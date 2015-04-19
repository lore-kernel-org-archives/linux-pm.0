From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/12] tools/power turbostat: correct dumped pkg-cstate-limit value
Date: Sat, 18 Apr 2015 20:40:27 -0400
Message-ID: <e9257f5fa48cc296d7eed35acf9f2ad195184122.1429402554.git.len.brown@intel.com>
References: <1429404027-23203-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:34374 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbbDSAlB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Apr 2015 20:41:01 -0400
Received: by qcyk17 with SMTP id k17so42197371qcy.1
        for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2015 17:41:00 -0700 (PDT)
In-Reply-To: <1429404027-23203-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
References: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

HSW expanded MSR_PKG_CST_CONFIG_CONTROL.Package-C-State-Limit,
from bits[2:0] used by previous implementations, to [3:0].
The value 1000b is unlimited, and is used by BDW and SKL too.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 203d45d..bac98ca 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1137,13 +1137,12 @@ int pkg_cstate_limit = PCLUKN;
 char *pkg_cstate_limit_strings[] = { "reserved", "unknown", "pc0", "pc1", "pc2",
 	"pc3", "pc4", "pc6", "pc6n", "pc6r", "pc7", "pc7s", "pc8", "pc9", "unlimited"};
 
-int nhm_pkg_cstate_limits[8] = {PCL__0, PCL__1, PCL__3, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLUNL};
-int snb_pkg_cstate_limits[8] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCL__7, PCL_7S, PCLRSV, PCLUNL};
-int hsw_pkg_cstate_limits[8] = {PCL__0, PCL__2, PCL__3, PCL__6, PCL__7, PCL_7S, PCLRSV, PCLUNL};
-int skl_pkg_cstate_limits[8] = {PCL__0, PCL__2, PCL__3, PCL__6, PCL__7, PCL_7S, PCL__8, PCL__9};
-int slv_pkg_cstate_limits[8] = {PCL__0, PCL__1, PCLRSV, PCLRSV, PCL__4, PCLRSV, PCL__6, PCL__7};
-int amt_pkg_cstate_limits[8] = {PCL__0, PCL__1, PCL__2, PCLRSV, PCLRSV, PCLRSV, PCL__6, PCL__7};
-int phi_pkg_cstate_limits[8] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL};
+int nhm_pkg_cstate_limits[16] = {PCL__0, PCL__1, PCL__3, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
+int snb_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCL__7, PCL_7S, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
+int hsw_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL__3, PCL__6, PCL__7, PCL_7S, PCL__8, PCL__9, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
+int slv_pkg_cstate_limits[16] = {PCL__0, PCL__1, PCLRSV, PCLRSV, PCL__4, PCLRSV, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
+int amt_pkg_cstate_limits[16] = {PCL__0, PCL__1, PCL__2, PCLRSV, PCLRSV, PCLRSV, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
+int phi_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 
 static void
 dump_nhm_platform_info(void)
@@ -1707,7 +1706,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	}
 	get_msr(0, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
 
-	pkg_cstate_limit = pkg_cstate_limits[msr & 0x7];
+	pkg_cstate_limit = pkg_cstate_limits[msr & 0xF];
 
 	return 1;
 }
@@ -2871,7 +2870,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(stderr, "turbostat version 4.4 2 Apr, 2015"
+	fprintf(stderr, "turbostat version 4.5 2 Apr, 2015"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.4.0.rc1

