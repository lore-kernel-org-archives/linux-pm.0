From: Dmitry Shachnev <mitya57@debian.org>
Subject: [PATCH] cpupower: Install cpupower.h as a public header file
Date: Mon, 16 Oct 2017 21:50:04 +0300
Message-ID: <20171016185004.zyq6eugwedc34f7l@mitya57.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44018 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755009AbdJPSuI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 14:50:08 -0400
Received: by mail-lf0-f65.google.com with SMTP id a16so18135261lfk.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2017 11:50:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org

This helps software that uses cpupower_is_cpu_online function, such as
gnome-applets.

Signed-off-by: Dmitry Shachnev <mitya57@debian.org>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=153161
---
 tools/power/cpupower/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 4c5a481a850c..113e14983c7d 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -278,6 +278,7 @@ install-lib:
 	$(INSTALL) -d $(DESTDIR)${includedir}
 	$(INSTALL_DATA) lib/cpufreq.h $(DESTDIR)${includedir}/cpufreq.h
 	$(INSTALL_DATA) lib/cpuidle.h $(DESTDIR)${includedir}/cpuidle.h
+	$(INSTALL_DATA) lib/cpupower.h $(DESTDIR)${includedir}/cpupower.h
 
 install-tools:
 	$(INSTALL) -d $(DESTDIR)${bindir}
@@ -314,6 +315,7 @@ uninstall:
 	- rm -f $(DESTDIR)${libdir}/libcpupower.*
 	- rm -f $(DESTDIR)${includedir}/cpufreq.h
 	- rm -f $(DESTDIR)${includedir}/cpuidle.h
+	- rm -f $(DESTDIR)${includedir}/cpupower.h
 	- rm -f $(DESTDIR)${bindir}/utils/cpupower
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower.1
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower-frequency-set.1
-- 
2.14.1


--
Dmitry Shachnev
