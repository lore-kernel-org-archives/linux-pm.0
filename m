From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [Update][PATCH 1/2] cpufreq: intel_pstate: Per CPU P-State limits
Date: Wed, 12 Oct 2016 12:07:21 -0700
Message-ID: <1476299241-87924-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41012 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755137AbcJLTHw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Oct 2016 15:07:52 -0400
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

In the current implementation both of the above methods, change limits to
every CPU in the system, even if cpufreq interface offers per CPU controls.

This change gives some clarity to these interfaces and fixes cpufreq sysfs
interface to only impact the CPU on which operation is done (When possible
by the CPU architecture and also need to consider hyperthreading)

To be precise:
- Intel P-State sysfs is for placing global limits for all CPUs
- The cpufreq sysfs for individual CPU is to place limits on each CPU,
which are constrained by global limits. So If the global limit is
to reduce max_perf_pct to 80%, the individual CPU can't exceed 80%
of performance, but each CPU can add more restrictive limit
(E.g. say 60% here). Same rule applies to min_perf_pct. Each CPU
can request more than min_perf_pct as a limit value.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Update:
	Minor update in the commit description

 drivers/cpufreq/intel_pstate.c | 361 +++++++++++++++++++++++++++++------------
 1 file changed, 257 insertions(+), 104 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1c7b91c..d49fe21 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -193,6 +193,24 @@ struct _pid {
  * @prev_cummulative_iowait: IO Wait time difference from last and
  *			current sample
  * @sample:		Storage for storing last Sample data
+ * @max_perf:		This is a scaled value between 0 to 255 for
+ *			max_perf_pct. This value is used to limit
+ *			max pstate for this CPU
+ * @min_perf:		This is a scaled value between 0 to 255 for
+ *			min_perf_pct. This value is used to limit
+ *			min pstate for this CPU
+ * @prev_max_perf:	Last max_perf value
+ * @prev_min_perf:	Last min perf value
+ * @max_policy_pct:	The maximum performance in percentage enforced by
+ *			cpufreq setpolicy interface for this CPU
+ * @max_policy_pct:	The minimum performance in percentage enforced by
+ *			cpufreq setpolicy interface for this CPU
+ * @max_perf_pct:	Effective maximum performance limit in percentage, this
+ *			is minimum of either limits enforced by cpufreq policy
+ *			or limits from user set limits via intel_pstate sysfs
+ * @min_perf_pct:	Effective minimum performance limit in percentage, this
+ *			is maximum of either limits enforced by cpufreq policy
+ *			or limits from user set limits via intel_pstate sysfs
  * @acpi_perf_data:	Stores ACPI perf information read from _PSS
  * @valid_pss_table:	Set to true for valid ACPI _PSS entries found
  *
@@ -215,6 +233,14 @@ struct cpudata {
 	u64	prev_tsc;
 	u64	prev_cummulative_iowait;
 	struct sample sample;
+	int32_t max_perf;
+	int32_t min_perf;
+	int32_t prev_max_perf;
+	int32_t prev_min_perf;
+	int max_policy_pct;
+	int min_policy_pct;
+	int max_perf_pct;
+	int min_perf_pct;
 #ifdef CONFIG_ACPI
 	struct acpi_processor_performance acpi_perf_data;
 	bool valid_pss_table;
@@ -289,6 +315,9 @@ static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu);
 static struct pstate_adjust_policy pid_params __read_mostly;
 static struct pstate_funcs pstate_funcs __read_mostly;
 static int hwp_active __read_mostly;
+static DEFINE_MUTEX(perf_limits_lock);
+static int system_policy_max_perf;
+static int system_policy_min_perf;
 
 #ifdef CONFIG_ACPI
 static bool acpi_ppc;
@@ -300,63 +329,31 @@ static bool acpi_ppc;
  * @turbo_disabled:	Platform turbo status either from msr
  *			MSR_IA32_MISC_ENABLE or when maximum available pstate
  *			matches the maximum turbo pstate
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
  * @max_sysfs_pct:	The maximum performance in percentage enforced by
- *			intel pstate sysfs interface
- * @min_policy_pct:	The minimum performance in percentage enforced by
- *			cpufreq setpolicy interface
+ *			intel pstate sysfs interface for all CPUs
  * @min_sysfs_pct:	The minimum performance in percentage enforced by
- *			intel pstate sysfs interface
+ *			intel pstate sysfs interface for all CPUs
  *
  * Storage for user and policy defined limits.
  */
 struct perf_limits {
 	int no_turbo;
 	int turbo_disabled;
-	int max_perf_pct;
-	int min_perf_pct;
-	int32_t max_perf;
-	int32_t min_perf;
-	int max_policy_pct;
 	int max_sysfs_pct;
-	int min_policy_pct;
 	int min_sysfs_pct;
 };
 
 static struct perf_limits performance_limits = {
 	.no_turbo = 0,
 	.turbo_disabled = 0,
-	.max_perf_pct = 100,
-	.max_perf = int_tofp(1),
-	.min_perf_pct = 100,
-	.min_perf = int_tofp(1),
-	.max_policy_pct = 100,
 	.max_sysfs_pct = 100,
-	.min_policy_pct = 0,
 	.min_sysfs_pct = 0,
 };
 
 static struct perf_limits powersave_limits = {
 	.no_turbo = 0,
 	.turbo_disabled = 0,
-	.max_perf_pct = 100,
-	.max_perf = int_tofp(1),
-	.min_perf_pct = 0,
-	.min_perf = 0,
-	.max_policy_pct = 100,
 	.max_sysfs_pct = 100,
-	.min_policy_pct = 0,
 	.min_sysfs_pct = 0,
 };
 
@@ -569,12 +566,12 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 		range = hw_max - hw_min;
 
 		rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
-		adj_range = limits->min_perf_pct * range / 100;
+		adj_range = all_cpu_data[cpu]->min_perf_pct * range / 100;
 		min = hw_min + adj_range;
 		value &= ~HWP_MIN_PERF(~0L);
 		value |= HWP_MIN_PERF(min);
 
-		adj_range = limits->max_perf_pct * range / 100;
+		adj_range = all_cpu_data[cpu]->max_perf_pct * range / 100;
 		max = hw_min + adj_range;
 		if (limits->no_turbo) {
 			hw_max = HWP_GUARANTEED_PERF(cap);
@@ -654,12 +651,6 @@ static void __init intel_pstate_debug_expose_params(void)
 /************************** debugfs end ************************/
 
 /************************** sysfs begin ************************/
-#define show_one(file_name, object)					\
-	static ssize_t show_##file_name					\
-	(struct kobject *kobj, struct attribute *attr, char *buf)	\
-	{								\
-		return sprintf(buf, "%u\n", limits->object);		\
-	}
 
 static ssize_t show_turbo_pct(struct kobject *kobj,
 				struct attribute *attr, char *buf)
@@ -726,27 +717,126 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
 	return count;
 }
 
+/*
+ * Find the maximum and minimum performance as a percentage based
+ * on limits placed on individual CPUs. Since threads can migrate
+ * to different CPUs, the ground rules are:
+ * - The max performance is the CPU with least performance, since that
+ * is what can be be most constrained max performance limit.
+ * - The min performance is the CPU with the max limit on performance,
+ * since that is what can be be most constrained min performance limit.
+ */
+static void get_max_min_perf(int *max_perf, int *min_perf)
+{
+	int cpu_index;
+
+	mutex_lock(&perf_limits_lock);
+
+	/*
+	 * If there is no set_policy() or offline cpu called after last
+	 * calculation, don't need to calculate min/max
+	 */
+	if (system_policy_max_perf && system_policy_min_perf)
+		goto set_perf_val;
+
+	system_policy_max_perf = limits->max_sysfs_pct;
+	system_policy_min_perf = limits->min_sysfs_pct;
+
+	for_each_online_cpu(cpu_index) {
+		struct cpudata *cpu = all_cpu_data[cpu_index];
+
+		if (system_policy_max_perf > cpu->max_perf_pct)
+			system_policy_max_perf = cpu->max_perf_pct;
+
+		if (system_policy_min_perf < cpu->min_perf_pct)
+			system_policy_min_perf = cpu->min_perf_pct;
+	}
+
+set_perf_val:
+	*min_perf = system_policy_min_perf;
+	*max_perf = system_policy_max_perf;
+
+	mutex_unlock(&perf_limits_lock);
+}
+
+/*
+ * Invalidate max/min sysfs limits: this will force recalculation during next
+ * sysfs [max|min]perf_pct read/writes. Must be called with perf_limit_lock
+ * mutex held.
+ */
+static void invalidate_policy_perf_limits(void)
+{
+	system_policy_max_perf = 0;
+	system_policy_min_perf = 0;
+}
+
+static ssize_t show_max_perf_pct(struct kobject *kobj,
+				 struct attribute *attr, char *buf)
+{
+	int max_perf, min_perf;
+
+	get_max_min_perf(&max_perf, &min_perf);
+
+	return sprintf(buf, "%d\n", max_perf);
+}
+
+static ssize_t show_min_perf_pct(struct kobject *kobj,
+				 struct attribute *attr, char *buf)
+{
+	int max_perf, min_perf;
+
+	get_max_min_perf(&max_perf, &min_perf);
+
+	return sprintf(buf, "%d\n", min_perf);
+}
+
 static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 				  const char *buf, size_t count)
 {
 	unsigned int input;
+	int max_perf, min_perf;
+	int max_sysfs_pct;
+	int cpu_index;
 	int ret;
 
 	ret = sscanf(buf, "%u", &input);
 	if (ret != 1)
 		return -EINVAL;
 
-	limits->max_sysfs_pct = clamp_t(int, input, 0 , 100);
-	limits->max_perf_pct = min(limits->max_policy_pct,
-				   limits->max_sysfs_pct);
-	limits->max_perf_pct = max(limits->min_policy_pct,
-				   limits->max_perf_pct);
-	limits->max_perf_pct = max(limits->min_perf_pct,
-				   limits->max_perf_pct);
-	limits->max_perf = div_fp(limits->max_perf_pct, 100);
+	max_sysfs_pct = clamp_t(int, input, 0, 100);
+
+	get_max_min_perf(&max_perf, &min_perf);
+	if (max_sysfs_pct < min_perf)
+		return -EINVAL;
+
+	mutex_lock(&perf_limits_lock);
+	limits->max_sysfs_pct = max_sysfs_pct;
+	system_policy_max_perf = limits->max_sysfs_pct;
+
+	for_each_online_cpu(cpu_index) {
+		struct cpudata *cpu = all_cpu_data[cpu_index];
+
+		/*
+		 * Find minimum of cpufreq and sysfs settings and ensure
+		 * that this is more than minimum allowed on this CPU
+		 */
+		cpu->max_perf_pct = min(cpu->max_policy_pct,
+					limits->max_sysfs_pct);
+		cpu->max_perf_pct = max(cpu->min_perf_pct,
+					cpu->max_perf_pct);
+
+		if (system_policy_max_perf > cpu->max_perf_pct)
+			system_policy_max_perf = cpu->max_perf_pct;
+
+		cpu->max_perf = div_fp(cpu->max_perf_pct, 100);
+		cpu->prev_max_perf = cpu->max_perf;
+	}
+
+	mutex_unlock(&perf_limits_lock);
 
 	if (hwp_active)
 		intel_pstate_hwp_set_online_cpus();
+
 	return count;
 }
 
@@ -754,29 +844,52 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 				  const char *buf, size_t count)
 {
 	unsigned int input;
+	int max_perf, min_perf;
+	int min_sysfs_pct;
+	int cpu_index;
 	int ret;
 
 	ret = sscanf(buf, "%u", &input);
 	if (ret != 1)
 		return -EINVAL;
 
-	limits->min_sysfs_pct = clamp_t(int, input, 0 , 100);
-	limits->min_perf_pct = max(limits->min_policy_pct,
-				   limits->min_sysfs_pct);
-	limits->min_perf_pct = min(limits->max_policy_pct,
-				   limits->min_perf_pct);
-	limits->min_perf_pct = min(limits->max_perf_pct,
-				   limits->min_perf_pct);
-	limits->min_perf = div_fp(limits->min_perf_pct, 100);
+	min_sysfs_pct = clamp_t(int, input, 0, 100);
+
+	get_max_min_perf(&max_perf, &min_perf);
+	if (min_sysfs_pct > max_perf)
+		return -EINVAL;
+
+	mutex_lock(&perf_limits_lock);
+	limits->min_sysfs_pct = min_sysfs_pct;
+	system_policy_min_perf = limits->min_sysfs_pct;
+
+	for_each_online_cpu(cpu_index) {
+		struct cpudata *cpu = all_cpu_data[cpu_index];
+		/*
+		 * Find maximum of cpufreq and sysfs settings and ensure
+		 * that this is less than maximum allowed on this CPU
+		 */
+
+		cpu->min_perf_pct = max(cpu->min_policy_pct,
+					limits->min_sysfs_pct);
+		cpu->min_perf_pct = min(cpu->max_perf_pct,
+					cpu->min_perf_pct);
+
+		if (system_policy_min_perf < cpu->min_perf_pct)
+			system_policy_min_perf = cpu->min_perf_pct;
+
+		cpu->min_perf = div_fp(cpu->min_perf_pct, 100);
+		cpu->prev_min_perf = cpu->min_perf;
+	}
+
+	mutex_unlock(&perf_limits_lock);
 
 	if (hwp_active)
 		intel_pstate_hwp_set_online_cpus();
+
 	return count;
 }
 
-show_one(max_perf_pct, max_perf_pct);
-show_one(min_perf_pct, min_perf_pct);
-
 define_one_global_rw(no_turbo);
 define_one_global_rw(max_perf_pct);
 define_one_global_rw(min_perf_pct);
@@ -1134,11 +1247,11 @@ static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
 	 * policy, or by cpu specific default values determined through
 	 * experimentation.
 	 */
-	max_perf_adj = fp_toint(max_perf * limits->max_perf);
+	max_perf_adj = fp_toint(max_perf * cpu->max_perf);
 	*max = clamp_t(int, max_perf_adj,
 			cpu->pstate.min_pstate, cpu->pstate.turbo_pstate);
 
-	min_perf = fp_toint(max_perf * limits->min_perf);
+	min_perf = fp_toint(max_perf * cpu->min_perf);
 	*min = clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf);
 }
 
@@ -1389,11 +1502,19 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 {
 	struct cpudata *cpu;
 
-	if (!all_cpu_data[cpunum])
+	if (!all_cpu_data[cpunum]) {
 		all_cpu_data[cpunum] = kzalloc(sizeof(struct cpudata),
 					       GFP_KERNEL);
-	if (!all_cpu_data[cpunum])
-		return -ENOMEM;
+		if (!all_cpu_data[cpunum])
+			return -ENOMEM;
+
+		all_cpu_data[cpunum]->max_perf_pct = 100;
+#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
+		all_cpu_data[cpunum]->min_perf_pct = 100;
+#else
+		all_cpu_data[cpunum]->min_perf_pct = 0;
+#endif
+	}
 
 	cpu = all_cpu_data[cpunum];
 
@@ -1447,18 +1568,14 @@ static void intel_pstate_clear_update_util_hook(unsigned int cpu)
 	synchronize_sched();
 }
 
-static void intel_pstate_set_performance_limits(struct perf_limits *limits)
+static void intel_pstate_set_performance_limits(struct cpudata *cpu)
 {
-	limits->no_turbo = 0;
-	limits->turbo_disabled = 0;
-	limits->max_perf_pct = 100;
-	limits->max_perf = int_tofp(1);
-	limits->min_perf_pct = 100;
-	limits->min_perf = int_tofp(1);
-	limits->max_policy_pct = 100;
-	limits->max_sysfs_pct = 100;
-	limits->min_policy_pct = 0;
-	limits->min_sysfs_pct = 0;
+	cpu->max_perf = int_tofp(1);
+	cpu->min_perf = int_tofp(1);
+	cpu->max_policy_pct = 100;
+	cpu->min_policy_pct = 0;
+	cpu->max_perf_pct = 100;
+	cpu->min_perf_pct = 100;
 }
 
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
@@ -1471,7 +1588,7 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	pr_debug("set_policy cpuinfo.max %u policy->max %u\n",
 		 policy->cpuinfo.max_freq, policy->max);
 
-	cpu = all_cpu_data[0];
+	cpu = all_cpu_data[policy->cpu];
 	if (cpu->pstate.max_pstate_physical > cpu->pstate.max_pstate &&
 	    policy->max < policy->cpuinfo.max_freq &&
 	    policy->max > cpu->pstate.max_pstate * cpu->pstate.scaling) {
@@ -1481,9 +1598,10 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 
 	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		limits = &performance_limits;
-		if (policy->max >= policy->cpuinfo.max_freq) {
+		if (policy->max >= policy->cpuinfo.max_freq &&
+		    limits->max_sysfs_pct == 100) {
 			pr_debug("set performance\n");
-			intel_pstate_set_performance_limits(limits);
+			intel_pstate_set_performance_limits(cpu);
 			goto out;
 		}
 	} else {
@@ -1491,30 +1609,61 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 		limits = &powersave_limits;
 	}
 
-	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
-	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0 , 100);
-	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
+	mutex_lock(&perf_limits_lock);
+
+	cpu->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
 					      policy->cpuinfo.max_freq);
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
-
-	limits->min_perf = div_fp(limits->min_perf_pct, 100);
-	limits->max_perf = div_fp(limits->max_perf_pct, 100);
-	limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
-
- out:
+	cpu->max_policy_pct = clamp_t(int, cpu->max_policy_pct, 0, 100);
+	/*
+	 * When policy->max and policy->min are same use the same policy
+	 * percentage. The max_policy_pct is rounded up but not min_perf_pct.
+	 * So when they are same, results in different percentage for max
+	 * and minimum. Since minimum is a conservative value for power,
+	 * a lower value without rounding is better in most of the cases
+	 * unless user wants policy->max = policy->min
+	 */
+	if (policy->max == policy->min) {
+		cpu->min_policy_pct = cpu->max_policy_pct;
+	} else {
+		cpu->min_policy_pct = (policy->min * 100) /
+						policy->cpuinfo.max_freq;
+		cpu->min_policy_pct = clamp_t(int, cpu->min_policy_pct, 0, 100);
+	}
+	/*
+	 * Adjust cpu->min_perf_pct:
+	 * It should be more or equal to global min_sysfs_pct
+	 * cpufreq core already has checks to check
+	 * policy->min > policy->max, so not checking that
+	 */
+	cpu->min_perf_pct = max(cpu->min_policy_pct, limits->min_sysfs_pct);
+
+	/*
+	 * Adjust cpu->max_perf_pct:
+	 * It should be less or equal to global max_sysfs_pct
+	 * cpufreq core already has checks to check
+	 * policy->max < policy->min, so not checking that
+	 */
+	cpu->max_perf_pct = min(cpu->max_policy_pct, limits->max_sysfs_pct);
+
+	cpu->min_perf = div_fp(cpu->min_perf_pct, 100);
+	cpu->max_perf = div_fp(cpu->max_perf_pct, 100);
+	cpu->max_perf = round_up(cpu->max_perf, FRAC_BITS);
+
+	/* Avoid resetting system max min percentages if there is no change */
+	if (cpu->max_perf != cpu->prev_max_perf ||
+	    cpu->min_perf != cpu->prev_min_perf)
+		invalidate_policy_perf_limits();
+
+	cpu->prev_max_perf = cpu->max_perf;
+	cpu->prev_min_perf = cpu->min_perf;
+
+	mutex_unlock(&perf_limits_lock);
+
+	pr_debug("cpu->min:%d, cpu->max:%d, limit->min:%d, limit->max:%d\n",
+		 cpu->min_perf_pct, cpu->max_perf_pct, limits->min_sysfs_pct,
+		 limits->max_sysfs_pct);
+
+out:
 	intel_pstate_set_update_util_hook(policy->cpu);
 
 	intel_pstate_hwp_set_policy(policy);
@@ -1540,6 +1689,10 @@ static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
 
 	pr_debug("CPU %d exiting\n", cpu_num);
 
+	mutex_lock(&perf_limits_lock);
+	invalidate_policy_perf_limits();
+	mutex_unlock(&perf_limits_lock);
+
 	intel_pstate_clear_update_util_hook(cpu_num);
 
 	if (hwp_active)
@@ -1559,7 +1712,7 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	cpu = all_cpu_data[policy->cpu];
 
-	if (limits->min_perf_pct == 100 && limits->max_perf_pct == 100)
+	if (cpu->min_perf_pct == 100 && cpu->max_perf_pct == 100)
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
 	else
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
-- 
2.7.4

