From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/5] tools/power turbostat: enable turbostat to support Knights Landing (KNL)
Date: Wed, 27 May 2015 18:08:03 -0400
Message-ID: <fb5d432722e186c656285ccc088e35dbe24f6fd1.1432764245.git.len.brown@intel.com>
References: <1432764486-3517-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35612 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbbE0WIT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 18:08:19 -0400
Received: by qgg60 with SMTP id 60so9305915qgg.2
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2015 15:08:19 -0700 (PDT)
In-Reply-To: <1432764486-3517-1-git-send-email-lenb@kernel.org>
In-Reply-To: <e275b3885dffd31095984ed2476ed0447fa7309a.1432764245.git.len.brown@intel.com>
References: <e275b3885dffd31095984ed2476ed0447fa7309a.1432764245.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>, Len Brown <len.brown@intel.com>

From: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>

Changes mainly to account for minor differences in Knights Landing(KNL):
1. KNL supports C1 and C6 core states.
2. KNL supports PC2, PC3 and PC6 package states.
3. KNL has a different encoding of the TURBO_RATIO_LIMIT MSR

Signed-off-by: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/uapi/asm/msr-index.h |   1 +
 tools/power/x86/turbostat/turbostat.c | 105 ++++++++++++++++++++++++++++++++--
 2 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/uapi/asm/msr-index.h b/arch/x86/include/uapi/asm/msr-index.h
index c469490..3c6bb34 100644
--- a/arch/x86/include/uapi/asm/msr-index.h
+++ b/arch/x86/include/uapi/asm/msr-index.h
@@ -140,6 +140,7 @@
 #define MSR_CORE_C3_RESIDENCY		0x000003fc
 #define MSR_CORE_C6_RESIDENCY		0x000003fd
 #define MSR_CORE_C7_RESIDENCY		0x000003fe
+#define MSR_KNL_CORE_C6_RESIDENCY	0x000003ff
 #define MSR_PKG_C2_RESIDENCY		0x0000060d
 #define MSR_PKG_C8_RESIDENCY		0x00000630
 #define MSR_PKG_C9_RESIDENCY		0x00000631
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index d85adba..256a5e1 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -52,6 +52,7 @@ unsigned int skip_c0;
 unsigned int skip_c1;
 unsigned int do_nhm_cstates;
 unsigned int do_snb_cstates;
+unsigned int do_knl_cstates;
 unsigned int do_pc2;
 unsigned int do_pc3;
 unsigned int do_pc6;
@@ -316,7 +317,7 @@ void print_header(void)
 
 	if (do_nhm_cstates)
 		outp += sprintf(outp, "  CPU%%c1");
-	if (do_nhm_cstates && !do_slm_cstates)
+	if (do_nhm_cstates && !do_slm_cstates && !do_knl_cstates)
 		outp += sprintf(outp, "  CPU%%c3");
 	if (do_nhm_cstates)
 		outp += sprintf(outp, "  CPU%%c6");
@@ -546,7 +547,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	if (!(t->flags & CPU_IS_FIRST_THREAD_IN_CORE))
 		goto done;
 
-	if (do_nhm_cstates && !do_slm_cstates)
+	if (do_nhm_cstates && !do_slm_cstates && !do_knl_cstates)
 		outp += sprintf(outp, "%8.2f", 100.0 * c->c3/t->tsc);
 	if (do_nhm_cstates)
 		outp += sprintf(outp, "%8.2f", 100.0 * c->c6/t->tsc);
@@ -1018,14 +1019,17 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (!(t->flags & CPU_IS_FIRST_THREAD_IN_CORE))
 		return 0;
 
-	if (do_nhm_cstates && !do_slm_cstates) {
+	if (do_nhm_cstates && !do_slm_cstates && !do_knl_cstates) {
 		if (get_msr(cpu, MSR_CORE_C3_RESIDENCY, &c->c3))
 			return -6;
 	}
 
-	if (do_nhm_cstates) {
+	if (do_nhm_cstates && !do_knl_cstates) {
 		if (get_msr(cpu, MSR_CORE_C6_RESIDENCY, &c->c6))
 			return -7;
+	} else if (do_knl_cstates) {
+		if (get_msr(cpu, MSR_KNL_CORE_C6_RESIDENCY, &c->c6))
+			return -7;
 	}
 
 	if (do_snb_cstates)
@@ -1296,6 +1300,67 @@ dump_nhm_turbo_ratio_limits(void)
 }
 
 static void
+dump_knl_turbo_ratio_limits(void)
+{
+	int cores;
+	unsigned int ratio;
+	unsigned long long msr;
+	int delta_cores;
+	int delta_ratio;
+	int i;
+
+	get_msr(0, MSR_NHM_TURBO_RATIO_LIMIT, &msr);
+
+	fprintf(stderr, "cpu0: MSR_NHM_TURBO_RATIO_LIMIT: 0x%08llx\n",
+	msr);
+
+	/**
+	 * Turbo encoding in KNL is as follows:
+	 * [7:0] -- Base value of number of active cores of bucket 1.
+	 * [15:8] -- Base value of freq ratio of bucket 1.
+	 * [20:16] -- +ve delta of number of active cores of bucket 2.
+	 * i.e. active cores of bucket 2 =
+	 * active cores of bucket 1 + delta
+	 * [23:21] -- Negative delta of freq ratio of bucket 2.
+	 * i.e. freq ratio of bucket 2 =
+	 * freq ratio of bucket 1 - delta
+	 * [28:24]-- +ve delta of number of active cores of bucket 3.
+	 * [31:29]-- -ve delta of freq ratio of bucket 3.
+	 * [36:32]-- +ve delta of number of active cores of bucket 4.
+	 * [39:37]-- -ve delta of freq ratio of bucket 4.
+	 * [44:40]-- +ve delta of number of active cores of bucket 5.
+	 * [47:45]-- -ve delta of freq ratio of bucket 5.
+	 * [52:48]-- +ve delta of number of active cores of bucket 6.
+	 * [55:53]-- -ve delta of freq ratio of bucket 6.
+	 * [60:56]-- +ve delta of number of active cores of bucket 7.
+	 * [63:61]-- -ve delta of freq ratio of bucket 7.
+	 */
+	cores = msr & 0xFF;
+	ratio = (msr >> 8) && 0xFF;
+	if (ratio > 0)
+		fprintf(stderr,
+			"%d * %.0f = %.0f MHz max turbo %d active cores\n",
+			ratio, bclk, ratio * bclk, cores);
+
+	for (i = 16; i < 64; i = i + 8) {
+		delta_cores = (msr >> i) & 0x1F;
+		delta_ratio = (msr >> (i + 5)) && 0x7;
+		if (!delta_cores || !delta_ratio)
+			return;
+		cores = cores + delta_cores;
+		ratio = ratio - delta_ratio;
+
+		/** -ve ratios will make successive ratio calculations
+		 * negative. Hence return instead of carrying on.
+		 */
+		if (ratio > 0)
+			fprintf(stderr,
+				"%d * %.0f = %.0f MHz max turbo %d active cores\n",
+				ratio, bclk, ratio * bclk, cores);
+	}
+}
+
+static void
 dump_nhm_cst_cfg(void)
 {
 	unsigned long long msr;
@@ -1788,6 +1853,21 @@ int has_hsw_turbo_ratio_limit(unsigned int family, unsigned int model)
 	}
 }
 
+int has_knl_turbo_ratio_limit(unsigned int family, unsigned int model)
+{
+	if (!genuine_intel)
+		return 0;
+
+	if (family != 6)
+		return 0;
+
+	switch (model) {
+	case 0x57:	/* Knights Landing */
+		return 1;
+	default:
+		return 0;
+	}
+}
 static void
 dump_cstate_pstate_config_info(family, model)
 {
@@ -1805,6 +1885,9 @@ dump_cstate_pstate_config_info(family, model)
 	if (has_nhm_turbo_ratio_limit(family, model))
 		dump_nhm_turbo_ratio_limits();
 
+	if (has_knl_turbo_ratio_limit(family, model))
+		dump_knl_turbo_ratio_limits();
+
 	dump_nhm_cst_cfg();
 }
 
@@ -1985,6 +2068,7 @@ rapl_dram_energy_units_probe(int  model, double rapl_energy_units)
 	case 0x3F:	/* HSX */
 	case 0x4F:	/* BDX */
 	case 0x56:	/* BDX-DE */
+	case 0x57:	/* KNL */
 		return (rapl_dram_energy_units = 15.3 / 1000000);
 	default:
 		return (rapl_energy_units);
@@ -2026,6 +2110,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 	case 0x3F:	/* HSX */
 	case 0x4F:	/* BDX */
 	case 0x56:	/* BDX-DE */
+	case 0x57:	/* KNL */
 		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
 		break;
 	case 0x2D:
@@ -2366,6 +2451,17 @@ int is_slm(unsigned int family, unsigned int model)
 	return 0;
 }
 
+int is_knl(unsigned int family, unsigned int model)
+{
+	if (!genuine_intel)
+		return 0;
+	switch (model) {
+	case 0x57:	/* KNL */
+		return 1;
+	}
+	return 0;
+}
+
 #define SLM_BCLK_FREQS 5
 double slm_freq_table[SLM_BCLK_FREQS] = { 83.3, 100.0, 133.3, 116.7, 80.0};
 
@@ -2576,6 +2672,7 @@ void process_cpuid()
 	do_c8_c9_c10 = has_hsw_msrs(family, model);
 	do_skl_residency = has_skl_msrs(family, model);
 	do_slm_cstates = is_slm(family, model);
+	do_knl_cstates  = is_knl(family, model);
 	bclk = discover_bclk(family, model);
 
 	rapl_probe(family, model);
-- 
2.4.1.314.g9532ead

