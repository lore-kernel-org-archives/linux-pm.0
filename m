From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 1/5] power: supply: gpio-charger: Drop driver remove function
Date: Wed, 17 Jan 2018 21:31:14 +0100
Message-ID: <20180117203114.GB8774@lenoch>
References: <20180117202701.GA8774@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:33078 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754070AbeAQUbY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jan 2018 15:31:24 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23993497AbeAQUbXOEWfE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jan 2018 21:31:23 +0100
Content-Disposition: inline
In-Reply-To: <20180117202701.GA8774@lenoch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>

Simplify error unwinding using devm_* allocators. This also
makes driver remove function empty, so remove it.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/power/supply/gpio-charger.c | 49 ++++++++-----------------------------
 1 file changed, 10 insertions(+), 39 deletions(-)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 001731e88718..9c008ef8cf70 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -35,7 +35,6 @@ struct gpio_charger {
 	struct power_supply *charger;
 	struct power_supply_desc charger_desc;
 	struct gpio_desc *gpiod;
-	bool legacy_gpio_requested;
 };
 
 static irqreturn_t gpio_charger_irq(int irq, void *devid)
@@ -159,18 +158,12 @@ static int gpio_charger_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Invalid gpio pin in pdata\n");
 			return -EINVAL;
 		}
-		ret = gpio_request(pdata->gpio, dev_name(&pdev->dev));
-		if (ret) {
+		err = devm_gpio_request_one(&pdev->dev, pdata->gpio, GPIOF_IN,
+						dev_name(&pdev->dev));
+		if (err) {
 			dev_err(&pdev->dev, "Failed to request gpio pin: %d\n",
-				ret);
-			return ret;
-		}
-		gpio_charger->legacy_gpio_requested = true;
-		ret = gpio_direction_input(pdata->gpio);
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to set gpio to input: %d\n",
-				ret);
-			goto err_gpio_free;
+				err);
+			return err;
 		}
 		/* Then convert this to gpiod for now */
 		gpio_charger->gpiod = gpio_to_desc(pdata->gpio);
@@ -195,20 +188,19 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = gpio_charger;
 
-	gpio_charger->pdata = pdata;
-
-	gpio_charger->charger = power_supply_register(&pdev->dev,
-						      charger_desc, &psy_cfg);
+	gpio_charger->charger = devm_power_supply_register(&pdev->dev,
+							charger_desc, &psy_cfg);
 	if (IS_ERR(gpio_charger->charger)) {
 		ret = PTR_ERR(gpio_charger->charger);
 		dev_err(&pdev->dev, "Failed to register power supply: %d\n",
 			ret);
-		goto err_gpio_free;
+		return ret;
 	}
 
 	irq = gpiod_to_irq(gpio_charger->gpiod);
 	if (irq > 0) {
-		ret = request_any_context_irq(irq, gpio_charger_irq,
+		ret = devm_request_any_context_irq(&pdev->dev, irq,
+				gpio_charger_irq,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 				dev_name(&pdev->dev), gpio_charger->charger);
 		if (ret < 0)
@@ -222,26 +214,6 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, 1);
 
 	return 0;
-
-err_gpio_free:
-	if (gpio_charger->legacy_gpio_requested)
-		gpio_free(pdata->gpio);
-	return ret;
-}
-
-static int gpio_charger_remove(struct platform_device *pdev)
-{
-	struct gpio_charger *gpio_charger = platform_get_drvdata(pdev);
-
-	if (gpio_charger->irq)
-		free_irq(gpio_charger->irq, gpio_charger->charger);
-
-	power_supply_unregister(gpio_charger->charger);
-
-	if (gpio_charger->legacy_gpio_requested)
-		gpio_free(gpio_charger->pdata->gpio);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -280,7 +252,6 @@ MODULE_DEVICE_TABLE(of, gpio_charger_match);
 
 static struct platform_driver gpio_charger_driver = {
 	.probe = gpio_charger_probe,
-	.remove = gpio_charger_remove,
 	.driver = {
 		.name = "gpio-charger",
 		.pm = &gpio_charger_pm_ops,
-- 
2.15.1
