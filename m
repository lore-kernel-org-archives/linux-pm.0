From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Enforce _PPC limits
Date: Mon,  4 Apr 2016 16:22:30 -0700
Message-ID: <1459812150-9111-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:10525 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbcDDXWB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 Apr 2016 19:22:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Use ACPI _PPC notification to limit max P state driver will request.
ACPI _PPC change notification is sent by BIOS to limit max P state
in several cases:
- Reduce impact of platform thermal condition
- When Config TDP feature is used, a changed _PPC is sent to
follow TDP change
- Remote node managers in server want to control platform power
via baseboard management controller (BMC)

This change registers with ACPI processor performance lib so that
_PPC changes are notified to cpufreq core, which in turns will
result in call to .setpolicy() callback. Also the way _PSS
table identifies a turbo frequency is not compatible to max turbo
frequency in intel_pstate, so the very first entry in _PSS needs
to be adjusted.

When config TDP feature is on the turbo activation ratio can be less than
max physical non turbo P state. In this case _PPC is set to turbo
activation ratio + 1. In this case we don't need to treat this as the
reduced frequency in set_policy callback, as this is still in the turbo
range. So we set the policy->max to actual policy->cpuinfo.max_freq.
It avoid showing reduced P States max_perf_pct in intel P state sysfs,
when the _PPC is still in turbo range.

This feature can be turned on by using kernel parameters:
intel_pstate=acpi_ppc

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/kernel-parameters.txt |   2 +
 drivers/cpufreq/Kconfig.x86         |   1 +
 drivers/cpufreq/intel_pstate.c      | 161 +++++++++++++++++++++++++++++++++++-
 3 files changed, 162 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index ecc74fa..b7714bf 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1661,6 +1661,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 		hwp_only
 			Only load intel_pstate on systems which support
 			hardware P state control (HWP) if available.
+		acpi_ppc
+			Enforce ACPI _PPC performance limits.
 
 	intremap=	[X86-64, Intel-IOMMU]
 			on	enable Interrupt Remapping (default)
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index c59bdcb..adbd1de 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -5,6 +5,7 @@
 config X86_INTEL_PSTATE
        bool "Intel P state control"
        depends on X86
+       select ACPI_PROCESSOR if ACPI
        help
           This driver provides a P state for Intel core processors.
 	  The driver implements an internal governor and will become
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8b5a415..b10ea73 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -39,6 +39,10 @@
 #define ATOM_TURBO_RATIOS	0x66c
 #define ATOM_TURBO_VIDS		0x66d
 
+#if IS_ENABLED(CONFIG_ACPI)
+#include <acpi/processor.h>
+#endif
+
 #define FRAC_BITS 8
 #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
 #define fp_toint(X) ((X) >> FRAC_BITS)
@@ -190,6 +194,10 @@ struct cpudata {
 	u64	prev_tsc;
 	u64	prev_cummulative_iowait;
 	struct sample sample;
+#if IS_ENABLED(CONFIG_ACPI)
+	struct acpi_processor_performance acpi_perf_data;
+	bool valid_pss_table;
+#endif
 };
 
 static struct cpudata **all_cpu_data;
@@ -257,7 +265,7 @@ static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu);
 static struct pstate_adjust_policy pid_params;
 static struct pstate_funcs pstate_funcs;
 static int hwp_active;
-
+static int acpi_ppc;
 
 /**
  * struct perf_limits - Store user and policy limits
@@ -331,6 +339,117 @@ static struct perf_limits *limits = &performance_limits;
 static struct perf_limits *limits = &powersave_limits;
 #endif
 
+#if IS_ENABLED(CONFIG_ACPI)
+/*
+ * The max target pstate ratio is a 8 bit value in both PLATFORM_INFO MSR and
+ * in TURBO_RATIO_LIMIT MSR, which pstate driver stores in max_pstate and
+ * max_turbo_pstate fields. The PERF_CTL MSR contains 16 bit value for P state
+ * ratio, out of it only high 8 bits are used. For example 0x1700 is setting
+ * target ratio 0x17. The _PSS control value stores in a format which can be
+ * directly written to PERF_CTL MSR. But in intel_pstate driver this shift
+ * occurs during write to PERF_CTL (E.g. for cores core_set_pstate()).
+ * This function converts the _PSS control value to intel pstate driver format
+ * for comparison and assignment.
+ */
+static int convert_to_native_pstate_format(struct cpudata *cpu, int index)
+{
+	return cpu->acpi_perf_data.states[index].control >> 8;
+}
+
+static int intel_pstate_init_perf_limits(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu;
+	int turbo_pss_ctl;
+	int ret;
+	int i;
+
+	cpu = all_cpu_data[policy->cpu];
+
+	if (!cpu->acpi_perf_data.shared_cpu_map &&
+	    zalloc_cpumask_var_node(&cpu->acpi_perf_data.shared_cpu_map,
+				    GFP_KERNEL, cpu_to_node(policy->cpu))) {
+		return -ENOMEM;
+	}
+
+	ret = acpi_processor_register_performance(&cpu->acpi_perf_data,
+						  policy->cpu);
+	if (ret)
+		return ret;
+
+	/*
+	 * Check if the control value in _PSS is for PERF_CTL MSR, which should
+	 * guarantee that the states returned by it map to the states in our
+	 * list directly.
+	 */
+	if (cpu->acpi_perf_data.control_register.space_id !=
+						ACPI_ADR_SPACE_FIXED_HARDWARE)
+		goto unreg_perf;
+
+	/*
+	 * If there is only one entry _PSS, simply ignore _PSS and continue as
+	 * usual without taking _PSS into account
+	 */
+	if (cpu->acpi_perf_data.state_count < 2)
+		goto unreg_perf;
+
+	pr_debug("intel_pstate: CPU%u - ACPI _PSS perf data\n", policy->cpu);
+	for (i = 0; i < cpu->acpi_perf_data.state_count; i++) {
+		pr_debug("     %cP%d: %u MHz, %u mW, 0x%x\n",
+			 (i == cpu->acpi_perf_data.state ? '*' : ' '), i,
+			 (u32) cpu->acpi_perf_data.states[i].core_frequency,
+			 (u32) cpu->acpi_perf_data.states[i].power,
+			 (u32) cpu->acpi_perf_data.states[i].control);
+	}
+
+	/*
+	 * The _PSS table doesn't contain whole turbo frequency range.
+	 * This just contains +1 MHZ above the max non turbo frequency,
+	 * with control value corresponding to max turbo ratio. But
+	 * when cpufreq set policy is called, it will call with this
+	 * max frequency, which will cause a reduced performance as
+	 * this driver uses real max turbo frequency as the max
+	 * frequeny. So correct this frequency in _PSS table to
+	 * correct max turbo frequency based on the turbo ratio.
+	 * Also need to convert to MHz as _PSS freq is in MHz.
+	 */
+	turbo_pss_ctl = convert_to_native_pstate_format(cpu, 0);
+	if (turbo_pss_ctl > cpu->pstate.max_pstate)
+		cpu->acpi_perf_data.states[0].core_frequency =
+					policy->cpuinfo.max_freq / 1000;
+	cpu->valid_pss_table = true;
+	pr_info("intel_pstate: _PPC limits will be enforced\n");
+
+	return 0;
+unreg_perf:
+	cpu->valid_pss_table = false;
+	acpi_processor_unregister_performance(policy->cpu);
+	return -EINVAL;
+}
+
+static int intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu;
+
+	cpu = all_cpu_data[policy->cpu];
+	if (!acpi_ppc || !cpu->valid_pss_table)
+		return 0;
+
+	acpi_processor_unregister_performance(policy->cpu);
+	return 0;
+}
+
+#else
+static int intel_pstate_init_perf_limits(struct cpufreq_policy *policy)
+{
+	return 0;
+}
+
+static int intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
+{
+	return 0;
+}
+#endif
+
 static inline void pid_reset(struct _pid *pid, int setpoint, int busy,
 			     int deadband, int integral) {
 	pid->setpoint = int_tofp(setpoint);
@@ -1297,6 +1416,30 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 
 	intel_pstate_clear_update_util_hook(policy->cpu);
 
+	if (acpi_ppc) {
+		struct cpudata *cpu;
+
+		/*
+		 * If the platform has config TDP feature, then to indicate
+		 * start of turbo range _PPC is set to one more than the turbo
+		 * activation ratio, which is cpu->pstate.max_pstate. Here the
+		 * updated frequency corresponding to _PPC is reflected in
+		 * policy->max. This  means that this _PPC setting still
+		 * allowing system to reach policy->cpuinfo.max_freq anyway as
+		 * this is turbo range.
+		 * In this case showing restricted limits in intel_pstate
+		 * sysfs or setting limits->max_perf to a lower value has
+		 * no meaning.
+		 */
+		cpu = all_cpu_data[0];
+		if (policy->max < policy->cpuinfo.max_freq &&
+		    policy->max > (cpu->pstate.max_pstate *
+					cpu->pstate.scaling)) {
+			pr_info("intel_pstate: _PPC > Max non Turbo P_state\n");
+			policy->max = policy->cpuinfo.max_freq;
+		}
+	}
+
 	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		limits = &performance_limits;
 		if (policy->max >= policy->cpuinfo.max_freq) {
@@ -1392,18 +1535,30 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	policy->cpuinfo.max_freq =
 		cpu->pstate.turbo_pstate * cpu->pstate.scaling;
+	if (acpi_ppc)
+		intel_pstate_init_perf_limits(policy);
+	/*
+	 * If there is no acpi perf data or error, we ignore and use Intel P
+	 * state calculated limits, So this is not fatal error.
+	 */
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	cpumask_set_cpu(policy->cpu, policy->cpus);
 
 	return 0;
 }
 
+static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
+{
+	return intel_pstate_exit_perf_limits(policy);
+}
+
 static struct cpufreq_driver intel_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.verify		= intel_pstate_verify_policy,
 	.setpolicy	= intel_pstate_set_policy,
 	.get		= intel_pstate_get,
 	.init		= intel_pstate_cpu_init,
+	.exit		= intel_pstate_cpu_exit,
 	.stop_cpu	= intel_pstate_stop_cpu,
 	.name		= "intel_pstate",
 };
@@ -1448,7 +1603,6 @@ static void copy_cpu_funcs(struct pstate_funcs *funcs)
 }
 
 #if IS_ENABLED(CONFIG_ACPI)
-#include <acpi/processor.h>
 
 static bool intel_pstate_no_acpi_pss(void)
 {
@@ -1654,6 +1808,9 @@ static int __init intel_pstate_setup(char *str)
 		force_load = 1;
 	if (!strcmp(str, "hwp_only"))
 		hwp_only = 1;
+	if (!strcmp(str, "acpi_ppc"))
+		acpi_ppc = 1;
+
 	return 0;
 }
 early_param("intel_pstate", intel_pstate_setup);
-- 
2.4.3

