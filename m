From: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 1/3] power: rt5033_battery: Add RT5033 Fuel gauge device
 driver
Date: Fri, 09 Jan 2015 17:45:11 +0900
Message-ID: <1420793114-20586-2-git-send-email-beomho.seo@samsung.com>
References: <1420793114-20586-1-git-send-email-beomho.seo@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1420793114-20586-1-git-send-email-beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lee.jone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch adds device driver of Richtek PMIC.
The driver support battery fuel gange. Fuel gauge calculates and determines the
battery state of charge(SOC) according to battery open circuit voltage(OCV).
Also, this driver provides battery average voltage, voltage and bettery present
property.

Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Signed-off-by: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
Changes in v2
- none.
---
 drivers/power/Kconfig          |    8 ++
 drivers/power/Makefile         |    1 +
 drivers/power/rt5033_battery.c |  177 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/power/rt5033_battery.c

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 0108c2a..da6981f 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -397,6 +397,14 @@ config BATTERY_GOLDFISH
 	  Say Y to enable support for the battery and AC power in the
 	  Goldfish emulator.
 
+config BATTERY_RT5033
+	tristate "RT5033 fuel gauge support"
+	depends on MFD_RT5033
+	help
+	  This adds support for battery fuel gauge in Richtek RT5033 PMIC.
+	  The fuelgauge calculates and determines the battery state of charge
+	  according to battery open circuit voltage.
+
 source "drivers/power/reset/Kconfig"
 
 endif # POWER_SUPPLY
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index dfa8942..b83a0c7 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_BATTERY_DA9052)	+= da9052-battery.o
 obj-$(CONFIG_BATTERY_MAX17040)	+= max17040_battery.o
 obj-$(CONFIG_BATTERY_MAX17042)	+= max17042_battery.o
 obj-$(CONFIG_BATTERY_Z2)	+= z2_battery.o
+obj-$(CONFIG_BATTERY_RT5033)	+= rt5033_battery.o
 obj-$(CONFIG_BATTERY_S3C_ADC)	+= s3c_adc_battery.o
 obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
 obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
diff --git a/drivers/power/rt5033_battery.c b/drivers/power/rt5033_battery.c
new file mode 100644
index 0000000..7b898f4
--- /dev/null
+++ b/drivers/power/rt5033_battery.c
@@ -0,0 +1,177 @@
+/*
+ * Fuel gauge driver for Richtek RT5033
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
+#include <linux/power_supply.h>
+#include <linux/mfd/rt5033-private.h>
+#include <linux/mfd/rt5033.h>
+
+static int rt5033_battery_get_capacity(struct i2c_client *client)
+{
+	struct rt5033_battery *battery = i2c_get_clientdata(client);
+	u32 msb;
+
+	regmap_read(battery->regmap, RT5033_FUEL_REG_SOC_H, &msb);
+
+	return msb;
+}
+
+static int rt5033_battery_get_present(struct i2c_client *client)
+{
+	struct rt5033_battery *battery = i2c_get_clientdata(client);
+	u32 val;
+
+	regmap_read(battery->regmap, RT5033_FUEL_REG_CONFIG_L, &val);
+
+	return (val & RT5033_FUEL_BAT_PRESENT) ? true : false;
+}
+
+static int rt5033_battery_get_watt_prop(struct i2c_client *client,
+		enum power_supply_property psp)
+{
+	struct rt5033_battery *battery = i2c_get_clientdata(client);
+	unsigned int regh, regl;
+	int ret;
+	u32 msb, lsb;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		regh = RT5033_FUEL_REG_VBAT_H;
+		regl = RT5033_FUEL_REG_VBAT_L;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		regh = RT5033_FUEL_REG_AVG_VOLT_H;
+		regl = RT5033_FUEL_REG_AVG_VOLT_L;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		regh = RT5033_FUEL_REG_OCV_H;
+		regl = RT5033_FUEL_REG_OCV_L;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_read(battery->regmap, regh, &msb);
+	regmap_read(battery->regmap, regl, &lsb);
+
+	ret = ((msb << 4) + (lsb >> 4)) * 1250 / 1000;
+
+	return ret;
+}
+
+static int rt5033_battery_get_property(struct power_supply *psy,
+		enum power_supply_property psp,
+		union power_supply_propval *val)
+{
+	struct rt5033_battery *battery = container_of(psy,
+				struct rt5033_battery, psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		val->intval = rt5033_battery_get_watt_prop(battery->client,
+									psp);
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = rt5033_battery_get_present(battery->client);
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = rt5033_battery_get_capacity(battery->client);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property rt5033_battery_props[] = {
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CAPACITY,
+};
+
+static struct regmap_config rt5033_battery_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= RT5033_FUEL_REG_END,
+};
+
+static int rt5033_battery_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct rt5033_battery *battery;
+	u32 ret;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
+		return -EIO;
+
+	battery = devm_kzalloc(&client->dev, sizeof(*battery), GFP_KERNEL);
+	if (!battery)
+		return -EINVAL;
+
+	battery->client = client;
+	battery->regmap = devm_regmap_init_i2c(client,
+			&rt5033_battery_regmap_config);
+	if (IS_ERR(battery->regmap)) {
+		dev_err(&client->dev, "Failed to initialize regmap\n");
+		return -EINVAL;
+	}
+
+	i2c_set_clientdata(client, battery);
+
+	battery->psy.name		= "rt5033-battery";
+	battery->psy.type		= POWER_SUPPLY_TYPE_BATTERY;
+	battery->psy.get_property	= rt5033_battery_get_property;
+	battery->psy.properties		= rt5033_battery_props;
+	battery->psy.num_properties	= ARRAY_SIZE(rt5033_battery_props);
+
+	ret = power_supply_register(&client->dev, &battery->psy);
+	if (ret) {
+		dev_err(&client->dev, "Failed to register power supply\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rt5033_battery_remove(struct i2c_client *client)
+{
+	struct rt5033_battery *battery = i2c_get_clientdata(client);
+
+	power_supply_unregister(&battery->psy);
+
+	return 0;
+}
+
+static const struct i2c_device_id rt5033_battery_id[] = {
+	{ "rt5033-battery", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, rt5033_battery_id);
+
+static struct i2c_driver rt5033_battery_driver = {
+	.driver = {
+		.name = "rt5033-battery",
+	},
+	.probe = rt5033_battery_probe,
+	.remove = rt5033_battery_remove,
+	.id_table = rt5033_battery_id,
+};
+module_i2c_driver(rt5033_battery_driver);
+
+MODULE_DESCRIPTION("Richtek RT5033 fuel gauge driver");
+MODULE_AUTHOR("Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
