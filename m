From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpufreq: governor: CPUFREQ_GOV_STOP never fails
Date: Thu, 12 May 2016 15:14:12 +0200
Message-ID: <2034165.RqMO62khMb@vostro.rjw.lan>
References: <4540082.RMPf3KxPDh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4540082.RMPf3KxPDh@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

None of the cpufreq governors currently in the tree will ever fail
an invocation of the ->governor() callback with the event argument
equal to CPUFREQ_GOV_STOP (unless invoked with incorrect arguments
which doesn't matter anyway) and it is rather difficult to imagine
a valid reason for such a failure.

Accordingly, rearrange the code in the core to make it clear that
this call never fails.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -83,6 +83,11 @@ static inline void cpufreq_exit_governor
 	(void)cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
 }
 
+static inline void cpufreq_stop_governor(struct cpufreq_policy *policy)
+{
+	(void)cpufreq_governor(policy, CPUFREQ_GOV_STOP);
+}
+
 /**
  * Two notifier lists: the "policy" list is involved in the
  * validation process for a new CPU frequency policy; the
@@ -1026,13 +1031,8 @@ static int cpufreq_add_policy_cpu(struct
 		return 0;
 
 	down_write(&policy->rwsem);
-	if (has_target()) {
-		ret = cpufreq_governor(policy, CPUFREQ_GOV_STOP);
-		if (ret) {
-			pr_err("%s: Failed to stop governor\n", __func__);
-			goto unlock;
-		}
-	}
+	if (has_target())
+		cpufreq_stop_governor(policy);
 
 	cpumask_set_cpu(cpu, policy->cpus);
 
@@ -1041,8 +1041,6 @@ static int cpufreq_add_policy_cpu(struct
 		if (ret)
 			pr_err("%s: Failed to start governor\n", __func__);
 	}
-
-unlock:
 	up_write(&policy->rwsem);
 	return ret;
 }
@@ -1354,11 +1352,8 @@ static void cpufreq_offline(unsigned int
 	}
 
 	down_write(&policy->rwsem);
-	if (has_target()) {
-		ret = cpufreq_governor(policy, CPUFREQ_GOV_STOP);
-		if (ret)
-			pr_err("%s: Failed to stop governor\n", __func__);
-	}
+	if (has_target())
+		cpufreq_stop_governor(policy);
 
 	cpumask_clear_cpu(cpu, policy->cpus);
 
@@ -1622,7 +1617,6 @@ EXPORT_SYMBOL(cpufreq_generic_suspend);
 void cpufreq_suspend(void)
 {
 	struct cpufreq_policy *policy;
-	int ret;
 
 	if (!cpufreq_driver)
 		return;
@@ -1635,14 +1629,8 @@ void cpufreq_suspend(void)
 	for_each_active_policy(policy) {
 		if (has_target()) {
 			down_write(&policy->rwsem);
-			ret = cpufreq_governor(policy, CPUFREQ_GOV_STOP);
+			cpufreq_stop_governor(policy);
 			up_write(&policy->rwsem);
-
-			if (ret) {
-				pr_err("%s: Failed to stop governor for policy: %p\n",
-					__func__, policy);
-				continue;
-			}
 		}
 
 		if (cpufreq_driver->suspend && cpufreq_driver->suspend(policy))
@@ -2216,13 +2204,7 @@ static int cpufreq_set_policy(struct cpu
 	old_gov = policy->governor;
 	/* end old governor */
 	if (old_gov) {
-		ret = cpufreq_governor(policy, CPUFREQ_GOV_STOP);
-		if (ret) {
-			/* This can happen due to race with other operations */
-			pr_debug("%s: Failed to Stop Governor: %s (%d)\n",
-				 __func__, old_gov->name, ret);
-			return ret;
-		}
+		cpufreq_stop_governor(policy);
 		cpufreq_exit_governor(policy);
 	}
 
