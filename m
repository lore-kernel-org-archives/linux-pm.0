From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/17] tools/power turbostat: fix SKX PKG_CSTATE_LIMIT decoding
Date: Sat, 24 Dec 2016 15:53:41 -0500
Message-ID: <d8ebb442264de62d5d0157adb8f0df96e831b3d3.1482612381.git.len.brown@intel.com>
References: <20161224205345.29129-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34596 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbcLXU4M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Dec 2016 15:56:12 -0500
Received: by mail-qt0-f195.google.com with SMTP id p16so14974369qta.1
        for <linux-pm@vger.kernel.org>; Sat, 24 Dec 2016 12:56:12 -0800 (PST)
In-Reply-To: <20161224205345.29129-1-lenb@kernel.org>
In-Reply-To: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
References: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

SKX has fewer package C-states than previous generations,
and so the decoding of PKG_CSTATE_LIMIT has changed.

This changes the line ending with pkg-cstate-limit=XXX: pcYYY

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a54ca3775521..10ae4ffe137c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1294,6 +1294,7 @@ int slv_pkg_cstate_limits[16] = {PCL__0, PCL__1, PCLRSV, PCLRSV, PCL__4, PCLRSV,
 int amt_pkg_cstate_limits[16] = {PCL__0, PCL__1, PCL__2, PCLRSV, PCLRSV, PCLRSV, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int phi_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int bxt_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
+int skx_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 
 
 static void
@@ -2191,9 +2192,11 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_SKYLAKE_DESKTOP:	/* SKL */
 	case INTEL_FAM6_KABYLAKE_MOBILE:	/* KBL */
 	case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
-	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 		pkg_cstate_limits = hsw_pkg_cstate_limits;
 		break;
+	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
+		pkg_cstate_limits = skx_pkg_cstate_limits;
+		break;
 	case INTEL_FAM6_ATOM_SILVERMONT1:	/* BYT */
 	case INTEL_FAM6_ATOM_SILVERMONT2:	/* AVN */
 		pkg_cstate_limits = slv_pkg_cstate_limits;
-- 
2.11.0.161.g6610af872

