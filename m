From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/5] tools/power turbostat: update version number to 4.7
Date: Wed, 27 May 2015 18:08:06 -0400
Message-ID: <a68c7c3ff0469d79993ee85e8e0a3a9a568ce350.1432764245.git.len.brown@intel.com>
References: <1432764486-3517-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:34487 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbbE0WIY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 18:08:24 -0400
Received: by qcbhb1 with SMTP id hb1so10219524qcb.1
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2015 15:08:23 -0700 (PDT)
In-Reply-To: <1432764486-3517-1-git-send-email-lenb@kernel.org>
In-Reply-To: <e275b3885dffd31095984ed2476ed0447fa7309a.1432764245.git.len.brown@intel.com>
References: <e275b3885dffd31095984ed2476ed0447fa7309a.1432764245.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 68e77fd..323b65e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3014,7 +3014,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(stderr, "turbostat version 4.5 2 Apr, 2015"
+	fprintf(stderr, "turbostat version 4.7 27-May, 2015"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.4.1.314.g9532ead

