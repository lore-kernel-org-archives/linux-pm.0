From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/12] tools/power turbostat: label base frequency
Date: Sat, 18 Apr 2015 20:40:18 -0400
Message-ID: <8f61f3598d541b12e714d9e3f8f6094cff946c6f.1429402554.git.len.brown@intel.com>
References: <1429404027-23203-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33396 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbbDSAkr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Apr 2015 20:40:47 -0400
Received: by qkx62 with SMTP id 62so169761422qkx.0
        for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2015 17:40:47 -0700 (PDT)
In-Reply-To: <1429404027-23203-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
References: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

syntax only.

The cool kids are now using the phrase "base frequency",
where in the past we used "max non-turbo frequency" or "TSC frequency".

This distinction becomes important when a processor has a TSC
that runs at a different speed than the "base frequency".

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 50ef857..9bf6ca9 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1091,11 +1091,11 @@ void dump_system_config_info(void)
 	fprintf(stderr, "cpu0: MSR_NHM_PLATFORM_INFO: 0x%08llx\n", msr);
 
 	ratio = (msr >> 40) & 0xFF;
-	fprintf(stderr, "%d * %.0f = %.0f MHz max efficiency\n",
+	fprintf(stderr, "%d * %.0f = %.0f MHz max efficiency frequency\n",
 		ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 8) & 0xFF;
-	fprintf(stderr, "%d * %.0f = %.0f MHz TSC frequency\n",
+	fprintf(stderr, "%d * %.0f = %.0f MHz base frequency\n",
 		ratio, bclk, ratio * bclk);
 
 	get_msr(0, MSR_IA32_POWER_CTL, &msr);
-- 
2.4.0.rc1

