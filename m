From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 3/3] power: supply: bq24190_charger: Make battery iface registraton conditional
Date: Wed, 12 Apr 2017 20:18:08 +0200
Message-ID: <20170412181808.31768-4-hdegoede@redhat.com>
References: <20170412181808.31768-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752369AbdDLSSQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Apr 2017 14:18:16 -0400
In-Reply-To: <20170412181808.31768-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

The TI bq24190 chip is purely a charger chip, as such it has very
little battery info to export to userspace and in practice it is almost
always used together with a separate fuel-gauge chip which does have
interesting info to export.

Since the userspace ABI requires there to be only 1 power_supply device
registered per physical battery, the limited battery power_supply device
the bq24190_charger driver is registering is actually getting in the way
of a fuel-gauge driver exporting more useful info.

This commit adds a check for a "disable-battery-power-supply-iface"
device-property which can be set by platform-code if it knows that
there will be a fuel-gauge which will supply a battery interface.

Cc: Liam Breck <kernel@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-This is a new patch in v2 of this patch-set
Changes in v3:
-Check for "disable-battery-power-supply-iface" device-property instead of
 completely removing the battery interface
Changes in v4:
-Rebase on top of current power-supply/next
---
 drivers/power/supply/bq24190_charger.c | 41 ++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index ad429b7..0c01f48 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1268,8 +1268,12 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
 
 	if (alert_charger)
 		power_supply_changed(bdi->charger);
-	if (alert_battery)
-		power_supply_changed(bdi->battery);
+	if (alert_battery) {
+		if (bdi->battery)
+			power_supply_changed(bdi->battery);
+		else
+			power_supply_changed(bdi->charger);
+	}
 
 	dev_dbg(bdi->dev, "ss_reg: 0x%02x, f_reg: 0x%02x\n", ss_reg, f_reg);
 }
@@ -1475,13 +1479,23 @@ static int bq24190_probe(struct i2c_client *client,
 		goto out_pmrt;
 	}
 
-	battery_cfg.drv_data = bdi;
-	bdi->battery = power_supply_register(dev, &bq24190_battery_desc,
-						&battery_cfg);
-	if (IS_ERR(bdi->battery)) {
-		dev_err(dev, "Can't register battery\n");
-		ret = PTR_ERR(bdi->battery);
-		goto out_charger;
+	/*
+	 * The disable-battery-power-supply-iface is purely a temporary in
+	 * kernel interface for platform-code to use if it knows that there
+	 * will be a fuel-gauge which will supply a battery interface. The long
+	 * term plan is for all properties to move to the charger interface
+	 * and for the battery interface to be removed completely.
+	 */
+	if (!device_property_read_bool(bdi->dev,
+				       "disable-battery-power-supply-iface")) {
+		battery_cfg.drv_data = bdi;
+		bdi->battery = power_supply_register(dev, &bq24190_battery_desc,
+						     &battery_cfg);
+		if (IS_ERR(bdi->battery)) {
+			dev_err(dev, "Can't register battery\n");
+			ret = PTR_ERR(bdi->battery);
+			goto out_charger;
+		}
 	}
 
 	ret = bq24190_sysfs_create_group(bdi);
@@ -1526,7 +1540,8 @@ static int bq24190_probe(struct i2c_client *client,
 	bq24190_sysfs_remove_group(bdi);
 
 out_battery:
-	power_supply_unregister(bdi->battery);
+	if (bdi->battery)
+		power_supply_unregister(bdi->battery);
 
 out_charger:
 	power_supply_unregister(bdi->charger);
@@ -1552,7 +1567,8 @@ static int bq24190_remove(struct i2c_client *client)
 	if (device_property_read_bool(bdi->dev, "reset-on-probe"))
 		bq24190_register_reset(bdi);
 	bq24190_sysfs_remove_group(bdi);
-	power_supply_unregister(bdi->battery);
+	if (bdi->battery)
+		power_supply_unregister(bdi->battery);
 	power_supply_unregister(bdi->charger);
 	if (error >= 0)
 		pm_runtime_put_sync(bdi->dev);
@@ -1642,7 +1658,8 @@ static __maybe_unused int bq24190_pm_resume(struct device *dev)
 
 	/* Things may have changed while suspended so alert upper layer */
 	power_supply_changed(bdi->charger);
-	power_supply_changed(bdi->battery);
+	if (bdi->battery)
+		power_supply_changed(bdi->battery);
 
 	return 0;
 }
-- 
2.9.3
