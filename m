From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/16] tools/power turbostat: re-name "%Busy" field to "Busy%"
Date: Sat, 27 Feb 2016 04:01:03 -0500
Message-ID: <fbe87b8d29a4536dcd378f2747127270ee74aa6f.1456563103.git.len.brown@intel.com>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f193.google.com ([209.85.160.193]:35870 "EHLO
	mail-yk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756219AbcB0JB7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 04:01:59 -0500
Received: by mail-yk0-f193.google.com with SMTP id z13so2787013ykd.3
        for <linux-pm@vger.kernel.org>; Sat, 27 Feb 2016 01:01:59 -0800 (PST)
In-Reply-To: <1456563670-23282-1-git-send-email-lenb@kernel.org>
In-Reply-To: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
References: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

some tools processing turbostat output
have difficulty with items that begin with %...

Reported-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 16 ++++++++--------
 tools/power/x86/turbostat/turbostat.c |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 8a9727b..1104373 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -61,7 +61,7 @@ displays the statistics gathered since it was forked.
 .nf
 \fBCPU\fP Linux CPU (logical processor) number.  Yes, it is okay that on many systems the CPUs are not listed in numerical order -- for efficiency reasons, turbostat runs in topology order, so HT siblings appear together.
 \fBAVG_MHz\fP number of cycles executed divided by time elapsed.
-\fB%Busy\fP percent of the interval that the CPU retired instructions, aka. % of time in "C0" state.
+\fBBusy%\fP percent of the interval that the CPU retired instructions, aka. % of time in "C0" state.
 \fBBzy_MHz\fP average clock rate while the CPU was busy (in "c0" state).
 \fBTSC_MHz\fP average MHz that the TSC ran during the entire interval.
 .fi
@@ -89,7 +89,7 @@ Without any parameters, turbostat displays statistics ever 5 seconds.
 for turbostat to fork).
 .nf
 [root@hsw]# ./turbostat
-     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
+     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
        -     488   12.51    3898    3498
        0       0    0.01    3885    3498
        4    3897   99.99    3898    3498
@@ -145,7 +145,7 @@ cpu0: MSR_IA32_THERM_STATUS: 0x88340000 (48 C +/- 1)
 cpu1: MSR_IA32_THERM_STATUS: 0x88440000 (32 C +/- 1)
 cpu2: MSR_IA32_THERM_STATUS: 0x88450000 (31 C +/- 1)
 cpu3: MSR_IA32_THERM_STATUS: 0x88490000 (27 C +/- 1)
-    Core     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz     SMI  CPU%c1  CPU%c3  CPU%c6  CPU%c7 CoreTmp  PkgTmp PkgWatt CorWatt GFXWatt
+    Core     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz     SMI  CPU%c1  CPU%c3  CPU%c6  CPU%c7 CoreTmp  PkgTmp PkgWatt CorWatt GFXWatt
        -       -     493   12.64    3898    3498       0   12.64    0.00    0.00   74.72      47      47   21.62   13.74    0.00
        0       0       4    0.11    3894    3498       0   99.89    0.00    0.00    0.00      47      47   21.62   13.74    0.00
        0       4    3897   99.98    3898    3498       0    0.02
@@ -178,7 +178,7 @@ until ^C while the other CPUs are mostly idle:
 .nf
 root@hsw: turbostat cat /dev/zero > /dev/null
 ^C
-     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
+     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
        -     482   12.51    3854    3498
        0       0    0.01    1960    3498
        4       0    0.00    2128    3498
@@ -192,12 +192,12 @@ root@hsw: turbostat cat /dev/zero > /dev/null
 
 .fi
 Above the cycle soaker drives cpu5 up its 3.9 GHz turbo limit.
-The first row shows the average MHz and %Busy across all the processors in the system.
+The first row shows the average MHz and Busy% across all the processors in the system.
 
 Note that the Avg_MHz column reflects the total number of cycles executed
-divided by the measurement interval.  If the %Busy column is 100%,
+divided by the measurement interval.  If the Busy% column is 100%,
 then the processor was running at that speed the entire interval.
-The Avg_MHz multiplied by the %Busy results in the Bzy_MHz --
+The Avg_MHz multiplied by the Busy% results in the Bzy_MHz --
 which is the average frequency while the processor was executing --
 not including any non-busy idle time.
 
@@ -233,7 +233,7 @@ in the brand string in /proc/cpuinfo.  On a system where
 the TSC stops in idle, TSC_MHz will drop
 below the processor's base frequency.
 
-%Busy = MPERF_delta/TSC_delta
+Busy% = MPERF_delta/TSC_delta
 
 Bzy_MHz = TSC_delta/APERF_delta/MPERF_delta/measurement_interval
 
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4e5386d..947239b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -293,7 +293,7 @@ int get_msr(int cpu, off_t offset, unsigned long long *msr)
 /*
  * Example Format w/ field column widths:
  *
- *  Package    Core     CPU Avg_MHz Bzy_MHz TSC_MHz     SMI   %Busy CPU_%c1 CPU_%c3 CPU_%c6 CPU_%c7 CoreTmp  PkgTmp Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 PkgWatt CorWatt GFXWatt
+ *  Package    Core     CPU Avg_MHz Bzy_MHz TSC_MHz     SMI   Busy% CPU_%c1 CPU_%c3 CPU_%c6 CPU_%c7 CoreTmp  PkgTmp Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 PkgWatt CorWatt GFXWatt
  * 123456781234567812345678123456781234567812345678123456781234567812345678123456781234567812345678123456781234567812345678123456781234567812345678123456781234567812345678
  */
 
@@ -308,7 +308,7 @@ void print_header(void)
 	if (has_aperf)
 		outp += sprintf(outp, " Avg_MHz");
 	if (has_aperf)
-		outp += sprintf(outp, "   %%Busy");
+		outp += sprintf(outp, "   Busy%%");
 	if (has_aperf)
 		outp += sprintf(outp, " Bzy_MHz");
 	outp += sprintf(outp, " TSC_MHz");
@@ -511,7 +511,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
 		outp += sprintf(outp, "%8.0f",
 			1.0 / units * t->aperf / interval_float);
 
-	/* %Busy */
+	/* Busy% */
 	if (has_aperf) {
 		if (!skip_c0)
 			outp += sprintf(outp, "%8.2f", 100.0 * t->mperf/t->tsc/tsc_tweak);
-- 
2.7.1.339.g0233b80

