From: Srikant Ritolia <s.ritolia@samsung.com>
Subject: [PATCH] power: max8997_charger: Using device managed API and remove
 OOM print
Date: Thu, 08 Dec 2016 14:42:37 +0530
Message-ID: <1481188357-11889-1-git-send-email-s.ritolia@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:39467 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbcLHJPB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2016 04:15:01 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHV00ZSC0CXZE00@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Thu, 08 Dec 2016 18:14:59 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Srikant Ritolia <s.ritolia@samsung.com>
Cc: linux-pm@vger.kernel.org, vidushi.koul@samsung.com, srikant.ritolia@gmail.com

Use managed resource function devm_power_supply_register instead of
power_supply_register to simplify the error path by allowing unregistering
to happen automatically on error and remove.
Removing max8997_battery_remove function also as it is now redundant.

Also removing out of memory printk message after kzalloc as there is
already enough information on failure.

Signed-off-by: Srikant Ritolia <s.ritolia@samsung.com>
---
 drivers/power/max8997_charger.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/power/max8997_charger.c b/drivers/power/max8997_charger.c
index 0b2eab5..66567bb 100644
--- a/drivers/power/max8997_charger.c
+++ b/drivers/power/max8997_charger.c
@@ -148,10 +148,8 @@ static int max8997_battery_probe(struct platform_device *pdev)
 
 	charger = devm_kzalloc(&pdev->dev, sizeof(struct charger_data),
 				GFP_KERNEL);
-	if (charger == NULL) {
-		dev_err(&pdev->dev, "Cannot allocate memory.\n");
+	if (!charger)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(pdev, charger);
 
@@ -161,7 +159,7 @@ static int max8997_battery_probe(struct platform_device *pdev)
 
 	psy_cfg.drv_data = charger;
 
-	charger->battery = power_supply_register(&pdev->dev,
+	charger->battery = devm_power_supply_register(&pdev->dev,
 						 &max8997_battery_desc,
 						 &psy_cfg);
 	if (IS_ERR(charger->battery)) {
@@ -172,14 +170,6 @@ static int max8997_battery_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int max8997_battery_remove(struct platform_device *pdev)
-{
-	struct charger_data *charger = platform_get_drvdata(pdev);
-
-	power_supply_unregister(charger->battery);
-	return 0;
-}
-
 static const struct platform_device_id max8997_battery_id[] = {
 	{ "max8997-battery", 0 },
 	{ }
@@ -190,7 +180,6 @@ static struct platform_driver max8997_battery_driver = {
 		.name = "max8997-battery",
 	},
 	.probe = max8997_battery_probe,
-	.remove = max8997_battery_remove,
 	.id_table = max8997_battery_id,
 };
 
-- 
1.7.9.5

