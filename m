From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 6/6] cpufreq: intel_pstate: Avoid calculation for max/min
Date: Thu, 27 Aug 2015 18:34:26 -0700
Message-ID: <1440725666-3550-7-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1440725666-3550-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:17215 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbbH1Bfn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Aug 2015 21:35:43 -0400
In-Reply-To: <1440725666-3550-1-git-send-email-srinivas.pandruvada@linux.intel.com>
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
index 399c6e9..2af523f 100644
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
@@ -939,12 +943,23 @@ static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
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
@@ -1227,6 +1242,11 @@ static unsigned int intel_pstate_get(unsigned int cpu_num)
 
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 {
+	struct cpudata *cpu;
+	int i;
+
+	pr_debug("intel_pstate: %s max %u policy->max %u\n", __func__,
+		 policy->cpuinfo.max_freq, policy->max);
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
@@ -1239,6 +1259,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 		limits.max_perf_pct = 100;
 		limits.max_perf = int_tofp(1);
 		limits.no_turbo = 0;
+		limits.max_perf_ctl = 0;
+		limits.min_perf_ctl = 0;
 		return 0;
 	}
 
@@ -1252,6 +1274,22 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
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
+	pr_debug("intel_pstate: max %u policy_max %u perf_ctl [0x%x-0x%x]\n",
+		 policy->cpuinfo.max_freq, policy->max, limits.min_perf_ctl,
+		 limits.max_perf_ctl);
+
 	if (hwp_active)
 		intel_pstate_hwp_set();
 
-- 
2.4.3

