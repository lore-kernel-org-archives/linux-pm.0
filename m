From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH 5/6] regulator: max77843: Add max77843 regulator driver
Date: Fri, 23 Jan 2015 14:02:46 +0900
Message-ID: <1421989367-32721-6-git-send-email-jaewon02.kim@samsung.com>
References: <1421989367-32721-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:23252 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbbAWFDK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jan 2015 00:03:10 -0500
In-reply-to: <1421989367-32721-1-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Inki Dae <inki.dae@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Beomho Seo <beomho.seo@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>

This patch adds new regulator driver to support max77843
MFD(Multi Function Device) chip`s regulators.
The Max77843 has two voltage regulators for USB safeout.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/regulator/Kconfig    |    8 ++
 drivers/regulator/Makefile   |    1 +
 drivers/regulator/max77843.c |  259 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)
 create mode 100644 drivers/regulator/max77843.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index c3a60b5..c1f9c33 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -414,6 +414,14 @@ config REGULATOR_MAX77802
 	  Exynos5420/Exynos5800 SoCs to control various voltages.
 	  It includes support for control of voltage and ramp speed.
 
+config REGULATOR_MAX77843
+	tristate "Maxim 77843 regulator"
+	depends on MFD_MAX77843
+	help
+	  This driver controls a Maxim 77843 regulator.
+	  The regulator include two 'SAFEOUT' for USB(Universal Serial Bus)
+	  This is suitable for Exynos5433 SoC chips.
+
 config REGULATOR_MC13XXX_CORE
 	tristate
 
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 1f28ebf..12408d6 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_REGULATOR_MAX8998) += max8998.o
 obj-$(CONFIG_REGULATOR_MAX77686) += max77686.o
 obj-$(CONFIG_REGULATOR_MAX77693) += max77693.o
 obj-$(CONFIG_REGULATOR_MAX77802) += max77802.o
+obj-$(CONFIG_REGULATOR_MAX77843) += max77843.o
 obj-$(CONFIG_REGULATOR_MC13783) += mc13783-regulator.o
 obj-$(CONFIG_REGULATOR_MC13892) += mc13892-regulator.o
 obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=  mc13xxx-regulator-core.o
diff --git a/drivers/regulator/max77843.c b/drivers/regulator/max77843.c
new file mode 100644
index 0000000..86afc7a
--- /dev/null
+++ b/drivers/regulator/max77843.c
@@ -0,0 +1,259 @@
+/*
+ * max77843.c - Regulator driver for the Maxim MAX77843
+ *
+ * Copyright (C) 2014 Samsung Electrnoics
+ * Author: Jaewon Kim <jaewon02.kim@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/mfd/max77843-private.h>
+#include <linux/regulator/of_regulator.h>
+
+#define MAX77843_SUPPORTED_VOLTAGE_NUM	4
+
+enum max77843_regulator_type {
+	MAX77843_SAFEOUT1 = 0,
+	MAX77843_SAFEOUT2,
+	MAX77843_CHARGER,
+
+	MAX77843_NUM,
+};
+
+static const unsigned int max77843_regulator_table[] = {
+	4850000,
+	4900000,
+	4950000,
+	3300000,
+};
+
+static int max77843_reg_is_enabled(struct regulator_dev *rdev)
+{
+	struct regmap *regmap = rdev->regmap;
+	int ret;
+	unsigned int reg;
+
+	ret = regmap_read(regmap, rdev->desc->enable_reg, &reg);
+	if (ret) {
+		dev_err(&rdev->dev, "Fialed to read charger register\n");
+		return ret;
+	}
+
+	return (reg & rdev->desc->enable_mask) == rdev->desc->enable_mask;
+}
+
+static int max77843_reg_get_current_limit(struct regulator_dev *rdev)
+{
+	struct regmap *regmap = rdev->regmap;
+	unsigned int chg_min_uA = rdev->constraints->min_uA;
+	unsigned int chg_max_uA = rdev->constraints->max_uA;
+	unsigned int val;
+	int ret;
+	unsigned int reg, sel;
+
+	ret = regmap_read(regmap, MAX77843_CHG_REG_CHG_CNFG_02, &reg);
+	if (ret) {
+		dev_err(&rdev->dev, "Failed to read charger register\n");
+		return ret;
+	}
+
+	sel = reg & MAX77843_CHG_FAST_CHG_CURRENT_MASK;
+
+	if (sel < 0x03)
+		sel = 0;
+	else
+		sel -= 2;
+
+	val = chg_min_uA + MAX77843_CHG_FAST_CHG_CURRENT_STEP * sel;
+	if (val > chg_max_uA)
+		return -EINVAL;
+
+	return val;
+}
+
+static int max77843_reg_set_current_limit(struct regulator_dev *rdev,
+		int min_uA, int max_uA)
+{
+	struct regmap *regmap = rdev->regmap;
+	unsigned int chg_min_uA = rdev->constraints->min_uA;
+	int sel = 0;
+
+	while (chg_min_uA + MAX77843_CHG_FAST_CHG_CURRENT_STEP * sel < min_uA)
+		sel++;
+
+	if (chg_min_uA + MAX77843_CHG_FAST_CHG_CURRENT_STEP * sel > max_uA)
+		return -EINVAL;
+
+	sel += 2;
+
+	return regmap_write(regmap, MAX77843_CHG_REG_CHG_CNFG_02, sel);
+}
+
+static struct regulator_ops max77843_charger_ops = {
+	.is_enabled		= max77843_reg_is_enabled,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.get_current_limit	= max77843_reg_get_current_limit,
+	.set_current_limit	= max77843_reg_set_current_limit,
+};
+
+static struct regulator_ops max77843_regulator_ops = {
+	.is_enabled             = regulator_is_enabled_regmap,
+	.enable                 = regulator_enable_regmap,
+	.disable                = regulator_disable_regmap,
+	.list_voltage		= regulator_list_voltage_table,
+	.get_voltage_sel        = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel        = regulator_set_voltage_sel_regmap,
+};
+
+static const struct regulator_desc max77843_supported_regulators[] = {
+	[MAX77843_SAFEOUT1] = {
+		.name		= "SAFEOUT1",
+		.id		= MAX77843_SAFEOUT1,
+		.ops		= &max77843_regulator_ops,
+		.type		= REGULATOR_VOLTAGE,
+		.owner		= THIS_MODULE,
+		.n_voltages	= MAX77843_SUPPORTED_VOLTAGE_NUM,
+		.volt_table	= max77843_regulator_table,
+		.enable_reg	= MAX77843_SYS_REG_SAFEOUTCTRL,
+		.enable_mask	= MAX77843_REG_SAFEOUTCTRL_ENSAFEOUT1,
+		.vsel_reg	= MAX77843_SYS_REG_SAFEOUTCTRL,
+		.vsel_mask	= MAX77843_REG_SAFEOUTCTRL_SAFEOUT1_MASK,
+	},
+	[MAX77843_SAFEOUT2] = {
+		.name           = "SAFEOUT2",
+		.id             = MAX77843_SAFEOUT2,
+		.ops            = &max77843_regulator_ops,
+		.type           = REGULATOR_VOLTAGE,
+		.owner          = THIS_MODULE,
+		.n_voltages     = MAX77843_SUPPORTED_VOLTAGE_NUM,
+		.volt_table	= max77843_regulator_table,
+		.enable_reg     = MAX77843_SYS_REG_SAFEOUTCTRL,
+		.enable_mask    = MAX77843_REG_SAFEOUTCTRL_ENSAFEOUT2,
+		.vsel_reg	= MAX77843_SYS_REG_SAFEOUTCTRL,
+		.vsel_mask	= MAX77843_REG_SAFEOUTCTRL_SAFEOUT2_MASK,
+	},
+	[MAX77843_CHARGER] = {
+		.name		= "CHARGER",
+		.id		= MAX77843_CHARGER,
+		.ops		= &max77843_charger_ops,
+		.type		= REGULATOR_CURRENT,
+		.owner		= THIS_MODULE,
+		.enable_reg	= MAX77843_CHG_REG_CHG_CNFG_00,
+		.enable_mask	= MAX77843_CHG_MASK,
+	},
+};
+
+static struct of_regulator_match max77843_regulator_matches[] = {
+	{ .name = "SAFEOUT1", },
+	{ .name = "SAFEOUT2", },
+	{ .name = "CHARGER", },
+};
+
+static struct regmap *max77843_get_regmap(struct max77843 *max77843, int reg_id)
+{
+	switch (reg_id) {
+	case MAX77843_SAFEOUT1:
+	case MAX77843_SAFEOUT2:
+		return max77843->regmap;
+	case MAX77843_CHARGER:
+		return max77843->regmap_chg;
+	default:
+		return max77843->regmap;
+	}
+}
+
+static int max77843_regulator_dt_parse(struct platform_device *pdev)
+{
+	struct device_node *np;
+	int ret;
+
+	np = of_get_child_by_name(pdev->dev.parent->of_node, "regulators");
+	if (!np) {
+		dev_err(&pdev->dev,
+			"Cannot get child OF node for regulators\n");
+		return -EINVAL;
+	}
+
+	ret = of_regulator_match(&pdev->dev, np, max77843_regulator_matches,
+			ARRAY_SIZE(max77843_regulator_matches));
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Cannot parsing regulator init data\n");
+		return ret;
+	}
+
+	of_node_put(np);
+
+	return 0;
+}
+
+static int max77843_regulator_probe(struct platform_device *pdev)
+{
+	struct max77843 *max77843 = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_config config = {};
+	int i, ret;
+
+	ret = max77843_regulator_dt_parse(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to parse device tree\n");
+		return ret;
+	}
+
+	config.dev = &pdev->dev;
+	config.driver_data = max77843;
+
+	for (i = 0; i < ARRAY_SIZE(max77843_supported_regulators); i++) {
+		struct regulator_dev *regulator;
+
+		config.init_data = max77843_regulator_matches[i].init_data;
+		config.of_node = max77843_regulator_matches[i].of_node;
+		config.regmap = max77843_get_regmap(max77843,
+				max77843_supported_regulators[i].id);
+
+		regulator = devm_regulator_register(&pdev->dev,
+				&max77843_supported_regulators[i], &config);
+		if (IS_ERR(regulator)) {
+			dev_err(&pdev->dev,
+					"Failed to regiser regulator-%d\n", i);
+			return PTR_ERR(regulator);
+		}
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id max77843_regulator_id[] = {
+	{ "max77843-regulator", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver max77843_regulator_driver = {
+	.driver	= {
+		.name = "max77843-regulator",
+	},
+	.probe		= max77843_regulator_probe,
+	.id_table	= max77843_regulator_id,
+};
+
+static int __init max77843_regulator_init(void)
+{
+	return platform_driver_register(&max77843_regulator_driver);
+}
+subsys_initcall(max77843_regulator_init);
+
+static void __exit max77843_regulator_exit(void)
+{
+	platform_driver_unregister(&max77843_regulator_driver);
+}
+module_exit(max77843_regulator_exit);
+
+MODULE_AUTHOR("Jaewon Kim <jaewon02.kim@samsung.com>");
+MODULE_DESCRIPTION("Maxim MAX77843 regulator driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5

