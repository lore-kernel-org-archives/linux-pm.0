From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH] cpufreq: intel_pstate: Synchronize sysfs limits
Date: Fri, 28 Oct 2016 10:46:02 -0700
Message-ID: <1477676762-20416-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:65449 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756354AbcJ1RqF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Oct 2016 13:46:05 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
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
Intel P-State sysfs and try to change via cpufreq sysfs, then they can
only set limit which constrains more. For example in the above example,
user can't set any frequency above 2240000 from cpufreq sysfs, they can
set less than that as long as this is more than scaling_min_freq.
To set above, the max limit need to changed via Intel P-State sysfs,
which created this constraint.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 0837175..1bfc1b3 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -751,6 +751,18 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
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
@@ -776,6 +788,9 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 
 	if (hwp_active)
 		intel_pstate_hwp_set_online_cpus();
+
+	update_cpufreq_policies();
+
 	return count;
 }
 
@@ -804,6 +819,9 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 
 	if (hwp_active)
 		intel_pstate_hwp_set_online_cpus();
+
+	update_cpufreq_policies();
+
 	return count;
 }
 
@@ -1745,6 +1763,28 @@ static struct cpufreq_driver intel_pstate_driver = {
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
@@ -1959,6 +1999,9 @@ static int __init intel_pstate_init(void)
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

