From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v6 1/3] power: supply: ltc2941-battery-gauge: Prepare for
 LTC2942 and LTC2944
Date: Sun, 16 Jul 2017 11:33:06 +0200
Message-ID: <20170716093306.vz4xw7ij7dptzkot@lenoch>
References: <20170716093202.vfea4yylbzfec72v@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:41740 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbdGPJdJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Jul 2017 05:33:09 -0400
Content-Disposition: inline
In-Reply-To: <20170716093202.vfea4yylbzfec72v@lenoch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Dragos Bogdan <dragos.bogdan@analog.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

In order to support LTC2942 which has temperature registers
at different offsets than LTC2943 use following register naming
scheme (prefixes):
- LTC294X_ common registers
- LTC2942_ chips specific registers
- LTC2943_ specific registers

LTC2944 is compatible with LTC2943 but uses different constants
to compute voltage and current, so replace num_regs misused
for device indentification with real device id to discriminate
between those two.

There are no functional changes.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 - v2: None
 - v3: Extend commit message
 - v4: None
 - v5: Count on LTC2944 too
 - v6: Move LTC2942 and LTC2944 to respective patches

 drivers/power/supply/ltc2941-battery-gauge.c | 63 ++++++++++++++--------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 7efb908f4451..b0de448a226b 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -34,16 +34,19 @@ enum ltc294x_reg {
 	LTC294X_REG_CONTROL		= 0x01,
 	LTC294X_REG_ACC_CHARGE_MSB	= 0x02,
 	LTC294X_REG_ACC_CHARGE_LSB	= 0x03,
-	LTC294X_REG_THRESH_HIGH_MSB	= 0x04,
-	LTC294X_REG_THRESH_HIGH_LSB	= 0x05,
-	LTC294X_REG_THRESH_LOW_MSB	= 0x06,
-	LTC294X_REG_THRESH_LOW_LSB	= 0x07,
-	LTC294X_REG_VOLTAGE_MSB	= 0x08,
-	LTC294X_REG_VOLTAGE_LSB	= 0x09,
-	LTC294X_REG_CURRENT_MSB	= 0x0E,
-	LTC294X_REG_CURRENT_LSB	= 0x0F,
-	LTC294X_REG_TEMPERATURE_MSB	= 0x14,
-	LTC294X_REG_TEMPERATURE_LSB	= 0x15,
+	LTC294X_REG_VOLTAGE_MSB		= 0x08,
+	LTC294X_REG_VOLTAGE_LSB		= 0x09,
+	LTC2942_REG_TEMPERATURE_MSB	= 0x0C,
+	LTC2942_REG_TEMPERATURE_LSB	= 0x0D,
+	LTC2943_REG_CURRENT_MSB		= 0x0E,
+	LTC2943_REG_CURRENT_LSB		= 0x0F,
+	LTC2943_REG_TEMPERATURE_MSB	= 0x14,
+	LTC2943_REG_TEMPERATURE_LSB	= 0x15,
+};
+
+enum ltc294x_id {
+	LTC2941_ID,
+	LTC2943_ID,
 };
 
 #define LTC2943_REG_CONTROL_MODE_MASK (BIT(7) | BIT(6))
@@ -54,15 +57,12 @@ enum ltc294x_reg {
 	((x << 3) & LTC294X_REG_CONTROL_PRESCALER_MASK)
 #define LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED	0
 
-#define LTC2941_NUM_REGS	0x08
-#define LTC2943_NUM_REGS	0x18
-
 struct ltc294x_info {
 	struct i2c_client *client;	/* I2C Client pointer */
 	struct power_supply *supply;	/* Supply pointer */
 	struct power_supply_desc supply_desc;	/* Supply description */
 	struct delayed_work work;	/* Work scheduler */
-	unsigned long num_regs;	/* Number of registers (chip type) */
+	enum ltc294x_id id;		/* Chip type */
 	int charge;	/* Last charge register content */
 	int r_sense;	/* mOhm */
 	int Qlsb;	/* nAh */
@@ -146,7 +146,7 @@ static int ltc294x_reset(const struct ltc294x_info *info, int prescaler_exp)
 	control = LTC294X_REG_CONTROL_PRESCALER_SET(prescaler_exp) |
 				LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED;
 	/* Put the 2943 into "monitor" mode, so it measures every 10 sec */
-	if (info->num_regs == LTC2943_NUM_REGS)
+	if (info->id == LTC2941_ID)
 		control |= LTC2943_REG_CONTROL_MODE_SCAN;
 
 	if (value != control) {
@@ -263,7 +263,7 @@ static int ltc294x_get_current(const struct ltc294x_info *info, int *val)
 	s32 value;
 
 	ret = ltc294x_read_regs(info->client,
-		LTC294X_REG_CURRENT_MSB, &datar[0], 2);
+		LTC2943_REG_CURRENT_MSB, &datar[0], 2);
 	value = (datar[0] << 8) | datar[1];
 	value -= 0x7FFF;
 	/* Value is in range -32k..+32k, r_sense is usually 10..50 mOhm,
@@ -280,7 +280,7 @@ static int ltc294x_get_temperature(const struct ltc294x_info *info, int *val)
 	u32 value;
 
 	ret = ltc294x_read_regs(info->client,
-		LTC294X_REG_TEMPERATURE_MSB, &datar[0], 2);
+		LTC2943_REG_TEMPERATURE_MSB, &datar[0], 2);
 	value = (datar[0] << 8) | datar[1];
 	/* Full-scale is 510 Kelvin, convert to centidegrees  */
 	*val = (((51000 * value) / 0xFFFF) - 27215);
@@ -357,8 +357,8 @@ static enum power_supply_property ltc294x_properties[] = {
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
 static int ltc294x_i2c_remove(struct i2c_client *client)
@@ -388,7 +388,7 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 
 	np = of_node_get(client->dev.of_node);
 
-	info->num_regs = (unsigned long)of_device_get_match_data(&client->dev);
+	info->id = (enum ltc294x_id)of_device_get_match_data(&client->dev);
 	info->supply_desc.name = np->name;
 
 	/* r_sense can be negative, when sense+ is connected to the battery
@@ -409,7 +409,7 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 		prescaler_exp = LTC2941_MAX_PRESCALER_EXP;
 	}
 
-	if (info->num_regs == LTC2943_NUM_REGS) {
+	if (info->id == LTC2943_ID) {
 		if (prescaler_exp > LTC2943_MAX_PRESCALER_EXP)
 			prescaler_exp = LTC2943_MAX_PRESCALER_EXP;
 		info->Qlsb = ((340 * 50000) / r_sense) /
@@ -424,18 +424,17 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	info->client = client;
 	info->supply_desc.type = POWER_SUPPLY_TYPE_BATTERY;
 	info->supply_desc.properties = ltc294x_properties;
-	if (info->num_regs >= LTC294X_REG_TEMPERATURE_LSB)
+	switch (info->id) {
+	case LTC2943_ID:
 		info->supply_desc.num_properties =
 			ARRAY_SIZE(ltc294x_properties);
-	else if (info->num_regs >= LTC294X_REG_CURRENT_LSB)
-		info->supply_desc.num_properties =
-			ARRAY_SIZE(ltc294x_properties) - 1;
-	else if (info->num_regs >= LTC294X_REG_VOLTAGE_LSB)
-		info->supply_desc.num_properties =
-			ARRAY_SIZE(ltc294x_properties) - 2;
-	else
+		break;
+	case LTC2941_ID:
+	default:
 		info->supply_desc.num_properties =
 			ARRAY_SIZE(ltc294x_properties) - 3;
+		break;
+	}
 	info->supply_desc.get_property = ltc294x_get_property;
 	info->supply_desc.set_property = ltc294x_set_property;
 	info->supply_desc.property_is_writeable = ltc294x_property_is_writeable;
@@ -492,8 +491,8 @@ static SIMPLE_DEV_PM_OPS(ltc294x_pm_ops, ltc294x_suspend, ltc294x_resume);
 
 
 static const struct i2c_device_id ltc294x_i2c_id[] = {
-	{"ltc2941", LTC2941_NUM_REGS},
-	{"ltc2943", LTC2943_NUM_REGS},
+	{ "ltc2941", LTC2941_ID, },
+	{ "ltc2943", LTC2943_ID, },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);
@@ -501,11 +500,11 @@ MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);
 static const struct of_device_id ltc294x_i2c_of_match[] = {
 	{
 		.compatible = "lltc,ltc2941",
-		.data = (void *)LTC2941_NUM_REGS
+		.data = (void *)LTC2941_ID,
 	},
 	{
 		.compatible = "lltc,ltc2943",
-		.data = (void *)LTC2943_NUM_REGS
+		.data = (void *)LTC2943_ID,
 	},
 	{ },
 };
-- 
2.11.0
