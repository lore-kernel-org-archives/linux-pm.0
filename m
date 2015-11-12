From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/4] tools/power turbostat: bugfix: print MAX_NON_TURBO_RATIO
Date: Thu, 12 Nov 2015 02:42:30 -0500
Message-ID: <fb080ae3866e94dff7010fc978128c35e527a21f.1447313797.git.len.brown@intel.com>
References: <1447314152-2145-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35041 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbbKLHnM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2015 02:43:12 -0500
Received: by ykba77 with SMTP id a77so85986870ykb.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2015 23:43:11 -0800 (PST)
In-Reply-To: <1447314152-2145-1-git-send-email-lenb@kernel.org>
In-Reply-To: <22c227bf47c6812dd8ac4e59cae4acd3fec74272.1447313797.git.len.brown@intel.com>
References: <22c227bf47c6812dd8ac4e59cae4acd3fec74272.1447313797.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

MSR_TURBO_ACTIVATION_RATIO: 0x00000016 (MAX_NON_TURBO_RATIO=6 lock=0)
should print all 7 bits of MAX_NON_TURBO_RATIO (in decimal):
MSR_TURBO_ACTIVATION_RATIO: 0x00000016 (MAX_NON_TURBO_RATIO=22 lock=0)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 346bb54..32452a8 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1443,7 +1443,7 @@ dump_config_tdp(void)
 	
 	get_msr(base_cpu, MSR_TURBO_ACTIVATION_RATIO, &msr);
 	fprintf(stderr, "cpu%d: MSR_TURBO_ACTIVATION_RATIO: 0x%08llx (", base_cpu, msr);
-	fprintf(stderr, "MAX_NON_TURBO_RATIO=%d", (unsigned int)(msr) & 0xEF);
+	fprintf(stderr, "MAX_NON_TURBO_RATIO=%d", (unsigned int)(msr) & 0x7F);
 	fprintf(stderr, " lock=%d", (unsigned int)(msr >> 31) & 1);
 	fprintf(stderr, ")\n");
 }
-- 
2.6.2.450.g259b5e6

