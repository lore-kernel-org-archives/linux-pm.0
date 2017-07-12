From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v5 3/3] power: supply: ltc2941-battery-gauge: Add LTC2944
 support
Date: Wed, 12 Jul 2017 03:12:27 +0200
Message-ID: <20170712011227.jpc5zhotxg4iqjlx@lenoch>
References: <20170712010758.66jx54qbdjfyt6x6@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:49890 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754675AbdGLBMa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 21:12:30 -0400
Content-Disposition: inline
In-Reply-To: <20170712010758.66jx54qbdjfyt6x6@lenoch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Dragos Bogdan <dragos.bogdan@analog.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

From: Dragos Bogdan <dragos.bogdan@analog.com>

LTC2944 is compatible with LTC2943, but used different
voltage and current computing constants.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
[ladis: fix voltage conversion, rebase on LTC2942 patchset]
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Dragos, LTC2944 datasheet states 500K full range temperature,
 but the rest of paragraph is the same as in LTC2943 datasheet
 (LTC2943 is using 510K full range). As Linear was recently accuired
 by Analog, please ask for the truth there, so we can write it
 into code comment. Thank you!
 http://cds.linear.com/docs/en/datasheet/2943fa.pdf
 http://cds.linear.com/docs/en/datasheet/2944f.pdf
 both on pdf page 15

 Changes:
 - v2: fixed voltage and current conversion
 - v3: skipped
 - v4: skipped
 - v5: fixed voltage conversion overflow, rebased on LTC2942 patchset

 .../devicetree/bindings/power/supply/ltc2941.txt   | 12 +++++------
 drivers/power/supply/ltc2941-battery-gauge.c       | 24 +++++++++++++++++-----
 2 files changed, 25 insertions(+), 11 deletions(-)

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
index f67fa8d8009e..b257ec943041 100644
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
@@ -154,7 +154,8 @@ static int ltc294x_reset(const struct ltc294x_info *info, int prescaler_exp)
 	case LTC2942_ID:	/* 2942 measures every 2 sec */
 		control |= LTC2942_REG_CONTROL_MODE_SCAN;
 		break;
-	case LTC2943_ID:	/* 2943 measures every 10 sec */
+	case LTC2943_ID:
+	case LTC2944_ID:	/* 2943 and 2944 measure every 10 sec */
 		control |= LTC2943_REG_CONTROL_MODE_SCAN;
 		break;
 	default:
@@ -270,6 +271,10 @@ static int ltc294x_get_voltage(const struct ltc294x_info *info, int *val)
 		value /= 0xFFFF;
 		value *= 1000 / 2;
 		break;
+	case LTC2944_ID:
+		value *= 70800 / 5*4;
+		value /= 0xFFFF;
+		value *= 1000 * 5/4;
 	default:
 		value *= 6000 * 10;
 		value /= 0xFFFF;
@@ -290,10 +295,14 @@ static int ltc294x_get_current(const struct ltc294x_info *info, int *val)
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
 
@@ -545,6 +554,7 @@ static const struct i2c_device_id ltc294x_i2c_id[] = {
 	{ "ltc2941", LTC2941_ID, },
 	{ "ltc2942", LTC2942_ID, },
 	{ "ltc2943", LTC2943_ID, },
+	{ "ltc2944", LTC2944_ID, },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);
@@ -562,6 +572,10 @@ static const struct of_device_id ltc294x_i2c_of_match[] = {
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
@@ -580,5 +594,5 @@ module_i2c_driver(ltc294x_driver);
 
 MODULE_AUTHOR("Auryn Verwegen, Topic Embedded Systems");
 MODULE_AUTHOR("Mike Looijmans, Topic Embedded Products");
-MODULE_DESCRIPTION("LTC2941/LTC2942/LTC2943 Battery Gas Gauge IC driver");
+MODULE_DESCRIPTION("LTC2941/LTC2942/LTC2943/LTC2944 Battery Gas Gauge IC driver");
 MODULE_LICENSE("GPL");
-- 
2.11.0
