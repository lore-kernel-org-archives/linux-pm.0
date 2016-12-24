From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/17] tools/power turbostat: switch to tab delimited output
Date: Sat, 24 Dec 2016 15:53:31 -0500
Message-ID: <3d109de23c93e9196c370fd729fbd7ecf7371701.1482612381.git.len.brown@intel.com>
References: <20161224205345.29129-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33531 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbcLXU4G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Dec 2016 15:56:06 -0500
Received: by mail-qt0-f194.google.com with SMTP id 41so9409376qtn.0
        for <linux-pm@vger.kernel.org>; Sat, 24 Dec 2016 12:56:05 -0800 (PST)
In-Reply-To: <20161224205345.29129-1-lenb@kernel.org>
In-Reply-To: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
References: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Switch to tab-delimited output from fixed-width columns
to make it simpler to import into spreadsheets.

As the fixed width columnns were 8-spaces wide,
the output on the screen should not change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 170 +++++++++++++++++-----------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c0dade0c1921..be50892f27aa 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -323,103 +323,103 @@ int get_msr(int cpu, off_t offset, unsigned long long *msr)
 void print_header(void)
 {
 	if (show_pkg)
-		outp += sprintf(outp, " Package");
+		outp += sprintf(outp, "\tPackage");
 	if (show_core)
-		outp += sprintf(outp, "    Core");
+		outp += sprintf(outp, "\tCore");
 	if (show_cpu)
-		outp += sprintf(outp, "     CPU");
+		outp += sprintf(outp, "\tCPU");
 	if (has_aperf)
-		outp += sprintf(outp, " Avg_MHz");
+		outp += sprintf(outp, "\tAvg_MHz");
 	if (has_aperf)
-		outp += sprintf(outp, "   Busy%%");
+		outp += sprintf(outp, "\tBusy%%");
 	if (has_aperf)
-		outp += sprintf(outp, " Bzy_MHz");
-	outp += sprintf(outp, " TSC_MHz");
+		outp += sprintf(outp, "\tBzy_MHz");
+	outp += sprintf(outp, "\tTSC_MHz");
 
 	if (extra_delta_offset32)
-		outp += sprintf(outp, "  count 0x%03X", extra_delta_offset32);
+		outp += sprintf(outp, "\tcount 0x%03X", extra_delta_offset32);
 	if (extra_delta_offset64)
-		outp += sprintf(outp, "  COUNT 0x%03X", extra_delta_offset64);
+		outp += sprintf(outp, "\tCOUNT 0x%03X", extra_delta_offset64);
 	if (extra_msr_offset32)
-		outp += sprintf(outp, "   MSR 0x%03X", extra_msr_offset32);
+		outp += sprintf(outp, "\tMSR 0x%03X", extra_msr_offset32);
 	if (extra_msr_offset64)
-		outp += sprintf(outp, "           MSR 0x%03X", extra_msr_offset64);
+		outp += sprintf(outp, "\tMSR 0x%03X", extra_msr_offset64);
 
 	if (!debug)
 		goto done;
 
 	if (do_irq)
-		outp += sprintf(outp, "     IRQ");
+		outp += sprintf(outp, "\tIRQ");
 	if (do_smi)
-		outp += sprintf(outp, "     SMI");
+		outp += sprintf(outp, "\tSMI");
 
 	if (do_nhm_cstates)
-		outp += sprintf(outp, "  CPU%%c1");
+		outp += sprintf(outp, "\tCPU%%c1");
 	if (do_nhm_cstates && !do_slm_cstates && !do_knl_cstates)
-		outp += sprintf(outp, "  CPU%%c3");
+		outp += sprintf(outp, "\tCPU%%c3");
 	if (do_nhm_cstates)
-		outp += sprintf(outp, "  CPU%%c6");
+		outp += sprintf(outp, "\tCPU%%c6");
 	if (do_snb_cstates)
-		outp += sprintf(outp, "  CPU%%c7");
+		outp += sprintf(outp, "\tCPU%%c7");
 
 	if (do_dts)
-		outp += sprintf(outp, " CoreTmp");
+		outp += sprintf(outp, "\tCoreTmp");
 	if (do_ptm)
-		outp += sprintf(outp, "  PkgTmp");
+		outp += sprintf(outp, "\tPkgTmp");
 
 	if (do_gfx_rc6_ms)
-		outp += sprintf(outp, " GFX%%rc6");
+		outp += sprintf(outp, "\tGFX%%rc6");
 
 	if (do_gfx_mhz)
-		outp += sprintf(outp, "  GFXMHz");
+		outp += sprintf(outp, "\tGFXMHz");
 
 	if (do_skl_residency) {
-		outp += sprintf(outp, " Totl%%C0");
-		outp += sprintf(outp, "  Any%%C0");
-		outp += sprintf(outp, "  GFX%%C0");
-		outp += sprintf(outp, " CPUGFX%%");
+		outp += sprintf(outp, "\tTotl%%C0");
+		outp += sprintf(outp, "\tAny%%C0");
+		outp += sprintf(outp, "\tGFX%%C0");
+		outp += sprintf(outp, "\tCPUGFX%%");
 	}
 
 	if (do_pc2)
-		outp += sprintf(outp, " Pkg%%pc2");
+		outp += sprintf(outp, "\tPkg%%pc2");
 	if (do_pc3)
-		outp += sprintf(outp, " Pkg%%pc3");
+		outp += sprintf(outp, "\tPkg%%pc3");
 	if (do_pc6)
-		outp += sprintf(outp, " Pkg%%pc6");
+		outp += sprintf(outp, "\tPkg%%pc6");
 	if (do_pc7)
-		outp += sprintf(outp, " Pkg%%pc7");
+		outp += sprintf(outp, "\tPkg%%pc7");
 	if (do_c8_c9_c10) {
-		outp += sprintf(outp, " Pkg%%pc8");
-		outp += sprintf(outp, " Pkg%%pc9");
-		outp += sprintf(outp, " Pk%%pc10");
+		outp += sprintf(outp, "\tPkg%%pc8");
+		outp += sprintf(outp, "\tPkg%%pc9");
+		outp += sprintf(outp, "\tPk%%pc10");
 	}
 
 	if (do_rapl && !rapl_joules) {
 		if (do_rapl & RAPL_PKG)
-			outp += sprintf(outp, " PkgWatt");
+			outp += sprintf(outp, "\tPkgWatt");
 		if (do_rapl & RAPL_CORES)
-			outp += sprintf(outp, " CorWatt");
+			outp += sprintf(outp, "\tCorWatt");
 		if (do_rapl & RAPL_GFX)
-			outp += sprintf(outp, " GFXWatt");
+			outp += sprintf(outp, "\tGFXWatt");
 		if (do_rapl & RAPL_DRAM)
-			outp += sprintf(outp, " RAMWatt");
+			outp += sprintf(outp, "\tRAMWatt");
 		if (do_rapl & RAPL_PKG_PERF_STATUS)
-			outp += sprintf(outp, "   PKG_%%");
+			outp += sprintf(outp, "\tPKG_%%");
 		if (do_rapl & RAPL_DRAM_PERF_STATUS)
-			outp += sprintf(outp, "   RAM_%%");
+			outp += sprintf(outp, "\tRAM_%%");
 	} else if (do_rapl && rapl_joules) {
 		if (do_rapl & RAPL_PKG)
-			outp += sprintf(outp, "   Pkg_J");
+			outp += sprintf(outp, "\tPkg_J");
 		if (do_rapl & RAPL_CORES)
-			outp += sprintf(outp, "   Cor_J");
+			outp += sprintf(outp, "\tCor_J");
 		if (do_rapl & RAPL_GFX)
-			outp += sprintf(outp, "   GFX_J");
+			outp += sprintf(outp, "\tGFX_J");
 		if (do_rapl & RAPL_DRAM)
-			outp += sprintf(outp, "   RAM_J");
+			outp += sprintf(outp, "\tRAM_J");
 		if (do_rapl & RAPL_PKG_PERF_STATUS)
-			outp += sprintf(outp, "   PKG_%%");
+			outp += sprintf(outp, "\tPKG_%%");
 		if (do_rapl & RAPL_DRAM_PERF_STATUS)
-			outp += sprintf(outp, "   RAM_%%");
+			outp += sprintf(outp, "\tRAM_%%");
 	}
     done:
 	outp += sprintf(outp, "\n");
@@ -515,91 +515,91 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	/* topo columns, print blanks on 1st (average) line */
 	if (t == &average.threads) {
 		if (show_pkg)
-			outp += sprintf(outp, "       -");
+			outp += sprintf(outp, "\t-");
 		if (show_core)
-			outp += sprintf(outp, "       -");
+			outp += sprintf(outp, "\t-");
 		if (show_cpu)
-			outp += sprintf(outp, "       -");
+			outp += sprintf(outp, "\t-");
 	} else {
 		if (show_pkg) {
 			if (p)
-				outp += sprintf(outp, "%8d", p->package_id);
+				outp += sprintf(outp, "\t%d", p->package_id);
 			else
-				outp += sprintf(outp, "       -");
+				outp += sprintf(outp, "\t-");
 		}
 		if (show_core) {
 			if (c)
-				outp += sprintf(outp, "%8d", c->core_id);
+				outp += sprintf(outp, "\t%d", c->core_id);
 			else
-				outp += sprintf(outp, "       -");
+				outp += sprintf(outp, "\t-");
 		}
 		if (show_cpu)
-			outp += sprintf(outp, "%8d", t->cpu_id);
+			outp += sprintf(outp, "\t%d", t->cpu_id);
 	}
 
 	/* Avg_MHz */
 	if (has_aperf)
-		outp += sprintf(outp, "%8.0f",
+		outp += sprintf(outp, "\t%.0f",
 			1.0 / units * t->aperf / interval_float);
 
 	/* Busy% */
 	if (has_aperf)
-		outp += sprintf(outp, "%8.2f", 100.0 * t->mperf/t->tsc/tsc_tweak);
+		outp += sprintf(outp, "\t%.2f", 100.0 * t->mperf/t->tsc/tsc_tweak);
 
 	/* Bzy_MHz */
 	if (has_aperf) {
 		if (has_base_hz)
-			outp += sprintf(outp, "%8.0f", base_hz / units * t->aperf / t->mperf);
+			outp += sprintf(outp, "\t%.0f", base_hz / units * t->aperf / t->mperf);
 		else
-			outp += sprintf(outp, "%8.0f",
+			outp += sprintf(outp, "\t%.0f",
 				1.0 * t->tsc / units * t->aperf / t->mperf / interval_float);
 	}
 
 	/* TSC_MHz */
-	outp += sprintf(outp, "%8.0f", 1.0 * t->tsc/units/interval_float);
+	outp += sprintf(outp, "\t%.0f", 1.0 * t->tsc/units/interval_float);
 
 	/* delta */
 	if (extra_delta_offset32)
-		outp += sprintf(outp, "  %11llu", t->extra_delta32);
+		outp += sprintf(outp, "\t%11llu", t->extra_delta32);
 
 	/* DELTA */
 	if (extra_delta_offset64)
-		outp += sprintf(outp, "  %11llu", t->extra_delta64);
+		outp += sprintf(outp, "\t%11llu", t->extra_delta64);
 	/* msr */
 	if (extra_msr_offset32)
-		outp += sprintf(outp, "  0x%08llx", t->extra_msr32);
+		outp += sprintf(outp, "\t0x%08llx", t->extra_msr32);
 
 	/* MSR */
 	if (extra_msr_offset64)
-		outp += sprintf(outp, "  0x%016llx", t->extra_msr64);
+		outp += sprintf(outp, "\t0x%016llx", t->extra_msr64);
 
 	if (!debug)
 		goto done;
 
 	/* IRQ */
 	if (do_irq)
-		outp += sprintf(outp, "%8d", t->irq_count);
+		outp += sprintf(outp, "\t%d", t->irq_count);
 
 	/* SMI */
 	if (do_smi)
-		outp += sprintf(outp, "%8d", t->smi_count);
+		outp += sprintf(outp, "\t%d", t->smi_count);
 
 	if (do_nhm_cstates)
-		outp += sprintf(outp, "%8.2f", 100.0 * t->c1/t->tsc);
+		outp += sprintf(outp, "\t%.2f", 100.0 * t->c1/t->tsc);
 
 	/* print per-core data only for 1st thread in core */
 	if (!(t->flags & CPU_IS_FIRST_THREAD_IN_CORE))
 		goto done;
 
 	if (do_nhm_cstates && !do_slm_cstates && !do_knl_cstates)
-		outp += sprintf(outp, "%8.2f", 100.0 * c->c3/t->tsc);
+		outp += sprintf(outp, "\t%.2f", 100.0 * c->c3/t->tsc);
 	if (do_nhm_cstates)
-		outp += sprintf(outp, "%8.2f", 100.0 * c->c6/t->tsc);
+		outp += sprintf(outp, "\t%.2f", 100.0 * c->c6/t->tsc);
 	if (do_snb_cstates)
-		outp += sprintf(outp, "%8.2f", 100.0 * c->c7/t->tsc);
+		outp += sprintf(outp, "\t%.2f", 100.0 * c->c7/t->tsc);
 
 	if (do_dts)
-		outp += sprintf(outp, "%8d", c->core_temp_c);
+		outp += sprintf(outp, "\t%d", c->core_temp_c);
 
 	/* print per-package data only for 1st core in package */
 	if (!(t->flags & CPU_IS_FIRST_CORE_IN_PACKAGE))
@@ -607,42 +607,42 @@ int format_counters(struct thread_data *t, struct core_data *c,
 
 	/* PkgTmp */
 	if (do_ptm)
-		outp += sprintf(outp, "%8d", p->pkg_temp_c);
+		outp += sprintf(outp, "\t%d", p->pkg_temp_c);
 
 	/* GFXrc6 */
 	if (do_gfx_rc6_ms) {
 		if (p->gfx_rc6_ms == -1) {	/* detect GFX counter reset */
-			outp += sprintf(outp, "   **.**");
+			outp += sprintf(outp, "\t**.**");
 		} else {
-			outp += sprintf(outp, "%8.2f",
+			outp += sprintf(outp, "\t%.2f",
 				p->gfx_rc6_ms / 10.0 / interval_float);
 		}
 	}
 
 	/* GFXMHz */
 	if (do_gfx_mhz)
-		outp += sprintf(outp, "%8d", p->gfx_mhz);
+		outp += sprintf(outp, "\t%d", p->gfx_mhz);
 
 	/* Totl%C0, Any%C0 GFX%C0 CPUGFX% */
 	if (do_skl_residency) {
-		outp += sprintf(outp, "%8.2f", 100.0 * p->pkg_wtd_core_c0/t->tsc);
-		outp += sprintf(outp, "%8.2f", 100.0 * p->pkg_any_core_c0/t->tsc);
-		outp += sprintf(outp, "%8.2f", 100.0 * p->pkg_any_gfxe_c0/t->tsc);
-		outp += sprintf(outp, "%8.2f", 100.0 * p->pkg_both_core_gfxe_c0/t->tsc);
+		outp += sprintf(outp, "\t%.2f", 100.0 * p->pkg_wtd_core_c0/t->tsc);
+		outp += sprintf(outp, "\t%.2f", 100.0 * p->pkg_any_core_c0/t->tsc);
+		outp += sprintf(outp, "\t%.2f", 100.0 * p->pkg_any_gfxe_c0/t->tsc);
+		outp += sprintf(outp, "\t%.2f", 100.0 * p->pkg_both_core_gfxe_c0/t->tsc);
 	}
 
 	if (do_pc2)
-		outp += sprintf(outp, "%8.2f", 100.0 * p->pc2/t->tsc);
+		outp += sprintf(outp, "\t%.2f", 100.0 * p->pc2/t->tsc);
 	if (do_pc3)
-		outp += sprintf(outp, "%8.2f", 100.0 * p->pc3/t->tsc);
+		outp += sprintf(outp, "\t%.2f", 100.0 * p->pc3/t->tsc);
 	if (do_pc6)
-		outp += sprintf(outp, "%8.2f", 100.0 * p->pc6/t->tsc);
+		outp += sprintf(outp, "\t%.2f", 100.0 * p->pc6/t->tsc);
 	if (do_pc7)
-		outp += sprintf(outp, "%8.2f", 100.0 * p->pc7/t->tsc);
+		outp += sprintf(outp, "\t%.2f", 100.0 * p->pc7/t->tsc);
 	if (do_c8_c9_c10) {
-		outp += sprintf(outp, "%8.2f", 100.0 * p->pc8/t->tsc);
-		outp += sprintf(outp, "%8.2f", 100.0 * p->pc9/t->tsc);
-		outp += sprintf(outp, "%8.2f", 100.0 * p->pc10/t->tsc);
+		outp += sprintf(outp, "\t%.2f", 100.0 * p->pc8/t->tsc);
+		outp += sprintf(outp, "\t%.2f", 100.0 * p->pc9/t->tsc);
+		outp += sprintf(outp, "\t%.2f", 100.0 * p->pc10/t->tsc);
 	}
 
 	/*
@@ -650,7 +650,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
  	 * indicate that results are suspect by printing "**" in fraction place.
  	 */
 	if (interval_float < rapl_joule_counter_range)
-		fmt8 = "%8.2f";
+		fmt8 = "\t%.2f";
 	else
 		fmt8 = "%6.0f**";
 
@@ -3715,7 +3715,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(outf, "turbostat version 4.13 22 Apr 2016"
+	fprintf(outf, "turbostat version 4.14 22 Apr 2016"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.11.0.161.g6610af872

