From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 11/14] cpufreq: intel_pstate: Add update_util callback to pstate_funcs
Date: Sun, 12 Mar 2017 18:22:18 +0100
Message-ID: <2375635.BphC3bWpT1@aspire.rjw.lan>
References: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57414 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934583AbdCLRci (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Mar 2017 13:32:38 -0400
In-Reply-To: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Avoid using extra function pointers during P-state selection by
dropping the get_target_pstate member from struct pstate_funcs,
adding a new update_util callback to it (to be registered with
the CPU scheduler as the utilization update callback in the active
mode) and reworking the utilization update callback routines to
invoke specific P-state selection functions directly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   79 +++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 37 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -332,7 +332,7 @@ struct pstate_adjust_policy {
  * @get_scaling:	Callback to get frequency scaling factor
  * @get_val:		Callback to convert P state to actual MSR write value
  * @get_vid:		Callback to get VID data for Atom platforms
- * @get_target_pstate:	Callback to a function to calculate next P state to use
+ * @update_util:	Active mode utilization update callback.
  *
  * Core and Atom CPU models have different way to get P State limits. This
  * structure is used to store those callbacks.
@@ -345,7 +345,8 @@ struct pstate_funcs {
 	int (*get_scaling)(void);
 	u64 (*get_val)(struct cpudata*, int pstate);
 	void (*get_vid)(struct cpudata *);
-	int32_t (*get_target_pstate)(struct cpudata *);
+	void (*update_util)(struct update_util_data *data, u64 time,
+			    unsigned int flags);
 };
 
 /**
@@ -356,9 +357,6 @@ struct cpu_defaults {
 	struct pstate_funcs funcs;
 };
 
-static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu);
-static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu);
-
 static struct pstate_funcs pstate_funcs __read_mostly;
 static struct pstate_adjust_policy pid_params __read_mostly = {
 	.sample_rate_ms = 10,
@@ -1562,6 +1560,11 @@ static int knl_get_turbo_pstate(void)
 	return ret;
 }
 
+static void intel_pstate_update_util_pid(struct update_util_data *data,
+					 u64 time, unsigned int flags);
+static void intel_pstate_update_util(struct update_util_data *data, u64 time,
+				     unsigned int flags);
+
 static struct cpu_defaults core_params = {
 	.funcs = {
 		.get_max = core_get_max_pstate,
@@ -1570,7 +1573,7 @@ static struct cpu_defaults core_params =
 		.get_turbo = core_get_turbo_pstate,
 		.get_scaling = core_get_scaling,
 		.get_val = core_get_val,
-		.get_target_pstate = get_target_pstate_use_performance,
+		.update_util = intel_pstate_update_util_pid,
 	},
 };
 
@@ -1583,7 +1586,7 @@ static const struct cpu_defaults silverm
 		.get_val = atom_get_val,
 		.get_scaling = silvermont_get_scaling,
 		.get_vid = atom_get_vid,
-		.get_target_pstate = get_target_pstate_use_cpu_load,
+		.update_util = intel_pstate_update_util,
 	},
 };
 
@@ -1596,7 +1599,7 @@ static const struct cpu_defaults airmont
 		.get_val = atom_get_val,
 		.get_scaling = airmont_get_scaling,
 		.get_vid = atom_get_vid,
-		.get_target_pstate = get_target_pstate_use_cpu_load,
+		.update_util = intel_pstate_update_util,
 	},
 };
 
@@ -1608,7 +1611,7 @@ static const struct cpu_defaults knl_par
 		.get_turbo = knl_get_turbo_pstate,
 		.get_scaling = core_get_scaling,
 		.get_val = core_get_val,
-		.get_target_pstate = get_target_pstate_use_performance,
+		.update_util = intel_pstate_update_util_pid,
 	},
 };
 
@@ -1620,7 +1623,7 @@ static const struct cpu_defaults bxt_par
 		.get_turbo = core_get_turbo_pstate,
 		.get_scaling = core_get_scaling,
 		.get_val = core_get_val,
-		.get_target_pstate = get_target_pstate_use_cpu_load,
+		.update_util = intel_pstate_update_util,
 	},
 };
 
@@ -1760,6 +1763,9 @@ static inline int32_t get_target_pstate_
 	int32_t busy_frac, boost;
 	int target, avg_pstate;
 
+	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE)
+		return cpu->pstate.turbo_pstate;
+
 	busy_frac = div_fp(sample->mperf, sample->tsc);
 
 	boost = cpu->iowait_boost;
@@ -1796,6 +1802,9 @@ static inline int32_t get_target_pstate_
 	int32_t perf_scaled, max_pstate, current_pstate, sample_ratio;
 	u64 duration_ns;
 
+	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE)
+		return cpu->pstate.turbo_pstate;
+
 	/*
 	 * perf_scaled is the ratio of the average P-state during the last
 	 * sampling period to the P-state requested last time (in percent).
@@ -1846,16 +1855,11 @@ static void intel_pstate_update_pstate(s
 	wrmsrl(MSR_IA32_PERF_CTL, pstate_funcs.get_val(cpu, pstate));
 }
 
-static void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
+static void intel_pstate_adjust_pstate(struct cpudata *cpu, int target_pstate)
 {
-	int from, target_pstate;
+	int from = cpu->pstate.current_pstate;
 	struct sample *sample;
 
-	from = cpu->pstate.current_pstate;
-
-	target_pstate = cpu->policy == CPUFREQ_POLICY_PERFORMANCE ?
-		cpu->pstate.turbo_pstate : pstate_funcs.get_target_pstate(cpu);
-
 	update_turbo_state();
 
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
@@ -1893,8 +1897,12 @@ static void intel_pstate_update_util_pid
 	if ((s64)delta_ns < pid_params.sample_rate_ns)
 		return;
 
-	if (intel_pstate_sample(cpu, time))
-		intel_pstate_adjust_busy_pstate(cpu);
+	if (intel_pstate_sample(cpu, time)) {
+		int target_pstate;
+
+		target_pstate = get_target_pstate_use_performance(cpu);
+		intel_pstate_adjust_pstate(cpu, target_pstate);
+	}
 }
 
 static void intel_pstate_update_util(struct update_util_data *data, u64 time,
@@ -1916,13 +1924,13 @@ static void intel_pstate_update_util(str
 	if ((s64)delta_ns < INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL)
 		return;
 
-	if (intel_pstate_sample(cpu, time))
-		intel_pstate_adjust_busy_pstate(cpu);
-}
+	if (intel_pstate_sample(cpu, time)) {
+		int target_pstate;
 
-/* Utilization update callback to register in the active mode. */
-static void (*update_util_cb)(struct update_util_data *data, u64 time,
-			      unsigned int flags) = intel_pstate_update_util;
+		target_pstate = get_target_pstate_use_cpu_load(cpu);
+		intel_pstate_adjust_pstate(cpu, target_pstate);
+	}
+}
 
 #define ICPU(model, policy) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF,\
@@ -2001,7 +2009,7 @@ static int intel_pstate_init_cpu(unsigne
 			intel_pstate_disable_ee(cpunum);
 
 		intel_pstate_hwp_enable(cpu);
-	} else if (pstate_funcs.get_target_pstate == get_target_pstate_use_performance) {
+	} else if (pstate_funcs.update_util == intel_pstate_update_util_pid) {
 		intel_pstate_pid_reset(cpu);
 	}
 
@@ -2028,7 +2036,8 @@ static void intel_pstate_set_update_util
 
 	/* Prevent intel_pstate_update_util() from using stale data. */
 	cpu->sample.time = 0;
-	cpufreq_add_update_util_hook(cpu_num, &cpu->update_util, update_util_cb);
+	cpufreq_add_update_util_hook(cpu_num, &cpu->update_util,
+				     pstate_funcs.update_util);
 	cpu->update_util_set = true;
 }
 
@@ -2412,7 +2421,7 @@ static int intel_pstate_register_driver(
 	}
 
 	if (intel_pstate_driver == &intel_pstate && !hwp_active &&
-	    pstate_funcs.get_target_pstate != get_target_pstate_use_cpu_load)
+	    pstate_funcs.update_util == intel_pstate_update_util_pid)
 		intel_pstate_debug_expose_params();
 
 	return 0;
@@ -2423,8 +2432,8 @@ static int intel_pstate_unregister_drive
 	if (hwp_active)
 		return -EBUSY;
 
-	if (intel_pstate_driver == &intel_pstate && !hwp_active &&
-	    pstate_funcs.get_target_pstate != get_target_pstate_use_cpu_load)
+	if (intel_pstate_driver == &intel_pstate &&
+	    pstate_funcs.update_util == intel_pstate_update_util_pid)
 		intel_pstate_debug_hide_params();
 
 	cpufreq_unregister_driver(intel_pstate_driver);
@@ -2498,8 +2507,7 @@ static int __init intel_pstate_msrs_not_
 static void intel_pstate_use_acpi_profile(void)
 {
 	if (acpi_gbl_FADT.preferred_profile == PM_MOBILE)
-		pstate_funcs.get_target_pstate =
-				get_target_pstate_use_cpu_load;
+		pstate_funcs.update_util = intel_pstate_update_util;
 }
 #else
 static void intel_pstate_use_acpi_profile(void)
@@ -2516,12 +2524,9 @@ static void __init copy_cpu_funcs(struct
 	pstate_funcs.get_scaling = funcs->get_scaling;
 	pstate_funcs.get_val   = funcs->get_val;
 	pstate_funcs.get_vid   = funcs->get_vid;
-	pstate_funcs.get_target_pstate = funcs->get_target_pstate;
+	pstate_funcs.update_util = funcs->update_util;
 
 	intel_pstate_use_acpi_profile();
-
-	if (pstate_funcs.get_target_pstate == get_target_pstate_use_performance)
-		update_util_cb = intel_pstate_update_util_pid;
 }
 
 #ifdef CONFIG_ACPI
@@ -2667,9 +2672,9 @@ static int __init intel_pstate_init(void
 
 	if (x86_match_cpu(hwp_support_ids) && !no_hwp) {
 		copy_cpu_funcs(&core_params.funcs);
+		pstate_funcs.update_util = intel_pstate_update_util_hwp;
 		hwp_active++;
 		intel_pstate.attr = hwp_cpufreq_attrs;
-		update_util_cb = intel_pstate_update_util_hwp;
 		goto hwp_cpu_matched;
 	}
 
