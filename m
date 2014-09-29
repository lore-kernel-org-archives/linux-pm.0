From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] PM / Domains: add missing include to linux/pm.h
Date: Mon, 29 Sep 2014 14:18:53 +0200
Message-ID: <3760683.0Y3oBQm6U1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:56019 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbaI2MTc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Sep 2014 08:19:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

The newly added attach/detach API introduces a use of -ENODEV
in linux/pm.h, which can cause build errors:

In file included from arch/arm/mach-shmobile/cpuidle.c:11:0:
include/linux/pm.h: In function 'dev_pm_domain_attach':
include/linux/pm.h:631:10: error: 'ENODEV' undeclared (first use in this function)

This is easily solved by adding an include of linux/errno.h

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 46420dd73b80 ("PM / Domains: Add APIs to attach/detach a PM domain for a device")
---
This is from last thursday, please just ignore if someone else has
the same fix.

diff --git a/include/linux/pm.h b/include/linux/pm.h
index c4cbf485a5d6..56d1a7df4321 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -21,6 +21,7 @@
 #ifndef _LINUX_PM_H
 #define _LINUX_PM_H
 
+#include <linux/errno.h>
 #include <linux/list.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>

