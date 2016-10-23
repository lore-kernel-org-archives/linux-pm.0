From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH] cpufreq: intel_pstate: Generic governors support
Date: Sun, 23 Oct 2016 02:17:13 +0200
Message-ID: <12441245.RjJfkIG2qy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62460 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S935093AbcJWAKP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Oct 2016 20:10:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There may be reasons to use generic cpufreq governors (eg. schedutil)
on Intel platforms instead of the intel_pstate driver's internal
governor.  However, that currently can only be done by disabling
intel_pstate altogether and using the acpi-cpufreq driver instead
of it, which is subject to limitations.

First of all, acpi-cpufreq only works on systems where the _PSS
object is present in the ACPI tables for all logical CPUs.  Second,
on those systems acpi-cpufreq will only use frequencies listed by
_PSS which may be suboptimal.  In particular, by convention, the
whole turbo range is represented in _PSS as a single P-state and
the frequency assigned to it is greater by 1 MHz than the greatest
non-turbo frequency listed by _PSS.  That may confuse governors to
use turbo frequencies less frequently which may lead to suboptimal
performance.

For this reason, make it possible to use the intel_pstate driver
with generic cpufreq governors as a "normal" cpufreq driver.  That
mode is enforced by adding intel_pstate=passive to the kernel
command line and cannot be disabled at run time.  In that mode,
intel_pstate provides a cpufreq driver interface including
the ->target() and ->fast_switch() callbacks and is listed in
scaling_driver as "intel_cpufreq".

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is all experimental at this point, although it has been tested with
various governors.  In any case, it will have to be rebased on top of
some fixes currently in the works, like

https://patchwork.kernel.org/patch/9389599/
https://patchwork.kernel.org/patch/9389597/

Technically, it is on top of

https://patchwork.kernel.org/patch/9383383/
https://patchwork.kernel.org/patch/9383387/

but it should apply without the two on top of 4.9-rc1 (or -rc2 when it's out).

This mostly is intended as a heads-up about what may be coming or in case
somebody wants to play with it and let me know about the impressions. :-)

Thanks,
Rafael

---
 Documentation/kernel-parameters.txt |    6 +
 drivers/cpufreq/intel_pstate.c      |  212 ++++++++++++++++++++++++++++--------
 2 files changed, 172 insertions(+), 46 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -122,6 +122,8 @@ struct sample {
  * @scaling:		Scaling factor to  convert frequency to cpufreq
  *			frequency units
  * @turbo_pstate:	Max Turbo P state possible for this platform
+ * @max_freq:		@max_pstate frequency in cpufreq units
+ * @turbo_freq:		@turbo_pstate frequency in cpufreq units
  *
  * Stores the per cpu model P state limits and current P state.
  */
@@ -132,6 +134,8 @@ struct pstate_data {
 	int	max_pstate_physical;
 	int	scaling;
 	int	turbo_pstate;
+	unsigned int max_freq;
+	unsigned int turbo_freq;
 };
 
 /**
@@ -459,7 +463,7 @@ static void intel_pstate_init_acpi_perf_
 {
 }
 
-static void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
+static inline int intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
 {
 }
 #endif
@@ -1171,6 +1175,8 @@ static void intel_pstate_get_cpu_pstates
 	cpu->pstate.max_pstate_physical = pstate_funcs.get_max_physical();
 	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
 	cpu->pstate.scaling = pstate_funcs.get_scaling();
+	cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
+	cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
 
 	if (pstate_funcs.get_vid)
 		pstate_funcs.get_vid(cpu);
@@ -1312,8 +1318,6 @@ static inline void intel_pstate_update_p
 {
 	int max_perf, min_perf;
 
-	update_turbo_state();
-
 	intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
 	pstate = clamp_t(int, pstate, min_perf, max_perf);
 	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
@@ -1333,6 +1337,8 @@ static inline void intel_pstate_adjust_b
 
 	target_pstate = pstate_funcs.get_target_pstate(cpu);
 
+	update_turbo_state();
+
 	intel_pstate_update_pstate(cpu, target_pstate);
 
 	sample = &cpu->sample;
@@ -1487,6 +1493,32 @@ static void intel_pstate_set_performance
 	limits->min_sysfs_pct = 0;
 }
 
+static void intel_pstate_adjust_limits(struct cpufreq_policy *policy)
+{
+	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
+	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0 , 100);
+	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
+					      policy->cpuinfo.max_freq);
+	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);
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
+}
+
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu;
@@ -1517,28 +1549,7 @@ static int intel_pstate_set_policy(struc
 		limits = &powersave_limits;
 	}
 
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
-
-	limits->min_perf = div_fp(limits->min_perf_pct, 100);
-	limits->max_perf = div_fp(limits->max_perf_pct, 100);
-	limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
+	intel_pstate_adjust_limits(policy);
 
  out:
 	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
@@ -1568,22 +1579,21 @@ static int intel_pstate_verify_policy(st
 	return 0;
 }
 
-static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
+static void intel_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 {
-	int cpu_num = policy->cpu;
-	struct cpudata *cpu = all_cpu_data[cpu_num];
-
-	pr_debug("CPU %d exiting\n", cpu_num);
-
-	intel_pstate_clear_update_util_hook(cpu_num);
+	intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
+}
 
-	if (hwp_active)
-		return;
+static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
+{
+	pr_debug("CPU %d exiting\n", policy->cpu);
 
-	intel_pstate_set_min_pstate(cpu);
+	intel_pstate_clear_update_util_hook(policy->cpu);
+	if (!hwp_active)
+		intel_cpufreq_stop_cpu(policy);
 }
 
-static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
+static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu;
 	int rc;
@@ -1594,11 +1604,6 @@ static int intel_pstate_cpu_init(struct
 
 	cpu = all_cpu_data[policy->cpu];
 
-	if (limits->min_perf_pct == 100 && limits->max_perf_pct == 100)
-		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
-	else
-		policy->policy = CPUFREQ_POLICY_POWERSAVE;
-
 	policy->min = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	policy->max = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
 
@@ -1610,9 +1615,11 @@ static int intel_pstate_cpu_init(struct
 	policy->cpuinfo.max_freq *= cpu->pstate.scaling;
 
 	intel_pstate_init_acpi_perf_limits(policy);
-	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+	policy->cpuinfo.transition_latency = 20000;
 	cpumask_set_cpu(policy->cpu, policy->cpus);
 
+	policy->fast_switch_possible = true;
+
 	return 0;
 }
 
@@ -1620,10 +1627,27 @@ static int intel_pstate_cpu_exit(struct
 {
 	intel_pstate_exit_perf_limits(policy);
 
+	policy->fast_switch_possible = false;
+
 	return 0;
 }
 
-static struct cpufreq_driver intel_pstate_driver = {
+static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
+{
+	int ret = intel_cpufreq_cpu_init(policy);
+
+	if (ret)
+		return ret;
+
+	if (limits->min_perf_pct == 100 && limits->max_perf_pct == 100)
+		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
+	else
+		policy->policy = CPUFREQ_POLICY_POWERSAVE;
+
+	return 0;
+}
+
+static struct cpufreq_driver intel_pstate = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.verify		= intel_pstate_verify_policy,
 	.setpolicy	= intel_pstate_set_policy,
@@ -1635,6 +1659,95 @@ static struct cpufreq_driver intel_pstat
 	.name		= "intel_pstate",
 };
 
+static int intel_cpufreq_verify_policy(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+
+	update_turbo_state();
+	policy->cpuinfo.max_freq = limits->turbo_disabled ?
+			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
+
+	cpufreq_verify_within_cpu_limits(policy);
+
+	intel_pstate_adjust_limits(policy);
+
+	return 0;
+}
+
+static unsigned int intel_cpufreq_turbo_update(struct cpudata *cpu,
+					       struct cpufreq_policy *policy,
+					       unsigned int target_freq)
+{
+	unsigned int max_freq;
+
+	update_turbo_state();
+
+	max_freq = limits->no_turbo || limits->turbo_disabled ?
+			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
+	policy->cpuinfo.max_freq = max_freq;
+	if (policy->max > max_freq)
+		policy->max = max_freq;
+
+	if (target_freq > max_freq)
+		target_freq = max_freq;
+
+	return target_freq;
+}
+
+static int intel_cpufreq_target(struct cpufreq_policy *policy,
+				unsigned int target_freq,
+				unsigned int relation)
+{
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+	struct cpufreq_freqs freqs;
+	int target_pstate;
+
+	freqs.old = policy->cur;
+	freqs.new = intel_cpufreq_turbo_update(cpu, policy, target_freq);
+
+	cpufreq_freq_transition_begin(policy, &freqs);
+	switch (relation) {
+	case CPUFREQ_RELATION_L:
+		target_pstate = DIV_ROUND_UP(freqs.new, cpu->pstate.scaling);
+		break;
+	case CPUFREQ_RELATION_H:
+		target_pstate = freqs.new / cpu->pstate.scaling;
+		break;
+	default:
+		target_pstate = DIV_ROUND_CLOSEST(freqs.new, cpu->pstate.scaling);
+		break;
+	}
+	intel_pstate_update_pstate(cpu, target_pstate);
+	cpufreq_freq_transition_end(policy, &freqs, false);
+
+	return 0;
+}
+
+static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
+					      unsigned int target_freq)
+{
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+	int target_pstate;
+
+	target_freq = intel_cpufreq_turbo_update(cpu, policy, target_freq);
+	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
+	intel_pstate_update_pstate(cpu, target_pstate);
+	return target_freq;
+}
+
+static struct cpufreq_driver intel_cpufreq = {
+	.flags		= CPUFREQ_CONST_LOOPS,
+	.verify		= intel_cpufreq_verify_policy,
+	.target		= intel_cpufreq_target,
+	.fast_switch	= intel_cpufreq_fast_switch,
+	.init		= intel_cpufreq_cpu_init,
+	.exit		= intel_pstate_cpu_exit,
+	.stop_cpu	= intel_cpufreq_stop_cpu,
+	.name		= "intel_cpufreq",
+};
+
+static struct cpufreq_driver *intel_pstate_driver = &intel_pstate;
+
 static int no_load __initdata;
 static int no_hwp __initdata;
 static int hwp_only __initdata;
@@ -1839,7 +1952,7 @@ hwp_cpu_matched:
 	if (!hwp_active && hwp_only)
 		goto out;
 
-	rc = cpufreq_register_driver(&intel_pstate_driver);
+	rc = cpufreq_register_driver(intel_pstate_driver);
 	if (rc)
 		goto out;
 
@@ -1854,7 +1967,9 @@ out:
 	get_online_cpus();
 	for_each_online_cpu(cpu) {
 		if (all_cpu_data[cpu]) {
-			intel_pstate_clear_update_util_hook(cpu);
+			if (intel_pstate_driver == &intel_pstate)
+				intel_pstate_clear_update_util_hook(cpu);
+
 			kfree(all_cpu_data[cpu]);
 		}
 	}
@@ -1870,8 +1985,13 @@ static int __init intel_pstate_setup(cha
 	if (!str)
 		return -EINVAL;
 
-	if (!strcmp(str, "disable"))
+	if (!strcmp(str, "disable")) {
 		no_load = 1;
+	} else if (!strcmp(str, "passive")) {
+		pr_info("Passive mode enabled\n");
+		intel_pstate_driver = &intel_cpufreq;
+		no_hwp = 1;
+	}
 	if (!strcmp(str, "no_hwp")) {
 		pr_info("HWP disabled\n");
 		no_hwp = 1;
Index: linux-pm/Documentation/kernel-parameters.txt
===================================================================
--- linux-pm.orig/Documentation/kernel-parameters.txt
+++ linux-pm/Documentation/kernel-parameters.txt
@@ -1694,6 +1694,12 @@ bytes respectively. Such letter suffixes
 		       disable
 		         Do not enable intel_pstate as the default
 		         scaling driver for the supported processors
+		       passive
+			 Use intel_pstate as a scaling driver, but configure it
+			 to work with generic cpufreq governors (instead of
+			 enabling its internal governor).  This mode cannot be
+			 used along with the hardware-managed P-states (HWP)
+			 feature.
 		       force
 			 Enable intel_pstate on systems that prohibit it by default
 			 in favor of acpi-cpufreq. Forcing the intel_pstate driver

