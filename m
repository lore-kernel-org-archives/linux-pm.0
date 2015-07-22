From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH] cpufreq: intel_pstate: Use ACPI perf configuration
Date: Tue, 21 Jul 2015 22:27:47 -0700
Message-ID: <1437542867-32559-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4170 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbbGVFaS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 22 Jul 2015 01:30:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com, khlebnikov@yandex-team.ru
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Use ACPI _PSS to limit the Intel P State turbo, max and min ratios. This driver
uses acpi processor perf lib calls to register performance. The following
logic is used to adjust Intel P state driver limits:
- If there is no turbo entry in _PSS, then disable Intel P state turbo and limit
to non turbo max
- If the non turbo max ratio is more than _PSS max non turbo value, then
set the max non turbo ratio to _PSS non turbo max
- If the min ratio is less than _PSS min then change the min ratio matching
_PSS min
- Scale the _PSS turbo frequency to max turbo frequency based on control value.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 115 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6414661..576aec0 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -33,6 +33,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/cpufeature.h>
 
+#include <acpi/processor.h>
+
 #define BYT_RATIOS		0x66a
 #define BYT_VIDS		0x66b
 #define BYT_TURBO_RATIOS	0x66c
@@ -110,6 +112,9 @@ struct cpudata {
 	u64	prev_aperf;
 	u64	prev_mperf;
 	struct sample sample;
+#if IS_ENABLED(CONFIG_ACPI)
+	struct acpi_processor_performance acpi_perf_data;
+#endif
 };
 
 static struct cpudata **all_cpu_data;
@@ -166,6 +171,109 @@ static struct perf_limits limits = {
 	.min_sysfs_pct = 0,
 };
 
+#if IS_ENABLED(CONFIG_ACPI)
+static int intel_pstate_init_perf_limits(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu;
+	int ret;
+	int min_perf;
+	bool turbo_absent = false;
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
+	pr_debug("CPU%u - ACPI _PSS perf data\n", policy->cpu);
+	for (i = 0; i < cpu->acpi_perf_data.state_count; i++)
+		pr_debug("     %cP%d: %d MHz, %d mW, 0x%x\n",
+			 (i == cpu->acpi_perf_data.state ? '*' : ' '), i,
+			 (u32) cpu->acpi_perf_data.states[i].core_frequency,
+			 (u32) cpu->acpi_perf_data.states[i].power,
+			 (u32) cpu->acpi_perf_data.states[i].control);
+
+	if (cpu->acpi_perf_data.state_count < 2)
+		return 0;
+
+	/* Check if there is a turbo freq in _PSS */
+	if ((cpu->acpi_perf_data.states[0].core_frequency % 2) == 0) {
+		pr_debug("no turbo range exists in _PSS\n");
+		limits.no_turbo = limits.turbo_disabled = 1;
+		cpu->pstate.turbo_pstate = cpu->pstate.max_pstate;
+		turbo_absent = true;
+	}
+
+	/* Check if the max non turbo p state < Intel P state max */
+	for (i = 0; i < cpu->acpi_perf_data.state_count; i++) {
+		if ((cpu->acpi_perf_data.states[i].core_frequency % 2) == 0) {
+			int perf_max_ctl =
+				cpu->acpi_perf_data.states[i].control >> 8;
+			if (cpu->pstate.max_pstate > perf_max_ctl)
+				cpu->pstate.max_pstate = perf_max_ctl;
+			break;
+		}
+	}
+
+	/* check If min perf > Intel P State min */
+	min_perf = cpu->acpi_perf_data.states[
+			cpu->acpi_perf_data.state_count - 1].control >> 8;
+	if (min_perf > cpu->pstate.min_pstate) {
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
+	pr_debug("Updated limits 0x%x 0x%x 0x %x\n", cpu->pstate.min_pstate,
+		 cpu->pstate.max_pstate, cpu->pstate.turbo_pstate);
+	pr_debug("policy max_freq=%d Mhz min_freq = %d MHz\n",
+		 policy->cpuinfo.max_freq, policy->cpuinfo.min_freq);
+
+	return 0;
+}
+
+static int intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu;
+
+	cpu = all_cpu_data[policy->cpu];
+	acpi_processor_unregister_performance(&cpu->acpi_perf_data,
+						      policy->cpu);
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
@@ -1033,18 +1141,25 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	policy->cpuinfo.max_freq =
 		cpu->pstate.turbo_pstate * cpu->pstate.scaling;
+	intel_pstate_init_perf_limits(policy);
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
-- 
2.1.4

