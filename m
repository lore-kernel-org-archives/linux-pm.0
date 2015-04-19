From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/12] tools/power turbostat: Use $(CURDIR) instead of $(PWD) and add support for O= option in Makefile
Date: Sat, 18 Apr 2015 20:40:23 -0400
Message-ID: <f82263c6989c31ae9b94cecddffb29dcbec38710.1429402554.git.len.brown@intel.com>
References: <1429404027-23203-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:36661 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbbDSAkz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Apr 2015 20:40:55 -0400
Received: by qcpm10 with SMTP id m10so42168348qcp.3
        for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2015 17:40:55 -0700 (PDT)
In-Reply-To: <1429404027-23203-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
References: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Thomas D <whissi@whissi.de>, Mark Asselstine <mark.asselstine@windriver.com>, Len Brown <len.brown@intel.com>

From: Thomas D <whissi@whissi.de>

Since commit ee0778a30153
("tools/power: turbostat: make Makefile a bit more capable")
turbostat's Makefile is using

  [...]
  BUILD_OUTPUT    := $(PWD)
  [...]

which obviously causes trouble when building "turbostat" with

  make -C /usr/src/linux/tools/power/x86/turbostat ARCH=x86 turbostat

because GNU make does not update nor guarantee that $PWD is set.

This patch changes the Makefile to use $CURDIR instead, which GNU make
guarantees to set and update (i.e. when using "make -C ...") and also
adds support for the O= option (see "make help" in your root of your
kernel source tree for more details).

Link: https://bugs.gentoo.org/show_bug.cgi?id=533918
Fixes: ee0778a30153 ("tools/power: turbostat: make Makefile a bit more capable")
Signed-off-by: Thomas D. <whissi@whissi.de>
Cc: Mark Asselstine <mark.asselstine@windriver.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index d1b3a36..4039854 100644
--- a/tools/power/x86/turbostat/Makefile
+++ b/tools/power/x86/turbostat/Makefile
@@ -1,8 +1,12 @@
 CC		= $(CROSS_COMPILE)gcc
-BUILD_OUTPUT	:= $(PWD)
+BUILD_OUTPUT	:= $(CURDIR)
 PREFIX		:= /usr
 DESTDIR		:=
 
+ifeq ("$(origin O)", "command line")
+	BUILD_OUTPUT := $(O)
+endif
+
 turbostat : turbostat.c
 CFLAGS +=	-Wall
 CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/uapi/asm/msr-index.h"'
-- 
2.4.0.rc1

