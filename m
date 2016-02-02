From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v2] power: bq27xxx_battery: Restore device name
Date: Tue,  2 Feb 2016 14:47:37 +0200
Message-ID: <1454417257-10992-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <56B0A318.9060306@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36571 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406AbcBBMrq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 07:47:46 -0500
In-Reply-To: <56B0A318.9060306@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: pali.rohar@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Patch <703df6c097956d17a818e63961c82e8e9eef9fef> ("power: bq27xxx_battery:
 Reorganize I2C into a module") has removed the device name numbering from
bq27xxx_battery_i2c_probe. Fix that by restoring the code.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/power/bq27xxx_battery_i2c.c   | 37 ++++++++++++++++++++++++++++++++---
 include/linux/power/bq27xxx_battery.h |  1 +
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/power/bq27xxx_battery_i2c.c b/drivers/power/bq27xxx_battery_i2c.c
index b810e08..b8f8d3a 100644
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
@@ -70,19 +73,33 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
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
 
+	di->id = num;
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
@@ -103,6 +120,16 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
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
@@ -111,6 +138,10 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
 
 	bq27xxx_battery_teardown(di);
 
+	mutex_lock(&battery_mutex);
+	idr_remove(&battery_id, di->id);
+	mutex_unlock(&battery_mutex);
+
 	return 0;
 }
 
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 998d8f1..b50c049 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -49,6 +49,7 @@ struct bq27xxx_reg_cache {
 
 struct bq27xxx_device_info {
 	struct device *dev;
+	int id;
 	enum bq27xxx_chip chip;
 	const char *name;
 	struct bq27xxx_access_methods bus;
-- 
1.9.1

