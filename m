From: Len Brown <lenb@kernel.org>
Subject: [PATCH 36/44] tools/power turbostat: update --list feature
Date: Wed,  1 Mar 2017 00:27:40 -0500
Message-ID: <6168c2e0fb5084d187aa8f3ec4093db5e161d4dc.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32769 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdCAFbU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 00:31:20 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Make it possible to take the entire un-edited output
from `turbostat --list` and feed it to "turbostat --show"
or "turbostat --hide".

To do this, the leading comma was removed
(no mater what columns are active)
and also they dynamic C-state "C1, C2, C3" etc are replaced
by the string "sysfs", which refers to them as a group.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 219 ++++++++++++++++++----------------
 1 file changed, 113 insertions(+), 106 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index cafc6bba6539..851eaf06f358 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -474,33 +474,38 @@ unsigned long long bic_lookup(char *name_list)
 void print_header(char *delim)
 {
 	struct msr_counter *mp;
+	int printed = 0;
 
 	if (DO_BIC(BIC_Package))
-		outp += sprintf(outp, "%sPackage", delim);
+		outp += sprintf(outp, "%sPackage", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Core))
-		outp += sprintf(outp, "%sCore", delim);
+		outp += sprintf(outp, "%sCore", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPU))
-		outp += sprintf(outp, "%sCPU", delim);
+		outp += sprintf(outp, "%sCPU", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Avg_MHz))
-		outp += sprintf(outp, "%sAvg_MHz", delim);
+		outp += sprintf(outp, "%sAvg_MHz", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Busy))
-		outp += sprintf(outp, "%sBusy%%", delim);
+		outp += sprintf(outp, "%sBusy%%", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Bzy_MHz))
-		outp += sprintf(outp, "%sBzy_MHz", delim);
+		outp += sprintf(outp, "%sBzy_MHz", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_TSC_MHz))
-		outp += sprintf(outp, "%sTSC_MHz", delim);
+		outp += sprintf(outp, "%sTSC_MHz", (printed++ ? delim : ""));
 
 	if (DO_BIC(BIC_IRQ)) {
 		if (sums_need_wide_columns)
-			outp += sprintf(outp, "%s     IRQ", delim);
+			outp += sprintf(outp, "%s     IRQ", (printed++ ? delim : ""));
 		else
-			outp += sprintf(outp, "%sIRQ", delim);
+			outp += sprintf(outp, "%sIRQ", (printed++ ? delim : ""));
 	}
 
 	if (DO_BIC(BIC_SMI))
-		outp += sprintf(outp, "%sSMI", delim);
+		outp += sprintf(outp, "%sSMI", (printed++ ? delim : ""));
 
 	for (mp = sys.tp; mp; mp = mp->next) {
+		if (*delim == ',') {
+			outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), "sysfs");
+			break;
+		}
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 64)
 				outp += sprintf(outp, "%s%18.18s", delim, mp->name);
@@ -515,19 +520,19 @@ void print_header(char *delim)
 	}
 
 	if (DO_BIC(BIC_CPU_c1))
-		outp += sprintf(outp, "%sCPU%%c1", delim);
+		outp += sprintf(outp, "%sCPU%%c1", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPU_c3) && !do_slm_cstates && !do_knl_cstates)
-		outp += sprintf(outp, "%sCPU%%c3", delim);
+		outp += sprintf(outp, "%sCPU%%c3", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPU_c6))
-		outp += sprintf(outp, "%sCPU%%c6", delim);
+		outp += sprintf(outp, "%sCPU%%c6", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPU_c7))
-		outp += sprintf(outp, "%sCPU%%c7", delim);
+		outp += sprintf(outp, "%sCPU%%c7", (printed++ ? delim : ""));
 
 	if (DO_BIC(BIC_Mod_c6))
-		outp += sprintf(outp, "%sMod%%c6", delim);
+		outp += sprintf(outp, "%sMod%%c6", (printed++ ? delim : ""));
 
 	if (DO_BIC(BIC_CoreTmp))
-		outp += sprintf(outp, "%sCoreTmp", delim);
+		outp += sprintf(outp, "%sCoreTmp", (printed++ ? delim : ""));
 
 	for (mp = sys.cp; mp; mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
@@ -544,62 +549,62 @@ void print_header(char *delim)
 	}
 
 	if (DO_BIC(BIC_PkgTmp))
-		outp += sprintf(outp, "%sPkgTmp", delim);
+		outp += sprintf(outp, "%sPkgTmp", (printed++ ? delim : ""));
 
 	if (DO_BIC(BIC_GFX_rc6))
-		outp += sprintf(outp, "%sGFX%%rc6", delim);
+		outp += sprintf(outp, "%sGFX%%rc6", (printed++ ? delim : ""));
 
 	if (DO_BIC(BIC_GFXMHz))
-		outp += sprintf(outp, "%sGFXMHz", delim);
+		outp += sprintf(outp, "%sGFXMHz", (printed++ ? delim : ""));
 
 	if (do_skl_residency) {
-		outp += sprintf(outp, "%sTotl%%C0", delim);
-		outp += sprintf(outp, "%sAny%%C0", delim);
-		outp += sprintf(outp, "%sGFX%%C0", delim);
-		outp += sprintf(outp, "%sCPUGFX%%", delim);
+		outp += sprintf(outp, "%sTotl%%C0", (printed++ ? delim : ""));
+		outp += sprintf(outp, "%sAny%%C0", (printed++ ? delim : ""));
+		outp += sprintf(outp, "%sGFX%%C0", (printed++ ? delim : ""));
+		outp += sprintf(outp, "%sCPUGFX%%", (printed++ ? delim : ""));
 	}
 
 	if (DO_BIC(BIC_Pkgpc2))
-		outp += sprintf(outp, "%sPkg%%pc2", delim);
+		outp += sprintf(outp, "%sPkg%%pc2", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Pkgpc3))
-		outp += sprintf(outp, "%sPkg%%pc3", delim);
+		outp += sprintf(outp, "%sPkg%%pc3", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Pkgpc6))
-		outp += sprintf(outp, "%sPkg%%pc6", delim);
+		outp += sprintf(outp, "%sPkg%%pc6", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Pkgpc7))
-		outp += sprintf(outp, "%sPkg%%pc7", delim);
+		outp += sprintf(outp, "%sPkg%%pc7", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Pkgpc8))
-		outp += sprintf(outp, "%sPkg%%pc8", delim);
+		outp += sprintf(outp, "%sPkg%%pc8", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Pkgpc9))
-		outp += sprintf(outp, "%sPkg%%pc9", delim);
+		outp += sprintf(outp, "%sPkg%%pc9", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Pkgpc10))
-		outp += sprintf(outp, "%sPk%%pc10", delim);
+		outp += sprintf(outp, "%sPk%%pc10", (printed++ ? delim : ""));
 
 	if (do_rapl && !rapl_joules) {
 		if (DO_BIC(BIC_PkgWatt))
-			outp += sprintf(outp, "%sPkgWatt", delim);
+			outp += sprintf(outp, "%sPkgWatt", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_CorWatt))
-			outp += sprintf(outp, "%sCorWatt", delim);
+			outp += sprintf(outp, "%sCorWatt", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_GFXWatt))
-			outp += sprintf(outp, "%sGFXWatt", delim);
+			outp += sprintf(outp, "%sGFXWatt", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_RAMWatt))
-			outp += sprintf(outp, "%sRAMWatt", delim);
+			outp += sprintf(outp, "%sRAMWatt", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_PKG__))
-			outp += sprintf(outp, "%sPKG_%%", delim);
+			outp += sprintf(outp, "%sPKG_%%", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_RAM__))
-			outp += sprintf(outp, "%sRAM_%%", delim);
+			outp += sprintf(outp, "%sRAM_%%", (printed++ ? delim : ""));
 	} else if (do_rapl && rapl_joules) {
 		if (DO_BIC(BIC_Pkg_J))
-			outp += sprintf(outp, "%sPkg_J", delim);
+			outp += sprintf(outp, "%sPkg_J", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_Cor_J))
-			outp += sprintf(outp, "%sCor_J", delim);
+			outp += sprintf(outp, "%sCor_J", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_GFX_J))
-			outp += sprintf(outp, "%sGFX_J", delim);
+			outp += sprintf(outp, "%sGFX_J", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_RAM_J))
-			outp += sprintf(outp, "%sRAM_J", delim);
+			outp += sprintf(outp, "%sRAM_J", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_PKG__))
-			outp += sprintf(outp, "%sPKG_%%", delim);
+			outp += sprintf(outp, "%sPKG_%%", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_RAM__))
-			outp += sprintf(outp, "%sRAM_%%", delim);
+			outp += sprintf(outp, "%sRAM_%%", (printed++ ? delim : ""));
 	}
 	for (mp = sys.pp; mp; mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
@@ -708,6 +713,8 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	char *fmt8;
 	int i;
 	struct msr_counter *mp;
+	char *delim = "\t";
+	int printed = 0;
 
 	 /* if showing only 1st thread in core and this isn't one, bail out */
 	if (show_core_only && !(t->flags & CPU_IS_FIRST_THREAD_IN_CORE))
@@ -729,81 +736,81 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	/* topo columns, print blanks on 1st (average) line */
 	if (t == &average.threads) {
 		if (DO_BIC(BIC_Package))
-			outp += sprintf(outp, "\t-");
+			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_Core))
-			outp += sprintf(outp, "\t-");
+			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_CPU))
-			outp += sprintf(outp, "\t-");
+			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 	} else {
 		if (DO_BIC(BIC_Package)) {
 			if (p)
-				outp += sprintf(outp, "\t%d", p->package_id);
+				outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->package_id);
 			else
-				outp += sprintf(outp, "\t-");
+				outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 		}
 		if (DO_BIC(BIC_Core)) {
 			if (c)
-				outp += sprintf(outp, "\t%d", c->core_id);
+				outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), c->core_id);
 			else
-				outp += sprintf(outp, "\t-");
+				outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 		}
 		if (DO_BIC(BIC_CPU))
-			outp += sprintf(outp, "\t%d", t->cpu_id);
+			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->cpu_id);
 	}
 
 	if (DO_BIC(BIC_Avg_MHz))
-		outp += sprintf(outp, "\t%.0f",
+		outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""),
 			1.0 / units * t->aperf / interval_float);
 
 	if (DO_BIC(BIC_Busy))
-		outp += sprintf(outp, "\t%.2f", 100.0 * t->mperf/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->mperf/tsc);
 
 	if (DO_BIC(BIC_Bzy_MHz)) {
 		if (has_base_hz)
-			outp += sprintf(outp, "\t%.0f", base_hz / units * t->aperf / t->mperf);
+			outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""), base_hz / units * t->aperf / t->mperf);
 		else
-			outp += sprintf(outp, "\t%.0f",
+			outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""),
 				tsc / units * t->aperf / t->mperf / interval_float);
 	}
 
 	if (DO_BIC(BIC_TSC_MHz))
-		outp += sprintf(outp, "\t%.0f", 1.0 * t->tsc/units/interval_float);
+		outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""), 1.0 * t->tsc/units/interval_float);
 
 	/* IRQ */
 	if (DO_BIC(BIC_IRQ)) {
 		if (sums_need_wide_columns)
-			outp += sprintf(outp, "\t%8lld", t->irq_count);
+			outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), t->irq_count);
 		else
-			outp += sprintf(outp, "\t%lld", t->irq_count);
+			outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), t->irq_count);
 	}
 
 	/* SMI */
 	if (DO_BIC(BIC_SMI))
-		outp += sprintf(outp, "\t%d", t->smi_count);
+		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->smi_count);
 
 	/* Added counters */
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
-				outp += sprintf(outp, "\t0x%08lx", (unsigned long) t->counter[i]);
+				outp += sprintf(outp, "%s0x%08lx", (printed++ ? delim : ""), (unsigned long) t->counter[i]);
 			else
-				outp += sprintf(outp, "\t0x%016llx", t->counter[i]);
+				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), t->counter[i]);
 		} else if (mp->format == FORMAT_DELTA) {
 			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "\t%8lld", t->counter[i]);
+				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), t->counter[i]);
 			else
-				outp += sprintf(outp, "\t%lld", t->counter[i]);
+				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), t->counter[i]);
 		} else if (mp->format == FORMAT_PERCENT) {
 			if (mp->type == COUNTER_USEC)
-				outp += sprintf(outp, "\t%.2f", t->counter[i]/interval_float/10000);
+				outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), t->counter[i]/interval_float/10000);
 			else
-				outp += sprintf(outp, "\t%.2f", 100.0 * t->counter[i]/tsc);
+				outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->counter[i]/tsc);
 		}
 	}
 
 	/* C1 */
 	if (DO_BIC(BIC_CPU_c1))
-		outp += sprintf(outp, "\t%.2f", 100.0 * t->c1/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->c1/tsc);
 
 
 	/* print per-core data only for 1st thread in core */
@@ -811,32 +818,32 @@ int format_counters(struct thread_data *t, struct core_data *c,
 		goto done;
 
 	if (DO_BIC(BIC_CPU_c3) && !do_slm_cstates && !do_knl_cstates)
-		outp += sprintf(outp, "\t%.2f", 100.0 * c->c3/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->c3/tsc);
 	if (DO_BIC(BIC_CPU_c6))
-		outp += sprintf(outp, "\t%.2f", 100.0 * c->c6/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->c6/tsc);
 	if (DO_BIC(BIC_CPU_c7))
-		outp += sprintf(outp, "\t%.2f", 100.0 * c->c7/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->c7/tsc);
 
 	/* Mod%c6 */
 	if (DO_BIC(BIC_Mod_c6))
-		outp += sprintf(outp, "\t%.2f", 100.0 * c->mc6_us / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->mc6_us / tsc);
 
 	if (DO_BIC(BIC_CoreTmp))
-		outp += sprintf(outp, "\t%d", c->core_temp_c);
+		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), c->core_temp_c);
 
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
-				outp += sprintf(outp, "\t0x%08lx", (unsigned long) c->counter[i]);
+				outp += sprintf(outp, "%s0x%08lx", (printed++ ? delim : ""), (unsigned long) c->counter[i]);
 			else
-				outp += sprintf(outp, "\t0x%016llx", c->counter[i]);
+				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), c->counter[i]);
 		} else if (mp->format == FORMAT_DELTA) {
 			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "\t%8lld", c->counter[i]);
+				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), c->counter[i]);
 			else
-				outp += sprintf(outp, "\t%lld", c->counter[i]);
+				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), c->counter[i]);
 		} else if (mp->format == FORMAT_PERCENT) {
-			outp += sprintf(outp, "\t%.2f", 100.0 * c->counter[i]/tsc);
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->counter[i]/tsc);
 		}
 	}
 
@@ -846,88 +853,88 @@ int format_counters(struct thread_data *t, struct core_data *c,
 
 	/* PkgTmp */
 	if (DO_BIC(BIC_PkgTmp))
-		outp += sprintf(outp, "\t%d", p->pkg_temp_c);
+		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->pkg_temp_c);
 
 	/* GFXrc6 */
 	if (DO_BIC(BIC_GFX_rc6)) {
 		if (p->gfx_rc6_ms == -1) {	/* detect GFX counter reset */
-			outp += sprintf(outp, "\t**.**");
+			outp += sprintf(outp, "%s**.**", (printed++ ? delim : ""));
 		} else {
-			outp += sprintf(outp, "\t%.2f",
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""),
 				p->gfx_rc6_ms / 10.0 / interval_float);
 		}
 	}
 
 	/* GFXMHz */
 	if (DO_BIC(BIC_GFXMHz))
-		outp += sprintf(outp, "\t%d", p->gfx_mhz);
+		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->gfx_mhz);
 
 	/* Totl%C0, Any%C0 GFX%C0 CPUGFX% */
 	if (do_skl_residency) {
-		outp += sprintf(outp, "\t%.2f", 100.0 * p->pkg_wtd_core_c0/tsc);
-		outp += sprintf(outp, "\t%.2f", 100.0 * p->pkg_any_core_c0/tsc);
-		outp += sprintf(outp, "\t%.2f", 100.0 * p->pkg_any_gfxe_c0/tsc);
-		outp += sprintf(outp, "\t%.2f", 100.0 * p->pkg_both_core_gfxe_c0/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_wtd_core_c0/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_any_core_c0/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_any_gfxe_c0/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_both_core_gfxe_c0/tsc);
 	}
 
 	if (DO_BIC(BIC_Pkgpc2))
-		outp += sprintf(outp, "\t%.2f", 100.0 * p->pc2/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc2/tsc);
 	if (DO_BIC(BIC_Pkgpc3))
-		outp += sprintf(outp, "\t%.2f", 100.0 * p->pc3/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc3/tsc);
 	if (DO_BIC(BIC_Pkgpc6))
-		outp += sprintf(outp, "\t%.2f", 100.0 * p->pc6/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc6/tsc);
 	if (DO_BIC(BIC_Pkgpc7))
-		outp += sprintf(outp, "\t%.2f", 100.0 * p->pc7/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc7/tsc);
 	if (DO_BIC(BIC_Pkgpc8))
-		outp += sprintf(outp, "\t%.2f", 100.0 * p->pc8/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc8/tsc);
 	if (DO_BIC(BIC_Pkgpc9))
-		outp += sprintf(outp, "\t%.2f", 100.0 * p->pc9/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc9/tsc);
 	if (DO_BIC(BIC_Pkgpc10))
-		outp += sprintf(outp, "\t%.2f", 100.0 * p->pc10/tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc10/tsc);
 
 	/*
  	 * If measurement interval exceeds minimum RAPL Joule Counter range,
  	 * indicate that results are suspect by printing "**" in fraction place.
  	 */
 	if (interval_float < rapl_joule_counter_range)
-		fmt8 = "\t%.2f";
+		fmt8 = "%s%.2f";
 	else
 		fmt8 = "%6.0f**";
 
 	if (DO_BIC(BIC_PkgWatt))
-		outp += sprintf(outp, fmt8, p->energy_pkg * rapl_energy_units / interval_float);
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units / interval_float);
 	if (DO_BIC(BIC_CorWatt))
-		outp += sprintf(outp, fmt8, p->energy_cores * rapl_energy_units / interval_float);
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units / interval_float);
 	if (DO_BIC(BIC_GFXWatt))
-		outp += sprintf(outp, fmt8, p->energy_gfx * rapl_energy_units / interval_float);
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units / interval_float);
 	if (DO_BIC(BIC_RAMWatt))
-		outp += sprintf(outp, fmt8, p->energy_dram * rapl_dram_energy_units / interval_float);
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_dram * rapl_dram_energy_units / interval_float);
 	if (DO_BIC(BIC_Pkg_J))
-		outp += sprintf(outp, fmt8, p->energy_pkg * rapl_energy_units);
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units);
 	if (DO_BIC(BIC_Cor_J))
-		outp += sprintf(outp, fmt8, p->energy_cores * rapl_energy_units);
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units);
 	if (DO_BIC(BIC_GFX_J))
-		outp += sprintf(outp, fmt8, p->energy_gfx * rapl_energy_units);
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units);
 	if (DO_BIC(BIC_RAM_J))
-		outp += sprintf(outp, fmt8, p->energy_dram * rapl_dram_energy_units);
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_dram * rapl_dram_energy_units);
 	if (DO_BIC(BIC_PKG__))
-		outp += sprintf(outp, fmt8, 100.0 * p->rapl_pkg_perf_status * rapl_time_units / interval_float);
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), 100.0 * p->rapl_pkg_perf_status * rapl_time_units / interval_float);
 	if (DO_BIC(BIC_RAM__))
-		outp += sprintf(outp, fmt8, 100.0 * p->rapl_dram_perf_status * rapl_time_units / interval_float);
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), 100.0 * p->rapl_dram_perf_status * rapl_time_units / interval_float);
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
-				outp += sprintf(outp, "\t0x%08lx", (unsigned long) p->counter[i]);
+				outp += sprintf(outp, "%s0x%08lx", (printed++ ? delim : ""), (unsigned long) p->counter[i]);
 			else
-				outp += sprintf(outp, "\t0x%016llx", p->counter[i]);
+				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), p->counter[i]);
 		} else if (mp->format == FORMAT_DELTA) {
 			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "\t%8lld", p->counter[i]);
+				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), p->counter[i]);
 			else
-				outp += sprintf(outp, "\t%lld", p->counter[i]);
+				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), p->counter[i]);
 		} else if (mp->format == FORMAT_PERCENT) {
-			outp += sprintf(outp, "\t%.2f", 100.0 * p->counter[i]/tsc);
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->counter[i]/tsc);
 		}
 	}
 
-- 
2.11.0.161.g6610af872
