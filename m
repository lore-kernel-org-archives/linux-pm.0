From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/7] tools/power turbostat: initial BXT support
Date: Wed,  6 Apr 2016 17:15:56 -0400
Message-ID: <ab194a4c6300065606e1f57f720d8c145d7e0d42.1459977091.git.len.brown@intel.com>
References: <1459977360-2841-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35742 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbcDFVQn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:16:43 -0400
Received: by mail-yw0-f194.google.com with SMTP id k197so4285183ywe.2
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 14:16:43 -0700 (PDT)
In-Reply-To: <1459977360-2841-1-git-send-email-lenb@kernel.org>
In-Reply-To: <c0137ec621c50427091eeebeaff5cb7f7a426ecb.1459977091.git.len.brown@intel.com>
References: <c0137ec621c50427091eeebeaff5cb7f7a426ecb.1459977091.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Broxton has a lot in common with SKL

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2d5a27f..1561ac5 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1298,6 +1298,7 @@ int hsw_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL__3, PCL__6, PCL__7, PCL_7S,
 int slv_pkg_cstate_limits[16] = {PCL__0, PCL__1, PCLRSV, PCLRSV, PCL__4, PCLRSV, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int amt_pkg_cstate_limits[16] = {PCL__0, PCL__1, PCL__2, PCLRSV, PCLRSV, PCLRSV, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int phi_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
+int bxt_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 
 
 static void
@@ -2199,6 +2200,9 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	case 0x57:	/* PHI */
 		pkg_cstate_limits = phi_pkg_cstate_limits;
 		break;
+	case 0x5C:	/* BXT */
+		pkg_cstate_limits = bxt_pkg_cstate_limits;
+		break;
 	default:
 		return 0;
 	}
@@ -2628,6 +2632,9 @@ void rapl_probe(unsigned int family, unsigned int model)
 	case 0x47:	/* BDW */
 		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_GFX | RAPL_PKG_POWER_INFO;
 		break;
+	case 0x5C:	/* BXT */
+		do_rapl = RAPL_PKG | RAPL_PKG_POWER_INFO;
+		break;
 	case 0x4E:	/* SKL */
 	case 0x5E:	/* SKL */
 		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
@@ -2914,6 +2921,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case 0x56:	/* BDX-DE */
 	case 0x4E:	/* SKL */
 	case 0x5E:	/* SKL */
+	case 0x5C:	/* BXT */
 		return 1;
 	}
 	return 0;
@@ -2941,6 +2949,7 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
 	case 0x3D:	/* BDW */
 	case 0x4E:	/* SKL */
 	case 0x5E:	/* SKL */
+	case 0x5C:	/* BXT */
 		return 1;
 	}
 	return 0;
-- 
2.8.0.rc4.16.g56331f8

