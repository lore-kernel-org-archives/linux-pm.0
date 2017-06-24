From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v3 1/2] power: supply: ltc2941-battery-gauge: Define LTC2942
 registers
Date: Sat, 24 Jun 2017 17:07:35 +0200
Message-ID: <20170624150735.to5izi5remfmrqox@lenoch>
References: <20170624150545.2oxwror5fy2xlvaz@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:58582 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdFXPHi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jun 2017 11:07:38 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23993887AbdFXPHgaP2SW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 24 Jun 2017 17:07:36 +0200
Content-Disposition: inline
In-Reply-To: <20170624150545.2oxwror5fy2xlvaz@lenoch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>

In order to support LTC2942 which has temperature registers
at different offsets than LTC2943 use following register naming
scheme (prefixes):
- LTC294X_ common registers
- LTC2942_ chips specific registers
- LTC2943_ specific registers
There are no functional changes.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 - v2: None
 - v3: Extend commit message

 drivers/power/supply/ltc2941-battery-gauge.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 7efb908f4451..0a1b69bbca7f 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -34,16 +34,14 @@ enum ltc294x_reg {
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
 };
 
 #define LTC2943_REG_CONTROL_MODE_MASK (BIT(7) | BIT(6))
@@ -55,6 +53,7 @@ enum ltc294x_reg {
 #define LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED	0
 
 #define LTC2941_NUM_REGS	0x08
+#define LTC2942_NUM_REGS	0x10
 #define LTC2943_NUM_REGS	0x18
 
 struct ltc294x_info {
@@ -263,7 +262,7 @@ static int ltc294x_get_current(const struct ltc294x_info *info, int *val)
 	s32 value;
 
 	ret = ltc294x_read_regs(info->client,
-		LTC294X_REG_CURRENT_MSB, &datar[0], 2);
+		LTC2943_REG_CURRENT_MSB, &datar[0], 2);
 	value = (datar[0] << 8) | datar[1];
 	value -= 0x7FFF;
 	/* Value is in range -32k..+32k, r_sense is usually 10..50 mOhm,
@@ -280,7 +279,7 @@ static int ltc294x_get_temperature(const struct ltc294x_info *info, int *val)
 	u32 value;
 
 	ret = ltc294x_read_regs(info->client,
-		LTC294X_REG_TEMPERATURE_MSB, &datar[0], 2);
+		LTC2943_REG_TEMPERATURE_MSB, &datar[0], 2);
 	value = (datar[0] << 8) | datar[1];
 	/* Full-scale is 510 Kelvin, convert to centidegrees  */
 	*val = (((51000 * value) / 0xFFFF) - 27215);
@@ -424,10 +423,10 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	info->client = client;
 	info->supply_desc.type = POWER_SUPPLY_TYPE_BATTERY;
 	info->supply_desc.properties = ltc294x_properties;
-	if (info->num_regs >= LTC294X_REG_TEMPERATURE_LSB)
+	if (info->num_regs >= LTC2943_REG_TEMPERATURE_LSB)
 		info->supply_desc.num_properties =
 			ARRAY_SIZE(ltc294x_properties);
-	else if (info->num_regs >= LTC294X_REG_CURRENT_LSB)
+	else if (info->num_regs >= LTC2943_REG_CURRENT_LSB)
 		info->supply_desc.num_properties =
 			ARRAY_SIZE(ltc294x_properties) - 1;
 	else if (info->num_regs >= LTC294X_REG_VOLTAGE_LSB)
-- 
2.11.0
