From: Colin King <colin.king@canonical.com>
Subject: [PATCH] tools/power turbostat: fix overflow read on array slm_freq_table
Date: Mon, 25 Apr 2016 13:03:15 +0100
Message-ID: <1461585795-23828-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39663 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592AbcDYMDR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 08:03:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

When i >= SLM_BCLK_FREQS, the frequency read from the slm_freq_table
is off the end of the array because msr is set to 3 rather than the
actual array index i.  Set i to 3 rather than msr to fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index acbf7ff..a66f07c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3050,7 +3050,7 @@ double slm_bclk(void)
 	i = msr & 0xf;
 	if (i >= SLM_BCLK_FREQS) {
 		fprintf(outf, "SLM BCLK[%d] invalid\n", i);
-		msr = 3;
+		i = 3;
 	}
 	freq = slm_freq_table[i];
 
-- 
2.7.4

