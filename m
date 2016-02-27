From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/16] tools/power turbostat: decode HWP registers
Date: Sat, 27 Feb 2016 04:00:58 -0500
Message-ID: <7f5c258e1ce1e0909d3195694ac79f143051e513.1456563103.git.len.brown@intel.com>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34307 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbcB0JBw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 04:01:52 -0500
Received: by mail-yw0-f196.google.com with SMTP id f6so5309971ywa.1
        for <linux-pm@vger.kernel.org>; Sat, 27 Feb 2016 01:01:51 -0800 (PST)
In-Reply-To: <1456563670-23282-1-git-send-email-lenb@kernel.org>
In-Reply-To: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
References: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

 # turbostat --debug
...
CPUID(6): ... HWP, HWPnotify, HWPwindow, HWPepp, HWPpkg ...
...
cpu0: MSR_PM_ENABLE: 0x00000001 (HWP)
cpu0: MSR_HWP_CAPABILITIES: 0x01050916 (high 0x16 guar 0x9 eff 0x5 low 0x1)
cpu0: MSR_HWP_REQUEST: 0x80001604 (min 0x4 max 0x16 des 0x0 epp 0x80 window 0x0 pkg 0x0)
cpu0: MSR_HWP_INTERRUPT: 0x00000001 (EN_Guaranteed_Perf_Change, Dis_Excursion_Min)
cpu0: MSR_HWP_STATUS: 0x00000000 (No-Guaranteed_Perf_Change, No-Excursion_Min)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 124 ++++++++++++++++++++++++++++++++--
 1 file changed, 118 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4c4470f..af3b955 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -98,6 +98,12 @@ unsigned int crystal_hz;
 unsigned long long tsc_hz;
 int base_cpu;
 double discover_bclk(unsigned int family, unsigned int model);
+unsigned int has_hwp;	/* IA32_PM_ENABLE, IA32_HWP_CAPABILITIES */
+			/* IA32_HWP_REQUEST, IA32_HWP_STATUS */
+unsigned int has_hwp_notify;		/* IA32_HWP_INTERRUPT */
+unsigned int has_hwp_activity_window;	/* IA32_HWP_REQUEST[bits 41:32] */
+unsigned int has_hwp_epp;		/* IA32_HWP_REQUEST[bits 31:24] */
+unsigned int has_hwp_pkg;		/* IA32_HWP_REQUEST_PKG */
 
 #define RAPL_PKG		(1 << 0)
 					/* 0x610 MSR_PKG_POWER_LIMIT */
@@ -2041,6 +2047,97 @@ int print_epb(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 
 	return 0;
 }
+/*
+ * print_hwp()
+ * Decode the MSR_HWP_CAPABILITIES
+ */
+int print_hwp(struct thread_data *t, struct core_data *c, struct pkg_data *p)
+{
+	unsigned long long msr;
+	int cpu;
+
+	if (!has_hwp)
+		return 0;
+
+	cpu = t->cpu_id;
+
+	/* MSR_HWP_CAPABILITIES is per-package */
+	if (!(t->flags & CPU_IS_FIRST_THREAD_IN_CORE) || !(t->flags & CPU_IS_FIRST_CORE_IN_PACKAGE))
+		return 0;
+
+	if (cpu_migrate(cpu)) {
+		fprintf(stderr, "Could not migrate to CPU %d\n", cpu);
+		return -1;
+	}
+
+	if (get_msr(cpu, MSR_PM_ENABLE, &msr))
+		return 0;
+
+	fprintf(stderr, "cpu%d: MSR_PM_ENABLE: 0x%08llx (%sHWP)\n",
+		cpu, msr, (msr & (1 << 0)) ? "" : "No-");
+
+	/* MSR_PM_ENABLE[1] == 1 if HWP is enabled and MSRs visible */
+	if ((msr & (1 << 0)) == 0)
+		return 0;
+
+	if (get_msr(cpu, MSR_HWP_CAPABILITIES, &msr))
+		return 0;
+
+	fprintf(stderr, "cpu%d: MSR_HWP_CAPABILITIES: 0x%08llx "
+			"(high 0x%x guar 0x%x eff 0x%x low 0x%x)\n",
+			cpu, msr,
+			(unsigned int)HWP_HIGHEST_PERF(msr),
+			(unsigned int)HWP_GUARANTEED_PERF(msr),
+			(unsigned int)HWP_MOSTEFFICIENT_PERF(msr),
+			(unsigned int)HWP_LOWEST_PERF(msr));
+
+	if (get_msr(cpu, MSR_HWP_REQUEST, &msr))
+		return 0;
+
+	fprintf(stderr, "cpu%d: MSR_HWP_REQUEST: 0x%08llx "
+			"(min 0x%x max 0x%x des 0x%x epp 0x%x window 0x%x pkg 0x%x)\n",
+			cpu, msr,
+			(unsigned int)(((msr) >> 0) & 0xff),
+			(unsigned int)(((msr) >> 8) & 0xff),
+			(unsigned int)(((msr) >> 16) & 0xff),
+			(unsigned int)(((msr) >> 24) & 0xff),
+			(unsigned int)(((msr) >> 32) & 0xff3),
+			(unsigned int)(((msr) >> 42) & 0x1));
+
+	if (has_hwp_pkg) {
+		if (get_msr(cpu, MSR_HWP_REQUEST_PKG, &msr))
+			return 0;
+
+		fprintf(stderr, "cpu%d: MSR_HWP_REQUEST_PKG: 0x%08llx "
+			"(min 0x%x max 0x%x des 0x%x epp 0x%x window 0x%x)\n",
+			cpu, msr,
+			(unsigned int)(((msr) >> 0) & 0xff),
+			(unsigned int)(((msr) >> 8) & 0xff),
+			(unsigned int)(((msr) >> 16) & 0xff),
+			(unsigned int)(((msr) >> 24) & 0xff),
+			(unsigned int)(((msr) >> 32) & 0xff3));
+	}
+	if (has_hwp_notify) {
+		if (get_msr(cpu, MSR_HWP_INTERRUPT, &msr))
+			return 0;
+
+		fprintf(stderr, "cpu%d: MSR_HWP_INTERRUPT: 0x%08llx "
+			"(%s_Guaranteed_Perf_Change, %s_Excursion_Min)\n",
+			cpu, msr,
+			((msr) & 0x1) ? "EN" : "Dis",
+			((msr) & 0x2) ? "EN" : "Dis");
+	}
+	if (get_msr(cpu, MSR_HWP_STATUS, &msr))
+		return 0;
+
+	fprintf(stderr, "cpu%d: MSR_HWP_STATUS: 0x%08llx "
+			"(%sGuaranteed_Perf_Change, %sExcursion_Min)\n",
+			cpu, msr,
+			((msr) & 0x1) ? "" : "No-",
+			((msr) & 0x2) ? "" : "No-");
+
+	return 0;
+}
 
 /*
  * print_perf_limit()
@@ -2686,6 +2783,7 @@ void decode_misc_enable_msr(void)
 			msr & (1 << 18) ? "MONITOR" : "");
 }
 
+
 void process_cpuid()
 {
 	unsigned int eax, ebx, ecx, edx, max_level, max_extended_level;
@@ -2753,14 +2851,25 @@ void process_cpuid()
 	has_aperf = ecx & (1 << 0);
 	do_dts = eax & (1 << 0);
 	do_ptm = eax & (1 << 6);
+	has_hwp = eax & (1 << 7);
+	has_hwp_notify = eax & (1 << 8);
+	has_hwp_activity_window = eax & (1 << 9);
+	has_hwp_epp = eax & (1 << 10);
+	has_hwp_pkg = eax & (1 << 11);
 	has_epb = ecx & (1 << 3);
 
 	if (debug)
-		fprintf(stderr, "CPUID(6): %sAPERF, %sDTS, %sPTM, %sEPB\n",
-			has_aperf ? "" : "No ",
-			do_dts ? "" : "No ",
-			do_ptm ? "" : "No ",
-			has_epb ? "" : "No ");
+		fprintf(stderr, "CPUID(6): %sAPERF, %sDTS, %sPTM, %sHWP, "
+			"%sHWPnotify, %sHWPwindow, %sHWPepp, %sHWPpkg, %sEPB\n",
+			has_aperf ? "" : "No-",
+			do_dts ? "" : "No-",
+			do_ptm ? "" : "No-",
+			has_hwp ? "" : "No-",
+			has_hwp_notify ? "" : "No-",
+			has_hwp_activity_window ? "" : "No-",
+			has_hwp_epp ? "" : "No-",
+			has_hwp_pkg ? "" : "No-",
+			has_epb ? "" : "No-");
 
 	if (debug)
 		decode_misc_enable_msr();
@@ -3088,6 +3197,9 @@ void turbostat_init()
 
 
 	if (debug)
+		for_all_cpus(print_hwp, ODD_COUNTERS);
+
+	if (debug)
 		for_all_cpus(print_epb, ODD_COUNTERS);
 
 	if (debug)
@@ -3164,7 +3276,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(stderr, "turbostat version 4.9 22 Nov, 2015"
+	fprintf(stderr, "turbostat version 4.10 10 Dec, 2015"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.7.1.339.g0233b80

