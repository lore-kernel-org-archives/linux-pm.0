From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: [PATCH v4 2/2] power: supply: ltc2941-battery-gauge: Add support for
 LTC2942
Date: Tue, 11 Jul 2017 15:00:20 +0200
Message-ID: <20170711130020.kfimnv6em3besr3j@lenoch>
References: <20170711125821.nt5opxjvbjcppiaw@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170711125821.nt5opxjvbjcppiaw@lenoch>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

LTC2942 is pin compatible with LTC2941 providing additional
informations about battery voltage and temperature. It can
be runtime detected using bit A7 in the Status register.

Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
---
 Changes:
 - v2: reworked voltage computing to not overflow and keep presision
 - v3: update devicetree binding documentation
 - v4: add ltc2942 devicetree compatible

 .../devicetree/bindings/power/supply/ltc2941.txt   | 15 ++--
 drivers/power/supply/ltc2941-battery-gauge.c       | 85 +++++++++++++++++-----
 2 files changed, 74 insertions(+), 26 deletions(-)

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
index 0a1b69bbca7f..c787c257451e 100644
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
@@ -420,21 +445,38 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 				(128 / (1 << prescaler_exp));
 	}
 
+	/* Read status register to check for LTC2942 */
+	if (info->num_regs != LTC2943_NUM_REGS) {
+		ret = ltc294x_read_regs(client, LTC294X_REG_STATUS, &status, 1);
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Could not read status register\n");
+			return ret;
+		}
+		if (status & LTC2941_REG_STATUS_CHIP_ID)
+			info->num_regs = LTC2941_NUM_REGS;
+		else
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
@@ -492,6 +534,7 @@ static SIMPLE_DEV_PM_OPS(ltc294x_pm_ops, ltc294x_suspend, ltc294x_resume);
 
 static const struct i2c_device_id ltc294x_i2c_id[] = {
 	{"ltc2941", LTC2941_NUM_REGS},
+	{"ltc2942", LTC2942_NUM_REGS},
 	{"ltc2943", LTC2943_NUM_REGS},
 	{ },
 };
@@ -503,6 +546,10 @@ static const struct of_device_id ltc294x_i2c_of_match[] = {
 		.data = (void *)LTC2941_NUM_REGS
 	},
 	{
+		.compatible = "lltc,ltc2942",
+		.data = (void *)LTC2942_NUM_REGS
+	},
+	{
 		.compatible = "lltc,ltc2943",
 		.data = (void *)LTC2943_NUM_REGS
 	},
@@ -524,5 +571,5 @@ module_i2c_driver(ltc294x_driver);
 
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
