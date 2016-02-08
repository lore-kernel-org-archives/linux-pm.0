From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 06/13] cpufreq: Merge cpufreq_offline_prepare/finish routines
Date: Mon,  8 Feb 2016 17:09:20 +0530
Message-ID: <3ea57cc1f0f061470d2f7fadf95f4deff3e2c09a.1454931188.git.viresh.kumar@linaro.org>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454931188.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454931188.git.viresh.kumar@linaro.org>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
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
index 9c62bf35b9dc..863ac26c4ecf 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1361,9 +1361,10 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	return ret;
 }
 
-static void cpufreq_offline_prepare(unsigned int cpu)
+static void cpufreq_offline(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
+	int ret;
 
 	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
 
@@ -1374,7 +1375,7 @@ static void cpufreq_offline_prepare(unsigned int cpu)
 	}
 
 	if (has_target()) {
-		int ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
+		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret)
 			pr_err("%s: Failed to stop governor\n", __func__);
 	}
@@ -1397,34 +1398,23 @@ static void cpufreq_offline_prepare(unsigned int cpu)
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
@@ -1453,10 +1443,8 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
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
@@ -2304,11 +2292,7 @@ static int cpufreq_cpu_callback(struct notifier_block *nfb,
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
2.7.1.370.gb2aa7f8
