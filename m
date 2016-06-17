From: Chris Lapa <chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>
Subject: [PATCH v3 5/7] max8903: removes non zero validity checks on gpios.
Date: Fri, 17 Jun 2016 15:00:24 +1000
Message-ID: <1466139626-51434-6-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466139626-51434-1-git-send-email-chris@lapa.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466139626-51434-1-git-send-email-chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>
In-Reply-To: <1464849897-21527-3-git-send-email-chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>
References: <1464849897-21527-3-git-send-email-chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Lapa <chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Chris Lapa <chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>

Prior to this commit a zero gpio was treated as invalid. Whereas
gpio_is_valid() will treat a zero gpio as valid.

This commit removes the confusion and explicity uses gpio_is_valid()
throughout. Which in turn results in several of the error messages becoming
redundant and thus removed.

Signed-off-by: Chris Lapa <chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>
---
 drivers/power/max8903_charger.c | 125 ++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 70 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index c068efe..bfb81a2 100644
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
 
@@ -211,7 +211,7 @@ static int max8903_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->dc_valid) {
-		if (pdata->dok && gpio_is_valid(pdata->dok)) {
+		if (gpio_is_valid(pdata->dok)) {
 			ret = devm_gpio_request(dev,
 						pdata->dok,
 						data->psy_desc.name);
@@ -231,28 +231,23 @@ static int max8903_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (pdata->dcm) {
-		if (gpio_is_valid(pdata->dcm)) {
-			ret = devm_gpio_request(dev,
-						pdata->dcm,
-						data->psy_desc.name);
-			if (ret) {
-				dev_err(dev,
-						"Failed GPIO request for dcm: %d err %d\n",
-						pdata->dcm, ret);
-				return -EINVAL;
-			}
-
-			gpio = pdata->dcm; /* Output */
-			gpio_set_value(gpio, ta_in);
-		} else {
-			dev_err(dev, "Invalid pin: dcm.\n");
+	if (gpio_is_valid(pdata->dcm)) {
+		ret = devm_gpio_request(dev,
+					pdata->dcm,
+					data->psy_desc.name);
+		if (ret) {
+			dev_err(dev,
+					"Failed GPIO request for dcm: %d err %d\n",
+					pdata->dcm, ret);
 			return -EINVAL;
 		}
+
+		gpio = pdata->dcm; /* Output */
+		gpio_set_value(gpio, ta_in);
 	}
 
 	if (pdata->usb_valid) {
-		if (pdata->uok && gpio_is_valid(pdata->uok)) {
+		if (gpio_is_valid(pdata->uok)) {
 			ret = devm_gpio_request(dev,
 						pdata->uok,
 						data->psy_desc.name);
@@ -272,64 +267,54 @@ static int max8903_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (pdata->cen) {
-		if (gpio_is_valid(pdata->cen)) {
-			ret = devm_gpio_request(dev,
-						pdata->cen,
-						data->psy_desc.name);
-			if (ret) {
-				dev_err(dev,
-						"Failed GPIO request for cen: %d err %d\n",
-						pdata->cen, ret);
-				return -EINVAL;
-			}
 
-			gpio_set_value(pdata->cen, (ta_in || usb_in) ? 0 : 1);
-		} else {
-			dev_err(dev, "Invalid pin: cen.\n");
+	if (gpio_is_valid(pdata->cen)) {
+		ret = devm_gpio_request(dev,
+					pdata->cen,
+					data->psy_desc.name);
+		if (ret) {
+			dev_err(dev,
+					"Failed GPIO request for cen: %d err %d\n",
+					pdata->cen, ret);
 			return -EINVAL;
 		}
+
+		gpio_set_value(pdata->cen, (ta_in || usb_in) ? 0 : 1);
 	}
 
-	if (pdata->chg) {
-		if (gpio_is_valid(pdata->chg)) {
-			ret = devm_gpio_request(dev,
-						pdata->chg,
-						data->psy_desc.name);
-			if (ret) {
-				dev_err(dev,
-						"Failed GPIO request for chg: %d err %d\n",
-						pdata->chg, ret);
-				return -EINVAL;
-			}
+	if (gpio_is_valid(pdata->chg)) {
+		ret = devm_gpio_request(dev,
+					pdata->chg,
+					data->psy_desc.name);
+		if (ret) {
+			dev_err(dev,
+					"Failed GPIO request for chg: %d err %d\n",
+					pdata->chg, ret);
+			return -EINVAL;
 		}
 	}
 
-	if (pdata->flt) {
-		if (gpio_is_valid(pdata->flt)) {
-			ret = devm_gpio_request(dev,
-						pdata->flt,
-						data->psy_desc.name);
-			if (ret) {
-				dev_err(dev,
-						"Failed GPIO request for flt: %d err %d\n",
-						pdata->flt, ret);
-				return -EINVAL;
-			}
+	if (gpio_is_valid(pdata->flt)) {
+		ret = devm_gpio_request(dev,
+					pdata->flt,
+					data->psy_desc.name);
+		if (ret) {
+			dev_err(dev,
+					"Failed GPIO request for flt: %d err %d\n",
+					pdata->flt, ret);
+			return -EINVAL;
 		}
 	}
 
-	if (pdata->usus) {
-		if (gpio_is_valid(pdata->usus)) {
-			ret = devm_gpio_request(dev,
-						pdata->usus,
-						data->psy_desc.name);
-			if (ret) {
-				dev_err(dev,
-						"Failed GPIO request for usus: %d err %d\n",
-						pdata->usus, ret);
-				return -EINVAL;
-			}
+	if (gpio_is_valid(pdata->usus)) {
+		ret = devm_gpio_request(dev,
+					pdata->usus,
+					data->psy_desc.name);
+		if (ret) {
+			dev_err(dev,
+					"Failed GPIO request for usus: %d err %d\n",
+					pdata->usus, ret);
+			return -EINVAL;
 		}
 	}
 
@@ -379,7 +364,7 @@ static int max8903_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (pdata->flt) {
+	if (gpio_is_valid(pdata->flt)) {
 		ret = devm_request_threaded_irq(dev, gpio_to_irq(pdata->flt),
 					NULL, max8903_fault,
 					IRQF_TRIGGER_FALLING |
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
