From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/7] tools/power turbostat: print IRTL MSRs
Date: Wed,  6 Apr 2016 17:15:55 -0400
Message-ID: <dd1a3bdbca4b1f8d61dff4c26807e23fa8b5d7a5.1459977091.git.len.brown@intel.com>
References: <1459977360-2841-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36548 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbcDFVQr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:16:47 -0400
Received: by mail-yw0-f193.google.com with SMTP id p65so8580836ywb.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 14:16:47 -0700 (PDT)
In-Reply-To: <1459977360-2841-1-git-send-email-lenb@kernel.org>
In-Reply-To: <c0137ec621c50427091eeebeaff5cb7f7a426ecb.1459977091.git.len.brown@intel.com>
References: <c0137ec621c50427091eeebeaff5cb7f7a426ecb.1459977091.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Some processors use the Interrupt Response Time Limit (IRTL) MSR value
to describe the maximum IRQ response time latency for deep
package C-states.  (Though others have the register, but do not use it)
Lets print it out to give insight into the cases where it is used.

IRTL begain in SNB, with PC3/PC6/PC7, and HSW added PC8/PC9/PC10.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/msr-index.h      |  8 +++++
 tools/power/x86/turbostat/turbostat.c | 59 +++++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 2da46ac..1e81927 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -167,6 +167,14 @@
 #define MSR_PKG_C9_RESIDENCY		0x00000631
 #define MSR_PKG_C10_RESIDENCY		0x00000632
 
+/* Interrupt Response Limit */
+#define MSR_PKGC3_IRTL			0x0000060a
+#define MSR_PKGC6_IRTL			0x0000060b
+#define MSR_PKGC7_IRTL			0x0000060c
+#define MSR_PKGC8_IRTL			0x00000633
+#define MSR_PKGC9_IRTL			0x00000634
+#define MSR_PKGC10_IRTL			0x00000635
+
 /* Run Time Average Power Limiting (RAPL) Interface */
 
 #define MSR_RAPL_POWER_UNIT		0x00000606
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f7616f3..2d5a27f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -66,6 +66,8 @@ unsigned int do_slm_cstates;
 unsigned int use_c1_residency_msr;
 unsigned int has_aperf;
 unsigned int has_epb;
+unsigned int do_irtl_snb;
+unsigned int do_irtl_hsw;
 unsigned int units = 1000000;	/* MHz etc */
 unsigned int genuine_intel;
 unsigned int has_invariant_tsc;
@@ -1579,6 +1581,47 @@ dump_config_tdp(void)
 	fprintf(outf, " lock=%d", (unsigned int)(msr >> 31) & 1);
 	fprintf(outf, ")\n");
 }
+
+unsigned int irtl_time_units[] = {1, 32, 1024, 32768, 1048576, 33554432, 0, 0 };
+
+void print_irtl(void)
+{
+	unsigned long long msr;
+
+	get_msr(base_cpu, MSR_PKGC3_IRTL, &msr);
+	fprintf(outf, "cpu%d: MSR_PKGC3_IRTL: 0x%08llx (", base_cpu, msr);
+	fprintf(outf, "%svalid, %lld ns)\n", msr & (1 << 15) ? "" : "NOT",
+		(msr & 0x3FF) * irtl_time_units[(msr >> 10) & 0x3]);
+
+	get_msr(base_cpu, MSR_PKGC6_IRTL, &msr);
+	fprintf(outf, "cpu%d: MSR_PKGC6_IRTL: 0x%08llx (", base_cpu, msr);
+	fprintf(outf, "%svalid, %lld ns)\n", msr & (1 << 15) ? "" : "NOT",
+		(msr & 0x3FF) * irtl_time_units[(msr >> 10) & 0x3]);
+
+	get_msr(base_cpu, MSR_PKGC7_IRTL, &msr);
+	fprintf(outf, "cpu%d: MSR_PKGC7_IRTL: 0x%08llx (", base_cpu, msr);
+	fprintf(outf, "%svalid, %lld ns)\n", msr & (1 << 15) ? "" : "NOT",
+		(msr & 0x3FF) * irtl_time_units[(msr >> 10) & 0x3]);
+
+	if (!do_irtl_hsw)
+		return;
+
+	get_msr(base_cpu, MSR_PKGC8_IRTL, &msr);
+	fprintf(outf, "cpu%d: MSR_PKGC8_IRTL: 0x%08llx (", base_cpu, msr);
+	fprintf(outf, "%svalid, %lld ns)\n", msr & (1 << 15) ? "" : "NOT",
+		(msr & 0x3FF) * irtl_time_units[(msr >> 10) & 0x3]);
+
+	get_msr(base_cpu, MSR_PKGC9_IRTL, &msr);
+	fprintf(outf, "cpu%d: MSR_PKGC9_IRTL: 0x%08llx (", base_cpu, msr);
+	fprintf(outf, "%svalid, %lld ns)\n", msr & (1 << 15) ? "" : "NOT",
+		(msr & 0x3FF) * irtl_time_units[(msr >> 10) & 0x3]);
+
+	get_msr(base_cpu, MSR_PKGC10_IRTL, &msr);
+	fprintf(outf, "cpu%d: MSR_PKGC10_IRTL: 0x%08llx (", base_cpu, msr);
+	fprintf(outf, "%svalid, %lld ns)\n", msr & (1 << 15) ? "" : "NOT",
+		(msr & 0x3FF) * irtl_time_units[(msr >> 10) & 0x3]);
+
+}
 void free_fd_percpu(void)
 {
 	int i;
@@ -2879,9 +2922,14 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 /*
  * HSW adds support for additional MSRs:
  *
- * MSR_PKG_C8_RESIDENCY            0x00000630
- * MSR_PKG_C9_RESIDENCY            0x00000631
- * MSR_PKG_C10_RESIDENCY           0x00000632
+ * MSR_PKG_C8_RESIDENCY		0x00000630
+ * MSR_PKG_C9_RESIDENCY		0x00000631
+ * MSR_PKG_C10_RESIDENCY	0x00000632
+ *
+ * MSR_PKGC8_IRTL		0x00000633
+ * MSR_PKGC9_IRTL		0x00000634
+ * MSR_PKGC10_IRTL		0x00000635
+ *
  */
 int has_hsw_msrs(unsigned int family, unsigned int model)
 {
@@ -3254,11 +3302,13 @@ void process_cpuid()
 
 	do_nhm_platform_info = do_nhm_cstates = do_smi = probe_nhm_msrs(family, model);
 	do_snb_cstates = has_snb_msrs(family, model);
+	do_irtl_snb = has_snb_msrs(family, model);
 	do_pc2 = do_snb_cstates && (pkg_cstate_limit >= PCL__2);
 	do_pc3 = (pkg_cstate_limit >= PCL__3);
 	do_pc6 = (pkg_cstate_limit >= PCL__6);
 	do_pc7 = do_snb_cstates && (pkg_cstate_limit >= PCL__7);
 	do_c8_c9_c10 = has_hsw_msrs(family, model);
+	do_irtl_hsw = has_hsw_msrs(family, model);
 	do_skl_residency = has_skl_msrs(family, model);
 	do_slm_cstates = is_slm(family, model);
 	do_knl_cstates  = is_knl(family, model);
@@ -3564,6 +3614,9 @@ void turbostat_init()
 
 	if (debug)
 		for_all_cpus(print_thermal, ODD_COUNTERS);
+
+	if (debug && do_irtl_snb)
+		print_irtl();
 }
 
 int fork_it(char **argv)
-- 
2.8.0.rc4.16.g56331f8

