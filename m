From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: [PATCH v2] power_supply: max8998: Use devm_power_supply_register
Date: Thu, 13 Aug 2015 10:24:41 +0530
Message-ID: <20150813045440.GA21920@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32999 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbbHMEyr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 00:54:47 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Use managed resource function devm_power_supply_register instead
of power_supply_register to simplify the error path by allowing
unregister to happen automatically on error. To be compatible with
the change, replace various gotos by direct returns and remove
unneeded label err.

Also, remove max8998_battery_remove as it is now redundant.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
Changes since v1:
	- Make commit log more reasonable
---
 drivers/power/max8998_charger.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/power/max8998_charger.c b/drivers/power/max8998_charger.c
index 47448d4..6014df5 100644
--- a/drivers/power/max8998_charger.c
+++ b/drivers/power/max8998_charger.c
@@ -117,8 +117,7 @@ static int max8998_battery_probe(struct platform_device *pdev)
 			"EOC value not set: leave it unchanged.\n");
 	} else {
 		dev_err(max8998->dev, "Invalid EOC value\n");
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	/* Setup Charge Restart Level */
@@ -141,8 +140,7 @@ static int max8998_battery_probe(struct platform_device *pdev)
 		break;
 	default:
 		dev_err(max8998->dev, "Invalid Restart Level\n");
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	/* Setup Charge Full Timeout */
@@ -165,34 +163,22 @@ static int max8998_battery_probe(struct platform_device *pdev)
 		break;
 	default:
 		dev_err(max8998->dev, "Invalid Full Timeout value\n");
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	psy_cfg.drv_data = max8998;
 
-	max8998->battery = power_supply_register(max8998->dev,
-						 &max8998_battery_desc,
-						 &psy_cfg);
+	max8998->battery = devm_power_supply_register(max8998->dev,
+						      &max8998_battery_desc,
+						      &psy_cfg);
 	if (IS_ERR(max8998->battery)) {
 		ret = PTR_ERR(max8998->battery);
 		dev_err(max8998->dev, "failed: power supply register: %d\n",
 			ret);
-		goto err;
+		return ret;
 	}
 
 	return 0;
-err:
-	return ret;
-}
-
-static int max8998_battery_remove(struct platform_device *pdev)
-{
-	struct max8998_battery_data *max8998 = platform_get_drvdata(pdev);
-
-	power_supply_unregister(max8998->battery);
-
-	return 0;
 }
 
 static const struct platform_device_id max8998_battery_id[] = {
-- 
1.9.1

