From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v4 1/1] power: sbs-battery: Use gpio_desc and sleeping calls for battery detect
Date: Thu,  1 Sep 2016 15:50:52 +0800
Message-ID: <1472716252-42087-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:62696 "EHLO
        preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754814AbcIAHvA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2016 03:51:00 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, preid@electromag.com.au, linux-pm@vger.kernel.org

Switch to using new gpio_desc interface and devm gpio get calls to
automatically manage gpio resource. Use gpiod_get_value which handles
active high / low calls.

If gpio_detect is set then force loading of the driver as it is
reasonable to assume that the battery may not be present.

Update the is_present flag immediately in the IRQ.

Remove legacy gpio specification from platform data.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---

Notes:
    Sebastian, I have not implemented all the changes you highlighted.
    I've sort of headed back to a minimal changeset that I think doesn't change
    existing behaviour as much. In particular the driver will load if platform_data
    is not set and of_node is not set. I'm not sure if this is valid case or not.
    And the non OF build will also load if platform_data is not set.
    Happy to change this but perhaps they should be another patch. WDYR?
    
    Changes from V3:
    - Fix gpiod interface for platform data.
      Due to my complete misunderstanding of gpiod interface with platform data.
      devm_gpiod_get_optional now called in the probe function.
    - Revert changes to always create pdata. As gpio_detect is now a member
      of chip structure.
    
    Changes from V2:
    - add the correct gpiod include: <include/linux/gpio/consumer.h>
    - rebase on power-supply's next branch
    - remove battery_detect and battery_detect_present from the
      struct sbs_platform_data and always use the gpiod API.
    - Ensure pdata is always valid and remove pdata null checks.
    
    Changes from V1:
    - Fix sbs_of_populate_pdata params for non OF builds.
    - Fix title of summary message.

 drivers/power/supply/sbs-battery.c | 99 +++++++++++++-------------------------
 include/linux/power/sbs-battery.h  |  4 --
 2 files changed, 33 insertions(+), 70 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index e1dfb3e..5203d04 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -26,7 +26,7 @@
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/stat.h>
 
@@ -165,7 +165,7 @@ struct sbs_info {
 	struct power_supply		*power_supply;
 	struct sbs_platform_data	*pdata;
 	bool				is_present;
-	bool				gpio_detect;
+	struct gpio_desc		*gpio_detect;
 	bool				enable_detection;
 	int				last_state;
 	int				poll_time;
@@ -306,13 +306,11 @@ static int sbs_get_battery_presence_and_health(
 	s32 ret;
 	struct sbs_info *chip = i2c_get_clientdata(client);
 
-	if (psp == POWER_SUPPLY_PROP_PRESENT &&
-		chip->gpio_detect) {
-		ret = gpio_get_value(chip->pdata->battery_detect);
-		if (ret == chip->pdata->battery_detect_present)
-			val->intval = 1;
-		else
-			val->intval = 0;
+	if (psp == POWER_SUPPLY_PROP_PRESENT && chip->gpio_detect) {
+		ret = gpiod_get_value_cansleep(chip->gpio_detect);
+		if (ret < 0)
+			return ret;
+		val->intval = ret;
 		chip->is_present = val->intval;
 		return ret;
 	}
@@ -683,7 +681,12 @@ static irqreturn_t sbs_irq(int irq, void *devid)
 {
 	struct sbs_info *chip = devid;
 	struct power_supply *battery = chip->power_supply;
+	int ret;
 
+	ret = gpiod_get_value_cansleep(chip->gpio_detect);
+	if (ret < 0)
+		return ret;
+	chip->is_present = ret;
 	power_supply_changed(battery);
 
 	return IRQ_HANDLED;
@@ -750,12 +753,11 @@ static const struct of_device_id sbs_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, sbs_dt_ids);
 
-static struct sbs_platform_data *sbs_of_populate_pdata(
-		struct i2c_client *client)
+static struct sbs_platform_data *sbs_of_populate_pdata(struct sbs_info *chip)
 {
+	struct i2c_client *client = chip->client;
 	struct device_node *of_node = client->dev.of_node;
-	struct sbs_platform_data *pdata = client->dev.platform_data;
-	enum of_gpio_flags gpio_flags;
+	struct sbs_platform_data *pdata;
 	int rc;
 	u32 prop;
 
@@ -763,22 +765,17 @@ static struct sbs_platform_data *sbs_of_populate_pdata(
 	if (!of_node)
 		return NULL;
 
-	/* if platform data is set, honor it */
-	if (pdata)
-		return pdata;
-
 	/* first make sure at least one property is set, otherwise
 	 * it won't change behavior from running without pdata.
 	 */
 	if (!of_get_property(of_node, "sbs,i2c-retry-count", NULL) &&
-		!of_get_property(of_node, "sbs,poll-retry-count", NULL) &&
-		!of_get_property(of_node, "sbs,battery-detect-gpios", NULL))
+	    !of_get_property(of_node, "sbs,poll-retry-count", NULL))
 		goto of_out;
 
 	pdata = devm_kzalloc(&client->dev, sizeof(struct sbs_platform_data),
 				GFP_KERNEL);
 	if (!pdata)
-		goto of_out;
+		return ERR_PTR(-ENOMEM);
 
 	rc = of_property_read_u32(of_node, "sbs,i2c-retry-count", &prop);
 	if (!rc)
@@ -788,25 +785,12 @@ static struct sbs_platform_data *sbs_of_populate_pdata(
 	if (!rc)
 		pdata->poll_retry_count = prop;
 
-	if (!of_get_property(of_node, "sbs,battery-detect-gpios", NULL)) {
-		pdata->battery_detect = -1;
-		goto of_out;
-	}
-
-	pdata->battery_detect = of_get_named_gpio_flags(of_node,
-			"sbs,battery-detect-gpios", 0, &gpio_flags);
-
-	if (gpio_flags & OF_GPIO_ACTIVE_LOW)
-		pdata->battery_detect_present = 0;
-	else
-		pdata->battery_detect_present = 1;
-
 of_out:
 	return pdata;
 }
 #else
 static struct sbs_platform_data *sbs_of_populate_pdata(
-	struct i2c_client *client)
+	struct sbs_info *client)
 {
 	return client->dev.platform_data;
 }
@@ -846,7 +830,6 @@ static int sbs_probe(struct i2c_client *client,
 
 	chip->client = client;
 	chip->enable_detection = false;
-	chip->gpio_detect = false;
 	psy_cfg.of_node = client->dev.of_node;
 	psy_cfg.drv_data = chip;
 	/* ignore first notification of external change, it is generated
@@ -855,11 +838,20 @@ static int sbs_probe(struct i2c_client *client,
 	chip->ignore_changes = 1;
 	chip->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
 
-	pdata = sbs_of_populate_pdata(client);
+	if (!pdata)
+		pdata = sbs_of_populate_pdata(chip);
+
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+
+	chip->pdata = pdata;
 
-	if (pdata) {
-		chip->gpio_detect = gpio_is_valid(pdata->battery_detect);
-		chip->pdata = pdata;
+	chip->gpio_detect = devm_gpiod_get_optional(&client->dev,
+			"sbs,battery-detect", GPIOD_IN);
+	if (IS_ERR(chip->gpio_detect)) {
+		dev_err(&client->dev, "Failed to get gpio: %ld\n",
+			PTR_ERR(chip->gpio_detect));
+		return PTR_ERR(chip->gpio_detect);
 	}
 
 	i2c_set_clientdata(client, chip);
@@ -867,26 +859,9 @@ static int sbs_probe(struct i2c_client *client,
 	if (!chip->gpio_detect)
 		goto skip_gpio;
 
-	rc = gpio_request(pdata->battery_detect, dev_name(&client->dev));
-	if (rc) {
-		dev_warn(&client->dev, "Failed to request gpio: %d\n", rc);
-		chip->gpio_detect = false;
-		goto skip_gpio;
-	}
-
-	rc = gpio_direction_input(pdata->battery_detect);
-	if (rc) {
-		dev_warn(&client->dev, "Failed to get gpio as input: %d\n", rc);
-		gpio_free(pdata->battery_detect);
-		chip->gpio_detect = false;
-		goto skip_gpio;
-	}
-
-	irq = gpio_to_irq(pdata->battery_detect);
+	irq = gpiod_to_irq(chip->gpio_detect);
 	if (irq <= 0) {
 		dev_warn(&client->dev, "Failed to get gpio as irq: %d\n", irq);
-		gpio_free(pdata->battery_detect);
-		chip->gpio_detect = false;
 		goto skip_gpio;
 	}
 
@@ -895,8 +870,6 @@ static int sbs_probe(struct i2c_client *client,
 		dev_name(&client->dev), chip);
 	if (rc) {
 		dev_warn(&client->dev, "Failed to request irq: %d\n", rc);
-		gpio_free(pdata->battery_detect);
-		chip->gpio_detect = false;
 		goto skip_gpio;
 	}
 
@@ -905,7 +878,7 @@ skip_gpio:
 	 * Before we register, we might need to make sure we can actually talk
 	 * to the battery.
 	 */
-	if (!force_load) {
+	if (!(force_load || chip->gpio_detect)) {
 		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
 
 		if (rc < 0) {
@@ -934,9 +907,6 @@ skip_gpio:
 	return 0;
 
 exit_psupply:
-	if (chip->gpio_detect)
-		gpio_free(pdata->battery_detect);
-
 	return rc;
 }
 
@@ -944,9 +914,6 @@ static int sbs_remove(struct i2c_client *client)
 {
 	struct sbs_info *chip = i2c_get_clientdata(client);
 
-	if (chip->gpio_detect)
-		gpio_free(chip->pdata->battery_detect);
-
 	cancel_delayed_work_sync(&chip->work);
 
 	return 0;
diff --git a/include/linux/power/sbs-battery.h b/include/linux/power/sbs-battery.h
index 2b0a9d9..811f1a0 100644
--- a/include/linux/power/sbs-battery.h
+++ b/include/linux/power/sbs-battery.h
@@ -26,15 +26,11 @@
 
 /**
  * struct sbs_platform_data - platform data for sbs devices
- * @battery_detect:		GPIO which is used to detect battery presence
- * @battery_detect_present:	gpio state when battery is present (0 / 1)
  * @i2c_retry_count:		# of times to retry on i2c IO failure
  * @poll_retry_count:		# of times to retry looking for new status after
  *				external change notification
  */
 struct sbs_platform_data {
-	int battery_detect;
-	int battery_detect_present;
 	int i2c_retry_count;
 	int poll_retry_count;
 };
-- 
1.8.3.1

