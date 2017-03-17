From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 06/15] power: supply: bq24190_charger: Use i2c-core irq-mapping code
Date: Fri, 17 Mar 2017 10:55:18 +0100
Message-ID: <20170317095527.10487-7-hdegoede@redhat.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170317095527.10487-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The i2c-core already maps of irqs before calling the driver's probe
function and there are no in tree users of
bq24190_platform_data->gpio_int.

Remove the redundant custom irq-mapping code and just use client->irq.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 61 ++--------------------------------
 include/linux/power/bq24190_charger.h  |  1 -
 2 files changed, 2 insertions(+), 60 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 7bca8d0..9c4b171 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -154,8 +154,6 @@ struct bq24190_dev_info {
 	struct bq24190_platform_data	*pdata;
 	char				model_name[I2C_NAME_SIZE];
 	kernel_ulong_t			model;
-	unsigned int			gpio_int;
-	unsigned int			irq;
 	struct mutex			f_reg_lock;
 	u8				f_reg;
 	u8				ss_reg;
@@ -1296,56 +1294,11 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 	return ret;
 }
 
-#ifdef CONFIG_OF
-static int bq24190_setup_dt(struct bq24190_dev_info *bdi)
-{
-	bdi->irq = irq_of_parse_and_map(bdi->dev->of_node, 0);
-	if (bdi->irq <= 0)
-		return -1;
-
-	return 0;
-}
-#else
-static int bq24190_setup_dt(struct bq24190_dev_info *bdi)
-{
-	return -1;
-}
-#endif
-
-static int bq24190_setup_pdata(struct bq24190_dev_info *bdi,
-		struct bq24190_platform_data *pdata)
-{
-	int ret;
-
-	if (!gpio_is_valid(pdata->gpio_int))
-		return -1;
-
-	ret = gpio_request(pdata->gpio_int, dev_name(bdi->dev));
-	if (ret < 0)
-		return -1;
-
-	ret = gpio_direction_input(pdata->gpio_int);
-	if (ret < 0)
-		goto out;
-
-	bdi->irq = gpio_to_irq(pdata->gpio_int);
-	if (!bdi->irq)
-		goto out;
-
-	bdi->gpio_int = pdata->gpio_int;
-	return 0;
-
-out:
-	gpio_free(pdata->gpio_int);
-	return -1;
-}
-
 static int bq24190_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	struct device *dev = &client->dev;
-	struct bq24190_platform_data *pdata = client->dev.platform_data;
 	struct power_supply_config charger_cfg = {}, battery_cfg = {};
 	struct bq24190_dev_info *bdi;
 	int ret;
@@ -1372,12 +1325,7 @@ static int bq24190_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, bdi);
 
-	if (dev->of_node)
-		ret = bq24190_setup_dt(bdi);
-	else
-		ret = bq24190_setup_pdata(bdi, pdata);
-
-	if (ret) {
+	if (!client->irq) {
 		dev_err(dev, "Can't get irq info\n");
 		return -EINVAL;
 	}
@@ -1417,7 +1365,7 @@ static int bq24190_probe(struct i2c_client *client,
 		goto out3;
 	}
 
-	ret = devm_request_threaded_irq(dev, bdi->irq, NULL,
+	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 			bq24190_irq_handler_thread,
 			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			"bq24190-charger", bdi);
@@ -1439,8 +1387,6 @@ static int bq24190_probe(struct i2c_client *client,
 
 out1:
 	pm_runtime_disable(dev);
-	if (bdi->gpio_int)
-		gpio_free(bdi->gpio_int);
 	return ret;
 }
 
@@ -1457,9 +1403,6 @@ static int bq24190_remove(struct i2c_client *client)
 	power_supply_unregister(bdi->charger);
 	pm_runtime_disable(bdi->dev);
 
-	if (bdi->gpio_int)
-		gpio_free(bdi->gpio_int);
-
 	return 0;
 }
 
diff --git a/include/linux/power/bq24190_charger.h b/include/linux/power/bq24190_charger.h
index cb49717..8d918cb 100644
--- a/include/linux/power/bq24190_charger.h
+++ b/include/linux/power/bq24190_charger.h
@@ -10,7 +10,6 @@
 #define _BQ24190_CHARGER_H_
 
 struct bq24190_platform_data {
-	unsigned int	gpio_int;	/* GPIO pin that's connected to INT# */
 	bool no_register_reset;
 };
 
-- 
2.9.3

