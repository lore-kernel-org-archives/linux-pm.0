From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v2 4/4] power: sbs-battery: Use gpio_desc and sleeping calls for battery detect
Date: Mon, 25 Jul 2016 10:43:00 +0800
Message-ID: <1469414580-14121-5-git-send-email-preid@electromag.com.au>
References: <1469414580-14121-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:48252 "EHLO
	preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752644AbcGYCnK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 24 Jul 2016 22:43:10 -0400
In-Reply-To: <1469414580-14121-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org
Cc: Phil Reid <preid@electromag.com.au>

Switch to using new gpio_desc interface and devm gpio get calls to
automatically manage gpio resource. Use gpiod_get_value which handles
active high / low calls.

If gpio_detect is set then force loading of the driver as it is
reasonable to assume that the battery may not be present.

Update the is_present flag immediately in the IRQ.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/power/sbs-battery.c | 122 +++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 63 deletions(-)

diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index 31f3e33..c05bec4 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -160,7 +160,7 @@ struct sbs_info {
 	struct power_supply		*power_supply;
 	struct sbs_platform_data	*pdata;
 	bool				is_present;
-	bool				gpio_detect;
+	struct gpio_desc		*gpio_detect;
 	bool				enable_detection;
 	int				last_state;
 	int				poll_time;
@@ -301,13 +301,11 @@ static int sbs_get_battery_presence_and_health(
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
@@ -662,7 +660,12 @@ static irqreturn_t sbs_irq(int irq, void *devid)
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
@@ -717,6 +720,31 @@ static void sbs_delayed_work(struct work_struct *work)
 	}
 }
 
+static struct sbs_platform_data *sbs_populate_pdata(struct sbs_info *chip)
+{
+	struct i2c_client *client = chip->client;
+	struct sbs_platform_data *pdata = client->dev.platform_data;
+	int rc;
+	unsigned long flags = GPIOF_DIR_IN;
+
+	if (!gpio_is_valid(pdata->battery_detect))
+		return pdata;
+
+	if (!pdata->battery_detect_present)
+		set_bit(GPIOF_ACTIVE_LOW, &flags);
+
+	rc = devm_gpio_request_one(&client->dev, pdata->battery_detect,
+				   flags, dev_name(&client->dev));
+	if (rc) {
+		dev_warn(&client->dev, "Failed to get gpio: %d\n", rc);
+		return pdata;
+	}
+
+	chip->gpio_detect = gpio_to_desc(pdata->battery_detect);
+
+	return pdata;
+}
+
 #if defined(CONFIG_OF)
 
 #include <linux/of_device.h>
@@ -729,12 +757,11 @@ static const struct of_device_id sbs_dt_ids[] = {
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
+	struct sbs_platform_data *pdata = NULL;
 	int rc;
 	u32 prop;
 
@@ -742,10 +769,6 @@ static struct sbs_platform_data *sbs_of_populate_pdata(
 	if (!of_node)
 		return NULL;
 
-	/* if platform data is set, honor it */
-	if (pdata)
-		return pdata;
-
 	/* first make sure at least one property is set, otherwise
 	 * it won't change behavior from running without pdata.
 	 */
@@ -757,7 +780,7 @@ static struct sbs_platform_data *sbs_of_populate_pdata(
 	pdata = devm_kzalloc(&client->dev, sizeof(struct sbs_platform_data),
 				GFP_KERNEL);
 	if (!pdata)
-		goto of_out;
+		return ERR_PTR(-ENOMEM);
 
 	rc = of_property_read_u32(of_node, "sbs,i2c-retry-count", &prop);
 	if (!rc)
@@ -767,27 +790,22 @@ static struct sbs_platform_data *sbs_of_populate_pdata(
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
+	chip->gpio_detect = devm_gpiod_get_optional(&client->dev,
+			"sbs,battery-detect", GPIOD_IN);
 
+	if (IS_ERR(chip->gpio_detect)) {
+		dev_err(&client->dev, "Failed to get gpio: %ld\n",
+			PTR_ERR(chip->gpio_detect));
+		return ERR_PTR(PTR_ERR(chip->gpio_detect));
+	}
 of_out:
 	return pdata;
 }
 #else
 static struct sbs_platform_data *sbs_of_populate_pdata(
-	struct i2c_client *client)
+	struct sbs_info *client)
 {
-	return client->dev.platform_data;
+	return NULL;
 }
 #endif
 
@@ -825,7 +843,6 @@ static int sbs_probe(struct i2c_client *client,
 
 	chip->client = client;
 	chip->enable_detection = false;
-	chip->gpio_detect = false;
 	psy_cfg.of_node = client->dev.of_node;
 	psy_cfg.drv_data = chip;
 	/* ignore first notification of external change, it is generated
@@ -834,38 +851,25 @@ static int sbs_probe(struct i2c_client *client,
 	chip->ignore_changes = 1;
 	chip->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
 
-	pdata = sbs_of_populate_pdata(client);
-
 	if (pdata) {
-		chip->gpio_detect = gpio_is_valid(pdata->battery_detect);
-		chip->pdata = pdata;
+		pdata = sbs_populate_pdata(chip);
+	} else {
+		pdata = sbs_of_populate_pdata(chip);
 	}
 
-	i2c_set_clientdata(client, chip);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
 
-	if (!chip->gpio_detect)
-		goto skip_gpio;
+	chip->pdata = pdata;
 
-	rc = gpio_request(pdata->battery_detect, dev_name(&client->dev));
-	if (rc) {
-		dev_warn(&client->dev, "Failed to request gpio: %d\n", rc);
-		chip->gpio_detect = false;
-		goto skip_gpio;
-	}
+	i2c_set_clientdata(client, chip);
 
-	rc = gpio_direction_input(pdata->battery_detect);
-	if (rc) {
-		dev_warn(&client->dev, "Failed to get gpio as input: %d\n", rc);
-		gpio_free(pdata->battery_detect);
-		chip->gpio_detect = false;
+	if (!chip->gpio_detect)
 		goto skip_gpio;
-	}
 
-	irq = gpio_to_irq(pdata->battery_detect);
+	irq = gpiod_to_irq(chip->gpio_detect);
 	if (irq <= 0) {
 		dev_warn(&client->dev, "Failed to get gpio as irq: %d\n", irq);
-		gpio_free(pdata->battery_detect);
-		chip->gpio_detect = false;
 		goto skip_gpio;
 	}
 
@@ -874,8 +878,6 @@ static int sbs_probe(struct i2c_client *client,
 		dev_name(&client->dev), chip);
 	if (rc) {
 		dev_warn(&client->dev, "Failed to request irq: %d\n", rc);
-		gpio_free(pdata->battery_detect);
-		chip->gpio_detect = false;
 		goto skip_gpio;
 	}
 
@@ -884,7 +886,7 @@ skip_gpio:
 	 * Before we register, we might need to make sure we can actually talk
 	 * to the battery.
 	 */
-	if (!force_load) {
+	if (!(force_load || chip->gpio_detect)) {
 		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
 
 		if (rc < 0) {
@@ -913,9 +915,6 @@ skip_gpio:
 	return 0;
 
 exit_psupply:
-	if (chip->gpio_detect)
-		gpio_free(pdata->battery_detect);
-
 	return rc;
 }
 
@@ -923,9 +922,6 @@ static int sbs_remove(struct i2c_client *client)
 {
 	struct sbs_info *chip = i2c_get_clientdata(client);
 
-	if (chip->gpio_detect)
-		gpio_free(chip->pdata->battery_detect);
-
 	cancel_delayed_work_sync(&chip->work);
 
 	return 0;
-- 
1.8.3.1

