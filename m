From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/12] tools/power turbostat: simplify default output
Date: Sat, 18 Apr 2015 20:40:16 -0400
Message-ID: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
References: <1429404027-23203-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34897 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbbDSAkp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Apr 2015 20:40:45 -0400
Received: by qkhg7 with SMTP id g7so172803206qkh.2
        for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2015 17:40:44 -0700 (PDT)
In-Reply-To: <1429404027-23203-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Casual turbostat users generally just want to know MHz.
So by default, just print enough information to make sense of MHz.

All the other configuration data and columns for C-states and temperature etc,
are printed with the --debug option.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 138 +++++++++++++++++++---------------
 tools/power/x86/turbostat/turbostat.c |  30 +++++---
 2 files changed, 98 insertions(+), 70 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index feea7ad..05b8fc3 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -20,9 +20,11 @@ upon its completion.
 The second method is to omit the command,
 and turbostat displays statistics every 5 seconds.
 The 5-second interval can be changed using the --interval option.
-
+.PP
 Some information is not available on older processors.
 .SS Options
+Options can be specified with a single or double '-', and only as much of the option
+name as necessary to disambiguate it from others is necessary.  Note that options are case-sensitive.
 \fB--Counter MSR#\fP shows the delta of the specified 64-bit MSR counter.
 .PP
 \fB--counter MSR#\fP shows the delta of the specified 32-bit MSR counter.
@@ -55,16 +57,20 @@ more than once may also enable internal turbostat debug information.
 The \fBcommand\fP parameter forks \fBcommand\fP, and upon its exit,
 displays the statistics gathered since it was forked.
 .PP
-.SH FIELD DESCRIPTIONS
+.SH DEFAULT FIELD DESCRIPTIONS
 .nf
-\fBPackage\fP processor package number.
-\fBCore\fP processor core number.
-\fBCPU\fP Linux CPU (logical processor) number.
-Note that multiple CPUs per core indicate support for Intel(R) Hyper-Threading Technology.
+\fBCPU\fP Linux CPU (logical processor) number.  Yes, it is okay that on many systems the CPUs are not listed in numerical order -- for efficiency reasons, turbostat runs in topology order, so HT siblings appear together.
 \fBAVG_MHz\fP number of cycles executed divided by time elapsed.
 \fB%Busy\fP percent of the interval that the CPU retired instructions, aka. % of time in "C0" state.
 \fBBzy_MHz\fP average clock rate while the CPU was busy (in "c0" state).
 \fBTSC_MHz\fP average MHz that the TSC ran during the entire interval.
+.fi
+.PP
+.SH DEBUG FIELD DESCRIPTIONS
+.nf
+\fBPackage\fP processor package number.
+\fBCore\fP processor core number.
+Note that multiple CPUs per core indicate support for Intel(R) Hyper-Threading Technology (HT).
 \fBCPU%c1, CPU%c3, CPU%c6, CPU%c7\fP show the percentage residency in hardware core idle states.
 \fBCoreTmp\fP Degrees Celsius reported by the per-core Digital Thermal Sensor.
 \fBPkgTtmp\fP Degrees Celsius reported by the per-package Package Thermal Monitor.
@@ -81,63 +87,76 @@ Note that multiple CPUs per core indicate support for Intel(R) Hyper-Threading T
 Without any parameters, turbostat displays statistics ever 5 seconds.
 (override interval with "-i sec" option, or specify a command
 for turbostat to fork).
+.nf
+[root@hsw]# ./turbostat
+     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
+       -     488   12.51    3898    3498
+       0       0    0.01    3885    3498
+       4    3897   99.99    3898    3498
+       1       0    0.00    3861    3498
+       5       0    0.00    3882    3498
+       2       1    0.02    3894    3498
+       6       2    0.06    3898    3498
+       3       0    0.00    3849    3498
+       7       0    0.00    3877    3498
+
+.fi
+.SH DEBUG EXAMPLE
+The "--debug" option prints additional system information before measurements:
 
 The first row of statistics is a summary for the entire system.
 For residency % columns, the summary is a weighted average.
 For Temperature columns, the summary is the column maximum.
 For Watts columns, the summary is a system total.
 Subsequent rows show per-CPU statistics.
-
-.nf
-[root@ivy]# ./turbostat
-    Core     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz     SMI  CPU%c1  CPU%c3  CPU%c6  CPU%c7 CoreTmp  PkgTmp Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 PkgWatt CorWatt GFXWatt 
-       -       -       6    0.36    1596    3492       0    0.59    0.01   99.04    0.00      23      24   23.82    0.01   72.47    0.00    6.40    1.01    0.00
-       0       0       9    0.58    1596    3492       0    0.28    0.01   99.13    0.00      23      24   23.82    0.01   72.47    0.00    6.40    1.01    0.00
-       0       4       1    0.07    1596    3492       0    0.79
-       1       1      10    0.65    1596    3492       0    0.59    0.00   98.76    0.00      23
-       1       5       5    0.28    1596    3492       0    0.95
-       2       2      10    0.66    1596    3492       0    0.41    0.01   98.92    0.00      23
-       2       6       2    0.10    1597    3492       0    0.97
-       3       3       3    0.20    1596    3492       0    0.44    0.00   99.37    0.00      23
-       3       7       5    0.31    1596    3492       0    0.33
-.fi
-.SH DEBUG EXAMPLE
-The "--debug" option prints additional system information before measurements:
-
 .nf
-turbostat version 4.0 10-Feb, 2015 - Len Brown <lenb@kernel.org>
-CPUID(0): GenuineIntel 13 CPUID levels; family:model:stepping 0x6:3a:9 (6:58:9)
+turbostat version 4.1 10-Feb, 2015 - Len Brown <lenb@kernel.org>
+CPUID(0): GenuineIntel 13 CPUID levels; family:model:stepping 0x6:3c:3 (6:60:3)
 CPUID(6): APERF, DTS, PTM, EPB
-RAPL: 851 sec. Joule Counter Range, at 77 Watts
-cpu0: MSR_NHM_PLATFORM_INFO: 0x81010f0012300
-16 * 100 = 1600 MHz max efficiency
+RAPL: 3121 sec. Joule Counter Range, at 84 Watts
+cpu0: MSR_NHM_PLATFORM_INFO: 0x80838f3012300
+8 * 100 = 800 MHz max efficiency
 35 * 100 = 3500 MHz TSC frequency
-cpu0: MSR_IA32_POWER_CTL: 0x0014005d (C1E auto-promotion: DISabled)
-cpu0: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x1e008402 (UNdemote-C3, UNdemote-C1, demote-C3, demote-C1, locked: pkg-cstate-limit=2: pc6n)
+cpu0: MSR_IA32_POWER_CTL: 0x0004005d (C1E auto-promotion: DISabled)
+cpu0: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x1e000400 (UNdemote-C3, UNdemote-C1, demote-C3, demote-C1, UNlocked: pkg-cstate-limit=0: pc0)
 cpu0: MSR_NHM_TURBO_RATIO_LIMIT: 0x25262727
 37 * 100 = 3700 MHz max turbo 4 active cores
 38 * 100 = 3800 MHz max turbo 3 active cores
 39 * 100 = 3900 MHz max turbo 2 active cores
 39 * 100 = 3900 MHz max turbo 1 active cores
 cpu0: MSR_IA32_ENERGY_PERF_BIAS: 0x00000006 (balanced)
-cpu0: MSR_RAPL_POWER_UNIT: 0x000a1003 (0.125000 Watts, 0.000015 Joules, 0.000977 sec.)
-cpu0: MSR_PKG_POWER_INFO: 0x01e00268 (77 W TDP, RAPL 60 - 0 W, 0.000000 sec.)
-cpu0: MSR_PKG_POWER_LIMIT: 0x30000148268 (UNlocked)
-cpu0: PKG Limit #1: ENabled (77.000000 Watts, 1.000000 sec, clamp DISabled)
-cpu0: PKG Limit #2: DISabled (96.000000 Watts, 0.000977* sec, clamp DISabled)
+cpu0: MSR_CORE_PERF_LIMIT_REASONS, 0x31200000 (Active: ) (Logged: Auto-HWP, Amps, MultiCoreTurbo, Transitions, )
+cpu0: MSR_GFX_PERF_LIMIT_REASONS, 0x00000000 (Active: ) (Logged: )
+cpu0: MSR_RING_PERF_LIMIT_REASONS, 0x0d000000 (Active: ) (Logged: Amps, PkgPwrL1, PkgPwrL2, )
+cpu0: MSR_RAPL_POWER_UNIT: 0x000a0e03 (0.125000 Watts, 0.000061 Joules, 0.000977 sec.)
+cpu0: MSR_PKG_POWER_INFO: 0x000002a0 (84 W TDP, RAPL 0 - 0 W, 0.000000 sec.)
+cpu0: MSR_PKG_POWER_LIMIT: 0x428348001a82a0 (UNlocked)
+cpu0: PKG Limit #1: ENabled (84.000000 Watts, 8.000000 sec, clamp DISabled)
+cpu0: PKG Limit #2: ENabled (105.000000 Watts, 0.002441* sec, clamp DISabled)
 cpu0: MSR_PP0_POLICY: 0
 cpu0: MSR_PP0_POWER_LIMIT: 0x00000000 (UNlocked)
 cpu0: Cores Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp DISabled)
 cpu0: MSR_PP1_POLICY: 0
 cpu0: MSR_PP1_POWER_LIMIT: 0x00000000 (UNlocked)
 cpu0: GFX Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp DISabled)
-cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x00691400 (105 C)
-cpu0: MSR_IA32_PACKAGE_THERM_STATUS: 0x884e0000 (27 C)
-cpu0: MSR_IA32_THERM_STATUS: 0x88580000 (17 C +/- 1)
-cpu1: MSR_IA32_THERM_STATUS: 0x885a0000 (15 C +/- 1)
-cpu2: MSR_IA32_THERM_STATUS: 0x88570000 (18 C +/- 1)
-cpu3: MSR_IA32_THERM_STATUS: 0x884e0000 (27 C +/- 1)
- ...
+cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x00641400 (100 C)
+cpu0: MSR_IA32_PACKAGE_THERM_STATUS: 0x88340800 (48 C)
+cpu0: MSR_IA32_THERM_STATUS: 0x88340000 (48 C +/- 1)
+cpu1: MSR_IA32_THERM_STATUS: 0x88440000 (32 C +/- 1)
+cpu2: MSR_IA32_THERM_STATUS: 0x88450000 (31 C +/- 1)
+cpu3: MSR_IA32_THERM_STATUS: 0x88490000 (27 C +/- 1)
+    Core     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz     SMI  CPU%c1  CPU%c3  CPU%c6  CPU%c7 CoreTmp  PkgTmp PkgWatt CorWatt GFXWatt
+       -       -     493   12.64    3898    3498       0   12.64    0.00    0.00   74.72      47      47   21.62   13.74    0.00
+       0       0       4    0.11    3894    3498       0   99.89    0.00    0.00    0.00      47      47   21.62   13.74    0.00
+       0       4    3897   99.98    3898    3498       0    0.02
+       1       1       7    0.17    3887    3498       0    0.04    0.00    0.00   99.79      32
+       1       5       0    0.00    3885    3498       0    0.21
+       2       2      29    0.76    3895    3498       0    0.10    0.01    0.01   99.13      32
+       2       6       2    0.06    3896    3498       0    0.80
+       3       3       1    0.02    3832    3498       0    0.03    0.00    0.00   99.95      28
+       3       7       0    0.00    3879    3498       0    0.04
+^C
+
 .fi
 The \fBmax efficiency\fP frequency, a.k.a. Low Frequency Mode, is the frequency
 available at the minimum package voltage.  The \fBTSC frequency\fP is the base
@@ -147,6 +166,9 @@ should be sustainable on all CPUs indefinitely, given nominal power and cooling.
 The remaining rows show what maximum turbo frequency is possible
 depending on the number of idle cores.  Note that not all information is
 available on all processors.
+.PP
+The --debug option adds additional columns to the measurement ouput, including CPU idle power-state residency processor temperature sensor readinds.
+See the field definitions above.
 .SH FORK EXAMPLE
 If turbostat is invoked with a command, it will fork that command
 and output the statistics gathered when the command exits.
@@ -154,27 +176,23 @@ eg. Here a cycle soaker is run on 1 CPU (see %c0) for a few seconds
 until ^C while the other CPUs are mostly idle:
 
 .nf
-root@ivy: turbostat cat /dev/zero > /dev/null
+root@hsw: turbostat cat /dev/zero > /dev/null
 ^C
-    Core     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz     SMI  CPU%c1  CPU%c3  CPU%c6  CPU%c7 CoreTmp  PkgTmp Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 PkgWatt CorWatt GFXWatt 
-       -       -     496   12.75    3886    3492       0   13.16    0.04   74.04    0.00      36      36    0.00    0.00    0.00    0.00   23.15   17.65    0.00
-       0       0      22    0.57    3830    3492       0    0.83    0.02   98.59    0.00      27      36    0.00    0.00    0.00    0.00   23.15   17.65    0.00
-       0       4       9    0.24    3829    3492       0    1.15
-       1       1       4    0.09    3783    3492       0   99.91    0.00    0.00    0.00      36
-       1       5    3880   99.82    3888    3492       0    0.18
-       2       2      17    0.44    3813    3492       0    0.77    0.04   98.75    0.00      28
-       2       6      12    0.32    3823    3492       0    0.89
-       3       3      16    0.43    3844    3492       0    0.63    0.11   98.84    0.00      30
-       3       7       4    0.11    3827    3492       0    0.94
-30.372243 sec
+     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
+       -     482   12.51    3854    3498
+       0       0    0.01    1960    3498
+       4       0    0.00    2128    3498
+       1       0    0.00    3003    3498
+       5    3854   99.98    3855    3498
+       2       0    0.01    3504    3498
+       6       3    0.08    3884    3498
+       3       0    0.00    2553    3498
+       7       0    0.00    2126    3498
+10.783983 sec
 
 .fi
-Above the cycle soaker drives cpu5 up its 3.8 GHz turbo limit
-while the other processors are generally in various states of idle.
-
-Note that cpu1 and cpu5 are HT siblings within core1.
-As cpu5 is very busy, it prevents its sibling, cpu1,
-from entering a c-state deeper than c1.
+Above the cycle soaker drives cpu5 up its 3.9 GHz turbo limit.
+The first row shows the average MHz and %Busy across all the processors in the system.
 
 Note that the Avg_MHz column reflects the total number of cycles executed
 divided by the measurement interval.  If the %Busy column is 100%,
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2d089ca..1bc6e6c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -292,8 +292,7 @@ void print_header(void)
 	if (has_aperf)
 		outp += sprintf(outp, " Bzy_MHz");
 	outp += sprintf(outp, " TSC_MHz");
-	if (do_smi)
-		outp += sprintf(outp, "     SMI");
+
 	if (extra_delta_offset32)
 		outp += sprintf(outp, "  count 0x%03X", extra_delta_offset32);
 	if (extra_delta_offset64)
@@ -302,6 +301,13 @@ void print_header(void)
 		outp += sprintf(outp, "   MSR 0x%03X", extra_msr_offset32);
 	if (extra_msr_offset64)
 		outp += sprintf(outp, "           MSR 0x%03X", extra_msr_offset64);
+
+	if (!debug)
+		goto done;
+
+	if (do_smi)
+		outp += sprintf(outp, "     SMI");
+
 	if (do_nhm_cstates)
 		outp += sprintf(outp, "  CPU%%c1");
 	if (do_nhm_cstates && !do_slm_cstates)
@@ -359,6 +365,7 @@ void print_header(void)
 		outp += sprintf(outp, "   time");
 
 	}
+    done:
 	outp += sprintf(outp, "\n");
 }
 
@@ -487,10 +494,6 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	/* TSC_MHz */
 	outp += sprintf(outp, "%8.0f", 1.0 * t->tsc/units/interval_float);
 
-	/* SMI */
-	if (do_smi)
-		outp += sprintf(outp, "%8d", t->smi_count);
-
 	/* delta */
 	if (extra_delta_offset32)
 		outp += sprintf(outp, "  %11llu", t->extra_delta32);
@@ -506,6 +509,13 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	if (extra_msr_offset64)
 		outp += sprintf(outp, "  0x%016llx", t->extra_msr64);
 
+	if (!debug)
+		goto done;
+
+	/* SMI */
+	if (do_smi)
+		outp += sprintf(outp, "%8d", t->smi_count);
+
 	if (do_nhm_cstates) {
 		if (!skip_c1)
 			outp += sprintf(outp, "%8.2f", 100.0 * t->c1/t->tsc);
@@ -1068,7 +1078,7 @@ int slv_pkg_cstate_limits[8] = {PCL__0, PCL__1, PCLRSV, PCLRSV, PCL__4, PCLRSV,
 int amt_pkg_cstate_limits[8] = {PCL__0, PCL__1, PCL__2, PCLRSV, PCLRSV, PCLRSV, PCL__6, PCL__7};
 int phi_pkg_cstate_limits[8] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL};
 
-void print_verbose_header(void)
+void dump_system_config_info(void)
 {
 	unsigned long long msr;
 	unsigned int ratio;
@@ -2428,14 +2438,14 @@ void topology_probe()
 	if (debug > 1)
 		fprintf(stderr, "max_core_id %d, sizing for %d cores per package\n",
 			max_core_id, topo.num_cores_per_pkg);
-	if (!summary_only && topo.num_cores_per_pkg > 1)
+	if (debug && !summary_only && topo.num_cores_per_pkg > 1)
 		show_core = 1;
 
 	topo.num_packages = max_package_id + 1;
 	if (debug > 1)
 		fprintf(stderr, "max_package_id %d, sizing for %d packages\n",
 			max_package_id, topo.num_packages);
-	if (!summary_only && topo.num_packages > 1)
+	if (debug && !summary_only && topo.num_packages > 1)
 		show_pkg = 1;
 
 	topo.num_threads_per_core = max_siblings;
@@ -2555,7 +2565,7 @@ void turbostat_init()
 	setup_all_buffers();
 
 	if (debug)
-		print_verbose_header();
+		dump_system_config_info();
 
 	if (debug)
 		for_all_cpus(print_epb, ODD_COUNTERS);
-- 
2.4.0.rc1

