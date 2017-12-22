From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 08/16] power: supply: axp288_charger: Pick lower input current limit not higher
Date: Fri, 22 Dec 2017 13:37:46 +0100
Message-ID: <20171222123754.9622-8-hdegoede@redhat.com>
References: <20171222123754.9622-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbdLVMiG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Dec 2017 07:38:06 -0500
In-Reply-To: <20171222123754.9622-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

The code before this commit would pick 900 mA when asking for an input
current limit of 600mA, rather then 500 mA, not good.

While touching almost all code using the silly xxxMA defines anyways,
also get rid of these simply typing out the numbers and switch the
unit to uA as that is the psy class standard unit for currents.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 52 ++++++++++++-----------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 2c7b0efbbf3d..fdca0a4a1c8e 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -99,21 +99,6 @@
 #define CV_4200MV			4200	/* 4200mV */
 #define CV_4350MV			4350	/* 4350mV */
 
-#define CC_200MA			200	/*  200mA */
-#define CC_600MA			600	/*  600mA */
-#define CC_800MA			800	/*  800mA */
-#define CC_1000MA			1000	/* 1000mA */
-#define CC_1600MA			1600	/* 1600mA */
-#define CC_2000MA			2000	/* 2000mA */
-
-#define ILIM_100MA			100	/* 100mA */
-#define ILIM_500MA			500	/* 500mA */
-#define ILIM_900MA			900	/* 900mA */
-#define ILIM_1500MA			1500	/* 1500mA */
-#define ILIM_2000MA			2000	/* 2000mA */
-#define ILIM_2500MA			2500	/* 2500mA */
-#define ILIM_3000MA			3000	/* 3000mA */
-
 #define AXP288_EXTCON_DEV_NAME		"axp288_extcon"
 #define USB_HOST_EXTCON_HID		"INT3496"
 #define USB_HOST_EXTCON_NAME		"INT3496:00"
@@ -253,23 +238,20 @@ static inline int axp288_charger_set_vbus_inlmt(struct axp288_chrg_info *info,
 	int ret;
 	u8 reg_val;
 
-	if (inlmt <= ILIM_100MA) {
-		reg_val = CHRG_VBUS_ILIM_100MA;
-	} else if (inlmt <= ILIM_500MA) {
-		reg_val = CHRG_VBUS_ILIM_500MA;
-	} else if (inlmt <= ILIM_900MA) {
-		reg_val = CHRG_VBUS_ILIM_900MA;
-	} else if (inlmt <= ILIM_1500MA) {
-		reg_val = CHRG_VBUS_ILIM_1500MA;
-	} else if (inlmt <= ILIM_2000MA) {
-		reg_val = CHRG_VBUS_ILIM_2000MA;
-	} else if (inlmt <= ILIM_2500MA) {
-		reg_val = CHRG_VBUS_ILIM_2500MA;
-	} else {
-		reg_val = CHRG_VBUS_ILIM_3000MA;
-	}
-
-	reg_val = reg_val << CHRG_VBUS_ILIM_BIT_POS;
+	if (inlmt >= 3000000)
+		reg_val = CHRG_VBUS_ILIM_3000MA << CHRG_VBUS_ILIM_BIT_POS;
+	else if (inlmt >= 2500000)
+		reg_val = CHRG_VBUS_ILIM_2500MA << CHRG_VBUS_ILIM_BIT_POS;
+	else if (inlmt >= 2000000)
+		reg_val = CHRG_VBUS_ILIM_2000MA << CHRG_VBUS_ILIM_BIT_POS;
+	else if (inlmt >= 1500000)
+		reg_val = CHRG_VBUS_ILIM_1500MA << CHRG_VBUS_ILIM_BIT_POS;
+	else if (inlmt >= 900000)
+		reg_val = CHRG_VBUS_ILIM_900MA << CHRG_VBUS_ILIM_BIT_POS;
+	else if (inlmt >= 500000)
+		reg_val = CHRG_VBUS_ILIM_500MA << CHRG_VBUS_ILIM_BIT_POS;
+	else
+		reg_val = CHRG_VBUS_ILIM_100MA << CHRG_VBUS_ILIM_BIT_POS;
 
 	ret = regmap_update_bits(info->regmap, AXP20X_CHRG_BAK_CTRL,
 				 CHRG_VBUS_ILIM_MASK, reg_val);
@@ -584,13 +566,13 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 	/* Determine cable/charger type */
 	if (extcon_get_state(edev, EXTCON_CHG_USB_SDP) > 0) {
 		dev_dbg(&info->pdev->dev, "USB SDP charger is connected\n");
-		current_limit = ILIM_500MA;
+		current_limit = 500000;
 	} else if (extcon_get_state(edev, EXTCON_CHG_USB_CDP) > 0) {
 		dev_dbg(&info->pdev->dev, "USB CDP charger is connected\n");
-		current_limit = ILIM_1500MA;
+		current_limit = 1500000;
 	} else if (extcon_get_state(edev, EXTCON_CHG_USB_DCP) > 0) {
 		dev_dbg(&info->pdev->dev, "USB DCP charger is connected\n");
-		current_limit = ILIM_2000MA;
+		current_limit = 2000000;
 	} else {
 		/* Charger type detection still in progress, bail. */
 		return;
-- 
2.14.3
