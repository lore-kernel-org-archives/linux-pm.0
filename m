From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v5 5/7] max8903: removes non zero validity checks on gpios.
Date: Fri, 24 Jun 2016 12:26:10 +1000
Message-ID: <1466735172-13372-6-git-send-email-chris@cpdesign.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466735172-13372-1-git-send-email-chris@cpdesign.com.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466735172-13372-1-git-send-email-chris@cpdesign.com.au>
In-Reply-To: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>
List-Id: linux-pm@vger.kernel.org

From: Chris Lapa <chris@lapa.com.au>

Prior to this commit a zero gpio was treated as invalid. Whereas
gpio_is_valid() will treat a zero gpio as valid.

This commit removes the confusion and explicitly uses gpio_is_valid()
throughout. Which in turn results in several of the error messages becoming
redundant and thus removed.

Signed-off-by: Chris Lapa <chris@lapa.com.au>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/max8903_charger.c | 115 ++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 68 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index 3f35593..643a87a 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -53,7 +53,7 @@ static int max8903_get_property(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
-		if (data->pdata->chg) {
+		if (gpio_is_valid(data->pdata->chg)) {
 			if (gpio_get_value(data->pdata->chg) == 0)
 				val->intval = POWER_SUPPLY_STATUS_CHARGING;
 			else if (data->usb_in || data->ta_in)
@@ -93,11 +93,11 @@ static irqreturn_t max8903_dcin(int irq, void *_data)
 	data->ta_in = ta_in;
 
 	/* Set Current-Limit-Mode 1:DC 0:USB */
-	if (pdata->dcm)
+	if (gpio_is_valid(pdata->dcm))
 		gpio_set_value(pdata->dcm, ta_in ? 1 : 0);
 
 	/* Charger Enable / Disable (cen is negated) */
-	if (pdata->cen)
+	if (gpio_is_valid(pdata->cen))
 		gpio_set_value(pdata->cen, ta_in ? 0 :
 				(data->usb_in ? 0 : 1));
 
@@ -136,7 +136,7 @@ static irqreturn_t max8903_usbin(int irq, void *_data)
 	/* Do not touch Current-Limit-Mode */
 
 	/* Charger Enable / Disable (cen is negated) */
-	if (pdata->cen)
+	if (gpio_is_valid(pdata->cen))
 		gpio_set_value(pdata->cen, usb_in ? 0 :
 				(data->ta_in ? 0 : 1));
 
@@ -190,7 +190,7 @@ static int max8903_setup_gpios(struct platform_device *pdev)
 	int usb_in = 0;
 
 	if (pdata->dc_valid) {
-		if (pdata->dok && gpio_is_valid(pdata->dok)) {
+		if (gpio_is_valid(pdata->dok)) {
 			ret = devm_gpio_request(dev, pdata->dok,
 						data->psy_desc.name);
 			if (ret) {
@@ -208,27 +208,21 @@ static int max8903_setup_gpios(struct platform_device *pdev)
 		}
 	}
 
-	if (pdata->dcm) {
-		if (gpio_is_valid(pdata->dcm)) {
-			ret = devm_gpio_request(dev, pdata->dcm,
-						data->psy_desc.name);
-			if (ret) {
-				dev_err(dev,
-					"Failed GPIO request for dcm: %d err %d\n",
-					pdata->dcm, ret);
-				return ret;
-			}
-
-			gpio = pdata->dcm; /* Output */
-			gpio_set_value(gpio, ta_in);
-		} else {
-			dev_err(dev, "Invalid pin: dcm.\n");
-			return -EINVAL;
+	if (gpio_is_valid(pdata->dcm)) {
+		ret = devm_gpio_request(dev, pdata->dcm, data->psy_desc.name);
+		if (ret) {
+			dev_err(dev,
+				"Failed GPIO request for dcm: %d err %d\n",
+				pdata->dcm, ret);
+			return ret;
 		}
+
+		gpio = pdata->dcm; /* Output */
+		gpio_set_value(gpio, ta_in);
 	}
 
 	if (pdata->usb_valid) {
-		if (pdata->uok && gpio_is_valid(pdata->uok)) {
+		if (gpio_is_valid(pdata->uok)) {
 			ret = devm_gpio_request(dev, pdata->uok,
 						data->psy_desc.name);
 			if (ret) {
@@ -247,60 +241,45 @@ static int max8903_setup_gpios(struct platform_device *pdev)
 		}
 	}
 
-	if (pdata->cen) {
-		if (gpio_is_valid(pdata->cen)) {
-			ret = devm_gpio_request(dev, pdata->cen,
-						data->psy_desc.name);
-			if (ret) {
-				dev_err(dev,
-					"Failed GPIO request for cen: %d err %d\n",
-					pdata->cen, ret);
-				return ret;
-			}
-
-			gpio_set_value(pdata->cen, (ta_in || usb_in) ? 0 : 1);
-		} else {
-			dev_err(dev, "Invalid pin: cen.\n");
-			return -EINVAL;
+	if (gpio_is_valid(pdata->cen)) {
+		ret = devm_gpio_request(dev, pdata->cen, data->psy_desc.name);
+		if (ret) {
+			dev_err(dev,
+				"Failed GPIO request for cen: %d err %d\n",
+				pdata->cen, ret);
+			return ret;
 		}
+
+		gpio_set_value(pdata->cen, (ta_in || usb_in) ? 0 : 1);
 	}
 
-	if (pdata->chg) {
-		if (gpio_is_valid(pdata->chg)) {
-			ret = devm_gpio_request(dev, pdata->chg,
-						data->psy_desc.name);
-			if (ret) {
-				dev_err(dev,
-					"Failed GPIO request for chg: %d err %d\n",
-					pdata->chg, ret);
-				return ret;
-			}
+	if (gpio_is_valid(pdata->chg)) {
+		ret = devm_gpio_request(dev, pdata->chg, data->psy_desc.name);
+		if (ret) {
+			dev_err(dev,
+				"Failed GPIO request for chg: %d err %d\n",
+				pdata->chg, ret);
+			return ret;
 		}
 	}
 
-	if (pdata->flt) {
-		if (gpio_is_valid(pdata->flt)) {
-			ret = devm_gpio_request(dev, pdata->flt,
-						data->psy_desc.name);
-			if (ret) {
-				dev_err(dev,
-					"Failed GPIO request for flt: %d err %d\n",
-					pdata->flt, ret);
-				return ret;
-			}
+	if (gpio_is_valid(pdata->flt)) {
+		ret = devm_gpio_request(dev, pdata->flt, data->psy_desc.name);
+		if (ret) {
+			dev_err(dev,
+				"Failed GPIO request for flt: %d err %d\n",
+				pdata->flt, ret);
+			return ret;
 		}
 	}
 
-	if (pdata->usus) {
-		if (gpio_is_valid(pdata->usus)) {
-			ret = devm_gpio_request(dev, pdata->usus,
-						data->psy_desc.name);
-			if (ret) {
-				dev_err(dev,
-					"Failed GPIO request for usus: %d err %d\n",
-					pdata->usus, ret);
-				return ret;
-			}
+	if (gpio_is_valid(pdata->usus)) {
+		ret = devm_gpio_request(dev, pdata->usus, data->psy_desc.name);
+		if (ret) {
+			dev_err(dev,
+				"Failed GPIO request for usus: %d err %d\n",
+				pdata->usus, ret);
+			return ret;
 		}
 	}
 
@@ -385,7 +364,7 @@ static int max8903_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (pdata->flt) {
+	if (gpio_is_valid(pdata->flt)) {
 		ret = devm_request_threaded_irq(dev, gpio_to_irq(pdata->flt),
 					NULL, max8903_fault,
 					IRQF_TRIGGER_FALLING |
-- 
1.9.1
