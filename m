From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Synchronize sysfs limits
Date: Fri, 11 Nov 2016 16:11:35 -0800
Message-ID: <1478909495-57026-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53077 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934500AbcKLALj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Nov 2016 19:11:39 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When user sets some limits using Intel P-State sysfs, they are not
reflected in the cpufreq policy scaling_max_freq and scaling_min_freq.
This change updates the cpufreq policy of each CPU, when user sets
limits via Intel P-State sysfs.

For example:
root@stn1]# cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
100
root@stn1]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
2800000

Now limit the max performance
root@stn1]# echo 80 > /sys/devices/system/cpu/intel_pstate/max_perf_pct
This change now is also changed the scaling_max_freq
root@stn1]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
2240000

But there is a side effect of this change for the users who use both
methods to limit interchangeably. For example if user sets limit via
Intel P-State sysfs to a lower maximum value and then sets a higher
maximum value via cpufreq sysfs, then the cpufreq display will show a
lower maximum value set by the Intel P-State sysfs. But there is no
change in the effective P-State used, as the driver will always use
the most constrained limit.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8f683e2..d8315e3 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -805,6 +805,18 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
 	return count;
 }
 
+static void update_cpufreq_policies(void)
+{
+	int cpu;
+
+	get_online_cpus();
+	for_each_online_cpu(cpu) {
+		if (all_cpu_data[cpu])
+			cpufreq_update_policy(cpu);
+	}
+	put_online_cpus();
+}
+
 static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 				  const char *buf, size_t count)
 {
@@ -830,6 +842,9 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 
 	if (hwp_active)
 		intel_pstate_hwp_set_online_cpus();
+
+	update_cpufreq_policies();
+
 	return count;
 }
 
@@ -858,6 +873,9 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 
 	if (hwp_active)
 		intel_pstate_hwp_set_online_cpus();
+
+	update_cpufreq_policies();
+
 	return count;
 }
 
@@ -1802,6 +1820,28 @@ static struct cpufreq_driver intel_pstate_driver = {
 	.name		= "intel_pstate",
 };
 
+static int cpufreq_intel_pstate_notifier(struct notifier_block *nb,
+					 unsigned long event, void *data)
+{
+	struct cpufreq_policy *policy = data;
+	int max_freq, min_freq;
+
+	/* When per-CPU limits are used, sysfs limits can't be set */
+	if (per_cpu_limits)
+		return NOTIFY_OK;
+
+	max_freq = policy->cpuinfo.max_freq * limits->max_sysfs_pct / 100;
+	min_freq = policy->cpuinfo.max_freq * limits->min_sysfs_pct / 100;
+
+	cpufreq_verify_within_limits(policy, min_freq, max_freq);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block intel_pstate_cpufreq_notifier_block = {
+	.notifier_call = cpufreq_intel_pstate_notifier,
+};
+
 static int no_load __initdata;
 static int no_hwp __initdata;
 static int hwp_only __initdata;
@@ -2032,6 +2072,9 @@ static int __init intel_pstate_init(void)
 	if (hwp_active)
 		pr_info("HWP enabled\n");
 
+	cpufreq_register_notifier(&intel_pstate_cpufreq_notifier_block,
+				  CPUFREQ_POLICY_NOTIFIER);
+
 	return rc;
 out:
 	get_online_cpus();
-- 
2.7.4

