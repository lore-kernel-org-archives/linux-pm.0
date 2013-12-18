From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 3/3] fuelgauge: max17042: Seperate available property set for
 different operation.
Date: Wed, 18 Dec 2013 12:53:54 +0900
Message-ID: <1387338834-4046-4-git-send-email-jonghwa3.lee@samsung.com>
References: <1387338834-4046-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:24898 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab3LRDyD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2013 22:54:03 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXZ00MIAHHZ9T50@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 18 Dec 2013 12:53:59 +0900 (KST)
In-reply-to: <1387338834-4046-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: anton@enomsg.org, dwmw2@infradead.org, Jonghwa Lee <jonghwa3.lee@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>

max17042 fuelgauge driver supports various successors based on max17042.
Some versions use currrent sensor and temperature sensor to increase accuracy,
while others don't. So this patch makes driver to support seperate property set
depending on chip implementation.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 .../bindings/power_supply/max17042_battery.txt     |    3 +
 drivers/power/max17042_battery.c                   |  140 ++++++++++++++------
 include/linux/power/max17042_battery.h             |    4 +
 3 files changed, 104 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/power_supply/max17042_battery.txt b/Documentation/devicetree/bindings/power_supply/max17042_battery.txt
index 5bc9b68..b0f9859 100644
--- a/Documentation/devicetree/bindings/power_supply/max17042_battery.txt
+++ b/Documentation/devicetree/bindings/power_supply/max17042_battery.txt
@@ -8,6 +8,8 @@ Optional properties :
  - maxim,rsns-microohm : Resistance of rsns resistor in micro Ohms
                          (datasheet-recommended value is 10000).
    Defining this property enables current-sense functionality.
+ - maxim,thermometer-exist : Represent thermistor directly conneted.
+   (NOTE) Without this flag, max17042 never checks battery temperature.
 
 Example:
 
@@ -15,4 +17,5 @@ Example:
 		compatible = "maxim,max17042";
 		reg = <0x36>;
 		maxim,rsns-microohm = <10000>;
+		maxim,thermometer-exist;
 	};
diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index c611ce7..04821fb 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -45,7 +45,15 @@ struct max17042_chip {
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
@@ -54,12 +62,8 @@ static enum power_supply_property max17042_battery_props[] = {
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
@@ -140,6 +144,8 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = data >> 8;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		if (!chip->pdata->enable_current_sense)
+			return -EINVAL;
 		ret = regmap_read(map, MAX17042_FULLCAP, &data);
 		if (ret < 0)
 			return ret;
@@ -147,6 +153,8 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = data * 1000 / 2;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
+		if (!chip->pdata->enable_current_sense)
+			return -EINVAL;
 		ret = regmap_read(map, MAX17042_QH, &data);
 		if (ret < 0)
 			return ret;
@@ -154,6 +162,8 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = data * 1000 / 2;
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
+		if (!chip->pdata->enable_temperature_sense)
+			return -EINVAL;
 		ret = regmap_read(map, MAX17042_TEMP, &data);
 		if (ret < 0)
 			return ret;
@@ -169,40 +179,36 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = val->intval * 10 / 256;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		if (chip->pdata->enable_current_sense) {
-			ret = regmap_read(map, MAX17042_CURRENT, &data);
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
+		ret = regmap_read(map, MAX17042_CURRENT, &data);
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
-			ret = regmap_read(map, MAX17042_AVGCURRENT, &data);
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
+		ret = regmap_read(map, MAX17042_AVGCURRENT, &data);
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
@@ -617,6 +623,9 @@ max17042_get_pdata(struct device *dev)
 		pdata->enable_current_sense = true;
 	}
 
+	if (of_get_property(np, "maxim,thermometer-exist", NULL))
+		pdata->enable_temperature_sense = true;
+
 	return pdata;
 }
 #else
@@ -633,6 +642,57 @@ static struct regmap_config max17042_regmap_config = {
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
+		regmap_write(chip->regmap, MAX17042_MISCCFG, 0x0003);
+		regmap_write(chip->regmap, MAX17042_LEARNCFG, 0x0007);
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
@@ -679,16 +739,10 @@ static int max17042_probe(struct i2c_client *client,
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
index 7f75ecd..3d6a518 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -37,6 +37,9 @@
 
 /* Config register bits */
 #define CONFIG_ALRT_BIT_ENBL	(1 << 2)
+#define CONFIG_ETHERM_BIT	(1 << 4)
+#define CONFIG_TEX_BIT		(1 << 8)
+#define CONFIG_TEN_BIT		(1 << 9)
 
 #define MAX17042_BATTERY_FULL	(100)
 #define MAX17042_DEFAULT_SNS_RESISTOR	(10000)
@@ -223,6 +226,7 @@ struct max17042_platform_data {
 	struct max17042_config_data *config_data;
 	int num_init_data; /* Number of enties in init_data array */
 	bool enable_current_sense;
+	bool enable_temperature_sense;
 	bool enable_por_init; /* Use POR init from Maxim appnote */
 
 	/*
-- 
1.7.9.5

