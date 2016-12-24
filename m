From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/17] tools/power turbostat: fix error case overflow read of slm_freq_table[]
Date: Sat, 24 Dec 2016 15:53:33 -0500
Message-ID: <0a91e551527a7b931d36f4822b97e70536bd2bb3.1482612381.git.len.brown@intel.com>
References: <20161224205345.29129-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:32830 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbcLXU4H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Dec 2016 15:56:07 -0500
Received: by mail-qk0-f196.google.com with SMTP id n21so21671385qka.0
        for <linux-pm@vger.kernel.org>; Sat, 24 Dec 2016 12:56:07 -0800 (PST)
In-Reply-To: <20161224205345.29129-1-lenb@kernel.org>
In-Reply-To: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
References: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Colin Ian King <colin.king@canonical.com>, Len Brown <len.brown@intel.com>

From: Colin Ian King <colin.king@canonical.com>

When i >= SLM_BCLK_FREQS, the frequency read from the slm_freq_table
is off the end of the array because msr is set to 3 rather than the
actual array index i.  Set i to 3 rather than msr to fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 741fefa2f07e..12a6eea2d6ae 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3036,7 +3036,7 @@ double slm_bclk(void)
 	i = msr & 0xf;
 	if (i >= SLM_BCLK_FREQS) {
 		fprintf(outf, "SLM BCLK[%d] invalid\n", i);
-		msr = 3;
+		i = 3;
 	}
 	freq = slm_freq_table[i];
 
-- 
2.11.0.161.g6610af872

