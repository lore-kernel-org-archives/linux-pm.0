From: Chris Lapa <chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>
Subject: [PATCH v3 4/7] max8903: adds requesting of gpios.
Date: Fri, 17 Jun 2016 15:00:23 +1000
Message-ID: <1466139626-51434-5-git-send-email-chris@lapa.com.au>
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

This change ensures all gpios are available for the driver to use.

Signed-off-by: Chris Lapa <chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>
---
 drivers/power/max8903_charger.c | 79 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 9 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index dbd911c4..c068efe 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -212,6 +212,16 @@ static int max8903_probe(struct platform_device *pdev)
 
 	if (pdata->dc_valid) {
 		if (pdata->dok && gpio_is_valid(pdata->dok)) {
+			ret = devm_gpio_request(dev,
+						pdata->dok,
+						data->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+						"Failed GPIO request for dok: %d err %d\n",
+						pdata->dok, ret);
+				return -EINVAL;
+			}
+
 			gpio = pdata->dok; /* PULL_UPed Interrupt */
 			ta_in = gpio_get_value(gpio) ? 0 : 1;
 		} else {
@@ -223,6 +233,16 @@ static int max8903_probe(struct platform_device *pdev)
 
 	if (pdata->dcm) {
 		if (gpio_is_valid(pdata->dcm)) {
+			ret = devm_gpio_request(dev,
+						pdata->dcm,
+						data->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+						"Failed GPIO request for dcm: %d err %d\n",
+						pdata->dcm, ret);
+				return -EINVAL;
+			}
+
 			gpio = pdata->dcm; /* Output */
 			gpio_set_value(gpio, ta_in);
 		} else {
@@ -233,6 +253,16 @@ static int max8903_probe(struct platform_device *pdev)
 
 	if (pdata->usb_valid) {
 		if (pdata->uok && gpio_is_valid(pdata->uok)) {
+			ret = devm_gpio_request(dev,
+						pdata->uok,
+						data->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+						"Failed GPIO request for uok: %d err %d\n",
+						pdata->uok, ret);
+				return -EINVAL;
+			}
+
 			gpio = pdata->uok;
 			usb_in = gpio_get_value(gpio) ? 0 : 1;
 		} else {
@@ -244,6 +274,16 @@ static int max8903_probe(struct platform_device *pdev)
 
 	if (pdata->cen) {
 		if (gpio_is_valid(pdata->cen)) {
+			ret = devm_gpio_request(dev,
+						pdata->cen,
+						data->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+						"Failed GPIO request for cen: %d err %d\n",
+						pdata->cen, ret);
+				return -EINVAL;
+			}
+
 			gpio_set_value(pdata->cen, (ta_in || usb_in) ? 0 : 1);
 		} else {
 			dev_err(dev, "Invalid pin: cen.\n");
@@ -252,23 +292,44 @@ static int max8903_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->chg) {
-		if (!gpio_is_valid(pdata->chg)) {
-			dev_err(dev, "Invalid pin: chg.\n");
-			return -EINVAL;
+		if (gpio_is_valid(pdata->chg)) {
+			ret = devm_gpio_request(dev,
+						pdata->chg,
+						data->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+						"Failed GPIO request for chg: %d err %d\n",
+						pdata->chg, ret);
+				return -EINVAL;
+			}
 		}
 	}
 
 	if (pdata->flt) {
-		if (!gpio_is_valid(pdata->flt)) {
-			dev_err(dev, "Invalid pin: flt.\n");
-			return -EINVAL;
+		if (gpio_is_valid(pdata->flt)) {
+			ret = devm_gpio_request(dev,
+						pdata->flt,
+						data->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+						"Failed GPIO request for flt: %d err %d\n",
+						pdata->flt, ret);
+				return -EINVAL;
+			}
 		}
 	}
 
 	if (pdata->usus) {
-		if (!gpio_is_valid(pdata->usus)) {
-			dev_err(dev, "Invalid pin: usus.\n");
-			return -EINVAL;
+		if (gpio_is_valid(pdata->usus)) {
+			ret = devm_gpio_request(dev,
+						pdata->usus,
+						data->psy_desc.name);
+			if (ret) {
+				dev_err(dev,
+						"Failed GPIO request for usus: %d err %d\n",
+						pdata->usus, ret);
+				return -EINVAL;
+			}
 		}
 	}
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
