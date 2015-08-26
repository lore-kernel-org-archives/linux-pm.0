From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 5/5] cpufreq: intel_pstate: Avoid calculation for max/min
Date: Wed, 26 Aug 2015 13:32:41 -0700
Message-ID: <1440621161-2732-6-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1440621161-2732-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64578 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755964AbbHZUc5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 26 Aug 2015 16:32:57 -0400
In-Reply-To: <1440621161-2732-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When requested from cpufreq to set policy, look into _pss and get
control values, instead of using max/min perf calculations. These
calculation misses next control state in boundary conditions.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 48 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6eafb55..ead751e 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -164,6 +164,8 @@ struct perf_limits {
 	int max_sysfs_pct;
 	int min_policy_pct;
 	int min_sysfs_pct;
+	int max_perf_ctl;
+	int min_perf_ctl;
 };
 
 static struct perf_limits limits = {
@@ -177,6 +179,8 @@ static struct perf_limits limits = {
 	.max_sysfs_pct = 100,
 	.min_policy_pct = 0,
 	.min_sysfs_pct = 0,
+	.max_perf_ctl = 0,
+	.min_perf_ctl = 0,
 };
 
 #if IS_ENABLED(CONFIG_ACPI)
@@ -929,12 +933,23 @@ static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
 	 * policy, or by cpu specific default values determined through
 	 * experimentation.
 	 */
-	max_perf_adj = fp_toint(mul_fp(int_tofp(max_perf), limits.max_perf));
-	*max = clamp_t(int, max_perf_adj,
-			cpu->pstate.min_pstate, cpu->pstate.turbo_pstate);
+	if (limits.max_perf_ctl && limits.max_sysfs_pct >=
+						limits.max_policy_pct) {
+		*max = limits.max_perf_ctl;
+	} else {
+		max_perf_adj = fp_toint(mul_fp(int_tofp(max_perf),
+					limits.max_perf));
+		*max = clamp_t(int, max_perf_adj, cpu->pstate.min_pstate,
+			       cpu->pstate.turbo_pstate);
+	}
 
-	min_perf = fp_toint(mul_fp(int_tofp(max_perf), limits.min_perf));
-	*min = clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf);
+	if (limits.min_perf_ctl) {
+		*min = limits.min_perf_ctl;
+	} else {
+		min_perf = fp_toint(mul_fp(int_tofp(max_perf),
+				    limits.min_perf));
+		*min = clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf);
+	}
 }
 
 static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate, bool force)
@@ -1223,6 +1238,11 @@ static unsigned int intel_pstate_get(unsigned int cpu_num)
 
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 {
+	struct cpudata *cpu;
+	int i;
+
+	pr_debug("%s max %u policy->max %u\n", __func__,
+		 policy->cpuinfo.max_freq, policy->max);
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
@@ -1235,6 +1255,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 		limits.max_perf_pct = 100;
 		limits.max_perf = int_tofp(1);
 		limits.no_turbo = 0;
+		limits.max_perf_ctl = 0;
+		limits.min_perf_ctl = 0;
 		return 0;
 	}
 
@@ -1248,6 +1270,22 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
 	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
 
+	cpu = all_cpu_data[policy->cpu];
+	for (i = 0; i < cpu->acpi_perf_data.state_count; i++) {
+		if ((cpu->acpi_perf_data.states[i].control >> 8) *
+		    cpu->pstate.scaling == policy->max)
+			limits.max_perf_ctl =
+				cpu->acpi_perf_data.states[i].control >> 8;
+		if ((cpu->acpi_perf_data.states[i].control >> 8) *
+		    cpu->pstate.scaling == policy->min)
+			limits.min_perf_ctl =
+				cpu->acpi_perf_data.states[i].control >> 8;
+	}
+
+	pr_debug("max %u policy->max %u max_perf_ctl 0x%x min_perf_ctl 0x%x\n",
+		 policy->cpuinfo.max_freq, policy->max, limits.max_perf_ctl,
+		 limits.min_perf_ctl);
+
 	if (hwp_active)
 		intel_pstate_hwp_set();
 
-- 
1.9.3

