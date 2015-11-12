From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/4] tools/power turbostat: simplify Bzy_MHz calculation
Date: Thu, 12 Nov 2015 02:42:29 -0500
Message-ID: <22c227bf47c6812dd8ac4e59cae4acd3fec74272.1447313797.git.len.brown@intel.com>
References: <1447314152-2145-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36252 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbbKLHnL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2015 02:43:11 -0500
Received: by ykdr82 with SMTP id r82so86157243ykd.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2015 23:43:10 -0800 (PST)
In-Reply-To: <1447314152-2145-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Bzy_MHz = TSC_delta*tsc_tweak/APERF_delta/MPERF_delta/measurement_interval

becomes...

Bzy_MHz = base_mhz/APERF_delta/MPERF_delta

on systems which support MSR_PLATFORM_INFO.

base_mhz is calculated directly from the base_ratio
reported in MSR_PLATFORM_INFO * bclk,
and bclk is discovered via MSR or cpuid.

This reduces the dependency of Bzy_MHz calculation on the TSC.
Previously, there were 4 TSC readings required in each calculation,
the raw TSC delta combined with the measurement_interval.
This also removes the "tsc_tweak" correction factor used when
TSC runs on a different base clock from the CPU's bclk.

After this change, tsc_tweak is used only for %Busy.

The end-result should be a Bzy_MHz result slightly less prone to jitter.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bde0ef1..346bb54 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -75,6 +75,7 @@ unsigned int aperf_mperf_multiplier = 1;
 int do_smi;
 double bclk;
 double base_hz;
+unsigned int has_base_hz;
 double tsc_tweak = 1.0;
 unsigned int show_pkg;
 unsigned int show_core;
@@ -96,6 +97,7 @@ unsigned int do_ring_perf_limit_reasons;
 unsigned int crystal_hz;
 unsigned long long tsc_hz;
 int base_cpu;
+double discover_bclk(unsigned int family, unsigned int model);
 
 #define RAPL_PKG		(1 << 0)
 					/* 0x610 MSR_PKG_POWER_LIMIT */
@@ -505,15 +507,22 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	/* %Busy */
 	if (has_aperf) {
 		if (!skip_c0)
-			outp += sprintf(outp, "%8.2f", 100.0 * t->mperf/t->tsc/tsc_tweak);
+			outp += sprintf(outp, "%8.2f",
+				100.0 * t->mperf/t->tsc/tsc_tweak);
 		else
 			outp += sprintf(outp, "********");
 	}
 
 	/* Bzy_MHz */
-	if (has_aperf)
-		outp += sprintf(outp, "%8.0f",
-			1.0 * t->tsc * tsc_tweak / units * t->aperf / t->mperf / interval_float);
+	if (has_aperf) {
+		if (has_base_hz)
+			outp += sprintf(outp, "%8.0f", base_hz /
+				units * t->aperf / t->mperf);
+		else
+			outp += sprintf(outp, "%8.0f",
+				1.0 * t->tsc / units * t->aperf /
+				t->mperf / interval_float);
+	}
 
 	/* TSC_MHz */
 	outp += sprintf(outp, "%8.0f", 1.0 * t->tsc/units/interval_float);
@@ -1158,12 +1167,6 @@ int phi_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV,
 static void
 calculate_tsc_tweak()
 {
-	unsigned long long msr;
-	unsigned int base_ratio;
-
-	get_msr(base_cpu, MSR_NHM_PLATFORM_INFO, &msr);
-	base_ratio = (msr >> 8) & 0xFF;
-	base_hz = base_ratio * bclk * 1000000;
 	tsc_tweak = base_hz / tsc_hz;
 }
 
@@ -1821,6 +1824,7 @@ void check_permissions()
 int probe_nhm_msrs(unsigned int family, unsigned int model)
 {
 	unsigned long long msr;
+	unsigned int base_ratio;
 	int *pkg_cstate_limits;
 
 	if (!genuine_intel)
@@ -1829,6 +1833,8 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	if (family != 6)
 		return 0;
 
+	bclk = discover_bclk(family, model);
+
 	switch (model) {
 	case 0x1A:	/* Core i7, Xeon 5500 series - Bloomfield, Gainstown NHM-EP */
 	case 0x1E:	/* Core i7 and i5 Processor - Clarksfield, Lynnfield, Jasper Forest */
@@ -1871,9 +1877,13 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		return 0;
 	}
 	get_msr(base_cpu, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
-
 	pkg_cstate_limit = pkg_cstate_limits[msr & 0xF];
 
+	get_msr(base_cpu, MSR_NHM_PLATFORM_INFO, &msr);
+	base_ratio = (msr >> 8) & 0xFF;
+
+	base_hz = base_ratio * bclk * 1000000;
+	has_base_hz = 1;
 	return 1;
 }
 int has_nhm_turbo_ratio_limit(unsigned int family, unsigned int model)
@@ -2780,7 +2790,6 @@ void process_cpuid()
 	do_skl_residency = has_skl_msrs(family, model);
 	do_slm_cstates = is_slm(family, model);
 	do_knl_cstates  = is_knl(family, model);
-	bclk = discover_bclk(family, model);
 
 	rapl_probe(family, model);
 	perf_limit_reasons_probe(family, model);
@@ -3119,7 +3128,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(stderr, "turbostat version 4.8 26-Sep, 2015"
+	fprintf(stderr, "turbostat version 4.9 19-Oct, 2015"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.6.2.450.g259b5e6

