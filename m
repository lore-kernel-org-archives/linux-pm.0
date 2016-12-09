From: Atul Raj <atul.r@samsung.com>
Subject: [PATCH v2] power: supply: smb347_charger: Use device managed API's
Date: Fri, 09 Dec 2016 16:40:03 +0530
Message-ID: <1481281803-10627-1-git-send-email-atul.r@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:39861 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753240AbcLILMm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2016 06:12:42 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHX00CCJ0H3ZF40@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 09 Dec 2016 20:12:39 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, d.wadhawan@samsung.com, vidushi.koul@samsung.com, atulraj.nith@gmail.com, pankaj.s4@samsung.com

Using device managed API to make the code simpler

using devm_gpio_request_one in place of gpio_request_one
using devm_request_threaded_irq in place of request_threaded_irq
using devm_power_supply_register in place of power_supply_register
using gpiod_* API's in place of gpio_* API's
---
Changes in v2:
  - using gpiod_* API's in place of gpio_* API's

 drivers/power/smb347-charger.c |   59 ++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/drivers/power/smb347-charger.c b/drivers/power/smb347-charger.c
index 072c518..5b2b5cb 100644
--- a/drivers/power/smb347-charger.c
+++ b/drivers/power/smb347-charger.c
@@ -12,7 +12,7 @@
  */
 
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -145,6 +145,7 @@ struct smb347_charger {
 	bool			mains_online;
 	bool			usb_online;
 	bool			charging_enabled;
+	struct gpio_desc	*irq_gpio;
 	const struct smb347_charger_platform_data *pdata;
 };
 
@@ -835,21 +836,29 @@ static int smb347_irq_init(struct smb347_charger *smb,
 			   struct i2c_client *client)
 {
 	const struct smb347_charger_platform_data *pdata = smb->pdata;
-	int ret, irq = gpio_to_irq(pdata->irq_gpio);
+	int ret, irq;
+	struct gpio_desc *gpiod;
 
-	ret = gpio_request_one(pdata->irq_gpio, GPIOF_IN, client->name);
-	if (ret < 0)
+	smb->irq_gpio = gpio_to_desc(pdata->irq_gpio);
+	irq = gpiod_to_irq(smb->irq_gpio);
+
+	gpiod = devm_gpiod_get_optional(&client->dev, NULL, GPIOD_IN);
+	if (IS_ERR(gpiod)) {
+		ret = PTR_ERR(gpiod);
 		goto fail;
+	}
 
-	ret = request_threaded_irq(irq, NULL, smb347_interrupt,
-				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				   client->name, smb);
+
+	ret = devm_request_threaded_irq(&client->dev, irq, NULL,
+				smb347_interrupt,
+				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				client->name, smb);
 	if (ret < 0)
-		goto fail_gpio;
+		goto fail;
 
 	ret = smb347_set_writable(smb, true);
 	if (ret < 0)
-		goto fail_irq;
+		goto fail;
 
 	/*
 	 * Configure the STAT output to be suitable for interrupts: disable
@@ -867,10 +876,6 @@ static int smb347_irq_init(struct smb347_charger *smb,
 
 fail_readonly:
 	smb347_set_writable(smb, false);
-fail_irq:
-	free_irq(irq, smb);
-fail_gpio:
-	gpio_free(pdata->irq_gpio);
 fail:
 	client->irq = 0;
 	return ret;
@@ -1249,32 +1254,24 @@ static int smb347_probe(struct i2c_client *client,
 	mains_usb_cfg.num_supplicants = ARRAY_SIZE(battery);
 	mains_usb_cfg.drv_data = smb;
 	if (smb->pdata->use_mains) {
-		smb->mains = power_supply_register(dev, &smb347_mains_desc,
+		smb->mains = devm_power_supply_register(dev, &smb347_mains_desc,
 						   &mains_usb_cfg);
 		if (IS_ERR(smb->mains))
 			return PTR_ERR(smb->mains);
 	}
 
 	if (smb->pdata->use_usb) {
-		smb->usb = power_supply_register(dev, &smb347_usb_desc,
+		smb->usb = devm_power_supply_register(dev, &smb347_usb_desc,
 						 &mains_usb_cfg);
-		if (IS_ERR(smb->usb)) {
-			if (smb->pdata->use_mains)
-				power_supply_unregister(smb->mains);
+		if (IS_ERR(smb->usb))
 			return PTR_ERR(smb->usb);
-		}
 	}
 
 	battery_cfg.drv_data = smb;
-	smb->battery = power_supply_register(dev, &smb347_battery_desc,
+	smb->battery = devm_power_supply_register(dev, &smb347_battery_desc,
 					     &battery_cfg);
-	if (IS_ERR(smb->battery)) {
-		if (smb->pdata->use_usb)
-			power_supply_unregister(smb->usb);
-		if (smb->pdata->use_mains)
-			power_supply_unregister(smb->mains);
+	if (IS_ERR(smb->battery))
 		return PTR_ERR(smb->battery);
-	}
 
 	/*
 	 * Interrupt pin is optional. If it is connected, we setup the
@@ -1297,17 +1294,9 @@ static int smb347_remove(struct i2c_client *client)
 {
 	struct smb347_charger *smb = i2c_get_clientdata(client);
 
-	if (client->irq) {
+	if (client->irq)
 		smb347_irq_disable(smb);
-		free_irq(client->irq, smb);
-		gpio_free(smb->pdata->irq_gpio);
-	}
 
-	power_supply_unregister(smb->battery);
-	if (smb->pdata->use_usb)
-		power_supply_unregister(smb->usb);
-	if (smb->pdata->use_mains)
-		power_supply_unregister(smb->mains);
 	return 0;
 }
 
-- 
1.7.9.5

