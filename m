From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v4 2/7] max8903: store pointer to pdata instead of copying it.
Date: Mon, 20 Jun 2016 08:27:17 +1000
Message-ID: <1466375242-38354-3-git-send-email-chris@cpdesign.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466375242-38354-1-git-send-email-chris@cpdesign.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36290 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbcFTHTU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 03:19:20 -0400
Received: by mail-pf0-f193.google.com with SMTP id i123so7973810pfg.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2016 00:19:20 -0700 (PDT)
In-Reply-To: <1466375242-38354-1-git-send-email-chris@cpdesign.com.au>
In-Reply-To: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

Stores pointer to pdata because it easily allows pdata to reference
either platform data or in the future device tree data.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 drivers/power/max8903_charger.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index 17876ca..0a5b0e1 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -29,7 +29,7 @@
 #include <linux/power/max8903_charger.h>
 
 struct max8903_data {
-	struct max8903_pdata pdata;
+	struct max8903_pdata *pdata;
 	struct device *dev;
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
@@ -53,8 +53,8 @@ static int max8903_get_property(struct power_supply *psy,
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
@@ -81,7 +81,7 @@ static int max8903_get_property(struct power_supply *psy,
 static irqreturn_t max8903_dcin(int irq, void *_data)
 {
 	struct max8903_data *data = _data;
-	struct max8903_pdata *pdata = &data->pdata;
+	struct max8903_pdata *pdata = data->pdata;
 	bool ta_in;
 	enum power_supply_type old_type;
 
@@ -122,7 +122,7 @@ static irqreturn_t max8903_dcin(int irq, void *_data)
 static irqreturn_t max8903_usbin(int irq, void *_data)
 {
 	struct max8903_data *data = _data;
-	struct max8903_pdata *pdata = &data->pdata;
+	struct max8903_pdata *pdata = data->pdata;
 	bool usb_in;
 	enum power_supply_type old_type;
 
@@ -161,7 +161,7 @@ static irqreturn_t max8903_usbin(int irq, void *_data)
 static irqreturn_t max8903_fault(int irq, void *_data)
 {
 	struct max8903_data *data = _data;
-	struct max8903_pdata *pdata = &data->pdata;
+	struct max8903_pdata *pdata = data->pdata;
 	bool fault;
 
 	fault = gpio_get_value(pdata->flt) ? false : true;
@@ -190,12 +190,18 @@ static int max8903_probe(struct platform_device *pdev)
 	int ta_in = 0;
 	int usb_in = 0;
 
+	if (pdata == NULL) {
+		dev_err(dev, "No platform data.\n");
+		return -EINVAL;
+	}
+
 	data = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(dev, "Cannot allocate memory.\n");
 		return -ENOMEM;
 	}
-	memcpy(&data->pdata, pdata, sizeof(struct max8903_pdata));
+
+	data->pdata = pdev->dev.platform_data;
 	data->dev = dev;
 	platform_set_drvdata(pdev, data);
 
-- 
1.9.1

