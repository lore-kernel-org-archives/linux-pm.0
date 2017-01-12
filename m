From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] power: reset: Add MAX77620 support
Date: Thu, 12 Jan 2017 17:15:07 +0100
Message-ID: <20170112161507.23774-1-thierry.reding@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33248 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdALQPL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2017 11:15:11 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chaitanya Bandi <bandik@nvidia.com>

From: Thierry Reding <treding@nvidia.com>

The Maxim MAX77620 PMIC has the ability to power off and restart the
system. Add a driver that supports power off (via pm_power_off()) and
restart (via arm_pm_restart() on 32-bit and 64-bit ARM).

Based on work by Chaitanya Bandi <bandik@nvidia.com>.

Cc: Chaitanya Bandi <bandik@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/power/reset/Kconfig             |   6 ++
 drivers/power/reset/Makefile            |   1 +
 drivers/power/reset/max77620-poweroff.c | 146 ++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 drivers/power/reset/max77620-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index abeb77217a21..f0d0c20632f8 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -98,6 +98,12 @@ config POWER_RESET_IMX
 	  say N here or disable in dts to make sure pm_power_off never be
 	  overwrote wrongly by this driver.
 
+config POWER_RESET_MAX77620
+	bool "Maxim MAX77620 PMIC power-off driver"
+	depends on MFD_MAX77620
+	help
+	  Power off and restart support for Maxim MAX77620 PMICs.
+
 config POWER_RESET_MSM
 	bool "Qualcomm MSM power-off driver"
 	depends on ARCH_QCOM
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 11dae3b56ff9..74511d2f037a 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
 obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
 obj-$(CONFIG_POWER_RESET_IMX) += imx-snvs-poweroff.o
+obj-$(CONFIG_POWER_RESET_MAX77620) += max77620-poweroff.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
 obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
diff --git a/drivers/power/reset/max77620-poweroff.c b/drivers/power/reset/max77620-poweroff.c
new file mode 100644
index 000000000000..4f2682d10925
--- /dev/null
+++ b/drivers/power/reset/max77620-poweroff.c
@@ -0,0 +1,146 @@
+/*
+ * Power off driver for Maxim MAX77620 device.
+ *
+ * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Based on work by Chaitanya Bandi <bandik@nvidia.com>.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
+ * whether express or implied; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/errno.h>
+#include <linux/mfd/max77620.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+#include <asm/system_misc.h>
+#endif
+
+struct max77620_power {
+	struct regmap *regmap;
+	struct device *dev;
+};
+
+static struct max77620_power *system_power_controller = NULL;
+
+static void max77620_pm_power_off(void)
+{
+	struct max77620_power *power = system_power_controller;
+	unsigned int value;
+	int err;
+
+	if (!power)
+		return;
+
+	/* clear power key interrupts */
+	err = regmap_read(power->regmap, MAX77620_REG_ONOFFIRQ, &value);
+	if (err < 0)
+		dev_err(power->dev, "failed to clear power key interrupts: %d\n", err);
+
+	/* clear RTC interrupts */
+	/*
+	err = regmap_read(power->regmap, MAX77620_REG_RTCINT, &value);
+	if (err < 0)
+		dev_err(power->dev, "failed to clear RTC interrupts: %d\n", err);
+	*/
+
+	/* clear TOP interrupts */
+	err = regmap_read(power->regmap, MAX77620_REG_IRQTOP, &value);
+	if (err < 0)
+		dev_err(power->dev, "failed to clear interrupts: %d\n", err);
+
+	err = regmap_update_bits(power->regmap, MAX77620_REG_ONOFFCNFG2,
+				 MAX77620_ONOFFCNFG2_SFT_RST_WK, 0);
+	if (err < 0)
+		dev_err(power->dev, "failed to clear SFT_RST_WK: %d\n", err);
+
+	err = regmap_update_bits(power->regmap, MAX77620_REG_ONOFFCNFG1,
+				 MAX77620_ONOFFCNFG1_SFT_RST,
+				 MAX77620_ONOFFCNFG1_SFT_RST);
+	if (err < 0)
+		dev_err(power->dev, "failed to set SFT_RST: %d\n", err);
+}
+
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+static void max77620_pm_restart(enum reboot_mode mode, const char *cmd)
+{
+	struct max77620_power *power = system_power_controller;
+	int err;
+
+	if (!power)
+		return;
+
+	err = regmap_update_bits(power->regmap, MAX77620_REG_ONOFFCNFG2,
+				 MAX77620_ONOFFCNFG2_SFT_RST_WK,
+				 MAX77620_ONOFFCNFG2_SFT_RST_WK);
+	if (err < 0)
+		dev_err(power->dev, "failed to set SFT_RST_WK: %d\n", err);
+
+	err = regmap_update_bits(power->regmap, MAX77620_REG_ONOFFCNFG1,
+				 MAX77620_ONOFFCNFG1_SFT_RST,
+				 MAX77620_ONOFFCNFG1_SFT_RST);
+	if (err < 0)
+		dev_err(power->dev, "failed to set SFT_RST: %d\n", err);
+}
+#endif
+
+static int max77620_poweroff_probe(struct platform_device *pdev)
+{
+	struct max77620_chip *max77620 = dev_get_drvdata(pdev->dev.parent);
+	struct device_node *np = pdev->dev.parent->of_node;
+	struct max77620_power *power;
+	unsigned int value;
+	int err;
+
+	if (!of_property_read_bool(np, "system-power-controller"))
+		return 0;
+
+	power = devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
+	if (!power)
+		return -ENOMEM;
+
+	power->regmap = max77620->rmap;
+	power->dev = &pdev->dev;
+
+	err = regmap_read(power->regmap, MAX77620_REG_NVERC, &value);
+	if (err < 0) {
+		dev_err(power->dev, "failed to read event recorder: %d\n", err);
+		return err;
+	}
+
+	dev_dbg(&pdev->dev, "event recorder: %#x\n", value);
+
+	system_power_controller = power;
+	pm_power_off = max77620_pm_power_off;
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+	arm_pm_restart = max77620_pm_restart;
+#endif
+
+	return 0;
+}
+
+static struct platform_driver max77620_poweroff_driver = {
+	.driver = {
+		.name = "max77620-power",
+	},
+	.probe = max77620_poweroff_probe,
+};
+module_platform_driver(max77620_poweroff_driver);
+
+MODULE_DESCRIPTION("Maxim MAX77620 PMIC power off and restart driver");
+MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
+MODULE_ALIAS("platform:max77620-power");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

