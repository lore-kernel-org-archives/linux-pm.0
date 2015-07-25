From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: [PATCH v2] power_supply: bq24735: Convert to using managed resources
Date: Sat, 25 Jul 2015 09:23:16 +0530
Message-ID: <20150725035316.GA10621@vaishali-Ideapad-Z570>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36022 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbbGYDxX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 23:53:23 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Frans Klaver <fransklaver@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Use managed resource functions like devm_kasprintf and
devm_power_supply_register in bq24735_charger_probe. To be
compatible with the change, replace various gotos by direct
returns and drop unneeded labels.

Also, remove bq24735_charger_remove as it is now redundant.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
Changes since v2:
	- Use devm_power_supply_register
	- Remove bq24735_charger_remove
	- Improve commit log
---
 drivers/power/bq24735-charger.c | 51 +++++++++++------------------------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/drivers/power/bq24735-charger.c b/drivers/power/bq24735-charger.c
index b017437..eb2b368 100644
--- a/drivers/power/bq24735-charger.c
+++ b/drivers/power/bq24735-charger.c
@@ -267,8 +267,9 @@ static int bq24735_charger_probe(struct i2c_client *client,
 
 	name = (char *)charger->pdata->name;
 	if (!name) {
-		name = kasprintf(GFP_KERNEL, "bq24735@%s",
-				 dev_name(&client->dev));
+		name = devm_kasprintf(&client->dev, GFP_KERNEL,
+				      "bq24735@%s",
+				      dev_name(&client->dev));
 		if (!name) {
 			dev_err(&client->dev, "Failed to alloc device name\n");
 			return -ENOMEM;
@@ -296,23 +297,21 @@ static int bq24735_charger_probe(struct i2c_client *client,
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to read manufacturer id : %d\n",
 			ret);
-		goto err_free_name;
+		return ret;
 	} else if (ret != 0x0040) {
 		dev_err(&client->dev,
 			"manufacturer id mismatch. 0x0040 != 0x%04x\n", ret);
-		ret = -ENODEV;
-		goto err_free_name;
+		return -ENODEV;
 	}
 
 	ret = bq24735_read_word(client, BQ24735_DEVICE_ID);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to read device id : %d\n", ret);
-		goto err_free_name;
+		return ret;
 	} else if (ret != 0x000B) {
 		dev_err(&client->dev,
 			"device id mismatch. 0x000b != 0x%04x\n", ret);
-		ret = -ENODEV;
-		goto err_free_name;
+		return -ENODEV;
 	}
 
 	if (gpio_is_valid(charger->pdata->status_gpio)) {
@@ -331,7 +330,7 @@ static int bq24735_charger_probe(struct i2c_client *client,
 	ret = bq24735_config_charger(charger);
 	if (ret < 0) {
 		dev_err(&client->dev, "failed in configuring charger");
-		goto err_free_name;
+		return ret;
 	}
 
 	/* check for AC adapter presence */
@@ -339,17 +338,17 @@ static int bq24735_charger_probe(struct i2c_client *client,
 		ret = bq24735_enable_charging(charger);
 		if (ret < 0) {
 			dev_err(&client->dev, "Failed to enable charging\n");
-			goto err_free_name;
+			return ret;
 		}
 	}
 
-	charger->charger = power_supply_register(&client->dev, supply_desc,
-						 &psy_cfg);
+	charger->charger = devm_power_supply_register(&client->dev, supply_desc,
+						      &psy_cfg);
 	if (IS_ERR(charger->charger)) {
 		ret = PTR_ERR(charger->charger);
 		dev_err(&client->dev, "Failed to register power supply: %d\n",
 			ret);
-		goto err_free_name;
+		return ret;
 	}
 
 	if (client->irq) {
@@ -364,34 +363,11 @@ static int bq24735_charger_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"Unable to register IRQ %d err %d\n",
 				client->irq, ret);
-			goto err_unregister_supply;
+			return ret;
 		}
 	}
 
 	return 0;
-err_unregister_supply:
-	power_supply_unregister(charger->charger);
-err_free_name:
-	if (name != charger->pdata->name)
-		kfree(name);
-
-	return ret;
-}
-
-static int bq24735_charger_remove(struct i2c_client *client)
-{
-	struct bq24735 *charger = i2c_get_clientdata(client);
-
-	if (charger->client->irq)
-		devm_free_irq(&charger->client->dev, charger->client->irq,
-			      &charger->charger);
-
-	power_supply_unregister(charger->charger);
-
-	if (charger->charger_desc.name != charger->pdata->name)
-		kfree(charger->charger_desc.name);
-
-	return 0;
 }
 
 static const struct i2c_device_id bq24735_charger_id[] = {
@@ -412,7 +388,6 @@ static struct i2c_driver bq24735_charger_driver = {
 		.of_match_table = bq24735_match_ids,
 	},
 	.probe = bq24735_charger_probe,
-	.remove = bq24735_charger_remove,
 	.id_table = bq24735_charger_id,
 };
 
-- 
1.9.1

