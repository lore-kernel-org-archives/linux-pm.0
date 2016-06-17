From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v3 3/7] max8903: cleans up confusing relationship between dc_valid, dok and dcm.
Date: Fri, 17 Jun 2016 15:00:22 +1000
Message-ID: <1466139626-51434-4-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466139626-51434-1-git-send-email-chris@lapa.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35597 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933517AbcFQFAq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 01:00:46 -0400
Received: by mail-pa0-f65.google.com with SMTP id hf6so5001584pac.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jun 2016 22:00:46 -0700 (PDT)
In-Reply-To: <1466139626-51434-1-git-send-email-chris@lapa.com.au>
In-Reply-To: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>

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
 drivers/power/max8903_charger.c       | 23 ++++++++++-------------
 include/linux/power/max8903_charger.h |  6 +++---
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index 0a5b0e1..dbd911c4 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -211,27 +211,24 @@ static int max8903_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->dc_valid) {
-		if (pdata->dok && gpio_is_valid(pdata->dok) &&
-				pdata->dcm && gpio_is_valid(pdata->dcm)) {
+		if (pdata->dok && gpio_is_valid(pdata->dok)) {
 			gpio = pdata->dok; /* PULL_UPed Interrupt */
 			ta_in = gpio_get_value(gpio) ? 0 : 1;
+		} else {
+			dev_err(dev, "When DC is wired, DOK should"
+					" be wired as well.\n");
+			return -EINVAL;
+		}
+	}
 
+	if (pdata->dcm) {
+		if (gpio_is_valid(pdata->dcm)) {
 			gpio = pdata->dcm; /* Output */
 			gpio_set_value(gpio, ta_in);
 		} else {
-			dev_err(dev, "When DC is wired, DOK and DCM should"
-					" be wired as well.\n");
+			dev_err(dev, "Invalid pin: dcm.\n");
 			return -EINVAL;
 		}
-	} else {
-		if (pdata->dcm) {
-			if (gpio_is_valid(pdata->dcm))
-				gpio_set_value(pdata->dcm, 0);
-			else {
-				dev_err(dev, "Invalid pin: dcm.\n");
-				return -EINVAL;
-			}
-		}
 	}
 
 	if (pdata->usb_valid) {
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

