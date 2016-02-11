From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 2/6] cpufreq: Call __cpufreq_governor() with policy->rwsem held
Date: Thu, 11 Feb 2016 17:31:12 +0530
Message-ID: <3878a871586ae97a9f28fed77b4e5e790f19ee8a.1455191663.git.viresh.kumar@linaro.org>
References: <cover.1455191663.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455191663.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1455191663.git.viresh.kumar@linaro.org>
References: <cover.1455191663.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The cpufreq core code is not consistent with respect to invoking
__cpufreq_governor() under policy->rwsem.

Changing all code to always hold policy->rwsem around
__cpufreq_governor() invocations will allow us to remove
cpufreq_governor_lock, that is used today because we can't guarantee
that __cpufreq_governor() isn't executed in parallel.

We should also ensure that the lock is held across state changes to the
governors.

For example, while adding a CPU to the policy on cpu-online path, we
need to stop the governor, change policy->cpus, start the governor and
then refresh its limits. The complete sequence must be guaranteed to
execute without any concurrent races. And that can be achieved using
policy->rwsem around these use cases.

Also note that, after this patch cpufreq_driver->stop_cpu() and ->exit()
will get called while policy->rwsem is held, which wasn't the case
earlier. That shouldn't have any side effects though.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Juri Lelli <juri.lelli@arm.com>
Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/cpufreq.c | 49 +++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 863ac26c4ecf..51fb47cd38a0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1048,30 +1048,29 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 	if (cpumask_test_cpu(cpu, policy->cpus))
 		return 0;
 
+	down_write(&policy->rwsem);
 	if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret) {
 			pr_err("%s: Failed to stop governor\n", __func__);
-			return ret;
+			goto unlock;
 		}
 	}
 
-	down_write(&policy->rwsem);
 	cpumask_set_cpu(cpu, policy->cpus);
-	up_write(&policy->rwsem);
 
 	if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
 		if (!ret)
 			ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 
-		if (ret) {
+		if (ret)
 			pr_err("%s: Failed to start governor\n", __func__);
-			return ret;
-		}
 	}
 
-	return 0;
+unlock:
+	up_write(&policy->rwsem);
+	return ret;
 }
 
 static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
@@ -1374,13 +1373,13 @@ static void cpufreq_offline(unsigned int cpu)
 		return;
 	}
 
+	down_write(&policy->rwsem);
 	if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret)
 			pr_err("%s: Failed to stop governor\n", __func__);
 	}
 
-	down_write(&policy->rwsem);
 	cpumask_clear_cpu(cpu, policy->cpus);
 
 	if (policy_is_inactive(policy)) {
@@ -1393,7 +1392,6 @@ static void cpufreq_offline(unsigned int cpu)
 		/* Nominate new CPU */
 		policy->cpu = cpumask_any(policy->cpus);
 	}
-	up_write(&policy->rwsem);
 
 	/* Start governor again for active policy */
 	if (!policy_is_inactive(policy)) {
@@ -1406,7 +1404,7 @@ static void cpufreq_offline(unsigned int cpu)
 				pr_err("%s: Failed to start governor\n", __func__);
 		}
 
-		return;
+		goto unlock;
 	}
 
 	if (cpufreq_driver->stop_cpu)
@@ -1428,6 +1426,9 @@ static void cpufreq_offline(unsigned int cpu)
 		cpufreq_driver->exit(policy);
 		policy->freq_table = NULL;
 	}
+
+unlock:
+	up_write(&policy->rwsem);
 }
 
 /**
@@ -1624,6 +1625,7 @@ EXPORT_SYMBOL(cpufreq_generic_suspend);
 void cpufreq_suspend(void)
 {
 	struct cpufreq_policy *policy;
+	int ret;
 
 	if (!cpufreq_driver)
 		return;
@@ -1634,7 +1636,11 @@ void cpufreq_suspend(void)
 	pr_debug("%s: Suspending Governors\n", __func__);
 
 	for_each_active_policy(policy) {
-		if (__cpufreq_governor(policy, CPUFREQ_GOV_STOP))
+		down_write(&policy->rwsem);
+		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
+		up_write(&policy->rwsem);
+
+		if (ret)
 			pr_err("%s: Failed to stop governor for policy: %p\n",
 				__func__, policy);
 		else if (cpufreq_driver->suspend
@@ -1656,6 +1662,7 @@ void cpufreq_suspend(void)
 void cpufreq_resume(void)
 {
 	struct cpufreq_policy *policy;
+	int ret;
 
 	if (!cpufreq_driver)
 		return;
@@ -1668,13 +1675,20 @@ void cpufreq_resume(void)
 	pr_debug("%s: Resuming Governors\n", __func__);
 
 	for_each_active_policy(policy) {
-		if (cpufreq_driver->resume && cpufreq_driver->resume(policy))
+		if (cpufreq_driver->resume && cpufreq_driver->resume(policy)) {
 			pr_err("%s: Failed to resume driver: %p\n", __func__,
 				policy);
-		else if (__cpufreq_governor(policy, CPUFREQ_GOV_START)
-		    || __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS))
-			pr_err("%s: Failed to start governor for policy: %p\n",
-				__func__, policy);
+		} else {
+			down_write(&policy->rwsem);
+			ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
+			if (!ret)
+				__cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+			up_write(&policy->rwsem);
+
+			if (ret)
+				pr_err("%s: Failed to start governor for policy: %p\n",
+				       __func__, policy);
+		}
 	}
 
 	/*
@@ -2325,8 +2339,11 @@ static int cpufreq_boost_set_sw(int state)
 				       __func__);
 				break;
 			}
+
+			down_write(&policy->rwsem);
 			policy->user_policy.max = policy->max;
 			__cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+			up_write(&policy->rwsem);
 		}
 	}
 
-- 
2.7.1.370.gb2aa7f8
