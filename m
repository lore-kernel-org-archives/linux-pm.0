From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] MAINTAINERS: Reorder maintainer addresses for PM and ACPI
Date: Thu, 20 Mar 2014 00:00:14 +0100
Message-ID: <1744772.yf52reTAmC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@rjwysocki.net>

For a few subsystems I am the person who actually applies patches
and people don't CC me on patch submissions, because my address is
not the first one in the given MAINTAINERS item.

Reorder PM and ACPI maintainer addresses in MAINTAINERS to make
the probability of that a bit smaller.

Signed-off-by: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 MAINTAINERS |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -242,8 +242,8 @@ S:	Maintained
 F:	drivers/platform/x86/acer-wmi.c
 
 ACPI
-M:	Len Brown <lenb@kernel.org>
 M:	Rafael J. Wysocki <rjw@rjwysocki.net>
+M:	Len Brown <lenb@kernel.org>
 L:	linux-acpi@vger.kernel.org
 W:	https://01.org/linux-acpi
 Q:	https://patchwork.kernel.org/project/linux-acpi/list/
@@ -3657,8 +3657,8 @@ S:	Maintained
 F:	fs/freevxfs/
 
 FREEZER
+M:	Rafael J. Wysocki <rjw@rjwysocki.net>
 M:	Pavel Machek <pavel@ucw.cz>
-M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/power/freezing-of-tasks.txt
@@ -4022,8 +4022,8 @@ S:	Maintained
 F:	drivers/video/hgafb.c
 
 HIBERNATION (aka Software Suspend, aka swsusp)
+M:	Rafael J. Wysocki <rjw@rjwysocki.net>
 M:	Pavel Machek <pavel@ucw.cz>
-M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	arch/x86/power/
@@ -8425,9 +8425,9 @@ F:	arch/sh/
 F:	drivers/sh/
 
 SUSPEND TO RAM
+M:	Rafael J. Wysocki <rjw@rjwysocki.net>
 M:	Len Brown <len.brown@intel.com>
 M:	Pavel Machek <pavel@ucw.cz>
-M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/power/

