From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] tools/thermal: tmon: use pkg-config also for CFLAGS
Date: Fri,  2 Oct 2015 09:50:45 +0000
Message-ID: <1443779445-19821-1-git-send-email-olaf@aepfle.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:28037 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbJBJu6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2015 05:50:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Olaf Hering <olaf@aepfle.de>

The header <panel.h> might be in /usr/include/ncursesw, which is not
part of the standard include path. This fixes compile on openSUSE.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 tools/thermal/tmon/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 2e83dd3..3a961e9 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -22,6 +22,9 @@ TMON_LIBS += $(shell pkg-config --libs $(STATIC) panelw ncursesw 2> /dev/null ||
 		     pkg-config --libs $(STATIC) panel ncurses 2> /dev/null || \
 		     echo -lpanel -lncurses)
 
+CFLAGS    += $(shell pkg-config --cflags $(STATIC) panelw ncursesw 2> /dev/null || \
+		     pkg-config --cflags $(STATIC) panel ncurses 2> /dev/null)
+
 OBJS = tmon.o tui.o sysfs.o pid.o
 OBJS +=
 
