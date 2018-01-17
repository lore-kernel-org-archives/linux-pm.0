From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 2/5] power: supply: gpio-charger: use helper variable to
 access device info
Date: Wed, 17 Jan 2018 21:31:49 +0100
Message-ID: <20180117203149.GC8774@lenoch>
References: <20180117202701.GA8774@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:33078 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752974AbeAQUbv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jan 2018 15:31:51 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23994707AbeAQUbuzX8AE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jan 2018 21:31:50 +0100
Content-Disposition: inline
In-Reply-To: <20180117202701.GA8774@lenoch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>

Using explicit struct device variable makes code a bit more readable.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/power/supply/gpio-charger.c | 42 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 9c008ef8cf70..8660a886162b 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -118,7 +118,8 @@ struct gpio_charger_platform_data *gpio_charger_parse_dt(struct device *dev)
 
 static int gpio_charger_probe(struct platform_device *pdev)
 {
-	const struct gpio_charger_platform_data *pdata = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
+	const struct gpio_charger_platform_data *pdata = dev->platform_data;
 	struct power_supply_config psy_cfg = {};
 	struct gpio_charger *gpio_charger;
 	struct power_supply_desc *charger_desc;
@@ -126,19 +127,18 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	int irq;
 
 	if (!pdata) {
-		pdata = gpio_charger_parse_dt(&pdev->dev);
+		pdata = gpio_charger_parse_dt(dev);
 		if (IS_ERR(pdata)) {
 			ret = PTR_ERR(pdata);
 			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev, "No platform data\n");
+				dev_err(dev, "No platform data\n");
 			return ret;
 		}
 	}
 
-	gpio_charger = devm_kzalloc(&pdev->dev, sizeof(*gpio_charger),
-					GFP_KERNEL);
+	gpio_charger = devm_kzalloc(dev, sizeof(*gpio_charger), GFP_KERNEL);
 	if (!gpio_charger) {
-		dev_err(&pdev->dev, "Failed to alloc driver structure\n");
+		dev_err(dev, "Failed to alloc driver structure\n");
 		return -ENOMEM;
 	}
 
@@ -146,20 +146,20 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	 * This will fetch a GPIO descriptor from device tree, ACPI or
 	 * boardfile descriptor tables. It's good to try this first.
 	 */
-	gpio_charger->gpiod = devm_gpiod_get(&pdev->dev, NULL, GPIOD_IN);
+	gpio_charger->gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
 
 	/*
 	 * If this fails and we're not using device tree, try the
 	 * legacy platform data method.
 	 */
-	if (IS_ERR(gpio_charger->gpiod) && !pdev->dev.of_node) {
+	if (IS_ERR(gpio_charger->gpiod) && !dev->of_node) {
 		/* Non-DT: use legacy GPIO numbers */
 		if (!gpio_is_valid(pdata->gpio)) {
-			dev_err(&pdev->dev, "Invalid gpio pin in pdata\n");
+			dev_err(dev, "Invalid gpio pin in pdata\n");
 			return -EINVAL;
 		}
-		err = devm_gpio_request_one(&pdev->dev, pdata->gpio, GPIOF_IN,
-						dev_name(&pdev->dev));
+		err = devm_gpio_request_one(dev, pdata->gpio, GPIOF_IN,
+						dev_name(dev));
 		if (err) {
 			dev_err(&pdev->dev, "Failed to request gpio pin: %d\n",
 				err);
@@ -171,7 +171,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
 		/* Just try again if this happens */
 		if (PTR_ERR(gpio_charger->gpiod) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
-		dev_err(&pdev->dev, "error getting GPIO descriptor\n");
+		dev_err(dev, "error getting GPIO descriptor\n");
 		return PTR_ERR(gpio_charger->gpiod);
 	}
 
@@ -185,33 +185,31 @@ static int gpio_charger_probe(struct platform_device *pdev)
 
 	psy_cfg.supplied_to = pdata->supplied_to;
 	psy_cfg.num_supplicants = pdata->num_supplicants;
-	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.of_node = dev->of_node;
 	psy_cfg.drv_data = gpio_charger;
 
-	gpio_charger->charger = devm_power_supply_register(&pdev->dev,
-							charger_desc, &psy_cfg);
+	gpio_charger->charger = devm_power_supply_register(dev, charger_desc,
+							   &psy_cfg);
 	if (IS_ERR(gpio_charger->charger)) {
 		ret = PTR_ERR(gpio_charger->charger);
-		dev_err(&pdev->dev, "Failed to register power supply: %d\n",
-			ret);
+		dev_err(dev, "Failed to register power supply: %d\n", ret);
 		return ret;
 	}
 
 	irq = gpiod_to_irq(gpio_charger->gpiod);
 	if (irq > 0) {
-		ret = devm_request_any_context_irq(&pdev->dev, irq,
-				gpio_charger_irq,
+		ret = devm_request_any_context_irq(dev, irq, gpio_charger_irq,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				dev_name(&pdev->dev), gpio_charger->charger);
+				dev_name(dev), gpio_charger->charger);
 		if (ret < 0)
-			dev_warn(&pdev->dev, "Failed to request irq: %d\n", ret);
+			dev_warn(dev, "Failed to request irq: %d\n", ret);
 		else
 			gpio_charger->irq = irq;
 	}
 
 	platform_set_drvdata(pdev, gpio_charger);
 
-	device_init_wakeup(&pdev->dev, 1);
+	device_init_wakeup(dev, 1);
 
 	return 0;
 }
-- 
2.15.1
