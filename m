From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 6/6] cpufreq: intel_pstate: Avoid calculation for max/min
Date: Tue,  1 Sep 2015 04:54:01 -0700
Message-ID: <1441108441-3388-7-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1441108441-3388-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:23602 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755934AbbIALzT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Sep 2015 07:55:19 -0400
In-Reply-To: <1441108441-3388-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When requested from cpufreq to set policy, look into _pss and get
control values, instead of using max/min perf calculations. These
calculation misses next control state in boundary conditions.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 51 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f5aa1da..e2acd69 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -166,6 +166,8 @@ struct perf_limits {
 	int max_sysfs_pct;
 	int min_policy_pct;
 	int min_sysfs_pct;
+	int max_perf_ctl;
+	int min_perf_ctl;
 };
 
 static struct perf_limits limits = {
@@ -179,6 +181,8 @@ static struct perf_limits limits = {
 	.max_sysfs_pct = 100,
 	.min_policy_pct = 0,
 	.min_sysfs_pct = 0,
+	.max_perf_ctl = 0,
+	.min_perf_ctl = 0,
 };
 
 #if IS_ENABLED(CONFIG_ACPI)
@@ -941,12 +945,23 @@ static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
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
@@ -1229,6 +1244,12 @@ static unsigned int intel_pstate_get(unsigned int cpu_num)
 
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 {
+#if IS_ENABLED(CONFIG_ACPI)
+	struct cpudata *cpu;
+	int i;
+#endif
+	pr_debug("intel_pstate: %s max %u policy->max %u\n", __func__,
+		 policy->cpuinfo.max_freq, policy->max);
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
@@ -1241,6 +1262,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 		limits.max_perf_pct = 100;
 		limits.max_perf = int_tofp(1);
 		limits.no_turbo = 0;
+		limits.max_perf_ctl = 0;
+		limits.min_perf_ctl = 0;
 		return 0;
 	}
 
@@ -1254,6 +1277,24 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
 	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
 
+#if IS_ENABLED(CONFIG_ACPI)
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
+#endif
+
 	if (hwp_active)
 		intel_pstate_hwp_set();
 
-- 
2.4.3

