From: Markus Mayer <code@mmayer.net>
Subject: [PATCH 3/3] tools/thermal: tmon: use $(PKG_CONFIG) instead of hard-coding pkg-config
Date: Wed, 27 Sep 2017 16:02:37 -0700
Message-ID: <20170927230237.62199-4-code@mmayer.net>
References: <20170927230237.62199-1-code@mmayer.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170927230237.62199-1-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Markus Mayer <mmayer@broadcom.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

To ease cross-compiling, make use of the $(PKG_CONFIG) variable rather
than hard-coding calls to pkg-config.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 tools/thermal/tmon/Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 581da71..1e11bd3 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -9,6 +9,7 @@ CFLAGS+= -O1 ${WARNFLAGS}
 # Add "-fstack-protector" only if toolchain supports it.
 CFLAGS+= $(call cc-option,-fstack-protector)
 CC?= $(CROSS_COMPILE)gcc
+PKG_CONFIG?= pkg-config
 
 CFLAGS+=-D VERSION=\"$(VERSION)\"
 LDFLAGS+=
@@ -23,12 +24,12 @@ STATIC := --static
 endif
 
 TMON_LIBS=-lm -lpthread
-TMON_LIBS += $(shell pkg-config --libs $(STATIC) panelw ncursesw 2> /dev/null || \
-		     pkg-config --libs $(STATIC) panel ncurses 2> /dev/null || \
+TMON_LIBS += $(shell $(PKG_CONFIG) --libs $(STATIC) panelw ncursesw 2> /dev/null || \
+		     $(PKG_CONFIG) --libs $(STATIC) panel ncurses 2> /dev/null || \
 		     echo -lpanel -lncurses)
 
-CFLAGS    += $(shell pkg-config --cflags $(STATIC) panelw ncursesw 2> /dev/null || \
-		     pkg-config --cflags $(STATIC) panel ncurses 2> /dev/null)
+CFLAGS    += $(shell $(PKG_CONFIG) --cflags $(STATIC) panelw ncursesw 2> /dev/null || \
+		     $(PKG_CONFIG) --cflags $(STATIC) panel ncurses 2> /dev/null)
 
 OBJS = tmon.o tui.o sysfs.o pid.o
 OBJS +=
-- 
2.7.4
