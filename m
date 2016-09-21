From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v5 5/6] power: supply: sbs-battery: Add alert callback.
Date: Wed, 21 Sep 2016 16:41:13 +0800
Message-ID: <1474447274-90821-6-git-send-email-preid@electromag.com.au>
References: <1474447274-90821-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:37112 "EHLO
        preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754523AbcIUIl2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2016 04:41:28 -0400
In-Reply-To: <1474447274-90821-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, andrea.merello@gmail.com, preid@electromag.com.au, karl-heinz@schneider-inet.de, arnd@arndb.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

To simplify the sbs-manager code and notification of battery removal
use the i2c alert callback to notify the sbs-battery driver that an
event has occurred.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/power/supply/sbs-battery.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index d15ce9e..b1284e6 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -674,21 +674,30 @@ done:
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
 
+void sbs_alert(struct i2c_client *client, enum i2c_alert_protocol prot,
+	unsigned int data)
+{
+	sbs_supply_changed(i2c_get_clientdata(client));
+}
+
 static void sbs_external_power_changed(struct power_supply *psy)
 {
 	struct sbs_info *chip = power_supply_get_drvdata(psy);
@@ -916,6 +925,7 @@ MODULE_DEVICE_TABLE(of, sbs_dt_ids);
 static struct i2c_driver sbs_battery_driver = {
 	.probe		= sbs_probe,
 	.remove		= sbs_remove,
+	.alert		= sbs_alert,
 	.id_table	= sbs_id,
 	.driver = {
 		.name	= "sbs-battery",
-- 
1.8.3.1

