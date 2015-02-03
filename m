From: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 4/6] power: max77843_battery: Add Max77843 fuel gauge device
 driver
Date: Tue, 03 Feb 2015 14:04:04 +0900
Message-ID: <1422939846-29955-5-git-send-email-jaewon02.kim@samsung.com>
References: <1422939846-29955-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1422939846-29955-1-git-send-email-jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, SangBae Lee <sangbae90.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

This patch adds device driver of max77843 fuel gauge.
The driver support for battery fuel gauge in Maxim Max77843.
It is fuel-gauge systems for lithuum-ion batteries in handled and
portable devices.

Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/power/Kconfig            |    9 ++
 drivers/power/Makefile           |    1 +
 drivers/power/max77843_battery.c |  286 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 296 insertions(+)
 create mode 100644 drivers/power/max77843_battery.c

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index a054a28..cea0ea2 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -212,6 +212,15 @@ config BATTERY_MAX17042
 	  with MAX17042. This driver also supports max17047/50 chips which are
 	  improved version of max17042.
 
+config BATTERY_MAX77843
+	tristate "Maxim MAX77843 Fuel Gauge"
+	depends on MFD_MAX77843
+	help
+	  This adds support for battery fuel gauge in Maxim MAX77843. It is
+	  fuel-gauge for a lithium-ion batteries with a single cell and can be
+	  found in portable devices. The MAX17040 is configured to operate with
+	  a single lithium cell.
+
 config BATTERY_Z2
 	tristate "Z2 battery driver"
 	depends on I2C && MACH_ZIPIT2
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 212c6a2..ae0d795 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_BATTERY_DA9030)	+= da9030_battery.o
 obj-$(CONFIG_BATTERY_DA9052)	+= da9052-battery.o
 obj-$(CONFIG_BATTERY_MAX17040)	+= max17040_battery.o
 obj-$(CONFIG_BATTERY_MAX17042)	+= max17042_battery.o
+obj-$(CONFIG_BATTERY_MAX77843)	+= max77843_battery.o
 obj-$(CONFIG_BATTERY_Z2)	+= z2_battery.o
 obj-$(CONFIG_BATTERY_S3C_ADC)	+= s3c_adc_battery.o
 obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
diff --git a/drivers/power/max77843_battery.c b/drivers/power/max77843_battery.c
new file mode 100644
index 0000000..0c59a16
--- /dev/null
+++ b/drivers/power/max77843_battery.c
@@ -0,0 +1,286 @@
+/*
+ * Fuel gauge driver for Maxim MAX77843
+ *
+ * Copyright (C) 2015 Samsung Electronics, Co., Ltd.
+ * Author: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published bythe Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/mfd/max77843-private.h>
+
+struct max77843_battery {
+	struct device		*dev;
+	struct max77843		*max77843;
+	struct i2c_client	*client;
+	struct regmap		*regmap;
+	struct power_supply	psy;
+};
+
+static int max77843_battery_get_capacity(struct max77843_battery *battery)
+{
+	struct regmap *regmap = battery->regmap;
+	int ret, val;
+	unsigned int reg_data;
+
+	ret = regmap_read(regmap, MAX77843_FG_REG_SOCREP, &reg_data);
+	if (ret) {
+		dev_err(battery->dev, "Failed to read fuelgauge register\n");
+		return ret;
+	}
+
+	val = reg_data >> 8;
+
+	return val;
+}
+
+static int max77843_battery_get_energy_prop(struct max77843_battery *battery,
+		enum power_supply_property psp)
+{
+	struct regmap *regmap = battery->regmap;
+	unsigned int reg;
+	int ret, val;
+	unsigned int reg_data;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ENERGY_FULL:
+		reg = MAX77843_FG_REG_FULLCAP;
+		break;
+	case POWER_SUPPLY_PROP_ENERGY_NOW:
+		reg = MAX77843_FG_REG_REMCAP_REP;
+		break;
+	case POWER_SUPPLY_PROP_ENERGY_AVG:
+		reg = MAX77843_FG_REG_REMCAP_AV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_read(regmap, reg, &reg_data);
+	if (ret) {
+		dev_err(battery->dev, "Failed to read fuelgauge register\n");
+		return ret;
+	}
+
+	val = reg_data;
+
+	return val;
+}
+
+static int max77843_battery_get_current_prop(struct max77843_battery *battery,
+		enum power_supply_property psp)
+{
+	struct regmap *regmap = battery->regmap;
+	unsigned int reg;
+	int ret, val;
+	unsigned int reg_data;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		reg = MAX77843_FG_REG_CURRENT;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		reg = MAX77843_FG_REG_AVG_CURRENT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_read(regmap, reg, &reg_data);
+	if (ret) {
+		dev_err(battery->dev, "Failed to read fuelgauge register\n");
+		return ret;
+	}
+
+	val = reg_data;
+	if (val & 0x8000) {
+		/* Negative */
+		val = ~val & 0xffff;
+		val++;
+		val *= -1;
+	}
+	/* Unit of current is mA */
+	val =  val * 15625 / 100000;
+
+	return val;
+}
+
+static int max77843_battery_get_voltage_prop(struct max77843_battery *battery,
+		enum power_supply_property psp)
+{
+	struct regmap *regmap = battery->regmap;
+	unsigned int reg;
+	int ret, val;
+	unsigned int reg_data;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		reg = MAX77843_FG_REG_VCELL;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		reg = MAX77843_FG_REG_AVG_VCELL;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		reg = MAX77843_FG_REG_OCV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_read(regmap, reg, &reg_data);
+	if (ret) {
+		dev_err(battery->dev, "Failed to read fuelgauge register\n");
+		return ret;
+	}
+
+	val = (reg_data >> 4)  * 125;
+	val /= 100;
+
+	return val;
+}
+
+static const char *model_name = "MAX77843";
+static const char *manufacturer = "Maxim Integrated";
+
+static int max77843_battery_get_property(struct power_supply *psy,
+		enum power_supply_property psp,
+		union power_supply_propval *val)
+{
+	struct max77843_battery *battery = container_of(psy,
+				struct max77843_battery, psy);
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		val->intval = max77843_battery_get_voltage_prop(battery, psp);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		val->intval = max77843_battery_get_current_prop(battery, psp);
+		break;
+	case POWER_SUPPLY_PROP_ENERGY_FULL:
+	case POWER_SUPPLY_PROP_ENERGY_NOW:
+	case POWER_SUPPLY_PROP_ENERGY_AVG:
+		val->intval = max77843_battery_get_energy_prop(battery, psp);
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = max77843_battery_get_capacity(battery);
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval =  model_name;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = manufacturer;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static enum power_supply_property max77843_battery_props[] = {
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_ENERGY_FULL,
+	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_ENERGY_AVG,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static const struct regmap_config max77843_fuel_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 16,
+	.val_format_endian = REGMAP_ENDIAN_NATIVE,
+	.max_register	= MAX77843_FG_END,
+};
+
+static int max77843_battery_probe(struct platform_device *pdev)
+{
+	struct max77843 *max77843 = dev_get_drvdata(pdev->dev.parent);
+	struct max77843_battery *battery;
+	int ret;
+
+	battery = devm_kzalloc(&pdev->dev, sizeof(*battery), GFP_KERNEL);
+	if (!battery)
+		return -ENOMEM;
+
+	battery->dev = &pdev->dev;
+	battery->max77843 = max77843;
+
+	battery->client = i2c_new_dummy(max77843->i2c->adapter, I2C_ADDR_FG);
+	if (!battery->client) {
+		dev_err(&pdev->dev, "Failed to get dummy i2c client.\n");
+		return PTR_ERR(battery->client);
+	}
+	i2c_set_clientdata(battery->client, max77843);
+
+	battery->regmap = devm_regmap_init_i2c(battery->client,
+			&max77843_fuel_regmap_config);
+	if (IS_ERR(battery->regmap)) {
+		ret = PTR_ERR(battery->regmap);
+		goto err_i2c;
+	}
+
+	platform_set_drvdata(pdev, battery);
+
+	battery->psy.name	= "max77843-fuelgauge";
+	battery->psy.type	= POWER_SUPPLY_TYPE_BATTERY;
+	battery->psy.get_property	= max77843_battery_get_property;
+	battery->psy.properties		= max77843_battery_props;
+	battery->psy.num_properties	= ARRAY_SIZE(max77843_battery_props);
+
+	ret = power_supply_register(&pdev->dev, &battery->psy);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed  to register power supply\n");
+		goto err_i2c;
+	}
+
+	return 0;
+
+err_i2c:
+	i2c_unregister_device(battery->client);
+
+	return ret;
+}
+
+static int max77843_battery_remove(struct platform_device *pdev)
+{
+	struct max77843_battery *battery = platform_get_drvdata(pdev);
+
+	power_supply_unregister(&battery->psy);
+
+	i2c_unregister_device(battery->client);
+
+	return 0;
+}
+
+static const struct platform_device_id max77843_battery_id[] = {
+	{ "max77843-fuelgauge", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, max77843_battery_id);
+
+static struct platform_driver max77843_battery_driver = {
+	.driver = {
+		.name = "max77843-fuelgauge",
+	},
+	.probe = max77843_battery_probe,
+	.remove = max77843_battery_remove,
+	.id_table = max77843_battery_id,
+};
+module_platform_driver(max77843_battery_driver);
+
+MODULE_DESCRIPTION("Maxim MAX77843 fuel gauge driver");
+MODULE_AUTHOR("Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
