From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v5 8/9] power: supply: sbs-battery: Add alert callback
Date: Mon,  1 May 2017 16:49:58 +0800
Message-ID: <1493628599-30552-9-git-send-email-preid@electromag.com.au>
References: <1493628599-30552-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1493628599-30552-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, peda@axentia.se, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

To simplify the sbs-manager code and notification of battery removal
use the i2c alert callback to notify the sbs-battery driver that an
event has occurred.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/power/supply/sbs-battery.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 8bb2eb3..a719892 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -675,21 +675,30 @@ static int sbs_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static irqreturn_t sbs_irq(int irq, void *devid)
+static void sbs_supply_changed(struct sbs_info *chip)
 {
-	struct sbs_info *chip = devid;
 	struct power_supply *battery = chip->power_supply;
 	int ret;
 
 	ret = gpiod_get_value_cansleep(chip->gpio_detect);
 	if (ret < 0)
-		return ret;
+		return;
 	chip->is_present = ret;
 	power_supply_changed(battery);
+}
 
+static irqreturn_t sbs_irq(int irq, void *devid)
+{
+	sbs_supply_changed(devid);
 	return IRQ_HANDLED;
 }
 
+static void sbs_alert(struct i2c_client *client, enum i2c_alert_protocol prot,
+	unsigned int data)
+{
+	sbs_supply_changed(i2c_get_clientdata(client));
+}
+
 static void sbs_external_power_changed(struct power_supply *psy)
 {
 	struct sbs_info *chip = power_supply_get_drvdata(psy);
@@ -917,6 +926,7 @@ static int sbs_suspend(struct device *dev)
 static struct i2c_driver sbs_battery_driver = {
 	.probe		= sbs_probe,
 	.remove		= sbs_remove,
+	.alert		= sbs_alert,
 	.id_table	= sbs_id,
 	.driver = {
 		.name	= "sbs-battery",
-- 
1.8.3.1
