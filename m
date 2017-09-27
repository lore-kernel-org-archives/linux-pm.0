From: Markus Mayer <code@mmayer.net>
Subject: [PATCH 1/3] tools/thermal: tmon: use "-fstack-protector" only if supported
Date: Wed, 27 Sep 2017 16:02:35 -0700
Message-ID: <20170927230237.62199-2-code@mmayer.net>
References: <20170927230237.62199-1-code@mmayer.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170927230237.62199-1-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Markus Mayer <mmayer@broadcom.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

Most, but not all, toolchains support the "-fstack-protector" flag. We
check if the compiler supports the flag before using it. This allows
tmon to be compiled for more environments.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 tools/thermal/tmon/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 3a961e9..5777bc7 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -1,8 +1,13 @@
+# We need this for the "cc-option" macro.
+include ../../../scripts/Kbuild.include
+
 VERSION = 1.0
 
 BINDIR=usr/bin
 WARNFLAGS=-Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplicit-int
-CFLAGS+= -O1 ${WARNFLAGS} -fstack-protector
+CFLAGS+= -O1 ${WARNFLAGS}
+# Add "-fstack-protector" only if toolchain supports it.
+CFLAGS+= $(call cc-option,-fstack-protector)
 CC=$(CROSS_COMPILE)gcc
 
 CFLAGS+=-D VERSION=\"$(VERSION)\"
-- 
2.7.4
