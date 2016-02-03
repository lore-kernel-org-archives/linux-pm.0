From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 5/7] cpufreq: Merge cpufreq_offline_prepare/finish routines
Date: Wed,  3 Feb 2016 19:32:21 +0530
Message-ID: <5e84719b5475f79602e95af524e66e8927a85bc9.1454507872.git.viresh.kumar@linaro.org>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454507872.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454507872.git.viresh.kumar@linaro.org>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The offline routine was separated into two halves earlier by
'commit 1aee40ac9c86 ("cpufreq: Invoke __cpufreq_remove_dev_finish()
after releasing cpu_hotplug.lock");.

And the reasons cited were, race issues between accessing policy's sysfs
files and policy kobject's cleanup.

That race isn't valid anymore, as we don't remove the policy & its
kobject completely on hotplugs, but do that from ->remove() callback of
subsys framework.

These two routines can be merged back now.

This is a preparatory step for the next patch, that will enforce
policy->rwsem lock around __cpufreq_governor() routines STOP/EXIT
sequence.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5f7e24567e0e..dc43294e7b31 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1309,9 +1309,10 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	return ret;
 }
 
-static void cpufreq_offline_prepare(unsigned int cpu)
+static void cpufreq_offline(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
+	int ret;
 
 	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
 
@@ -1322,7 +1323,7 @@ static void cpufreq_offline_prepare(unsigned int cpu)
 	}
 
 	if (has_target()) {
-		int ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
+		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret)
 			pr_err("%s: Failed to stop governor\n", __func__);
 	}
@@ -1345,34 +1346,23 @@ static void cpufreq_offline_prepare(unsigned int cpu)
 	/* Start governor again for active policy */
 	if (!policy_is_inactive(policy)) {
 		if (has_target()) {
-			int ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
+			ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
 			if (!ret)
 				ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 
 			if (ret)
 				pr_err("%s: Failed to start governor\n", __func__);
 		}
-	} else if (cpufreq_driver->stop_cpu) {
-		cpufreq_driver->stop_cpu(policy);
-	}
-}
 
-static void cpufreq_offline_finish(unsigned int cpu)
-{
-	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
-
-	if (!policy) {
-		pr_debug("%s: No cpu_data found\n", __func__);
 		return;
 	}
 
-	/* Only proceed for inactive policies */
-	if (!policy_is_inactive(policy))
-		return;
+	if (cpufreq_driver->stop_cpu)
+		cpufreq_driver->stop_cpu(policy);
 
 	/* If cpu is last user of policy, free policy */
 	if (has_target()) {
-		int ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+		ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
 		if (ret)
 			pr_err("%s: Failed to exit governor\n", __func__);
 	}
@@ -1401,10 +1391,8 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	if (!policy)
 		return;
 
-	if (cpu_online(cpu)) {
-		cpufreq_offline_prepare(cpu);
-		cpufreq_offline_finish(cpu);
-	}
+	if (cpu_online(cpu))
+		cpufreq_offline(cpu);
 
 	cpumask_clear_cpu(cpu, policy->real_cpus);
 	remove_cpu_dev_symlink(policy, cpu);
@@ -2255,11 +2243,7 @@ static int cpufreq_cpu_callback(struct notifier_block *nfb,
 		break;
 
 	case CPU_DOWN_PREPARE:
-		cpufreq_offline_prepare(cpu);
-		break;
-
-	case CPU_POST_DEAD:
-		cpufreq_offline_finish(cpu);
+		cpufreq_offline(cpu);
 		break;
 
 	case CPU_DOWN_FAILED:
-- 
2.7.0.79.gdc08a19
