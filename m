From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/9] cpupower: Remove all manpages on make uninstall
Date: Tue, 13 May 2014 12:41:40 +0200
Message-ID: <1399977706-50854-4-git-send-email-trenn@suse.de>
References: <1399977706-50854-1-git-send-email-trenn@suse.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51384 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760198AbaEMKlv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 May 2014 06:41:51 -0400
In-Reply-To: <1399977706-50854-1-git-send-email-trenn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>, Thomas Renninger <trenn@suse.de>

From: Ramkumar Ramachandra <artagnon@gmail.com>

Cc: Thomas Renninger <trenn@suse.de>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/cpupower/Makefile |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index cbfec92..dca6b43 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -295,8 +295,12 @@ uninstall:
 	- rm -f $(DESTDIR)${libdir}/libcpupower.*
 	- rm -f $(DESTDIR)${includedir}/cpufreq.h
 	- rm -f $(DESTDIR)${bindir}/utils/cpupower
-	- rm -f $(DESTDIR)${mandir}/man1/cpufreq-set.1
-	- rm -f $(DESTDIR)${mandir}/man1/cpufreq-info.1
+	- rm -f $(DESTDIR)${mandir}/man1/cpupower.1
+	- rm -f $(DESTDIR)${mandir}/man1/cpupower-frequency-set.1
+	- rm -f $(DESTDIR)${mandir}/man1/cpupower-frequency-info.1
+	- rm -f $(DESTDIR)${mandir}/man1/cpupower-set.1
+	- rm -f $(DESTDIR)${mandir}/man1/cpupower-info.1
+	- rm -f $(DESTDIR)${mandir}/man1/cpupower-monitor.1
 	- for HLANG in $(LANGUAGES); do \
 		rm -f $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo; \
 	  done;
-- 
1.7.6.1

