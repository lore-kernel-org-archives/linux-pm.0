From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] power/ltc2941-battery-gauge.c: Use the devicetree node name as supply name
Date: Wed,  1 Jul 2015 11:40:53 +0200
Message-ID: <1435743653-13967-1-git-send-email-mike.looijmans@topic.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: sre@kernel.org, linux-kernel@vger.kernel.org, mike.looijmans@topic.nl
List-Id: linux-pm@vger.kernel.org

Make it possible to set the name of the supply from the devicetree.
Like other power supply drivers just use the node name. This makes
the code smaller as well, as it doesn't need to allocate memory to
hold the name and allocate a unique ID.

Functionally tested on 4.0 kernel, only compile-tested on mainline.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/power/ltc2941-battery-gauge.c | 54 ++++++-----------------------------
 1 file changed, 8 insertions(+), 46 deletions(-)

diff --git a/drivers/power/ltc2941-battery-gauge.c b/drivers/power/ltc2941-battery-gauge.c
index daeb086..4adf2ba 100644
--- a/drivers/power/ltc2941-battery-gauge.c
+++ b/drivers/power/ltc2941-battery-gauge.c
@@ -14,7 +14,6 @@
 #include <linux/swab.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
-#include <linux/idr.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
 
@@ -63,15 +62,11 @@ struct ltc294x_info {
 	struct power_supply_desc supply_desc;	/* Supply description */
 	struct delayed_work work;	/* Work scheduler */
 	int num_regs;	/* Number of registers (chip type) */
-	int id;		/* Identifier of ltc294x chip */
 	int charge;	/* Last charge register content */
 	int r_sense;	/* mOhm */
 	int Qlsb;	/* nAh */
 };
 
-static DEFINE_IDR(ltc294x_id);
-static DEFINE_MUTEX(ltc294x_lock);
-
 static inline int convert_bin_to_uAh(
 	const struct ltc294x_info *info, int Q)
 {
@@ -371,10 +366,6 @@ static int ltc294x_i2c_remove(struct i2c_client *client)
 
 	cancel_delayed_work(&info->work);
 	power_supply_unregister(info->supply);
-	kfree(info->supply_desc.name);
-	mutex_lock(&ltc294x_lock);
-	idr_remove(&ltc294x_id, info->id);
-	mutex_unlock(&ltc294x_lock);
 	return 0;
 }
 
@@ -384,44 +375,28 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	struct power_supply_config psy_cfg = {};
 	struct ltc294x_info *info;
 	int ret;
-	int num;
 	u32 prescaler_exp;
 	s32 r_sense;
 	struct device_node *np;
 
-	mutex_lock(&ltc294x_lock);
-	ret = idr_alloc(&ltc294x_id, client, 0, 0, GFP_KERNEL);
-	mutex_unlock(&ltc294x_lock);
-	if (ret < 0)
-		goto fail_id;
-
-	num = ret;
-
 	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
-	if (info == NULL) {
-		ret = -ENOMEM;
-		goto fail_info;
-	}
+	if (info == NULL)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, info);
 
-	info->num_regs = id->driver_data;
-	info->supply_desc.name = kasprintf(GFP_KERNEL, "%s-%d", client->name,
-					   num);
-	if (!info->supply_desc.name) {
-		ret = -ENOMEM;
-		goto fail_name;
-	}
-
 	np = of_node_get(client->dev.of_node);
 
+	info->num_regs = id->driver_data;
+	info->supply_desc.name = np->name;
+
 	/* r_sense can be negative, when sense+ is connected to the battery
 	 * instead of the sense-. This results in reversed measurements. */
 	ret = of_property_read_u32(np, "lltc,resistor-sense", &r_sense);
 	if (ret < 0) {
 		dev_err(&client->dev,
 			"Could not find lltc,resistor-sense in devicetree\n");
-		goto fail_name;
+		return ret;
 	}
 	info->r_sense = r_sense;
 
@@ -446,7 +421,6 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	}
 
 	info->client = client;
-	info->id = num;
 	info->supply_desc.type = POWER_SUPPLY_TYPE_BATTERY;
 	info->supply_desc.properties = ltc294x_properties;
 	if (info->num_regs >= LTC294X_REG_TEMPERATURE_LSB)
@@ -473,31 +447,19 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	ret = ltc294x_reset(info, prescaler_exp);
 	if (ret < 0) {
 		dev_err(&client->dev, "Communication with chip failed\n");
-		goto fail_comm;
+		return ret;
 	}
 
 	info->supply = power_supply_register(&client->dev, &info->supply_desc,
 					     &psy_cfg);
 	if (IS_ERR(info->supply)) {
 		dev_err(&client->dev, "failed to register ltc2941\n");
-		ret = PTR_ERR(info->supply);
-		goto fail_register;
+		return PTR_ERR(info->supply);
 	} else {
 		schedule_delayed_work(&info->work, LTC294X_WORK_DELAY * HZ);
 	}
 
 	return 0;
-
-fail_register:
-	kfree(info->supply_desc.name);
-fail_comm:
-fail_name:
-fail_info:
-	mutex_lock(&ltc294x_lock);
-	idr_remove(&ltc294x_id, num);
-	mutex_unlock(&ltc294x_lock);
-fail_id:
-	return ret;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
1.9.1
