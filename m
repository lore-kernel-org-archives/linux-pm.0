From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/5] tools/power turbostat: update version number
Date: Sat, 24 Jun 2017 20:13:01 -0700
Message-ID: <f7d44a8f3fd7f13770470a306a233acbaad5e96d.1498359826.git.len.brown@intel.com>
References: <1498360381-10293-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35546 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdFYDNM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jun 2017 23:13:12 -0400
Received: by mail-qt0-f194.google.com with SMTP id w12so9928718qta.2
        for <linux-pm@vger.kernel.org>; Sat, 24 Jun 2017 20:13:12 -0700 (PDT)
In-Reply-To: <1498360381-10293-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a99d87306f83d2a97c8c7e854b6583c4037ecf75.1498359826.git.len.brown@intel.com>
References: <a99d87306f83d2a97c8c7e854b6583c4037ecf75.1498359826.git.len.brown@intel.com>
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
index 33992a9..0dafba2 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4634,7 +4634,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(outf, "turbostat version 17.04.12"
+	fprintf(outf, "turbostat version 17.06.23"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.7.4
