From: Atul Raj <atul.r@samsung.com>
Subject: [PATCH] power: supply: smb347_charger: Use device managed API's
Date: Sat, 10 Dec 2016 14:05:53 +0530
Message-ID: <1481358953-30836-1-git-send-email-atul.r@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36136 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752589AbcLJIiT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Dec 2016 03:38:19 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHY00AXNNZTMQ40@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Sat, 10 Dec 2016 17:38:17 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, vidushi.koul@samsung.com, atulraj.nith@gmail.com, pankaj.s4@samsung.com

Using device manaeged API to make the code simpler

using devm_gpio_request_one in place of gpio_request_one
using devm_request_threaded_irq in place of request_threaded_irq
using devm_power_supply_register in place of power_supply_register

Signed-off-by: Atul Raj <atul.r@samsung.com>
---
 drivers/power/supply/smb347-charger.c | 46 +++++++++++------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 072c518..f39d986 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -837,19 +837,21 @@ static int smb347_irq_init(struct smb347_charger *smb,
 	const struct smb347_charger_platform_data *pdata = smb->pdata;
 	int ret, irq = gpio_to_irq(pdata->irq_gpio);
 
-	ret = gpio_request_one(pdata->irq_gpio, GPIOF_IN, client->name);
+	ret = devm_gpio_request_one(&client->dev, pdata->irq_gpio, GPIOF_IN,
+				client->name);
 	if (ret < 0)
 		goto fail;
 
-	ret = request_threaded_irq(irq, NULL, smb347_interrupt,
-				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				   client->name, smb);
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
@@ -867,10 +869,6 @@ static int smb347_irq_init(struct smb347_charger *smb,
 
 fail_readonly:
 	smb347_set_writable(smb, false);
-fail_irq:
-	free_irq(irq, smb);
-fail_gpio:
-	gpio_free(pdata->irq_gpio);
 fail:
 	client->irq = 0;
 	return ret;
@@ -1249,32 +1247,24 @@ static int smb347_probe(struct i2c_client *client,
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
@@ -1297,17 +1287,9 @@ static int smb347_remove(struct i2c_client *client)
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
2.10.2.windows.1

