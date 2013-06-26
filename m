From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/8] ARM: davinci: move cpuidle driver to drivers/cpuidle/
Date: Wed, 26 Jun 2013 12:15:41 +0200
Message-ID: <1372241747-21083-3-git-send-email-b.zolnierkie@samsung.com>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:15399 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab3FZKQ2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 06:16:28 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MOZ00I4MWJC8BZ0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 26 Jun 2013 19:16:26 +0900 (KST)
In-reply-to: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, nsekhar@ti.com, khilman@deeprootsystems.com, kernel@pengutronix.de, shawn.guo@linaro.org, tony@atomide.com, ben-linux@fluff.org, kgene.kim@samsung.com, horms@verge.net.au, magnus.damm@gmail.com, swarren@wwwdotorg.org, srinidhi.kasagar@stericsson.com, linus.walleij@linaro.org, daniel.lezcano@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com, b.zolnierkie@samsung.com

Compile tested only.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-davinci/Makefile    |   1 -
 arch/arm/mach-davinci/cpuidle.c   | 105 --------------------------------------
 drivers/cpuidle/Makefile          |   3 ++
 drivers/cpuidle/cpuidle-davinci.c | 104 +++++++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+), 106 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/cpuidle.c
 create mode 100644 drivers/cpuidle/cpuidle-davinci.c

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 63997a1..76712e2 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -37,6 +37,5 @@ obj-$(CONFIG_MACH_MITYOMAPL138)		+= board-mityomapl138.o
 obj-$(CONFIG_MACH_OMAPL138_HAWKBOARD)	+= board-omapl138-hawk.o
 
 # Power Management
-obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_SUSPEND)			+= pm.o sleep.o
 obj-$(CONFIG_HAVE_CLK)			+= pm_domain.o
diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
deleted file mode 100644
index 36aef3a..0000000
--- a/arch/arm/mach-davinci/cpuidle.c
+++ /dev/null
@@ -1,105 +0,0 @@
-/*
- * CPU idle for DaVinci SoCs
- *
- * Copyright (C) 2009 Texas Instruments Incorporated. http://www.ti.com/
- *
- * Derived from Marvell Kirkwood CPU idle code
- * (arch/arm/mach-kirkwood/cpuidle.c)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/cpuidle.h>
-#include <linux/io.h>
-#include <linux/export.h>
-#include <asm/proc-fns.h>
-#include <asm/cpuidle.h>
-
-#include <mach/cpuidle.h>
-#include <mach/ddr2.h>
-
-#define DAVINCI_CPUIDLE_MAX_STATES	2
-
-static void __iomem *ddr2_reg_base;
-static bool ddr2_pdown;
-
-static void davinci_save_ddr_power(int enter, bool pdown)
-{
-	u32 val;
-
-	val = __raw_readl(ddr2_reg_base + DDR2_SDRCR_OFFSET);
-
-	if (enter) {
-		if (pdown)
-			val |= DDR2_SRPD_BIT;
-		else
-			val &= ~DDR2_SRPD_BIT;
-		val |= DDR2_LPMODEN_BIT;
-	} else {
-		val &= ~(DDR2_SRPD_BIT | DDR2_LPMODEN_BIT);
-	}
-
-	__raw_writel(val, ddr2_reg_base + DDR2_SDRCR_OFFSET);
-}
-
-/* Actual code that puts the SoC in different idle states */
-static int davinci_enter_idle(struct cpuidle_device *dev,
-			      struct cpuidle_driver *drv, int index)
-{
-	davinci_save_ddr_power(1, ddr2_pdown);
-	cpu_do_idle();
-	davinci_save_ddr_power(0, ddr2_pdown);
-
-	return index;
-}
-
-static struct cpuidle_driver davinci_idle_driver = {
-	.name			= "cpuidle-davinci",
-	.owner			= THIS_MODULE,
-	.states[0]		= ARM_CPUIDLE_WFI_STATE,
-	.states[1]		= {
-		.enter			= davinci_enter_idle,
-		.exit_latency		= 10,
-		.target_residency	= 100000,
-		.flags			= CPUIDLE_FLAG_TIME_VALID,
-		.name			= "DDR SR",
-		.desc			= "WFI and DDR Self Refresh",
-	},
-	.state_count = DAVINCI_CPUIDLE_MAX_STATES,
-};
-
-static int __init davinci_cpuidle_probe(struct platform_device *pdev)
-{
-	struct davinci_cpuidle_config *pdata = pdev->dev.platform_data;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "cannot get platform data\n");
-		return -ENOENT;
-	}
-
-	ddr2_reg_base = pdata->ddr2_ctlr_base;
-
-	ddr2_pdown = pdata->ddr2_pdown;
-
-	return cpuidle_register(&davinci_idle_driver, NULL);
-}
-
-static struct platform_driver davinci_cpuidle_driver = {
-	.driver = {
-		.name	= "cpuidle-davinci",
-		.owner	= THIS_MODULE,
-	},
-};
-
-static int __init davinci_cpuidle_init(void)
-{
-	return platform_driver_probe(&davinci_cpuidle_driver,
-						davinci_cpuidle_probe);
-}
-device_initcall(davinci_cpuidle_init);
-
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 9dd4091..3bbb828 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -9,5 +9,8 @@ ifeq ($(CONFIG_ARCH_AT91),y)
 	obj-y += cpuidle-at91.o
 endif
 obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
+ifeq ($(CONFIG_ARCH_DAVINCI),y)
+	obj-y += cpuidle-davinci.o
+endif
 obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
 obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
diff --git a/drivers/cpuidle/cpuidle-davinci.c b/drivers/cpuidle/cpuidle-davinci.c
new file mode 100644
index 0000000..b5a6476
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-davinci.c
@@ -0,0 +1,104 @@
+/*
+ * CPU idle for DaVinci SoCs
+ *
+ * Copyright (C) 2009 Texas Instruments Incorporated. http://www.ti.com/
+ *
+ * Derived from Marvell Kirkwood CPU idle code
+ * (arch/arm/mach-kirkwood/cpuidle.c)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/cpuidle.h>
+#include <linux/io.h>
+#include <linux/export.h>
+#include <asm/proc-fns.h>
+#include <asm/cpuidle.h>
+
+#include <mach/cpuidle.h>
+#include <mach/ddr2.h>
+
+#define DAVINCI_CPUIDLE_MAX_STATES	2
+
+static void __iomem *ddr2_reg_base;
+static bool ddr2_pdown;
+
+static void davinci_save_ddr_power(int enter, bool pdown)
+{
+	u32 val;
+
+	val = __raw_readl(ddr2_reg_base + DDR2_SDRCR_OFFSET);
+
+	if (enter) {
+		if (pdown)
+			val |= DDR2_SRPD_BIT;
+		else
+			val &= ~DDR2_SRPD_BIT;
+		val |= DDR2_LPMODEN_BIT;
+	} else {
+		val &= ~(DDR2_SRPD_BIT | DDR2_LPMODEN_BIT);
+	}
+
+	__raw_writel(val, ddr2_reg_base + DDR2_SDRCR_OFFSET);
+}
+
+/* Actual code that puts the SoC in different idle states */
+static int davinci_enter_idle(struct cpuidle_device *dev,
+			      struct cpuidle_driver *drv, int index)
+{
+	davinci_save_ddr_power(1, ddr2_pdown);
+	cpu_do_idle();
+	davinci_save_ddr_power(0, ddr2_pdown);
+
+	return index;
+}
+
+static struct cpuidle_driver davinci_idle_driver = {
+	.name			= "cpuidle-davinci",
+	.owner			= THIS_MODULE,
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.states[1]		= {
+		.enter			= davinci_enter_idle,
+		.exit_latency		= 10,
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "DDR SR",
+		.desc			= "WFI and DDR Self Refresh",
+	},
+	.state_count = DAVINCI_CPUIDLE_MAX_STATES,
+};
+
+static int __init davinci_cpuidle_probe(struct platform_device *pdev)
+{
+	struct davinci_cpuidle_config *pdata = pdev->dev.platform_data;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "cannot get platform data\n");
+		return -ENOENT;
+	}
+
+	ddr2_reg_base = pdata->ddr2_ctlr_base;
+
+	ddr2_pdown = pdata->ddr2_pdown;
+
+	return cpuidle_register(&davinci_idle_driver, NULL);
+}
+
+static struct platform_driver davinci_cpuidle_driver = {
+	.driver = {
+		.name	= "cpuidle-davinci",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init davinci_cpuidle_init(void)
+{
+	return platform_driver_probe(&davinci_cpuidle_driver,
+						davinci_cpuidle_probe);
+}
+device_initcall(davinci_cpuidle_init);
-- 
1.8.2.3

