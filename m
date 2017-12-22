From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 06/16] power: supply: axp288_charger: Remove no longer needed locking
Date: Fri, 22 Dec 2017 13:37:44 +0100
Message-ID: <20171222123754.9622-6-hdegoede@redhat.com>
References: <20171222123754.9622-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbdLVMiE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Dec 2017 07:38:04 -0500
In-Reply-To: <20171222123754.9622-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

Now that we use regmap to do read-modify-write ops everywhere, we can
rely on the regmap lock and no longer need our own lock.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 7b48afca1a1f..070dd79e606f 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -140,7 +140,6 @@ struct axp288_chrg_info {
 	struct regmap_irq_chip_data *regmap_irqc;
 	int irq[CHRG_INTR_END];
 	struct power_supply *psy_usb;
-	struct mutex lock;
 
 	/* OTG/Host mode */
 	struct {
@@ -361,8 +360,6 @@ static int axp288_charger_usb_set_property(struct power_supply *psy,
 	int ret = 0;
 	int scaled_val;
 
-	mutex_lock(&info->lock);
-
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		scaled_val = min(val->intval, info->max_cc);
@@ -382,7 +379,6 @@ static int axp288_charger_usb_set_property(struct power_supply *psy,
 		ret = -EINVAL;
 	}
 
-	mutex_unlock(&info->lock);
 	return ret;
 }
 
@@ -391,9 +387,7 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
 				    union power_supply_propval *val)
 {
 	struct axp288_chrg_info *info = power_supply_get_drvdata(psy);
-	int ret = 0;
-
-	mutex_lock(&info->lock);
+	int ret;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -404,7 +398,7 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
 		}
 		ret = axp288_charger_is_present(info);
 		if (ret < 0)
-			goto psy_get_prop_fail;
+			return ret;
 		val->intval = ret;
 		break;
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -415,7 +409,7 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
 		}
 		ret = axp288_charger_is_online(info);
 		if (ret < 0)
-			goto psy_get_prop_fail;
+			return ret;
 		val->intval = ret;
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
@@ -437,13 +431,10 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
 		val->intval = info->inlmt * 1000;
 		break;
 	default:
-		ret = -EINVAL;
-		goto psy_get_prop_fail;
+		return -EINVAL;
 	}
 
-psy_get_prop_fail:
-	mutex_unlock(&info->lock);
-	return ret;
+	return 0;
 }
 
 static int axp288_charger_property_is_writeable(struct power_supply *psy,
@@ -561,9 +552,7 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 	/* Offline? Disable charging and bail */
 	if (!(val & PS_STAT_VBUS_VALID)) {
 		dev_dbg(&info->pdev->dev, "USB charger disconnected\n");
-		mutex_lock(&info->lock);
 		axp288_charger_enable_charger(info, false);
-		mutex_unlock(&info->lock);
 		power_supply_changed(info->psy_usb);
 		return;
 	}
@@ -583,7 +572,6 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 		return;
 	}
 
-	mutex_lock(&info->lock);
 	/* Set vbus current limit first, then enable charger */
 	ret = axp288_charger_set_vbus_inlmt(info, current_limit);
 	if (ret == 0)
@@ -591,7 +579,6 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 	else
 		dev_err(&info->pdev->dev,
 			"error setting current limit (%d)\n", ret);
-	mutex_unlock(&info->lock);
 
 	power_supply_changed(info->psy_usb);
 }
@@ -784,7 +771,6 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, info);
-	mutex_init(&info->lock);
 
 	ret = charger_init_hw_regs(info);
 	if (ret)
-- 
2.14.3
