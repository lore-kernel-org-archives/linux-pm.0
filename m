From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 1/3] cpufreq: intel_pstate: Enforce _PPC limits
Date: Wed, 27 Apr 2016 15:48:06 -0700
Message-ID: <1461797288-31573-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1461797288-31573-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52033 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbcD0WsF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Apr 2016 18:48:05 -0400
In-Reply-To: <1461797288-31573-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: khlebnikov@yandex-team.ru, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

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

This feature can be turned on by using kernel parameters:
intel_pstate=support_acpi_ppc

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/kernel-parameters.txt |   2 +
 drivers/cpufreq/Kconfig.x86         |   1 +
 drivers/cpufreq/intel_pstate.c      | 135 +++++++++++++++++++++++++++++++++++-
 3 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 0b3de80..4199a1b 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1661,6 +1661,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 		hwp_only
 			Only load intel_pstate on systems which support
 			hardware P state control (HWP) if available.
+		support_acpi_ppc
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
index 30fe323..fc37446 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -39,6 +39,10 @@
 #define ATOM_TURBO_RATIOS	0x66c
 #define ATOM_TURBO_VIDS		0x66d
 
+#ifdef CONFIG_ACPI
+#include <acpi/processor.h>
+#endif
+
 #define FRAC_BITS 8
 #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
 #define fp_toint(X) ((X) >> FRAC_BITS)
@@ -172,6 +176,8 @@ struct _pid {
  * @prev_cummulative_iowait: IO Wait time difference from last and
  *			current sample
  * @sample:		Storage for storing last Sample data
+ * @acpi_perf_data:	Stores ACPI perf information read from _PSS
+ * @valid_pss_table:	Set to true for valid ACPI _PSS entries found
  *
  * This structure stores per CPU instance data for all CPUs.
  */
@@ -190,6 +196,10 @@ struct cpudata {
 	u64	prev_tsc;
 	u64	prev_cummulative_iowait;
 	struct sample sample;
+#ifdef CONFIG_ACPI
+	struct acpi_processor_performance acpi_perf_data;
+	bool valid_pss_table;
+#endif
 };
 
 static struct cpudata **all_cpu_data;
@@ -258,6 +268,9 @@ static struct pstate_adjust_policy pid_params;
 static struct pstate_funcs pstate_funcs;
 static int hwp_active;
 
+#ifdef CONFIG_ACPI
+static bool acpi_ppc;
+#endif
 
 /**
  * struct perf_limits - Store user and policy limits
@@ -331,6 +344,110 @@ static struct perf_limits *limits = &performance_limits;
 static struct perf_limits *limits = &powersave_limits;
 #endif
 
+#ifdef CONFIG_ACPI
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
+static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu;
+	int turbo_pss_ctl;
+	int ret;
+	int i;
+
+	if (!acpi_ppc)
+		return;
+
+	cpu = all_cpu_data[policy->cpu];
+
+	ret = acpi_processor_register_performance(&cpu->acpi_perf_data,
+						  policy->cpu);
+	if (ret)
+		return;
+
+	/*
+	 * Check if the control value in _PSS is for PERF_CTL MSR, which should
+	 * guarantee that the states returned by it map to the states in our
+	 * list directly.
+	 */
+	if (cpu->acpi_perf_data.control_register.space_id !=
+						ACPI_ADR_SPACE_FIXED_HARDWARE)
+		goto err_unreg_perf;
+
+	/*
+	 * If there is only one entry _PSS, simply ignore _PSS and continue as
+	 * usual without taking _PSS into account
+	 */
+	if (cpu->acpi_perf_data.state_count < 2)
+		goto err_unreg_perf;
+
+	pr_debug("CPU%u - ACPI _PSS perf data\n", policy->cpu);
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
+	 * frequency. So correct this frequency in _PSS table to
+	 * correct max turbo frequency based on the turbo ratio.
+	 * Also need to convert to MHz as _PSS freq is in MHz.
+	 */
+	turbo_pss_ctl = convert_to_native_pstate_format(cpu, 0);
+	if (turbo_pss_ctl > cpu->pstate.max_pstate)
+		cpu->acpi_perf_data.states[0].core_frequency =
+					policy->cpuinfo.max_freq / 1000;
+	cpu->valid_pss_table = true;
+	pr_info("_PPC limits will be enforced\n");
+
+	return;
+err_unreg_perf:
+	cpu->valid_pss_table = false;
+	acpi_processor_unregister_performance(policy->cpu);
+}
+
+static void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu;
+
+	cpu = all_cpu_data[policy->cpu];
+	if (!cpu->valid_pss_table)
+		return;
+
+	acpi_processor_unregister_performance(policy->cpu);
+}
+
+#else
+static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
+{
+}
+
+static void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
+{
+}
+#endif
+
 static inline void pid_reset(struct _pid *pid, int setpoint, int busy,
 			     int deadband, int integral) {
 	pid->setpoint = int_tofp(setpoint);
@@ -1396,18 +1513,27 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	policy->cpuinfo.max_freq =
 		cpu->pstate.turbo_pstate * cpu->pstate.scaling;
+	intel_pstate_init_acpi_perf_limits(policy);
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	cpumask_set_cpu(policy->cpu, policy->cpus);
 
 	return 0;
 }
 
+static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
+{
+	intel_pstate_exit_perf_limits(policy);
+
+	return 0;
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
@@ -1451,8 +1577,7 @@ static void copy_cpu_funcs(struct pstate_funcs *funcs)
 
 }
 
-#if IS_ENABLED(CONFIG_ACPI)
-#include <acpi/processor.h>
+#ifdef CONFIG_ACPI
 
 static bool intel_pstate_no_acpi_pss(void)
 {
@@ -1658,6 +1783,12 @@ static int __init intel_pstate_setup(char *str)
 		force_load = 1;
 	if (!strcmp(str, "hwp_only"))
 		hwp_only = 1;
+
+#ifdef CONFIG_ACPI
+	if (!strcmp(str, "support_acpi_ppc"))
+		acpi_ppc = true;
+#endif
+
 	return 0;
 }
 early_param("intel_pstate", intel_pstate_setup);
-- 
2.5.5

