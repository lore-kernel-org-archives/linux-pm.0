From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/7] tools/power turbostat: initial KBL support
Date: Wed,  6 Apr 2016 17:15:59 -0400
Message-ID: <504daa1369cf309351fc24a3e41f19cb8ce3cc3f.1459977091.git.len.brown@intel.com>
References: <1459977360-2841-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35767 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbcDFVQr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:16:47 -0400
Received: by mail-yw0-f193.google.com with SMTP id k197so4285393ywe.2
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 14:16:46 -0700 (PDT)
In-Reply-To: <1459977360-2841-1-git-send-email-lenb@kernel.org>
In-Reply-To: <c0137ec621c50427091eeebeaff5cb7f7a426ecb.1459977091.git.len.brown@intel.com>
References: <c0137ec621c50427091eeebeaff5cb7f7a426ecb.1459977091.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

KBL is similar to SKL

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4950cdf..e3b803b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2188,6 +2188,8 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	case 0x56:	/* BDX-DE */
 	case 0x4E:	/* SKL */
 	case 0x5E:	/* SKL */
+	case 0x8E:	/* KBL */
+	case 0x9E:	/* KBL */
 	case 0x55:	/* SKX */
 		pkg_cstate_limits = hsw_pkg_cstate_limits;
 		break;
@@ -2296,6 +2298,8 @@ int has_config_tdp(unsigned int family, unsigned int model)
 	case 0x56:	/* BDX-DE */
 	case 0x4E:	/* SKL */
 	case 0x5E:	/* SKL */
+	case 0x8E:	/* KBL */
+	case 0x9E:	/* KBL */
 	case 0x55:	/* SKX */
 
 	case 0x57:	/* Knights Landing */
@@ -2639,6 +2643,8 @@ void rapl_probe(unsigned int family, unsigned int model)
 		break;
 	case 0x4E:	/* SKL */
 	case 0x5E:	/* SKL */
+	case 0x8E:	/* KBL */
+	case 0x9E:	/* KBL */
 		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
 		break;
 	case 0x3F:	/* HSX */
@@ -2924,6 +2930,8 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case 0x56:	/* BDX-DE */
 	case 0x4E:	/* SKL */
 	case 0x5E:	/* SKL */
+	case 0x8E:	/* KBL */
+	case 0x9E:	/* KBL */
 	case 0x55:	/* SKX */
 	case 0x5C:	/* BXT */
 		return 1;
@@ -2953,6 +2961,8 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
 	case 0x3D:	/* BDW */
 	case 0x4E:	/* SKL */
 	case 0x5E:	/* SKL */
+	case 0x8E:	/* KBL */
+	case 0x9E:	/* KBL */
 	case 0x5C:	/* BXT */
 		return 1;
 	}
@@ -2975,6 +2985,8 @@ int has_skl_msrs(unsigned int family, unsigned int model)
 	switch (model) {
 	case 0x4E:	/* SKL */
 	case 0x5E:	/* SKL */
+	case 0x8E:	/* KBL */
+	case 0x9E:	/* KBL */
 		return 1;
 	}
 	return 0;
@@ -3282,6 +3294,8 @@ void process_cpuid()
 				switch(model) {
 				case 0x4E:	/* SKL */
 				case 0x5E:	/* SKL */
+				case 0x8E:	/* KBL */
+				case 0x9E:	/* KBL */
 					crystal_hz = 24000000;	/* 24.0 MHz */
 					break;
 				case 0x55:	/* SKX */
-- 
2.8.0.rc4.16.g56331f8

