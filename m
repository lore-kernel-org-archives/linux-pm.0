From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3] cpufreq: intel_pstate: Avoid percentages in limits-related computations
Date: Tue, 14 Mar 2017 16:18:34 +0100
Message-ID: <3305006.UFgYgyKJxf@aspire.rjw.lan>
References: <2130954.RIJyMN1BRu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2130954.RIJyMN1BRu@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Currently, intel_pstate_update_perf_limits() first converts the
policy minimum and maximum limits into percentages of the maximum
turbo frequency (rounding up to an integer) and then converts these
percentages into fractions by using fixed-point arithmetic to divide
them by 100.

That introduces a rounding error unnecessarily, because the fractions
can be obtained by carrying out fixed-point divisions directly on the
input numbers.

Rework the computations in intel_pstate_hwp_set() to use fractions
instead of percentages (and drop redundant local variables from
there) and modify intel_pstate_update_perf_limits() to compute the
fractions directly and percentages out of them.

While at it, introduce percent_ext_fp() for converting percentages
to fractions (with extended number of fraction bits) and use it in
the computations.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   60 ++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -84,6 +84,11 @@ static inline u64 div_ext_fp(u64 x, u64
 	return div64_u64(x << EXT_FRAC_BITS, y);
 }
 
+static inline int32_t percent_ext_fp(int percent)
+{
+	return div_ext_fp(percent, 100);
+}
+
 /**
  * struct sample -	Store performance sample
  * @core_avg_perf:	Ratio of APERF/MPERF which is the actual average
@@ -850,7 +855,6 @@ static void intel_pstate_hwp_set(struct
 	u64 value, cap;
 
 	for_each_cpu(cpu, policy->cpus) {
-		int max_perf_pct, min_perf_pct;
 		struct cpudata *cpu_data = all_cpu_data[cpu];
 		s16 epp;
 
@@ -864,16 +868,14 @@ static void intel_pstate_hwp_set(struct
 		else
 			hw_max = HWP_HIGHEST_PERF(cap);
 
-		max_perf_pct = perf_limits->max_perf_pct;
-		min_perf_pct = perf_limits->min_perf_pct;
-		min = hw_max * min_perf_pct / 100;
+		min = fp_ext_toint(hw_max * perf_limits->min_perf);
 
 		rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
 
 		value &= ~HWP_MIN_PERF(~0L);
 		value |= HWP_MIN_PERF(min);
 
-		max = hw_max * max_perf_pct / 100;
+		max = fp_ext_toint(hw_max * perf_limits->max_perf);
 		value &= ~HWP_MAX_PERF(~0L);
 		value |= HWP_MAX_PERF(max);
 
@@ -1223,7 +1225,7 @@ static ssize_t store_max_perf_pct(struct
 				   limits->max_perf_pct);
 	limits->max_perf_pct = max(limits->min_perf_pct,
 				   limits->max_perf_pct);
-	limits->max_perf = div_ext_fp(limits->max_perf_pct, 100);
+	limits->max_perf = percent_ext_fp(limits->max_perf_pct);
 
 	intel_pstate_update_policies();
 
@@ -1260,7 +1262,7 @@ static ssize_t store_min_perf_pct(struct
 				   limits->min_perf_pct);
 	limits->min_perf_pct = min(limits->max_perf_pct,
 				   limits->min_perf_pct);
-	limits->min_perf = div_ext_fp(limits->min_perf_pct, 100);
+	limits->min_perf = percent_ext_fp(limits->min_perf_pct);
 
 	intel_pstate_update_policies();
 
@@ -2078,36 +2080,34 @@ static void intel_pstate_clear_update_ut
 static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
 					    struct perf_limits *limits)
 {
+	int32_t max_policy_perf, min_policy_perf;
 
-	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
-					      policy->cpuinfo.max_freq);
-	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0, 100);
+	max_policy_perf = div_ext_fp(policy->max, policy->cpuinfo.max_freq);
+	max_policy_perf = clamp_t(int32_t, max_policy_perf, 0, int_ext_tofp(1));
 	if (policy->max == policy->min) {
-		limits->min_policy_pct = limits->max_policy_pct;
+		min_policy_perf = max_policy_perf;
 	} else {
-		limits->min_policy_pct = DIV_ROUND_UP(policy->min * 100,
-						      policy->cpuinfo.max_freq);
-		limits->min_policy_pct = clamp_t(int, limits->min_policy_pct,
-						 0, 100);
-	}
-
-	/* Normalize user input to [min_policy_pct, max_policy_pct] */
-	limits->min_perf_pct = max(limits->min_policy_pct,
-				   limits->min_sysfs_pct);
-	limits->min_perf_pct = min(limits->max_policy_pct,
-				   limits->min_perf_pct);
-	limits->max_perf_pct = min(limits->max_policy_pct,
-				   limits->max_sysfs_pct);
-	limits->max_perf_pct = max(limits->min_policy_pct,
-				   limits->max_perf_pct);
+		min_policy_perf = div_ext_fp(policy->min,
+					     policy->cpuinfo.max_freq);
+		min_policy_perf = clamp_t(int32_t, min_policy_perf,
+					  0, max_policy_perf);
+	}
+
+	/* Normalize user input to [min_perf, max_perf] */
+	limits->min_perf = max(min_policy_perf,
+			       percent_ext_fp(limits->min_sysfs_pct));
+	limits->min_perf = min(limits->min_perf, max_policy_perf);
+	limits->max_perf = min(max_policy_perf,
+			       percent_ext_fp(limits->max_sysfs_pct));
+	limits->max_perf = max(min_policy_perf, limits->max_perf);
 
-	/* Make sure min_perf_pct <= max_perf_pct */
-	limits->min_perf_pct = min(limits->max_perf_pct, limits->min_perf_pct);
+	/* Make sure min_perf <= max_perf */
+	limits->min_perf = min(limits->min_perf, limits->max_perf);
 
-	limits->min_perf = div_ext_fp(limits->min_perf_pct, 100);
-	limits->max_perf = div_ext_fp(limits->max_perf_pct, 100);
 	limits->max_perf = round_up(limits->max_perf, EXT_FRAC_BITS);
 	limits->min_perf = round_up(limits->min_perf, EXT_FRAC_BITS);
+	limits->max_perf_pct = fp_ext_toint(limits->max_perf * 100);
+	limits->min_perf_pct = fp_ext_toint(limits->min_perf * 100);
 
 	pr_debug("cpu:%d max_perf_pct:%d min_perf_pct:%d\n", policy->cpu,
 		 limits->max_perf_pct, limits->min_perf_pct);
