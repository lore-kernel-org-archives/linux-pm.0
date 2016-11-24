From: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
Subject: [PATCH v3 1/2] power: supply: add sbs-charger driver
Date: Thu, 24 Nov 2016 13:33:42 +0100
Message-ID: <1479990823-25841-2-git-send-email-nicolas.saenz@prodys.net>
References: <1479990823-25841-1-git-send-email-nicolas.saenz@prodys.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479990823-25841-1-git-send-email-nicolas.saenz@prodys.net>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.saenz@prodys.net
List-Id: linux-pm@vger.kernel.org

This adds support for sbs-charger compilant chips as defined here:
http://sbs-forum.org/specs/sbc110.pdf

This was tested on a arm board connected to an LTC41000 battery charger
chip.

Signed-off-by: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
---
 v2 -> v3:
 - add readable_reg() function to regmap config
 - update compatible strings with part number

 v1 -> v2:
 - add spec link in header
 - use proper gpio/interrupt interface
 - update regmap configuration (max register & endianness)
 - dropped oldschool .supplied_to assignments
 - use devm_* APIs
 drivers/power/supply/Kconfig       |   6 +
 drivers/power/supply/Makefile      |   1 +
 drivers/power/supply/sbs-charger.c | 275 +++++++++++++++++++++++++++++++++++++
 3 files changed, 282 insertions(+)
 create mode 100644 drivers/power/supply/sbs-charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 76806a0..42877ff 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -164,6 +164,12 @@ config BATTERY_SBS
 	  Say Y to include support for SBS battery driver for SBS-compliant
 	  gas gauges.
 
+config CHARGER_SBS
+        tristate "SBS Compliant charger"
+        depends on I2C
+        help
+	  Say Y to include support for SBS compilant battery chargers.
+
 config BATTERY_BQ27XXX
 	tristate "BQ27xxx battery driver"
 	help
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 36c599d..06d9ef5 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_BATTERY_COLLIE)	+= collie_battery.o
 obj-$(CONFIG_BATTERY_IPAQ_MICRO) += ipaq_micro_battery.o
 obj-$(CONFIG_BATTERY_WM97XX)	+= wm97xx_battery.o
 obj-$(CONFIG_BATTERY_SBS)	+= sbs-battery.o
+obj-$(CONFIG_CHARGER_SBS)	+= sbs-charger.o
 obj-$(CONFIG_BATTERY_BQ27XXX)	+= bq27xxx_battery.o
 obj-$(CONFIG_BATTERY_BQ27XXX_I2C) += bq27xxx_battery_i2c.o
 obj-$(CONFIG_BATTERY_DA9030)	+= da9030_battery.o
diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
new file mode 100644
index 0000000..2c4cd45
--- /dev/null
+++ b/drivers/power/supply/sbs-charger.c
@@ -0,0 +1,275 @@
+/*
+ * Copyright (c) 2016, Prodys S.L.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This adds support for sbs-charger compilant chips as defined here:
+ * http://sbs-forum.org/specs/sbc110.pdf
+ *
+ * Implemetation based on sbs-battery.c
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/power_supply.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/gpio.h>
+#include <linux/regmap.h>
+#include <linux/of_gpio.h>
+#include <linux/bitops.h>
+
+#define SBS_CHARGER_REG_SPEC_INFO		0x11
+#define SBS_CHARGER_REG_STATUS			0x13
+#define SBS_CHARGER_REG_ALARM_WARNING		0x16
+
+#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(1)
+#define SBS_CHARGER_STATUS_RES_COLD		BIT(9)
+#define SBS_CHARGER_STATUS_RES_HOT		BIT(10)
+#define SBS_CHARGER_STATUS_BATTERY_PRESENT	BIT(14)
+#define SBS_CHARGER_STATUS_AC_PRESENT		BIT(15)
+
+#define SBS_CHARGER_POLL_TIME			500
+
+struct sbs_info {
+	struct i2c_client		*client;
+	struct power_supply		*power_supply;
+	struct regmap			*regmap;
+	struct delayed_work		work;
+	unsigned int			last_state;
+};
+
+static int sbs_get_property(struct power_supply *psy,
+			    enum power_supply_property psp,
+			    union power_supply_propval *val)
+{
+	struct sbs_info *chip = power_supply_get_drvdata(psy);
+	unsigned int reg;
+
+	reg = chip->last_state;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = !!(reg & SBS_CHARGER_STATUS_BATTERY_PRESENT);
+		break;
+
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = !!(reg & SBS_CHARGER_STATUS_AC_PRESENT);
+		break;
+
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+
+		if (!(reg & SBS_CHARGER_STATUS_BATTERY_PRESENT))
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		else if (reg & SBS_CHARGER_STATUS_AC_PRESENT &&
+			 !(reg & SBS_CHARGER_STATUS_CHARGE_INHIBITED))
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+
+		break;
+
+	case POWER_SUPPLY_PROP_HEALTH:
+		if (reg & SBS_CHARGER_STATUS_RES_COLD)
+			val->intval = POWER_SUPPLY_HEALTH_COLD;
+		if (reg & SBS_CHARGER_STATUS_RES_HOT)
+			val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
+		else
+			val->intval = POWER_SUPPLY_HEALTH_GOOD;
+
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sbs_check_state(struct sbs_info *chip)
+{
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(chip->regmap, SBS_CHARGER_REG_STATUS, &reg);
+	if (!ret && reg != chip->last_state) {
+		chip->last_state = reg;
+		power_supply_changed(chip->power_supply);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void sbs_delayed_work(struct work_struct *work)
+{
+	struct sbs_info *chip = container_of(work, struct sbs_info, work.work);
+
+	sbs_check_state(chip);
+
+	schedule_delayed_work(&chip->work,
+			      msecs_to_jiffies(SBS_CHARGER_POLL_TIME));
+}
+
+static irqreturn_t sbs_irq_thread(int irq, void *data)
+{
+	struct sbs_info *chip = data;
+	int ret;
+
+	ret = sbs_check_state(chip);
+
+	return ret ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static enum power_supply_property sbs_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_HEALTH,
+};
+
+static bool sbs_readable_reg(struct device *dev, unsigned int reg)
+{
+	if (reg < SBS_CHARGER_REG_SPEC_INFO)
+		return false;
+	else
+		return true;
+}
+
+static bool sbs_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case SBS_CHARGER_REG_STATUS:
+		return true;
+	}
+
+	return false;
+}
+
+static const struct regmap_config sbs_regmap = {
+	.reg_bits	= 8,
+	.val_bits	= 16,
+	.max_register	= SBS_CHARGER_REG_ALARM_WARNING,
+	.readable_reg	= sbs_readable_reg,
+	.volatile_reg	= sbs_volatile_reg,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE, /* since based on SMBus */
+};
+
+static const struct power_supply_desc sbs_desc = {
+	.name = "sbs-charger",
+	.type = POWER_SUPPLY_TYPE_MAINS,
+	.properties = sbs_properties,
+	.num_properties = ARRAY_SIZE(sbs_properties),
+	.get_property = sbs_get_property,
+};
+
+static int sbs_probe(struct i2c_client *client,
+		     const struct i2c_device_id *id)
+{
+	struct power_supply_config psy_cfg = {};
+	struct sbs_info *chip;
+	int ret, val;
+
+	chip = devm_kzalloc(&client->dev, sizeof(struct sbs_info), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->client = client;
+	psy_cfg.of_node = client->dev.of_node;
+	psy_cfg.drv_data = chip;
+
+	i2c_set_clientdata(client, chip);
+
+	chip->regmap = devm_regmap_init_i2c(client, &sbs_regmap);
+	if (IS_ERR(chip->regmap))
+		return PTR_ERR(chip->regmap);
+
+	/*
+	 * Before we register, we need to make sure we can actually talk
+	 * to the battery.
+	 */
+	ret = regmap_read(chip->regmap, SBS_CHARGER_REG_STATUS, &val);
+	if (ret) {
+		dev_err(&client->dev, "Failed to get device status\n");
+		return ret;
+	}
+	chip->last_state = val;
+
+	chip->power_supply = devm_power_supply_register(&client->dev, &sbs_desc,
+							&psy_cfg);
+	if (IS_ERR(chip->power_supply)) {
+		dev_err(&client->dev, "Failed to register power supply\n");
+		return PTR_ERR(chip->power_supply);
+	}
+
+	/*
+	 * The sbs-charger spec doesn't impose the use of an interrupt. So in
+	 * the case it wasn't provided we use polling in order get the charger's
+	 * status.
+	 */
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+					NULL, sbs_irq_thread,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					dev_name(&client->dev), chip);
+		if (ret) {
+			dev_err(&client->dev, "Failed to request irq, %d\n", ret);
+			return ret;
+		}
+	} else {
+		INIT_DELAYED_WORK(&chip->work, sbs_delayed_work);
+		schedule_delayed_work(&chip->work,
+				      msecs_to_jiffies(SBS_CHARGER_POLL_TIME));
+	}
+
+	dev_info(&client->dev,
+		 "%s: smart charger device registered\n", client->name);
+
+	return 0;
+}
+
+static int sbs_remove(struct i2c_client *client)
+{
+	struct sbs_info *chip = i2c_get_clientdata(client);
+
+	cancel_delayed_work_sync(&chip->work);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id sbs_dt_ids[] = {
+	{ .compatible = "lltc,ltc4100" },
+	{ .compatible = "sbs,sbs-charger" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sbs_dt_ids);
+#endif
+
+static const struct i2c_device_id sbs_id[] = {
+	{ "sbs-charger", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sbs_id);
+
+static struct i2c_driver sbs_driver = {
+	.probe		= sbs_probe,
+	.remove		= sbs_remove,
+	.id_table	= sbs_id,
+	.driver = {
+		.name	= "sbs-charger",
+		.of_match_table = of_match_ptr(sbs_dt_ids),
+	},
+};
+module_i2c_driver(sbs_driver);
+
+MODULE_AUTHOR("Nicolas Saenz Julienne <nicolassaenzj@gmail.com>");
+MODULE_DESCRIPTION("SBS smart charger driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
