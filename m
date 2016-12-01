From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] cpufreq: intel_pstate: Lock HWP requests
Date: Thu,  1 Dec 2016 15:39:08 -0800
Message-ID: <1480635549-43518-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1480635549-43518-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:36786 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756202AbcLAXjQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Dec 2016 18:39:16 -0500
In-Reply-To: <1480635549-43518-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

To avoid race condition from multiple threads, increase the scope of
intel_pstate_limits_lock to include HWP requests also.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4fbe366f..cdc5e7f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1051,11 +1051,11 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
 
 	limits->no_turbo = clamp_t(int, input, 0, 1);
 
-	mutex_unlock(&intel_pstate_limits_lock);
-
 	if (hwp_active)
 		intel_pstate_hwp_set_online_cpus();
 
+	mutex_unlock(&intel_pstate_limits_lock);
+
 	return count;
 }
 
@@ -1080,10 +1080,11 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 				   limits->max_perf_pct);
 	limits->max_perf = div_ext_fp(limits->max_perf_pct, 100);
 
-	mutex_unlock(&intel_pstate_limits_lock);
-
 	if (hwp_active)
 		intel_pstate_hwp_set_online_cpus();
+
+	mutex_unlock(&intel_pstate_limits_lock);
+
 	return count;
 }
 
@@ -1108,10 +1109,11 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 				   limits->min_perf_pct);
 	limits->min_perf = div_ext_fp(limits->min_perf_pct, 100);
 
-	mutex_unlock(&intel_pstate_limits_lock);
-
 	if (hwp_active)
 		intel_pstate_hwp_set_online_cpus();
+
+	mutex_unlock(&intel_pstate_limits_lock);
+
 	return count;
 }
 
@@ -1865,7 +1867,6 @@ static void intel_pstate_clear_update_util_hook(unsigned int cpu)
 
 static void intel_pstate_set_performance_limits(struct perf_limits *limits)
 {
-	mutex_lock(&intel_pstate_limits_lock);
 	limits->no_turbo = 0;
 	limits->turbo_disabled = 0;
 	limits->max_perf_pct = 100;
@@ -1876,15 +1877,12 @@ static void intel_pstate_set_performance_limits(struct perf_limits *limits)
 	limits->max_sysfs_pct = 100;
 	limits->min_policy_pct = 0;
 	limits->min_sysfs_pct = 0;
-	mutex_unlock(&intel_pstate_limits_lock);
 }
 
 static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
 					    struct perf_limits *limits)
 {
 
-	mutex_lock(&intel_pstate_limits_lock);
-
 	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
 					      policy->cpuinfo.max_freq);
 	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0, 100);
@@ -1915,8 +1913,6 @@ static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
 	limits->max_perf = round_up(limits->max_perf, EXT_FRAC_BITS);
 	limits->min_perf = round_up(limits->min_perf, EXT_FRAC_BITS);
 
-	mutex_unlock(&intel_pstate_limits_lock);
-
 	pr_debug("cpu:%d max_perf_pct:%d min_perf_pct:%d\n", policy->cpu,
 		 limits->max_perf_pct, limits->min_perf_pct);
 }
@@ -1945,6 +1941,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	if (per_cpu_limits)
 		perf_limits = cpu->perf_limits;
 
+	mutex_lock(&intel_pstate_limits_lock);
+
 	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		if (!perf_limits) {
 			limits = &performance_limits;
@@ -1979,6 +1977,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 
 	intel_pstate_hwp_set_policy(policy);
 
+	mutex_unlock(&intel_pstate_limits_lock);
+
 	return 0;
 }
 
-- 
2.7.4

