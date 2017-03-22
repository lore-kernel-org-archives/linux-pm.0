From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/5] cpufreq: intel_pstate: Active mode P-state limits rework
Date: Wed, 22 Mar 2017 23:58:57 +0100
Message-ID: <2621523.RDlv2b9eLR@aspire.rjw.lan>
References: <2025489.DxMTzKos7o@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43047 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751416AbdCVXov (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 19:44:51 -0400
In-Reply-To: <2025489.DxMTzKos7o@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Doug Smythies <dsmythies@telus.net>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The coordination of P-state limits used by intel_pstate in the active
mode (ie. by default) is problematic, because it synchronizes all of
the limits (ie. the global ones and the per-policy ones) so as to use
one common pair of P-state limits (min and max) across all CPUs in
the system.  The drawbacks of that are as follows:

 - If P-states are coordinated in hardware, it is not necessary
   to coordinate them in software on top of that, so in that case
   all of the above activity is in vain.

 - If P-states are not coordinated in hardware, then the processor
   is actually capable of setting different P-states for different
   CPUs and coordinating them at the software level simply doesn't
   allow that capability to be utilized.

 - The coordination works in such a way that setting a per-policy
   limit (eg. scaling_max_freq) for one CPU causes the common
   effective limit to change (and it will affect all of the other
   CPUs too), but subsequent reads from the corresponding sysfs
   attributes for the other CPUs will return stale values (which
   is confusing).

 - Reads from the global P-state limit attributes, min_perf_pct and
   max_perf_pct, return the effective common values and not the last
   values set through these attributes.  However, the last values
   set through these attributes become hard limits that cannot be
   exceeded by writes to scaling_min_freq and scaling_max_freq,
   respectively, and they are not exposed, so essentially users
   have to remember what they are.

All of that is painful enough to warrant a change of the management
of P-state limits in the active mode.

To that end, redesign the active mode P-state limits management in
intel_pstate in accordance with the following rules:

 (1) All CPUs are affected by the global limits (that is, none of
     them can be requested to run faster than the global max and
     none of them can be requested to run slower than the global
     min).

 (2) Each individual CPU is affected by its own per-policy limits
     (that is, it cannot be requested to run faster than its own
     per-policy max and it cannot be requested to run slower than
     its own per-policy min).

 (3) The global and per-policy limits can be set independently.

Also, the global maximum and minimum P-state limits will be always
expressed as percentages of the maximum supported turbo P-state.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |  185 ++++++++++++++++++-----------------------
 1 file changed, 85 insertions(+), 100 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -187,44 +187,35 @@ struct _pid {
 
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
-	int max_perf_pct;
-	int min_perf_pct;
 	int32_t max_perf;
 	int32_t min_perf;
-	int max_policy_pct;
-	int max_sysfs_pct;
-	int min_policy_pct;
-	int min_sysfs_pct;
+};
+
+/**
+ * struct global_params - Global parameters, mostly tunable via sysfs.
+ * @no_turbo:		Whether or not to use turbo P-states.
+ * @turbo_disabled:	Whethet or not turbo P-states are available at all,
+ *			based on the MSR_IA32_MISC_ENABLE value and whether or
+ *			not the maximum reported turbo P-state is different from
+ *			the maximum reported non-turbo one.
+ * @min_perf_pct:	Minimum capacity limit in percent of the maximum turbo
+ *			P-state capacity.
+ * @max_perf_pct:	Maximum capacity limit in percent of the maximum turbo
+ *			P-state capacity.
+ */
+struct global_params {
+	bool no_turbo;
+	bool turbo_disabled;
+	int max_perf_pct;
+	int min_perf_pct;
 };
 
 /**
@@ -245,9 +236,7 @@ struct perf_limits {
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
@@ -279,7 +268,7 @@ struct cpudata {
 	u64	prev_tsc;
 	u64	prev_cummulative_iowait;
 	struct sample sample;
-	struct perf_limits *perf_limits;
+	struct perf_limits perf_limits;
 #ifdef CONFIG_ACPI
 	struct acpi_processor_performance acpi_perf_data;
 	bool valid_pss_table;
@@ -364,16 +353,7 @@ static bool driver_registered __read_mos
 static bool acpi_ppc;
 #endif
 
-static struct perf_limits global;
-
-static void intel_pstate_init_limits(struct perf_limits *limits)
-{
-	memset(limits, 0, sizeof(*limits));
-	limits->max_perf_pct = 100;
-	limits->max_perf = int_ext_tofp(1);
-	limits->max_policy_pct = 100;
-	limits->max_sysfs_pct = 100;
-}
+static struct global_params global;
 
 static DEFINE_MUTEX(intel_pstate_driver_lock);
 static DEFINE_MUTEX(intel_pstate_limits_lock);
@@ -621,6 +601,14 @@ static inline void update_turbo_state(vo
 		 cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
 }
 
+static int min_perf_pct_min(void)
+{
+	struct cpudata *cpu = all_cpu_data[0];
+
+	return DIV_ROUND_UP(cpu->pstate.min_pstate * 100,
+			    cpu->pstate.turbo_pstate);
+}
+
 static s16 intel_pstate_get_epb(struct cpudata *cpu_data)
 {
 	u64 epb;
@@ -841,16 +829,13 @@ static struct freq_attr *hwp_cpufreq_att
 static void intel_pstate_hwp_set(struct cpufreq_policy *policy)
 {
 	int min, hw_min, max, hw_max, cpu;
-	struct perf_limits *perf_limits = &global;
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
 		if (global.no_turbo)
@@ -1163,6 +1148,15 @@ static ssize_t store_no_turbo(struct kob
 
 	global.no_turbo = clamp_t(int, input, 0, 1);
 
+	if (global.no_turbo) {
+		struct cpudata *cpu = all_cpu_data[0];
+		int pct = cpu->pstate.max_pstate * 100 / cpu->pstate.turbo_pstate;
+
+		/* Squash the global minimum into the permitted range. */
+		if (global.min_perf_pct > pct)
+			global.min_perf_pct = pct;
+	}
+
 	mutex_unlock(&intel_pstate_limits_lock);
 
 	intel_pstate_update_policies();
@@ -1191,11 +1185,7 @@ static ssize_t store_max_perf_pct(struct
 
 	mutex_lock(&intel_pstate_limits_lock);
 
-	global.max_sysfs_pct = clamp_t(int, input, 0 , 100);
-	global.max_perf_pct = min(global.max_policy_pct, global.max_sysfs_pct);
-	global.max_perf_pct = max(global.min_policy_pct, global.max_perf_pct);
-	global.max_perf_pct = max(global.min_perf_pct, global.max_perf_pct);
-	global.max_perf = percent_ext_fp(global.max_perf_pct);
+	global.max_perf_pct = clamp_t(int, input, global.min_perf_pct, 100);
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
@@ -1225,11 +1215,8 @@ static ssize_t store_min_perf_pct(struct
 
 	mutex_lock(&intel_pstate_limits_lock);
 
-	global.min_sysfs_pct = clamp_t(int, input, 0 , 100);
-	global.min_perf_pct = max(global.min_policy_pct, global.min_sysfs_pct);
-	global.min_perf_pct = min(global.max_policy_pct, global.min_perf_pct);
-	global.min_perf_pct = min(global.max_perf_pct, global.min_perf_pct);
-	global.min_perf = percent_ext_fp(global.min_perf_pct);
+	global.min_perf_pct = clamp_t(int, input,
+				      min_perf_pct_min(), global.max_perf_pct);
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
@@ -1650,14 +1637,11 @@ static void intel_pstate_get_min_max(str
 	int max_perf = cpu->pstate.turbo_pstate;
 	int max_perf_adj;
 	int min_perf;
-	struct perf_limits *perf_limits = &global;
+	struct perf_limits *perf_limits = &cpu->perf_limits;
 
 	if (global.no_turbo || global.turbo_disabled)
 		max_perf = cpu->pstate.max_pstate;
 
-	if (per_cpu_limits)
-		perf_limits = cpu->perf_limits;
-
 	/*
 	 * performance can be limited by user through sysfs, by cpufreq
 	 * policy, or by cpu specific default values determined through
@@ -1968,18 +1952,11 @@ static int intel_pstate_init_cpu(unsigne
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
@@ -2045,8 +2022,9 @@ static void intel_pstate_clear_update_ut
 }
 
 static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
-					    struct perf_limits *limits)
+					    struct cpudata *cpu)
 {
+	struct perf_limits *limits = &cpu->perf_limits;
 	int32_t max_policy_perf, min_policy_perf;
 
 	max_policy_perf = div_ext_fp(policy->max, policy->cpuinfo.max_freq);
@@ -2061,29 +2039,45 @@ static void intel_pstate_update_perf_lim
 	}
 
 	/* Normalize user input to [min_perf, max_perf] */
-	limits->min_perf = max(min_policy_perf,
-			       percent_ext_fp(limits->min_sysfs_pct));
-	limits->min_perf = min(limits->min_perf, max_policy_perf);
-	limits->max_perf = min(max_policy_perf,
-			       percent_ext_fp(limits->max_sysfs_pct));
-	limits->max_perf = max(min_policy_perf, limits->max_perf);
+	if (per_cpu_limits) {
+		limits->min_perf = min_policy_perf;
+		limits->max_perf = max_policy_perf;
+	} else {
+		int32_t global_min, global_max;
+
+		/* Global limits are in percent of the maximum turbo P-state. */
+		global_max = percent_ext_fp(global.max_perf_pct);
+		global_min = percent_ext_fp(global.min_perf_pct);
+		if (policy->cpuinfo.max_freq != cpu->pstate.turbo_freq) {
+			int32_t turbo_factor;
+
+			turbo_factor = div_ext_fp(cpu->pstate.turbo_pstate,
+						  cpu->pstate.max_pstate);
+			global_min = mul_ext_fp(global_min, turbo_factor);
+			global_max = mul_ext_fp(global_max, turbo_factor);
+		}
+		global_min = clamp_t(int32_t, global_min, 0, global_max);
 
-	/* Make sure min_perf <= max_perf */
-	limits->min_perf = min(limits->min_perf, limits->max_perf);
+		limits->min_perf = max(min_policy_perf, global_min);
+		limits->min_perf = min(limits->min_perf, max_policy_perf);
+		limits->max_perf = min(max_policy_perf, global_max);
+		limits->max_perf = max(min_policy_perf, limits->max_perf);
+
+		/* Make sure min_perf <= max_perf */
+		limits->min_perf = min(limits->min_perf, limits->max_perf);
+	}
 
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
-	struct perf_limits *perf_limits = &global;
 
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
@@ -2101,12 +2095,9 @@ static int intel_pstate_set_policy(struc
 		policy->max = policy->cpuinfo.max_freq;
 	}
 
-	if (per_cpu_limits)
-		perf_limits = cpu->perf_limits;
-
 	mutex_lock(&intel_pstate_limits_lock);
 
-	intel_pstate_update_perf_limits(policy, perf_limits);
+	intel_pstate_update_perf_limits(policy, cpu);
 
 	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		/*
@@ -2142,17 +2133,6 @@ static int intel_pstate_verify_policy(st
 	    policy->policy != CPUFREQ_POLICY_PERFORMANCE)
 		return -EINVAL;
 
-	/* When per-CPU limits are used, sysfs limits are not used */
-	if (!per_cpu_limits) {
-		unsigned int max_freq, min_freq;
-
-		max_freq = policy->cpuinfo.max_freq *
-					global.max_sysfs_pct / 100;
-		min_freq = policy->cpuinfo.max_freq *
-					global.min_sysfs_pct / 100;
-		cpufreq_verify_within_limits(policy, min_freq, max_freq);
-	}
-
 	return 0;
 }
 
@@ -2192,8 +2172,8 @@ static int __intel_pstate_cpu_init(struc
 
 	cpu = all_cpu_data[policy->cpu];
 
-	if (per_cpu_limits)
-		intel_pstate_init_limits(cpu->perf_limits);
+	cpu->perf_limits.max_perf = int_ext_tofp(1);
+	cpu->perf_limits.min_perf = 0;
 
 	policy->min = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	policy->max = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
@@ -2252,6 +2232,8 @@ static int intel_cpufreq_verify_policy(s
 
 	cpufreq_verify_within_cpu_limits(policy);
 
+	intel_pstate_update_perf_limits(policy, cpu);
+
 	return 0;
 }
 
@@ -2354,7 +2336,8 @@ static int intel_pstate_register_driver(
 {
 	int ret;
 
-	intel_pstate_init_limits(&global);
+	memset(&global, 0, sizeof(global));
+	global.max_perf_pct = 100;
 
 	ret = cpufreq_register_driver(intel_pstate_driver);
 	if (ret) {
@@ -2362,6 +2345,8 @@ static int intel_pstate_register_driver(
 		return ret;
 	}
 
+	global.min_perf_pct = min_perf_pct_min();
+
 	mutex_lock(&intel_pstate_limits_lock);
 	driver_registered = true;
 	mutex_unlock(&intel_pstate_limits_lock);
