From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/12] tools/power turbostat: dump MSR_TURBO_RATIO_LIMIT2
Date: Sat, 18 Apr 2015 20:40:21 -0400
Message-ID: <fcd17211bd807533f6d4be20b1a4644e9191bfe2.1429402554.git.len.brown@intel.com>
References: <1429404027-23203-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36005 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbbDSAkw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Apr 2015 20:40:52 -0400
Received: by qgeb100 with SMTP id b100so37905627qge.3
        for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2015 17:40:52 -0700 (PDT)
In-Reply-To: <1429404027-23203-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
References: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

and up to 18 cores of turbo ratio limit
when using the turbostat --debug option.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 141 +++++++++++++++++++++++++---------
 1 file changed, 105 insertions(+), 36 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b699a0e..f05a3f7 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -65,8 +65,6 @@ unsigned int units = 1000000;	/* MHz etc */
 unsigned int genuine_intel;
 unsigned int has_invariant_tsc;
 unsigned int do_nhm_platform_info;
-unsigned int do_nhm_turbo_ratio_limit;
-unsigned int do_ivt_turbo_ratio_limit;
 unsigned int extra_msr_offset32;
 unsigned int extra_msr_offset64;
 unsigned int extra_delta_offset32;
@@ -1078,14 +1076,12 @@ int slv_pkg_cstate_limits[8] = {PCL__0, PCL__1, PCLRSV, PCLRSV, PCL__4, PCLRSV,
 int amt_pkg_cstate_limits[8] = {PCL__0, PCL__1, PCL__2, PCLRSV, PCLRSV, PCLRSV, PCL__6, PCL__7};
 int phi_pkg_cstate_limits[8] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL};
 
-void dump_system_config_info(void)
+static void
+dump_nhm_platform_info(void)
 {
 	unsigned long long msr;
 	unsigned int ratio;
 
-	if (!do_nhm_platform_info)
-		return;
-
 	get_msr(0, MSR_NHM_PLATFORM_INFO, &msr);
 
 	fprintf(stderr, "cpu0: MSR_NHM_PLATFORM_INFO: 0x%08llx\n", msr);
@@ -1102,8 +1098,36 @@ void dump_system_config_info(void)
 	fprintf(stderr, "cpu0: MSR_IA32_POWER_CTL: 0x%08llx (C1E auto-promotion: %sabled)\n",
 		msr, msr & 0x2 ? "EN" : "DIS");
 
-	if (!do_ivt_turbo_ratio_limit)
-		goto print_nhm_turbo_ratio_limits;
+	return;
+}
+
+static void
+dump_hsw_turbo_ratio_limits(void)
+{
+	unsigned long long msr;
+	unsigned int ratio;
+
+	get_msr(0, MSR_TURBO_RATIO_LIMIT2, &msr);
+
+	fprintf(stderr, "cpu0: MSR_TURBO_RATIO_LIMIT2: 0x%08llx\n", msr);
+
+	ratio = (msr >> 8) & 0xFF;
+	if (ratio)
+		fprintf(stderr, "%d * %.0f = %.0f MHz max turbo 18 active cores\n",
+			ratio, bclk, ratio * bclk);
+
+	ratio = (msr >> 0) & 0xFF;
+	if (ratio)
+		fprintf(stderr, "%d * %.0f = %.0f MHz max turbo 17 active cores\n",
+			ratio, bclk, ratio * bclk);
+	return;
+}
+
+static void
+dump_ivt_turbo_ratio_limits(void)
+{
+	unsigned long long msr;
+	unsigned int ratio;
 
 	get_msr(0, MSR_TURBO_RATIO_LIMIT1, &msr);
 
@@ -1148,26 +1172,14 @@ void dump_system_config_info(void)
 	if (ratio)
 		fprintf(stderr, "%d * %.0f = %.0f MHz max turbo 9 active cores\n",
 			ratio, bclk, ratio * bclk);
+	return;
+}
 
-print_nhm_turbo_ratio_limits:
-	get_msr(0, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
-
-#define SNB_C1_AUTO_UNDEMOTE              (1UL << 27)
-#define SNB_C3_AUTO_UNDEMOTE              (1UL << 28)
-
-	fprintf(stderr, "cpu0: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x%08llx", msr);
-
-	fprintf(stderr, " (%s%s%s%s%slocked: pkg-cstate-limit=%d: %s)\n",
-		(msr & SNB_C3_AUTO_UNDEMOTE) ? "UNdemote-C3, " : "",
-		(msr & SNB_C1_AUTO_UNDEMOTE) ? "UNdemote-C1, " : "",
-		(msr & NHM_C3_AUTO_DEMOTE) ? "demote-C3, " : "",
-		(msr & NHM_C1_AUTO_DEMOTE) ? "demote-C1, " : "",
-		(msr & (1 << 15)) ? "" : "UN",
-		(unsigned int)msr & 7,
-		pkg_cstate_limit_strings[pkg_cstate_limit]);
-
-	if (!do_nhm_turbo_ratio_limit)
-		return;
+static void
+dump_nhm_turbo_ratio_limits(void)
+{
+	unsigned long long msr;
+	unsigned int ratio;
 
 	get_msr(0, MSR_TURBO_RATIO_LIMIT, &msr);
 
@@ -1212,7 +1224,30 @@ print_nhm_turbo_ratio_limits:
 	if (ratio)
 		fprintf(stderr, "%d * %.0f = %.0f MHz max turbo 1 active cores\n",
 			ratio, bclk, ratio * bclk);
+	return;
+}
 
+static void
+dump_nhm_cst_cfg(void)
+{
+	unsigned long long msr;
+
+	get_msr(0, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
+
+#define SNB_C1_AUTO_UNDEMOTE              (1UL << 27)
+#define SNB_C3_AUTO_UNDEMOTE              (1UL << 28)
+
+	fprintf(stderr, "cpu0: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x%08llx", msr);
+
+	fprintf(stderr, " (%s%s%s%s%slocked: pkg-cstate-limit=%d: %s)\n",
+		(msr & SNB_C3_AUTO_UNDEMOTE) ? "UNdemote-C3, " : "",
+		(msr & SNB_C1_AUTO_UNDEMOTE) ? "UNdemote-C1, " : "",
+		(msr & NHM_C3_AUTO_DEMOTE) ? "demote-C3, " : "",
+		(msr & NHM_C1_AUTO_DEMOTE) ? "demote-C1, " : "",
+		(msr & (1 << 15)) ? "" : "UN",
+		(unsigned int)msr & 7,
+		pkg_cstate_limit_strings[pkg_cstate_limit]);
+	return;
 }
 
 void free_all_buffers(void)
@@ -1625,12 +1660,49 @@ int has_ivt_turbo_ratio_limit(unsigned int family, unsigned int model)
 
 	switch (model) {
 	case 0x3E:	/* IVB Xeon */
+	case 0x3F:	/* HSW Xeon */
+		return 1;
+	default:
+		return 0;
+	}
+}
+int has_hsw_turbo_ratio_limit(unsigned int family, unsigned int model)
+{
+	if (!genuine_intel)
+		return 0;
+
+	if (family != 6)
+		return 0;
+
+	switch (model) {
+	case 0x3F:	/* HSW Xeon */
 		return 1;
 	default:
 		return 0;
 	}
 }
 
+static void
+dump_cstate_pstate_config_info(family, model)
+{
+	if (!do_nhm_platform_info)
+		return;
+
+	dump_nhm_platform_info();
+
+	if (has_hsw_turbo_ratio_limit(family, model))
+		dump_hsw_turbo_ratio_limits();
+
+	if (has_ivt_turbo_ratio_limit(family, model))
+		dump_ivt_turbo_ratio_limits();
+
+	if (has_nhm_turbo_ratio_limit(family, model))
+		dump_nhm_turbo_ratio_limits();
+
+	dump_nhm_cst_cfg();
+}
+
+
 /*
  * print_epb()
  * Decode the ENERGY_PERF_BIAS MSR
@@ -2238,7 +2310,7 @@ guess:
 
 	return 0;
 }
-void check_cpuid()
+void process_cpuid()
 {
 	unsigned int eax, ebx, ecx, edx, max_level;
 	unsigned int fms, family, model, stepping;
@@ -2314,15 +2386,15 @@ void check_cpuid()
 	do_slm_cstates = is_slm(family, model);
 	bclk = discover_bclk(family, model);
 
-	do_nhm_turbo_ratio_limit = do_nhm_platform_info && has_nhm_turbo_ratio_limit(family, model);
-	do_ivt_turbo_ratio_limit = has_ivt_turbo_ratio_limit(family, model);
 	rapl_probe(family, model);
 	perf_limit_reasons_probe(family, model);
 
+	if (debug)
+		dump_cstate_pstate_config_info();
+
 	return;
 }
 
-
 void help()
 {
 	fprintf(stderr,
@@ -2560,14 +2632,11 @@ void turbostat_init()
 {
 	check_dev_msr();
 	check_permissions();
-	check_cpuid();
+	process_cpuid();
 
 	setup_all_buffers();
 
 	if (debug)
-		dump_system_config_info();
-
-	if (debug)
 		for_all_cpus(print_epb, ODD_COUNTERS);
 
 	if (debug)
@@ -2644,7 +2713,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(stderr, "turbostat version 4.1 10-Feb, 2015"
+	fprintf(stderr, "turbostat version 4.2 23 Mar, 2015"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.4.0.rc1

