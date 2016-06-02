From: James Morse <james.morse@arm.com>
Subject: [PATCH] PM / Hibernate: Don't let kasan instrument snapshot.c
Date: Thu,  2 Jun 2016 13:20:32 +0100
Message-ID: <1464870032-12289-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44493 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473AbcFBMWo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 Jun 2016 08:22:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, James Morse <james.morse@arm.com>

Kasan causes the compiler to instrument C code and is used at runtime to
detect accesses to memory that has been freed, or not yet allocated.

The code in snapshot.c saves and restores memory when hibernating. This will
access whole pages in the slab cache that have both free and allocated
areas, resulting in a large number of false positives from Kasan.

Disable instrumentation of this file.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>

---
With this, I can hibernate/resume a kernel built with kasan on arm64.

 kernel/power/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index cb880a14cc39..eb4f717705ba 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -1,6 +1,8 @@
 
 ccflags-$(CONFIG_PM_DEBUG)	:= -DDEBUG
 
+KASAN_SANITIZE_snapshot.o	:= n
+
 obj-y				+= qos.o
 obj-$(CONFIG_PM)		+= main.o
 obj-$(CONFIG_VT_CONSOLE_SLEEP)	+= console.o
-- 
2.8.0.rc3

