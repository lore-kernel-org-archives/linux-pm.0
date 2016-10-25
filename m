From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 1/4] cpufreq: intel_pstate: Per CPU P-State limits
Date: Tue, 25 Oct 2016 13:20:40 -0700
Message-ID: <1477426843-63821-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1477426843-63821-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2438 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932301AbcJYUU4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Oct 2016 16:20:56 -0400
In-Reply-To: <1477426843-63821-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Intel P-State offers two interface to set performance limits:
- Intel P-State sysfs
	/sys/devices/system/cpu/intel_pstate/max_perf_pct
	/sys/devices/system/cpu/intel_pstate/min_perf_pct
- cpufreq
	/sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
	/sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq

In the current implementation both of the above methods, change limits
to every CPU in the system. Moreover the limits placed using cpufreq
policy interface also presented in the Intel P-State sysfs via modified
max_perf_pct and min_per_pct during sysfs reads. This allows to check
percent of reduced/increased performance, irrespective of method used to
limit.

There are some new generations of processors, where it is possible to
have limits placed on individual CPU cores. Using cpufreq interface it
is possible to set limits on each CPU. But the current processing will
use last limits placed on all CPUs. So the per core limit feature of
CPUs can't be used.

This change brings in capability to set P-States limits for each CPU,
with some limitations. In this case what should be the read of
max_perf_pct and min_perf_pct? It can be most restrictive limits placed
on any CPU or max possible performance on any given CPU on which no
limits are placed. In either case someone will have issue.

So the consensus is, we can't have both sysfs controls present when user
wants to use limit per core limits.
- By default per-core-control feature is not enabled. So no one will
notice any difference.
- The way to enable is by kernel command line
intel_pstate=per_cpu_perf_limits
- When the per-core-controls are enabled there is no display of for both
read and write on
	/sys/devices/system/cpu/intel_pstate/max_perf_pct
	/sys/devices/system/cpu/intel_pstate/min_perf_pct
- User can change limits using
	/sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
	/sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq
	/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
- User can still observe turbo percent and number of P-States from
	/sys/devices/system/cpu/intel_pstate/turbo_pct
	/sys/devices/system/cpu/intel_pstate/num_pstates
- User can read write system wide turbo status
	/sys/devices/system/cpu/no_turbo

While changing this BUG_ON is changed to WARN_ON, as they are not fatal
errors for the system.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 236 +++++++++++++++++++++++++++--------------
 1 file changed, 156 insertions(+), 80 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d7a9195..b6e9b49 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -177,6 +177,48 @@ struct _pid {
 };
 
 /**
+ * struct perf_limits - Store user and policy limits
+ * @no_turbo:		User requested turbo state from intel_pstate sysfs
+ * @turbo_disabled:	Platform turbo status either from msr
+ *			MSR_IA32_MISC_ENABLE or when maximum available pstate
+ *			matches the maximum turbo pstate
+ * @max_perf_pct:	Effective maximum performance limit in percentage, this
+ *			is minimum of either limits enforced by cpufreq policy
+ *			or limits from user set limits via intel_pstate sysfs
+ * @min_perf_pct:	Effective minimum performance limit in percentage, this
+ *			is maximum of either limits enforced by cpufreq policy
+ *			or limits from user set limits via intel_pstate sysfs
+ * @max_perf:		This is a scaled value between 0 to 255 for max_perf_pct
+ *			This value is used to limit max pstate
+ * @min_perf:		This is a scaled value between 0 to 255 for min_perf_pct
+ *			This value is used to limit min pstate
+ * @max_policy_pct:	The maximum performance in percentage enforced by
+ *			cpufreq setpolicy interface
+ * @max_sysfs_pct:	The maximum performance in percentage enforced by
+ *			intel pstate sysfs interface, unused when per cpu
+ *			controls are enforced
+ * @min_policy_pct:	The minimum performance in percentage enforced by
+ *			cpufreq setpolicy interface
+ * @min_sysfs_pct:	The minimum performance in percentage enforced by
+ *			intel pstate sysfs interface, unused when per cpu
+ *			controls are enforced
+ *
+ * Storage for user and policy defined limits.
+ */
+struct perf_limits {
+	int no_turbo;
+	int turbo_disabled;
+	int max_perf_pct;
+	int min_perf_pct;
+	int32_t max_perf;
+	int32_t min_perf;
+	int max_policy_pct;
+	int max_sysfs_pct;
+	int min_policy_pct;
+	int min_sysfs_pct;
+};
+
+/**
  * struct cpudata -	Per CPU instance data storage
  * @cpu:		CPU number for this instance data
  * @policy:		CPUFreq policy value
@@ -194,6 +236,9 @@ struct _pid {
  * @prev_cummulative_iowait: IO Wait time difference from last and
  *			current sample
  * @sample:		Storage for storing last Sample data
+ * @perf_limits:	Pointer to perf_limit unique to this CPU
+ *			Not all field in the structure are applicable
+ *			when per cpu controls are enforced
  * @acpi_perf_data:	Stores ACPI perf information read from _PSS
  * @valid_pss_table:	Set to true for valid ACPI _PSS entries found
  *
@@ -217,6 +262,7 @@ struct cpudata {
 	u64	prev_tsc;
 	u64	prev_cummulative_iowait;
 	struct sample sample;
+	struct perf_limits *perf_limits;
 #ifdef CONFIG_ACPI
 	struct acpi_processor_performance acpi_perf_data;
 	bool valid_pss_table;
@@ -289,51 +335,12 @@ static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu);
 static struct pstate_adjust_policy pid_params __read_mostly;
 static struct pstate_funcs pstate_funcs __read_mostly;
 static int hwp_active __read_mostly;
+static bool per_cpu_limits __read_mostly;
 
 #ifdef CONFIG_ACPI
 static bool acpi_ppc;
 #endif
 
-/**
- * struct perf_limits - Store user and policy limits
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
- * @max_perf:		This is a scaled value between 0 to 255 for max_perf_pct
- *			This value is used to limit max pstate
- * @min_perf:		This is a scaled value between 0 to 255 for min_perf_pct
- *			This value is used to limit min pstate
- * @max_policy_pct:	The maximum performance in percentage enforced by
- *			cpufreq setpolicy interface
- * @max_sysfs_pct:	The maximum performance in percentage enforced by
- *			intel pstate sysfs interface
- * @min_policy_pct:	The minimum performance in percentage enforced by
- *			cpufreq setpolicy interface
- * @min_sysfs_pct:	The minimum performance in percentage enforced by
- *			intel pstate sysfs interface
- *
- * Storage for user and policy defined limits.
- */
-struct perf_limits {
-	int no_turbo;
-	int turbo_disabled;
-	int max_perf_pct;
-	int min_perf_pct;
-	int32_t max_perf;
-	int32_t min_perf;
-	int max_policy_pct;
-	int max_sysfs_pct;
-	int min_policy_pct;
-	int min_sysfs_pct;
-};
-
 static struct perf_limits performance_limits = {
 	.no_turbo = 0,
 	.turbo_disabled = 0,
@@ -560,21 +567,30 @@ static inline void update_turbo_state(void)
 static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 {
 	int min, hw_min, max, hw_max, cpu, range, adj_range;
+	struct perf_limits *perf_limits = limits;
 	u64 value, cap;
 
 	for_each_cpu(cpu, cpumask) {
+		int max_perf_pct, min_perf_pct;
+
+		if (per_cpu_limits)
+			perf_limits = all_cpu_data[cpu]->perf_limits;
+
 		rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
 		hw_min = HWP_LOWEST_PERF(cap);
 		hw_max = HWP_HIGHEST_PERF(cap);
 		range = hw_max - hw_min;
 
+		max_perf_pct = perf_limits->max_perf_pct;
+		min_perf_pct = perf_limits->min_perf_pct;
+
 		rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
-		adj_range = limits->min_perf_pct * range / 100;
+		adj_range = min_perf_pct * range / 100;
 		min = hw_min + adj_range;
 		value &= ~HWP_MIN_PERF(~0L);
 		value |= HWP_MIN_PERF(min);
 
-		adj_range = limits->max_perf_pct * range / 100;
+		adj_range = max_perf_pct * range / 100;
 		max = hw_min + adj_range;
 		if (limits->no_turbo) {
 			hw_max = HWP_GUARANTEED_PERF(cap);
@@ -787,8 +803,6 @@ define_one_global_ro(num_pstates);
 
 static struct attribute *intel_pstate_attributes[] = {
 	&no_turbo.attr,
-	&max_perf_pct.attr,
-	&min_perf_pct.attr,
 	&turbo_pct.attr,
 	&num_pstates.attr,
 	NULL
@@ -805,9 +819,26 @@ static void __init intel_pstate_sysfs_expose_params(void)
 
 	intel_pstate_kobject = kobject_create_and_add("intel_pstate",
 						&cpu_subsys.dev_root->kobj);
-	BUG_ON(!intel_pstate_kobject);
+	if (WARN_ON(!intel_pstate_kobject))
+		return;
+
 	rc = sysfs_create_group(intel_pstate_kobject, &intel_pstate_attr_group);
-	BUG_ON(rc);
+	if (WARN_ON(rc))
+		return;
+
+	/*
+	 * If per cpu limits are enforced there are no global limits, so
+	 * return without creating max/min_perf_pct attributes
+	 */
+	if (per_cpu_limits)
+		return;
+
+	rc = sysfs_create_file(intel_pstate_kobject, &max_perf_pct.attr);
+	WARN_ON(rc);
+
+	rc = sysfs_create_file(intel_pstate_kobject, &min_perf_pct.attr);
+	WARN_ON(rc);
+
 }
 /************************** sysfs end ************************/
 
@@ -1124,20 +1155,24 @@ static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
 	int max_perf = cpu->pstate.turbo_pstate;
 	int max_perf_adj;
 	int min_perf;
+	struct perf_limits *perf_limits = limits;
 
 	if (limits->no_turbo || limits->turbo_disabled)
 		max_perf = cpu->pstate.max_pstate;
 
+	if (per_cpu_limits)
+		perf_limits = cpu->perf_limits;
+
 	/*
 	 * performance can be limited by user through sysfs, by cpufreq
 	 * policy, or by cpu specific default values determined through
 	 * experimentation.
 	 */
-	max_perf_adj = fp_toint(max_perf * limits->max_perf);
+	max_perf_adj = fp_toint(max_perf * perf_limits->max_perf);
 	*max = clamp_t(int, max_perf_adj,
 			cpu->pstate.min_pstate, cpu->pstate.turbo_pstate);
 
-	min_perf = fp_toint(max_perf * limits->min_perf);
+	min_perf = fp_toint(max_perf * perf_limits->min_perf);
 	*min = clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf);
 }
 
@@ -1421,11 +1456,23 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 {
 	struct cpudata *cpu;
 
-	if (!all_cpu_data[cpunum])
-		all_cpu_data[cpunum] = kzalloc(sizeof(struct cpudata),
-					       GFP_KERNEL);
-	if (!all_cpu_data[cpunum])
-		return -ENOMEM;
+	cpu = all_cpu_data[cpunum];
+
+	if (!cpu) {
+		unsigned int size = sizeof(struct cpudata);
+
+		if (per_cpu_limits)
+			size += sizeof(struct perf_limits);
+
+		cpu = kzalloc(size, GFP_KERNEL);
+		if (!cpu)
+			return -ENOMEM;
+
+		all_cpu_data[cpunum] = cpu;
+		if (per_cpu_limits)
+			cpu->perf_limits = (struct perf_limits *)(cpu + 1);
+
+	}
 
 	cpu = all_cpu_data[cpunum];
 
@@ -1493,9 +1540,40 @@ static void intel_pstate_set_performance_limits(struct perf_limits *limits)
 	limits->min_sysfs_pct = 0;
 }
 
+static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
+					    struct perf_limits *limits)
+{
+	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
+	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0, 100);
+	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
+					      policy->cpuinfo.max_freq);
+	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0, 100);
+
+	/* Normalize user input to [min_policy_pct, max_policy_pct] */
+	limits->min_perf_pct = max(limits->min_policy_pct,
+				   limits->min_sysfs_pct);
+	limits->min_perf_pct = min(limits->max_policy_pct,
+				   limits->min_perf_pct);
+	limits->max_perf_pct = min(limits->max_policy_pct,
+				   limits->max_sysfs_pct);
+	limits->max_perf_pct = max(limits->min_policy_pct,
+				   limits->max_perf_pct);
+
+	/* Make sure min_perf_pct <= max_perf_pct */
+	limits->min_perf_pct = min(limits->max_perf_pct, limits->min_perf_pct);
+
+	limits->min_perf = div_fp(limits->min_perf_pct, 100);
+	limits->max_perf = div_fp(limits->max_perf_pct, 100);
+	limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
+
+	pr_debug("cpu:%d max_perf_pct:%d min_perf_pct:%d\n", policy->cpu,
+		 limits->max_perf_pct, limits->min_perf_pct);
+}
+
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu;
+	struct perf_limits *perf_limits = NULL;
 
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
@@ -1513,41 +1591,29 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 		policy->max = policy->cpuinfo.max_freq;
 	}
 
-	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE) {
-		limits = &performance_limits;
+	if (per_cpu_limits)
+		perf_limits = cpu->perf_limits;
+
+	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
+		if (!perf_limits) {
+			limits = &performance_limits;
+			perf_limits = limits;
+		}
 		if (policy->max >= policy->cpuinfo.max_freq) {
 			pr_debug("set performance\n");
-			intel_pstate_set_performance_limits(limits);
+			intel_pstate_set_performance_limits(perf_limits);
 			goto out;
 		}
 	} else {
 		pr_debug("set powersave\n");
-		limits = &powersave_limits;
-	}
-
-	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
-	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0 , 100);
-	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
-					      policy->cpuinfo.max_freq);
-	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);
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
-
-	/* Make sure min_perf_pct <= max_perf_pct */
-	limits->min_perf_pct = min(limits->max_perf_pct, limits->min_perf_pct);
+		if (!perf_limits) {
+			limits = &powersave_limits;
+			perf_limits = limits;
+		}
 
-	limits->min_perf = div_fp(limits->min_perf_pct, 100);
-	limits->max_perf = div_fp(limits->max_perf_pct, 100);
-	limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
+	}
 
+	intel_pstate_update_perf_limits(policy, perf_limits);
  out:
 	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		/*
@@ -1607,6 +1673,14 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	else
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
 
+	/*
+	 * We need sane value in the cpu->perf_limits, so inherit from global
+	 * perf_limits limits, which are seeded with values based on the
+	 * CONFIG_CPU_FREQ_DEFAULT_GOV_*, during boot up.
+	 */
+	if (per_cpu_limits)
+		memcpy(cpu->perf_limits, limits, sizeof(struct perf_limits));
+
 	policy->min = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	policy->max = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
 
@@ -1888,6 +1962,8 @@ static int __init intel_pstate_setup(char *str)
 		force_load = 1;
 	if (!strcmp(str, "hwp_only"))
 		hwp_only = 1;
+	if (!strcmp(str, "per_cpu_perf_limits"))
+		per_cpu_limits = true;
 
 #ifdef CONFIG_ACPI
 	if (!strcmp(str, "support_acpi_ppc"))
-- 
2.7.4

