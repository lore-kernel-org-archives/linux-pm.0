From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v7 1/2] power: act8945a: add charger driver for ACT8945A
Date: Fri, 22 Jan 2016 14:53:29 +0800
Message-ID: <1453445610-19275-2-git-send-email-wenyou.yang@atmel.com>
References: <1453445610-19275-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:48485 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbcAVG4W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2016 01:56:22 -0500
In-Reply-To: <1453445610-19275-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Lee Jones <lee.jones@linaro.org>, Peter Korsgaard <jacmet@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>

This patch adds new driver for Active-semi ACT8945A ActivePath
charger (part of ACT8945A MFD driver) providing power supply class
information to userspace.

The driver can be configured through DT (such as, total timer,
precondition timer and input over-voltage threshold).

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v7:
 - use the helper dev_get_regmap(pdev->dev.parent, NULL) to get regmap.
 - remove *act8945a_dev member from struct act8945a_charger.
 - remove *psy member from struct act8945a_charger.
 - merge _parse_dt() and _charger_config() functions, remove relevent
   members from struct act8945a_charger.
 - remove unused platform_set_drvdata(pdev, charger) statement.

Changes in v6:
 - change the type value to unsigned int.

Changes in v5:
 - remove spare spaces after #define.
 - add OF match table.

Changes in v4:
 - use spaces after #define, not tabs.
 - use BIT(n) macros to substitute (0x01 << x).
 - change dt properties with more legible name.

Changes in v3:
 - update the file header with short version license and author line.
 - remove unused member of struct act8945a_charger, dev.
 - action due to removing the member of stuct act8945a_dev, dev.
 - remove the unnecessary print out.
 - remove the unnecessary act8945a_charger_remove().
 - fix align of the code-style.

Changes in v2:
 1./ Substitute of_property_read_bool() for of_get_property().
 2./ Substitute devm_power_supply_register() for power_supply_register().
 3./ Use module_platform_driver(), instead of subsys_initcall().
 4./ Substitute MODULE_LICENSE("GPL") for MODULE_LICENSE("GPL v2").

 drivers/power/Kconfig            |    7 +
 drivers/power/Makefile           |    1 +
 drivers/power/act8945a_charger.c |  362 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 370 insertions(+)
 create mode 100644 drivers/power/act8945a_charger.c

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 1ddd13c..ae75211 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -75,6 +75,13 @@ config BATTERY_88PM860X
 	help
 	  Say Y here to enable battery monitor for Marvell 88PM860x chip.
 
+config BATTERY_ACT8945A
+	tristate "Active-semi ACT8945A charger driver"
+	depends on MFD_ACT8945A
+	help
+	  Say Y here to enable support for power supply provided by
+	  Active-semi ActivePath ACT8945A charger.
+
 config BATTERY_DS2760
 	tristate "DS2760 battery driver (HP iPAQ & others)"
 	depends on W1 && W1_SLAVE_DS2760
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 0e4eab5..e46b75d 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_WM8350_POWER)	+= wm8350_power.o
 obj-$(CONFIG_TEST_POWER)	+= test_power.o
 
 obj-$(CONFIG_BATTERY_88PM860X)	+= 88pm860x_battery.o
+obj-$(CONFIG_BATTERY_ACT8945A)	+= act8945a_charger.o
 obj-$(CONFIG_BATTERY_DS2760)	+= ds2760_battery.o
 obj-$(CONFIG_BATTERY_DS2780)	+= ds2780_battery.o
 obj-$(CONFIG_BATTERY_DS2781)	+= ds2781_battery.o
diff --git a/drivers/power/act8945a_charger.c b/drivers/power/act8945a_charger.c
new file mode 100644
index 0000000..930614e
--- /dev/null
+++ b/drivers/power/act8945a_charger.c
@@ -0,0 +1,362 @@
+/*
+ * Power supply driver for the Active-semi ACT8945A PMIC
+ *
+ * Copyright (C) 2015 Atmel Corporation
+ *
+ * Author: Wenyou Yang <wenyou.yang@atmel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+
+static const char *act8945a_charger_model = "ACT8945A";
+static const char *act8945a_charger_manufacturer = "Active-semi";
+
+/**
+ * ACT8945A Charger Register Map
+ */
+
+/* 0x70: Reserved */
+#define ACT8945A_APCH_CFG		0x71
+#define ACT8945A_APCH_STATUS		0x78
+#define ACT8945A_APCH_CTRL		0x79
+#define ACT8945A_APCH_STATE		0x7A
+
+/* ACT8945A_APCH_CFG */
+#define APCH_CFG_OVPSET			(0x3 << 0)
+#define APCH_CFG_OVPSET_6V6		(0x0 << 0)
+#define APCH_CFG_OVPSET_7V		(0x1 << 0)
+#define APCH_CFG_OVPSET_7V5		(0x2 << 0)
+#define APCH_CFG_OVPSET_8V		(0x3 << 0)
+#define APCH_CFG_PRETIMO		(0x3 << 2)
+#define APCH_CFG_PRETIMO_40_MIN		(0x0 << 2)
+#define APCH_CFG_PRETIMO_60_MIN		(0x1 << 2)
+#define APCH_CFG_PRETIMO_80_MIN		(0x2 << 2)
+#define APCH_CFG_PRETIMO_DISABLED	(0x3 << 2)
+#define APCH_CFG_TOTTIMO		(0x3 << 4)
+#define APCH_CFG_TOTTIMO_3_HOUR		(0x0 << 4)
+#define APCH_CFG_TOTTIMO_4_HOUR		(0x1 << 4)
+#define APCH_CFG_TOTTIMO_5_HOUR		(0x2 << 4)
+#define APCH_CFG_TOTTIMO_DISABLED	(0x3 << 4)
+#define APCH_CFG_SUSCHG			(0x1 << 7)
+
+#define APCH_STATUS_CHGDAT		BIT(0)
+#define APCH_STATUS_INDAT		BIT(1)
+#define APCH_STATUS_TEMPDAT		BIT(2)
+#define APCH_STATUS_TIMRDAT		BIT(3)
+#define APCH_STATUS_CHGSTAT		BIT(4)
+#define APCH_STATUS_INSTAT		BIT(5)
+#define APCH_STATUS_TEMPSTAT		BIT(6)
+#define APCH_STATUS_TIMRSTAT		BIT(7)
+
+#define APCH_CTRL_CHGEOCOUT		BIT(0)
+#define APCH_CTRL_INDIS			BIT(1)
+#define APCH_CTRL_TEMPOUT		BIT(2)
+#define APCH_CTRL_TIMRPRE		BIT(3)
+#define APCH_CTRL_CHGEOCIN		BIT(4)
+#define APCH_CTRL_INCON			BIT(5)
+#define APCH_CTRL_TEMPIN		BIT(6)
+#define APCH_CTRL_TIMRTOT		BIT(7)
+
+#define APCH_STATE_ACINSTAT		(0x1 << 1)
+#define APCH_STATE_CSTATE		(0x3 << 4)
+#define APCH_STATE_CSTATE_SHIFT		4
+#define APCH_STATE_CSTATE_DISABLED	0x00
+#define APCH_STATE_CSTATE_EOC		0x01
+#define APCH_STATE_CSTATE_FAST		0x02
+#define APCH_STATE_CSTATE_PRE		0x03
+
+struct act8945a_charger {
+	struct regmap *regmap;
+	bool battery_temperature;
+};
+
+static int act8945a_get_charger_state(struct regmap *regmap, int *val)
+{
+	int ret;
+	unsigned int status, state;
+
+	ret = regmap_read(regmap, ACT8945A_APCH_STATUS, &status);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(regmap, ACT8945A_APCH_STATE, &state);
+	if (ret < 0)
+		return ret;
+
+	state &= APCH_STATE_CSTATE;
+	state >>= APCH_STATE_CSTATE_SHIFT;
+
+	if (state == APCH_STATE_CSTATE_EOC) {
+		if (status & APCH_STATUS_CHGDAT)
+			*val = POWER_SUPPLY_STATUS_FULL;
+		else
+			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+	} else if ((state == APCH_STATE_CSTATE_FAST) ||
+		   (state == APCH_STATE_CSTATE_PRE)) {
+		*val = POWER_SUPPLY_STATUS_CHARGING;
+	} else {
+		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+	}
+
+	return 0;
+}
+
+static int act8945a_get_charge_type(struct regmap *regmap, int *val)
+{
+	int ret;
+	unsigned int state;
+
+	ret = regmap_read(regmap, ACT8945A_APCH_STATE, &state);
+	if (ret < 0)
+		return ret;
+
+	state &= APCH_STATE_CSTATE;
+	state >>= APCH_STATE_CSTATE_SHIFT;
+
+	switch (state) {
+	case APCH_STATE_CSTATE_PRE:
+		*val = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		break;
+	case APCH_STATE_CSTATE_FAST:
+		*val = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		break;
+	case APCH_STATE_CSTATE_EOC:
+	case APCH_STATE_CSTATE_DISABLED:
+	default:
+		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
+	}
+
+	return 0;
+}
+
+static int act8945a_get_battery_health(struct act8945a_charger *charger,
+				       struct regmap *regmap, int *val)
+{
+	int ret;
+	unsigned int status;
+
+	ret = regmap_read(regmap, ACT8945A_APCH_STATUS, &status);
+	if (ret < 0)
+		return ret;
+
+	if (charger->battery_temperature && !(status & APCH_STATUS_TEMPDAT))
+		*val = POWER_SUPPLY_HEALTH_OVERHEAT;
+	else if (!(status & APCH_STATUS_INDAT))
+		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+	else if (status & APCH_STATUS_TIMRDAT)
+		*val = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
+	else
+		*val = POWER_SUPPLY_HEALTH_GOOD;
+
+	return 0;
+}
+
+static enum power_supply_property act8945a_charger_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER
+};
+
+static int act8945a_charger_get_property(struct power_supply *psy,
+					 enum power_supply_property prop,
+					 union power_supply_propval *val)
+{
+	struct act8945a_charger *charger = power_supply_get_drvdata(psy);
+	struct regmap *regmap = charger->regmap;
+	int ret = 0;
+
+	switch (prop) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = act8945a_get_charger_state(regmap, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		ret = act8945a_get_charge_type(regmap, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret = act8945a_get_battery_health(charger,
+						  regmap, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = act8945a_charger_model;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = act8945a_charger_manufacturer;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct power_supply_desc act8945a_charger_desc = {
+	.name		= "act8945a-charger",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.get_property	= act8945a_charger_get_property,
+	.properties	= act8945a_charger_props,
+	.num_properties	= ARRAY_SIZE(act8945a_charger_props),
+};
+
+#define DEFAULT_TOTAL_TIME_OUT		3
+#define DEFAULT_PRE_TIME_OUT		40
+#define DEFAULT_INPUT_OVP_THRESHOLD	6600
+
+static int act8945a_charger_config(struct device *dev,
+				   struct act8945a_charger *charger)
+{
+	struct device_node *np = dev->of_node;
+	enum of_gpio_flags flags;
+	struct regmap *regmap = charger->regmap;
+
+	u32 total_time_out;
+	u32 pre_time_out;
+	u32 input_voltage_threshold;
+	int chglev_pin;
+
+	unsigned int value = 0;
+
+	if (!np) {
+		dev_err(dev, "no charger of node\n");
+		return -EINVAL;
+	}
+
+	charger->battery_temperature = of_property_read_bool(np,
+				"active-semi,check-battery-temperature");
+
+	chglev_pin = of_get_named_gpio_flags(np,
+				"active-semi,chglev-gpios", 0, &flags);
+
+	if (gpio_is_valid(chglev_pin)) {
+		gpio_set_value(chglev_pin,
+			       ((flags == OF_GPIO_ACTIVE_LOW) ? 0 : 1));
+	}
+
+	if (of_property_read_u32(np,
+				 "active-semi,input-voltage-threshold-microvolt",
+				 &input_voltage_threshold))
+		input_voltage_threshold = DEFAULT_PRE_TIME_OUT;
+
+	if (of_property_read_u32(np,
+				 "active-semi,precondition-timeout",
+				 &pre_time_out))
+		pre_time_out = DEFAULT_PRE_TIME_OUT;
+
+	if (of_property_read_u32(np, "active-semi,total-timeout",
+				 &total_time_out))
+		total_time_out = DEFAULT_TOTAL_TIME_OUT;
+
+	switch (input_voltage_threshold) {
+	case 8000:
+		value |= APCH_CFG_OVPSET_8V;
+		break;
+	case 7500:
+		value |= APCH_CFG_OVPSET_7V5;
+		break;
+	case 7000:
+		value |= APCH_CFG_OVPSET_7V;
+		break;
+	case 6600:
+	default:
+		value |= APCH_CFG_OVPSET_6V6;
+		break;
+	}
+
+	switch (pre_time_out) {
+	case 60:
+		value |= APCH_CFG_PRETIMO_60_MIN;
+		break;
+	case 80:
+		value |= APCH_CFG_PRETIMO_80_MIN;
+		break;
+	case 0:
+		value |= APCH_CFG_PRETIMO_DISABLED;
+		break;
+	case 40:
+	default:
+		value |= APCH_CFG_PRETIMO_40_MIN;
+		break;
+	}
+
+	switch (total_time_out) {
+	case 4:
+		value |= APCH_CFG_TOTTIMO_4_HOUR;
+		break;
+	case 5:
+		value |= APCH_CFG_TOTTIMO_5_HOUR;
+		break;
+	case 0:
+		value |= APCH_CFG_TOTTIMO_DISABLED;
+		break;
+	case 3:
+	default:
+		value |= APCH_CFG_TOTTIMO_3_HOUR;
+		break;
+	}
+
+	return regmap_write(regmap, ACT8945A_APCH_CFG, value);
+}
+
+static int act8945a_charger_probe(struct platform_device *pdev)
+{
+	struct act8945a_charger *charger;
+	struct power_supply *psy;
+	struct power_supply_config psy_cfg = {};
+	int ret;
+
+	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
+	if (!charger)
+		return -ENOMEM;
+
+	charger->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+
+	ret = act8945a_charger_config(&pdev->dev, charger);
+	if (ret)
+		return ret;
+
+	psy_cfg.of_node	= pdev->dev.of_node;
+	psy_cfg.drv_data = charger;
+
+	psy = devm_power_supply_register(&pdev->dev,
+					 &act8945a_charger_desc,
+					 &psy_cfg);
+	if (IS_ERR(psy)) {
+		dev_err(&pdev->dev, "failed to register power supply\n");
+		return PTR_ERR(psy);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id act8945a_charger_of_match[] = {
+	{ .compatible = "active-semi,act8945a-charger" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, act8945a_charger_of_match);
+
+static struct platform_driver act8945a_charger_driver = {
+	.driver	= {
+		.name = "act8945a-charger",
+		.of_match_table = of_match_ptr(act8945a_charger_of_match),
+	},
+	.probe	= act8945a_charger_probe,
+};
+module_platform_driver(act8945a_charger_driver);
+
+MODULE_DESCRIPTION("Active-semi ACT8945A ActivePath charger driver");
+MODULE_AUTHOR("Wenyou Yang <wenyou.yang@atmel.com>");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5

