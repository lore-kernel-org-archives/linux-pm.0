From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 6/7] cpufreq: Call __cpufreq_governor() with policy->rwsem held
Date: Wed,  3 Feb 2016 19:32:22 +0530
Message-ID: <c7d9903e34dc658025fb20f90c610fa7cc0c8e5d.1454507872.git.viresh.kumar@linaro.org>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36078 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756009AbcBCOCt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 09:02:49 -0500
Received: by mail-pa0-f51.google.com with SMTP id yy13so14027270pab.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2016 06:02:49 -0800 (PST)
In-Reply-To: <cover.1454507872.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454507872.git.viresh.kumar@linaro.org>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

This isn't followed properly by all parts of the core code, some follow
it, whereas others don't.

Enforcing it will also enable us to remove cpufreq_governor_lock, that
is used today because we can't guarantee that __cpufreq_governor() isn't
executed in parallel.

We should also ensure that the lock is held across state changes to the
governors.

For example, while adding a CPU to the policy on cpu-online path, we
need to stop the governor, change policy->cpus, start the governor and
then refresh its limits. The complete sequence must be guaranteed to
execute without any concurrent races. And that can be achieved using
policy->rwsem around these use cases.

Also note that cpufreq_driver->stop_cpu() and ->exit() can get called
while policy->rwsem is held. That shouldn't have any side effects
though.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index dc43294e7b31..4fc3889ca7c9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -996,30 +996,29 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
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
@@ -1322,13 +1321,13 @@ static void cpufreq_offline(unsigned int cpu)
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
@@ -1341,7 +1340,6 @@ static void cpufreq_offline(unsigned int cpu)
 		/* Nominate new CPU */
 		policy->cpu = cpumask_any(policy->cpus);
 	}
-	up_write(&policy->rwsem);
 
 	/* Start governor again for active policy */
 	if (!policy_is_inactive(policy)) {
@@ -1376,6 +1374,7 @@ static void cpufreq_offline(unsigned int cpu)
 		cpufreq_driver->exit(policy);
 		policy->freq_table = NULL;
 	}
+	up_write(&policy->rwsem);
 }
 
 /**
@@ -1572,6 +1571,7 @@ EXPORT_SYMBOL(cpufreq_generic_suspend);
 void cpufreq_suspend(void)
 {
 	struct cpufreq_policy *policy;
+	int ret;
 
 	if (!cpufreq_driver)
 		return;
@@ -1582,7 +1582,11 @@ void cpufreq_suspend(void)
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
@@ -1604,6 +1608,7 @@ void cpufreq_suspend(void)
 void cpufreq_resume(void)
 {
 	struct cpufreq_policy *policy;
+	int ret;
 
 	if (!cpufreq_driver)
 		return;
@@ -1616,13 +1621,20 @@ void cpufreq_resume(void)
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
@@ -2276,8 +2288,11 @@ static int cpufreq_boost_set_sw(int state)
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
2.7.0.79.gdc08a19

