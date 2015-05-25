From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 1/2] turbostat, add base_cpu
Date: Mon, 25 May 2015 08:34:28 -0400
Message-ID: <1432557269-10994-2-git-send-email-prarit@redhat.com>
References: <1432557269-10994-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34793 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbbEYMeh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 May 2015 08:34:37 -0400
In-Reply-To: <1432557269-10994-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, andrey.semin@intel.com, linux-pm@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>

turbostat does not function properly on systems that support CPU0 hotplug.
When running turbostat on these systems the following error is seen.

[root@intel-chiefriver-04 ~]# turbostat ls
turbostat: no /dev/cpu/0/msr
Try "# modprobe msr": No such file or directory

This happens because /dev/cpu/0 is hardcoded in several locations in the
turbostat code.

This patch adds base_cpu, which will be used to track the lowest cpu number
on the system.  This patch does not add any functionality differences and
sets base_cpu to 0.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 tools/power/x86/turbostat/turbostat.c |   31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bac98ca..8c2e761 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -91,6 +91,7 @@ unsigned int do_gfx_perf_limit_reasons;
 unsigned int do_ring_perf_limit_reasons;
 unsigned int crystal_hz;
 unsigned long long tsc_hz;
+int base_cpu = 0;
 
 #define RAPL_PKG		(1 << 0)
 					/* 0x610 MSR_PKG_POWER_LIMIT */
@@ -1150,7 +1151,7 @@ dump_nhm_platform_info(void)
 	unsigned long long msr;
 	unsigned int ratio;
 
-	get_msr(0, MSR_NHM_PLATFORM_INFO, &msr);
+	get_msr(base_cpu, MSR_NHM_PLATFORM_INFO, &msr);
 
 	fprintf(stderr, "cpu0: MSR_NHM_PLATFORM_INFO: 0x%08llx\n", msr);
 
@@ -1162,7 +1163,7 @@ dump_nhm_platform_info(void)
 	fprintf(stderr, "%d * %.0f = %.0f MHz base frequency\n",
 		ratio, bclk, ratio * bclk);
 
-	get_msr(0, MSR_IA32_POWER_CTL, &msr);
+	get_msr(base_cpu, MSR_IA32_POWER_CTL, &msr);
 	fprintf(stderr, "cpu0: MSR_IA32_POWER_CTL: 0x%08llx (C1E auto-promotion: %sabled)\n",
 		msr, msr & 0x2 ? "EN" : "DIS");
 
@@ -1175,7 +1176,7 @@ dump_hsw_turbo_ratio_limits(void)
 	unsigned long long msr;
 	unsigned int ratio;
 
-	get_msr(0, MSR_TURBO_RATIO_LIMIT2, &msr);
+	get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT2, &msr);
 
 	fprintf(stderr, "cpu0: MSR_TURBO_RATIO_LIMIT2: 0x%08llx\n", msr);
 
@@ -1197,7 +1198,7 @@ dump_ivt_turbo_ratio_limits(void)
 	unsigned long long msr;
 	unsigned int ratio;
 
-	get_msr(0, MSR_TURBO_RATIO_LIMIT1, &msr);
+	get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT1, &msr);
 
 	fprintf(stderr, "cpu0: MSR_TURBO_RATIO_LIMIT1: 0x%08llx\n", msr);
 
@@ -1249,7 +1250,7 @@ dump_nhm_turbo_ratio_limits(void)
 	unsigned long long msr;
 	unsigned int ratio;
 
-	get_msr(0, MSR_TURBO_RATIO_LIMIT, &msr);
+	get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT, &msr);
 
 	fprintf(stderr, "cpu0: MSR_TURBO_RATIO_LIMIT: 0x%08llx\n", msr);
 
@@ -1300,7 +1301,7 @@ dump_nhm_cst_cfg(void)
 {
 	unsigned long long msr;
 
-	get_msr(0, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
+	get_msr(base_cpu, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
 
 #define SNB_C1_AUTO_UNDEMOTE              (1UL << 27)
 #define SNB_C3_AUTO_UNDEMOTE              (1UL << 28)
@@ -1594,8 +1595,10 @@ restart:
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
@@ -1608,6 +1611,7 @@ void check_permissions()
 	cap_user_data_t cap_data = &cap_data_data;
 	extern int capget(cap_user_header_t hdrp, cap_user_data_t datap);
 	int do_exit = 0;
+	char pathname[32];
 
 	/* check for CAP_SYS_RAWIO */
 	cap_header->pid = getpid();
@@ -1622,7 +1626,8 @@ void check_permissions()
 	}
 
 	/* test file permissions */
-	if (euidaccess("/dev/cpu/0/msr", R_OK)) {
+	sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
+	if (euidaccess(pathname, R_OK)) {
 		do_exit++;
 		warn("/dev/cpu/0/msr open failed, try chown or chmod +r /dev/cpu/*/msr");
 	}
@@ -1704,7 +1709,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	default:
 		return 0;
 	}
-	get_msr(0, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
+	get_msr(base_cpu, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
 
 	pkg_cstate_limit = pkg_cstate_limits[msr & 0xF];
 
@@ -1925,7 +1930,7 @@ double get_tdp(model)
 	unsigned long long msr;
 
 	if (do_rapl & RAPL_PKG_POWER_INFO)
-		if (!get_msr(0, MSR_PKG_POWER_INFO, &msr))
+		if (!get_msr(base_cpu, MSR_PKG_POWER_INFO, &msr))
 			return ((msr >> 0) & RAPL_POWER_GRANULARITY) * rapl_power_units;
 
 	switch (model) {
@@ -2006,7 +2011,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 	}
 
 	/* units on package 0, verify later other packages match */
-	if (get_msr(0, MSR_RAPL_POWER_UNIT, &msr))
+	if (get_msr(base_cpu, MSR_RAPL_POWER_UNIT, &msr))
 		return;
 
 	rapl_power_units = 1.0 / (1 << (msr & 0xF));
@@ -2340,7 +2345,7 @@ double slm_bclk(void)
 	unsigned int i;
 	double freq;
 
-	if (get_msr(0, MSR_FSB_FREQ, &msr))
+	if (get_msr(base_cpu, MSR_FSB_FREQ, &msr))
 		fprintf(stderr, "SLM BCLK: unknown\n");
 
 	i = msr & 0xf;
@@ -2408,7 +2413,7 @@ int set_temperature_target(struct thread_data *t, struct core_data *c, struct pk
 	if (!do_nhm_platform_info)
 		goto guess;
 
-	if (get_msr(0, MSR_IA32_TEMPERATURE_TARGET, &msr))
+	if (get_msr(base_cpu, MSR_IA32_TEMPERATURE_TARGET, &msr))
 		goto guess;
 
 	target_c_local = (msr >> 16) & 0xFF;
-- 
1.7.9.3

