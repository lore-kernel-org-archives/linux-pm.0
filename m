From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/7] power: supply: bq24190_charger: Use i2c-core irq-mapping code
Date: Wed, 22 Mar 2017 15:55:30 +0100
Message-ID: <20170322145536.30570-2-hdegoede@redhat.com>
References: <20170322145536.30570-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760414AbdCVOzl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 10:55:41 -0400
In-Reply-To: <20170322145536.30570-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>

The i2c-core already maps of irqs before calling the driver's probe
function and there are no in tree users of
bq24190_platform_data->gpio_int.

Remove the redundant custom irq-mapping code and just use client->irq.

Cc: Liam Breck <kernel@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Sebastian Reichel <sre@kernel.org>
---
Changes in v2:
-Completely drop platform_data and include/linux/power/bq24190_charger.h
---
 drivers/power/supply/bq24190_charger.c | 66 ++--------------------------------
 include/linux/power/bq24190_charger.h  | 16 ---------
 2 files changed, 3 insertions(+), 79 deletions(-)
 delete mode 100644 include/linux/power/bq24190_charger.h

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 451f2bc..fa2d2da 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -18,9 +18,6 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 
-#include <linux/power/bq24190_charger.h>
-
-
 #define	BQ24190_MANUFACTURER	"Texas Instruments"
 
 #define BQ24190_REG_ISC		0x00 /* Input Source Control */
@@ -153,8 +150,6 @@ struct bq24190_dev_info {
 	struct power_supply		*battery;
 	char				model_name[I2C_NAME_SIZE];
 	kernel_ulong_t			model;
-	unsigned int			gpio_int;
-	unsigned int			irq;
 	bool				initialized;
 	bool				irq_event;
 	struct mutex			f_reg_lock;
@@ -1310,56 +1305,11 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 	return bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
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
@@ -1385,12 +1335,7 @@ static int bq24190_probe(struct i2c_client *client,
 
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
@@ -1436,7 +1381,7 @@ static int bq24190_probe(struct i2c_client *client,
 
 	bdi->initialized = true;
 
-	ret = devm_request_threaded_irq(dev, bdi->irq, NULL,
+	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 			bq24190_irq_handler_thread,
 			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			"bq24190-charger", bdi);
@@ -1445,7 +1390,7 @@ static int bq24190_probe(struct i2c_client *client,
 		goto out5;
 	}
 
-	enable_irq_wake(bdi->irq);
+	enable_irq_wake(client->irq);
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
@@ -1467,8 +1412,6 @@ static int bq24190_probe(struct i2c_client *client,
 out1:
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
-	if (bdi->gpio_int)
-		gpio_free(bdi->gpio_int);
 	return ret;
 }
 
@@ -1492,9 +1435,6 @@ static int bq24190_remove(struct i2c_client *client)
 	pm_runtime_dont_use_autosuspend(bdi->dev);
 	pm_runtime_disable(bdi->dev);
 
-	if (bdi->gpio_int)
-		gpio_free(bdi->gpio_int);
-
 	return 0;
 }
 
diff --git a/include/linux/power/bq24190_charger.h b/include/linux/power/bq24190_charger.h
deleted file mode 100644
index 9f02837..0000000
--- a/include/linux/power/bq24190_charger.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * Platform data for the TI bq24190 battery charger driver.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _BQ24190_CHARGER_H_
-#define _BQ24190_CHARGER_H_
-
-struct bq24190_platform_data {
-	unsigned int	gpio_int;	/* GPIO pin that's connected to INT# */
-};
-
-#endif
-- 
2.9.3
