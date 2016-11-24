From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] MAINTAINERS: Add bug tracking system location entry type
Date: Fri, 25 Nov 2016 00:13:56 +0100
Message-ID: <2170547.PZqCrC6KTi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56291 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966450AbcKXXGT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 18:06:19 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Laura Abbott <labbott@redhat.com>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Jon Corbet <corbet@lwn.net>, James Bottomley <jejb@kernel.org>, Theodore Tso <tytso@google.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Following the kernel Bugzilla discussion during the Kernel Summit
(https://lwn.net/Articles/705245/), add bug tracking system location
entry type (B) to MAINTAINERS and populate it for several subsystems
known to be using the kernel BZ actively (and add the upstream BZ for
ACPICA too).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -77,6 +77,7 @@ Descriptions of section entries:
 	Q: Patchwork web based patch tracking system site
 	T: SCM tree type and location.
 	   Type is one of: git, hg, quilt, stgit, topgit
+	B: Bug tracking system location.
 	S: Status, one of the following:
 	   Supported:	Someone is actually paid to look after this.
 	   Maintained:	Someone actually looks after it.
@@ -281,6 +282,7 @@ L:	linux-acpi@vger.kernel.org
 W:	https://01.org/linux-acpi
 Q:	https://patchwork.kernel.org/project/linux-acpi/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
+B:	https://bugzilla.kernel.org
 S:	Supported
 F:	drivers/acpi/
 F:	drivers/pnp/pnpacpi/
@@ -304,6 +306,8 @@ W:	https://acpica.org/
 W:	https://github.com/acpica/acpica/
 Q:	https://patchwork.kernel.org/project/linux-acpi/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
+B:	https://bugzilla.kernel.org
+B:	https://bugs.acpica.org
 S:	Supported
 F:	drivers/acpi/acpica/
 F:	include/acpi/
@@ -313,6 +317,7 @@ ACPI FAN DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
 W:	https://01.org/linux-acpi
+B:	https://bugzilla.kernel.org
 S:	Supported
 F:	drivers/acpi/fan.c
 
@@ -328,6 +333,7 @@ ACPI THERMAL DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
 W:	https://01.org/linux-acpi
+B:	https://bugzilla.kernel.org
 S:	Supported
 F:	drivers/acpi/*thermal*
 
@@ -335,6 +341,7 @@ ACPI VIDEO DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
 W:	https://01.org/linux-acpi
+B:	https://bugzilla.kernel.org
 S:	Supported
 F:	drivers/acpi/acpi_video.c
 
@@ -5671,6 +5678,7 @@ HIBERNATION (aka Software Suspend, aka s
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 M:	Pavel Machek <pavel@ucw.cz>
 L:	linux-pm@vger.kernel.org
+B:	https://bugzilla.kernel.org
 S:	Supported
 F:	arch/x86/power/
 F:	drivers/base/power/
@@ -9632,6 +9640,7 @@ POWER MANAGEMENT CORE
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
+B:	https://bugzilla.kernel.org
 S:	Supported
 F:	drivers/base/power/
 F:	include/linux/pm.h
@@ -11621,6 +11630,7 @@ M:	"Rafael J. Wysocki" <rjw@rjwysocki.ne
 M:	Len Brown <len.brown@intel.com>
 M:	Pavel Machek <pavel@ucw.cz>
 L:	linux-pm@vger.kernel.org
+B:	https://bugzilla.kernel.org
 S:	Supported
 F:	Documentation/power/
 F:	arch/x86/kernel/acpi/

