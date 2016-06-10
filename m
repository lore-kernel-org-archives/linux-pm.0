From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v2 2/4] max8903: adds support for initiation via device tree.
Date: Fri, 10 Jun 2016 22:32:48 +1000
Message-ID: <1465561970-18377-3-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1465561970-18377-1-git-send-email-chris@lapa.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33772 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbcFJMdF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 08:33:05 -0400
Received: by mail-pa0-f65.google.com with SMTP id di3so5033249pab.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2016 05:33:05 -0700 (PDT)
In-Reply-To: <1465561970-18377-1-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: k.kozlowski@samsung.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

This commit also adds requesting gpio's via devm_gpio_request() to ensure
the gpio is available for usage by the driver.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 drivers/power/max8903_charger.c | 288 +++++++++++++++++++++++++++++++---------
 1 file changed, 225 insertions(+), 63 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index 17876ca..d7544c8 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -23,13 +23,16 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <linux/power_supply.h>
 #include <linux/platform_device.h>
 #include <linux/power/max8903_charger.h>
 
 struct max8903_data {
-	struct max8903_pdata pdata;
+	struct max8903_pdata *pdata;
 	struct device *dev;
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
@@ -53,8 +56,8 @@ static int max8903_get_property(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
-		if (data->pdata.chg) {
-			if (gpio_get_value(data->pdata.chg) == 0)
+		if (data->pdata->chg) {
+			if (gpio_get_value(data->pdata->chg) == 0)
 				val->intval = POWER_SUPPLY_STATUS_CHARGING;
 			else if (data->usb_in || data->ta_in)
 				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
@@ -75,13 +78,14 @@ static int max8903_get_property(struct power_supply *psy,
 	default:
 		return -EINVAL;
 	}
+
 	return 0;
 }
 
 static irqreturn_t max8903_dcin(int irq, void *_data)
 {
 	struct max8903_data *data = _data;
-	struct max8903_pdata *pdata = &data->pdata;
+	struct max8903_pdata *pdata = data->pdata;
 	bool ta_in;
 	enum power_supply_type old_type;
 
@@ -122,7 +126,7 @@ static irqreturn_t max8903_dcin(int irq, void *_data)
 static irqreturn_t max8903_usbin(int irq, void *_data)
 {
 	struct max8903_data *data = _data;
-	struct max8903_pdata *pdata = &data->pdata;
+	struct max8903_pdata *pdata = data->pdata;
 	bool usb_in;
 	enum power_supply_type old_type;
 
@@ -161,7 +165,7 @@ static irqreturn_t max8903_usbin(int irq, void *_data)
 static irqreturn_t max8903_fault(int irq, void *_data)
 {
 	struct max8903_data *data = _data;
-	struct max8903_pdata *pdata = &data->pdata;
+	struct max8903_pdata *pdata = data->pdata;
 	bool fault;
 
 	fault = gpio_get_value(pdata->flt) ? false : true;
@@ -179,38 +183,132 @@ static irqreturn_t max8903_fault(int irq, void *_data)
 	return IRQ_HANDLED;
 }
 
+static struct max8903_pdata *max8903_parse_dt_data(
+		struct device *dev)
+{
+	struct device_node *of_node = dev->of_node;
+	struct max8903_pdata *pdata = NULL;
+
+	if (!of_node)
+		return pdata;
+
+
+	pdata = devm_kzalloc(dev, sizeof(struct max8903_pdata),
+				GFP_KERNEL);
+	if (!pdata)
+		return pdata;
+
+	if (of_get_property(of_node, "dc_valid", NULL))
+		pdata->dc_valid = true;
+
+	if (of_get_property(of_node, "usb_valid", NULL))
+		pdata->usb_valid = true;
+
+	pdata->cen = of_get_named_gpio(of_node, "cen-gpios", 0);
+	if (!gpio_is_valid(pdata->cen))
+		pdata->cen = 0;
+
+	pdata->chg = of_get_named_gpio(of_node, "chg-gpios", 0);
+	if (!gpio_is_valid(pdata->chg))
+		pdata->chg = 0;
+
+	pdata->flt = of_get_named_gpio(of_node, "flt-gpios", 0);
+	if (!gpio_is_valid(pdata->flt))
+		pdata->flt = 0;
+
+	pdata->usus = of_get_named_gpio(of_node, "usus-gpios", 0);
+	if (!gpio_is_valid(pdata->usus))
+		pdata->usus = 0;
+
+	pdata->dcm = of_get_named_gpio(of_node, "dcm-gpios", 0);
+	if (!gpio_is_valid(pdata->dcm))
+		pdata->dcm = 0;
+
+	pdata->dok = of_get_named_gpio(of_node, "dok-gpios", 0);
+	if (!gpio_is_valid(pdata->dok))
+		pdata->dok = 0;
+
+	pdata->uok = of_get_named_gpio(of_node, "uok-gpios", 0);
+	if (!gpio_is_valid(pdata->uok))
+		pdata->uok = 0;
+
+	return pdata;
+}
+
 static int max8903_probe(struct platform_device *pdev)
 {
-	struct max8903_data *data;
+	struct max8903_data *charger;
 	struct device *dev = &pdev->dev;
-	struct max8903_pdata *pdata = pdev->dev.platform_data;
 	struct power_supply_config psy_cfg = {};
 	int ret = 0;
 	int gpio;
 	int ta_in = 0;
 	int usb_in = 0;
 
-	data = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
-	if (data == NULL) {
+	charger = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
+	if (charger == NULL) {
 		dev_err(dev, "Cannot allocate memory.\n");
 		return -ENOMEM;
 	}
-	memcpy(&data->pdata, pdata, sizeof(struct max8903_pdata));
-	data->dev = dev;
-	platform_set_drvdata(pdev, data);
 
-	if (pdata->dc_valid == false && pdata->usb_valid == false) {
+	charger->pdata = pdev->dev.platform_data;
+	if (IS_ENABLED(CONFIG_OF) && !charger->pdata && dev->of_node) {
+		charger->pdata = max8903_parse_dt_data(dev);
+		if (!charger->pdata)
+			return -EINVAL;
+	}
+
+	charger->dev = dev;
+
+	platform_set_drvdata(pdev, charger);
+
+	charger->fault = false;
+	charger->ta_in = ta_in;
+	charger->usb_in = usb_in;
+
+	charger->psy_desc.name = "max8903_charger";
+	charger->psy_desc.type = (ta_in) ? POWER_SUPPLY_TYPE_MAINS :
+			((usb_in) ? POWER_SUPPLY_TYPE_USB :
+			 POWER_SUPPLY_TYPE_BATTERY);
+	charger->psy_desc.get_property = max8903_get_property;
+	charger->psy_desc.properties = max8903_charger_props;
+	charger->psy_desc.num_properties = ARRAY_SIZE(max8903_charger_props);
+
+	if (charger->pdata->dc_valid == false &&
+			charger->pdata->usb_valid == false) {
 		dev_err(dev, "No valid power sources.\n");
 		return -EINVAL;
 	}
 
-	if (pdata->dc_valid) {
-		if (pdata->dok && gpio_is_valid(pdata->dok) &&
-				pdata->dcm && gpio_is_valid(pdata->dcm)) {
-			gpio = pdata->dok; /* PULL_UPed Interrupt */
+	if (charger->pdata->dc_valid) {
+		if (charger->pdata->dok &&
+				gpio_is_valid(charger->pdata->dok) &&
+				charger->pdata->dcm &&
+				gpio_is_valid(charger->pdata->dcm)) {
+			ret = devm_gpio_request(dev,
+						charger->pdata->dok,
+						charger->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+					"Failed GPIO request for dok: %d err %d\n",
+					charger->pdata->dok, ret);
+				return -EINVAL;
+			}
+
+			ret = devm_gpio_request(dev,
+						charger->pdata->dcm,
+						charger->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+					"Failed GPIO request for dcm: %d err %d\n",
+					charger->pdata->dcm, ret);
+				return -EINVAL;
+			}
+
+			gpio = charger->pdata->dok; /* PULL_UPed Interrupt */
 			ta_in = gpio_get_value(gpio) ? 0 : 1;
 
-			gpio = pdata->dcm; /* Output */
+			gpio = charger->pdata->dcm; /* Output */
 			gpio_set_value(gpio, ta_in);
 		} else {
 			dev_err(dev, "When DC is wired, DOK and DCM should"
@@ -218,19 +316,39 @@ static int max8903_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 	} else {
-		if (pdata->dcm) {
-			if (gpio_is_valid(pdata->dcm))
-				gpio_set_value(pdata->dcm, 0);
-			else {
+		if (charger->pdata->dcm) {
+			if (gpio_is_valid(charger->pdata->dcm)) {
+				ret = devm_gpio_request(dev,
+							charger->pdata->dcm,
+							charger->psy_desc.name);
+				if (ret) {
+					dev_err(dev,
+						"Failed GPIO request for dcm: %d err %d\n",
+						charger->pdata->dcm, ret);
+					return -EINVAL;
+				}
+
+				gpio_set_value(charger->pdata->dcm, 0);
+			} else {
 				dev_err(dev, "Invalid pin: dcm.\n");
 				return -EINVAL;
 			}
 		}
 	}
 
-	if (pdata->usb_valid) {
-		if (pdata->uok && gpio_is_valid(pdata->uok)) {
-			gpio = pdata->uok;
+	if (charger->pdata->usb_valid) {
+		if (gpio_is_valid(charger->pdata->uok)) {
+			ret = devm_gpio_request(dev,
+						charger->pdata->uok,
+						charger->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+					"Failed GPIO request for uok: %d err %d\n",
+					charger->pdata->uok, ret);
+				return -EINVAL;
+			}
+
+			gpio = charger->pdata->uok;
 			usb_in = gpio_get_value(gpio) ? 0 : 1;
 		} else {
 			dev_err(dev, "When USB is wired, UOK should be wired."
@@ -239,91 +357,128 @@ static int max8903_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (pdata->cen) {
-		if (gpio_is_valid(pdata->cen)) {
-			gpio_set_value(pdata->cen, (ta_in || usb_in) ? 0 : 1);
+	if (charger->pdata->cen) {
+		if (gpio_is_valid(charger->pdata->cen)) {
+			ret = devm_gpio_request(dev,
+						charger->pdata->cen,
+						charger->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+					"Failed GPIO request for cen: %d err %d\n",
+					charger->pdata->cen, ret);
+				return -EINVAL;
+			}
+
+			gpio_set_value(charger->pdata->cen,
+					(ta_in || usb_in) ? 0 : 1);
 		} else {
 			dev_err(dev, "Invalid pin: cen.\n");
 			return -EINVAL;
 		}
 	}
 
-	if (pdata->chg) {
-		if (!gpio_is_valid(pdata->chg)) {
+	if (charger->pdata->chg) {
+		if (gpio_is_valid(charger->pdata->chg)) {
+			ret = devm_gpio_request(dev,
+						charger->pdata->chg,
+						charger->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+					"Failed GPIO request for chg: %d err %d\n",
+					charger->pdata->chg, ret);
+				return -EINVAL;
+			}
+		} else {
 			dev_err(dev, "Invalid pin: chg.\n");
 			return -EINVAL;
 		}
 	}
 
-	if (pdata->flt) {
-		if (!gpio_is_valid(pdata->flt)) {
+	if (charger->pdata->flt) {
+		if (gpio_is_valid(charger->pdata->flt)) {
+			ret = devm_gpio_request(dev,
+						charger->pdata->flt,
+						charger->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+					"Failed GPIO request for flt: %d err %d\n",
+					charger->pdata->flt, ret);
+				return -EINVAL;
+			}
+		} else {
 			dev_err(dev, "Invalid pin: flt.\n");
 			return -EINVAL;
 		}
 	}
 
-	if (pdata->usus) {
-		if (!gpio_is_valid(pdata->usus)) {
+	if (charger->pdata->usus) {
+		if (gpio_is_valid(charger->pdata->usus)) {
+			ret = devm_gpio_request(dev,
+						charger->pdata->usus,
+						charger->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+					"Failed GPIO request for usus: %d err %d\n",
+					charger->pdata->usus, ret);
+				return -EINVAL;
+			}
+		} else {
 			dev_err(dev, "Invalid pin: usus.\n");
 			return -EINVAL;
 		}
 	}
 
-	data->fault = false;
-	data->ta_in = ta_in;
-	data->usb_in = usb_in;
+	psy_cfg.supplied_to = NULL;
+	psy_cfg.num_supplicants = 0;
+	psy_cfg.of_node = dev->of_node;
+	psy_cfg.drv_data = charger;
 
-	data->psy_desc.name = "max8903_charger";
-	data->psy_desc.type = (ta_in) ? POWER_SUPPLY_TYPE_MAINS :
-			((usb_in) ? POWER_SUPPLY_TYPE_USB :
-			 POWER_SUPPLY_TYPE_BATTERY);
-	data->psy_desc.get_property = max8903_get_property;
-	data->psy_desc.properties = max8903_charger_props;
-	data->psy_desc.num_properties = ARRAY_SIZE(max8903_charger_props);
-
-	psy_cfg.drv_data = data;
-
-	data->psy = devm_power_supply_register(dev, &data->psy_desc, &psy_cfg);
-	if (IS_ERR(data->psy)) {
+	charger->psy = devm_power_supply_register(dev,
+						&charger->psy_desc,
+						&psy_cfg);
+	if (IS_ERR(charger->psy)) {
 		dev_err(dev, "failed: power supply register.\n");
-		return PTR_ERR(data->psy);
+		return PTR_ERR(charger->psy);
 	}
 
-	if (pdata->dc_valid) {
-		ret = devm_request_threaded_irq(dev, gpio_to_irq(pdata->dok),
+	if (charger->pdata->dc_valid) {
+		ret = devm_request_threaded_irq(dev,
+					gpio_to_irq(charger->pdata->dok),
 					NULL, max8903_dcin,
 					IRQF_TRIGGER_FALLING |
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					"MAX8903 DC IN", data);
+					"MAX8903 DC IN", charger);
 		if (ret) {
 			dev_err(dev, "Cannot request irq %d for DC (%d)\n",
-					gpio_to_irq(pdata->dok), ret);
+					gpio_to_irq(charger->pdata->dok), ret);
 			return ret;
 		}
 	}
 
-	if (pdata->usb_valid) {
-		ret = devm_request_threaded_irq(dev, gpio_to_irq(pdata->uok),
+	if (charger->pdata->usb_valid) {
+		ret = devm_request_threaded_irq(dev,
+					gpio_to_irq(charger->pdata->uok),
 					NULL, max8903_usbin,
 					IRQF_TRIGGER_FALLING |
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					"MAX8903 USB IN", data);
+					"MAX8903 USB IN", charger);
 		if (ret) {
 			dev_err(dev, "Cannot request irq %d for USB (%d)\n",
-					gpio_to_irq(pdata->uok), ret);
+					gpio_to_irq(charger->pdata->uok), ret);
 			return ret;
 		}
 	}
 
-	if (pdata->flt) {
-		ret = devm_request_threaded_irq(dev, gpio_to_irq(pdata->flt),
+	if (charger->pdata->flt) {
+		ret = devm_request_threaded_irq(dev,
+					gpio_to_irq(charger->pdata->flt),
 					NULL, max8903_fault,
 					IRQF_TRIGGER_FALLING |
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					"MAX8903 Fault", data);
+					"MAX8903 Fault", charger);
 		if (ret) {
 			dev_err(dev, "Cannot request irq %d for Fault (%d)\n",
-					gpio_to_irq(pdata->flt), ret);
+					gpio_to_irq(charger->pdata->flt), ret);
 			return ret;
 		}
 	}
@@ -331,10 +486,17 @@ static int max8903_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id max8903_match_ids[] = {
+	{ .compatible = "maxim,max8903-charger", },
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

