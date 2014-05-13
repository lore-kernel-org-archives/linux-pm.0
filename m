From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 5/9] cpupower: Install recently added cpupower-idle-{set,info} manpages
Date: Tue, 13 May 2014 12:41:42 +0200
Message-ID: <1399977706-50854-6-git-send-email-trenn@suse.de>
References: <1399977706-50854-1-git-send-email-trenn@suse.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51395 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760593AbaEMKlx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 May 2014 06:41:53 -0400
In-Reply-To: <1399977706-50854-1-git-send-email-trenn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>

Index: b/tools/power/cpupower//Makefile
===================================================================
---
 tools/power/cpupower/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index dca6b43..78ce109 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -274,6 +274,8 @@ install-man:
 	$(INSTALL_DATA) -D man/cpupower.1 $(DESTDIR)${mandir}/man1/cpupower.1
 	$(INSTALL_DATA) -D man/cpupower-frequency-set.1 $(DESTDIR)${mandir}/man1/cpupower-frequency-set.1
 	$(INSTALL_DATA) -D man/cpupower-frequency-info.1 $(DESTDIR)${mandir}/man1/cpupower-frequency-info.1
+	$(INSTALL_DATA) -D man/cpupower-idle-set.1 $(DESTDIR)${mandir}/man1/cpupower-idle-set.1
+	$(INSTALL_DATA) -D man/cpupower-idle-info.1 $(DESTDIR)${mandir}/man1/cpupower-idle-info.1
 	$(INSTALL_DATA) -D man/cpupower-set.1 $(DESTDIR)${mandir}/man1/cpupower-set.1
 	$(INSTALL_DATA) -D man/cpupower-info.1 $(DESTDIR)${mandir}/man1/cpupower-info.1
 	$(INSTALL_DATA) -D man/cpupower-monitor.1 $(DESTDIR)${mandir}/man1/cpupower-monitor.1
-- 
1.7.6.1

