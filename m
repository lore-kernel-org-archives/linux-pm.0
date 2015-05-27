From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/5] tools/power turbostat: allow running without cpu0
Date: Wed, 27 May 2015 18:08:05 -0400
Message-ID: <7ce7d5de6dd08ee2a713ef13f4499073b4a72b7f.1432764245.git.len.brown@intel.com>
References: <1432764486-3517-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36150 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbbE0WIX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 18:08:23 -0400
Received: by qkx62 with SMTP id 62so14344681qkx.3
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2015 15:08:22 -0700 (PDT)
In-Reply-To: <1432764486-3517-1-git-send-email-lenb@kernel.org>
In-Reply-To: <e275b3885dffd31095984ed2476ed0447fa7309a.1432764245.git.len.brown@intel.com>
References: <e275b3885dffd31095984ed2476ed0447fa7309a.1432764245.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Len Brown <len.brown@intel.com>

From: Prarit Bhargava <prarit@redhat.com>

Linux-3.7 added CONFIG_BOOTPARAM_HOTPLUG_CPU0,
allowing systems to offline cpu0.

But when cpu0 is offline, turbostat will not run:

 # turbostat ls
turbostat: no /dev/cpu/0/msr

This patch replaces the hard-coded use of cpu0 in turbostat
with the current cpu, allowing it to run without a cpu0.

Fewer cross-calls may also be needed due to use of current cpu,
though this hard-coding was used only for the --debug preamble.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 46 +++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f92211e..68e77fd 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -92,6 +92,7 @@ unsigned int do_gfx_perf_limit_reasons;
 unsigned int do_ring_perf_limit_reasons;
 unsigned int crystal_hz;
 unsigned long long tsc_hz;
+int base_cpu;
 
 #define RAPL_PKG		(1 << 0)
 					/* 0x610 MSR_PKG_POWER_LIMIT */
@@ -1154,7 +1155,7 @@ dump_nhm_platform_info(void)
 	unsigned long long msr;
 	unsigned int ratio;
 
-	get_msr(0, MSR_NHM_PLATFORM_INFO, &msr);
+	get_msr(base_cpu, MSR_NHM_PLATFORM_INFO, &msr);
 
 	fprintf(stderr, "cpu0: MSR_NHM_PLATFORM_INFO: 0x%08llx\n", msr);
 
@@ -1166,7 +1167,7 @@ dump_nhm_platform_info(void)
 	fprintf(stderr, "%d * %.0f = %.0f MHz base frequency\n",
 		ratio, bclk, ratio * bclk);
 
-	get_msr(0, MSR_IA32_POWER_CTL, &msr);
+	get_msr(base_cpu, MSR_IA32_POWER_CTL, &msr);
 	fprintf(stderr, "cpu0: MSR_IA32_POWER_CTL: 0x%08llx (C1E auto-promotion: %sabled)\n",
 		msr, msr & 0x2 ? "EN" : "DIS");
 
@@ -1179,7 +1180,7 @@ dump_hsw_turbo_ratio_limits(void)
 	unsigned long long msr;
 	unsigned int ratio;
 
-	get_msr(0, MSR_TURBO_RATIO_LIMIT2, &msr);
+	get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT2, &msr);
 
 	fprintf(stderr, "cpu0: MSR_TURBO_RATIO_LIMIT2: 0x%08llx\n", msr);
 
@@ -1201,7 +1202,7 @@ dump_ivt_turbo_ratio_limits(void)
 	unsigned long long msr;
 	unsigned int ratio;
 
-	get_msr(0, MSR_TURBO_RATIO_LIMIT1, &msr);
+	get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT1, &msr);
 
 	fprintf(stderr, "cpu0: MSR_TURBO_RATIO_LIMIT1: 0x%08llx\n", msr);
 
@@ -1253,7 +1254,7 @@ dump_nhm_turbo_ratio_limits(void)
 	unsigned long long msr;
 	unsigned int ratio;
 
-	get_msr(0, MSR_TURBO_RATIO_LIMIT, &msr);
+	get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT, &msr);
 
 	fprintf(stderr, "cpu0: MSR_TURBO_RATIO_LIMIT: 0x%08llx\n", msr);
 
@@ -1309,7 +1310,7 @@ dump_knl_turbo_ratio_limits(void)
 	int delta_ratio;
 	int i;
 
-	get_msr(0, MSR_NHM_TURBO_RATIO_LIMIT, &msr);
+	get_msr(base_cpu, MSR_NHM_TURBO_RATIO_LIMIT, &msr);
 
 	fprintf(stderr, "cpu0: MSR_NHM_TURBO_RATIO_LIMIT: 0x%08llx\n",
 	msr);
@@ -1365,7 +1366,7 @@ dump_nhm_cst_cfg(void)
 {
 	unsigned long long msr;
 
-	get_msr(0, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
+	get_msr(base_cpu, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
 
 #define SNB_C1_AUTO_UNDEMOTE              (1UL << 27)
 #define SNB_C3_AUTO_UNDEMOTE              (1UL << 28)
@@ -1694,8 +1695,10 @@ restart:
 void check_dev_msr()
 {
 	struct stat sb;
+	char pathname[32];
 
-	if (stat("/dev/cpu/0/msr", &sb))
+	sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
+	if (stat(pathname, &sb))
  		if (system("/sbin/modprobe msr > /dev/null 2>&1"))
 			err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\" ");
 }
@@ -1708,6 +1711,7 @@ void check_permissions()
 	cap_user_data_t cap_data = &cap_data_data;
 	extern int capget(cap_user_header_t hdrp, cap_user_data_t datap);
 	int do_exit = 0;
+	char pathname[32];
 
 	/* check for CAP_SYS_RAWIO */
 	cap_header->pid = getpid();
@@ -1722,7 +1726,8 @@ void check_permissions()
 	}
 
 	/* test file permissions */
-	if (euidaccess("/dev/cpu/0/msr", R_OK)) {
+	sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
+	if (euidaccess(pathname, R_OK)) {
 		do_exit++;
 		warn("/dev/cpu/0/msr open failed, try chown or chmod +r /dev/cpu/*/msr");
 	}
@@ -1804,7 +1809,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	default:
 		return 0;
 	}
-	get_msr(0, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
+	get_msr(base_cpu, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
 
 	pkg_cstate_limit = pkg_cstate_limits[msr & 0xF];
 
@@ -2043,7 +2048,7 @@ double get_tdp(model)
 	unsigned long long msr;
 
 	if (do_rapl & RAPL_PKG_POWER_INFO)
-		if (!get_msr(0, MSR_PKG_POWER_INFO, &msr))
+		if (!get_msr(base_cpu, MSR_PKG_POWER_INFO, &msr))
 			return ((msr >> 0) & RAPL_POWER_GRANULARITY) * rapl_power_units;
 
 	switch (model) {
@@ -2126,7 +2131,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 	}
 
 	/* units on package 0, verify later other packages match */
-	if (get_msr(0, MSR_RAPL_POWER_UNIT, &msr))
+	if (get_msr(base_cpu, MSR_RAPL_POWER_UNIT, &msr))
 		return;
 
 	rapl_power_units = 1.0 / (1 << (msr & 0xF));
@@ -2471,7 +2476,7 @@ double slm_bclk(void)
 	unsigned int i;
 	double freq;
 
-	if (get_msr(0, MSR_FSB_FREQ, &msr))
+	if (get_msr(base_cpu, MSR_FSB_FREQ, &msr))
 		fprintf(stderr, "SLM BCLK: unknown\n");
 
 	i = msr & 0xf;
@@ -2539,7 +2544,7 @@ int set_temperature_target(struct thread_data *t, struct core_data *c, struct pk
 	if (!do_nhm_platform_info)
 		goto guess;
 
-	if (get_msr(0, MSR_IA32_TEMPERATURE_TARGET, &msr))
+	if (get_msr(base_cpu, MSR_IA32_TEMPERATURE_TARGET, &msr))
 		goto guess;
 
 	target_c_local = (msr >> 16) & 0xFF;
@@ -2913,13 +2918,24 @@ void setup_all_buffers(void)
 	for_all_proc_cpus(initialize_counters);
 }
 
+void set_base_cpu(void)
+{
+	base_cpu = sched_getcpu();
+	if (base_cpu < 0)
+		err(-ENODEV, "No valid cpus found");
+
+	if (debug > 1)
+		fprintf(stderr, "base_cpu = %d\n", base_cpu);
+}
+
 void turbostat_init()
 {
+	setup_all_buffers();
+	set_base_cpu();
 	check_dev_msr();
 	check_permissions();
 	process_cpuid();
 
-	setup_all_buffers();
 
 	if (debug)
 		for_all_cpus(print_epb, ODD_COUNTERS);
-- 
2.4.1.314.g9532ead

