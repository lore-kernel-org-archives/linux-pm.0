From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 2/2] power: supply: ltc2941-battery-gauge: Add support for
 LTC2942
Date: Mon, 12 Jun 2017 17:04:53 +0200
Message-ID: <20170612150453.kjsyu5jjsfb7kzoq@lenoch>
References: <20170612150226.woxfdi4lharq5gtq@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:41528 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbdFLPE4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 11:04:56 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990924AbdFLPEyxwU2m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Jun 2017 17:04:54 +0200
Content-Disposition: inline
In-Reply-To: <20170612150226.woxfdi4lharq5gtq@lenoch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Javier Martinez Canillas <javier@osg.samsung.com>

LTC2942 is pin compatible with LTC2941 providing additional
informations about battery voltage and temperature. It can
be runtime detected using bit A7 in the Status register.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/power/supply/ltc2941-battery-gauge.c | 56 ++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 0a1b69bbca7f..07e47478dbc6 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -44,6 +44,8 @@ enum ltc294x_reg {
 	LTC2943_REG_TEMPERATURE_LSB	= 0x15,
 };
 
+#define LTC2941_REG_STATUS_CHIP_ID	BIT(7)
+
 #define LTC2943_REG_CONTROL_MODE_MASK (BIT(7) | BIT(6))
 #define LTC2943_REG_CONTROL_MODE_SCAN BIT(7)
 #define LTC294X_REG_CONTROL_PRESCALER_MASK	(BIT(5) | BIT(4) | BIT(3))
@@ -250,8 +252,9 @@ static int ltc294x_get_voltage(const struct ltc294x_info *info, int *val)
 
 	ret = ltc294x_read_regs(info->client,
 		LTC294X_REG_VOLTAGE_MSB, &datar[0], 2);
-	value = (datar[0] << 8) | datar[1];
-	*val = ((value * 23600) / 0xFFFF) * 1000; /* in uV */
+	value = info->num_regs == LTC2943_NUM_REGS ? 23600 : 6000;
+	value *= (datar[0] << 8) | datar[1];
+	*val = 1000 * value / 0xFFFF; /* in uV */
 	return ret;
 }
 
@@ -274,15 +277,22 @@ static int ltc294x_get_current(const struct ltc294x_info *info, int *val)
 
 static int ltc294x_get_temperature(const struct ltc294x_info *info, int *val)
 {
+	enum ltc294x_reg reg;
 	int ret;
 	u8 datar[2];
 	u32 value;
 
-	ret = ltc294x_read_regs(info->client,
-		LTC2943_REG_TEMPERATURE_MSB, &datar[0], 2);
-	value = (datar[0] << 8) | datar[1];
-	/* Full-scale is 510 Kelvin, convert to centidegrees  */
-	*val = (((51000 * value) / 0xFFFF) - 27215);
+	if (info->num_regs == LTC2943_NUM_REGS) {
+		reg = LTC2943_REG_TEMPERATURE_MSB;
+		value = 51000;	/* Full-scale is 510 Kelvin */
+	} else {
+		reg = LTC2942_REG_TEMPERATURE_MSB;
+		value = 60000;	/* Full-scale is 600 Kelvin */
+	}
+	ret = ltc294x_read_regs(info->client, reg, &datar[0], 2);
+	value *= (datar[0] << 8) | datar[1];
+	/* Convert to centidegrees  */
+	*val = value / 0xFFFF - 27215;
 	return ret;
 }
 
@@ -356,8 +366,8 @@ static enum power_supply_property ltc294x_properties[] = {
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
 static int ltc294x_i2c_remove(struct i2c_client *client)
@@ -374,10 +384,11 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 {
 	struct power_supply_config psy_cfg = {};
 	struct ltc294x_info *info;
+	struct device_node *np;
 	int ret;
 	u32 prescaler_exp;
 	s32 r_sense;
-	struct device_node *np;
+	u8 status;
 
 	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
 	if (info == NULL)
@@ -420,21 +431,36 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 				(128 / (1 << prescaler_exp));
 	}
 
+	/* Read status register to check for LTC2942 */
+	if (info->num_regs == LTC2941_NUM_REGS) {
+		ret = ltc294x_read_regs(client, LTC294X_REG_STATUS, &status, 1);
+		if (ret < 0) {
+			dev_err(&info->client->dev,
+				"Could not read status register\n");
+			return ret;
+		}
+		if (!(status & LTC2941_REG_STATUS_CHIP_ID))
+			info->num_regs = LTC2942_NUM_REGS;
+	}
+
 	info->client = client;
 	info->supply_desc.type = POWER_SUPPLY_TYPE_BATTERY;
 	info->supply_desc.properties = ltc294x_properties;
-	if (info->num_regs >= LTC2943_REG_TEMPERATURE_LSB)
+	switch (info->num_regs) {
+	case LTC2943_NUM_REGS:
 		info->supply_desc.num_properties =
 			ARRAY_SIZE(ltc294x_properties);
-	else if (info->num_regs >= LTC2943_REG_CURRENT_LSB)
+		break;
+	case LTC2942_NUM_REGS:
 		info->supply_desc.num_properties =
 			ARRAY_SIZE(ltc294x_properties) - 1;
-	else if (info->num_regs >= LTC294X_REG_VOLTAGE_LSB)
-		info->supply_desc.num_properties =
-			ARRAY_SIZE(ltc294x_properties) - 2;
-	else
+		break;
+	case LTC2941_NUM_REGS:
+	default:
 		info->supply_desc.num_properties =
 			ARRAY_SIZE(ltc294x_properties) - 3;
+		break;
+	}
 	info->supply_desc.get_property = ltc294x_get_property;
 	info->supply_desc.set_property = ltc294x_set_property;
 	info->supply_desc.property_is_writeable = ltc294x_property_is_writeable;
-- 
2.11.0
