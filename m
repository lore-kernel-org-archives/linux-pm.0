From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/5] tools/power turbostat: hide SKL counters, when not requested
Date: Sat, 24 Jun 2017 20:12:57 -0700
Message-ID: <a99d87306f83d2a97c8c7e854b6583c4037ecf75.1498359826.git.len.brown@intel.com>
References: <1498360381-10293-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34290 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdFYDNJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jun 2017 23:13:09 -0400
Received: by mail-qk0-f195.google.com with SMTP id 91so5113113qkq.1
        for <linux-pm@vger.kernel.org>; Sat, 24 Jun 2017 20:13:09 -0700 (PDT)
In-Reply-To: <1498360381-10293-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Skylake has some new counters, and they were erroneously
exempt  from --show and --hide

eg.

turbostat  --quiet --show CPU
CPU	Totl%C0	Any%C0	GFX%C0	CPUGFX%
-	116.73	90.56	85.69	79.00
0	117.78	91.38	86.47	79.71
2
1
3

is now

CPU
-
0
2
1
3

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 58 +++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 13 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b112947..2b25727 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -57,7 +57,6 @@ unsigned int list_header_only;
 unsigned int dump_only;
 unsigned int do_snb_cstates;
 unsigned int do_knl_cstates;
-unsigned int do_skl_residency;
 unsigned int do_slm_cstates;
 unsigned int use_c1_residency_msr;
 unsigned int has_aperf;
@@ -384,8 +383,14 @@ struct msr_counter bic[] = {
 	{ 0x0, "CPU" },
 	{ 0x0, "Mod%c6" },
 	{ 0x0, "sysfs" },
+	{ 0x0, "Totl%C0" },
+	{ 0x0, "Any%C0" },
+	{ 0x0, "GFX%C0" },
+	{ 0x0, "CPUGFX%" },
 };
 
+
+
 #define MAX_BIC (sizeof(bic) / sizeof(struct msr_counter))
 #define	BIC_Package	(1ULL << 0)
 #define	BIC_Avg_MHz	(1ULL << 1)
@@ -426,6 +431,10 @@ struct msr_counter bic[] = {
 #define	BIC_CPU		(1ULL << 36)
 #define	BIC_Mod_c6	(1ULL << 37)
 #define	BIC_sysfs	(1ULL << 38)
+#define	BIC_Totl_c0	(1ULL << 39)
+#define	BIC_Any_c0	(1ULL << 40)
+#define	BIC_GFX_c0	(1ULL << 41)
+#define	BIC_CPUGFX	(1ULL << 42)
 
 unsigned long long bic_enabled = 0xFFFFFFFFFFFFFFFFULL;
 unsigned long long bic_present = BIC_sysfs;
@@ -599,12 +608,14 @@ void print_header(char *delim)
 	if (DO_BIC(BIC_GFXMHz))
 		outp += sprintf(outp, "%sGFXMHz", (printed++ ? delim : ""));
 
-	if (do_skl_residency) {
+	if (DO_BIC(BIC_Totl_c0))
 		outp += sprintf(outp, "%sTotl%%C0", (printed++ ? delim : ""));
+	if (DO_BIC(BIC_Any_c0))
 		outp += sprintf(outp, "%sAny%%C0", (printed++ ? delim : ""));
+	if (DO_BIC(BIC_GFX_c0))
 		outp += sprintf(outp, "%sGFX%%C0", (printed++ ? delim : ""));
+	if (DO_BIC(BIC_CPUGFX))
 		outp += sprintf(outp, "%sCPUGFX%%", (printed++ ? delim : ""));
-	}
 
 	if (DO_BIC(BIC_Pkgpc2))
 		outp += sprintf(outp, "%sPkg%%pc2", (printed++ ? delim : ""));
@@ -912,12 +923,14 @@ int format_counters(struct thread_data *t, struct core_data *c,
 		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->gfx_mhz);
 
 	/* Totl%C0, Any%C0 GFX%C0 CPUGFX% */
-	if (do_skl_residency) {
+	if (DO_BIC(BIC_Totl_c0))
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_wtd_core_c0/tsc);
+	if (DO_BIC(BIC_Any_c0))
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_any_core_c0/tsc);
+	if (DO_BIC(BIC_GFX_c0))
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_any_gfxe_c0/tsc);
+	if (DO_BIC(BIC_CPUGFX))
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_both_core_gfxe_c0/tsc);
-	}
 
 	if (DO_BIC(BIC_Pkgpc2))
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc2/tsc);
@@ -1038,12 +1051,16 @@ delta_package(struct pkg_data *new, struct pkg_data *old)
 	int i;
 	struct msr_counter *mp;
 
-	if (do_skl_residency) {
+
+	if (DO_BIC(BIC_Totl_c0))
 		old->pkg_wtd_core_c0 = new->pkg_wtd_core_c0 - old->pkg_wtd_core_c0;
+	if (DO_BIC(BIC_Any_c0))
 		old->pkg_any_core_c0 = new->pkg_any_core_c0 - old->pkg_any_core_c0;
+	if (DO_BIC(BIC_GFX_c0))
 		old->pkg_any_gfxe_c0 = new->pkg_any_gfxe_c0 - old->pkg_any_gfxe_c0;
+	if (DO_BIC(BIC_CPUGFX))
 		old->pkg_both_core_gfxe_c0 = new->pkg_both_core_gfxe_c0 - old->pkg_both_core_gfxe_c0;
-	}
+
 	old->pc2 = new->pc2 - old->pc2;
 	if (DO_BIC(BIC_Pkgpc3))
 		old->pc3 = new->pc3 - old->pc3;
@@ -1292,12 +1309,14 @@ int sum_counters(struct thread_data *t, struct core_data *c,
 	if (!(t->flags & CPU_IS_FIRST_CORE_IN_PACKAGE))
 		return 0;
 
-	if (do_skl_residency) {
+	if (DO_BIC(BIC_Totl_c0))
 		average.packages.pkg_wtd_core_c0 += p->pkg_wtd_core_c0;
+	if (DO_BIC(BIC_Any_c0))
 		average.packages.pkg_any_core_c0 += p->pkg_any_core_c0;
+	if (DO_BIC(BIC_GFX_c0))
 		average.packages.pkg_any_gfxe_c0 += p->pkg_any_gfxe_c0;
+	if (DO_BIC(BIC_CPUGFX))
 		average.packages.pkg_both_core_gfxe_c0 += p->pkg_both_core_gfxe_c0;
-	}
 
 	average.packages.pc2 += p->pc2;
 	if (DO_BIC(BIC_Pkgpc3))
@@ -1357,12 +1376,14 @@ void compute_average(struct thread_data *t, struct core_data *c,
 	average.cores.c7 /= topo.num_cores;
 	average.cores.mc6_us /= topo.num_cores;
 
-	if (do_skl_residency) {
+	if (DO_BIC(BIC_Totl_c0))
 		average.packages.pkg_wtd_core_c0 /= topo.num_packages;
+	if (DO_BIC(BIC_Any_c0))
 		average.packages.pkg_any_core_c0 /= topo.num_packages;
+	if (DO_BIC(BIC_GFX_c0))
 		average.packages.pkg_any_gfxe_c0 /= topo.num_packages;
+	if (DO_BIC(BIC_CPUGFX))
 		average.packages.pkg_both_core_gfxe_c0 /= topo.num_packages;
-	}
 
 	average.packages.pc2 /= topo.num_packages;
 	if (DO_BIC(BIC_Pkgpc3))
@@ -1603,13 +1624,19 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (!(t->flags & CPU_IS_FIRST_CORE_IN_PACKAGE))
 		return 0;
 
-	if (do_skl_residency) {
+	if (DO_BIC(BIC_Totl_c0)) {
 		if (get_msr(cpu, MSR_PKG_WEIGHTED_CORE_C0_RES, &p->pkg_wtd_core_c0))
 			return -10;
+	}
+	if (DO_BIC(BIC_Any_c0)) {
 		if (get_msr(cpu, MSR_PKG_ANY_CORE_C0_RES, &p->pkg_any_core_c0))
 			return -11;
+	}
+	if (DO_BIC(BIC_GFX_c0)) {
 		if (get_msr(cpu, MSR_PKG_ANY_GFXE_C0_RES, &p->pkg_any_gfxe_c0))
 			return -12;
+	}
+	if (DO_BIC(BIC_CPUGFX)) {
 		if (get_msr(cpu, MSR_PKG_BOTH_CORE_GFXE_C0_RES, &p->pkg_both_core_gfxe_c0))
 			return -13;
 	}
@@ -4198,7 +4225,12 @@ void process_cpuid()
 		BIC_PRESENT(BIC_Pkgpc10);
 	}
 	do_irtl_hsw = has_hsw_msrs(family, model);
-	do_skl_residency = has_skl_msrs(family, model);
+	if (has_skl_msrs(family, model)) {
+		BIC_PRESENT(BIC_Totl_c0);
+		BIC_PRESENT(BIC_Any_c0);
+		BIC_PRESENT(BIC_GFX_c0);
+		BIC_PRESENT(BIC_CPUGFX);
+	}
 	do_slm_cstates = is_slm(family, model);
 	do_knl_cstates  = is_knl(family, model);
 
-- 
2.7.4
