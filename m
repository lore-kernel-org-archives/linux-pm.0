From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 05/16] power: supply: axp288_charger: Use regmap_update_bits to set the input limits
Date: Tue, 26 Dec 2017 13:59:03 +0100
Message-ID: <20171226125914.10235-5-hdegoede@redhat.com>
References: <20171226125914.10235-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdLZM7V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Dec 2017 07:59:21 -0500
In-Reply-To: <20171226125914.10235-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

Use regmap_update_bits in axp288_charger_set_vbus_inlmt, instead of DIY
code.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 03f502e012c3..7b48afca1a1f 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -222,14 +222,8 @@ static inline int axp288_charger_set_vbus_inlmt(struct axp288_chrg_info *info,
 					   int inlmt)
 {
 	int ret;
-	unsigned int val;
 	u8 reg_val;
 
-	/* Read in limit register */
-	ret = regmap_read(info->regmap, AXP20X_CHRG_BAK_CTRL, &val);
-	if (ret < 0)
-		goto set_inlmt_fail;
-
 	if (inlmt <= ILIM_100MA) {
 		reg_val = CHRG_VBUS_ILIM_100MA;
 		inlmt = ILIM_100MA;
@@ -253,15 +247,15 @@ static inline int axp288_charger_set_vbus_inlmt(struct axp288_chrg_info *info,
 		inlmt = ILIM_3000MA;
 	}
 
-	reg_val = (val & ~CHRG_VBUS_ILIM_MASK)
-			| (reg_val << CHRG_VBUS_ILIM_BIT_POS);
-	ret = regmap_write(info->regmap, AXP20X_CHRG_BAK_CTRL, reg_val);
+	reg_val = reg_val << CHRG_VBUS_ILIM_BIT_POS;
+
+	ret = regmap_update_bits(info->regmap, AXP20X_CHRG_BAK_CTRL,
+				 CHRG_VBUS_ILIM_MASK, reg_val);
 	if (ret >= 0)
 		info->inlmt = inlmt;
 	else
 		dev_err(&info->pdev->dev, "charger BAK control %d\n", ret);
 
-set_inlmt_fail:
 	return ret;
 }
 
-- 
2.14.3
