From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/17] tools/power turbostat: line up headers when -M is used
Date: Sat, 24 Dec 2016 15:53:42 -0500
Message-ID: <5cc6323c797687d7193fef6deec589c23f16289a.1482612381.git.len.brown@intel.com>
References: <20161224205345.29129-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35340 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbcLXU4N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Dec 2016 15:56:13 -0500
Received: by mail-qt0-f193.google.com with SMTP id 3so11111635qtr.2
        for <linux-pm@vger.kernel.org>; Sat, 24 Dec 2016 12:56:13 -0800 (PST)
In-Reply-To: <20161224205345.29129-1-lenb@kernel.org>
In-Reply-To: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
References: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

The -M option adds an 18-column item, and the header
needs to be wide enough to keep the header aligned
with the columns.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 10ae4ffe137c..cfdb574ea302 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -345,7 +345,7 @@ void print_header(void)
 	if (extra_delta_offset64)
 		outp += sprintf(outp, "\tCOUNT 0x%03X", extra_delta_offset64);
 	if (extra_msr_offset32)
-		outp += sprintf(outp, "\tMSR 0x%03X", extra_msr_offset32);
+		outp += sprintf(outp, "\t         MSR 0x%03X", extra_msr_offset32);
 	if (extra_msr_offset64)
 		outp += sprintf(outp, "\tMSR 0x%03X", extra_msr_offset64);
 
-- 
2.11.0.161.g6610af872

