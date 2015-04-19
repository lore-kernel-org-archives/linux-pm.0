From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/12] tools/power turbostat: Initial Skylake support
Date: Sat, 18 Apr 2015 20:40:24 -0400
Message-ID: <0b2bb6925eb602eae993a4b5c282a8c18ad1c949.1429402554.git.len.brown@intel.com>
References: <1429404027-23203-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33430 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbbDSAk5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Apr 2015 20:40:57 -0400
Received: by qkx62 with SMTP id 62so169762379qkx.0
        for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2015 17:40:56 -0700 (PDT)
In-Reply-To: <1429404027-23203-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
References: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Skylake adds some additional residency counters.

Skylake supports a different mix of RAPL registers
from any previous product.

In most other ways, Skylake is like Broadwell.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/uapi/asm/msr-index.h |   5 ++
 tools/power/x86/turbostat/turbostat.c | 124 ++++++++++++++++++++++++++++++----
 2 files changed, 116 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/uapi/asm/msr-index.h b/arch/x86/include/uapi/asm/msr-index.h
index c4c7527..fe01b0a 100644
--- a/arch/x86/include/uapi/asm/msr-index.h
+++ b/arch/x86/include/uapi/asm/msr-index.h
@@ -150,6 +150,11 @@
 #define MSR_PP1_ENERGY_STATUS		0x00000641
 #define MSR_PP1_POLICY			0x00000642
 
+#define MSR_PKG_WEIGHTED_CORE_C0_RES	0x00000658
+#define MSR_PKG_ANY_CORE_C0_RES		0x00000659
+#define MSR_PKG_ANY_GFXE_C0_RES		0x0000065A
+#define MSR_PKG_BOTH_CORE_GFXE_C0_RES	0x0000065B
+
 #define MSR_CORE_C1_RES			0x00000660
 
 #define MSR_CC6_DEMOTION_POLICY_CONFIG	0x00000668
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 50341a3..ad56889 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -57,6 +57,7 @@ unsigned int do_pc3;
 unsigned int do_pc6;
 unsigned int do_pc7;
 unsigned int do_c8_c9_c10;
+unsigned int do_skl_residency;
 unsigned int do_slm_cstates;
 unsigned int use_c1_residency_msr;
 unsigned int has_aperf;
@@ -99,18 +100,18 @@ unsigned int do_ring_perf_limit_reasons;
 #define RAPL_DRAM		(1 << 3)
 					/* 0x618 MSR_DRAM_POWER_LIMIT */
 					/* 0x619 MSR_DRAM_ENERGY_STATUS */
-					/* 0x61c MSR_DRAM_POWER_INFO */
 #define RAPL_DRAM_PERF_STATUS	(1 << 4)
 					/* 0x61b MSR_DRAM_PERF_STATUS */
+#define RAPL_DRAM_POWER_INFO	(1 << 5)
+					/* 0x61c MSR_DRAM_POWER_INFO */
 
-#define RAPL_CORES		(1 << 5)
+#define RAPL_CORES		(1 << 6)
 					/* 0x638 MSR_PP0_POWER_LIMIT */
 					/* 0x639 MSR_PP0_ENERGY_STATUS */
-#define RAPL_CORE_POLICY	(1 << 6)
+#define RAPL_CORE_POLICY	(1 << 7)
 					/* 0x63a MSR_PP0_POLICY */
 
-
-#define RAPL_GFX		(1 << 7)
+#define RAPL_GFX		(1 << 8)
 					/* 0x640 MSR_PP1_POWER_LIMIT */
 					/* 0x641 MSR_PP1_ENERGY_STATUS */
 					/* 0x642 MSR_PP1_POLICY */
@@ -157,6 +158,10 @@ struct pkg_data {
 	unsigned long long pc8;
 	unsigned long long pc9;
 	unsigned long long pc10;
+	unsigned long long pkg_wtd_core_c0;
+	unsigned long long pkg_any_core_c0;
+	unsigned long long pkg_any_gfxe_c0;
+	unsigned long long pkg_both_core_gfxe_c0;
 	unsigned int package_id;
 	unsigned int energy_pkg;	/* MSR_PKG_ENERGY_STATUS */
 	unsigned int energy_dram;	/* MSR_DRAM_ENERGY_STATUS */
@@ -320,6 +325,13 @@ void print_header(void)
 	if (do_ptm)
 		outp += sprintf(outp, "  PkgTmp");
 
+	if (do_skl_residency) {
+		outp += sprintf(outp, " Totl%%C0");
+		outp += sprintf(outp, "  Any%%C0");
+		outp += sprintf(outp, "  GFX%%C0");
+		outp += sprintf(outp, " CPUGFX%%");
+	}
+
 	if (do_pc2)
 		outp += sprintf(outp, " Pkg%%pc2");
 	if (do_pc3)
@@ -401,6 +413,12 @@ int dump_counters(struct thread_data *t, struct core_data *c,
 
 	if (p) {
 		outp += sprintf(outp, "package: %d\n", p->package_id);
+
+		outp += sprintf(outp, "Weighted cores: %016llX\n", p->pkg_wtd_core_c0);
+		outp += sprintf(outp, "Any cores: %016llX\n", p->pkg_any_core_c0);
+		outp += sprintf(outp, "Any GFX: %016llX\n", p->pkg_any_gfxe_c0);
+		outp += sprintf(outp, "CPU + GFX: %016llX\n", p->pkg_both_core_gfxe_c0);
+
 		outp += sprintf(outp, "pc2: %016llX\n", p->pc2);
 		if (do_pc3)
 			outp += sprintf(outp, "pc3: %016llX\n", p->pc3);
@@ -539,9 +557,18 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	if (!(t->flags & CPU_IS_FIRST_CORE_IN_PACKAGE))
 		goto done;
 
+	/* PkgTmp */
 	if (do_ptm)
 		outp += sprintf(outp, "%8d", p->pkg_temp_c);
 
+	/* Totl%C0, Any%C0 GFX%C0 CPUGFX% */
+	if (do_skl_residency) {
+		outp += sprintf(outp, "%8.2f", 100.0 * p->pkg_wtd_core_c0/t->tsc);
+		outp += sprintf(outp, "%8.2f", 100.0 * p->pkg_any_core_c0/t->tsc);
+		outp += sprintf(outp, "%8.2f", 100.0 * p->pkg_any_gfxe_c0/t->tsc);
+		outp += sprintf(outp, "%8.2f", 100.0 * p->pkg_both_core_gfxe_c0/t->tsc);
+	}
+
 	if (do_pc2)
 		outp += sprintf(outp, "%8.2f", 100.0 * p->pc2/t->tsc);
 	if (do_pc3)
@@ -644,6 +671,13 @@ void format_all_counters(struct thread_data *t, struct core_data *c, struct pkg_
 void
 delta_package(struct pkg_data *new, struct pkg_data *old)
 {
+
+	if (do_skl_residency) {
+		old->pkg_wtd_core_c0 = new->pkg_wtd_core_c0 - old->pkg_wtd_core_c0;
+		old->pkg_any_core_c0 = new->pkg_any_core_c0 - old->pkg_any_core_c0;
+		old->pkg_any_gfxe_c0 = new->pkg_any_gfxe_c0 - old->pkg_any_gfxe_c0;
+		old->pkg_both_core_gfxe_c0 = new->pkg_both_core_gfxe_c0 - old->pkg_both_core_gfxe_c0;
+	}
 	old->pc2 = new->pc2 - old->pc2;
 	if (do_pc3)
 		old->pc3 = new->pc3 - old->pc3;
@@ -790,6 +824,11 @@ void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	c->c7 = 0;
 	c->core_temp_c = 0;
 
+	p->pkg_wtd_core_c0 = 0;
+	p->pkg_any_core_c0 = 0;
+	p->pkg_any_gfxe_c0 = 0;
+	p->pkg_both_core_gfxe_c0 = 0;
+
 	p->pc2 = 0;
 	if (do_pc3)
 		p->pc3 = 0;
@@ -834,6 +873,13 @@ int sum_counters(struct thread_data *t, struct core_data *c,
 	if (!(t->flags & CPU_IS_FIRST_CORE_IN_PACKAGE))
 		return 0;
 
+	if (do_skl_residency) {
+		average.packages.pkg_wtd_core_c0 += p->pkg_wtd_core_c0;
+		average.packages.pkg_any_core_c0 += p->pkg_any_core_c0;
+		average.packages.pkg_any_gfxe_c0 += p->pkg_any_gfxe_c0;
+		average.packages.pkg_both_core_gfxe_c0 += p->pkg_both_core_gfxe_c0;
+	}
+
 	average.packages.pc2 += p->pc2;
 	if (do_pc3)
 		average.packages.pc3 += p->pc3;
@@ -881,6 +927,13 @@ void compute_average(struct thread_data *t, struct core_data *c,
 	average.cores.c6 /= topo.num_cores;
 	average.cores.c7 /= topo.num_cores;
 
+	if (do_skl_residency) {
+		average.packages.pkg_wtd_core_c0 /= topo.num_packages;
+		average.packages.pkg_any_core_c0 /= topo.num_packages;
+		average.packages.pkg_any_gfxe_c0 /= topo.num_packages;
+		average.packages.pkg_both_core_gfxe_c0 /= topo.num_packages;
+	}
+
 	average.packages.pc2 /= topo.num_packages;
 	if (do_pc3)
 		average.packages.pc3 /= topo.num_packages;
@@ -987,6 +1040,16 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (!(t->flags & CPU_IS_FIRST_CORE_IN_PACKAGE))
 		return 0;
 
+	if (do_skl_residency) {
+		if (get_msr(cpu, MSR_PKG_WEIGHTED_CORE_C0_RES, &p->pkg_wtd_core_c0))
+			return -10;
+		if (get_msr(cpu, MSR_PKG_ANY_CORE_C0_RES, &p->pkg_any_core_c0))
+			return -11;
+		if (get_msr(cpu, MSR_PKG_ANY_GFXE_C0_RES, &p->pkg_any_gfxe_c0))
+			return -12;
+		if (get_msr(cpu, MSR_PKG_BOTH_CORE_GFXE_C0_RES, &p->pkg_both_core_gfxe_c0))
+			return -13;
+	}
 	if (do_pc3)
 		if (get_msr(cpu, MSR_PKG_C3_RESIDENCY, &p->pc3))
 			return -9;
@@ -1063,15 +1126,18 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 #define PCL_6R 9 /* PC6 Retention */
 #define PCL__7 10 /* PC7 */
 #define PCL_7S 11 /* PC7 Shrink */
-#define PCLUNL 12 /* Unlimited */
+#define PCL__8 12 /* PC8 */
+#define PCL__9 13 /* PC9 */
+#define PCLUNL 14 /* Unlimited */
 
 int pkg_cstate_limit = PCLUKN;
 char *pkg_cstate_limit_strings[] = { "reserved", "unknown", "pc0", "pc1", "pc2",
-	"pc3", "pc4", "pc6", "pc6n", "pc6r", "pc7", "pc7s", "unlimited"};
+	"pc3", "pc4", "pc6", "pc6n", "pc6r", "pc7", "pc7s", "pc8", "pc9", "unlimited"};
 
 int nhm_pkg_cstate_limits[8] = {PCL__0, PCL__1, PCL__3, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLUNL};
 int snb_pkg_cstate_limits[8] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCL__7, PCL_7S, PCLRSV, PCLUNL};
 int hsw_pkg_cstate_limits[8] = {PCL__0, PCL__2, PCL__3, PCL__6, PCL__7, PCL_7S, PCLRSV, PCLUNL};
+int skl_pkg_cstate_limits[8] = {PCL__0, PCL__2, PCL__3, PCL__6, PCL__7, PCL_7S, PCL__8, PCL__9};
 int slv_pkg_cstate_limits[8] = {PCL__0, PCL__1, PCLRSV, PCLRSV, PCL__4, PCLRSV, PCL__6, PCL__7};
 int amt_pkg_cstate_limits[8] = {PCL__0, PCL__1, PCL__2, PCLRSV, PCLRSV, PCLRSV, PCL__6, PCL__7};
 int phi_pkg_cstate_limits[8] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL};
@@ -1619,6 +1685,8 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	case 0x47:	/* BDW */
 	case 0x4F:	/* BDX */
 	case 0x56:	/* BDX-DE */
+	case 0x4E:	/* SKL */
+	case 0x5E:	/* SKL */
 		pkg_cstate_limits = hsw_pkg_cstate_limits;
 		break;
 	case 0x37:	/* BYT */
@@ -1895,14 +1963,18 @@ void rapl_probe(unsigned int family, unsigned int model)
 	case 0x47:	/* BDW */
 		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_GFX | RAPL_PKG_POWER_INFO;
 		break;
+	case 0x4E:	/* SKL */
+	case 0x5E:	/* SKL */
+		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
+		break;
 	case 0x3F:	/* HSX */
 	case 0x4F:	/* BDX */
 	case 0x56:	/* BDX-DE */
-		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
+		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
 		break;
 	case 0x2D:
 	case 0x3E:
-		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_DRAM | RAPL_PKG_PERF_STATUS | RAPL_DRAM_PERF_STATUS | RAPL_PKG_POWER_INFO;
+		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_PKG_PERF_STATUS | RAPL_DRAM_PERF_STATUS | RAPL_PKG_POWER_INFO;
 		break;
 	case 0x37:	/* BYT */
 	case 0x4D:	/* AVN */
@@ -2092,19 +2164,18 @@ int print_rapl(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 			((msr >> 48) & 1) ? "EN" : "DIS");
 	}
 
-	if (do_rapl & RAPL_DRAM) {
+	if (do_rapl & RAPL_DRAM_POWER_INFO) {
 		if (get_msr(cpu, MSR_DRAM_POWER_INFO, &msr))
                 	return -6;
 
-
 		fprintf(stderr, "cpu%d: MSR_DRAM_POWER_INFO,: 0x%08llx (%.0f W TDP, RAPL %.0f - %.0f W, %f sec.)\n",
 			cpu, msr,
 			((msr >>  0) & RAPL_POWER_GRANULARITY) * rapl_power_units,
 			((msr >> 16) & RAPL_POWER_GRANULARITY) * rapl_power_units,
 			((msr >> 32) & RAPL_POWER_GRANULARITY) * rapl_power_units,
 			((msr >> 48) & RAPL_TIME_GRANULARITY) * rapl_time_units);
-
-
+	}
+	if (do_rapl & RAPL_DRAM) {
 		if (get_msr(cpu, MSR_DRAM_POWER_LIMIT, &msr))
 			return -9;
 		fprintf(stderr, "cpu%d: MSR_DRAM_POWER_LIMIT: 0x%08llx (%slocked)\n",
@@ -2173,6 +2244,8 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case 0x47:	/* BDW */
 	case 0x4F:	/* BDX */
 	case 0x56:	/* BDX-DE */
+	case 0x4E:	/* SKL */
+	case 0x5E:	/* SKL */
 		return 1;
 	}
 	return 0;
@@ -2193,12 +2266,36 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
 	switch (model) {
 	case 0x45:	/* HSW */
 	case 0x3D:	/* BDW */
+	case 0x4E:	/* SKL */
+	case 0x5E:	/* SKL */
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * SKL adds support for additional MSRS:
+ *
+ * MSR_PKG_WEIGHTED_CORE_C0_RES    0x00000658
+ * MSR_PKG_ANY_CORE_C0_RES         0x00000659
+ * MSR_PKG_ANY_GFXE_C0_RES         0x0000065A
+ * MSR_PKG_BOTH_CORE_GFXE_C0_RES   0x0000065B
+ */
+int has_skl_msrs(unsigned int family, unsigned int model)
+{
+	if (!genuine_intel)
+		return 0;
+
+	switch (model) {
+	case 0x4E:	/* SKL */
+	case 0x5E:	/* SKL */
 		return 1;
 	}
 	return 0;
 }
 
 
+
 int is_slm(unsigned int family, unsigned int model)
 {
 	if (!genuine_intel)
@@ -2384,6 +2481,7 @@ void process_cpuid()
 	do_pc6 = (pkg_cstate_limit >= PCL__6);
 	do_pc7 = do_snb_cstates && (pkg_cstate_limit >= PCL__7);
 	do_c8_c9_c10 = has_hsw_msrs(family, model);
+	do_skl_residency = has_skl_msrs(family, model);
 	do_slm_cstates = is_slm(family, model);
 	bclk = discover_bclk(family, model);
 
-- 
2.4.0.rc1

