From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 01/16] cpufreq: intel_pstate: Eliminate struct perf_limits
Date: Tue, 28 Mar 2017 00:03:20 +0200
Message-ID: <3454289.NiEcekIoAl@aspire.rjw.lan>
References: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After recent changes the purpose of struct perf_limits is not
particularly clear any more and the code may be made somewhat
easier to follow by eliminating it, so go for that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   59 +++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 36 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -186,20 +186,6 @@ struct _pid {
 };
 
 /**
- * struct perf_limits - Store user and policy limits
- * @max_perf:		This is a scaled value between 0 to 255 for max_perf_pct
- *			This value is used to limit max pstate
- * @min_perf:		This is a scaled value between 0 to 255 for min_perf_pct
- *			This value is used to limit min pstate
- *
- * Storage for policy defined limits.
- */
-struct perf_limits {
-	int32_t max_perf;
-	int32_t min_perf;
-};
-
-/**
  * struct global_params - Global parameters, mostly tunable via sysfs.
  * @no_turbo:		Whether or not to use turbo P-states.
  * @turbo_disabled:	Whethet or not turbo P-states are available at all,
@@ -236,7 +222,10 @@ struct global_params {
  * @prev_cummulative_iowait: IO Wait time difference from last and
  *			current sample
  * @sample:		Storage for storing last Sample data
- * @perf_limits:	Capacity limits unique to this CPU
+ * @min_perf:		Minimum capacity limit as a fraction of the maximum
+ *			turbo P-state capacity.
+ * @max_perf:		Maximum capacity limit as a fraction of the maximum
+ *			turbo P-state capacity.
  * @acpi_perf_data:	Stores ACPI perf information read from _PSS
  * @valid_pss_table:	Set to true for valid ACPI _PSS entries found
  * @epp_powersave:	Last saved HWP energy performance preference
@@ -268,7 +257,8 @@ struct cpudata {
 	u64	prev_tsc;
 	u64	prev_cummulative_iowait;
 	struct sample sample;
-	struct perf_limits perf_limits;
+	int32_t	min_perf;
+	int32_t	max_perf;
 #ifdef CONFIG_ACPI
 	struct acpi_processor_performance acpi_perf_data;
 	bool valid_pss_table;
@@ -833,7 +823,6 @@ static void intel_pstate_hwp_set(struct
 
 	for_each_cpu(cpu, policy->cpus) {
 		struct cpudata *cpu_data = all_cpu_data[cpu];
-		struct perf_limits *perf_limits = &cpu_data->perf_limits;
 		s16 epp;
 
 		rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
@@ -843,11 +832,11 @@ static void intel_pstate_hwp_set(struct
 		else
 			hw_max = HWP_HIGHEST_PERF(cap);
 
-		max = fp_ext_toint(hw_max * perf_limits->max_perf);
+		max = fp_ext_toint(hw_max * cpu_data->max_perf);
 		if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE)
 			min = max;
 		else
-			min = fp_ext_toint(hw_max * perf_limits->min_perf);
+			min = fp_ext_toint(hw_max * cpu_data->min_perf);
 
 		rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
 
@@ -1637,7 +1626,6 @@ static void intel_pstate_get_min_max(str
 	int max_perf = cpu->pstate.turbo_pstate;
 	int max_perf_adj;
 	int min_perf;
-	struct perf_limits *perf_limits = &cpu->perf_limits;
 
 	if (global.no_turbo || global.turbo_disabled)
 		max_perf = cpu->pstate.max_pstate;
@@ -1647,11 +1635,11 @@ static void intel_pstate_get_min_max(str
 	 * policy, or by cpu specific default values determined through
 	 * experimentation.
 	 */
-	max_perf_adj = fp_ext_toint(max_perf * perf_limits->max_perf);
+	max_perf_adj = fp_ext_toint(max_perf * cpu->max_perf);
 	*max = clamp_t(int, max_perf_adj,
 			cpu->pstate.min_pstate, cpu->pstate.turbo_pstate);
 
-	min_perf = fp_ext_toint(max_perf * perf_limits->min_perf);
+	min_perf = fp_ext_toint(max_perf * cpu->min_perf);
 	*min = clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf);
 }
 
@@ -2030,7 +2018,6 @@ static int intel_pstate_get_max_freq(str
 static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
 					    struct cpudata *cpu)
 {
-	struct perf_limits *limits = &cpu->perf_limits;
 	int max_freq = intel_pstate_get_max_freq(cpu);
 	int32_t max_policy_perf, min_policy_perf;
 
@@ -2046,8 +2033,8 @@ static void intel_pstate_update_perf_lim
 
 	/* Normalize user input to [min_perf, max_perf] */
 	if (per_cpu_limits) {
-		limits->min_perf = min_policy_perf;
-		limits->max_perf = max_policy_perf;
+		cpu->min_perf = min_policy_perf;
+		cpu->max_perf = max_policy_perf;
 	} else {
 		int32_t global_min, global_max;
 
@@ -2064,21 +2051,21 @@ static void intel_pstate_update_perf_lim
 		}
 		global_min = clamp_t(int32_t, global_min, 0, global_max);
 
-		limits->min_perf = max(min_policy_perf, global_min);
-		limits->min_perf = min(limits->min_perf, max_policy_perf);
-		limits->max_perf = min(max_policy_perf, global_max);
-		limits->max_perf = max(min_policy_perf, limits->max_perf);
+		cpu->min_perf = max(min_policy_perf, global_min);
+		cpu->min_perf = min(cpu->min_perf, max_policy_perf);
+		cpu->max_perf = min(max_policy_perf, global_max);
+		cpu->max_perf = max(min_policy_perf, cpu->max_perf);
 
 		/* Make sure min_perf <= max_perf */
-		limits->min_perf = min(limits->min_perf, limits->max_perf);
+		cpu->min_perf = min(cpu->min_perf, cpu->max_perf);
 	}
 
-	limits->max_perf = round_up(limits->max_perf, EXT_FRAC_BITS);
-	limits->min_perf = round_up(limits->min_perf, EXT_FRAC_BITS);
+	cpu->max_perf = round_up(cpu->max_perf, EXT_FRAC_BITS);
+	cpu->min_perf = round_up(cpu->min_perf, EXT_FRAC_BITS);
 
 	pr_debug("cpu:%d max_perf_pct:%d min_perf_pct:%d\n", policy->cpu,
-		 fp_ext_toint(limits->max_perf * 100),
-		 fp_ext_toint(limits->min_perf * 100));
+		 fp_ext_toint(cpu->max_perf * 100),
+		 fp_ext_toint(cpu->min_perf * 100));
 }
 
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
@@ -2181,8 +2168,8 @@ static int __intel_pstate_cpu_init(struc
 
 	cpu = all_cpu_data[policy->cpu];
 
-	cpu->perf_limits.max_perf = int_ext_tofp(1);
-	cpu->perf_limits.min_perf = 0;
+	cpu->max_perf = int_ext_tofp(1);
+	cpu->min_perf = 0;
 
 	policy->min = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	policy->max = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
