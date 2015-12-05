From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] MAINTAINERS: Add an entry for the PM core
Date: Sat, 05 Dec 2015 01:54:47 +0100
Message-ID: <4533880.r6G3HUyhh9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a MAINTAINERS entry for the PM core with myself as the maintainer
and linux-pm as the mailing list.

This actually documents the current state of things.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

People seem to have problems with figuring out who maintains it, so ...

powercap has no separate maintainer at the time being, so I'm adding it
to the "PM core" bag for now for a good measure.

---
 MAINTAINERS |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -8438,6 +8438,17 @@ F:	fs/timerfd.c
 F:	include/linux/timer*
 F:	kernel/time/*timer*
 
+POWER MANAGEMENT CORE
+M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
+L:	linux-pm@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
+S:	Supported
+F:	drivers/base/power/
+F:	include/linux/pm.h
+F:	include/linux/pm_*
+F:	include/linux/powercap.h
+F:	drivers/powercap/
+
 POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
 M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
