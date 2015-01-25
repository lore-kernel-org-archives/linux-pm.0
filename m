From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/6] power/reset: Remove sun6i reboot driver
Date: Sun, 25 Jan 2015 12:30:42 -0800
Message-ID: <1422217845-18901-4-git-send-email-linux@roeck-us.net>
References: <1422217845-18901-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45878 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbbAYUbE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jan 2015 15:31:04 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YFTpn-000kHd-SX
	for linux-pm@vger.kernel.org; Sun, 25 Jan 2015 20:31:04 +0000
In-Reply-To: <1422217845-18901-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, David Woodhouse <dwmw2@infradead.org>, devicetree@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Grant Likely <grant.likely@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Rob Herring <robh+dt@kernel.org>

sun6i restart is now handled by its watchdog driver directly,
so this driver is no longer needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/power/reset/Kconfig        |  6 ---
 drivers/power/reset/Makefile       |  1 -
 drivers/power/reset/sun6i-reboot.c | 85 --------------------------------------
 3 files changed, 92 deletions(-)
 delete mode 100644 drivers/power/reset/sun6i-reboot.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index bf5acb3..4cb5744 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -109,12 +109,6 @@ config POWER_RESET_RESTART
 	  Instead they restart, and u-boot holds the SoC until the
 	  user presses a key. u-boot then boots into Linux.
 
-config POWER_RESET_SUN6I
-	bool "Allwinner A31 SoC reset driver"
-	depends on ARCH_SUNXI
-	help
-	  Reboot support for the Allwinner A31 SoCs.
-
 config POWER_RESET_ST
 	bool "ST restart power-off driver"
 	depends on ARCH_STI
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 1631652..11de15b 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
-obj-$(CONFIG_POWER_RESET_SUN6I) += sun6i-reboot.o
 obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
 obj-$(CONFIG_POWER_RESET_VERSATILE) += arm-versatile-reboot.o
 obj-$(CONFIG_POWER_RESET_VEXPRESS) += vexpress-poweroff.o
diff --git a/drivers/power/reset/sun6i-reboot.c b/drivers/power/reset/sun6i-reboot.c
deleted file mode 100644
index af2cd7f..0000000
--- a/drivers/power/reset/sun6i-reboot.c
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- * Allwinner A31 SoCs reset code
- *
- * Copyright (C) 2012-2014 Maxime Ripard
- *
- * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/platform_device.h>
-#include <linux/reboot.h>
-
-#include <asm/system_misc.h>
-
-#define SUN6I_WATCHDOG1_IRQ_REG		0x00
-#define SUN6I_WATCHDOG1_CTRL_REG	0x10
-#define SUN6I_WATCHDOG1_CTRL_RESTART		BIT(0)
-#define SUN6I_WATCHDOG1_CONFIG_REG	0x14
-#define SUN6I_WATCHDOG1_CONFIG_RESTART		BIT(0)
-#define SUN6I_WATCHDOG1_CONFIG_IRQ		BIT(1)
-#define SUN6I_WATCHDOG1_MODE_REG	0x18
-#define SUN6I_WATCHDOG1_MODE_ENABLE		BIT(0)
-
-static void __iomem *wdt_base;
-
-static void sun6i_wdt_restart(enum reboot_mode mode, const char *cmd)
-{
-	if (!wdt_base)
-		return;
-
-	/* Disable interrupts */
-	writel(0, wdt_base + SUN6I_WATCHDOG1_IRQ_REG);
-
-	/* We want to disable the IRQ and just reset the whole system */
-	writel(SUN6I_WATCHDOG1_CONFIG_RESTART,
-		wdt_base + SUN6I_WATCHDOG1_CONFIG_REG);
-
-	/* Enable timer. The default and lowest interval value is 0.5s */
-	writel(SUN6I_WATCHDOG1_MODE_ENABLE,
-		wdt_base + SUN6I_WATCHDOG1_MODE_REG);
-
-	/* Restart the watchdog. */
-	writel(SUN6I_WATCHDOG1_CTRL_RESTART,
-		wdt_base + SUN6I_WATCHDOG1_CTRL_REG);
-
-	while (1) {
-		mdelay(5);
-		writel(SUN6I_WATCHDOG1_MODE_ENABLE,
-			wdt_base + SUN6I_WATCHDOG1_MODE_REG);
-	}
-}
-
-static int sun6i_reboot_probe(struct platform_device *pdev)
-{
-	wdt_base = of_iomap(pdev->dev.of_node, 0);
-	if (!wdt_base) {
-		WARN(1, "failed to map watchdog base address");
-		return -ENODEV;
-	}
-
-	arm_pm_restart = sun6i_wdt_restart;
-
-	return 0;
-}
-
-static struct of_device_id sun6i_reboot_of_match[] = {
-	{ .compatible = "allwinner,sun6i-a31-wdt" },
-	{}
-};
-
-static struct platform_driver sun6i_reboot_driver = {
-	.probe = sun6i_reboot_probe,
-	.driver = {
-		.name = "sun6i-reboot",
-		.of_match_table = sun6i_reboot_of_match,
-	},
-};
-module_platform_driver(sun6i_reboot_driver);
-- 
2.1.0

