From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] cpufreq: intel_pstate: Simplify coordination of P-state limits
Date: Tue, 14 Mar 2017 16:19:28 +0100
Message-ID: <2208183.xLTyOuGuWA@aspire.rjw.lan>
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

The coordination of P-state limits used by intel_pstate in the active
mode (ie. by default) is convoluted, hard to explain and confusing.

Fix that by modifying intel_pstate to use one set of per-policy
(ie. set via the cpufreq policy interface) limits for each logical
CPU and one set of global P-state limits (min and max) with the
following rules:

 (1) All CPUs are affected by the global limits (that is, none of
     them can run faster than the global max and none of them can
     run slower than the global min).

 (2) Each individual CPU is affected by its own per-policy limits
     (that is, it cannot run faster than its own per-policy max and
     it cannot run slower than its own per-policy min).

 (3) The global and per-policy limits can be set independently.

regardless of the current operation mode of the driver.

That simplifies the code in quite a few places quite a bit too.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |  230 ++++++++++++-----------------------------
 1 file changed, 72 insertions(+), 158 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -187,44 +187,41 @@ struct _pid {
 
 /**
  * struct perf_limits - Store user and policy limits
- * @no_turbo:		User requested turbo state from intel_pstate sysfs
- * @turbo_disabled:	Platform turbo status either from msr
- *			MSR_IA32_MISC_ENABLE or when maximum available pstate
- *			matches the maximum turbo pstate
- * @max_perf_pct:	Effective maximum performance limit in percentage, this
- *			is minimum of either limits enforced by cpufreq policy
- *			or limits from user set limits via intel_pstate sysfs
- * @min_perf_pct:	Effective minimum performance limit in percentage, this
- *			is maximum of either limits enforced by cpufreq policy
- *			or limits from user set limits via intel_pstate sysfs
  * @max_perf:		This is a scaled value between 0 to 255 for max_perf_pct
  *			This value is used to limit max pstate
  * @min_perf:		This is a scaled value between 0 to 255 for min_perf_pct
  *			This value is used to limit min pstate
- * @max_policy_pct:	The maximum performance in percentage enforced by
- *			cpufreq setpolicy interface
- * @max_sysfs_pct:	The maximum performance in percentage enforced by
- *			intel pstate sysfs interface, unused when per cpu
- *			controls are enforced
- * @min_policy_pct:	The minimum performance in percentage enforced by
- *			cpufreq setpolicy interface
- * @min_sysfs_pct:	The minimum performance in percentage enforced by
- *			intel pstate sysfs interface, unused when per cpu
- *			controls are enforced
  *
- * Storage for user and policy defined limits.
+ * Storage for policy defined limits.
  */
 struct perf_limits {
-	int no_turbo;
-	int turbo_disabled;
+	int32_t max_perf;
+	int32_t min_perf;
+};
+
+/**
+ * struct global_params - Global parameters, mostly tunable via sysfs.
+ * @no_turbo:		Whether or not to use turbo P-states.
+ * @turbo_disabled:	Whethet or not turbo P-states are available at all,
+ *			based on the MSR_IA32_MISC_ENABLE value and whether or
+ *			not the maximum reported turbo P-state is different from
+ *			the maximum reported non-turbo one.
+ * @max_perf_pct:	Maximum capacity limit in percent of the maximum turbo
+ *			P-state capacity.
+ * @min_perf:		Minimum capacity limit as a fraction of the maximum
+ *			turbo P-state capacity.
+ * @max_perf_pct:	Maximum capacity limit in percent of the maximum turbo
+ *			P-state capacity.
+ * @max_perf:		Maximum capacity limit as a fraction of the maximum
+ *			turbo P-state capacity.
+ */
+struct global_params {
+	bool no_turbo;
+	bool turbo_disabled;
 	int max_perf_pct;
 	int min_perf_pct;
 	int32_t max_perf;
 	int32_t min_perf;
-	int max_policy_pct;
-	int max_sysfs_pct;
-	int min_policy_pct;
-	int min_sysfs_pct;
 };
 
 /**
@@ -245,9 +242,7 @@ struct perf_limits {
  * @prev_cummulative_iowait: IO Wait time difference from last and
  *			current sample
  * @sample:		Storage for storing last Sample data
- * @perf_limits:	Pointer to perf_limit unique to this CPU
- *			Not all field in the structure are applicable
- *			when per cpu controls are enforced
+ * @perf_limits:	Capacity limits unique to this CPU
  * @acpi_perf_data:	Stores ACPI perf information read from _PSS
  * @valid_pss_table:	Set to true for valid ACPI _PSS entries found
  * @epp_powersave:	Last saved HWP energy performance preference
@@ -279,7 +274,7 @@ struct cpudata {
 	u64	prev_tsc;
 	u64	prev_cummulative_iowait;
 	struct sample sample;
-	struct perf_limits *perf_limits;
+	struct perf_limits perf_limits;
 #ifdef CONFIG_ACPI
 	struct acpi_processor_performance acpi_perf_data;
 	bool valid_pss_table;
@@ -364,25 +359,13 @@ static bool driver_registered __read_mos
 static bool acpi_ppc;
 #endif
 
-static struct perf_limits performance_limits;
-static struct perf_limits powersave_limits;
-static struct perf_limits *limits;
+static struct global_params global;
 
-static void intel_pstate_init_limits(struct perf_limits *limits)
+static void intel_pstate_init_global_params(void)
 {
-	memset(limits, 0, sizeof(*limits));
-	limits->max_perf_pct = 100;
-	limits->max_perf = int_ext_tofp(1);
-	limits->max_policy_pct = 100;
-	limits->max_sysfs_pct = 100;
-}
-
-static void intel_pstate_set_performance_limits(struct perf_limits *limits)
-{
-	intel_pstate_init_limits(limits);
-	limits->min_perf_pct = 100;
-	limits->min_perf = int_ext_tofp(1);
-	limits->min_sysfs_pct = 100;
+	memset(&global, 0, sizeof(global));
+	global.max_perf_pct = 100;
+	global.max_perf = int_ext_tofp(1);
 }
 
 static DEFINE_MUTEX(intel_pstate_driver_lock);
@@ -507,7 +490,7 @@ static void intel_pstate_init_acpi_perf_
 	 * correct max turbo frequency based on the turbo state.
 	 * Also need to convert to MHz as _PSS freq is in MHz.
 	 */
-	if (!limits->turbo_disabled)
+	if (!global.turbo_disabled)
 		cpu->acpi_perf_data.states[0].core_frequency =
 					policy->cpuinfo.max_freq / 1000;
 	cpu->valid_pss_table = true;
@@ -626,7 +609,7 @@ static inline void update_turbo_state(vo
 
 	cpu = all_cpu_data[0];
 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
-	limits->turbo_disabled =
+	global.turbo_disabled =
 		(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE ||
 		 cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
 }
@@ -851,19 +834,16 @@ static struct freq_attr *hwp_cpufreq_att
 static void intel_pstate_hwp_set(struct cpufreq_policy *policy)
 {
 	int min, hw_min, max, hw_max, cpu;
-	struct perf_limits *perf_limits = limits;
 	u64 value, cap;
 
 	for_each_cpu(cpu, policy->cpus) {
 		struct cpudata *cpu_data = all_cpu_data[cpu];
+		struct perf_limits *perf_limits = &cpu_data->perf_limits;
 		s16 epp;
 
-		if (per_cpu_limits)
-			perf_limits = all_cpu_data[cpu]->perf_limits;
-
 		rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
 		hw_min = HWP_LOWEST_PERF(cap);
-		if (limits->no_turbo)
+		if (global.no_turbo)
 			hw_max = HWP_GUARANTEED_PERF(cap);
 		else
 			hw_max = HWP_HIGHEST_PERF(cap);
@@ -968,20 +948,11 @@ static int intel_pstate_resume(struct cp
 }
 
 static void intel_pstate_update_policies(void)
-	__releases(&intel_pstate_limits_lock)
-	__acquires(&intel_pstate_limits_lock)
 {
-	struct perf_limits *saved_limits = limits;
 	int cpu;
 
-	mutex_unlock(&intel_pstate_limits_lock);
-
 	for_each_possible_cpu(cpu)
 		cpufreq_update_policy(cpu);
-
-	mutex_lock(&intel_pstate_limits_lock);
-
-	limits = saved_limits;
 }
 
 /************************** debugfs begin ************************/
@@ -1060,7 +1031,7 @@ static void intel_pstate_debug_hide_para
 	static ssize_t show_##file_name					\
 	(struct kobject *kobj, struct attribute *attr, char *buf)	\
 	{								\
-		return sprintf(buf, "%u\n", limits->object);		\
+		return sprintf(buf, "%u\n", global.object);		\
 	}
 
 static ssize_t intel_pstate_show_status(char *buf);
@@ -1151,10 +1122,10 @@ static ssize_t show_no_turbo(struct kobj
 	}
 
 	update_turbo_state();
-	if (limits->turbo_disabled)
-		ret = sprintf(buf, "%u\n", limits->turbo_disabled);
+	if (global.turbo_disabled)
+		ret = sprintf(buf, "%u\n", global.turbo_disabled);
 	else
-		ret = sprintf(buf, "%u\n", limits->no_turbo);
+		ret = sprintf(buf, "%u\n", global.no_turbo);
 
 	mutex_unlock(&intel_pstate_driver_lock);
 
@@ -1181,19 +1152,19 @@ static ssize_t store_no_turbo(struct kob
 	mutex_lock(&intel_pstate_limits_lock);
 
 	update_turbo_state();
-	if (limits->turbo_disabled) {
+	if (global.turbo_disabled) {
 		pr_warn("Turbo disabled by BIOS or unavailable on processor\n");
 		mutex_unlock(&intel_pstate_limits_lock);
 		mutex_unlock(&intel_pstate_driver_lock);
 		return -EPERM;
 	}
 
-	limits->no_turbo = clamp_t(int, input, 0, 1);
-
-	intel_pstate_update_policies();
+	global.no_turbo = clamp_t(int, input, 0, 1);
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
+	intel_pstate_update_policies();
+
 	mutex_unlock(&intel_pstate_driver_lock);
 
 	return count;
@@ -1218,19 +1189,13 @@ static ssize_t store_max_perf_pct(struct
 
 	mutex_lock(&intel_pstate_limits_lock);
 
-	limits->max_sysfs_pct = clamp_t(int, input, 0 , 100);
-	limits->max_perf_pct = min(limits->max_policy_pct,
-				   limits->max_sysfs_pct);
-	limits->max_perf_pct = max(limits->min_policy_pct,
-				   limits->max_perf_pct);
-	limits->max_perf_pct = max(limits->min_perf_pct,
-				   limits->max_perf_pct);
-	limits->max_perf = percent_ext_fp(limits->max_perf_pct);
-
-	intel_pstate_update_policies();
+	global.max_perf_pct = clamp_t(int, input, global.min_perf_pct, 100);
+	global.max_perf = percent_ext_fp(global.max_perf_pct);
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
+	intel_pstate_update_policies();
+
 	mutex_unlock(&intel_pstate_driver_lock);
 
 	return count;
@@ -1255,19 +1220,13 @@ static ssize_t store_min_perf_pct(struct
 
 	mutex_lock(&intel_pstate_limits_lock);
 
-	limits->min_sysfs_pct = clamp_t(int, input, 0 , 100);
-	limits->min_perf_pct = max(limits->min_policy_pct,
-				   limits->min_sysfs_pct);
-	limits->min_perf_pct = min(limits->max_policy_pct,
-				   limits->min_perf_pct);
-	limits->min_perf_pct = min(limits->max_perf_pct,
-				   limits->min_perf_pct);
-	limits->min_perf = percent_ext_fp(limits->min_perf_pct);
-
-	intel_pstate_update_policies();
+	global.min_perf_pct = clamp_t(int, input, 0 , global.max_perf_pct);
+	global.min_perf = percent_ext_fp(global.min_perf_pct);
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
+	intel_pstate_update_policies();
+
 	mutex_unlock(&intel_pstate_driver_lock);
 
 	return count;
@@ -1387,7 +1346,7 @@ static u64 atom_get_val(struct cpudata *
 	u32 vid;
 
 	val = (u64)pstate << 8;
-	if (limits->no_turbo && !limits->turbo_disabled)
+	if (global.no_turbo && !global.turbo_disabled)
 		val |= (u64)1 << 32;
 
 	vid_fp = cpudata->vid.min + mul_fp(
@@ -1557,7 +1516,7 @@ static u64 core_get_val(struct cpudata *
 	u64 val;
 
 	val = (u64)pstate << 8;
-	if (limits->no_turbo && !limits->turbo_disabled)
+	if (global.no_turbo && !global.turbo_disabled)
 		val |= (u64)1 << 32;
 
 	return val;
@@ -1683,14 +1642,11 @@ static void intel_pstate_get_min_max(str
 	int max_perf = cpu->pstate.turbo_pstate;
 	int max_perf_adj;
 	int min_perf;
-	struct perf_limits *perf_limits = limits;
+	struct perf_limits *perf_limits = &cpu->perf_limits;
 
-	if (limits->no_turbo || limits->turbo_disabled)
+	if (global.no_turbo || global.turbo_disabled)
 		max_perf = cpu->pstate.max_pstate;
 
-	if (per_cpu_limits)
-		perf_limits = cpu->perf_limits;
-
 	/*
 	 * performance can be limited by user through sysfs, by cpufreq
 	 * policy, or by cpu specific default values determined through
@@ -1820,7 +1776,7 @@ static inline int32_t get_target_pstate_
 
 	sample->busy_scaled = busy_frac * 100;
 
-	target = limits->no_turbo || limits->turbo_disabled ?
+	target = global.no_turbo || global.turbo_disabled ?
 			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
 	target += target >> 2;
 	target = mul_fp(target, busy_frac);
@@ -2001,18 +1957,11 @@ static int intel_pstate_init_cpu(unsigne
 	cpu = all_cpu_data[cpunum];
 
 	if (!cpu) {
-		unsigned int size = sizeof(struct cpudata);
-
-		if (per_cpu_limits)
-			size += sizeof(struct perf_limits);
-
-		cpu = kzalloc(size, GFP_KERNEL);
+		cpu = kzalloc(sizeof(*cpu), GFP_KERNEL);
 		if (!cpu)
 			return -ENOMEM;
 
 		all_cpu_data[cpunum] = cpu;
-		if (per_cpu_limits)
-			cpu->perf_limits = (struct perf_limits *)(cpu + 1);
 
 		cpu->epp_default = -EINVAL;
 		cpu->epp_powersave = -EINVAL;
@@ -2094,11 +2043,9 @@ static void intel_pstate_update_perf_lim
 	}
 
 	/* Normalize user input to [min_perf, max_perf] */
-	limits->min_perf = max(min_policy_perf,
-			       percent_ext_fp(limits->min_sysfs_pct));
+	limits->min_perf = max(min_policy_perf, global.min_perf);
 	limits->min_perf = min(limits->min_perf, max_policy_perf);
-	limits->max_perf = min(max_policy_perf,
-			       percent_ext_fp(limits->max_sysfs_pct));
+	limits->max_perf = min(max_policy_perf, global.max_perf);
 	limits->max_perf = max(min_policy_perf, limits->max_perf);
 
 	/* Make sure min_perf <= max_perf */
@@ -2106,17 +2053,15 @@ static void intel_pstate_update_perf_lim
 
 	limits->max_perf = round_up(limits->max_perf, EXT_FRAC_BITS);
 	limits->min_perf = round_up(limits->min_perf, EXT_FRAC_BITS);
-	limits->max_perf_pct = fp_ext_toint(limits->max_perf * 100);
-	limits->min_perf_pct = fp_ext_toint(limits->min_perf * 100);
 
 	pr_debug("cpu:%d max_perf_pct:%d min_perf_pct:%d\n", policy->cpu,
-		 limits->max_perf_pct, limits->min_perf_pct);
+		 fp_ext_toint(limits->max_perf * 100),
+		 fp_ext_toint(limits->min_perf * 100));
 }
 
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu;
-	struct perf_limits *perf_limits = NULL;
 
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
@@ -2134,27 +2079,7 @@ static int intel_pstate_set_policy(struc
 		policy->max = policy->cpuinfo.max_freq;
 	}
 
-	if (per_cpu_limits)
-		perf_limits = cpu->perf_limits;
-
-	mutex_lock(&intel_pstate_limits_lock);
-
-	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
-		pr_debug("set performance\n");
-		if (!perf_limits) {
-			limits = &performance_limits;
-			perf_limits = limits;
-		}
-	} else {
-		pr_debug("set powersave\n");
-		if (!perf_limits) {
-			limits = &powersave_limits;
-			perf_limits = limits;
-		}
-
-	}
-
-	intel_pstate_update_perf_limits(policy, perf_limits);
+	intel_pstate_update_perf_limits(policy, &cpu->perf_limits);
 
 	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		/*
@@ -2177,16 +2102,9 @@ static int intel_pstate_set_policy(struc
 static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
-	struct perf_limits *perf_limits;
-
-	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
-		perf_limits = &performance_limits;
-	else
-		perf_limits = &powersave_limits;
 
 	update_turbo_state();
-	policy->cpuinfo.max_freq = perf_limits->turbo_disabled ||
-					perf_limits->no_turbo ?
+	policy->cpuinfo.max_freq = global.turbo_disabled || global.no_turbo ?
 					cpu->pstate.max_freq :
 					cpu->pstate.turbo_freq;
 
@@ -2235,8 +2153,8 @@ static int __intel_pstate_cpu_init(struc
 
 	cpu = all_cpu_data[policy->cpu];
 
-	if (per_cpu_limits)
-		intel_pstate_init_limits(cpu->perf_limits);
+	cpu->perf_limits.max_perf = int_ext_tofp(1);
+	cpu->perf_limits.min_perf = 0;
 
 	policy->min = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	policy->max = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
@@ -2244,7 +2162,7 @@ static int __intel_pstate_cpu_init(struc
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	update_turbo_state();
-	policy->cpuinfo.max_freq = limits->turbo_disabled ?
+	policy->cpuinfo.max_freq = global.turbo_disabled ?
 			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
 	policy->cpuinfo.max_freq *= cpu->pstate.scaling;
 
@@ -2264,7 +2182,7 @@ static int intel_pstate_cpu_init(struct
 		return ret;
 
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-	if (limits->min_perf_pct == 100 && limits->max_perf_pct == 100)
+	if (IS_ENABLED(CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE))
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
 	else
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
@@ -2290,11 +2208,13 @@ static int intel_cpufreq_verify_policy(s
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 
 	update_turbo_state();
-	policy->cpuinfo.max_freq = limits->turbo_disabled ?
+	policy->cpuinfo.max_freq = global.turbo_disabled ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 
 	cpufreq_verify_within_cpu_limits(policy);
 
+	intel_pstate_update_perf_limits(policy, &cpu->perf_limits);
+
 	return 0;
 }
 
@@ -2306,7 +2226,7 @@ static unsigned int intel_cpufreq_turbo_
 
 	update_turbo_state();
 
-	max_freq = limits->no_turbo || limits->turbo_disabled ?
+	max_freq = global.no_turbo || global.turbo_disabled ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 	policy->cpuinfo.max_freq = max_freq;
 	if (policy->max > max_freq)
@@ -2414,13 +2334,7 @@ static int intel_pstate_register_driver(
 {
 	int ret;
 
-	intel_pstate_init_limits(&powersave_limits);
-	intel_pstate_set_performance_limits(&performance_limits);
-	if (IS_ENABLED(CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE) &&
-	    intel_pstate_driver == &intel_pstate)
-		limits = &performance_limits;
-	else
-		limits = &powersave_limits;
+	intel_pstate_init_global_params();
 
 	ret = cpufreq_register_driver(intel_pstate_driver);
 	if (ret) {
