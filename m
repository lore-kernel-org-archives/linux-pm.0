From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 12/16] cpufreq: intel_pstate: Move cpu_defaults definitions
Date: Tue, 28 Mar 2017 00:18:02 +0200
Message-ID: <11219592.eHWzgQhGlg@aspire.rjw.lan>
References: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61100 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752238AbdC0WjI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 18:39:08 -0400
In-Reply-To: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the definitions of the cpu_defaults structures after the
definitions of utilization update callback routines to avoid
extra declarations of the latter.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |  129 +++++++++++++++++++----------------------
 1 file changed, 62 insertions(+), 67 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1508,73 +1508,6 @@ static int knl_get_turbo_pstate(void)
 	return ret;
 }
 
-static void intel_pstate_update_util_pid(struct update_util_data *data,
-					 u64 time, unsigned int flags);
-static void intel_pstate_update_util(struct update_util_data *data, u64 time,
-				     unsigned int flags);
-
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
-};
-
 static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
 {
 	int max_perf = cpu->pstate.turbo_pstate;
@@ -1876,6 +1809,68 @@ static void intel_pstate_update_util(str
 	}
 }
 
+static struct cpu_defaults core_params = {
+	.funcs = {
+		.get_max = core_get_max_pstate,
+		.get_max_physical = core_get_max_pstate_physical,
+		.get_min = core_get_min_pstate,
+		.get_turbo = core_get_turbo_pstate,
+		.get_scaling = core_get_scaling,
+		.get_val = core_get_val,
+		.update_util = intel_pstate_update_util_pid,
+	},
+};
+
+static const struct cpu_defaults silvermont_params = {
+	.funcs = {
+		.get_max = atom_get_max_pstate,
+		.get_max_physical = atom_get_max_pstate,
+		.get_min = atom_get_min_pstate,
+		.get_turbo = atom_get_turbo_pstate,
+		.get_val = atom_get_val,
+		.get_scaling = silvermont_get_scaling,
+		.get_vid = atom_get_vid,
+		.update_util = intel_pstate_update_util,
+	},
+};
+
+static const struct cpu_defaults airmont_params = {
+	.funcs = {
+		.get_max = atom_get_max_pstate,
+		.get_max_physical = atom_get_max_pstate,
+		.get_min = atom_get_min_pstate,
+		.get_turbo = atom_get_turbo_pstate,
+		.get_val = atom_get_val,
+		.get_scaling = airmont_get_scaling,
+		.get_vid = atom_get_vid,
+		.update_util = intel_pstate_update_util,
+	},
+};
+
+static const struct cpu_defaults knl_params = {
+	.funcs = {
+		.get_max = core_get_max_pstate,
+		.get_max_physical = core_get_max_pstate_physical,
+		.get_min = core_get_min_pstate,
+		.get_turbo = knl_get_turbo_pstate,
+		.get_scaling = core_get_scaling,
+		.get_val = core_get_val,
+		.update_util = intel_pstate_update_util_pid,
+	},
+};
+
+static const struct cpu_defaults bxt_params = {
+	.funcs = {
+		.get_max = core_get_max_pstate,
+		.get_max_physical = core_get_max_pstate_physical,
+		.get_min = core_get_min_pstate,
+		.get_turbo = core_get_turbo_pstate,
+		.get_scaling = core_get_scaling,
+		.get_val = core_get_val,
+		.update_util = intel_pstate_update_util,
+	},
+};
+
 #define ICPU(model, policy) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF,\
 			(unsigned long)&policy }
