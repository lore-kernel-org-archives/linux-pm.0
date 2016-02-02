From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] power: bq27xxx_battery: Restore device name
Date: Tue,  2 Feb 2016 14:15:19 +0200
Message-ID: <1454415319-31380-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36044 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831AbcBBMPw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 07:15:52 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: pali.rohar@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Patch <703df6c097956d17a818e63961c82e8e9eef9fef> ("power: bq27xxx_battery:
 Reorganize I2C into a module") has removed the device name numbering from
bq27xxx_battery_i2c_probe. Fix that by restoring the code.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/power/bq27xxx_battery_i2c.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/power/bq27xxx_battery_i2c.c b/drivers/power/bq27xxx_battery_i2c.c
index b810e08..d98cdc5 100644
--- a/drivers/power/bq27xxx_battery_i2c.c
+++ b/drivers/power/bq27xxx_battery_i2c.c
@@ -21,6 +21,9 @@
 
 #include <linux/power/bq27xxx_battery.h>
 
+static DEFINE_IDR(battery_id);
+static DEFINE_MUTEX(battery_mutex);
+
 static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *data)
 {
 	struct bq27xxx_device_info *di = data;
@@ -70,19 +73,32 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 {
 	struct bq27xxx_device_info *di;
 	int ret;
+	char *name;
+	int num;
+
+	/* Get new ID for the new battery device */
+	mutex_lock(&battery_mutex);
+	num = idr_alloc(&battery_id, client, 0, 0, GFP_KERNEL);
+	mutex_unlock(&battery_mutex);
+	if (num < 0)
+		return num;
+
+	name = devm_kasprintf(&client->dev, GFP_KERNEL, "%s-%d", id->name, num);
+	if (!name)
+		goto err_mem;
 
 	di = devm_kzalloc(&client->dev, sizeof(*di), GFP_KERNEL);
 	if (!di)
-		return -ENOMEM;
+		goto err_mem;
 
 	di->dev = &client->dev;
 	di->chip = id->driver_data;
-	di->name = id->name;
+	di->name = name;
 	di->bus.read = bq27xxx_battery_i2c_read;
 
 	ret = bq27xxx_battery_setup(di);
 	if (ret)
-		return ret;
+		goto err_failed;
 
 	/* Schedule a polling after about 1 min */
 	schedule_delayed_work(&di->work, 60 * HZ);
@@ -103,6 +119,16 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 	}
 
 	return 0;
+
+err_mem:
+	ret = -ENOMEM;
+
+err_failed:
+	mutex_lock(&battery_mutex);
+	idr_remove(&battery_id, num);
+	mutex_unlock(&battery_mutex);
+
+	return ret;
 }
 
 static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
-- 
1.9.1

