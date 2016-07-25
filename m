From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v2 2/4] power: sbs-battery: Request threaded irq and fix dev callback cookie
Date: Mon, 25 Jul 2016 10:42:58 +0800
Message-ID: <1469414580-14121-3-git-send-email-preid@electromag.com.au>
References: <1469414580-14121-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:48258 "EHLO
	preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752582AbcGYCnJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 24 Jul 2016 22:43:09 -0400
In-Reply-To: <1469414580-14121-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org
Cc: Phil Reid <preid@electromag.com.au>

Currently the battery detect gpio can not be used with a chained interrupt
controller that requires threaded irq handlers. Use threaded irq instead.
In addition this was not going to be working at present because
chip->power_supply is assigned after the request irq call.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/power/sbs-battery.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index 20f3be6..f9012ed 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -162,7 +162,6 @@ struct sbs_info {
 	bool				is_present;
 	bool				gpio_detect;
 	bool				enable_detection;
-	int				irq;
 	int				last_state;
 	int				poll_time;
 	struct delayed_work		work;
@@ -661,7 +660,8 @@ done:
 
 static irqreturn_t sbs_irq(int irq, void *devid)
 {
-	struct power_supply *battery = devid;
+	struct sbs_info *chip = devid;
+	struct power_supply *battery = chip->power_supply;
 
 	power_supply_changed(battery);
 
@@ -869,9 +869,9 @@ static int sbs_probe(struct i2c_client *client,
 		goto skip_gpio;
 	}
 
-	rc = request_irq(irq, sbs_irq,
+	rc = devm_request_threaded_irq(&client->dev, irq, NULL, sbs_irq,
 		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-		dev_name(&client->dev), chip->power_supply);
+		dev_name(&client->dev), chip);
 	if (rc) {
 		dev_warn(&client->dev, "Failed to request irq: %d\n", rc);
 		gpio_free(pdata->battery_detect);
@@ -879,8 +879,6 @@ static int sbs_probe(struct i2c_client *client,
 		goto skip_gpio;
 	}
 
-	chip->irq = irq;
-
 skip_gpio:
 	/*
 	 * Before we register, we might need to make sure we can actually talk
@@ -915,8 +913,6 @@ skip_gpio:
 	return 0;
 
 exit_psupply:
-	if (chip->irq)
-		free_irq(chip->irq, chip->power_supply);
 	if (chip->gpio_detect)
 		gpio_free(pdata->battery_detect);
 
@@ -927,8 +923,6 @@ static int sbs_remove(struct i2c_client *client)
 {
 	struct sbs_info *chip = i2c_get_clientdata(client);
 
-	if (chip->irq)
-		free_irq(chip->irq, chip->power_supply);
 	if (chip->gpio_detect)
 		gpio_free(chip->pdata->battery_detect);
 
-- 
1.8.3.1

