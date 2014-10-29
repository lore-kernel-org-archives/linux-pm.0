From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/2] power: reset: add driver for Hardkernel's Odroid boards
Date: Wed, 29 Oct 2014 14:13:28 +0100
Message-ID: <1414588409-8065-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:24174 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932746AbaJ2NNx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Oct 2014 09:13:53 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Tobias Jakobi <Liquid.Acid@gmx.net>, Daniel Drake <drake@endlessm.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Sebastian Reichel <sre@kernel.org>

This patch adds a driver implementing correct reboot and poweroff
procedures for Exynos4412-based Hardkernel's Odroid X/X2/U2/U3/U3+
boards.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../bindings/power/reset/odroid-reset.txt          |  18 ++++
 drivers/power/reset/Kconfig                        |   6 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/odroid-reboot.c                | 119 +++++++++++++++++++++
 4 files changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/odroid-reset.txt
 create mode 100644 drivers/power/reset/odroid-reboot.c

diff --git a/Documentation/devicetree/bindings/power/reset/odroid-reset.txt b/Documentation/devicetree/bindings/power/reset/odroid-reset.txt
new file mode 100644
index 000000000000..86471a463518
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/odroid-reset.txt
@@ -0,0 +1,18 @@
+* Device tree bindings for Hardkernel's Exynos4412 based Odroid boards
+
+This node is intended to allow proper system reboot and power off of
+Odroid X/X2/U2/U3/U3+ boards with eMMC storage. Without this node, board
+hangs during standard reset procedure.
+
+Required properties:
+- compatible:			hardkernel,odroid-reboot
+- samsung,pmureg-phandle:	phandle to Exynos PMU node
+- reset-gpios:			phandle and gpio-specifier to the GPIO pin
+				connected to the eMMC_nDET
+
+Example:
+odroid_reboot {
+	compatible = "hardkernel,odroid-reboot";
+	samsung,pmureg-phandle = <&pmu_system_controller>;
+	reset-gpio = <&gpk1 2 0>;
+};
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index f65ff49bb275..f02b13d5344f 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -84,6 +84,12 @@ config POWER_RESET_LTC2952
 	  This driver supports an external powerdown trigger and board power
 	  down via the LTC2952. Bindings are made in the device tree.
 
+config POWER_RESET_ODROID
+	bool "Hardkernel's Exynos4412 based Odroid reboot driver"
+	depends on POWER_RESET && ARCH_EXYNOS
+	help
+	  Power off and restart support for Odroid boards.
+
 config POWER_RESET_QNAP
 	bool "QNAP power-off driver"
 	depends on OF_GPIO && PLAT_ORION
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 76ce1c59469b..178ee86eb813 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
 obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
+obj-$(CONFIG_POWER_RESET_ODROID) += odroid-reboot.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
 obj-$(CONFIG_POWER_RESET_SUN6I) += sun6i-reboot.o
diff --git a/drivers/power/reset/odroid-reboot.c b/drivers/power/reset/odroid-reboot.c
new file mode 100644
index 000000000000..823e93539220
--- /dev/null
+++ b/drivers/power/reset/odroid-reboot.c
@@ -0,0 +1,119 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+
+#include <asm/system_misc.h>
+
+#define PS_HOLD_CONTROL	0x330C
+
+struct odroid_reboot_data {
+	struct device *dev;
+	int power_gpio;
+	struct regmap *reg_pmu;
+	void (*reboot_func)(enum reboot_mode mode, const char *cmd);
+};
+
+static struct odroid_reboot_data *reboot_data;
+
+static void odroid_reboot(enum reboot_mode mode, const char *cmd)
+{
+	local_irq_disable();
+
+	gpio_set_value(reboot_data->power_gpio, 0);
+	mdelay(150);
+	gpio_set_value(reboot_data->power_gpio, 1);
+
+	reboot_data->reboot_func(mode, cmd);
+
+	pr_emerg("%s: waiting for reboot\n", __func__);
+	while (1)
+		;
+}
+
+static void odroid_power_off(void)
+{
+	regmap_update_bits(reboot_data->reg_pmu, PS_HOLD_CONTROL, 0xffffffff, 0x5200);
+	while (1) {
+		pr_emerg("%s: should not reach here!\n", __func__);
+		msleep(1000);
+	}
+}
+
+static struct odroid_reboot_data *odroid_reboot_parse_dt(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct odroid_reboot_data *data;
+
+	data = devm_kzalloc(dev, sizeof(struct odroid_reboot_data), GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	data->power_gpio = of_get_named_gpio(np, "reset-gpios", 0);
+	if (!gpio_is_valid(data->power_gpio)) {
+		dev_err(dev, "invalid reset gpio pin\n");
+		return NULL;
+	}
+	devm_gpio_request(dev, data->power_gpio, "reset");
+
+	data->reg_pmu = syscon_regmap_lookup_by_phandle(np,
+						"samsung,pmureg-phandle");
+	if (IS_ERR(data->reg_pmu)) {
+		dev_err(dev, "failed to map PMU registers\n");
+		return NULL;
+	}
+
+	return data;
+}
+
+static int odroid_reboot_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	if (pdev->dev.of_node)
+		reboot_data = odroid_reboot_parse_dt(dev);
+
+	if (!reboot_data)
+		return -EINVAL;
+
+	reboot_data->dev = &pdev->dev;
+	reboot_data->reboot_func = arm_pm_restart;
+
+	/* grab reboot arm specific hook */
+	arm_pm_restart = odroid_reboot;
+
+	/* register power off function */
+	pm_power_off = odroid_power_off;
+
+	return 0;
+}
+
+static struct of_device_id odroid_reboot_of_match[] = {
+	{ .compatible = "hardkernel,odroid-reboot", },
+	{ },
+};
+
+static struct platform_driver odroid_reboot_driver = {
+	.probe		= odroid_reboot_probe,
+	.driver		= {
+		.name	= "odroid-reboot",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(odroid_reboot_of_match),
+	}
+};
+module_platform_driver(odroid_reboot_driver);
-- 
1.9.2

