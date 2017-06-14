From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 2/2] power: supply: ltc2941-battery-gauge: Add support
 for LTC2942
Date: Wed, 14 Jun 2017 02:08:29 +0200
Message-ID: <20170614000829.n6xtzpbhveh5vv2k@lenoch>
References: <20170612150226.woxfdi4lharq5gtq@lenoch>
 <20170612150453.kjsyu5jjsfb7kzoq@lenoch>
 <c854309e-68b0-c1f2-a7f8-3161e38e1579@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:43982 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbdFNAkI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 20:40:08 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23993865AbdFNAIaJpARW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Jun 2017 02:08:30 +0200
Content-Disposition: inline
In-Reply-To: <c854309e-68b0-c1f2-a7f8-3161e38e1579@topic.nl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pm@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

On Mon, Jun 12, 2017 at 06:29:54PM +0200, Mike Looijmans wrote:
> ﻿On 12-6-2017 17:04, Ladislav Michl wrote:
> > LTC2942 is pin compatible with LTC2941 providing additional
> > informations about battery voltage and temperature. It can
> > be runtime detected using bit A7 in the Status register.
> 
> Runtime detection is always nice. I'd suggest adding "ltc2942" to the device
> name list, since having to specify "ltc2941" when the chip is in fact an
> "ltc2942" looks a bit strange.
> 
> Again, no strong preference, whatever the maintainers think is best is fine
> with me also.

Actually, could you or someone else give it a try on ltc2943 to see if I
didn't break anything? Updated version follows...

Subject: [PATCH v2 2/2] power: supply: ltc2941-battery-gauge: Add support for LTC2942

LTC2942 is pin compatible with LTC2941 providing additional
informations about battery voltage and temperature. It can
be runtime detected using bit A7 in the Status register.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes since v1: reworked voltage computing to not overflow and keep presision

 drivers/power/supply/ltc2941-battery-gauge.c | 76 +++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 0a1b69bbca7f..65e67cd44c5c 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -44,8 +44,10 @@ enum ltc294x_reg {
 	LTC2943_REG_TEMPERATURE_LSB	= 0x15,
 };
 
-#define LTC2943_REG_CONTROL_MODE_MASK (BIT(7) | BIT(6))
-#define LTC2943_REG_CONTROL_MODE_SCAN BIT(7)
+#define LTC2941_REG_STATUS_CHIP_ID	BIT(7)
+
+#define LTC2942_REG_CONTROL_MODE_SCAN	(BIT(7) | BIT(6))
+#define LTC2943_REG_CONTROL_MODE_SCAN	BIT(7)
 #define LTC294X_REG_CONTROL_PRESCALER_MASK	(BIT(5) | BIT(4) | BIT(3))
 #define LTC294X_REG_CONTROL_SHUTDOWN_MASK	(BIT(0))
 #define LTC294X_REG_CONTROL_PRESCALER_SET(x) \
@@ -144,9 +146,15 @@ static int ltc294x_reset(const struct ltc294x_info *info, int prescaler_exp)
 
 	control = LTC294X_REG_CONTROL_PRESCALER_SET(prescaler_exp) |
 				LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED;
-	/* Put the 2943 into "monitor" mode, so it measures every 10 sec */
-	if (info->num_regs == LTC2943_NUM_REGS)
+	/* Put device into "monitor" mode */
+	switch (info->num_regs) {
+	case LTC2942_NUM_REGS:	/* 2942 measures every 2 sec */
+		control |= LTC2942_REG_CONTROL_MODE_SCAN;
+		break;
+	case LTC2943_NUM_REGS:	/* 2943 measures every 10 sec */
 		control |= LTC2943_REG_CONTROL_MODE_SCAN;
+		break;
+	}
 
 	if (value != control) {
 		ret = ltc294x_write_regs(info->client,
@@ -251,7 +259,16 @@ static int ltc294x_get_voltage(const struct ltc294x_info *info, int *val)
 	ret = ltc294x_read_regs(info->client,
 		LTC294X_REG_VOLTAGE_MSB, &datar[0], 2);
 	value = (datar[0] << 8) | datar[1];
-	*val = ((value * 23600) / 0xFFFF) * 1000; /* in uV */
+	if (info->num_regs == LTC2943_NUM_REGS) {
+		value *= 23600 * 2;
+		value /= 0xFFFF;
+		value *= 1000 / 2;
+	} else {
+		value *= 6000 * 10;
+		value /= 0xFFFF;
+		value *= 1000 / 10;
+	}
+	*val = value;
 	return ret;
 }
 
@@ -274,15 +291,22 @@ static int ltc294x_get_current(const struct ltc294x_info *info, int *val)
 
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
 
@@ -356,8 +380,8 @@ static enum power_supply_property ltc294x_properties[] = {
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
 static int ltc294x_i2c_remove(struct i2c_client *client)
@@ -374,10 +398,11 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
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
@@ -420,21 +445,36 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
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
