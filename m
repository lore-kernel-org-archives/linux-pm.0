From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 13/16] cpufreq: intel_pstate: Drop struct cpu_defaults
Date: Tue, 28 Mar 2017 00:19:03 +0200
Message-ID: <6146050.lfZtYTWz1b@aspire.rjw.lan>
References: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64757 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752743AbdC0Wnt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 18:43:49 -0400
In-Reply-To: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The cpu_defaults structure is redundant, because it only contains
one member of type struct pstate_funcs which can be used directly
instead of struct cpu_defaults.

For this reason, drop struct cpu_defaults, use struct pstate_funcs
directly instead of it where applicable and rename all of the
variables of that type accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |  170 ++++++++++++++++++-----------------------
 1 file changed, 75 insertions(+), 95 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -328,14 +328,6 @@ struct pstate_funcs {
 			    unsigned int flags);
 };
 
-/**
- * struct cpu_defaults- Per CPU model default config data
- * @funcs:		Callback function data
- */
-struct cpu_defaults {
-	struct pstate_funcs funcs;
-};
-
 static struct pstate_funcs pstate_funcs __read_mostly;
 static struct pstate_adjust_policy pid_params __read_mostly = {
 	.sample_rate_ms = 10,
@@ -1809,66 +1801,56 @@ static void intel_pstate_update_util(str
 	}
 }
 
-static struct cpu_defaults core_params = {
-	.funcs = {
-		.get_max = core_get_max_pstate,
-		.get_max_physical = core_get_max_pstate_physical,
-		.get_min = core_get_min_pstate,
-		.get_turbo = core_get_turbo_pstate,
-		.get_scaling = core_get_scaling,
-		.get_val = core_get_val,
-		.update_util = intel_pstate_update_util_pid,
-	},
-};
-
-static const struct cpu_defaults silvermont_params = {
-	.funcs = {
-		.get_max = atom_get_max_pstate,
-		.get_max_physical = atom_get_max_pstate,
-		.get_min = atom_get_min_pstate,
-		.get_turbo = atom_get_turbo_pstate,
-		.get_val = atom_get_val,
-		.get_scaling = silvermont_get_scaling,
-		.get_vid = atom_get_vid,
-		.update_util = intel_pstate_update_util,
-	},
-};
-
-static const struct cpu_defaults airmont_params = {
-	.funcs = {
-		.get_max = atom_get_max_pstate,
-		.get_max_physical = atom_get_max_pstate,
-		.get_min = atom_get_min_pstate,
-		.get_turbo = atom_get_turbo_pstate,
-		.get_val = atom_get_val,
-		.get_scaling = airmont_get_scaling,
-		.get_vid = atom_get_vid,
-		.update_util = intel_pstate_update_util,
-	},
-};
-
-static const struct cpu_defaults knl_params = {
-	.funcs = {
-		.get_max = core_get_max_pstate,
-		.get_max_physical = core_get_max_pstate_physical,
-		.get_min = core_get_min_pstate,
-		.get_turbo = knl_get_turbo_pstate,
-		.get_scaling = core_get_scaling,
-		.get_val = core_get_val,
-		.update_util = intel_pstate_update_util_pid,
-	},
-};
-
-static const struct cpu_defaults bxt_params = {
-	.funcs = {
-		.get_max = core_get_max_pstate,
-		.get_max_physical = core_get_max_pstate_physical,
-		.get_min = core_get_min_pstate,
-		.get_turbo = core_get_turbo_pstate,
-		.get_scaling = core_get_scaling,
-		.get_val = core_get_val,
-		.update_util = intel_pstate_update_util,
-	},
+static struct pstate_funcs core_funcs = {
+	.get_max = core_get_max_pstate,
+	.get_max_physical = core_get_max_pstate_physical,
+	.get_min = core_get_min_pstate,
+	.get_turbo = core_get_turbo_pstate,
+	.get_scaling = core_get_scaling,
+	.get_val = core_get_val,
+	.update_util = intel_pstate_update_util_pid,
+};
+
+static const struct pstate_funcs silvermont_funcs = {
+	.get_max = atom_get_max_pstate,
+	.get_max_physical = atom_get_max_pstate,
+	.get_min = atom_get_min_pstate,
+	.get_turbo = atom_get_turbo_pstate,
+	.get_val = atom_get_val,
+	.get_scaling = silvermont_get_scaling,
+	.get_vid = atom_get_vid,
+	.update_util = intel_pstate_update_util,
+};
+
+static const struct pstate_funcs airmont_funcs = {
+	.get_max = atom_get_max_pstate,
+	.get_max_physical = atom_get_max_pstate,
+	.get_min = atom_get_min_pstate,
+	.get_turbo = atom_get_turbo_pstate,
+	.get_val = atom_get_val,
+	.get_scaling = airmont_get_scaling,
+	.get_vid = atom_get_vid,
+	.update_util = intel_pstate_update_util,
+};
+
+static const struct pstate_funcs knl_funcs = {
+	.get_max = core_get_max_pstate,
+	.get_max_physical = core_get_max_pstate_physical,
+	.get_min = core_get_min_pstate,
+	.get_turbo = knl_get_turbo_pstate,
+	.get_scaling = core_get_scaling,
+	.get_val = core_get_val,
+	.update_util = intel_pstate_update_util_pid,
+};
+
+static const struct pstate_funcs bxt_funcs = {
+	.get_max = core_get_max_pstate,
+	.get_max_physical = core_get_max_pstate_physical,
+	.get_min = core_get_min_pstate,
+	.get_turbo = core_get_turbo_pstate,
+	.get_scaling = core_get_scaling,
+	.get_val = core_get_val,
+	.update_util = intel_pstate_update_util,
 };
 
 #define ICPU(model, policy) \
@@ -1876,38 +1858,38 @@ static const struct cpu_defaults bxt_par
 			(unsigned long)&policy }
 
 static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
-	ICPU(INTEL_FAM6_SANDYBRIDGE, 		core_params),
-	ICPU(INTEL_FAM6_SANDYBRIDGE_X,		core_params),
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT1,	silvermont_params),
-	ICPU(INTEL_FAM6_IVYBRIDGE,		core_params),
-	ICPU(INTEL_FAM6_HASWELL_CORE,		core_params),
-	ICPU(INTEL_FAM6_BROADWELL_CORE,		core_params),
-	ICPU(INTEL_FAM6_IVYBRIDGE_X,		core_params),
-	ICPU(INTEL_FAM6_HASWELL_X,		core_params),
-	ICPU(INTEL_FAM6_HASWELL_ULT,		core_params),
-	ICPU(INTEL_FAM6_HASWELL_GT3E,		core_params),
-	ICPU(INTEL_FAM6_BROADWELL_GT3E,		core_params),
-	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_params),
-	ICPU(INTEL_FAM6_SKYLAKE_MOBILE,		core_params),
-	ICPU(INTEL_FAM6_BROADWELL_X,		core_params),
-	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP,	core_params),
-	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_params),
-	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_params),
-	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_params),
-	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		bxt_params),
+	ICPU(INTEL_FAM6_SANDYBRIDGE, 		core_funcs),
+	ICPU(INTEL_FAM6_SANDYBRIDGE_X,		core_funcs),
+	ICPU(INTEL_FAM6_ATOM_SILVERMONT1,	silvermont_funcs),
+	ICPU(INTEL_FAM6_IVYBRIDGE,		core_funcs),
+	ICPU(INTEL_FAM6_HASWELL_CORE,		core_funcs),
+	ICPU(INTEL_FAM6_BROADWELL_CORE,		core_funcs),
+	ICPU(INTEL_FAM6_IVYBRIDGE_X,		core_funcs),
+	ICPU(INTEL_FAM6_HASWELL_X,		core_funcs),
+	ICPU(INTEL_FAM6_HASWELL_ULT,		core_funcs),
+	ICPU(INTEL_FAM6_HASWELL_GT3E,		core_funcs),
+	ICPU(INTEL_FAM6_BROADWELL_GT3E,		core_funcs),
+	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_funcs),
+	ICPU(INTEL_FAM6_SKYLAKE_MOBILE,		core_funcs),
+	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
+	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP,	core_funcs),
+	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_funcs),
+	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_funcs),
+	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_funcs),
+	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		bxt_funcs),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
 
 static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
-	ICPU(INTEL_FAM6_BROADWELL_XEON_D, core_params),
-	ICPU(INTEL_FAM6_BROADWELL_X, core_params),
-	ICPU(INTEL_FAM6_SKYLAKE_X, core_params),
+	ICPU(INTEL_FAM6_BROADWELL_XEON_D, core_funcs),
+	ICPU(INTEL_FAM6_BROADWELL_X, core_funcs),
+	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
 	{}
 };
 
 static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
-	ICPU(INTEL_FAM6_KABYLAKE_DESKTOP, core_params),
+	ICPU(INTEL_FAM6_KABYLAKE_DESKTOP, core_funcs),
 	{}
 };
 
@@ -2576,7 +2558,7 @@ static int __init intel_pstate_init(void
 		return -ENODEV;
 
 	if (x86_match_cpu(hwp_support_ids)) {
-		copy_cpu_funcs(&core_params.funcs);
+		copy_cpu_funcs(&core_funcs);
 		if (no_hwp) {
 			pstate_funcs.update_util = intel_pstate_update_util;
 		} else {
@@ -2587,14 +2569,12 @@ static int __init intel_pstate_init(void
 		}
 	} else {
 		const struct x86_cpu_id *id;
-		struct cpu_defaults *cpu_def;
 
 		id = x86_match_cpu(intel_pstate_cpu_ids);
 		if (!id)
 			return -ENODEV;
 
-		cpu_def = (struct cpu_defaults *)id->driver_data;
-		copy_cpu_funcs(&cpu_def->funcs);
+		copy_cpu_funcs((struct pstate_funcs *)id->driver_data);
 	}
 
 	if (intel_pstate_msrs_not_valid())
