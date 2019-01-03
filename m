From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpuidle / Documentation: Update cpuidle MAINTAINERS entry
Date: Thu, 03 Jan 2019 11:30:07 +0100
Message-ID: <11211688.O9o76ZdvQC@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Documentation <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Update the MAINTAINERS entry for cpuidle by making it clear that it
is not just drivers and adding a documentation record to it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -3945,13 +3945,14 @@ S:	Supported
 F:	drivers/cpuidle/cpuidle-exynos.c
 F:	arch/arm/mach-exynos/pm.c
 
-CPUIDLE DRIVERS
+CPU IDLE TIME MANAGEMENT FRAMEWORK
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 B:	https://bugzilla.kernel.org
+F:	Documentation/admin-guide/pm/cpuidle.rst
 F:	drivers/cpuidle/*
 F:	include/linux/cpuidle.h
 
