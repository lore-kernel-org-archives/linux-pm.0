From: Thomas Renninger <trenn@suse.com>
Subject: [PATCH 1/5] Honour user's LDFLAGS
Date: Thu, 28 Apr 2016 15:24:36 +0200
Message-ID: <1461849880-24777-1-git-send-email-trenn@suse.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33270 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbcD1NYo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Apr 2016 09:24:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, trenn@suse.com, Mattia Dongili <malattia@linux.it>

From: Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Thomas Renninger <trenn@suse.com>
---
 tools/power/cpupower/bench/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index d0f879b..3e59f1a 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -22,7 +22,7 @@ $(OUTPUT)%.o : %.c
 
 $(OUTPUT)cpufreq-bench: $(OBJS)
 	$(ECHO) "  CC      " $@
-	$(QUIET) $(CC) -o $@ $(CFLAGS) $(OBJS) $(LIBS)
+	$(QUIET) $(CC) -o $@ $(CFLAGS) $(LDFLAGS) $(OBJS) $(LIBS)
 
 all: $(OUTPUT)cpufreq-bench
 
-- 
1.8.5.6

