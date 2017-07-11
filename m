From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: [PATCH v4 1/2] power: supply: ltc2941-battery-gauge: Define LTC2942
 registers
Date: Tue, 11 Jul 2017 14:59:44 +0200
Message-ID: <20170711125944.yvzdcmmrbcmtl36m@lenoch>
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

In order to support LTC2942 which has temperature registers
at different offsets than LTC2943 use following register naming
scheme (prefixes):
- LTC294X_ common registers
- LTC2942_ chips specific registers
- LTC2943_ specific registers
There are no functional changes.

Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
---
 Changes:
 - v2: None
 - v3: Extend commit message
 - v4: None

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
