From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v5 7/7] max8903: adds support for initiation via device tree
Date: Fri, 24 Jun 2016 12:26:12 +1000
Message-ID: <1466735172-13372-8-git-send-email-chris@cpdesign.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466735172-13372-1-git-send-email-chris@cpdesign.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33578 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbcFXC05 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2016 22:26:57 -0400
Received: by mail-pa0-f65.google.com with SMTP id ts6so7772887pac.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 19:26:57 -0700 (PDT)
In-Reply-To: <1466735172-13372-1-git-send-email-chris@cpdesign.com.au>
In-Reply-To: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

Adds support for device tree to setup a max8903 battery charger. DC and USB
validity are determined by looking the presence of the dok and uok gpios.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 drivers/power/max8903_charger.c | 78 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 6 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index 9453bbf..fdc73d6 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -23,6 +23,9 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <linux/power_supply.h>
 #include <linux/platform_device.h>
@@ -75,6 +78,7 @@ static int max8903_get_property(struct power_supply *psy,
 	default:
 		return -EINVAL;
 	}
+
 	return 0;
 }
 
@@ -179,6 +183,56 @@ static irqreturn_t max8903_fault(int irq, void *_data)
 	return IRQ_HANDLED;
 }
 
+static struct max8903_pdata *max8903_parse_dt_data(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct max8903_pdata *pdata = NULL;
+
+	if (!np)
+		return NULL;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	pdata->dc_valid = false;
+	pdata->usb_valid = false;
+
+	pdata->cen = of_get_named_gpio(np, "cen-gpios", 0);
+	if (!gpio_is_valid(pdata->cen))
+		pdata->cen = -EINVAL;
+
+	pdata->chg = of_get_named_gpio(np, "chg-gpios", 0);
+	if (!gpio_is_valid(pdata->chg))
+		pdata->chg = -EINVAL;
+
+	pdata->flt = of_get_named_gpio(np, "flt-gpios", 0);
+	if (!gpio_is_valid(pdata->flt))
+		pdata->flt = -EINVAL;
+
+	pdata->usus = of_get_named_gpio(np, "usus-gpios", 0);
+	if (!gpio_is_valid(pdata->usus))
+		pdata->usus = -EINVAL;
+
+	pdata->dcm = of_get_named_gpio(np, "dcm-gpios", 0);
+	if (!gpio_is_valid(pdata->dcm))
+		pdata->dcm = -EINVAL;
+
+	pdata->dok = of_get_named_gpio(np, "dok-gpios", 0);
+	if (!gpio_is_valid(pdata->dok))
+		pdata->dok = -EINVAL;
+	else
+		pdata->dc_valid = true;
+
+	pdata->uok = of_get_named_gpio(np, "uok-gpios", 0);
+	if (!gpio_is_valid(pdata->uok))
+		pdata->uok = -EINVAL;
+	else
+		pdata->usb_valid = true;
+
+	return pdata;
+}
+
 static int max8903_setup_gpios(struct platform_device *pdev)
 {
 	struct max8903_data *data = platform_get_drvdata(pdev);
@@ -298,16 +352,20 @@ static int max8903_probe(struct platform_device *pdev)
 	struct power_supply_config psy_cfg = {};
 	int ret = 0;
 
-	if (pdata == NULL) {
-		dev_err(dev, "No platform data.\n");
-		return -EINVAL;
-	}
-
 	data = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->pdata = pdev->dev.platform_data;
+	if (IS_ENABLED(CONFIG_OF) && !pdata && dev->of_node)
+		pdata = max8903_parse_dt_data(dev);
+
+	if (!pdata) {
+		dev_err(dev, "No platform data.\n");
+		return -EINVAL;
+	}
+
+	pdev->dev.platform_data = pdata;
+	data->pdata = pdata;
 	data->dev = dev;
 	platform_set_drvdata(pdev, data);
 
@@ -328,6 +386,7 @@ static int max8903_probe(struct platform_device *pdev)
 	data->psy_desc.properties = max8903_charger_props;
 	data->psy_desc.num_properties = ARRAY_SIZE(max8903_charger_props);
 
+	psy_cfg.of_node = dev->of_node;
 	psy_cfg.drv_data = data;
 
 	data->psy = devm_power_supply_register(dev, &data->psy_desc, &psy_cfg);
@@ -378,10 +437,17 @@ static int max8903_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id max8903_match_ids[] = {
+	{ .compatible = "maxim,max8903", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, max8903_match_ids);
+
 static struct platform_driver max8903_driver = {
 	.probe	= max8903_probe,
 	.driver = {
 		.name	= "max8903-charger",
+		.of_match_table = max8903_match_ids
 	},
 };
 
-- 
1.9.1

