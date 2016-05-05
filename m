From: Chris Brand <chris.brand@broadcom.com>
Subject: [PATCH 1/6] power: Introduce Broadcom kona reset driver
Date: Thu,  5 May 2016 13:48:49 -0700
Message-ID: <1462481334-8943-2-git-send-email-chris.brand@broadcom.com>
References: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:60903 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226AbcEEUrz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2016 16:47:55 -0400
In-Reply-To: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Russell King <linux@arm.linux.org.uk>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Raymond Ngun <raymond.ngun@broadcom.com>, Markus Mayer <markus.mayer@broadcom.com>

This driver supports reset on both BCM21664 and BCM23550.
Code is being moved from arch/arm/mach-bcm/board_bcm21664.c

Signed-off-by: Chris Brand <chris.brand@broadcom.com>
---
 drivers/power/reset/Kconfig           | 10 +++++
 drivers/power/reset/Makefile          |  1 +
 drivers/power/reset/brcm-kona-reset.c | 75 +++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 drivers/power/reset/brcm-kona-reset.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 0a6408a39c66..1a7c49f3650a 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -38,6 +38,16 @@ config POWER_RESET_AXXIA
 
 	  Say Y if you have an Axxia family SoC.
 
+config POWER_RESET_BRCMKONA
+	bool "Broadcom Kona reset driver"
+	depends on ARM || COMPILE_TEST
+	default ARCH_BCM_MOBILE
+	help
+	  This driver provides restart support for Broadcom Kona chips.
+
+	  Say Y here if you have a Broadcom Kona-based board and you wish
+	  to have restart support.
+
 config POWER_RESET_BRCMSTB
 	bool "Broadcom STB reset driver"
 	depends on ARM || MIPS || COMPILE_TEST
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 096fa67047f6..ddb9a5b35480 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_POWER_RESET_AS3722) += as3722-poweroff.o
 obj-$(CONFIG_POWER_RESET_AT91_POWEROFF) += at91-poweroff.o
 obj-$(CONFIG_POWER_RESET_AT91_RESET) += at91-reset.o
 obj-$(CONFIG_POWER_RESET_AXXIA) += axxia-reset.o
+obj-$(CONFIG_POWER_RESET_BRCMKONA) += brcm-kona-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMSTB) += brcmstb-reboot.o
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
diff --git a/drivers/power/reset/brcm-kona-reset.c b/drivers/power/reset/brcm-kona-reset.c
new file mode 100644
index 000000000000..d6f2070be89c
--- /dev/null
+++ b/drivers/power/reset/brcm-kona-reset.c
@@ -0,0 +1,75 @@
+/*
+ * Copyright (C) 2016 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/reboot.h>
+
+#include <asm/mach/arch.h>
+
+#define RSTMGR_REG_WR_ACCESS_OFFSET	0
+#define RSTMGR_REG_CHIP_SOFT_RST_OFFSET	4
+
+#define RSTMGR_WR_PASSWORD		0xa5a5
+#define RSTMGR_WR_PASSWORD_SHIFT	8
+#define RSTMGR_WR_ACCESS_ENABLE		1
+
+static void __iomem *kona_reset_base;
+
+static int kona_reset_handler(struct notifier_block *this,
+				unsigned long mode, void *cmd)
+{
+	/*
+	 * A soft reset is triggered by writing a 0 to bit 0 of the soft reset
+	 * register. To write to that register we must first write the password
+	 * and the enable bit in the write access enable register.
+	 */
+	writel((RSTMGR_WR_PASSWORD << RSTMGR_WR_PASSWORD_SHIFT) |
+		RSTMGR_WR_ACCESS_ENABLE,
+		kona_reset_base + RSTMGR_REG_WR_ACCESS_OFFSET);
+	writel(0, kona_reset_base + RSTMGR_REG_CHIP_SOFT_RST_OFFSET);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block kona_reset_nb = {
+	.notifier_call = kona_reset_handler,
+	.priority = 128,
+};
+
+static int kona_reset_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	kona_reset_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(kona_reset_base))
+		return PTR_ERR(kona_reset_base);
+
+	return register_restart_handler(&kona_reset_nb);
+}
+
+static const struct of_device_id of_match[] = {
+	{ .compatible = "brcm,bcm21664-resetmgr" },
+	{},
+};
+
+static struct platform_driver bcm_kona_reset_driver = {
+	.probe = kona_reset_probe,
+	.driver = {
+		.name = "brcm-kona-reset",
+		.of_match_table = of_match,
+	},
+};
+
+builtin_platform_driver(bcm_kona_reset_driver);
-- 
1.9.1

