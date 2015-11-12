From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/4] tools/power turbostat: use new name for MSR_PLATFORM_INFO
Date: Thu, 12 Nov 2015 02:42:31 -0500
Message-ID: <bc253360d99c2d6e9b276de1d9f8ba3e83dd2888.1447313797.git.len.brown@intel.com>
References: <1447314152-2145-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33792 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbbKLHnO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2015 02:43:14 -0500
Received: by ykfs79 with SMTP id s79so86468813ykf.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2015 23:43:13 -0800 (PST)
In-Reply-To: <1447314152-2145-1-git-send-email-lenb@kernel.org>
In-Reply-To: <22c227bf47c6812dd8ac4e59cae4acd3fec74272.1447313797.git.len.brown@intel.com>
References: <22c227bf47c6812dd8ac4e59cae4acd3fec74272.1447313797.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

MSR_PLATFORM_INFO is the new name for MSR_NHM_PLATFORM_INFO

no functional change

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 32452a8..96794f3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1176,9 +1176,9 @@ dump_nhm_platform_info(void)
 	unsigned long long msr;
 	unsigned int ratio;
 
-	get_msr(base_cpu, MSR_NHM_PLATFORM_INFO, &msr);
+	get_msr(base_cpu, MSR_PLATFORM_INFO, &msr);
 
-	fprintf(stderr, "cpu%d: MSR_NHM_PLATFORM_INFO: 0x%08llx\n", base_cpu, msr);
+	fprintf(stderr, "cpu%d: MSR_PLATFORM_INFO: 0x%08llx\n", base_cpu, msr);
 
 	ratio = (msr >> 40) & 0xFF;
 	fprintf(stderr, "%d * %.0f = %.0f MHz max efficiency frequency\n",
@@ -1810,7 +1810,7 @@ void check_permissions()
  *
  * MSR_SMI_COUNT                   0x00000034
  *
- * MSR_NHM_PLATFORM_INFO           0x000000ce
+ * MSR_PLATFORM_INFO               0x000000ce
  * MSR_NHM_SNB_PKG_CST_CFG_CTL     0x000000e2
  *
  * MSR_PKG_C3_RESIDENCY            0x000003f8
@@ -1879,7 +1879,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	get_msr(base_cpu, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
 	pkg_cstate_limit = pkg_cstate_limits[msr & 0xF];
 
-	get_msr(base_cpu, MSR_NHM_PLATFORM_INFO, &msr);
+	get_msr(base_cpu, MSR_PLATFORM_INFO, &msr);
 	base_ratio = (msr >> 8) & 0xFF;
 
 	base_hz = base_ratio * bclk * 1000000;
-- 
2.6.2.450.g259b5e6

