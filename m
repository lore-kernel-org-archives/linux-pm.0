From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 3/3] power: supply: bq24735-charger: allow chargers to share the ac-detect gpio
Date: Wed, 14 Dec 2016 00:56:45 +0100
Message-ID: <1481673405-4547-4-git-send-email-peda@axentia.se>
References: <1481673405-4547-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481673405-4547-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If several parallel bq24735 chargers have their ac-detect gpios wired
together (or if only one of the parallel bq24735 chargers have its
ac-detect pin wired to a gpio, and the others are assumed to react the
same), then all driver instances need to check the same gpio. But the
gpio subsystem does not allow sharing gpios, so handle that locally.

However, only do this for the polling case, sharing is not supported if
the ac detection is handled with interrupts.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/power/supply/bq24735-charger.c | 111 +++++++++++++++++++++++++++++----
 1 file changed, 100 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index f45876927676..c2403c4d5ece 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
@@ -43,12 +44,24 @@
 #define BQ24735_MANUFACTURER_ID		0xfe
 #define BQ24735_DEVICE_ID		0xff
 
+struct bq24735;
+
+struct bq24735_shared {
+	struct list_head		list;
+	struct bq24735			*owner;
+	struct gpio_desc		*status_gpio;
+};
+
+static DEFINE_MUTEX(shared_lock);
+static LIST_HEAD(shared_list);
+
 struct bq24735 {
 	struct power_supply		*charger;
 	struct power_supply_desc	charger_desc;
 	struct i2c_client		*client;
 	struct bq24735_platform		*pdata;
 	struct mutex			lock;
+	struct bq24735_shared		*shared;
 	struct gpio_desc		*status_gpio;
 	struct delayed_work		poll;
 	u32				poll_interval;
@@ -346,6 +359,75 @@ static struct bq24735_platform *bq24735_parse_dt_data(struct i2c_client *client)
 	return pdata;
 }
 
+static struct gpio_desc *bq24735_get_status_gpio(struct bq24735 *charger)
+{
+	struct device *dev = &charger->client->dev;
+	struct bq24735_shared *shared;
+	int gpio;
+	enum of_gpio_flags flags;
+	int active_low;
+	struct list_head *pos;
+
+	if (of_property_read_bool(dev->of_node, "ti,ac-detect-gpios"))
+		gpio = of_get_named_gpio_flags(dev->of_node,
+					       "ti,ac-detect-gpios", 0, &flags);
+	else if (of_property_read_bool(dev->of_node, "ti,ac-detect-gpio"))
+		gpio = of_get_named_gpio_flags(dev->of_node,
+					       "ti,ac-detect-gpio", 0, &flags);
+	else
+		return NULL;
+
+	if (!gpio_is_valid(gpio))
+		return ERR_PTR(gpio);
+	active_low = flags & OF_GPIO_ACTIVE_LOW;
+
+	mutex_lock(&shared_lock);
+	list_for_each(pos, &shared_list) {
+		shared = list_entry(pos, struct bq24735_shared, list);
+		if (gpio != desc_to_gpio(shared->status_gpio))
+			continue;
+		if (!active_low ^ !gpiod_is_active_low(shared->status_gpio))
+			continue;
+
+		get_device(&shared->owner->client->dev);
+		dev_dbg(dev, "sharing gpio with %s\n",
+			shared->owner->pdata->name);
+		charger->shared = shared;
+		mutex_unlock(&shared_lock);
+		return shared->status_gpio;
+	}
+
+	shared = devm_kzalloc(dev, sizeof(*shared), GFP_KERNEL);
+	if (!shared) {
+		mutex_unlock(&shared_lock);
+		return ERR_PTR(-ENOMEM);
+	}
+	shared->owner = charger;
+	shared->status_gpio = gpiod_get(dev, "ti,ac-detect", GPIOD_IN);
+	if (!IS_ERR(shared->status_gpio)) {
+		charger->shared = shared;
+		list_add(&shared->list, &shared_list);
+	}
+	mutex_unlock(&shared_lock);
+
+	return shared->status_gpio;
+}
+
+static void bq24735_put_status_gpio(struct bq24735 *charger)
+{
+	if (!charger->shared)
+		return;
+
+	mutex_lock(&shared_lock);
+	if (charger->shared->owner != charger) {
+		put_device(&charger->shared->owner->client->dev);
+	} else {
+		list_del(&charger->shared->list);
+		gpiod_put(charger->shared->status_gpio);
+	}
+	mutex_unlock(&shared_lock);
+}
+
 static int bq24735_charger_probe(struct i2c_client *client,
 				 const struct i2c_device_id *id)
 {
@@ -402,9 +484,7 @@ static int bq24735_charger_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, charger);
 
-	charger->status_gpio = devm_gpiod_get_optional(&client->dev,
-						       "ti,ac-detect",
-						       GPIOD_IN);
+	charger->status_gpio = bq24735_get_status_gpio(charger);
 	if (IS_ERR(charger->status_gpio)) {
 		ret = PTR_ERR(charger->status_gpio);
 		dev_err(&client->dev, "Getting gpio failed: %d\n", ret);
@@ -416,28 +496,30 @@ static int bq24735_charger_probe(struct i2c_client *client,
 		if (ret < 0) {
 			dev_err(&client->dev, "Failed to read manufacturer id : %d\n",
 				ret);
-			return ret;
+			goto out;
 		} else if (ret != 0x0040) {
 			dev_err(&client->dev,
 				"manufacturer id mismatch. 0x0040 != 0x%04x\n", ret);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto out;
 		}
 
 		ret = bq24735_read_word(client, BQ24735_DEVICE_ID);
 		if (ret < 0) {
 			dev_err(&client->dev, "Failed to read device id : %d\n", ret);
-			return ret;
+			goto out;
 		} else if (ret != 0x000B) {
 			dev_err(&client->dev,
 				"device id mismatch. 0x000b != 0x%04x\n", ret);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto out;
 		}
 	}
 
 	ret = bq24735_config_charger(charger);
 	if (ret < 0) {
 		dev_err(&client->dev, "failed in configuring charger");
-		return ret;
+		goto out;
 	}
 
 	/* check for AC adapter presence */
@@ -445,7 +527,7 @@ static int bq24735_charger_probe(struct i2c_client *client,
 		ret = bq24735_enable_charging(charger);
 		if (ret < 0) {
 			dev_err(&client->dev, "Failed to enable charging\n");
-			return ret;
+			goto out;
 		}
 	}
 
@@ -455,7 +537,7 @@ static int bq24735_charger_probe(struct i2c_client *client,
 		ret = PTR_ERR(charger->charger);
 		dev_err(&client->dev, "Failed to register power supply: %d\n",
 			ret);
-		return ret;
+		goto out;
 	}
 
 	if (client->irq) {
@@ -470,7 +552,7 @@ static int bq24735_charger_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"Unable to register IRQ %d err %d\n",
 				client->irq, ret);
-			return ret;
+			goto out;
 		}
 	} else if (charger->status_gpio) {
 		ret = of_property_read_u32(client->dev.of_node,
@@ -487,6 +569,11 @@ static int bq24735_charger_probe(struct i2c_client *client,
 	}
 
 	return 0;
+
+out:
+	bq24735_put_status_gpio(charger);
+
+	return ret;
 }
 
 static int bq24735_charger_remove(struct i2c_client *client)
@@ -496,6 +583,8 @@ static int bq24735_charger_remove(struct i2c_client *client)
 	if (charger->poll_interval)
 		cancel_delayed_work_sync(&charger->poll);
 
+	bq24735_put_status_gpio(charger);
+
 	return 0;
 }
 
-- 
2.1.4
