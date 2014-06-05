From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 1/4] power: max17042_battery: Specifies operation mode of
 max17042 fuelgauge
Date: Thu, 05 Jun 2014 12:46:14 +0900
Message-ID: <1401939977-20328-2-git-send-email-jonghwa3.lee@samsung.com>
References: <1401939977-20328-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49756 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbaFEDq1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jun 2014 23:46:27 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6O00JAEFTCWU30@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Thu, 05 Jun 2014 12:46:24 +0900 (KST)
In-reply-to: <1401939977-20328-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, Jonghwa Lee <jonghwa3.lee@samsung.com>

Fuelgauge max17042 chip and its successors, max17047, max17050 has different
operation mode, 'ModelGague M1' and 'ModelGauge M3'. Each mode is selectable
depends on its implementation via register control.
M1 mode can measure battery's capacity only according to voltage information
while M3 needs current and temperature at once. Therefore, its properties which
is showed to users can be also differed. This patch supports mode selection in
max17042 driver and proper working for each mode.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 .../bindings/power_supply/max17042_battery.txt     |    3 +
 drivers/power/max17042_battery.c                   |  105 ++++++++++----------
 include/linux/power/max17042_battery.h             |    7 +-
 3 files changed, 64 insertions(+), 51 deletions(-)

diff --git a/Documentation/devicetree/bindings/power_supply/max17042_battery.txt b/Documentation/devicetree/bindings/power_supply/max17042_battery.txt
index 5bc9b68..8ac9405 100644
--- a/Documentation/devicetree/bindings/power_supply/max17042_battery.txt
+++ b/Documentation/devicetree/bindings/power_supply/max17042_battery.txt
@@ -3,6 +3,9 @@ max17042_battery
 
 Required properties :
  - compatible : "maxim,max17042"
+ - maxim,operation-mode : Defined fuelgauge operation mode
+		<0> : ModelGauge m1, fuelgauge based on voltage only
+		<1> : ModelGauge m3, fuelgauge with mixing algorithm
 
 Optional properties :
  - maxim,rsns-microohm : Resistance of rsns resistor in micro Ohms
diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index 66da691..1266760 100644
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
 
@@ -71,6 +74,7 @@ struct max17042_chip {
 	struct regmap *regmap;
 	struct power_supply battery;
 	enum max170xx_chip_type chip_type;
+	enum max17042_operation_mode mode;
 	struct max17042_platform_data *pdata;
 	struct work_struct work;
 	int    init_complete;
@@ -91,6 +95,8 @@ static enum power_supply_property max17042_battery_props[] = {
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 };
+#define MODELGAUGE_M1_PROPS 8
+#define MODELGAUGE_M3_PROPS 13
 
 static int max17042_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
@@ -164,7 +170,10 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = data * 625 / 8;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		ret = regmap_read(map, MAX17042_RepSOC, &data);
+		if (chip->mode == MODELGAUGE_M3)
+			ret = regmap_read(map, MAX17042_RepSOC, &data);
+		else
+			ret = regmap_read(map, MAX17042_VFSOC, &data);
 		if (ret < 0)
 			return ret;
 
@@ -200,40 +209,32 @@ static int max17042_get_property(struct power_supply *psy,
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
-			return -EINVAL;
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
+		val->intval *= 1562500 / chip->pdata->r_sns;
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
-			return -EINVAL;
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
@@ -629,7 +630,6 @@ static struct max17042_platform_data *
 max17042_get_pdata(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
-	u32 prop;
 	struct max17042_platform_data *pdata;
 
 	if (!np)
@@ -639,14 +639,14 @@ max17042_get_pdata(struct device *dev)
 	if (!pdata)
 		return NULL;
 
+	of_property_read_u32(np, "maxim,operation-mode", &pdata->mode);
+
 	/*
 	 * Require current sense resistor value to be specified for
 	 * current-sense functionality to be enabled at all.
 	 */
-	if (of_property_read_u32(np, "maxim,rsns-microohm", &prop) == 0) {
-		pdata->r_sns = prop;
-		pdata->enable_current_sense = true;
-	}
+	if (pdata->mode == MODELGAUGE_M3)
+		of_property_read_u32(np, "maxim,rsns-microohm", &pdata->r_sns);
 
 	return pdata;
 }
@@ -706,20 +706,31 @@ static int max17042_probe(struct i2c_client *client,
 		dev_err(&client->dev, "device version mismatch: %x\n", val);
 		return -EIO;
 	}
+	chip->mode = chip->pdata->mode;
+	dev_dbg(&client->dev, "operates as modelgauge %s\n",
+				chip->mode == MODELGAUGE_M1 ? "M1" : "M3");
 
 	chip->battery.name		= "max170xx_battery";
 	chip->battery.type		= POWER_SUPPLY_TYPE_BATTERY;
 	chip->battery.get_property	= max17042_get_property;
 	chip->battery.properties	= max17042_battery_props;
-	chip->battery.num_properties	= ARRAY_SIZE(max17042_battery_props);
-
-	/* When current is not measured,
-	 * CURRENT_NOW and CURRENT_AVG properties should be invisible. */
-	if (!chip->pdata->enable_current_sense)
-		chip->battery.num_properties -= 2;
+	if (chip->mode == MODELGAUGE_M3) {
+		/* ModelGauge m3 */
+		chip->battery.num_properties = MODELGAUGE_M3_PROPS;
+		if (chip->pdata->r_sns == 0)
+			chip->pdata->r_sns = MAX17042_DEFAULT_SNS_RESISTOR;
+	} else {
+		/* ModelGauge m1 */
+		chip->battery.num_properties = MODELGAUGE_M1_PROPS;
+		regmap_write(chip->regmap, MAX17042_CGAIN, 0x0000);
+		regmap_write(chip->regmap, MAX17042_MiscCFG, 0x0003);
+		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
 
-	if (chip->pdata->r_sns == 0)
-		chip->pdata->r_sns = MAX17042_DEFAULT_SNS_RESISTOR;
+		/* Off thermistor - temperature may be externally given */
+		regmap_update_bits(chip->regmap, MAX17042_CONFIG,
+			CONFIG_ETHERM_BIT | CONFIG_TEX_BIT | CONFIG_TEN_BIT,
+			CONFIG_TEX_BIT);
+	}
 
 	if (chip->pdata->init_data)
 		for (i = 0; i < chip->pdata->num_init_data; i++)
@@ -727,12 +738,6 @@ static int max17042_probe(struct i2c_client *client,
 					chip->pdata->init_data[i].addr,
 					chip->pdata->init_data[i].data);
 
-	if (!chip->pdata->enable_current_sense) {
-		regmap_write(chip->regmap, MAX17042_CGAIN, 0x0000);
-		regmap_write(chip->regmap, MAX17042_MiscCFG, 0x0003);
-		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
-	}
-
 	ret = power_supply_register(&client->dev, &chip->battery);
 	if (ret) {
 		dev_err(&client->dev, "failed: power supply register\n");
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 89dd84f..f8c03c2 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -195,13 +195,18 @@ struct max17042_config_data {
 	u16	cell_char_tbl[MAX17042_CHARACTERIZATION_DATA_SIZE];
 } __packed;
 
+enum max17042_operation_mode {
+	MODELGAUGE_M1,
+	MODELGAUGE_M3,
+};
+
 struct max17042_platform_data {
 	struct max17042_reg_data *init_data;
 	struct max17042_config_data *config_data;
 	int num_init_data; /* Number of enties in init_data array */
-	bool enable_current_sense;
 	bool enable_por_init; /* Use POR init from Maxim appnote */
 
+	enum max17042_operation_mode mode;
 	/*
 	 * R_sns in micro-ohms.
 	 * default 10000 (if r_sns = 0) as it is the recommended value by
-- 
1.7.9.5

