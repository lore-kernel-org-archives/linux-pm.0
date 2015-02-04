From: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 5/6] regulator: max77843: Add max77843 regulator driver
Date: Wed, 04 Feb 2015 13:56:10 +0900
Message-ID: <1423025771-4139-6-git-send-email-jaewon02.kim@samsung.com>
References: <1423025771-4139-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1423025771-4139-1-git-send-email-jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, SangBae Lee <sangbae90.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch adds new regulator driver to support max77843
MFD(Multi Function Device) chip`s regulators.
The Max77843 has two voltage regulators for USB safeout.

Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/regulator/Kconfig    |    8 ++
 drivers/regulator/Makefile   |    1 +
 drivers/regulator/max77843.c |  227 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 236 insertions(+)
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
index 0000000..779449f
--- /dev/null
+++ b/drivers/regulator/max77843.c
@@ -0,0 +1,227 @@
+/*
+ * max77843.c - Regulator driver for the Maxim MAX77843
+ *
+ * Copyright (C) 2015 Samsung Electronics
+ * Author: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
+ * Author: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
+enum max77843_regulator_type {
+	MAX77843_SAFEOUT1 = 0,
+	MAX77843_SAFEOUT2,
+	MAX77843_CHARGER,
+
+	MAX77843_NUM,
+};
+
+static const unsigned int max77843_safeout_voltage_table[] = {
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
+		.of_match	= of_match_ptr("SAFEOUT1"),
+		.regulators_node = of_match_ptr("regulators"),
+		.type		= REGULATOR_VOLTAGE,
+		.owner		= THIS_MODULE,
+		.n_voltages	= ARRAY_SIZE(max77843_safeout_voltage_table),
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
+		.of_match	= of_match_ptr("SAFEOUT2"),
+		.regulators_node = of_match_ptr("regulators"),
+		.type           = REGULATOR_VOLTAGE,
+		.owner          = THIS_MODULE,
+		.n_voltages	= ARRAY_SIZE(max77843_safeout_voltage_table),
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
+		.of_match	= of_match_ptr("CHARGER"),
+		.regulators_node = of_match_ptr("regulators"),
+		.type		= REGULATOR_CURRENT,
+		.owner		= THIS_MODULE,
+		.enable_reg	= MAX77843_CHG_REG_CHG_CNFG_00,
+		.enable_mask	= MAX77843_CHG_MASK,
+	},
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
+static int max77843_regulator_probe(struct platform_device *pdev)
+{
+	struct max77843 *max77843 = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_config config = {};
+	int i;
+
+	config.dev = max77843->dev;
+	config.driver_data = max77843;
+
+	for (i = 0; i < ARRAY_SIZE(max77843_supported_regulators); i++) {
+		struct regulator_dev *regulator;
+
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
+MODULE_AUTHOR("Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>");
+MODULE_AUTHOR("Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>");
+MODULE_DESCRIPTION("Maxim MAX77843 regulator driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
