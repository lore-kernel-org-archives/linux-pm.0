From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 10/16] power: supply: axp288_charger: Simplify extcon cable handling
Date: Fri, 22 Dec 2017 13:37:48 +0100
Message-ID: <20171222123754.9622-10-hdegoede@redhat.com>
References: <20171222123754.9622-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753617AbdLVMiJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Dec 2017 07:38:09 -0500
In-Reply-To: <20171222123754.9622-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

Simplify extcon cable handling using the new
devm_extcon_register_notifier_all function to listen to all cables
in one go.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 51 +++++++----------------------------
 1 file changed, 10 insertions(+), 41 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 8f4ac2d38b3f..4ec7b023c881 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -103,9 +103,6 @@
 #define USB_HOST_EXTCON_HID		"INT3496"
 #define USB_HOST_EXTCON_NAME		"INT3496:00"
 
-static const unsigned int cable_ids[] =
-	{ EXTCON_CHG_USB_SDP, EXTCON_CHG_USB_CDP, EXTCON_CHG_USB_DCP };
-
 enum {
 	VBUS_OV_IRQ = 0,
 	CHARGE_DONE_IRQ,
@@ -137,7 +134,7 @@ struct axp288_chrg_info {
 	/* SDP/CDP/DCP USB charging cable notifications */
 	struct {
 		struct extcon_dev *edev;
-		struct notifier_block nb[ARRAY_SIZE(cable_ids)];
+		struct notifier_block nb;
 		struct work_struct work;
 	} cable;
 
@@ -595,34 +592,11 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 	power_supply_changed(info->psy_usb);
 }
 
-/*
- * We need 3 copies of this, because there is no way to find out for which
- * cable id we are being called from the passed in arguments; and we must
- * have a separate nb for each extcon_register_notifier call.
- */
-static int axp288_charger_handle_cable0_evt(struct notifier_block *nb,
-					    unsigned long event, void *param)
-{
-	struct axp288_chrg_info *info =
-		container_of(nb, struct axp288_chrg_info, cable.nb[0]);
-	schedule_work(&info->cable.work);
-	return NOTIFY_OK;
-}
-
-static int axp288_charger_handle_cable1_evt(struct notifier_block *nb,
-					    unsigned long event, void *param)
+static int axp288_charger_handle_cable_evt(struct notifier_block *nb,
+					   unsigned long event, void *param)
 {
 	struct axp288_chrg_info *info =
-		container_of(nb, struct axp288_chrg_info, cable.nb[1]);
-	schedule_work(&info->cable.work);
-	return NOTIFY_OK;
-}
-
-static int axp288_charger_handle_cable2_evt(struct notifier_block *nb,
-					    unsigned long event, void *param)
-{
-	struct axp288_chrg_info *info =
-		container_of(nb, struct axp288_chrg_info, cable.nb[2]);
+		container_of(nb, struct axp288_chrg_info, cable.nb);
 	schedule_work(&info->cable.work);
 	return NOTIFY_OK;
 }
@@ -800,17 +774,12 @@ static int axp288_charger_probe(struct platform_device *pdev)
 
 	/* Register for extcon notification */
 	INIT_WORK(&info->cable.work, axp288_charger_extcon_evt_worker);
-	info->cable.nb[0].notifier_call = axp288_charger_handle_cable0_evt;
-	info->cable.nb[1].notifier_call = axp288_charger_handle_cable1_evt;
-	info->cable.nb[2].notifier_call = axp288_charger_handle_cable2_evt;
-	for (i = 0; i < ARRAY_SIZE(cable_ids); i++) {
-		ret = devm_extcon_register_notifier(dev, info->cable.edev,
-					  cable_ids[i], &info->cable.nb[i]);
-		if (ret) {
-			dev_err(dev, "failed to register extcon notifier for %u: %d\n",
-				cable_ids[i], ret);
-			return ret;
-		}
+	info->cable.nb.notifier_call = axp288_charger_handle_cable_evt;
+	ret = devm_extcon_register_notifier_all(dev, info->cable.edev,
+						&info->cable.nb);
+	if (ret) {
+		dev_err(dev, "failed to register cable extcon notifier\n");
+		return ret;
 	}
 	schedule_work(&info->cable.work);
 
-- 
2.14.3
