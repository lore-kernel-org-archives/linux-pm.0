From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/12] tools/power turbostat: use new MSR_TURBO_RATIO_LIMIT names
Date: Sat, 18 Apr 2015 20:40:20 -0400
Message-ID: <12bb43c6150525cd53af77a1a7b9ff2752944cbd.1429402554.git.len.brown@intel.com>
References: <1429404027-23203-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36411 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbbDSAkv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Apr 2015 20:40:51 -0400
Received: by qku63 with SMTP id 63so173262301qku.3
        for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2015 17:40:50 -0700 (PDT)
In-Reply-To: <1429404027-23203-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
References: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

s/MSR_NHM_TURBO_RATIO_LIMIT/MSR_TURBO_RATIO_LIMIT/
s/MSR_IVT_TURBO_RATIO_LIMIT/MSR_TURBO_RATIO_LIMIT1/

syntax only -- use the documented strings describing these registers.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9bf6ca9..b699a0e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1105,9 +1105,9 @@ void dump_system_config_info(void)
 	if (!do_ivt_turbo_ratio_limit)
 		goto print_nhm_turbo_ratio_limits;
 
-	get_msr(0, MSR_IVT_TURBO_RATIO_LIMIT, &msr);
+	get_msr(0, MSR_TURBO_RATIO_LIMIT1, &msr);
 
-	fprintf(stderr, "cpu0: MSR_IVT_TURBO_RATIO_LIMIT: 0x%08llx\n", msr);
+	fprintf(stderr, "cpu0: MSR_TURBO_RATIO_LIMIT1: 0x%08llx\n", msr);
 
 	ratio = (msr >> 56) & 0xFF;
 	if (ratio)
@@ -1169,9 +1169,9 @@ print_nhm_turbo_ratio_limits:
 	if (!do_nhm_turbo_ratio_limit)
 		return;
 
-	get_msr(0, MSR_NHM_TURBO_RATIO_LIMIT, &msr);
+	get_msr(0, MSR_TURBO_RATIO_LIMIT, &msr);
 
-	fprintf(stderr, "cpu0: MSR_NHM_TURBO_RATIO_LIMIT: 0x%08llx\n", msr);
+	fprintf(stderr, "cpu0: MSR_TURBO_RATIO_LIMIT: 0x%08llx\n", msr);
 
 	ratio = (msr >> 56) & 0xFF;
 	if (ratio)
-- 
2.4.0.rc1

