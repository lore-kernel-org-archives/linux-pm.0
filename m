From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: intel_pstate: One set of global limits in active mode
Date: Thu, 16 Mar 2017 13:25:12 +0100
Message-ID: <6156083.Tk2Q3PH0av@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51211 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752187AbdCPMak (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2017 08:30:40 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In the active mode intel_pstate currently uses two sets of global
limits, each associated with one of the possible scaling_governor
settings in that mode: "powersave" or "performance".

The driver switches over from one of those sets to the other
depending on the scaling_governor setting for the last CPU whose
per-policy cpufreq interface in sysfs was last used to change
parameters exposed in there.  That obviously leads to no end of
issues when the scaling_governor settings differ between CPUs.

The most recent issue was introduced by commit a240c4aa5d0f (cpufreq:
intel_pstate: Do not reinit performance limits in ->setpolicy)
that eliminated the reinitialization of "performance" limits in
intel_pstate_set_policy() preventing the max limit from being set
to anything below 100, among other things.

Namely, an undesirable side effect of commit a240c4aa5d0f is that
now, after setting scaling_governor to "performance" in the active
mode, the per-policy limits for the CPU in question go to the highest
level and stay there even when it is switched back to "powersave"
later.

As it turns out, some distributions set scaling_governor to
"performance" temporarily for all CPUs to speed-up system
initialization, so that change causes them to misbehave later.

To fix that, get rid of the performance/powersave global limits
split and use just one set of global limits for everything.

>From the user's persepctive, after this modification, when
scaling_governor is switched from "performance" to "powersave"
or the other way around on one CPU, the limits settings (ie. the
global max/min_perf_pct and per-policy scaling_max/min_freq for
any CPUs) will not change.  Still, switching from "performance"
to "powersave" or the other way around changes the way in which
P-states are selected and in particular "performance" causes the
driver to always request the highest P-state it is allowed to ask
for for the given CPU.

Fixes: a240c4aa5d0f (cpufreq: intel_pstate: Do not reinit performance limits in ->setpolicy)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This replaces https://patchwork.kernel.org/patch/9623739/ .

It has been in bleeding-edge for a while tentatively.

Thanks,
Rafael

---
 drivers/cpufreq/intel_pstate.c |  135 ++++++++++++-----------------------------
 1 file changed, 41 insertions(+), 94 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -364,9 +364,7 @@ static bool driver_registered __read_mos
 static bool acpi_ppc;
 #endif
 
-static struct perf_limits performance_limits;
-static struct perf_limits powersave_limits;
-static struct perf_limits *limits;
+static struct perf_limits global;
 
 static void intel_pstate_init_limits(struct perf_limits *limits)
 {
@@ -377,14 +375,6 @@ static void intel_pstate_init_limits(str
 	limits->max_sysfs_pct = 100;
 }
 
-static void intel_pstate_set_performance_limits(struct perf_limits *limits)
-{
-	intel_pstate_init_limits(limits);
-	limits->min_perf_pct = 100;
-	limits->min_perf = int_ext_tofp(1);
-	limits->min_sysfs_pct = 100;
-}
-
 static DEFINE_MUTEX(intel_pstate_driver_lock);
 static DEFINE_MUTEX(intel_pstate_limits_lock);
 
@@ -507,7 +497,7 @@ static void intel_pstate_init_acpi_perf_
 	 * correct max turbo frequency based on the turbo state.
 	 * Also need to convert to MHz as _PSS freq is in MHz.
 	 */
-	if (!limits->turbo_disabled)
+	if (!global.turbo_disabled)
 		cpu->acpi_perf_data.states[0].core_frequency =
 					policy->cpuinfo.max_freq / 1000;
 	cpu->valid_pss_table = true;
@@ -626,7 +616,7 @@ static inline void update_turbo_state(vo
 
 	cpu = all_cpu_data[0];
 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
-	limits->turbo_disabled =
+	global.turbo_disabled =
 		(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE ||
 		 cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
 }
@@ -851,7 +841,7 @@ static struct freq_attr *hwp_cpufreq_att
 static void intel_pstate_hwp_set(struct cpufreq_policy *policy)
 {
 	int min, hw_min, max, hw_max, cpu;
-	struct perf_limits *perf_limits = limits;
+	struct perf_limits *perf_limits = &global;
 	u64 value, cap;
 
 	for_each_cpu(cpu, policy->cpus) {
@@ -863,7 +853,7 @@ static void intel_pstate_hwp_set(struct
 
 		rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
 		hw_min = HWP_LOWEST_PERF(cap);
-		if (limits->no_turbo)
+		if (global.no_turbo)
 			hw_max = HWP_GUARANTEED_PERF(cap);
 		else
 			hw_max = HWP_HIGHEST_PERF(cap);
@@ -957,20 +947,11 @@ static int intel_pstate_resume(struct cp
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
@@ -1049,7 +1030,7 @@ static void intel_pstate_debug_hide_para
 	static ssize_t show_##file_name					\
 	(struct kobject *kobj, struct attribute *attr, char *buf)	\
 	{								\
-		return sprintf(buf, "%u\n", limits->object);		\
+		return sprintf(buf, "%u\n", global.object);		\
 	}
 
 static ssize_t intel_pstate_show_status(char *buf);
@@ -1140,10 +1121,10 @@ static ssize_t show_no_turbo(struct kobj
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
 
@@ -1170,19 +1151,19 @@ static ssize_t store_no_turbo(struct kob
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
@@ -1207,19 +1188,16 @@ static ssize_t store_max_perf_pct(struct
 
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
+	global.max_sysfs_pct = clamp_t(int, input, 0 , 100);
+	global.max_perf_pct = min(global.max_policy_pct, global.max_sysfs_pct);
+	global.max_perf_pct = max(global.min_policy_pct, global.max_perf_pct);
+	global.max_perf_pct = max(global.min_perf_pct, global.max_perf_pct);
+	global.max_perf = percent_ext_fp(global.max_perf_pct);
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
+	intel_pstate_update_policies();
+
 	mutex_unlock(&intel_pstate_driver_lock);
 
 	return count;
@@ -1244,19 +1222,16 @@ static ssize_t store_min_perf_pct(struct
 
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
+	global.min_sysfs_pct = clamp_t(int, input, 0 , 100);
+	global.min_perf_pct = max(global.min_policy_pct, global.min_sysfs_pct);
+	global.min_perf_pct = min(global.max_policy_pct, global.min_perf_pct);
+	global.min_perf_pct = min(global.max_perf_pct, global.min_perf_pct);
+	global.min_perf = percent_ext_fp(global.min_perf_pct);
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
+	intel_pstate_update_policies();
+
 	mutex_unlock(&intel_pstate_driver_lock);
 
 	return count;
@@ -1376,7 +1351,7 @@ static u64 atom_get_val(struct cpudata *
 	u32 vid;
 
 	val = (u64)pstate << 8;
-	if (limits->no_turbo && !limits->turbo_disabled)
+	if (global.no_turbo && !global.turbo_disabled)
 		val |= (u64)1 << 32;
 
 	vid_fp = cpudata->vid.min + mul_fp(
@@ -1546,7 +1521,7 @@ static u64 core_get_val(struct cpudata *
 	u64 val;
 
 	val = (u64)pstate << 8;
-	if (limits->no_turbo && !limits->turbo_disabled)
+	if (global.no_turbo && !global.turbo_disabled)
 		val |= (u64)1 << 32;
 
 	return val;
@@ -1672,9 +1647,9 @@ static void intel_pstate_get_min_max(str
 	int max_perf = cpu->pstate.turbo_pstate;
 	int max_perf_adj;
 	int min_perf;
-	struct perf_limits *perf_limits = limits;
+	struct perf_limits *perf_limits = &global;
 
-	if (limits->no_turbo || limits->turbo_disabled)
+	if (global.no_turbo || global.turbo_disabled)
 		max_perf = cpu->pstate.max_pstate;
 
 	if (per_cpu_limits)
@@ -1809,7 +1784,7 @@ static inline int32_t get_target_pstate_
 
 	sample->busy_scaled = busy_frac * 100;
 
-	target = limits->no_turbo || limits->turbo_disabled ?
+	target = global.no_turbo || global.turbo_disabled ?
 			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
 	target += target >> 2;
 	target = mul_fp(target, busy_frac);
@@ -2105,7 +2080,7 @@ static void intel_pstate_update_perf_lim
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu;
-	struct perf_limits *perf_limits = NULL;
+	struct perf_limits *perf_limits = &global;
 
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
@@ -2128,21 +2103,6 @@ static int intel_pstate_set_policy(struc
 
 	mutex_lock(&intel_pstate_limits_lock);
 
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
 	intel_pstate_update_perf_limits(policy, perf_limits);
 
 	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE) {
@@ -2167,16 +2127,9 @@ static int intel_pstate_set_policy(struc
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
 
@@ -2191,9 +2144,9 @@ static int intel_pstate_verify_policy(st
 		unsigned int max_freq, min_freq;
 
 		max_freq = policy->cpuinfo.max_freq *
-					perf_limits->max_sysfs_pct / 100;
+					global.max_sysfs_pct / 100;
 		min_freq = policy->cpuinfo.max_freq *
-					perf_limits->min_sysfs_pct / 100;
+					global.min_sysfs_pct / 100;
 		cpufreq_verify_within_limits(policy, min_freq, max_freq);
 	}
 
@@ -2245,7 +2198,7 @@ static int __intel_pstate_cpu_init(struc
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	update_turbo_state();
-	policy->cpuinfo.max_freq = limits->turbo_disabled ?
+	policy->cpuinfo.max_freq = global.turbo_disabled ?
 			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
 	policy->cpuinfo.max_freq *= cpu->pstate.scaling;
 
@@ -2265,7 +2218,7 @@ static int intel_pstate_cpu_init(struct
 		return ret;
 
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-	if (limits->min_perf_pct == 100 && limits->max_perf_pct == 100)
+	if (IS_ENABLED(CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE))
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
 	else
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
@@ -2291,7 +2244,7 @@ static int intel_cpufreq_verify_policy(s
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 
 	update_turbo_state();
-	policy->cpuinfo.max_freq = limits->turbo_disabled ?
+	policy->cpuinfo.max_freq = global.turbo_disabled ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 
 	cpufreq_verify_within_cpu_limits(policy);
@@ -2307,7 +2260,7 @@ static unsigned int intel_cpufreq_turbo_
 
 	update_turbo_state();
 
-	max_freq = limits->no_turbo || limits->turbo_disabled ?
+	max_freq = global.no_turbo || global.turbo_disabled ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 	policy->cpuinfo.max_freq = max_freq;
 	if (policy->max > max_freq)
@@ -2415,13 +2368,7 @@ static int intel_pstate_register_driver(
 {
 	int ret;
 
-	intel_pstate_init_limits(&powersave_limits);
-	intel_pstate_set_performance_limits(&performance_limits);
-	if (IS_ENABLED(CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE) &&
-	    intel_pstate_driver == &intel_pstate)
-		limits = &performance_limits;
-	else
-		limits = &powersave_limits;
+	intel_pstate_init_limits(&global);
 
 	ret = cpufreq_register_driver(intel_pstate_driver);
 	if (ret) {
