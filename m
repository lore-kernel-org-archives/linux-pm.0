From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 03/12] power: supply: axp288_charger: Use devm_power_supply_register
Date: Wed, 21 Dec 2016 15:36:48 +0100
Message-ID: <20161221143657.322-4-hdegoede@redhat.com>
References: <20161221143657.322-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161221143657.322-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

Use devm_power_supply_register instead of power_supply_register,
this avoids the need to do manual cleanup and results in quite
a nice code cleanup.

Note it may seem excessive to add a "struct device *dev" helper local
variable for the 1 time it is used in this patch, but future patches
in this series also use it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Rebase on top of for-next-next
-Only switch to devm_power_supply_register, for-next-next has already switched
 to devm_extcon_register_notifier
---
 drivers/power/supply/axp288_charger.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 5caa154..d929742 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -812,6 +812,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 {
 	int ret, i, pirq;
 	struct axp288_chrg_info *info;
+	struct device *dev = &pdev->dev;
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config charger_cfg = {};
 
@@ -862,12 +863,12 @@ static int axp288_charger_probe(struct platform_device *pdev)
 
 	/* Register with power supply class */
 	charger_cfg.drv_data = info;
-	info->psy_usb = power_supply_register(&pdev->dev, &axp288_charger_desc,
-						&charger_cfg);
+	info->psy_usb = devm_power_supply_register(dev, &axp288_charger_desc,
+						   &charger_cfg);
 	if (IS_ERR(info->psy_usb)) {
-		dev_err(&pdev->dev, "failed to register power supply charger\n");
 		ret = PTR_ERR(info->psy_usb);
-		goto psy_reg_failed;
+		dev_err(dev, "failed to register power supply: %d\n", ret);
+		return ret;
 	}
 
 	/* Register for OTG notification */
@@ -889,8 +890,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		if (info->irq[i] < 0) {
 			dev_warn(&info->pdev->dev,
 				"failed to get virtual interrupt=%d\n", pirq);
-			ret = info->irq[i];
-			goto intr_reg_failed;
+			return info->irq[i];
 		}
 		ret = devm_request_threaded_irq(&info->pdev->dev, info->irq[i],
 					NULL, axp288_charger_irq_thread_handler,
@@ -898,34 +898,19 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request interrupt=%d\n",
 								info->irq[i]);
-			goto intr_reg_failed;
+			return ret;
 		}
 	}
 
 	ret = charger_init_hw_regs(info);
 	if (ret)
-		goto intr_reg_failed;
-
-	return 0;
-
-intr_reg_failed:
-	power_supply_unregister(info->psy_usb);
-psy_reg_failed:
-	return ret;
-}
-
-static int axp288_charger_remove(struct platform_device *pdev)
-{
-	struct axp288_chrg_info *info =  dev_get_drvdata(&pdev->dev);
-
-	power_supply_unregister(info->psy_usb);
+		return ret;
 
 	return 0;
 }
 
 static struct platform_driver axp288_charger_driver = {
 	.probe = axp288_charger_probe,
-	.remove = axp288_charger_remove,
 	.driver = {
 		.name = "axp288_charger",
 	},
-- 
2.9.3
