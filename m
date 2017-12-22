From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 03/16] power: supply: axp288_charger: Remove charger-enabled state tracking
Date: Fri, 22 Dec 2017 13:37:41 +0100
Message-ID: <20171222123754.9622-3-hdegoede@redhat.com>
References: <20171222123754.9622-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751733AbdLVMh7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Dec 2017 07:37:59 -0500
In-Reply-To: <20171222123754.9622-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

The extcon code is the only one to trigger our worker (outside of the
initial run) and we can rely on it to only call us if things have
changed, so there is no need to track the charger-enabled state.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index d398f8ee296d..5d8308c8835d 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -162,7 +162,6 @@ struct axp288_chrg_info {
 	int cv;
 	int max_cc;
 	int max_cv;
-	int is_charger_enabled;
 };
 
 static inline int axp288_charger_set_cc(struct axp288_chrg_info *info, int cc)
@@ -291,9 +290,6 @@ static int axp288_charger_enable_charger(struct axp288_chrg_info *info,
 {
 	int ret;
 
-	if ((int)enable == info->is_charger_enabled)
-		return 0;
-
 	if (enable)
 		ret = regmap_update_bits(info->regmap, AXP20X_CHRG_CTRL1,
 				CHRG_CCCV_CHG_EN, CHRG_CCCV_CHG_EN);
@@ -302,8 +298,6 @@ static int axp288_charger_enable_charger(struct axp288_chrg_info *info,
 				CHRG_CCCV_CHG_EN, 0);
 	if (ret < 0)
 		dev_err(&info->pdev->dev, "axp288 enable charger %d\n", ret);
-	else
-		info->is_charger_enabled = enable;
 
 	return ret;
 }
@@ -779,7 +773,6 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	info->pdev = pdev;
 	info->regmap = axp20x->regmap;
 	info->regmap_irqc = axp20x->regmap_irqc;
-	info->is_charger_enabled = -1;
 
 	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
 	if (info->cable.edev == NULL) {
-- 
2.14.3
