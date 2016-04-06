From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/7] tools/power turbostat: initial SKX support
Date: Wed,  6 Apr 2016 17:15:58 -0400
Message-ID: <377e832496c3c3847b625b71f7a4f5e6da37aa53.1459977091.git.len.brown@intel.com>
References: <1459977360-2841-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35757 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbcDFVQp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:16:45 -0400
Received: by mail-yw0-f196.google.com with SMTP id k197so4285323ywe.2
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 14:16:45 -0700 (PDT)
In-Reply-To: <1459977360-2841-1-git-send-email-lenb@kernel.org>
In-Reply-To: <c0137ec621c50427091eeebeaff5cb7f7a426ecb.1459977091.git.len.brown@intel.com>
References: <c0137ec621c50427091eeebeaff5cb7f7a426ecb.1459977091.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

SKX has a lot in common with HSX

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 751bbcb..4950cdf 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2188,6 +2188,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	case 0x56:	/* BDX-DE */
 	case 0x4E:	/* SKL */
 	case 0x5E:	/* SKL */
+	case 0x55:	/* SKX */
 		pkg_cstate_limits = hsw_pkg_cstate_limits;
 		break;
 	case 0x37:	/* BYT */
@@ -2295,6 +2296,7 @@ int has_config_tdp(unsigned int family, unsigned int model)
 	case 0x56:	/* BDX-DE */
 	case 0x4E:	/* SKL */
 	case 0x5E:	/* SKL */
+	case 0x55:	/* SKX */
 
 	case 0x57:	/* Knights Landing */
 		return 1;
@@ -2642,6 +2644,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 	case 0x3F:	/* HSX */
 	case 0x4F:	/* BDX */
 	case 0x56:	/* BDX-DE */
+	case 0x55:	/* SKX */
 	case 0x57:	/* KNL */
 		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
 		break;
@@ -2921,6 +2924,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case 0x56:	/* BDX-DE */
 	case 0x4E:	/* SKL */
 	case 0x5E:	/* SKL */
+	case 0x55:	/* SKX */
 	case 0x5C:	/* BXT */
 		return 1;
 	}
@@ -3280,6 +3284,9 @@ void process_cpuid()
 				case 0x5E:	/* SKL */
 					crystal_hz = 24000000;	/* 24.0 MHz */
 					break;
+				case 0x55:	/* SKX */
+					crystal_hz = 25000000;	/* 25.0 MHz */
+					break;
 				case 0x5C:	/* BXT */
 					crystal_hz = 19200000;	/* 19.2 MHz */
 					break;
@@ -3694,7 +3701,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(outf, "turbostat version 4.11 27 Feb 2016"
+	fprintf(outf, "turbostat version 4.12 5 Apr 2016"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.8.0.rc4.16.g56331f8

