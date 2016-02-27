From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/16] tools/power turbostat: fix compiler warnings
Date: Sat, 27 Feb 2016 04:01:05 -0500
Message-ID: <f8fa621c125be932aec39528e44a36a877d7efac.1456563103.git.len.brown@intel.com>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33595 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932227AbcB0JCD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 04:02:03 -0500
Received: by mail-yw0-f193.google.com with SMTP id c124so5318356ywe.0
        for <linux-pm@vger.kernel.org>; Sat, 27 Feb 2016 01:02:02 -0800 (PST)
In-Reply-To: <1456563670-23282-1-git-send-email-lenb@kernel.org>
In-Reply-To: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
References: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5f9f41a..ad5bd56 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1987,7 +1987,7 @@ int has_config_tdp(unsigned int family, unsigned int model)
 }
 
 static void
-dump_cstate_pstate_config_info(family, model)
+dump_cstate_pstate_config_info(int family, int model)
 {
 	if (!do_nhm_platform_info)
 		return;
@@ -2250,7 +2250,7 @@ int print_perf_limit(struct thread_data *t, struct core_data *c, struct pkg_data
 #define	RAPL_POWER_GRANULARITY	0x7FFF	/* 15 bit power granularity */
 #define	RAPL_TIME_GRANULARITY	0x3F /* 6 bit time granularity */
 
-double get_tdp(model)
+double get_tdp(int model)
 {
 	unsigned long long msr;
 
@@ -2364,7 +2364,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 	return;
 }
 
-void perf_limit_reasons_probe(family, model)
+void perf_limit_reasons_probe(int family, int model)
 {
 	if (!genuine_intel)
 		return;
@@ -2974,7 +2974,7 @@ void process_cpuid()
 	perf_limit_reasons_probe(family, model);
 
 	if (debug)
-		dump_cstate_pstate_config_info();
+		dump_cstate_pstate_config_info(family, model);
 
 	if (has_skl_msrs(family, model))
 		calculate_tsc_tweak();
-- 
2.7.1.339.g0233b80

