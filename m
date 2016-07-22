From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 3/4] power: sbs-battery: Use devm_power_supply_register
Date: Fri, 22 Jul 2016 16:42:37 +0800
Message-ID: <1469176958-69804-4-git-send-email-preid@electromag.com.au>
References: <1469176958-69804-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:38122 "EHLO
	preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751572AbcGVIwR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2016 04:52:17 -0400
In-Reply-To: <1469176958-69804-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org
Cc: Phil Reid <preid@electromag.com.au>

Use devm_power_supply_register instead of power_supply_register.
Remove call to power_supply_unregister.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/power/sbs-battery.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index f9012ed..31f3e33 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -894,7 +894,7 @@ skip_gpio:
 		}
 	}
 
-	chip->power_supply = power_supply_register(&client->dev, sbs_desc,
+	chip->power_supply = devm_power_supply_register(&client->dev, sbs_desc,
 						   &psy_cfg);
 	if (IS_ERR(chip->power_supply)) {
 		dev_err(&client->dev,
@@ -926,8 +926,6 @@ static int sbs_remove(struct i2c_client *client)
 	if (chip->gpio_detect)
 		gpio_free(chip->pdata->battery_detect);
 
-	power_supply_unregister(chip->power_supply);
-
 	cancel_delayed_work_sync(&chip->work);
 
 	return 0;
-- 
1.8.3.1

