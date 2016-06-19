From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v4 4/7] max8903: adds requesting of gpios.
Date: Mon, 20 Jun 2016 08:27:19 +1000
Message-ID: <1466375242-38354-5-git-send-email-chris@cpdesign.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466375242-38354-1-git-send-email-chris@cpdesign.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33401 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbcFTHT2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 03:19:28 -0400
Received: by mail-pa0-f67.google.com with SMTP id ts6so10385176pac.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2016 00:19:28 -0700 (PDT)
In-Reply-To: <1466375242-38354-1-git-send-email-chris@cpdesign.com.au>
In-Reply-To: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

This change ensures all gpios are available for the driver to use and also
splits off gpio setup into its own function for readability.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 drivers/power/max8903_charger.c | 136 ++++++++++++++++++++++++++++++----------
 1 file changed, 102 insertions(+), 34 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index 6ec705f..3f35593 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -179,39 +179,27 @@ static irqreturn_t max8903_fault(int irq, void *_data)
 	return IRQ_HANDLED;
 }
 
-static int max8903_probe(struct platform_device *pdev)
+static int max8903_setup_gpios(struct platform_device *pdev)
 {
-	struct max8903_data *data;
+	struct max8903_data *data = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
 	struct max8903_pdata *pdata = pdev->dev.platform_data;
-	struct power_supply_config psy_cfg = {};
 	int ret = 0;
 	int gpio;
 	int ta_in = 0;
 	int usb_in = 0;
 
-	if (pdata == NULL) {
-		dev_err(dev, "No platform data.\n");
-		return -EINVAL;
-	}
-
-	data = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
-	if (data == NULL) {
-		dev_err(dev, "Cannot allocate memory.\n");
-		return -ENOMEM;
-	}
-
-	data->pdata = pdev->dev.platform_data;
-	data->dev = dev;
-	platform_set_drvdata(pdev, data);
-
-	if (pdata->dc_valid == false && pdata->usb_valid == false) {
-		dev_err(dev, "No valid power sources.\n");
-		return -EINVAL;
-	}
-
 	if (pdata->dc_valid) {
 		if (pdata->dok && gpio_is_valid(pdata->dok)) {
+			ret = devm_gpio_request(dev, pdata->dok,
+						data->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+					"Failed GPIO request for dok: %d err %d\n",
+					pdata->dok, ret);
+				return ret;
+			}
+
 			gpio = pdata->dok; /* PULL_UPed Interrupt */
 			ta_in = gpio_get_value(gpio) ? 0 : 1;
 		} else {
@@ -222,6 +210,15 @@ static int max8903_probe(struct platform_device *pdev)
 
 	if (pdata->dcm) {
 		if (gpio_is_valid(pdata->dcm)) {
+			ret = devm_gpio_request(dev, pdata->dcm,
+						data->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+					"Failed GPIO request for dcm: %d err %d\n",
+					pdata->dcm, ret);
+				return ret;
+			}
+
 			gpio = pdata->dcm; /* Output */
 			gpio_set_value(gpio, ta_in);
 		} else {
@@ -232,6 +229,15 @@ static int max8903_probe(struct platform_device *pdev)
 
 	if (pdata->usb_valid) {
 		if (pdata->uok && gpio_is_valid(pdata->uok)) {
+			ret = devm_gpio_request(dev, pdata->uok,
+						data->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+					"Failed GPIO request for uok: %d err %d\n",
+					pdata->uok, ret);
+				return ret;
+			}
+
 			gpio = pdata->uok;
 			usb_in = gpio_get_value(gpio) ? 0 : 1;
 		} else {
@@ -243,6 +249,15 @@ static int max8903_probe(struct platform_device *pdev)
 
 	if (pdata->cen) {
 		if (gpio_is_valid(pdata->cen)) {
+			ret = devm_gpio_request(dev, pdata->cen,
+						data->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+					"Failed GPIO request for cen: %d err %d\n",
+					pdata->cen, ret);
+				return ret;
+			}
+
 			gpio_set_value(pdata->cen, (ta_in || usb_in) ? 0 : 1);
 		} else {
 			dev_err(dev, "Invalid pin: cen.\n");
@@ -251,23 +266,41 @@ static int max8903_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->chg) {
-		if (!gpio_is_valid(pdata->chg)) {
-			dev_err(dev, "Invalid pin: chg.\n");
-			return -EINVAL;
+		if (gpio_is_valid(pdata->chg)) {
+			ret = devm_gpio_request(dev, pdata->chg,
+						data->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+					"Failed GPIO request for chg: %d err %d\n",
+					pdata->chg, ret);
+				return ret;
+			}
 		}
 	}
 
 	if (pdata->flt) {
-		if (!gpio_is_valid(pdata->flt)) {
-			dev_err(dev, "Invalid pin: flt.\n");
-			return -EINVAL;
+		if (gpio_is_valid(pdata->flt)) {
+			ret = devm_gpio_request(dev, pdata->flt,
+						data->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+					"Failed GPIO request for flt: %d err %d\n",
+					pdata->flt, ret);
+				return ret;
+			}
 		}
 	}
 
 	if (pdata->usus) {
-		if (!gpio_is_valid(pdata->usus)) {
-			dev_err(dev, "Invalid pin: usus.\n");
-			return -EINVAL;
+		if (gpio_is_valid(pdata->usus)) {
+			ret = devm_gpio_request(dev, pdata->usus,
+						data->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+					"Failed GPIO request for usus: %d err %d\n",
+					pdata->usus, ret);
+				return ret;
+			}
 		}
 	}
 
@@ -275,9 +308,44 @@ static int max8903_probe(struct platform_device *pdev)
 	data->ta_in = ta_in;
 	data->usb_in = usb_in;
 
+	return 0;
+}
+
+static int max8903_probe(struct platform_device *pdev)
+{
+	struct max8903_data *data;
+	struct device *dev = &pdev->dev;
+	struct max8903_pdata *pdata = pdev->dev.platform_data;
+	struct power_supply_config psy_cfg = {};
+	int ret = 0;
+
+	if (pdata == NULL) {
+		dev_err(dev, "No platform data.\n");
+		return -EINVAL;
+	}
+
+	data = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
+	if (data == NULL) {
+		dev_err(dev, "Cannot allocate memory.\n");
+		return -ENOMEM;
+	}
+
+	data->pdata = pdev->dev.platform_data;
+	data->dev = dev;
+	platform_set_drvdata(pdev, data);
+
+	if (pdata->dc_valid == false && pdata->usb_valid == false) {
+		dev_err(dev, "No valid power sources.\n");
+		return -EINVAL;
+	}
+
+	ret = max8903_setup_gpios(pdev);
+	if (ret)
+		return ret;
+
 	data->psy_desc.name = "max8903_charger";
-	data->psy_desc.type = (ta_in) ? POWER_SUPPLY_TYPE_MAINS :
-			((usb_in) ? POWER_SUPPLY_TYPE_USB :
+	data->psy_desc.type = (data->ta_in) ? POWER_SUPPLY_TYPE_MAINS :
+			((data->usb_in) ? POWER_SUPPLY_TYPE_USB :
 			 POWER_SUPPLY_TYPE_BATTERY);
 	data->psy_desc.get_property = max8903_get_property;
 	data->psy_desc.properties = max8903_charger_props;
-- 
1.9.1

