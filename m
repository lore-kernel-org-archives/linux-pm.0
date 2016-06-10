From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v2 3/4] max8903: cleans up confusing relationship between dc_valid, dok and dcm.
Date: Fri, 10 Jun 2016 22:32:49 +1000
Message-ID: <1465561970-18377-4-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1465561970-18377-1-git-send-email-chris@lapa.com.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465561970-18377-1-git-send-email-chris@lapa.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: k.kozlowski@samsung.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>
List-Id: linux-pm@vger.kernel.org

From: Chris Lapa <chris@lapa.com.au>

The max8903_charger.h file indicated that dcm and dok were not optional
when dc_valid is set.

It makes sense to have dok as a compulsory pin when dc_valid is given.
However dcm can be optionally wired to a fixed level especially when the
circuit is configured for dc power exclusively.

The previous implementation already allowed for this somewhat, however no
error was given if dok wasn't given whilst dc_valid was.

The new implementation enforces dok presence when dc_valid is given. Whilst
allowing dcm to be optional.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 drivers/power/max8903_charger.c       | 40 ++++++++++++-----------------------
 include/linux/power/max8903_charger.h |  6 +++---
 2 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index d7544c8..20d4b55 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -282,9 +282,7 @@ static int max8903_probe(struct platform_device *pdev)
 
 	if (charger->pdata->dc_valid) {
 		if (charger->pdata->dok &&
-				gpio_is_valid(charger->pdata->dok) &&
-				charger->pdata->dcm &&
-				gpio_is_valid(charger->pdata->dcm)) {
+				gpio_is_valid(charger->pdata->dok)) {
 			ret = devm_gpio_request(dev,
 						charger->pdata->dok,
 						charger->psy_desc.name);
@@ -295,6 +293,17 @@ static int max8903_probe(struct platform_device *pdev)
 				return -EINVAL;
 			}
 
+			gpio = charger->pdata->dok; /* PULL_UPed Interrupt */
+			ta_in = gpio_get_value(gpio) ? 0 : 1;
+		} else {
+			dev_err(dev, "When DC is wired, DOK should"
+					" be wired as well.\n");
+			return -EINVAL;
+		}
+	}
+
+	if (charger->pdata->dcm) {
+		if (gpio_is_valid(charger->pdata->dcm)) {
 			ret = devm_gpio_request(dev,
 						charger->pdata->dcm,
 						charger->psy_desc.name);
@@ -305,35 +314,12 @@ static int max8903_probe(struct platform_device *pdev)
 				return -EINVAL;
 			}
 
-			gpio = charger->pdata->dok; /* PULL_UPed Interrupt */
-			ta_in = gpio_get_value(gpio) ? 0 : 1;
-
 			gpio = charger->pdata->dcm; /* Output */
 			gpio_set_value(gpio, ta_in);
 		} else {
-			dev_err(dev, "When DC is wired, DOK and DCM should"
-					" be wired as well.\n");
+			dev_err(dev, "Invalid pin: dcm.\n");
 			return -EINVAL;
 		}
-	} else {
-		if (charger->pdata->dcm) {
-			if (gpio_is_valid(charger->pdata->dcm)) {
-				ret = devm_gpio_request(dev,
-							charger->pdata->dcm,
-							charger->psy_desc.name);
-				if (ret) {
-					dev_err(dev,
-						"Failed GPIO request for dcm: %d err %d\n",
-						charger->pdata->dcm, ret);
-					return -EINVAL;
-				}
-
-				gpio_set_value(charger->pdata->dcm, 0);
-			} else {
-				dev_err(dev, "Invalid pin: dcm.\n");
-				return -EINVAL;
-			}
-		}
 	}
 
 	if (charger->pdata->usb_valid) {
diff --git a/include/linux/power/max8903_charger.h b/include/linux/power/max8903_charger.h
index 24f51db..89d3f1c 100644
--- a/include/linux/power/max8903_charger.h
+++ b/include/linux/power/max8903_charger.h
@@ -26,8 +26,8 @@
 struct max8903_pdata {
 	/*
 	 * GPIOs
-	 * cen, chg, flt, and usus are optional.
-	 * dok, dcm, and uok are not optional depending on the status of
+	 * cen, chg, flt, dcm and usus are optional.
+	 * dok and uok are not optional depending on the status of
 	 * dc_valid and usb_valid.
 	 */
 	int cen;	/* Charger Enable input */
@@ -41,7 +41,7 @@ struct max8903_pdata {
 	/*
 	 * DC(Adapter/TA) is wired
 	 * When dc_valid is true,
-	 *	dok and dcm should be valid.
+	 *	dok should be valid.
 	 *
 	 * At least one of dc_valid or usb_valid should be true.
 	 */
-- 
1.9.1
