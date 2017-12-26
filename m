From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 01/16] power: supply: axp288_charger: Do not stop + restart charging at boot
Date: Tue, 26 Dec 2017 13:58:59 +0100
Message-ID: <20171226125914.10235-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdLZM7R (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Dec 2017 07:59:17 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

Before this commit we were relying solely on the extcon interface for
cable detection, including to determine if a cable providing vbus is
connected at all. This caused us to turn off charging at boot, because
when we run the initial state processing the axp288-extcon driver is still
running charger-type detection most of the time, so all charger cable
types read as disconnected when we run the initial state processing.

This commit reworks the axp288_charger_extcon_evt_worker flow to use the
VBUS_VALID bit from the PWR_INPUT_STATUS register to determine if we
should turn charging on/off. Note this is the same bit as we use for the
online property.

If VBUS_VALID is set, but the extcon code has not completed the charger
type detection yet, we now simply bail leaving things as configured by
the BIOS (we will get a notifier call when the extcon code is done and
reschedule the axp288_charger_extcon_evt_worker).

The extcon code is the only one to trigger the worker (outside of the
initial run) and we can rely on it to only call us if things have changed,
so while we are completely refactoring axp288_charger_extcon_evt_worker,
also remove the code to check if the state has changed.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 81 +++++++++++++----------------------
 1 file changed, 30 insertions(+), 51 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index d51ebd1da65e..54a95d196306 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -1,6 +1,7 @@
 /*
  * axp288_charger.c - X-power AXP288 PMIC Charger driver
  *
+ * Copyright (C) 2016-2017 Hans de Goede <hdegoede@redhat.com>
  * Copyright (C) 2014 Intel Corporation
  * Author: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
  *
@@ -152,8 +153,6 @@ struct axp288_chrg_info {
 	/* SDP/CDP/DCP USB charging cable notifications */
 	struct {
 		struct extcon_dev *edev;
-		bool connected;
-		enum power_supply_type chg_type;
 		struct notifier_block nb[ARRAY_SIZE(cable_ids)];
 		struct work_struct work;
 	} cable;
@@ -565,66 +564,47 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 	    container_of(work, struct axp288_chrg_info, cable.work);
 	int ret, current_limit;
 	struct extcon_dev *edev = info->cable.edev;
-	bool old_connected = info->cable.connected;
-	enum power_supply_type old_chg_type = info->cable.chg_type;
+	unsigned int val;
+
+	ret = regmap_read(info->regmap, AXP20X_PWR_INPUT_STATUS, &val);
+	if (ret < 0) {
+		dev_err(&info->pdev->dev, "Error reading status (%d)\n", ret);
+		return;
+	}
+
+	/* Offline? Disable charging and bail */
+	if (!(val & PS_STAT_VBUS_VALID)) {
+		dev_dbg(&info->pdev->dev, "USB charger disconnected\n");
+		mutex_lock(&info->lock);
+		axp288_charger_enable_charger(info, false);
+		mutex_unlock(&info->lock);
+		power_supply_changed(info->psy_usb);
+		return;
+	}
 
 	/* Determine cable/charger type */
 	if (extcon_get_state(edev, EXTCON_CHG_USB_SDP) > 0) {
 		dev_dbg(&info->pdev->dev, "USB SDP charger  is connected");
-		info->cable.connected = true;
-		info->cable.chg_type = POWER_SUPPLY_TYPE_USB;
+		current_limit = ILIM_500MA;
 	} else if (extcon_get_state(edev, EXTCON_CHG_USB_CDP) > 0) {
 		dev_dbg(&info->pdev->dev, "USB CDP charger is connected");
-		info->cable.connected = true;
-		info->cable.chg_type = POWER_SUPPLY_TYPE_USB_CDP;
+		current_limit = ILIM_1500MA;
 	} else if (extcon_get_state(edev, EXTCON_CHG_USB_DCP) > 0) {
 		dev_dbg(&info->pdev->dev, "USB DCP charger is connected");
-		info->cable.connected = true;
-		info->cable.chg_type = POWER_SUPPLY_TYPE_USB_DCP;
+		current_limit = ILIM_2000MA;
 	} else {
-		if (old_connected)
-			dev_dbg(&info->pdev->dev, "USB charger disconnected");
-		info->cable.connected = false;
-		info->cable.chg_type = POWER_SUPPLY_TYPE_USB;
-	}
-
-	/* Cable status changed */
-	if (old_connected == info->cable.connected &&
-	    old_chg_type == info->cable.chg_type)
+		/* Charger type detection still in progress, bail. */
 		return;
-
-	mutex_lock(&info->lock);
-
-	if (info->cable.connected) {
-		axp288_charger_enable_charger(info, false);
-
-		switch (info->cable.chg_type) {
-		case POWER_SUPPLY_TYPE_USB:
-			current_limit = ILIM_500MA;
-			break;
-		case POWER_SUPPLY_TYPE_USB_CDP:
-			current_limit = ILIM_1500MA;
-			break;
-		case POWER_SUPPLY_TYPE_USB_DCP:
-			current_limit = ILIM_2000MA;
-			break;
-		default:
-			/* Unknown */
-			current_limit = 0;
-			break;
-		}
-
-		/* Set vbus current limit first, then enable charger */
-		ret = axp288_charger_set_vbus_inlmt(info, current_limit);
-		if (ret == 0)
-			axp288_charger_enable_charger(info, true);
-		else
-			dev_err(&info->pdev->dev,
-				"error setting current limit (%d)", ret);
-	} else {
-		axp288_charger_enable_charger(info, false);
 	}
 
+	mutex_lock(&info->lock);
+	/* Set vbus current limit first, then enable charger */
+	ret = axp288_charger_set_vbus_inlmt(info, current_limit);
+	if (ret == 0)
+		axp288_charger_enable_charger(info, true);
+	else
+		dev_err(&info->pdev->dev,
+			"error setting current limit (%d)\n", ret);
 	mutex_unlock(&info->lock);
 
 	power_supply_changed(info->psy_usb);
@@ -799,7 +779,6 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	info->pdev = pdev;
 	info->regmap = axp20x->regmap;
 	info->regmap_irqc = axp20x->regmap_irqc;
-	info->cable.chg_type = -1;
 	info->is_charger_enabled = -1;
 
 	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
-- 
2.14.3
