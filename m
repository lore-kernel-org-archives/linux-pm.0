From: Dragos Bogdan <dragos.bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] power: supply: ltc2941-battery-gauge: Add LTC2944 support
Date: Tue, 11 Jul 2017 17:05:09 +0300
Message-ID: <20170711140509.31346-1-dragos.bogdan@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dragos Bogdan <dragos.bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The only difference between the already supported LTC2943 and LTC2944 is the
operating range (3.6V - 20V compared to 3.6V - 60V).

Signed-off-by: Dragos Bogdan <dragos.bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/power/supply/ltc2941.txt | 10 +++++-----
 drivers/power/supply/ltc2941-battery-gauge.c               | 11 ++++++++---
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/ltc2941.txt b/Documentation/devicetree/bindings/power/supply/ltc2941.txt
index a9d7aa60558b..ed0f02846d10 100644
--- a/Documentation/devicetree/bindings/power/supply/ltc2941.txt
+++ b/Documentation/devicetree/bindings/power/supply/ltc2941.txt
@@ -1,9 +1,9 @@
-binding for LTC2941 and LTC2943 battery gauges
+binding for LTC2941, LTC2943 and LTC2944 battery gauges
 
-Both the LTC2941 and LTC2943 measure battery capacity.
-The LTC2943 is compatible with the LTC2941, it adds voltage and
-temperature monitoring, and uses a slightly different conversion
-formula for the charge counter.
+All the LTC2941, LTC2943 and LTC2944 measure battery capacity.
+The LTC2943 and LTC2944 are compatible with the LTC2941, they add voltage and
+temperature monitoring, and use a slightly different conversion formula for the
+charge counter.
 
 Required properties:
 - compatible: Should contain "lltc,ltc2941" or "lltc,ltc2943" which also
diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 7efb908f4451..48af7b6fb704 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -1,5 +1,5 @@
 /*
- * I2C client/driver for the Linear Technology LTC2941 and LTC2943
+ * I2C client/driver for the Linear Technology LTC2941, LTC2943 and LTC2944
  * Battery Gas Gauge IC
  *
  * Copyright (C) 2014 Topic Embedded Systems
@@ -145,7 +145,7 @@ static int ltc294x_reset(const struct ltc294x_info *info, int prescaler_exp)
 
 	control = LTC294X_REG_CONTROL_PRESCALER_SET(prescaler_exp) |
 				LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED;
-	/* Put the 2943 into "monitor" mode, so it measures every 10 sec */
+	/* Put the 2943/4 into "monitor" mode, so it measures every 10 sec */
 	if (info->num_regs == LTC2943_NUM_REGS)
 		control |= LTC2943_REG_CONTROL_MODE_SCAN;
 
@@ -494,6 +494,7 @@ static SIMPLE_DEV_PM_OPS(ltc294x_pm_ops, ltc294x_suspend, ltc294x_resume);
 static const struct i2c_device_id ltc294x_i2c_id[] = {
 	{"ltc2941", LTC2941_NUM_REGS},
 	{"ltc2943", LTC2943_NUM_REGS},
+	{"ltc2944", LTC2943_NUM_REGS},
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);
@@ -507,6 +508,10 @@ static const struct of_device_id ltc294x_i2c_of_match[] = {
 		.compatible = "lltc,ltc2943",
 		.data = (void *)LTC2943_NUM_REGS
 	},
+	{
+		.compatible = "lltc,ltc2944",
+		.data = (void *)LTC2943_NUM_REGS
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ltc294x_i2c_of_match);
@@ -525,5 +530,5 @@ module_i2c_driver(ltc294x_driver);
 
 MODULE_AUTHOR("Auryn Verwegen, Topic Embedded Systems");
 MODULE_AUTHOR("Mike Looijmans, Topic Embedded Products");
-MODULE_DESCRIPTION("LTC2941/LTC2943 Battery Gas Gauge IC driver");
+MODULE_DESCRIPTION("LTC2941/LTC2943/LTC2944 Battery Gas Gauge IC driver");
 MODULE_LICENSE("GPL");
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
