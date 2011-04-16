From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/9] OMAP2+ / PM: Move runtime PM implementation
	to use power domains
Date: Sun, 17 Apr 2011 01:39:56 +0200
Message-ID: <201104170139.56905.rjw__34633.3023896024$1302997577$gmane$org@sisk.pl>
References: <201104130205.26988.rjw@sisk.pl> <201104170135.19388.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104170135.19388.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-pm@vger.kernel.org

From: Kevin Hilman <khilman@ti.com>

In commit 7538e3db6e015e890825fbd9f8659952896ddd5b (PM: add support
for device power domains) a better way for handling platform-specific
power hooks was introduced.

Rather than using the platform_bus dev_pm_ops overrides
(platform_bus_set_pm_ops()), this patch moves the OMAP runtime PM
implementation over to using device power domains.

Since OMAP is the only user of platform_bus_set_pm_ops(), that
interface can be removed (and will be in a forthcoming patch.)

[rjw: Rebased on top of a previous change modifying the handling of
 power domains by the PM core so that power domain callbacks take
 precendence over subsystem-level PM callbacks.]

Signed-off-by: Kevin Hilman <khilman@ti.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-omap2/Makefile     |    6 +-
 arch/arm/mach-omap2/pm_bus.c     |   85 ---------------------------------------
 arch/arm/plat-omap/omap_device.c |   23 ++++++++++
 3 files changed, 26 insertions(+), 88 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/pm_bus.c

Index: linux-2.6/arch/arm/mach-omap2/Makefile
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/Makefile
+++ linux-2.6/arch/arm/mach-omap2/Makefile
@@ -59,10 +59,10 @@ endif
 # Power Management
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
-obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o
+obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o \
-					   cpuidle34xx.o pm_bus.o
-obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
+					   cpuidle34xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
 obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
Index: linux-2.6/arch/arm/mach-omap2/pm_bus.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/pm_bus.c
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- * Runtime PM support code for OMAP
- *
- * Author: Kevin Hilman, Deep Root Systems, LLC
- *
- * Copyright (C) 2010 Texas Instruments, Inc.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/pm_runtime.h>
-#include <linux/platform_device.h>
-#include <linux/mutex.h>
-
-#include <plat/omap_device.h>
-#include <plat/omap-pm.h>
-
-#ifdef CONFIG_PM_RUNTIME
-static int omap_pm_runtime_suspend(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	int r, ret = 0;
-
-	dev_dbg(dev, "%s\n", __func__);
-
-	ret = pm_generic_runtime_suspend(dev);
-
-	if (!ret && dev->parent == &omap_device_parent) {
-		r = omap_device_idle(pdev);
-		WARN_ON(r);
-	}
-
-	return ret;
-};
-
-static int omap_pm_runtime_resume(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	int r;
-
-	dev_dbg(dev, "%s\n", __func__);
-
-	if (dev->parent == &omap_device_parent) {
-		r = omap_device_enable(pdev);
-		WARN_ON(r);
-	}
-
-	return pm_generic_runtime_resume(dev);
-};
-#else
-#define omap_pm_runtime_suspend NULL
-#define omap_pm_runtime_resume NULL
-#endif /* CONFIG_PM_RUNTIME */
-
-static int __init omap_pm_runtime_init(void)
-{
-	const struct dev_pm_ops *pm;
-	struct dev_pm_ops *omap_pm;
-
-	pm = platform_bus_get_pm_ops();
-	if (!pm) {
-		pr_err("%s: unable to get dev_pm_ops from platform_bus\n",
-			__func__);
-		return -ENODEV;
-	}
-
-	omap_pm = kmemdup(pm, sizeof(struct dev_pm_ops), GFP_KERNEL);
-	if (!omap_pm) {
-		pr_err("%s: unable to alloc memory for new dev_pm_ops\n",
-			__func__);
-		return -ENOMEM;
-	}
-
-	omap_pm->runtime_suspend = omap_pm_runtime_suspend;
-	omap_pm->runtime_resume = omap_pm_runtime_resume;
-
-	platform_bus_set_pm_ops(omap_pm);
-
-	return 0;
-}
-core_initcall(omap_pm_runtime_init);
Index: linux-2.6/arch/arm/plat-omap/omap_device.c
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/omap_device.c
+++ linux-2.6/arch/arm/plat-omap/omap_device.c
@@ -536,6 +536,28 @@ int omap_early_device_register(struct om
 	return 0;
 }
 
+static int _od_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return omap_device_idle(pdev);
+}
+
+static int _od_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return omap_device_enable(pdev);
+}
+
+static struct dev_power_domain omap_device_power_domain = {
+	.ops = {
+		USE_PLATFORM_PM_SLEEP_OPS,
+		.runtime_suspend = _od_runtime_suspend,
+		.runtime_resume = _od_runtime_resume,
+	}
+};
+
 /**
  * omap_device_register - register an omap_device with one omap_hwmod
  * @od: struct omap_device * to register
@@ -549,6 +571,7 @@ int omap_device_register(struct omap_dev
 	pr_debug("omap_device: %s: registering\n", od->pdev.name);
 
 	od->pdev.dev.parent = &omap_device_parent;
+	od->pdev.dev.pwr_domain = &omap_device_power_domain;
 	return platform_device_register(&od->pdev);
 }
 
