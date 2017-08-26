From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v3 3/5] power: bq24190_charger: Enable devicetree config
Date: Fri, 25 Aug 2017 22:14:11 -0700
Message-ID: <20170826051413.24569-4-liam@networkimprov.net>
References: <20170826051413.24569-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36028 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbdHZFOv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Aug 2017 01:14:51 -0400
Received: by mail-pg0-f66.google.com with SMTP id 83so2137180pgb.3
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2017 22:14:51 -0700 (PDT)
In-Reply-To: <20170826051413.24569-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Add get_config(). Rename set_mode_host() to set_config().
Call get_config() and hw_init() after power_supply_register().
No functional changes.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq24190_charger.c | 63 +++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 40b4bba7..c6be00d7 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -504,15 +504,7 @@ static int bq24190_sysfs_create_group(struct bq24190_dev_info *bdi)
 static inline void bq24190_sysfs_remove_group(struct bq24190_dev_info *bdi) {}
 #endif
 
-/*
- * According to the "Host Mode and default Mode" section of the
- * manual, a write to any register causes the bq24190 to switch
- * from default mode to host mode.  It will switch back to default
- * mode after a WDT timeout unless the WDT is turned off as well.
- * So, by simply turning off the WDT, we accomplish both with the
- * same write.
- */
-static int bq24190_set_mode_host(struct bq24190_dev_info *bdi)
+static int bq24190_set_config(struct bq24190_dev_info *bdi)
 {
 	int ret;
 	u8 v;
@@ -523,9 +515,22 @@ static int bq24190_set_mode_host(struct bq24190_dev_info *bdi)
 
 	bdi->watchdog = ((v & BQ24190_REG_CTTC_WATCHDOG_MASK) >>
 					BQ24190_REG_CTTC_WATCHDOG_SHIFT);
+
+	/*
+	 * According to the "Host Mode and default Mode" section of the
+	 * manual, a write to any register causes the bq24190 to switch
+	 * from default mode to host mode.  It will switch back to default
+	 * mode after a WDT timeout unless the WDT is turned off as well.
+	 * So, by simply turning off the WDT, we accomplish both with the
+	 * same write.
+	 */
 	v &= ~BQ24190_REG_CTTC_WATCHDOG_MASK;
 
-	return bq24190_write(bdi, BQ24190_REG_CTTC, v);
+	ret = bq24190_write(bdi, BQ24190_REG_CTTC, v);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int bq24190_register_reset(struct bq24190_dev_info *bdi)
@@ -1456,13 +1461,25 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 	if (ret < 0)
 		return ret;
 
-	ret = bq24190_set_mode_host(bdi);
+	ret = bq24190_set_config(bdi);
 	if (ret < 0)
 		return ret;
 
 	return bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
 }
 
+static int bq24190_get_config(struct bq24190_dev_info *bdi)
+{
+#ifdef CONFIG_OF
+	int v;
+
+	if (!bdi->dev->of_node)
+		return -EINVAL;
+
+#endif
+	return 0;
+}
+
 static int bq24190_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
@@ -1493,7 +1510,7 @@ static int bq24190_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, bdi);
 
-	if (!client->irq) {
+	if (client->irq <= 0) {
 		dev_err(dev, "Can't get irq info\n");
 		return -EINVAL;
 	}
@@ -1526,12 +1543,6 @@ static int bq24190_probe(struct i2c_client *client,
 		goto out_pmrt;
 	}
 
-	ret = bq24190_hw_init(bdi);
-	if (ret < 0) {
-		dev_err(dev, "Hardware init failed\n");
-		goto out_pmrt;
-	}
-
 	charger_cfg.drv_data = bdi;
 	charger_cfg.supplied_to = bq24190_charger_supplied_to;
 	charger_cfg.num_supplicants = ARRAY_SIZE(bq24190_charger_supplied_to),
@@ -1556,8 +1567,20 @@ static int bq24190_probe(struct i2c_client *client,
 		}
 	}
 
+	ret = bq24190_get_config(bdi);
+	if (ret < 0) {
+		dev_err(dev, "Can't get devicetree config\n");
+		goto out_charger;
+	}
+
+	ret = bq24190_hw_init(bdi);
+	if (ret < 0) {
+		dev_err(dev, "Hardware init failed\n");
+		goto out_charger;
+	}
+
 	ret = bq24190_sysfs_create_group(bdi);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(dev, "Can't create sysfs entries\n");
 		goto out_charger;
 	}
@@ -1700,7 +1723,7 @@ static __maybe_unused int bq24190_pm_resume(struct device *dev)
 	}
 
 	bq24190_register_reset(bdi);
-	bq24190_set_mode_host(bdi);
+	bq24190_set_config(bdi);
 	bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
 
 	if (error >= 0) {
-- 
2.13.2
