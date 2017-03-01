From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/44] tools/power turbostat: use new name for MSR_PKG_CST_CONFIG_CONTROL
Date: Wed,  1 Mar 2017 00:27:13 -0500
Message-ID: <1df2e55abce64e2f3117fac3968a9ac382fbc9c3.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36231 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdCAITk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 03:19:40 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Previously called MSR_NHM_SNB_PKG_CST_CFG_CTL

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index aedfaddbad30..d56f2b75dc58 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1761,12 +1761,12 @@ dump_nhm_cst_cfg(void)
 {
 	unsigned long long msr;
 
-	get_msr(base_cpu, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
+	get_msr(base_cpu, MSR_PKG_CST_CONFIG_CONTROL, &msr);
 
 #define SNB_C1_AUTO_UNDEMOTE              (1UL << 27)
 #define SNB_C3_AUTO_UNDEMOTE              (1UL << 28)
 
-	fprintf(outf, "cpu%d: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x%08llx", base_cpu, msr);
+	fprintf(outf, "cpu%d: MSR_PKG_CST_CONFIG_CONTROL: 0x%08llx", base_cpu, msr);
 
 	fprintf(outf, " (%s%s%s%s%slocked: pkg-cstate-limit=%d: %s)\n",
 		(msr & SNB_C3_AUTO_UNDEMOTE) ? "UNdemote-C3, " : "",
@@ -2383,7 +2383,7 @@ void check_permissions()
  * MSR_SMI_COUNT                   0x00000034
  *
  * MSR_PLATFORM_INFO               0x000000ce
- * MSR_NHM_SNB_PKG_CST_CFG_CTL     0x000000e2
+ * MSR_PKG_CST_CONFIG_CONTROL     0x000000e2
  *
  * MSR_MISC_PWR_MGMT               0x000001aa
  *
@@ -2393,7 +2393,7 @@ void check_permissions()
  * MSR_CORE_C6_RESIDENCY           0x000003fd
  *
  * Side effect:
- * sets global pkg_cstate_limit to decode MSR_NHM_SNB_PKG_CST_CFG_CTL
+ * sets global pkg_cstate_limit to decode MSR_PKG_CST_CONFIG_CONTROL
  */
 int probe_nhm_msrs(unsigned int family, unsigned int model)
 {
@@ -2462,7 +2462,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	default:
 		return 0;
 	}
-	get_msr(base_cpu, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
+	get_msr(base_cpu, MSR_PKG_CST_CONFIG_CONTROL, &msr);
 	pkg_cstate_limit = pkg_cstate_limits[msr & 0xF];
 
 	get_msr(base_cpu, MSR_PLATFORM_INFO, &msr);
-- 
2.11.0.161.g6610af872
