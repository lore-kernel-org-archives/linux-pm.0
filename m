From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/7] tools/power turbostat: cpu0 is no longer hard-coded, so  update output
Date: Sat, 15 Aug 2015 23:25:43 -0400
Message-ID: <bfae2052265cde825afaba35eb3a4d3889432734.1439695194.git.len.brown@intel.com>
References: <1439695548-21174-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36388 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbbHPDd6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 15 Aug 2015 23:33:58 -0400
In-Reply-To: <1439695548-21174-1-git-send-email-lenb@kernel.org>
In-Reply-To: <75fd7ffa7fab91c2c3234bd3e465ba4f366733f4.1439695194.git.len.brown@intel.com>
References: <75fd7ffa7fab91c2c3234bd3e465ba4f366733f4.1439695194.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

The --debug option reads a number of per-package MSRs.
Previously we explicitly read them on cpu0, but recently
turbostat changed to read them on the current "base_cpu".

Update the print-out to reflect base_cpu, rather than
the hard-coded cpu0.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 323b65e..67162ec 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1157,7 +1157,7 @@ dump_nhm_platform_info(void)
 
 	get_msr(base_cpu, MSR_NHM_PLATFORM_INFO, &msr);
 
-	fprintf(stderr, "cpu0: MSR_NHM_PLATFORM_INFO: 0x%08llx\n", msr);
+	fprintf(stderr, "cpu%d: MSR_NHM_PLATFORM_INFO: 0x%08llx\n", base_cpu, msr);
 
 	ratio = (msr >> 40) & 0xFF;
 	fprintf(stderr, "%d * %.0f = %.0f MHz max efficiency frequency\n",
@@ -1168,8 +1168,8 @@ dump_nhm_platform_info(void)
 		ratio, bclk, ratio * bclk);
 
 	get_msr(base_cpu, MSR_IA32_POWER_CTL, &msr);
-	fprintf(stderr, "cpu0: MSR_IA32_POWER_CTL: 0x%08llx (C1E auto-promotion: %sabled)\n",
-		msr, msr & 0x2 ? "EN" : "DIS");
+	fprintf(stderr, "cpu%d: MSR_IA32_POWER_CTL: 0x%08llx (C1E auto-promotion: %sabled)\n",
+		base_cpu, msr, msr & 0x2 ? "EN" : "DIS");
 
 	return;
 }
@@ -1182,7 +1182,7 @@ dump_hsw_turbo_ratio_limits(void)
 
 	get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT2, &msr);
 
-	fprintf(stderr, "cpu0: MSR_TURBO_RATIO_LIMIT2: 0x%08llx\n", msr);
+	fprintf(stderr, "cpu%d: MSR_TURBO_RATIO_LIMIT2: 0x%08llx\n", base_cpu, msr);
 
 	ratio = (msr >> 8) & 0xFF;
 	if (ratio)
@@ -1204,7 +1204,7 @@ dump_ivt_turbo_ratio_limits(void)
 
 	get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT1, &msr);
 
-	fprintf(stderr, "cpu0: MSR_TURBO_RATIO_LIMIT1: 0x%08llx\n", msr);
+	fprintf(stderr, "cpu%d: MSR_TURBO_RATIO_LIMIT1: 0x%08llx\n", base_cpu, msr);
 
 	ratio = (msr >> 56) & 0xFF;
 	if (ratio)
@@ -1256,7 +1256,7 @@ dump_nhm_turbo_ratio_limits(void)
 
 	get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT, &msr);
 
-	fprintf(stderr, "cpu0: MSR_TURBO_RATIO_LIMIT: 0x%08llx\n", msr);
+	fprintf(stderr, "cpu%d: MSR_TURBO_RATIO_LIMIT: 0x%08llx\n", base_cpu, msr);
 
 	ratio = (msr >> 56) & 0xFF;
 	if (ratio)
@@ -1312,8 +1312,8 @@ dump_knl_turbo_ratio_limits(void)
 
 	get_msr(base_cpu, MSR_NHM_TURBO_RATIO_LIMIT, &msr);
 
-	fprintf(stderr, "cpu0: MSR_NHM_TURBO_RATIO_LIMIT: 0x%08llx\n",
-	msr);
+	fprintf(stderr, "cpu%d: MSR_NHM_TURBO_RATIO_LIMIT: 0x%08llx\n",
+		base_cpu, msr);
 
 	/**
 	 * Turbo encoding in KNL is as follows:
@@ -1371,7 +1371,7 @@ dump_nhm_cst_cfg(void)
 #define SNB_C1_AUTO_UNDEMOTE              (1UL << 27)
 #define SNB_C3_AUTO_UNDEMOTE              (1UL << 28)
 
-	fprintf(stderr, "cpu0: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x%08llx", msr);
+	fprintf(stderr, "cpu%d: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x%08llx", base_cpu, msr);
 
 	fprintf(stderr, " (%s%s%s%s%slocked: pkg-cstate-limit=%d: %s)\n",
 		(msr & SNB_C3_AUTO_UNDEMOTE) ? "UNdemote-C3, " : "",
-- 
2.5.0.330.g130be8e

