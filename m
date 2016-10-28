From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: protect limits variable
Date: Fri, 28 Oct 2016 10:44:52 -0700
Message-ID: <1477676692-20262-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59631 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756354AbcJ1RpH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Oct 2016 13:45:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The limits variable gets modified from intel_pstate sysfs and also gets
modified from cpufreq sysfs. So protect with a mutex to keep data
integrity, when they are getting modified from multiple threads.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8e7390b..0837175 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -373,6 +373,8 @@ static struct perf_limits *limits = &performance_limits;
 static struct perf_limits *limits = &powersave_limits;
 #endif
 
+static DEFINE_MUTEX(intel_pstate_limits_lock);
+
 #ifdef CONFIG_ACPI
 
 static bool intel_pstate_get_ppc_enable_status(void)
@@ -730,14 +732,19 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
 	if (ret != 1)
 		return -EINVAL;
 
+	mutex_lock(&intel_pstate_limits_lock);
+
 	update_turbo_state();
 	if (limits->turbo_disabled) {
 		pr_warn("Turbo disabled by BIOS or unavailable on processor\n");
+		mutex_unlock(&intel_pstate_limits_lock);
 		return -EPERM;
 	}
 
 	limits->no_turbo = clamp_t(int, input, 0, 1);
 
+	mutex_unlock(&intel_pstate_limits_lock);
+
 	if (hwp_active)
 		intel_pstate_hwp_set_online_cpus();
 
@@ -754,6 +761,8 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 	if (ret != 1)
 		return -EINVAL;
 
+	mutex_lock(&intel_pstate_limits_lock);
+
 	limits->max_sysfs_pct = clamp_t(int, input, 0 , 100);
 	limits->max_perf_pct = min(limits->max_policy_pct,
 				   limits->max_sysfs_pct);
@@ -763,6 +772,8 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 				   limits->max_perf_pct);
 	limits->max_perf = div_fp(limits->max_perf_pct, 100);
 
+	mutex_unlock(&intel_pstate_limits_lock);
+
 	if (hwp_active)
 		intel_pstate_hwp_set_online_cpus();
 	return count;
@@ -778,6 +789,8 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 	if (ret != 1)
 		return -EINVAL;
 
+	mutex_lock(&intel_pstate_limits_lock);
+
 	limits->min_sysfs_pct = clamp_t(int, input, 0 , 100);
 	limits->min_perf_pct = max(limits->min_policy_pct,
 				   limits->min_sysfs_pct);
@@ -787,6 +800,8 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 				   limits->min_perf_pct);
 	limits->min_perf = div_fp(limits->min_perf_pct, 100);
 
+	mutex_unlock(&intel_pstate_limits_lock);
+
 	if (hwp_active)
 		intel_pstate_hwp_set_online_cpus();
 	return count;
@@ -1528,6 +1543,7 @@ static void intel_pstate_clear_update_util_hook(unsigned int cpu)
 
 static void intel_pstate_set_performance_limits(struct perf_limits *limits)
 {
+	mutex_lock(&intel_pstate_limits_lock);
 	limits->no_turbo = 0;
 	limits->turbo_disabled = 0;
 	limits->max_perf_pct = 100;
@@ -1538,11 +1554,15 @@ static void intel_pstate_set_performance_limits(struct perf_limits *limits)
 	limits->max_sysfs_pct = 100;
 	limits->min_policy_pct = 0;
 	limits->min_sysfs_pct = 0;
+	mutex_unlock(&intel_pstate_limits_lock);
 }
 
 static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
 					    struct perf_limits *limits)
 {
+
+	mutex_lock(&intel_pstate_limits_lock);
+
 	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
 					      policy->cpuinfo.max_freq);
 	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0, 100);
@@ -1572,6 +1592,8 @@ static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
 	limits->max_perf = div_fp(limits->max_perf_pct, 100);
 	limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
 
+	mutex_unlock(&intel_pstate_limits_lock);
+
 	pr_debug("cpu:%d max_perf_pct:%d min_perf_pct:%d\n", policy->cpu,
 		 limits->max_perf_pct, limits->min_perf_pct);
 }
-- 
2.7.4

