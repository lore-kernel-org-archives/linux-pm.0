From: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 2/5] regulator: rt5033: Add RT5033 Regulator device driver
Date: Wed, 12 Nov 2014 21:07:59 +0900
Message-ID: <1415794082-30277-3-git-send-email-beomho.seo@samsung.com>
References: <1415794082-30277-1-git-send-email-beomho.seo@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1415794082-30277-1-git-send-email-beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, geunsik.lim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch add device driver of Richtek RT5033 PMIC.
The driver support multiple regulator like LDO and synchronous Buck.
The integrated synchronous buck converter is designed to provide 0.6 A
application with high efficiency. Two LDOs are integrated. One safe LDO is
for 60mA and the other one LDO is for 150 mA.

Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
Changes in v3:
- Add author information the top of driver.

Changes in v2:
- Remove unnecessary device specific code.
---
 drivers/regulator/Kconfig            |    8 +++
 drivers/regulator/Makefile           |    1 +
 drivers/regulator/rt5033-regulator.c |  123 ++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 drivers/regulator/rt5033-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 55d7b7b..8558e1b 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -521,6 +521,14 @@ config REGULATOR_RN5T618
 	help
 	  Say y here to support the regulators found on Ricoh RN5T618 PMIC.
 
+config REGULATOR_RT5033
+	tristate "Richtek RT5033 Regulators"
+	depends on MFD_RT5033
+	help
+	  This adds support for voltage and current regulators in Richtek
+	  RT5033 PMIC. The device supports multiple regulators like
+	  current source, LDO and Buck.
+
 config REGULATOR_S2MPA01
 	tristate "Samsung S2MPA01 voltage regulator"
 	depends on MFD_SEC_CORE
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 1029ed3..1f28ebf 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_REGULATOR_PCF50633) += pcf50633-regulator.o
 obj-$(CONFIG_REGULATOR_RC5T583)  += rc5t583-regulator.o
 obj-$(CONFIG_REGULATOR_RK808)   += rk808-regulator.o
 obj-$(CONFIG_REGULATOR_RN5T618) += rn5t618-regulator.o
+obj-$(CONFIG_REGULATOR_RT5033)	+= rt5033-regulator.o
 obj-$(CONFIG_REGULATOR_S2MPA01) += s2mpa01.o
 obj-$(CONFIG_REGULATOR_S2MPS11) += s2mps11.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
diff --git a/drivers/regulator/rt5033-regulator.c b/drivers/regulator/rt5033-regulator.c
new file mode 100644
index 0000000..870cc49
--- /dev/null
+++ b/drivers/regulator/rt5033-regulator.c
@@ -0,0 +1,123 @@
+/*
+ * Regulator driver for the Richtek RT5033
+ *
+ * Copyright (C) 2014 Samsung Electronics, Co., Ltd.
+ * Author: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published bythe Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/mfd/rt5033.h>
+#include <linux/mfd/rt5033-private.h>
+#include <linux/regulator/of_regulator.h>
+
+static struct regulator_ops rt5033_safe_ldo_ops = {
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.list_voltage		= regulator_list_voltage_linear,
+};
+
+static struct regulator_ops rt5033_buck_ops = {
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+};
+
+static const struct regulator_desc rt5033_supported_regulators[] = {
+	[RT5033_BUCK] = {
+		.name		= "BUCK",
+		.id		= RT5033_BUCK,
+		.ops		= &rt5033_buck_ops,
+		.type		= REGULATOR_VOLTAGE,
+		.owner		= THIS_MODULE,
+		.n_voltages	= RT5033_REGULATOR_BUCK_VOLTAGE_STEP_NUM,
+		.min_uV		= RT5033_REGULATOR_BUCK_VOLTAGE_MIN,
+		.uV_step	= RT5033_REGULATOR_BUCK_VOLTAGE_STEP,
+		.enable_reg	= RT5033_REG_CTRL,
+		.enable_mask	= RT5033_CTRL_EN_BUCK_MASK,
+		.vsel_reg	= RT5033_REG_BUCK_CTRL,
+		.vsel_mask	= RT5033_BUCK_CTRL_MASK,
+	},
+	[RT5033_LDO] = {
+		.name		= "LDO",
+		.id		= RT5033_LDO,
+		.ops		= &rt5033_buck_ops,
+		.type		= REGULATOR_VOLTAGE,
+		.owner		= THIS_MODULE,
+		.n_voltages	= RT5033_REGULATOR_LDO_VOLTAGE_STEP_NUM,
+		.min_uV		= RT5033_REGULATOR_LDO_VOLTAGE_MIN,
+		.uV_step	= RT5033_REGULATOR_LDO_VOLTAGE_STEP,
+		.enable_reg	= RT5033_REG_CTRL,
+		.enable_mask	= RT5033_CTRL_EN_LDO_MASK,
+		.vsel_reg	= RT5033_REG_LDO_CTRL,
+		.vsel_mask	= RT5033_LDO_CTRL_MASK,
+	},
+	[RT5033_SAFE_LDO] = {
+		.name		= "SAFE_LDO",
+		.id		= RT5033_SAFE_LDO,
+		.ops		= &rt5033_safe_ldo_ops,
+		.type		= REGULATOR_VOLTAGE,
+		.owner		= THIS_MODULE,
+		.n_voltages	= 1,
+		.min_uV		= RT5033_REGULATOR_SAFE_LDO_VOLTAGE,
+		.enable_reg	= RT5033_REG_CTRL,
+		.enable_mask	= RT5033_CTRL_EN_SAFE_LDO_MASK,
+	},
+};
+
+static int rt5033_regulator_probe(struct platform_device *pdev)
+{
+	struct rt5033_dev *rt5033 = dev_get_drvdata(pdev->dev.parent);
+	int ret, i;
+	struct regulator_config config = {};
+
+	config.dev = &pdev->dev;
+	config.driver_data = rt5033;
+
+	for (i = 0; i < ARRAY_SIZE(rt5033_supported_regulators); i++) {
+		struct regulator_dev *regulator;
+
+		config.regmap = rt5033->regmap;
+
+		regulator = devm_regulator_register(&pdev->dev,
+				&rt5033_supported_regulators[i], &config);
+		if (IS_ERR(regulator)) {
+			ret = PTR_ERR(regulator);
+			dev_err(&pdev->dev,
+				"Regulator init failed %d: with error: %d\n",
+				i, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id rt5033_regulator_id[] = {
+	{ "rt5033-regulator", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, rt5033_regulator_id);
+
+static struct platform_driver rt5033_regulator_driver = {
+	.driver = {
+		.name = "rt5033-regulator",
+	},
+	.probe		= rt5033_regulator_probe,
+	.id_table	= rt5033_regulator_id,
+};
+module_platform_driver(rt5033_regulator_driver);
+
+MODULE_DESCRIPTION("Richtek RT5033 Regulator driver");
+MODULE_AUTHOR("Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
