From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH] fuelgauge: max17042: Seperate available property set for
 different operation.
Date: Tue, 21 Jan 2014 18:52:03 +0900
Message-ID: <1390297923-2914-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60753 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332AbaAUJwU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2014 04:52:20 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZQ00I6DWR5GY20@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 21 Jan 2014 18:52:17 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: anton@enomsg.org, dan.carpenter@oracle.com, dwmw2@infradead.org, Jonghwa Lee <jonghwa3.lee@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>

max17042 fuelgauge driver supports various successors based on max17042.
Some versions use currrent sensor and temperature sensor to increase accuracy,
while others don't. So this patch makes driver to support seperate property set
depending on chip implementation.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 .../bindings/power_supply/max17042_battery.txt     |    4 +
 drivers/power/max17042_battery.c                   |  143 ++++++++++++++------
 include/linux/power/max17042_battery.h             |    1 +
 3 files changed, 105 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/power_supply/max17042_battery.txt b/Documentation/devicetree/bindings/power_supply/max17042_battery.txt
index 5bc9b68..33b32f1 100644
--- a/Documentation/devicetree/bindings/power_supply/max17042_battery.txt
+++ b/Documentation/devicetree/bindings/power_supply/max17042_battery.txt
@@ -8,6 +8,9 @@ Optional properties :
  - maxim,rsns-microohm : Resistance of rsns resistor in micro Ohms
                          (datasheet-recommended value is 10000).
    Defining this property enables current-sense functionality.
+ - maxim,thermometer-exist : Represent thermistor directly conneted.
+   (NOTE) Without this flag, max17042 won't check battery temperature
+	  automatically.
 
 Example:
 
@@ -15,4 +18,5 @@ Example:
 		compatible = "maxim,max17042";
 		reg = <0x36>;
 		maxim,rsns-microohm = <10000>;
+		maxim,thermometer-exist;
 	};
diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index 66da691..9a40945 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -49,6 +49,9 @@
 
 /* Interrupt mask bits */
 #define CONFIG_ALRT_BIT_ENBL	(1 << 2)
+#define CONFIG_ETHERM_BIT	(1 << 4)
+#define CONFIG_TEX_BIT		(1 << 8)
+#define CONFIG_TEN_BIT		(1 << 9)
 #define STATUS_INTR_SOCMIN_BIT	(1 << 10)
 #define STATUS_INTR_SOCMAX_BIT	(1 << 14)
 
@@ -76,7 +79,15 @@ struct max17042_chip {
 	int    init_complete;
 };
 
-static enum power_supply_property max17042_battery_props[] = {
+/*
+ * Max17042/7 fuel-gauge optional properties :
+ * POWER_SUPPLY_PROP_CURRENT_NOW,
+ * POWER_SUPPLY_PROP_CURRENT_AVG,
+ * POWER_SUPPLY_PROP_CHARGE_FULL,
+ * POWER_SUPPLY_PROP_CHARGE_COUNTER,
+ * POWER_SUPPLY_PROP_TEMP,
+ */
+static enum power_supply_property max17042_default_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX,
@@ -85,12 +96,8 @@ static enum power_supply_property max17042_battery_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_AVG,
 	POWER_SUPPLY_PROP_VOLTAGE_OCV,
 	POWER_SUPPLY_PROP_CAPACITY,
-	POWER_SUPPLY_PROP_CHARGE_FULL,
-	POWER_SUPPLY_PROP_CHARGE_COUNTER,
-	POWER_SUPPLY_PROP_TEMP,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
-	POWER_SUPPLY_PROP_CURRENT_AVG,
 };
+#define NUM_ADDITIONAL_PROPS	5
 
 static int max17042_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
@@ -171,6 +178,8 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = data >> 8;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		if (!chip->pdata->enable_current_sense)
+			return -EINVAL;
 		ret = regmap_read(map, MAX17042_FullCAP, &data);
 		if (ret < 0)
 			return ret;
@@ -178,6 +187,8 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = data * 1000 / 2;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
+		if (!chip->pdata->enable_current_sense)
+			return -EINVAL;
 		ret = regmap_read(map, MAX17042_QH, &data);
 		if (ret < 0)
 			return ret;
@@ -185,6 +196,8 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = data * 1000 / 2;
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
+		if (!chip->pdata->enable_temperature_sense)
+			return -EINVAL;
 		ret = regmap_read(map, MAX17042_TEMP, &data);
 		if (ret < 0)
 			return ret;
@@ -200,40 +213,36 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = val->intval * 10 / 256;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		if (chip->pdata->enable_current_sense) {
-			ret = regmap_read(map, MAX17042_Current, &data);
-			if (ret < 0)
-				return ret;
-
-			val->intval = data;
-			if (val->intval & 0x8000) {
-				/* Negative */
-				val->intval = ~val->intval & 0x7fff;
-				val->intval++;
-				val->intval *= -1;
-			}
-			val->intval *= 1562500 / chip->pdata->r_sns;
-		} else {
+		if (!chip->pdata->enable_current_sense)
 			return -EINVAL;
+		ret = regmap_read(map, MAX17042_Current, &data);
+		if (ret < 0)
+			return ret;
+
+		val->intval = data;
+		if (val->intval & 0x8000) {
+			/* Negative */
+			val->intval = ~val->intval & 0x7fff;
+			val->intval++;
+			val->intval *= -1;
 		}
+			val->intval *= 1562500 / chip->pdata->r_sns;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
-		if (chip->pdata->enable_current_sense) {
-			ret = regmap_read(map, MAX17042_AvgCurrent, &data);
-			if (ret < 0)
-				return ret;
-
-			val->intval = data;
-			if (val->intval & 0x8000) {
-				/* Negative */
-				val->intval = ~val->intval & 0x7fff;
-				val->intval++;
-				val->intval *= -1;
-			}
-			val->intval *= 1562500 / chip->pdata->r_sns;
-		} else {
+		if (!chip->pdata->enable_current_sense)
 			return -EINVAL;
+		ret = regmap_read(map, MAX17042_AvgCurrent, &data);
+		if (ret < 0)
+			return ret;
+
+		val->intval = data;
+		if (val->intval & 0x8000) {
+			/* Negative */
+			val->intval = ~val->intval & 0x7fff;
+			val->intval++;
+			val->intval *= -1;
 		}
+		val->intval *= 1562500 / chip->pdata->r_sns;
 		break;
 	default:
 		return -EINVAL;
@@ -648,6 +657,9 @@ max17042_get_pdata(struct device *dev)
 		pdata->enable_current_sense = true;
 	}
 
+	if (of_get_property(np, "maxim,thermometer-exist", NULL))
+		pdata->enable_temperature_sense = true;
+
 	return pdata;
 }
 #else
@@ -664,6 +676,57 @@ static struct regmap_config max17042_regmap_config = {
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
 };
 
+static int max17042_init_properties(struct max17042_chip *chip)
+{
+	enum power_supply_property additional_props[NUM_ADDITIONAL_PROPS];
+	enum power_supply_property *properties;
+	int i, _base, added = 0;
+
+	_base = ARRAY_SIZE(max17042_default_props);
+
+	if (chip->pdata->enable_current_sense) {
+		additional_props[added++] = POWER_SUPPLY_PROP_CURRENT_NOW;
+		additional_props[added++] = POWER_SUPPLY_PROP_CURRENT_AVG;
+		additional_props[added++] = POWER_SUPPLY_PROP_CHARGE_FULL;
+		additional_props[added++] = POWER_SUPPLY_PROP_CHARGE_COUNTER;
+		if (chip->pdata->r_sns == 0)
+			chip->pdata->r_sns = MAX17042_DEFAULT_SNS_RESISTOR;
+	} else {
+		/* ModelGauge v1 - Without current sense */
+		regmap_write(chip->regmap, MAX17042_CGAIN, 0x0000);
+		regmap_write(chip->regmap, MAX17042_MiscCFG, 0x0003);
+		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
+	}
+
+	if (chip->pdata->enable_temperature_sense)
+		additional_props[added++] = POWER_SUPPLY_PROP_TEMP;
+	else
+		/* Off thermistor - temperature will be externally given */
+		regmap_update_bits(chip->regmap, MAX17042_CONFIG,
+			CONFIG_ETHERM_BIT | CONFIG_TEX_BIT | CONFIG_TEN_BIT,
+			CONFIG_TEX_BIT);
+
+	if (added) {
+		properties = devm_kzalloc(&chip->client->dev,
+			(_base + added) * sizeof(*properties), GFP_KERNEL);
+		if (!properties)
+			return -ENOMEM;
+
+		memcpy(properties, max17042_default_props,
+					sizeof(max17042_default_props));
+		for (i = 0; i < added; i++)
+			properties[_base + i] = additional_props[i];
+
+		chip->battery.properties = properties;
+		chip->battery.num_properties = _base + added;
+	} else {
+		chip->battery.properties = max17042_default_props;
+		chip->battery.num_properties = _base;
+	}
+
+	return 0;
+}
+
 static int max17042_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -710,16 +773,10 @@ static int max17042_probe(struct i2c_client *client,
 	chip->battery.name		= "max170xx_battery";
 	chip->battery.type		= POWER_SUPPLY_TYPE_BATTERY;
 	chip->battery.get_property	= max17042_get_property;
-	chip->battery.properties	= max17042_battery_props;
-	chip->battery.num_properties	= ARRAY_SIZE(max17042_battery_props);
 
-	/* When current is not measured,
-	 * CURRENT_NOW and CURRENT_AVG properties should be invisible. */
-	if (!chip->pdata->enable_current_sense)
-		chip->battery.num_properties -= 2;
-
-	if (chip->pdata->r_sns == 0)
-		chip->pdata->r_sns = MAX17042_DEFAULT_SNS_RESISTOR;
+	ret = max17042_init_properties(chip);
+	if (ret)
+		return ret;
 
 	if (chip->pdata->init_data)
 		for (i = 0; i < chip->pdata->num_init_data; i++)
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 89dd84f..81744ed 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -200,6 +200,7 @@ struct max17042_platform_data {
 	struct max17042_config_data *config_data;
 	int num_init_data; /* Number of enties in init_data array */
 	bool enable_current_sense;
+	bool enable_temperature_sense;
 	bool enable_por_init; /* Use POR init from Maxim appnote */
 
 	/*
-- 
1.7.9.5

