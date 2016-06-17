From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v3 7/7] max8903: adds support for initiation via device tree.
Date: Fri, 17 Jun 2016 15:00:26 +1000
Message-ID: <1466139626-51434-8-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466139626-51434-1-git-send-email-chris@lapa.com.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466139626-51434-1-git-send-email-chris@lapa.com.au>
In-Reply-To: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>
List-Id: linux-pm@vger.kernel.org

From: Chris Lapa <chris@lapa.com.au>

Adds support for device tree to setup a max8903 battery charger. DC and USB
validity are determined by looking the presence of the dok and uok gpios.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 drivers/power/max8903_charger.c | 217 +++++++++++++++++++++++++++-------------
 1 file changed, 145 insertions(+), 72 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index 5ddc667..3c59213 100644
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
 
@@ -179,48 +183,116 @@ static irqreturn_t max8903_fault(int irq, void *_data)
 	return IRQ_HANDLED;
 }
 
+static struct max8903_pdata *max8903_parse_dt_data(
+		struct device *dev)
+{
+	struct device_node *of_node = dev->of_node;
+	struct max8903_pdata *pdata = NULL;
+
+	if (!of_node)
+		return NULL;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata),
+				GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	pdata->dc_valid = false;
+	pdata->usb_valid = false;
+
+	pdata->cen = of_get_named_gpio(of_node, "cen-gpios", 0);
+	if (!gpio_is_valid(pdata->cen))
+		pdata->cen = -EINVAL;
+
+	pdata->chg = of_get_named_gpio(of_node, "chg-gpios", 0);
+	if (!gpio_is_valid(pdata->chg))
+		pdata->chg = -EINVAL;
+
+	pdata->flt = of_get_named_gpio(of_node, "flt-gpios", 0);
+	if (!gpio_is_valid(pdata->flt))
+		pdata->flt = -EINVAL;
+
+	pdata->usus = of_get_named_gpio(of_node, "usus-gpios", 0);
+	if (!gpio_is_valid(pdata->usus))
+		pdata->usus = -EINVAL;
+
+	pdata->dcm = of_get_named_gpio(of_node, "dcm-gpios", 0);
+	if (!gpio_is_valid(pdata->dcm))
+		pdata->dcm = -EINVAL;
+
+	pdata->dok = of_get_named_gpio(of_node, "dok-gpios", 0);
+	if (!gpio_is_valid(pdata->dok))
+		pdata->dok = -EINVAL;
+	else
+		pdata->dc_valid = true;
+
+	pdata->uok = of_get_named_gpio(of_node, "uok-gpios", 0);
+	if (!gpio_is_valid(pdata->uok))
+		pdata->uok = -EINVAL;
+	else
+		pdata->usb_valid = true;
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
 
-	if (pdata == NULL) {
+	charger = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
+	if (!charger)
+		return -ENOMEM;
+
+	charger->pdata = pdev->dev.platform_data;
+	if (IS_ENABLED(CONFIG_OF) && !charger->pdata && dev->of_node)
+		charger->pdata = max8903_parse_dt_data(dev);
+
+	if (!charger->pdata) {
 		dev_err(dev, "No platform data.\n");
 		return -EINVAL;
 	}
 
-	data = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
+	charger->dev = dev;
 
-	data->pdata = pdev->dev.platform_data;
-	data->dev = dev;
-	platform_set_drvdata(pdev, data);
+	charger->fault = false;
+	charger->ta_in = ta_in;
+	charger->usb_in = usb_in;
 
-	if (pdata->dc_valid == false && pdata->usb_valid == false) {
+	charger->psy_desc.name = "max8903_charger";
+	charger->psy_desc.type = (ta_in) ? POWER_SUPPLY_TYPE_MAINS :
+			((usb_in) ? POWER_SUPPLY_TYPE_USB :
+			 POWER_SUPPLY_TYPE_BATTERY);
+	charger->psy_desc.get_property = max8903_get_property;
+	charger->psy_desc.properties = max8903_charger_props;
+	charger->psy_desc.num_properties = ARRAY_SIZE(max8903_charger_props);
+
+	platform_set_drvdata(pdev, charger);
+
+	if (charger->pdata->dc_valid == false && charger->pdata->usb_valid == false) {
 		dev_err(dev, "No valid power sources.\n");
 		return -EINVAL;
 	}
 
-	if (pdata->dc_valid) {
-		if (gpio_is_valid(pdata->dok)) {
+
+	if (charger->pdata->dc_valid) {
+		if (gpio_is_valid(charger->pdata->dok)) {
 			ret = devm_gpio_request(dev,
-						pdata->dok,
-						data->psy_desc.name);
+						charger->pdata->dok,
+						charger->psy_desc.name);
 			if (ret) {
 				dev_err(dev,
 						"Failed GPIO request for dok: %d err %d\n",
-						pdata->dok, ret);
+						charger->pdata->dok, ret);
 				return -EINVAL;
 			}
 
-			gpio = pdata->dok; /* PULL_UPed Interrupt */
+			gpio = charger->pdata->dok; /* PULL_UPed Interrupt */
 			ta_in = gpio_get_value(gpio) ? 0 : 1;
 		} else {
 			dev_err(dev, "When DC is wired, DOK should"
@@ -229,34 +301,34 @@ static int max8903_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (gpio_is_valid(pdata->dcm)) {
+	if (gpio_is_valid(charger->pdata->dcm)) {
 		ret = devm_gpio_request(dev,
-					pdata->dcm,
-					data->psy_desc.name);
+					charger->pdata->dcm,
+					charger->psy_desc.name);
 		if (ret) {
 			dev_err(dev,
 					"Failed GPIO request for dcm: %d err %d\n",
-					pdata->dcm, ret);
+					charger->pdata->dcm, ret);
 			return -EINVAL;
 		}
 
-		gpio = pdata->dcm; /* Output */
+		gpio = charger->pdata->dcm; /* Output */
 		gpio_set_value(gpio, ta_in);
 	}
 
-	if (pdata->usb_valid) {
-		if (gpio_is_valid(pdata->uok)) {
+	if (charger->pdata->usb_valid) {
+		if (gpio_is_valid(charger->pdata->uok)) {
 			ret = devm_gpio_request(dev,
-						pdata->uok,
-						data->psy_desc.name);
+						charger->pdata->uok,
+						charger->psy_desc.name);
 			if (ret) {
 				dev_err(dev,
 						"Failed GPIO request for uok: %d err %d\n",
-						pdata->uok, ret);
+						charger->pdata->uok, ret);
 				return -EINVAL;
 			}
 
-			gpio = pdata->uok;
+			gpio = charger->pdata->uok;
 			usb_in = gpio_get_value(gpio) ? 0 : 1;
 		} else {
 			dev_err(dev, "When USB is wired, UOK should be wired."
@@ -266,111 +338,105 @@ static int max8903_probe(struct platform_device *pdev)
 	}
 
 
-	if (gpio_is_valid(pdata->cen)) {
+	if (gpio_is_valid(charger->pdata->cen)) {
 		ret = devm_gpio_request(dev,
-					pdata->cen,
-					data->psy_desc.name);
+					charger->pdata->cen,
+					charger->psy_desc.name);
 		if (ret) {
 			dev_err(dev,
 					"Failed GPIO request for cen: %d err %d\n",
-					pdata->cen, ret);
+					charger->pdata->cen, ret);
 			return -EINVAL;
 		}
 
-		gpio_set_value(pdata->cen, (ta_in || usb_in) ? 0 : 1);
+		gpio_set_value(charger->pdata->cen, (ta_in || usb_in) ? 0 : 1);
 	}
 
-	if (gpio_is_valid(pdata->chg)) {
+	if (gpio_is_valid(charger->pdata->chg)) {
 		ret = devm_gpio_request(dev,
-					pdata->chg,
-					data->psy_desc.name);
+					charger->pdata->chg,
+					charger->psy_desc.name);
 		if (ret) {
 			dev_err(dev,
 					"Failed GPIO request for chg: %d err %d\n",
-					pdata->chg, ret);
+					charger->pdata->chg, ret);
 			return -EINVAL;
 		}
 	}
 
-	if (gpio_is_valid(pdata->flt)) {
+	if (gpio_is_valid(charger->pdata->flt)) {
 		ret = devm_gpio_request(dev,
-					pdata->flt,
-					data->psy_desc.name);
+					charger->pdata->flt,
+					charger->psy_desc.name);
 		if (ret) {
 			dev_err(dev,
 					"Failed GPIO request for flt: %d err %d\n",
-					pdata->flt, ret);
+					charger->pdata->flt, ret);
 			return -EINVAL;
 		}
 	}
 
-	if (gpio_is_valid(pdata->usus)) {
+	if (gpio_is_valid(charger->pdata->usus)) {
 		ret = devm_gpio_request(dev,
-					pdata->usus,
-					data->psy_desc.name);
+					charger->pdata->usus,
+					charger->psy_desc.name);
 		if (ret) {
 			dev_err(dev,
 					"Failed GPIO request for usus: %d err %d\n",
-					pdata->usus, ret);
+					charger->pdata->usus, ret);
 			return -EINVAL;
 		}
 	}
 
-	data->fault = false;
-	data->ta_in = ta_in;
-	data->usb_in = usb_in;
-
-	data->psy_desc.name = "max8903_charger";
-	data->psy_desc.type = (ta_in) ? POWER_SUPPLY_TYPE_MAINS :
-			((usb_in) ? POWER_SUPPLY_TYPE_USB :
-			 POWER_SUPPLY_TYPE_BATTERY);
-	data->psy_desc.get_property = max8903_get_property;
-	data->psy_desc.properties = max8903_charger_props;
-	data->psy_desc.num_properties = ARRAY_SIZE(max8903_charger_props);
-
-	psy_cfg.drv_data = data;
+	psy_cfg.of_node = dev->of_node;
+	psy_cfg.drv_data = charger;
 
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
 
-	if (gpio_is_valid(pdata->flt)) {
-		ret = devm_request_threaded_irq(dev, gpio_to_irq(pdata->flt),
+	if (gpio_is_valid(charger->pdata->flt)) {
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
@@ -378,10 +444,17 @@ static int max8903_probe(struct platform_device *pdev)
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
