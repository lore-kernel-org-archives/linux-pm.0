From: malattia@linux.it
Subject: [PATCH 3/3] Honour user's LDFLAGS
Date: Wed, 16 Mar 2016 07:13:08 -0700
Message-ID: <1458137588-6126-4-git-send-email-malattia@linux.it>
References: <1458137588-6126-1-git-send-email-malattia@linux.it>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35062 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933008AbcCPONV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 10:13:21 -0400
Received: by mail-pf0-f178.google.com with SMTP id n5so76789110pfn.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 07:13:21 -0700 (PDT)
In-Reply-To: <1458137588-6126-1-git-send-email-malattia@linux.it>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Mattia Dongili <malattia@linux.it>

From: Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 tools/power/cpupower/bench/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index 7ec7021..5445c03 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -16,7 +16,7 @@ $(OUTPUT)%.o : %.c
 
 $(OUTPUT)cpufreq-bench: $(OBJS)
 	$(ECHO) "  CC      " $@
-	$(QUIET) $(CC) -o $@ $(CFLAGS) $(OBJS) $(LIBS)
+	$(QUIET) $(CC) -o $@ $(CFLAGS) $(LDFLAGS) $(OBJS) $(LIBS)
 
 all: $(OUTPUT)cpufreq-bench
 
-- 
2.7.0

