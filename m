From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] power: ltc2941-battery-gauge: Disable continuous monitoring on shutdown
Date: Thu, 23 Nov 2017 15:41:05 +0100
Message-ID: <1511448065-2727-1-git-send-email-mike.looijmans@topic.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, sre@kernel.org
Cc: linux-kernel@vger.kernel.org, ladis@linux-mips.org, Dragos.Bogdan@analog.com, Mike Looijmans <mike.looijmans@topic.nl>
List-Id: linux-pm@vger.kernel.org

The driver sets the fuel gauge to continuous monitoring on startup, for
the models that support this. When the board shuts down, the chip remains
in that mode, causing a few mA drain on the battery every 2 or 10 seconds.

This patch registers a shutdown handler that turns off the monitoring to
prevent this battery drain.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/power/supply/ltc2941-battery-gauge.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 08e4fd9..4cfa3f0 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -60,6 +60,7 @@ enum ltc294x_id {
 #define LTC294X_REG_CONTROL_PRESCALER_SET(x) \
 	((x << 3) & LTC294X_REG_CONTROL_PRESCALER_MASK)
 #define LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED	0
+#define LTC294X_REG_CONTROL_ADC_DISABLE(x)	((x) & ~(BIT(7) | BIT(6)))
 
 struct ltc294x_info {
 	struct i2c_client *client;	/* I2C Client pointer */
@@ -523,6 +524,29 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	return 0;
 }
 
+static void ltc294x_i2c_shutdown(struct i2c_client *client)
+{
+	struct ltc294x_info *info = i2c_get_clientdata(client);
+	int ret;
+	u8 value;
+	u8 control;
+
+	/* The LTC2941 does not need any special handling */
+	if (info->id == LTC2941_ID)
+		return;
+
+	/* Read control register */
+	ret = ltc294x_read_regs(info->client, LTC294X_REG_CONTROL, &value, 1);
+	if (ret < 0)
+		return;
+
+	/* Disable continuous ADC conversion as this drains the battery */
+	control = LTC294X_REG_CONTROL_ADC_DISABLE(value);
+	if (control != value)
+		ltc294x_write_regs(info->client, LTC294X_REG_CONTROL,
+			&control, 1);
+}
+
 #ifdef CONFIG_PM_SLEEP
 
 static int ltc294x_suspend(struct device *dev)
@@ -589,6 +613,7 @@ static int ltc294x_resume(struct device *dev)
 	},
 	.probe		= ltc294x_i2c_probe,
 	.remove		= ltc294x_i2c_remove,
+	.shutdown	= ltc294x_i2c_shutdown,
 	.id_table	= ltc294x_i2c_id,
 };
 module_i2c_driver(ltc294x_driver);
-- 
1.9.1
