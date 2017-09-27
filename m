From: Markus Mayer <code@mmayer.net>
Subject: [PATCH 2/3] tools/thermal: tmon: allow $(CC) to be defined externally
Date: Wed, 27 Sep 2017 16:02:36 -0700
Message-ID: <20170927230237.62199-3-code@mmayer.net>
References: <20170927230237.62199-1-code@mmayer.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170927230237.62199-1-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Markus Mayer <mmayer@broadcom.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

It can be helpful, especially when using a build system, to set the C
compiler externally.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 tools/thermal/tmon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 5777bc7..581da71 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -8,7 +8,7 @@ WARNFLAGS=-Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplicit-
 CFLAGS+= -O1 ${WARNFLAGS}
 # Add "-fstack-protector" only if toolchain supports it.
 CFLAGS+= $(call cc-option,-fstack-protector)
-CC=$(CROSS_COMPILE)gcc
+CC?= $(CROSS_COMPILE)gcc
 
 CFLAGS+=-D VERSION=\"$(VERSION)\"
 LDFLAGS+=
-- 
2.7.4
