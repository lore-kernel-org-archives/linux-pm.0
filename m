From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] tools/turbostat: allow user to alter DESTDIR and PREFIX
Date: Fri, 17 Jun 2016 15:59:33 +0300
Message-ID: <1466168373-101010-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59530 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753444AbcFQM7l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Jun 2016 08:59:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

When run
	make -C tools DESTDIR=/my/nice/dir turbostat_install
get a message
	install: cannot create regular file '/usr/bin/turbostat': Permission denied

Allow user to alter DESTDIR and PREFIX variables.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 tools/power/x86/turbostat/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index e367b1a..8561e7d 100644
--- a/tools/power/x86/turbostat/Makefile
+++ b/tools/power/x86/turbostat/Makefile
@@ -1,7 +1,7 @@
 CC		= $(CROSS_COMPILE)gcc
 BUILD_OUTPUT	:= $(CURDIR)
-PREFIX		:= /usr
-DESTDIR		:=
+PREFIX		?= /usr
+DESTDIR		?=
 
 ifeq ("$(origin O)", "command line")
 	BUILD_OUTPUT := $(O)
-- 
2.8.1

