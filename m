From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: [PATCH v6 2/3] power: supply: ltc2941-battery-gauge: Add LTC2942
 support
Date: Sun, 16 Jul 2017 11:34:00 +0200
Message-ID: <20170716093400.5l52et24ojux5hj4@lenoch>
References: <20170716093202.vfea4yylbzfec72v@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170716093202.vfea4yylbzfec72v@lenoch>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Dragos Bogdan <dragos.bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

LTC2942 is pin compatible with LTC2941 providing additional
informations about battery voltage and temperature. It can
be runtime detected using bit A7 in the Status register.

Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Changes:
 - v2: reworked voltage computing to not overflow and keep presision
 - v3: update devicetree binding documentation
 - v4: add ltc2942 devicetree compatible
 - v5: make use of info->id introduced in previous patch
 - v6: collect devicetree ack from Rob

 .../devicetree/bindings/power/supply/ltc2941.txt   | 15 ++--
 drivers/power/supply/ltc2941-battery-gauge.c       | 80 ++++++++++++++++++----
 2 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/ltc2941.txt b/Documentation/devicetree/bindings/power/supply/ltc2941.txt
index a9d7aa60558b..8ec10366295d 100644
--- a/Documentation/devicetree/bindings/power/supply/ltc2941.txt
+++ b/Documentation/devicetree/bindings/power/supply/ltc2941.txt
@@ -1,13 +1,14 @@
-binding for LTC2941 and LTC2943 battery gauges
+binding for LTC2941, LTC2942 and LTC2943 battery gauges
 
-Both the LTC2941 and LTC2943 measure battery capacity.
-The LTC2943 is compatible with the LTC2941, it adds voltage and
-temperature monitoring, and uses a slightly different conversion
-formula for the charge counter.
+All chips measure battery capacity.
+The LTC2942 is pin compatible with the LTC2941, it adds voltage and
+temperature monitoring, and is runtime detected. LTC2943 is software
+compatible, uses a slightly different conversion formula for the
+charge counter and adds voltage, current and temperature monitoring.
 
 Required properties:
-- compatible: Should contain "lltc,ltc2941" or "lltc,ltc2943" which also
-    indicates the type of I2C chip attached.
+- compatible: Should contain "lltc,ltc2941", "lltc,ltc2942" or "lltc,ltc2943"
+    which also indicates the type of I2C chip attached.
 - reg: The 7-bit I2C address.
 - lltc,resistor-sense: The sense resistor value in milli-ohms. Can be a 32-bit
     negative value when the battery has been connected to the wrong end of the
diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index b0de448a226b..42ff4e3daf35 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -1,5 +1,5 @@
 /*
- * I2C client/driver for the Linear Technology LTC2941 and LTC2943
+ * I2C client/driver for the Linear Technology LTC2941, LTC2942 and LTC2943
  * Battery Gas Gauge IC
  *
  * Copyright (C) 2014 Topic Embedded Systems
@@ -46,11 +46,14 @@ enum ltc294x_reg {
 
 enum ltc294x_id {
 	LTC2941_ID,
+	LTC2942_ID,
 	LTC2943_ID,
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
@@ -145,9 +148,17 @@ static int ltc294x_reset(const struct ltc294x_info *info, int prescaler_exp)
 
 	control = LTC294X_REG_CONTROL_PRESCALER_SET(prescaler_exp) |
 				LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED;
-	/* Put the 2943 into "monitor" mode, so it measures every 10 sec */
-	if (info->id == LTC2941_ID)
+	/* Put device into "monitor" mode */
+	switch (info->id) {
+	case LTC2942_ID:	/* 2942 measures every 2 sec */
+		control |= LTC2942_REG_CONTROL_MODE_SCAN;
+		break;
+	case LTC2943_ID:	/* 2943 measures every 10 sec */
 		control |= LTC2943_REG_CONTROL_MODE_SCAN;
+		break;
+	default:
+		break;
+	}
 
 	if (value != control) {
 		ret = ltc294x_write_regs(info->client,
@@ -252,7 +263,19 @@ static int ltc294x_get_voltage(const struct ltc294x_info *info, int *val)
 	ret = ltc294x_read_regs(info->client,
 		LTC294X_REG_VOLTAGE_MSB, &datar[0], 2);
 	value = (datar[0] << 8) | datar[1];
-	*val = ((value * 23600) / 0xFFFF) * 1000; /* in uV */
+	switch (info->id) {
+	case LTC2943_ID:
+		value *= 23600 * 2;
+		value /= 0xFFFF;
+		value *= 1000 / 2;
+		break;
+	default:
+		value *= 6000 * 10;
+		value /= 0xFFFF;
+		value *= 1000 / 10;
+		break;
+	}
+	*val = value;
 	return ret;
 }
 
@@ -275,15 +298,22 @@ static int ltc294x_get_current(const struct ltc294x_info *info, int *val)
 
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
+	if (info->id == LTC2942_ID) {
+		reg = LTC2942_REG_TEMPERATURE_MSB;
+		value = 60000;	/* Full-scale is 600 Kelvin */
+	} else {
+		reg = LTC2943_REG_TEMPERATURE_MSB;
+		value = 51000;	/* Full-scale is 510 Kelvin */
+	}
+	ret = ltc294x_read_regs(info->client, reg, &datar[0], 2);
+	value *= (datar[0] << 8) | datar[1];
+	/* Convert to centidegrees  */
+	*val = value / 0xFFFF - 27215;
 	return ret;
 }
 
@@ -375,10 +405,11 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
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
@@ -421,6 +452,20 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 				(128 / (1 << prescaler_exp));
 	}
 
+	/* Read status register to check for LTC2942 */
+	if (info->id == LTC2941_ID || info->id == LTC2942_ID) {
+		ret = ltc294x_read_regs(client, LTC294X_REG_STATUS, &status, 1);
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Could not read status register\n");
+			return ret;
+		}
+		if (status & LTC2941_REG_STATUS_CHIP_ID)
+			info->id = LTC2941_ID;
+		else
+			info->id = LTC2942_ID;
+	}
+
 	info->client = client;
 	info->supply_desc.type = POWER_SUPPLY_TYPE_BATTERY;
 	info->supply_desc.properties = ltc294x_properties;
@@ -429,6 +474,10 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 		info->supply_desc.num_properties =
 			ARRAY_SIZE(ltc294x_properties);
 		break;
+	case LTC2942_ID:
+		info->supply_desc.num_properties =
+			ARRAY_SIZE(ltc294x_properties) - 1;
+		break;
 	case LTC2941_ID:
 	default:
 		info->supply_desc.num_properties =
@@ -492,6 +541,7 @@ static SIMPLE_DEV_PM_OPS(ltc294x_pm_ops, ltc294x_suspend, ltc294x_resume);
 
 static const struct i2c_device_id ltc294x_i2c_id[] = {
 	{ "ltc2941", LTC2941_ID, },
+	{ "ltc2942", LTC2942_ID, },
 	{ "ltc2943", LTC2943_ID, },
 	{ },
 };
@@ -503,6 +553,10 @@ static const struct of_device_id ltc294x_i2c_of_match[] = {
 		.data = (void *)LTC2941_ID,
 	},
 	{
+		.compatible = "lltc,ltc2942",
+		.data = (void *)LTC2942_ID,
+	},
+	{
 		.compatible = "lltc,ltc2943",
 		.data = (void *)LTC2943_ID,
 	},
@@ -524,5 +578,5 @@ module_i2c_driver(ltc294x_driver);
 
 MODULE_AUTHOR("Auryn Verwegen, Topic Embedded Systems");
 MODULE_AUTHOR("Mike Looijmans, Topic Embedded Products");
-MODULE_DESCRIPTION("LTC2941/LTC2943 Battery Gas Gauge IC driver");
+MODULE_DESCRIPTION("LTC2941/LTC2942/LTC2943 Battery Gas Gauge IC driver");
 MODULE_LICENSE("GPL");
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
