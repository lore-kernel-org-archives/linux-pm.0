From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] cpufreq: intel_pstate: increase precision of performance limits
Date: Mon, 21 Nov 2016 16:33:20 -0800
Message-ID: <1479774800-126589-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1479774800-126589-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4835 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753695AbcKVAdZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Nov 2016 19:33:25 -0500
In-Reply-To: <1479774800-126589-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Even with round up of limits->min_perf and limits->max_perf, in some
cases resultant performance is 100 MHz less than the desired.

For example when the maximum frequency is 3.50 GHz, setting
scaling_min_frequency to 2.3 GHz always results in 2.2 GHz minimum.

Currently the fixed floating point operation uses 8 bit precision for
calculating limits->min_perf and limits->max_perf. For some operations
in this driver the 14 bit precision is used. Using the 14 bit precision
also for calculating limits->min_perf and limits->max_perf, addresses
this issue.

Introduced fp_ext_toint() equivalent to fp_toint() and int_ext_tofp()
equivalent to int_tofp() with 14 bit precision.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2f27812..72e8bbc 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -52,6 +52,8 @@
 
 #define EXT_BITS 6
 #define EXT_FRAC_BITS (EXT_BITS + FRAC_BITS)
+#define fp_ext_toint(X) ((X) >> EXT_FRAC_BITS)
+#define int_ext_tofp(X) ((int64_t)(X) << EXT_FRAC_BITS)
 
 static inline int32_t mul_fp(int32_t x, int32_t y)
 {
@@ -345,9 +347,9 @@ static struct perf_limits performance_limits = {
 	.no_turbo = 0,
 	.turbo_disabled = 0,
 	.max_perf_pct = 100,
-	.max_perf = int_tofp(1),
+	.max_perf = int_ext_tofp(1),
 	.min_perf_pct = 100,
-	.min_perf = int_tofp(1),
+	.min_perf = int_ext_tofp(1),
 	.max_policy_pct = 100,
 	.max_sysfs_pct = 100,
 	.min_policy_pct = 0,
@@ -358,7 +360,7 @@ static struct perf_limits powersave_limits = {
 	.no_turbo = 0,
 	.turbo_disabled = 0,
 	.max_perf_pct = 100,
-	.max_perf = int_tofp(1),
+	.max_perf = int_ext_tofp(1),
 	.min_perf_pct = 0,
 	.min_perf = 0,
 	.max_policy_pct = 100,
@@ -770,7 +772,7 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 				   limits->max_perf_pct);
 	limits->max_perf_pct = max(limits->min_perf_pct,
 				   limits->max_perf_pct);
-	limits->max_perf = div_fp(limits->max_perf_pct, 100);
+	limits->max_perf = div_ext_fp(limits->max_perf_pct, 100);
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
@@ -798,7 +800,7 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 				   limits->min_perf_pct);
 	limits->min_perf_pct = min(limits->max_perf_pct,
 				   limits->min_perf_pct);
-	limits->min_perf = div_fp(limits->min_perf_pct, 100);
+	limits->min_perf = div_ext_fp(limits->min_perf_pct, 100);
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
@@ -1183,11 +1185,11 @@ static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
 	 * policy, or by cpu specific default values determined through
 	 * experimentation.
 	 */
-	max_perf_adj = fp_toint(max_perf * perf_limits->max_perf);
+	max_perf_adj = fp_ext_toint(max_perf * perf_limits->max_perf);
 	*max = clamp_t(int, max_perf_adj,
 			cpu->pstate.min_pstate, cpu->pstate.turbo_pstate);
 
-	min_perf = fp_toint(max_perf * perf_limits->min_perf);
+	min_perf = fp_ext_toint(max_perf * perf_limits->min_perf);
 	*min = clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf);
 }
 
@@ -1547,9 +1549,9 @@ static void intel_pstate_set_performance_limits(struct perf_limits *limits)
 	limits->no_turbo = 0;
 	limits->turbo_disabled = 0;
 	limits->max_perf_pct = 100;
-	limits->max_perf = int_tofp(1);
+	limits->max_perf = int_ext_tofp(1);
 	limits->min_perf_pct = 100;
-	limits->min_perf = int_tofp(1);
+	limits->min_perf = int_ext_tofp(1);
 	limits->max_policy_pct = 100;
 	limits->max_sysfs_pct = 100;
 	limits->min_policy_pct = 0;
@@ -1588,10 +1590,10 @@ static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
 	/* Make sure min_perf_pct <= max_perf_pct */
 	limits->min_perf_pct = min(limits->max_perf_pct, limits->min_perf_pct);
 
-	limits->min_perf = div_fp(limits->min_perf_pct, 100);
-	limits->max_perf = div_fp(limits->max_perf_pct, 100);
-	limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
-	limits->min_perf = round_up(limits->min_perf, FRAC_BITS);
+	limits->min_perf = div_ext_fp(limits->min_perf_pct, 100);
+	limits->max_perf = div_ext_fp(limits->max_perf_pct, 100);
+	limits->max_perf = round_up(limits->max_perf, EXT_FRAC_BITS);
+	limits->min_perf = round_up(limits->min_perf, EXT_FRAC_BITS);
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
-- 
2.7.4

