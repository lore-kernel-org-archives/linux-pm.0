From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: [PATCH] max8903_charger: Convert to using managed resources
Date: Thu, 17 Sep 2015 18:55:00 +0530
Message-ID: <20150917132500.GA12639@localhost>
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
remove max8903_remove as it is now redundant.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 drivers/power/max8903_charger.c | 93 +++++++++++++----------------------------
 1 file changed, 28 insertions(+), 65 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index bf2b4b3..6d39d52 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -201,8 +201,7 @@ static int max8903_probe(struct platform_device *pdev)
 
 	if (pdata->dc_valid == false && pdata->usb_valid == false) {
 		dev_err(dev, "No valid power sources.\n");
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	if (pdata->dc_valid) {
@@ -216,8 +215,7 @@ static int max8903_probe(struct platform_device *pdev)
 		} else {
 			dev_err(dev, "When DC is wired, DOK and DCM should"
 					" be wired as well.\n");
-			ret = -EINVAL;
-			goto err;
+			return -EINVAL;
 		}
 	} else {
 		if (pdata->dcm) {
@@ -225,8 +223,7 @@ static int max8903_probe(struct platform_device *pdev)
 				gpio_set_value(pdata->dcm, 0);
 			else {
 				dev_err(dev, "Invalid pin: dcm.\n");
-				ret = -EINVAL;
-				goto err;
+				return -EINVAL;
 			}
 		}
 	}
@@ -238,8 +235,7 @@ static int max8903_probe(struct platform_device *pdev)
 		} else {
 			dev_err(dev, "When USB is wired, UOK should be wired."
 					"as well.\n");
-			ret = -EINVAL;
-			goto err;
+			return -EINVAL;
 		}
 	}
 
@@ -248,32 +244,28 @@ static int max8903_probe(struct platform_device *pdev)
 			gpio_set_value(pdata->cen, (ta_in || usb_in) ? 0 : 1);
 		} else {
 			dev_err(dev, "Invalid pin: cen.\n");
-			ret = -EINVAL;
-			goto err;
+			return -EINVAL;
 		}
 	}
 
 	if (pdata->chg) {
 		if (!gpio_is_valid(pdata->chg)) {
 			dev_err(dev, "Invalid pin: chg.\n");
-			ret = -EINVAL;
-			goto err;
+			return -EINVAL;
 		}
 	}
 
 	if (pdata->flt) {
 		if (!gpio_is_valid(pdata->flt)) {
 			dev_err(dev, "Invalid pin: flt.\n");
-			ret = -EINVAL;
-			goto err;
+			return -EINVAL;
 		}
 	}
 
 	if (pdata->usus) {
 		if (!gpio_is_valid(pdata->usus)) {
 			dev_err(dev, "Invalid pin: usus.\n");
-			ret = -EINVAL;
-			goto err;
+			return -EINVAL;
 		}
 	}
 
@@ -291,85 +283,56 @@ static int max8903_probe(struct platform_device *pdev)
 
 	psy_cfg.drv_data = data;
 
-	data->psy = power_supply_register(dev, &data->psy_desc, &psy_cfg);
+	data->psy = devm_power_supply_register(dev, &data->psy_desc, &psy_cfg);
 	if (IS_ERR(data->psy)) {
 		dev_err(dev, "failed: power supply register.\n");
-		ret = PTR_ERR(data->psy);
-		goto err;
+		return PTR_ERR(data->psy);
 	}
 
 	if (pdata->dc_valid) {
-		ret = request_threaded_irq(gpio_to_irq(pdata->dok),
-				NULL, max8903_dcin,
-				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-				"MAX8903 DC IN", data);
+		ret = devm_request_threaded_irq(dev, gpio_to_irq(pdata->dok),
+						NULL, max8903_dcin,
+						IRQF_TRIGGER_FALLING |
+						IRQF_TRIGGER_RISING,
+						"MAX8903 DC IN", data);
 		if (ret) {
 			dev_err(dev, "Cannot request irq %d for DC (%d)\n",
 					gpio_to_irq(pdata->dok), ret);
-			goto err_psy;
+			return ret;
 		}
 	}
 
 	if (pdata->usb_valid) {
-		ret = request_threaded_irq(gpio_to_irq(pdata->uok),
-				NULL, max8903_usbin,
-				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-				"MAX8903 USB IN", data);
+		ret = devm_request_threaded_irq(dev, gpio_to_irq(pdata->uok),
+						NULL, max8903_usbin,
+						IRQF_TRIGGER_FALLING |
+						IRQF_TRIGGER_RISING,
+						"MAX8903 USB IN", data);
 		if (ret) {
 			dev_err(dev, "Cannot request irq %d for USB (%d)\n",
 					gpio_to_irq(pdata->uok), ret);
-			goto err_dc_irq;
+			return ret;
 		}
 	}
 
 	if (pdata->flt) {
-		ret = request_threaded_irq(gpio_to_irq(pdata->flt),
-				NULL, max8903_fault,
-				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-				"MAX8903 Fault", data);
+		ret = devm_request_threaded_irq(dev, gpio_to_irq(pdata->flt),
+						NULL, max8903_fault,
+						IRQF_TRIGGER_FALLING |
+						IRQF_TRIGGER_RISING,
+						"MAX8903 Fault", data);
 		if (ret) {
 			dev_err(dev, "Cannot request irq %d for Fault (%d)\n",
 					gpio_to_irq(pdata->flt), ret);
-			goto err_usb_irq;
+			return ret;
 		}
 	}
 
 	return 0;
-
-err_usb_irq:
-	if (pdata->usb_valid)
-		free_irq(gpio_to_irq(pdata->uok), data);
-err_dc_irq:
-	if (pdata->dc_valid)
-		free_irq(gpio_to_irq(pdata->dok), data);
-err_psy:
-	power_supply_unregister(data->psy);
-err:
-	return ret;
-}
-
-static int max8903_remove(struct platform_device *pdev)
-{
-	struct max8903_data *data = platform_get_drvdata(pdev);
-
-	if (data) {
-		struct max8903_pdata *pdata = &data->pdata;
-
-		if (pdata->flt)
-			free_irq(gpio_to_irq(pdata->flt), data);
-		if (pdata->usb_valid)
-			free_irq(gpio_to_irq(pdata->uok), data);
-		if (pdata->dc_valid)
-			free_irq(gpio_to_irq(pdata->dok), data);
-		power_supply_unregister(data->psy);
-	}
-
-	return 0;
 }
 
 static struct platform_driver max8903_driver = {
 	.probe	= max8903_probe,
-	.remove	= max8903_remove,
 	.driver = {
 		.name	= "max8903-charger",
 	},
-- 
1.9.1
