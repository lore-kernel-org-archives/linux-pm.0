From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: [PATCH] 88pm860x_battery: Convert to using managed resources
Date: Thu, 17 Sep 2015 18:03:40 +0530
Message-ID: <20150917123340.GA10489@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use managed resource functions devm_request_threaded_irq and
devm_power_supply_register to simplify error handling.

To be compatible with the change, various gotos are replaced
with direct returns and unneeded labels are dropped. Also,
remove pm860x_battery_remove as it is now redundant.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 drivers/power/88pm860x_battery.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/power/88pm860x_battery.c b/drivers/power/88pm860x_battery.c
index d49579b..63c57dc 100644
--- a/drivers/power/88pm860x_battery.c
+++ b/drivers/power/88pm860x_battery.c
@@ -954,47 +954,33 @@ static int pm860x_battery_probe(struct platform_device *pdev)
 	else
 		info->resistor = 300;	/* set default internal resistor */
 
-	info->battery = power_supply_register(&pdev->dev, &pm860x_battery_desc,
-					      NULL);
+	info->battery = devm_power_supply_register(&pdev->dev,
+						   &pm860x_battery_desc,
+						   NULL);
 	if (IS_ERR(info->battery))
 		return PTR_ERR(info->battery);
 	info->battery->dev.parent = &pdev->dev;
 
-	ret = request_threaded_irq(info->irq_cc, NULL,
-				pm860x_coulomb_handler, IRQF_ONESHOT,
-				"coulomb", info);
+	ret = devm_request_threaded_irq(chip->dev, info->irq_cc, NULL,
+					pm860x_coulomb_handler, IRQF_ONESHOT,
+					"coulomb", info);
 	if (ret < 0) {
 		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
 			info->irq_cc, ret);
-		goto out_reg;
+		return ret;
 	}
 
-	ret = request_threaded_irq(info->irq_batt, NULL, pm860x_batt_handler,
-				IRQF_ONESHOT, "battery", info);
+	ret = devm_request_threaded_irq(chip->dev, info->irq_batt, NULL,
+					pm860x_batt_handler,
+					IRQF_ONESHOT, "battery", info);
 	if (ret < 0) {
 		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
 			info->irq_batt, ret);
-		goto out_coulomb;
+		return ret;
 	}
 
 
 	return 0;
-
-out_coulomb:
-	free_irq(info->irq_cc, info);
-out_reg:
-	power_supply_unregister(info->battery);
-	return ret;
-}
-
-static int pm860x_battery_remove(struct platform_device *pdev)
-{
-	struct pm860x_battery_info *info = platform_get_drvdata(pdev);
-
-	free_irq(info->irq_batt, info);
-	free_irq(info->irq_cc, info);
-	power_supply_unregister(info->battery);
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1028,7 +1014,6 @@ static struct platform_driver pm860x_battery_driver = {
 		   .pm = &pm860x_battery_pm_ops,
 	},
 	.probe = pm860x_battery_probe,
-	.remove = pm860x_battery_remove,
 };
 module_platform_driver(pm860x_battery_driver);
 
-- 
1.9.1
