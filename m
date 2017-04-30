From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 3/5] power: supply: bq27xxx: Rename work structure member to poll_work
Date: Sun, 30 Apr 2017 20:27:25 +0200
Message-ID: <20170430182727.24412-3-contact@paulk.fr>
References: <20170430182727.24412-1-contact@paulk.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:55279 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969105AbdD3S25 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Apr 2017 14:28:57 -0400
In-Reply-To: <20170430182727.24412-1-contact@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>, Paul Kocialkowski <contact@paulk.fr>

This renames the work structure member to poll_work, in anticipation
of the introduction of a status_work member used to detect status
changes.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/power/supply/bq27xxx_battery.c     | 20 ++++++++++----------
 drivers/power/supply/bq27xxx_battery_i2c.c |  2 +-
 include/linux/power/bq27xxx_battery.h      |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index be476e0bc85d..926bd58344d9 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -769,8 +769,8 @@ static int poll_interval_param_set(const char *val, const struct kernel_param *k
 
 	mutex_lock(&bq27xxx_list_lock);
 	list_for_each_entry(di, &bq27xxx_battery_devices, list) {
-		cancel_delayed_work_sync(&di->work);
-		schedule_delayed_work(&di->work, 0);
+		cancel_delayed_work_sync(&di->poll_work);
+		schedule_delayed_work(&di->poll_work, 0);
 	}
 	mutex_unlock(&bq27xxx_list_lock);
 
@@ -1126,12 +1126,12 @@ static void bq27xxx_battery_poll(struct work_struct *work)
 {
 	struct bq27xxx_device_info *di =
 			container_of(work, struct bq27xxx_device_info,
-				     work.work);
+				     poll_work.work);
 
 	bq27xxx_battery_update(di);
 
 	if (poll_interval > 0)
-		schedule_delayed_work(&di->work, poll_interval * HZ);
+		schedule_delayed_work(&di->poll_work, poll_interval * HZ);
 }
 
 /*
@@ -1265,8 +1265,8 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 
 	mutex_lock(&di->lock);
 	if (time_is_before_jiffies(di->last_update + 5 * HZ)) {
-		cancel_delayed_work_sync(&di->work);
-		bq27xxx_battery_poll(&di->work.work);
+		cancel_delayed_work_sync(&di->poll_work);
+		bq27xxx_battery_poll(&di->poll_work.work);
 	}
 	mutex_unlock(&di->lock);
 
@@ -1344,8 +1344,8 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 {
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
 
-	cancel_delayed_work_sync(&di->work);
-	schedule_delayed_work(&di->work, 0);
+	cancel_delayed_work_sync(&di->poll_work);
+	schedule_delayed_work(&di->poll_work, 0);
 }
 
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
@@ -1356,7 +1356,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	psy_cfg.drv_data = di;
 	psy_cfg.of_node = di->of_node;
 
-	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
+	INIT_DELAYED_WORK(&di->poll_work, bq27xxx_battery_poll);
 	mutex_init(&di->lock);
 	di->regs = bq27xxx_regs[di->chip];
 
@@ -1399,7 +1399,7 @@ void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 	 */
 	poll_interval = 0;
 
-	cancel_delayed_work_sync(&di->work);
+	cancel_delayed_work_sync(&di->poll_work);
 
 	power_supply_unregister(di->bat);
 
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 38a0422a4192..1b2ad22190ae 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -103,7 +103,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 		goto err_failed;
 
 	/* Schedule a polling after about 1 min */
-	schedule_delayed_work(&di->work, 60 * HZ);
+	schedule_delayed_work(&di->poll_work, 60 * HZ);
 
 	i2c_set_clientdata(client, di);
 
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 94637b77ecbf..0a9af513165a 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -66,7 +66,7 @@ struct bq27xxx_device_info {
 	struct device_node *of_node;
 	int charge_design_full;
 	unsigned long last_update;
-	struct delayed_work work;
+	struct delayed_work poll_work;
 	struct power_supply *bat;
 	struct list_head list;
 	struct mutex lock;
-- 
2.12.2
