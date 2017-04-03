From: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Subject: [PATCH 2/3] power: supply: New driver for LEGO MINDSTORMS EV3 battery
Date: Mon,  3 Apr 2017 15:23:48 -0500
Message-ID: <1491251029-23256-3-git-send-email-david@lechnology.com>
References: <1491251029-23256-1-git-send-email-david@lechnology.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491251029-23256-1-git-send-email-david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This adds a new driver for the LEGO MINDSTORMS EV3 battery. The EV3 is
an embedded ARM device that can use 6 AA batteries or a special rechargeable
Li-ion battery pack. The rechargeable battery pack presses a special key
switch in the battery compartment to indicate that it is present.

The EV3 is only capable of monitoring battery voltage and current. The
charging circuit is built into the rechargeable battery pack and there is
no way to communicate with is, so we can't provide any information about
charging status.

When not using the rechargeable battery pack, it is most common to use
alkaline batteries to power the device, but it is also common for people to
use rechargeable NiMH batteries. Since there is not a way to automatically
differentiate between these, the technology property is made writable.

Signed-off-by: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
---
 drivers/power/supply/Kconfig            |   6 +
 drivers/power/supply/Makefile           |   1 +
 drivers/power/supply/lego_ev3_battery.c | 237 ++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 drivers/power/supply/lego_ev3_battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index cc50e15..e00bf25 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -117,6 +117,12 @@ config BATTERY_DS2782
 	  Say Y here to enable support for the DS2782/DS2786 standalone battery
 	  gas-gauge.
 
+config BATTERY_LEGO_EV3
+	tristate "LEGO MINDSTORMS EV3 battery"
+	depends on OF && IIO && GPIOLIB
+	help
+	  Say Y here to enable support for the LEGO MINDSTORMS EV3 battery.
+
 config BATTERY_PMU
 	tristate "Apple PMU battery"
 	depends on PPC32 && ADB_PMU
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 3789a2c..dfeadbc 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_BATTERY_DS2781)	+= ds2781_battery.o
 obj-$(CONFIG_BATTERY_DS2782)	+= ds2782_battery.o
 obj-$(CONFIG_BATTERY_GAUGE_LTC2941)	+= ltc2941-battery-gauge.o
 obj-$(CONFIG_BATTERY_GOLDFISH)	+= goldfish_battery.o
+obj-$(CONFIG_BATTERY_LEGO_EV3)	+= lego_ev3_battery.o
 obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
 obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
 obj-$(CONFIG_BATTERY_TOSA)	+= tosa_battery.o
diff --git a/drivers/power/supply/lego_ev3_battery.c b/drivers/power/supply/lego_ev3_battery.c
new file mode 100644
index 0000000..87230bd
--- /dev/null
+++ b/drivers/power/supply/lego_ev3_battery.c
@@ -0,0 +1,237 @@
+/*
+ * Battery driver for LEGO MINDSTORMS EV3
+ *
+ * Copyright (C) 2017 David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/types.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+
+struct lego_ev3_battery {
+	struct iio_channel *iio_v;
+	struct iio_channel *iio_i;
+	struct gpio_desc *rechargeable_gpio;
+	struct power_supply *psy;
+	int technology;
+	int v_max;
+	int v_min;
+};
+
+static int lego_ev3_battery_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	struct lego_ev3_battery *batt = power_supply_get_drvdata(psy);
+	int val2;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = batt->technology;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		/* battery voltage is iio channel * 2 + Vce of transistor */
+		iio_read_channel_processed(batt->iio_v, &val->intval);
+		val->intval *= 2000;
+		val->intval += 200000;
+		/* plus adjust for shunt resistor drop */
+		iio_read_channel_processed(batt->iio_i, &val2);
+		val2 *= 1000;
+		val2 /= 15;
+		val->intval += val2;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		val->intval = batt->v_max;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		val->intval = batt->v_min;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		/* battery current is iio channel / 15 / 0.05 ohms */
+		iio_read_channel_processed(batt->iio_i, &val->intval);
+		val->intval *= 20000;
+		val->intval /= 15;
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int lego_ev3_battery_set_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 const union power_supply_propval *val)
+{
+	struct lego_ev3_battery *batt = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		/*
+		 * Only allow changing technology from Unknown to NiMH. Li-ion
+		 * batteries are automatically detected and should not be
+		 * overridden. Rechargeable AA batteries, on the other hand,
+		 * cannot be automatically detected, and so must be manually
+		 * specified. This should only be set once during system init,
+		 * so there is no mechanism to go back to Unknown.
+		 */
+		if (batt->technology != POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
+			return -EINVAL;
+		switch (val->intval) {
+		case POWER_SUPPLY_TECHNOLOGY_NiMH:
+			batt->technology = POWER_SUPPLY_TECHNOLOGY_NiMH;
+			batt->v_max = 7800000;
+			batt->v_min = 5400000;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int lego_ev3_battery_property_is_writeable(struct power_supply *psy,
+						  enum power_supply_property psp)
+{
+	struct lego_ev3_battery *batt = power_supply_get_drvdata(psy);
+
+	return psp == POWER_SUPPLY_PROP_TECHNOLOGY &&
+		batt->technology == POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
+}
+
+static enum power_supply_property lego_ev3_battery_props[] = {
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_SCOPE,
+};
+
+static const struct power_supply_desc lego_ev3_battery_desc = {
+	.name			= "lego-ev3-battery",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.properties		= lego_ev3_battery_props,
+	.num_properties		= ARRAY_SIZE(lego_ev3_battery_props),
+	.get_property		= lego_ev3_battery_get_property,
+	.set_property		= lego_ev3_battery_set_property,
+	.property_is_writeable	= lego_ev3_battery_property_is_writeable,
+};
+
+static int lego_ev3_battery_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct lego_ev3_battery *batt;
+	struct power_supply_config psy_cfg = {};
+	int err;
+
+	batt = devm_kzalloc(dev, sizeof(*batt), GFP_KERNEL);
+	if (!batt)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, batt);
+
+	batt->iio_v = devm_iio_channel_get(dev, "voltage");
+	err = PTR_ERR_OR_ZERO(batt->iio_v);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get voltage iio channel\n");
+		return err;
+	}
+
+	batt->iio_i = devm_iio_channel_get(dev, "current");
+	err = PTR_ERR_OR_ZERO(batt->iio_i);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get current iio channel\n");
+		return err;
+	}
+
+	batt->rechargeable_gpio = devm_gpiod_get(dev, "rechargeable", GPIOD_IN);
+	err = PTR_ERR_OR_ZERO(batt->rechargeable_gpio);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get rechargeable gpio\n");
+		return err;
+	}
+
+	/*
+	 * The rechargeable battery indication switch cannot be changed without
+	 * removing the battery, so we only need to read it once.
+	 */
+	if (gpiod_get_value(batt->rechargeable_gpio)) {
+		/* 2-cell Li-ion, 7.4V nominal */
+		batt->technology = POWER_SUPPLY_TECHNOLOGY_LION;
+		batt->v_max = 84000000;
+		batt->v_min = 60000000;
+	} else {
+		/* 6x AA Alkaline, 9V nominal */
+		batt->technology = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
+		batt->v_max = 90000000;
+		batt->v_min = 48000000;
+	}
+
+	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.drv_data = batt;
+
+	batt->psy = power_supply_register(dev, &lego_ev3_battery_desc, &psy_cfg);
+	err = PTR_ERR_OR_ZERO(batt->psy);
+	if (err) {
+		dev_err(dev, "failed to register power supply\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int lego_ev3_battery_remove(struct platform_device *pdev)
+{
+	struct lego_ev3_battery *batt = platform_get_drvdata(pdev);
+
+	power_supply_unregister(batt->psy);
+
+	return 0;
+}
+
+static const struct of_device_id of_lego_ev3_battery_match[] = {
+	{ .compatible = "lego,ev3-battery", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, of_lego_ev3_battery_match);
+
+static struct platform_driver lego_ev3_battery_driver = {
+	.driver	= {
+		.name		= "lego-ev3-battery",
+		.of_match_table = of_lego_ev3_battery_match,
+	},
+	.probe	= lego_ev3_battery_probe,
+	.remove	= lego_ev3_battery_remove,
+};
+module_platform_driver(lego_ev3_battery_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>");
+MODULE_DESCRIPTION("LEGO MINDSTORMS EV3 Battery Driver");
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
