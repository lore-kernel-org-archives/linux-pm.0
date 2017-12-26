From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 07/16] power: supply: axp288_charger: Do not cache input current limit value
Date: Tue, 26 Dec 2017 13:59:05 +0100
Message-ID: <20171226125914.10235-7-hdegoede@redhat.com>
References: <20171226125914.10235-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdLZM7Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Dec 2017 07:59:24 -0500
In-Reply-To: <20171226125914.10235-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

The hardware may change this underneath us.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 48 ++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 070dd79e606f..2c7b0efbbf3d 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -156,7 +156,6 @@ struct axp288_chrg_info {
 		struct work_struct work;
 	} cable;
 
-	int inlmt;
 	int cc;
 	int cv;
 	int max_cc;
@@ -217,6 +216,37 @@ static inline int axp288_charger_set_cv(struct axp288_chrg_info *info, int cv)
 	return ret;
 }
 
+static int axp288_charger_get_vbus_inlmt(struct axp288_chrg_info *info)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(info->regmap, AXP20X_CHRG_BAK_CTRL, &val);
+	if (ret < 0)
+		return ret;
+
+	val >>= CHRG_VBUS_ILIM_BIT_POS;
+	switch (val) {
+	case CHRG_VBUS_ILIM_100MA:
+		return 100000;
+	case CHRG_VBUS_ILIM_500MA:
+		return 500000;
+	case CHRG_VBUS_ILIM_900MA:
+		return 900000;
+	case CHRG_VBUS_ILIM_1500MA:
+		return 1500000;
+	case CHRG_VBUS_ILIM_2000MA:
+		return 2000000;
+	case CHRG_VBUS_ILIM_2500MA:
+		return 2500000;
+	case CHRG_VBUS_ILIM_3000MA:
+		return 3000000;
+	default:
+		dev_warn(&info->pdev->dev, "Unknown ilim reg val: %d\n", val);
+		return 0;
+	}
+}
+
 static inline int axp288_charger_set_vbus_inlmt(struct axp288_chrg_info *info,
 					   int inlmt)
 {
@@ -225,34 +255,25 @@ static inline int axp288_charger_set_vbus_inlmt(struct axp288_chrg_info *info,
 
 	if (inlmt <= ILIM_100MA) {
 		reg_val = CHRG_VBUS_ILIM_100MA;
-		inlmt = ILIM_100MA;
 	} else if (inlmt <= ILIM_500MA) {
 		reg_val = CHRG_VBUS_ILIM_500MA;
-		inlmt = ILIM_500MA;
 	} else if (inlmt <= ILIM_900MA) {
 		reg_val = CHRG_VBUS_ILIM_900MA;
-		inlmt = ILIM_900MA;
 	} else if (inlmt <= ILIM_1500MA) {
 		reg_val = CHRG_VBUS_ILIM_1500MA;
-		inlmt = ILIM_1500MA;
 	} else if (inlmt <= ILIM_2000MA) {
 		reg_val = CHRG_VBUS_ILIM_2000MA;
-		inlmt = ILIM_2000MA;
 	} else if (inlmt <= ILIM_2500MA) {
 		reg_val = CHRG_VBUS_ILIM_2500MA;
-		inlmt = ILIM_2500MA;
 	} else {
 		reg_val = CHRG_VBUS_ILIM_3000MA;
-		inlmt = ILIM_3000MA;
 	}
 
 	reg_val = reg_val << CHRG_VBUS_ILIM_BIT_POS;
 
 	ret = regmap_update_bits(info->regmap, AXP20X_CHRG_BAK_CTRL,
 				 CHRG_VBUS_ILIM_MASK, reg_val);
-	if (ret >= 0)
-		info->inlmt = inlmt;
-	else
+	if (ret < 0)
 		dev_err(&info->pdev->dev, "charger BAK control %d\n", ret);
 
 	return ret;
@@ -428,7 +449,10 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
 		val->intval = info->max_cv * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
-		val->intval = info->inlmt * 1000;
+		ret = axp288_charger_get_vbus_inlmt(info);
+		if (ret < 0)
+			return ret;
+		val->intval = ret;
 		break;
 	default:
 		return -EINVAL;
-- 
2.14.3
