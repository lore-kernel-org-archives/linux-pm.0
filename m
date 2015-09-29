From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 6/6] cpufreq: intel_pstate: Avoid calculation for max/min
Date: Tue, 29 Sep 2015 15:54:08 -0700
Message-ID: <1443567248-27134-7-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1443567248-27134-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:65153 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbbI2Wyo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Sep 2015 18:54:44 -0400
In-Reply-To: <1443567248-27134-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When requested from cpufreq to set policy, look into _pss and get
control values, instead of using max/min perf calculations. These
calculation misses next control state in boundary conditions.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 50 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 869f074..49a16ff 100644
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
@@ -980,12 +984,23 @@ static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
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
@@ -1272,6 +1287,12 @@ static unsigned int intel_pstate_get(unsigned int cpu_num)
 
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
 
@@ -1284,6 +1305,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 		limits.max_perf_pct = 100;
 		limits.max_perf = int_tofp(1);
 		limits.no_turbo = 0;
+		limits.max_perf_ctl = 0;
+		limits.min_perf_ctl = 0;
 		return 0;
 	}
 
@@ -1304,6 +1327,23 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
 	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
 
+#if IS_ENABLED(CONFIG_ACPI)
+	cpu = all_cpu_data[policy->cpu];
+	for (i = 0; i < cpu->acpi_perf_data.state_count; i++) {
+		int control;
+
+		control = convert_to_native_pstate_format(cpu, i);
+		if (control * cpu->pstate.scaling == policy->max)
+			limits.max_perf_ctl = control;
+		if (control * cpu->pstate.scaling == policy->min)
+			limits.min_perf_ctl = control;
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
1.9.3

