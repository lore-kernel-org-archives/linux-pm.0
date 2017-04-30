From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 4/5] power: supply: bq27xxx: Look for status change on external power change
Date: Sun, 30 Apr 2017 20:27:26 +0200
Message-ID: <20170430182727.24412-4-contact@paulk.fr>
References: <20170430182727.24412-1-contact@paulk.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170430182727.24412-1-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>, Paul Kocialkowski <contact@paulk.fr>
List-Id: linux-pm@vger.kernel.org

This introduces a dedicated status change work to look for power
status change. It is triggered by external power change notifications
and periodically retries detecting a power status change for 5 seconds.

This is largely inspired by a similar mechanism from the sbs-battery
driver.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/power/supply/bq27xxx_battery.c | 38 ++++++++++++++++++++++++++++++++--
 include/linux/power/bq27xxx_battery.h  |  3 +++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 926bd58344d9..cade00df6162 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1190,6 +1190,11 @@ static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
 			status = POWER_SUPPLY_STATUS_CHARGING;
 	}
 
+	if (di->status_retry == 0 && di->status_change_reference != status) {
+		di->status_change_reference = status;
+		power_supply_changed(di->bat);
+	}
+
 	val->intval = status;
 
 	return 0;
@@ -1340,12 +1345,38 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
+static void bq27xxx_status_change(struct work_struct *work)
+{
+	struct bq27xxx_device_info *di =
+			container_of(work, struct bq27xxx_device_info,
+				     status_work.work);
+	union power_supply_propval val;
+	int ret;
+
+	bq27xxx_battery_update(di);
+
+	ret = bq27xxx_battery_status(di, &val);
+	if (ret < 0)
+		return;
+
+	if (di->status_change_reference != val.intval) {
+		di->status_change_reference = val.intval;
+		power_supply_changed(di->bat);
+	}
+
+	if (di->status_retry > 0) {
+		di->status_retry--;
+		schedule_delayed_work(&di->status_work, HZ);
+	}
+}
+
 static void bq27xxx_external_power_changed(struct power_supply *psy)
 {
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
 
-	cancel_delayed_work_sync(&di->poll_work);
-	schedule_delayed_work(&di->poll_work, 0);
+	cancel_delayed_work_sync(&di->status_work);
+	schedule_delayed_work(&di->status_work, HZ);
+	di->status_retry = 5;
 }
 
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
@@ -1357,8 +1388,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	psy_cfg.of_node = di->of_node;
 
 	INIT_DELAYED_WORK(&di->poll_work, bq27xxx_battery_poll);
+	INIT_DELAYED_WORK(&di->status_work, bq27xxx_status_change);
 	mutex_init(&di->lock);
 	di->regs = bq27xxx_regs[di->chip];
+	di->status_change_reference = POWER_SUPPLY_STATUS_UNKNOWN;
 
 	psy_desc = devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
 	if (!psy_desc)
@@ -1400,6 +1433,7 @@ void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 	poll_interval = 0;
 
 	cancel_delayed_work_sync(&di->poll_work);
+	cancel_delayed_work_sync(&di->status_work);
 
 	power_supply_unregister(di->bat);
 
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 0a9af513165a..16d604681ace 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -67,6 +67,9 @@ struct bq27xxx_device_info {
 	int charge_design_full;
 	unsigned long last_update;
 	struct delayed_work poll_work;
+	struct delayed_work status_work;
+	int status_retry;
+	int status_change_reference;
 	struct power_supply *bat;
 	struct list_head list;
 	struct mutex lock;
-- 
2.12.2
