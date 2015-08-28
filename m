From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 4/6] cpufreq: intel_pstate: Use ACPI perf configuration
Date: Thu, 27 Aug 2015 18:34:24 -0700
Message-ID: <1440725666-3550-5-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1440725666-3550-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:17215 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbbH1Bfl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Aug 2015 21:35:41 -0400
In-Reply-To: <1440725666-3550-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Use ACPI _PSS to limit the Intel P State turbo, max and min ratios.
This driver uses acpi processor perf lib calls to register performance.
The following logic is used to adjust Intel P state driver limits:
- If there is no turbo entry in _PSS, then disable Intel P state turbo
and limit to non turbo max
- If the non turbo max ratio is more than _PSS max non turbo value, then
set the max non turbo ratio to _PSS non turbo max
- If the min ratio is less than _PSS min then change the min ratio
matching _PSS min
- Scale the _PSS turbo frequency to max turbo frequency based on control
value.
This feature can be disabled by using kernel parameters:
intel_pstate=no_acpi

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/Kconfig.x86    |   1 +
 drivers/cpufreq/intel_pstate.c | 139 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

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
index e92a59f..399c6e9 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -34,6 +34,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/cpufeature.h>
 
+#include <acpi/processor.h>
+
 #define BYT_RATIOS		0x66a
 #define BYT_VIDS		0x66b
 #define BYT_TURBO_RATIOS	0x66c
@@ -114,6 +116,9 @@ struct cpudata {
 	u64	prev_mperf;
 	u64	prev_tsc;
 	struct sample sample;
+#if IS_ENABLED(CONFIG_ACPI)
+	struct acpi_processor_performance acpi_perf_data;
+#endif
 };
 
 static struct cpudata **all_cpu_data;
@@ -146,6 +151,7 @@ struct cpu_defaults {
 static struct pstate_adjust_policy pid_params;
 static struct pstate_funcs pstate_funcs;
 static int hwp_active;
+static int no_acpi_perf;
 
 struct perf_limits {
 	int no_turbo;
@@ -173,6 +179,124 @@ static struct perf_limits limits = {
 	.min_sysfs_pct = 0,
 };
 
+#if IS_ENABLED(CONFIG_ACPI)
+static int intel_pstate_init_perf_limits(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu;
+	int ret;
+	int min_perf;
+	bool turbo_absent = false;
+	int max_pstate_index;
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
+	/* Check if the control value in _PSS is for PERF_CTL MSR */
+	if (cpu->acpi_perf_data.control_register.space_id !=
+						ACPI_ADR_SPACE_FIXED_HARDWARE)
+		return -EIO;
+
+	pr_debug("intel_pstate: CPU%u - ACPI _PSS perf data\n", policy->cpu);
+	for (i = 0; i < cpu->acpi_perf_data.state_count; i++)
+		pr_debug("     %cP%d: %u MHz, %u mW, 0x%x\n",
+			 (i == cpu->acpi_perf_data.state ? '*' : ' '), i,
+			 (u32) cpu->acpi_perf_data.states[i].core_frequency,
+			 (u32) cpu->acpi_perf_data.states[i].power,
+			 (u32) cpu->acpi_perf_data.states[i].control);
+
+	/*
+	 * If there is only one entry _PSS, simply ignore _PSS and continue as
+	 * usual without taking _PSS into account
+	 */
+	if (cpu->acpi_perf_data.state_count < 2)
+		return 0;
+
+	/* Check if there is a turbo freq in _PSS */
+	if ((cpu->acpi_perf_data.states[0].control >> 8) <=
+	    cpu->pstate.max_pstate) {
+		pr_debug("intel_pstate: no turbo range exists in _PSS\n");
+		limits.no_turbo = limits.turbo_disabled = 1;
+		cpu->pstate.turbo_pstate = cpu->pstate.max_pstate;
+		turbo_absent = true;
+	}
+
+	/* Check if the max non turbo p state < Intel P state max */
+	if (turbo_absent)
+		max_pstate_index = 0;
+	else
+		max_pstate_index = 1;
+	if ((cpu->acpi_perf_data.states[max_pstate_index].control >> 8) <
+	    cpu->pstate.max_pstate)
+		cpu->pstate.max_pstate =
+			cpu->acpi_perf_data.states[max_pstate_index].control;
+
+	/* check If min perf > Intel P State min */
+	min_perf = cpu->acpi_perf_data.states[
+			cpu->acpi_perf_data.state_count - 1].control >> 8;
+	if (min_perf > cpu->pstate.min_pstate &&
+	    min_perf < cpu->pstate.max_pstate) {
+		cpu->pstate.min_pstate = min_perf;
+		policy->cpuinfo.min_freq = cpu->pstate.min_pstate *
+						cpu->pstate.scaling;
+	}
+
+	if (turbo_absent)
+		policy->cpuinfo.max_freq =
+			cpu->pstate.max_pstate * cpu->pstate.scaling;
+	else {
+		policy->cpuinfo.max_freq =
+			cpu->pstate.turbo_pstate * cpu->pstate.scaling;
+		/* scale freq to intel pstate turbo scale */
+		cpu->acpi_perf_data.states[0].core_frequency =
+				cpu->pstate.scaling *
+				(cpu->acpi_perf_data.states[0].control >> 8);
+	}
+
+	pr_debug("intel_pstate: Updated limits 0x%x 0x%x 0x%x\n",
+		 cpu->pstate.min_pstate, cpu->pstate.max_pstate,
+		 cpu->pstate.turbo_pstate);
+	pr_debug("intel_pstate: policy max_freq=%d Khz min_freq = %d KHz\n",
+		 policy->cpuinfo.max_freq, policy->cpuinfo.min_freq);
+
+	return 0;
+}
+
+static int intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu;
+
+	if (!no_acpi_perf)
+		return 0;
+
+	cpu = all_cpu_data[policy->cpu];
+	acpi_processor_unregister_performance(&cpu->acpi_perf_data,
+					      policy->cpu);
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
 	pid->setpoint = setpoint;
@@ -1182,18 +1306,30 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	policy->cpuinfo.max_freq =
 		cpu->pstate.turbo_pstate * cpu->pstate.scaling;
+	if (!no_acpi_perf)
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
@@ -1425,6 +1561,9 @@ static int __init intel_pstate_setup(char *str)
 		force_load = 1;
 	if (!strcmp(str, "hwp_only"))
 		hwp_only = 1;
+	if (!strcmp(str, "no_acpi"))
+		no_acpi_perf = 1;
+
 	return 0;
 }
 early_param("intel_pstate", intel_pstate_setup);
-- 
2.4.3

