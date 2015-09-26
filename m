From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/4] tools/power turbostat: SKL: Adjust for TSC difference from base frequency
Date: Sat, 26 Sep 2015 01:05:15 -0400
Message-ID: <a2b7b74945dbfe5d734eafe8aa52f9f1f8bc6931.1443243089.git.len.brown@intel.com>
References: <1443243915-6696-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35030 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbbIZFGA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 26 Sep 2015 01:06:00 -0400
In-Reply-To: <1443243915-6696-1-git-send-email-lenb@kernel.org>
In-Reply-To: <135919a3a80565070b9645009e65f73e72c661c0.1443243089.git.len.brown@intel.com>
References: <135919a3a80565070b9645009e65f73e72c661c0.1443243089.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

On a Skylake with 1500MHz base frequency,
the TSC runs at 1512MHz.

This is because the TSC is no longer in the n*100 MHz BCLK domain,
but is now in the m*24MHz crystal clock domain. (24 MHz * 63 = 1512 MHz)

This adds error to several calculations in turbostat,
unless the TSC sample sizes are adjusted for this difference.

Note that calculations in the time domain are immune
from this issue, as the timing sub-system has already
calibrated the TSC against a known wall clock.

AVG_MHz = APERF_delta/measurement_interval

	need no adjustment.  APERF_delta is in the BCLK domain,
	and measurement_interval is in the time domain.

TSC_MHz  =  TSC_delta/measurement_interval

	needs no adjustment -- as we really do want to report
	the actual measured TSC delta here, and measurement_interval
	is in the accurate time domain.

%Busy = MPERF_delta/TSC_delta

	needs adjustment to use TSC_BCLK_DOMAIN_delta.
	TSC_BCLK_DOMAIN_delta = TSC_delta * base_hz / tsc_hz

Bzy_MHz = TSC_delta/APERF_delta/MPERF_delta/measurement_interval

	need adjustment as above.

No other metrics in turbostat need to be adjusted.

Before:

     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
       -     550   24.84    2216    1512
       0    2191   98.73    2219    1514
       2       0    0.01    2130    1512
       1       9    0.43    2016    1512
       3       2    0.08    2016    1512

After:

     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
       -     550   25.05    2198    1512
       0    2190   99.62    2199    1512
       2       0    0.01    2152    1512
       1       9    0.46    2000    1512
       3       2    0.10    2000    1512

Note that in this example, the "Before" Bzy_MHz
was reported as exceeding the 2200 max turbo rate.
Also, even a pinned spin loop would not be reported
as over 99% busy.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index d333c81..31d756b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -74,6 +74,8 @@ unsigned int extra_delta_offset64;
 unsigned int aperf_mperf_multiplier = 1;
 int do_smi;
 double bclk;
+double base_hz;
+double tsc_tweak = 1.0;
 unsigned int show_pkg;
 unsigned int show_core;
 unsigned int show_cpu;
@@ -503,7 +505,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	/* %Busy */
 	if (has_aperf) {
 		if (!skip_c0)
-			outp += sprintf(outp, "%8.2f", 100.0 * t->mperf/t->tsc);
+			outp += sprintf(outp, "%8.2f", 100.0 * t->mperf/t->tsc/tsc_tweak);
 		else
 			outp += sprintf(outp, "********");
 	}
@@ -511,7 +513,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	/* Bzy_MHz */
 	if (has_aperf)
 		outp += sprintf(outp, "%8.0f",
-			1.0 * t->tsc / units * t->aperf / t->mperf / interval_float);
+			1.0 * t->tsc * tsc_tweak / units * t->aperf / t->mperf / interval_float);
 
 	/* TSC_MHz */
 	outp += sprintf(outp, "%8.0f", 1.0 * t->tsc/units/interval_float);
@@ -1152,6 +1154,19 @@ int slv_pkg_cstate_limits[16] = {PCL__0, PCL__1, PCLRSV, PCLRSV, PCL__4, PCLRSV,
 int amt_pkg_cstate_limits[16] = {PCL__0, PCL__1, PCL__2, PCLRSV, PCLRSV, PCLRSV, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int phi_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 
+
+static void
+calculate_tsc_tweak()
+{
+	unsigned long long msr;
+	unsigned int base_ratio;
+
+	get_msr(base_cpu, MSR_NHM_PLATFORM_INFO, &msr);
+	base_ratio = (msr >> 8) & 0xFF;
+	base_hz = base_ratio * bclk * 1000000;
+	tsc_tweak = base_hz / tsc_hz;
+}
+
 static void
 dump_nhm_platform_info(void)
 {
@@ -2773,6 +2788,9 @@ void process_cpuid()
 	if (debug)
 		dump_cstate_pstate_config_info();
 
+	if (has_skl_msrs(family, model))
+		calculate_tsc_tweak();
+
 	return;
 }
 
-- 
2.6.0.rc1

