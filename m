From: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Subject: [PATCH 1/2] power_supply: bq2415x_charger: Fix coding style issues
Date: Tue, 12 May 2015 12:11:32 +0300
Message-ID: <1431421893-18816-2-git-send-email-anda-maria.nicolae@intel.com>
References: <1431421893-18816-1-git-send-email-anda-maria.nicolae@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:47435 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676AbbELJJ1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 May 2015 05:09:27 -0400
In-Reply-To: <1431421893-18816-1-git-send-email-anda-maria.nicolae@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

This patch fixes the following issues reported by checkpatch.pl:
- use -EINVAL instead of -ENOSYS, to fix warning message:
  "ENOSYS means 'invalid syscall nr' and nothing else"
- remove unnecessary log message
- split lines whose length is greater than 80 characters
- if an arm statement uses braces, add braces to the other arms of the
  respective statement, too
- match alignment with open parenthesis

Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
---
 drivers/power/bq2415x_charger.c |   35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index 6c534dc..2cf8ec7 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -631,7 +631,7 @@ static int bq2415x_set_charge_current(struct bq2415x_device *bq, int mA)
 	int val;
 
 	if (bq->init_data.resistor_sense <= 0)
-		return -ENOSYS;
+		return -EINVAL;
 
 	val = (mA * bq->init_data.resistor_sense - 37400) / 6800;
 	if (val < 0)
@@ -650,7 +650,7 @@ static int bq2415x_get_charge_current(struct bq2415x_device *bq)
 	int ret;
 
 	if (bq->init_data.resistor_sense <= 0)
-		return -ENOSYS;
+		return -EINVAL;
 
 	ret = bq2415x_i2c_read_mask(bq, BQ2415X_REG_CURRENT,
 			BQ2415X_MASK_VI_CHRG, BQ2415X_SHIFT_VI_CHRG);
@@ -665,7 +665,7 @@ static int bq2415x_set_termination_current(struct bq2415x_device *bq, int mA)
 	int val;
 
 	if (bq->init_data.resistor_sense <= 0)
-		return -ENOSYS;
+		return -EINVAL;
 
 	val = (mA * bq->init_data.resistor_sense - 3400) / 3400;
 	if (val < 0)
@@ -684,7 +684,7 @@ static int bq2415x_get_termination_current(struct bq2415x_device *bq)
 	int ret;
 
 	if (bq->init_data.resistor_sense <= 0)
-		return -ENOSYS;
+		return -EINVAL;
 
 	ret = bq2415x_i2c_read_mask(bq, BQ2415X_REG_CURRENT,
 			BQ2415X_MASK_VI_TERM, BQ2415X_SHIFT_VI_TERM);
@@ -1166,7 +1166,7 @@ static ssize_t bq2415x_sysfs_set_mode(struct device *dev,
 
 	if (strncmp(buf, "auto", 4) == 0) {
 		if (bq->automode < 0)
-			return -ENOSYS;
+			return -EINVAL;
 		bq->automode = 1;
 		mode = bq->reported_mode;
 	} else if (strncmp(buf, "off", 3) == 0) {
@@ -1556,28 +1556,28 @@ static int bq2415x_probe(struct i2c_client *client,
 
 	bq = devm_kzalloc(&client->dev, sizeof(*bq), GFP_KERNEL);
 	if (!bq) {
-		dev_err(&client->dev, "failed to allocate device data\n");
 		ret = -ENOMEM;
 		goto error_2;
 	}
 
 	if (np) {
-		bq->notify_psy = power_supply_get_by_phandle(np, "ti,usb-charger-detection");
+		bq->notify_psy = power_supply_get_by_phandle(np,
+						"ti,usb-charger-detection");
 
 		if (IS_ERR(bq->notify_psy)) {
 			dev_info(&client->dev,
-				"no 'ti,usb-charger-detection' property (err=%ld)\n",
+				 "no 'ti,usb-charger-detection' property (err=%ld)\n",
 				PTR_ERR(bq->notify_psy));
 			bq->notify_psy = NULL;
 		} else if (!bq->notify_psy) {
 			ret = -EPROBE_DEFER;
 			goto error_2;
 		}
-	}
-	else if (pdata->notify_device)
+	} else if (pdata->notify_device) {
 		bq->notify_psy = power_supply_get_by_name(pdata->notify_device);
-	else
+	} else {
 		bq->notify_psy = NULL;
+	}
 
 	i2c_set_clientdata(client, bq);
 
@@ -1592,11 +1592,11 @@ static int bq2415x_probe(struct i2c_client *client,
 
 	if (np) {
 		ret = of_property_read_u32(np, "ti,current-limit",
-				&bq->init_data.current_limit);
+					   &bq->init_data.current_limit);
 		if (ret)
 			goto error_3;
 		ret = of_property_read_u32(np, "ti,weak-battery-voltage",
-				&bq->init_data.weak_battery_voltage);
+					   &bq->init_data.weak_battery_voltage);
 		if (ret)
 			goto error_3;
 		ret = of_property_read_u32(np, "ti,battery-regulation-voltage",
@@ -1604,15 +1604,15 @@ static int bq2415x_probe(struct i2c_client *client,
 		if (ret)
 			goto error_3;
 		ret = of_property_read_u32(np, "ti,charge-current",
-				&bq->init_data.charge_current);
+					   &bq->init_data.charge_current);
 		if (ret)
 			goto error_3;
 		ret = of_property_read_u32(np, "ti,termination-current",
-				&bq->init_data.termination_current);
+					   &bq->init_data.termination_current);
 		if (ret)
 			goto error_3;
 		ret = of_property_read_u32(np, "ti,resistor-sense",
-				&bq->init_data.resistor_sense);
+					   &bq->init_data.resistor_sense);
 		if (ret)
 			goto error_3;
 	} else {
@@ -1648,7 +1648,8 @@ static int bq2415x_probe(struct i2c_client *client,
 		}
 
 		/* Query for initial reported_mode and set it */
-		bq2415x_notifier_call(&bq->nb, PSY_EVENT_PROP_CHANGED, bq->notify_psy);
+		bq2415x_notifier_call(&bq->nb, PSY_EVENT_PROP_CHANGED,
+				      bq->notify_psy);
 		bq2415x_set_mode(bq, bq->reported_mode);
 
 		bq->automode = 1;
-- 
1.7.9.5

