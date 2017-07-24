From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Drop ->update_util from pstate_funcs
Date: Tue, 25 Jul 2017 00:12:20 +0200
Message-ID: <3606380.24UY2ZGHqS@aspire.rjw.lan>
References: <6183701.sLtcQDF8CA@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6183701.sLtcQDF8CA@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

All systems use the same P-state selection "powersave" algorithm
in the active mode if HWP is not used, so there's no need to provide
a pointer for it in struct pstate_funcs any more.

Drop ->update_util from struct pstate_funcs and make
intel_pstate_set_update_util_hook() use intel_pstate_update_util()
directly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -268,7 +268,6 @@ static struct cpudata **all_cpu_data;
  * @get_scaling:	Callback to get frequency scaling factor
  * @get_val:		Callback to convert P state to actual MSR write value
  * @get_vid:		Callback to get VID data for Atom platforms
- * @update_util:	Active mode utilization update callback.
  *
  * Core and Atom CPU models have different way to get P State limits. This
  * structure is used to store those callbacks.
@@ -282,8 +281,6 @@ struct pstate_funcs {
 	int (*get_aperf_mperf_shift)(void);
 	u64 (*get_val)(struct cpudata*, int pstate);
 	void (*get_vid)(struct cpudata *);
-	void (*update_util)(struct update_util_data *data, u64 time,
-			    unsigned int flags);
 };
 
 static struct pstate_funcs pstate_funcs __read_mostly;
@@ -1556,7 +1553,6 @@ static struct pstate_funcs core_funcs =
 	.get_turbo = core_get_turbo_pstate,
 	.get_scaling = core_get_scaling,
 	.get_val = core_get_val,
-	.update_util = intel_pstate_update_util,
 };
 
 static const struct pstate_funcs silvermont_funcs = {
@@ -1567,7 +1563,6 @@ static const struct pstate_funcs silverm
 	.get_val = atom_get_val,
 	.get_scaling = silvermont_get_scaling,
 	.get_vid = atom_get_vid,
-	.update_util = intel_pstate_update_util,
 };
 
 static const struct pstate_funcs airmont_funcs = {
@@ -1578,7 +1573,6 @@ static const struct pstate_funcs airmont
 	.get_val = atom_get_val,
 	.get_scaling = airmont_get_scaling,
 	.get_vid = atom_get_vid,
-	.update_util = intel_pstate_update_util,
 };
 
 static const struct pstate_funcs knl_funcs = {
@@ -1589,7 +1583,6 @@ static const struct pstate_funcs knl_fun
 	.get_aperf_mperf_shift = knl_get_aperf_mperf_shift,
 	.get_scaling = core_get_scaling,
 	.get_val = core_get_val,
-	.update_util = intel_pstate_update_util,
 };
 
 static const struct pstate_funcs bxt_funcs = {
@@ -1599,7 +1592,6 @@ static const struct pstate_funcs bxt_fun
 	.get_turbo = core_get_turbo_pstate,
 	.get_scaling = core_get_scaling,
 	.get_val = core_get_val,
-	.update_util = intel_pstate_update_util,
 };
 
 #define ICPU(model, policy) \
@@ -1702,7 +1694,7 @@ static void intel_pstate_set_update_util
 	/* Prevent intel_pstate_update_util() from using stale data. */
 	cpu->sample.time = 0;
 	cpufreq_add_update_util_hook(cpu_num, &cpu->update_util,
-				     pstate_funcs.update_util);
+				     intel_pstate_update_util);
 	cpu->update_util_set = true;
 }
 
@@ -2148,7 +2140,6 @@ static void __init copy_cpu_funcs(struct
 	pstate_funcs.get_scaling = funcs->get_scaling;
 	pstate_funcs.get_val   = funcs->get_val;
 	pstate_funcs.get_vid   = funcs->get_vid;
-	pstate_funcs.update_util = funcs->update_util;
 	pstate_funcs.get_aperf_mperf_shift = funcs->get_aperf_mperf_shift;
 }
 
@@ -2293,9 +2284,7 @@ static int __init intel_pstate_init(void
 
 	if (x86_match_cpu(hwp_support_ids)) {
 		copy_cpu_funcs(&core_funcs);
-		if (no_hwp) {
-			pstate_funcs.update_util = intel_pstate_update_util;
-		} else {
+		if (!no_hwp) {
 			hwp_active++;
 			intel_pstate.attr = hwp_cpufreq_attrs;
 			goto hwp_cpu_matched;
