From: Devendra Naga <devendra.aaru@gmail.com>
Subject: [PATCH] power: max17040: use devm_kzalloc
Date: Sat,  5 Jan 2013 23:53:25 -0500
Message-ID: <1357448005-20896-1-git-send-email-devendra.aaru@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:47438 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310Ab3AFExk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 5 Jan 2013 23:53:40 -0500
Received: by mail-pa0-f54.google.com with SMTP id bi5so10127280pad.41
        for <linux-pm@vger.kernel.org>; Sat, 05 Jan 2013 20:53:39 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Cc: Devendra Naga <devendra.aaru@gmail.com>

use devm_kzalloc and no need of error path and unload frees

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 drivers/power/max17040_battery.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/max17040_battery.c b/drivers/power/max17040_battery.c
index 22cfe9c..74a0bd9 100644
--- a/drivers/power/max17040_battery.c
+++ b/drivers/power/max17040_battery.c
@@ -207,7 +207,7 @@ static int max17040_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
 		return -EIO;
 
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
@@ -225,7 +225,6 @@ static int max17040_probe(struct i2c_client *client,
 	ret = power_supply_register(&client->dev, &chip->battery);
 	if (ret) {
 		dev_err(&client->dev, "failed: power supply register\n");
-		kfree(chip);
 		return ret;
 	}
 
@@ -244,7 +243,6 @@ static int max17040_remove(struct i2c_client *client)
 
 	power_supply_unregister(&chip->battery);
 	cancel_delayed_work(&chip->work);
-	kfree(chip);
 	return 0;
 }
 
-- 
1.7.10.4

