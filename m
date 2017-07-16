From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v6 3/3] power: supply: ltc2941-battery-gauge: Add LTC2944
 support
Date: Sun, 16 Jul 2017 11:35:32 +0200
Message-ID: <20170716093532.w6sqqtadwnbroj3i@lenoch>
References: <20170716093202.vfea4yylbzfec72v@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:41740 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbdGPJfl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Jul 2017 05:35:41 -0400
Content-Disposition: inline
In-Reply-To: <20170716093202.vfea4yylbzfec72v@lenoch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Dragos Bogdan <dragos.bogdan@analog.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

From: Dragos Bogdan <dragos.bogdan@analog.com>

LTC2944 is compatible with LTC2943, but uses different
voltage and current computing constants.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 - v2: fixed voltage and current conversion
 - v3: skipped
 - v4: skipped
 - v5: fixed voltage conversion overflow, rebased on LTC2942 patchset
 - v6: fix missing break in the switch statement

 .../devicetree/bindings/power/supply/ltc2941.txt   | 12 +++++-----
 drivers/power/supply/ltc2941-battery-gauge.c       | 27 ++++++++++++++++++----
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/ltc2941.txt b/Documentation/devicetree/bindings/power/supply/ltc2941.txt
index 8ec10366295d..3b9ba147b041 100644
--- a/Documentation/devicetree/bindings/power/supply/ltc2941.txt
+++ b/Documentation/devicetree/bindings/power/supply/ltc2941.txt
@@ -1,14 +1,14 @@
-binding for LTC2941, LTC2942 and LTC2943 battery gauges
+binding for LTC2941, LTC2942, LTC2943 and LTC2944 battery gauges
 
 All chips measure battery capacity.
 The LTC2942 is pin compatible with the LTC2941, it adds voltage and
-temperature monitoring, and is runtime detected. LTC2943 is software
-compatible, uses a slightly different conversion formula for the
-charge counter and adds voltage, current and temperature monitoring.
+temperature monitoring, and is runtime detected. LTC2943 and LTC2944
+is software compatible, uses a slightly different conversion formula
+for the charge counter and adds voltage, current and temperature monitoring.
 
 Required properties:
-- compatible: Should contain "lltc,ltc2941", "lltc,ltc2942" or "lltc,ltc2943"
-    which also indicates the type of I2C chip attached.
+- compatible: Should contain "lltc,ltc2941", "lltc,ltc2942", "lltc,ltc2943"
+    or "lltc,ltc2944" which also indicates the type of I2C chip attached.
 - reg: The 7-bit I2C address.
 - lltc,resistor-sense: The sense resistor value in milli-ohms. Can be a 32-bit
     negative value when the battery has been connected to the wrong end of the
diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 42ff4e3daf35..08e4fd9ee607 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -1,6 +1,6 @@
 /*
- * I2C client/driver for the Linear Technology LTC2941, LTC2942 and LTC2943
- * Battery Gas Gauge IC
+ * I2C client/driver for the Linear Technology LTC2941, LTC2942, LTC2943
+ * and LTC2944 Battery Gas Gauge IC
  *
  * Copyright (C) 2014 Topic Embedded Systems
  *
@@ -48,6 +48,7 @@ enum ltc294x_id {
 	LTC2941_ID,
 	LTC2942_ID,
 	LTC2943_ID,
+	LTC2944_ID,
 };
 
 #define LTC2941_REG_STATUS_CHIP_ID	BIT(7)
@@ -153,7 +154,8 @@ static int ltc294x_reset(const struct ltc294x_info *info, int prescaler_exp)
 	case LTC2942_ID:	/* 2942 measures every 2 sec */
 		control |= LTC2942_REG_CONTROL_MODE_SCAN;
 		break;
-	case LTC2943_ID:	/* 2943 measures every 10 sec */
+	case LTC2943_ID:
+	case LTC2944_ID:	/* 2943 and 2944 measure every 10 sec */
 		control |= LTC2943_REG_CONTROL_MODE_SCAN;
 		break;
 	default:
@@ -269,6 +271,11 @@ static int ltc294x_get_voltage(const struct ltc294x_info *info, int *val)
 		value /= 0xFFFF;
 		value *= 1000 / 2;
 		break;
+	case LTC2944_ID:
+		value *= 70800 / 5*4;
+		value /= 0xFFFF;
+		value *= 1000 * 5/4;
+		break;
 	default:
 		value *= 6000 * 10;
 		value /= 0xFFFF;
@@ -289,10 +296,14 @@ static int ltc294x_get_current(const struct ltc294x_info *info, int *val)
 		LTC2943_REG_CURRENT_MSB, &datar[0], 2);
 	value = (datar[0] << 8) | datar[1];
 	value -= 0x7FFF;
+	if (info->id == LTC2944_ID)
+		value *= 64000;
+	else
+		value *= 60000;
 	/* Value is in range -32k..+32k, r_sense is usually 10..50 mOhm,
 	 * the formula below keeps everything in s32 range while preserving
 	 * enough digits */
-	*val = 1000 * ((60000 * value) / (info->r_sense * 0x7FFF)); /* in uA */
+	*val = 1000 * (value / (info->r_sense * 0x7FFF)); /* in uA */
 	return ret;
 }
 
@@ -470,6 +481,7 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	info->supply_desc.type = POWER_SUPPLY_TYPE_BATTERY;
 	info->supply_desc.properties = ltc294x_properties;
 	switch (info->id) {
+	case LTC2944_ID:
 	case LTC2943_ID:
 		info->supply_desc.num_properties =
 			ARRAY_SIZE(ltc294x_properties);
@@ -543,6 +555,7 @@ static const struct i2c_device_id ltc294x_i2c_id[] = {
 	{ "ltc2941", LTC2941_ID, },
 	{ "ltc2942", LTC2942_ID, },
 	{ "ltc2943", LTC2943_ID, },
+	{ "ltc2944", LTC2944_ID, },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);
@@ -560,6 +573,10 @@ static const struct of_device_id ltc294x_i2c_of_match[] = {
 		.compatible = "lltc,ltc2943",
 		.data = (void *)LTC2943_ID,
 	},
+	{
+		.compatible = "lltc,ltc2944",
+		.data = (void *)LTC2944_ID,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ltc294x_i2c_of_match);
@@ -578,5 +595,5 @@ module_i2c_driver(ltc294x_driver);
 
 MODULE_AUTHOR("Auryn Verwegen, Topic Embedded Systems");
 MODULE_AUTHOR("Mike Looijmans, Topic Embedded Products");
-MODULE_DESCRIPTION("LTC2941/LTC2942/LTC2943 Battery Gas Gauge IC driver");
+MODULE_DESCRIPTION("LTC2941/LTC2942/LTC2943/LTC2944 Battery Gas Gauge IC driver");
 MODULE_LICENSE("GPL");
-- 
2.11.0
