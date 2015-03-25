From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/3] power: reset: add Broadcom BCM63xx software reset driver
Date: Tue, 24 Mar 2015 17:17:11 -0700
Message-ID: <1427242632-7971-3-git-send-email-f.fainelli@gmail.com>
References: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, jogo@openwrt.org, cernekee@gmail.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-pm@vger.kernel.org

Add a sofware reset driver for the Broadcom BCM63xx DSL SoCs, starting
with 6328 all the way through newer chips such as 63138.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/power/reset/Kconfig          |  7 ++++
 drivers/power/reset/Makefile         |  1 +
 drivers/power/reset/bcm63xx-reboot.c | 80 ++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 drivers/power/reset/bcm63xx-reboot.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 27f6646731b0..c20c76870f42 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -38,6 +38,13 @@ config POWER_RESET_AXXIA
 
 	  Say Y if you have an Axxia family SoC.
 
+config POWER_RESET_BCM63XX
+	bool "Broadcom BCM63xx reset driver"
+	depends on ARM || MIPS || COMPILE_TEST
+	default ARCH_BCM_63XX
+	help
+	  This driver provides restart support for the Broadcom DSL SoCs.
+
 config POWER_RESET_BRCMSTB
 	bool "Broadcom STB reset driver"
 	depends on ARM || MIPS || COMPILE_TEST
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 11de15bae52e..7d28eaff4cd1 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_POWER_RESET_AS3722) += as3722-poweroff.o
 obj-$(CONFIG_POWER_RESET_AT91_POWEROFF) += at91-poweroff.o
 obj-$(CONFIG_POWER_RESET_AT91_RESET) += at91-reset.o
 obj-$(CONFIG_POWER_RESET_AXXIA) += axxia-reset.o
+obj-$(CONFIG_POWER_RESET_BCM63XX) += bcm63xx-reboot.o
 obj-$(CONFIG_POWER_RESET_BRCMSTB) += brcmstb-reboot.o
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
diff --git a/drivers/power/reset/bcm63xx-reboot.c b/drivers/power/reset/bcm63xx-reboot.c
new file mode 100644
index 000000000000..1e3a93c38784
--- /dev/null
+++ b/drivers/power/reset/bcm63xx-reboot.c
@@ -0,0 +1,80 @@
+/*
+ * Broadcom BCM63xx DSL SoCs reboot handler
+ *
+ * Copyright (C) 2015, Broadcom Corporation
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
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/of.h>
+
+static void __iomem *rst_base;
+
+#define SOFT_RESET	BIT(0)
+
+static int bcm63xx_restart_handler(struct notifier_block *this,
+				   unsigned long mdoe, void *cmd)
+{
+	u32 reg;
+
+	reg = __raw_readl(rst_base);
+	reg |= SOFT_RESET;
+	__raw_writel(reg, rst_base);
+
+	while (1)
+		;
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block bcm63xx_restart_nb = {
+	.notifier_call	= bcm63xx_restart_handler,
+	.priority = 128,
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id bcm63xx_reboot_of_match[] = {
+	{ .compatible = "brcm,bcm6328-soft-reset", },
+	{ /* sentinel */ },
+};
+#endif
+
+static int bcm63xx_reboot_probe(struct platform_device *pdev)
+{
+	struct resource *r;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rst_base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(rst_base)) {
+		dev_err(&pdev->dev, "failed to remap registers\n");
+		return PTR_ERR(rst_base);
+	}
+
+	return register_restart_handler(&bcm63xx_restart_nb);
+}
+
+static struct platform_driver bcm63xx_reboot_driver = {
+	.probe	= bcm63xx_reboot_probe,
+	.driver	= {
+		.name	= "bcm63xx-soft-reset",
+		.of_match_table	= of_match_ptr(bcm63xx_reboot_of_match),
+	},
+};
+
+static int __init bcm63xx_reboot_init(void)
+{
+	return platform_driver_probe(&bcm63xx_reboot_driver,
+				     bcm63xx_reboot_probe);
+}
+subsys_initcall(bcm63xx_reboot_init);
-- 
2.1.0
