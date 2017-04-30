From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 1/5] power: supply: bq27xxx: Pass of_node along to allow device-tree supply
Date: Sun, 30 Apr 2017 20:27:23 +0200
Message-ID: <20170430182727.24412-1-contact@paulk.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:49302 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969105AbdD3S2l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Apr 2017 14:28:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>, Paul Kocialkowski <contact@paulk.fr>

This passes the of_node from the bq27xxx i2c battery driver to the
common code, so that it can be registered and provide external supplies
linked with device-tree.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/power/supply/bq27xxx_battery.c     | 5 ++++-
 drivers/power/supply/bq27xxx_battery_i2c.c | 1 +
 include/linux/power/bq27xxx_battery.h      | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 398801a21b86..6ef95442a918 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1351,7 +1351,10 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 {
 	struct power_supply_desc *psy_desc;
-	struct power_supply_config psy_cfg = { .drv_data = di, };
+	struct power_supply_config psy_cfg = {};
+
+	psy_cfg.drv_data = di;
+	psy_cfg.of_node = di->of_node;
 
 	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
 	mutex_init(&di->lock);
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index c68fbc3fe50a..38a0422a4192 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -96,6 +96,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 	di->chip = id->driver_data;
 	di->name = name;
 	di->bus.read = bq27xxx_battery_i2c_read;
+	di->of_node = client->dev.of_node;
 
 	ret = bq27xxx_battery_setup(di);
 	if (ret)
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index b312bcef53da..94637b77ecbf 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -63,6 +63,7 @@ struct bq27xxx_device_info {
 	const char *name;
 	struct bq27xxx_access_methods bus;
 	struct bq27xxx_reg_cache cache;
+	struct device_node *of_node;
 	int charge_design_full;
 	unsigned long last_update;
 	struct delayed_work work;
-- 
2.12.2
