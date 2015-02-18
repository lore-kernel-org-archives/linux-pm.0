From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 6/8] tools/thermal: tmon: support cross-compiling
Date: Tue, 17 Feb 2015 18:18:34 -0800
Message-ID: <1424225916-13488-7-git-send-email-computersforpeace@gmail.com>
References: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, jacob.jun.pan@linux.intel.com
Cc: Neil Horman <nhorman@tuxdriver.com>, Brian Norris <computersforpeace@gmail.com>, Javi Merino <javi.merino@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We might want to prepare CFLAGS outside of this Makefile, so don't
overwrite its initial value.

Then, support $(CROSS_COMPILE), so we can use a cross-compile toolchain.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 tools/thermal/tmon/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index e775adcbd29f..13d1876c7889 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -2,8 +2,8 @@ VERSION = 1.0
 
 BINDIR=usr/bin
 WARNFLAGS=-Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplicit-int
-CFLAGS= -O1 ${WARNFLAGS} -fstack-protector
-CC=gcc
+CFLAGS+= -O1 ${WARNFLAGS} -fstack-protector
+CC=$(CROSS_COMPILE)gcc
 
 CFLAGS+=-D VERSION=\"$(VERSION)\"
 LDFLAGS+=
-- 
1.9.1
