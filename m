From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 01/12] power: supply: axp288_charger: Make charger_init_hw_regs propagate i2c errors
Date: Wed, 21 Dec 2016 15:36:46 +0100
Message-ID: <20161221143657.322-2-hdegoede@redhat.com>
References: <20161221143657.322-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161221143657.322-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

Make charger_init_hw_regs propagate i2c errors, instead of only warning
about them and then ignoring them.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 62 ++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 1115052..c0f5a49 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -701,59 +701,73 @@ static int axp288_charger_handle_otg_evt(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static void charger_init_hw_regs(struct axp288_chrg_info *info)
+static int charger_init_hw_regs(struct axp288_chrg_info *info)
 {
 	int ret, cc, cv;
 	unsigned int val;
 
 	/* Program temperature thresholds */
 	ret = regmap_write(info->regmap, AXP20X_V_LTF_CHRG, CHRG_VLTFC_0C);
-	if (ret < 0)
-		dev_warn(&info->pdev->dev, "register(%x) write error(%d)\n",
+	if (ret < 0) {
+		dev_err(&info->pdev->dev, "register(%x) write error(%d)\n",
 							AXP20X_V_LTF_CHRG, ret);
+		return ret;
+	}
 
 	ret = regmap_write(info->regmap, AXP20X_V_HTF_CHRG, CHRG_VHTFC_45C);
-	if (ret < 0)
-		dev_warn(&info->pdev->dev, "register(%x) write error(%d)\n",
+	if (ret < 0) {
+		dev_err(&info->pdev->dev, "register(%x) write error(%d)\n",
 							AXP20X_V_HTF_CHRG, ret);
+		return ret;
+	}
 
 	/* Do not turn-off charger o/p after charge cycle ends */
 	ret = regmap_update_bits(info->regmap,
 				AXP20X_CHRG_CTRL2,
 				CNTL2_CHG_OUT_TURNON, 1);
-	if (ret < 0)
-		dev_warn(&info->pdev->dev, "register(%x) write error(%d)\n",
+	if (ret < 0) {
+		dev_err(&info->pdev->dev, "register(%x) write error(%d)\n",
 						AXP20X_CHRG_CTRL2, ret);
+		return ret;
+	}
 
 	/* Enable interrupts */
 	ret = regmap_update_bits(info->regmap,
 				AXP20X_IRQ2_EN,
 				BAT_IRQ_CFG_BAT_MASK, 1);
-	if (ret < 0)
-		dev_warn(&info->pdev->dev, "register(%x) write error(%d)\n",
+	if (ret < 0) {
+		dev_err(&info->pdev->dev, "register(%x) write error(%d)\n",
 						AXP20X_IRQ2_EN, ret);
+		return ret;
+	}
 
 	ret = regmap_update_bits(info->regmap, AXP20X_IRQ3_EN,
 				TEMP_IRQ_CFG_MASK, 1);
-	if (ret < 0)
-		dev_warn(&info->pdev->dev, "register(%x) write error(%d)\n",
+	if (ret < 0) {
+		dev_err(&info->pdev->dev, "register(%x) write error(%d)\n",
 						AXP20X_IRQ3_EN, ret);
+		return ret;
+	}
 
 	/* Setup ending condition for charging to be 10% of I(chrg) */
 	ret = regmap_update_bits(info->regmap,
 				AXP20X_CHRG_CTRL1,
 				CHRG_CCCV_ITERM_20P, 0);
-	if (ret < 0)
-		dev_warn(&info->pdev->dev, "register(%x) write error(%d)\n",
+	if (ret < 0) {
+		dev_err(&info->pdev->dev, "register(%x) write error(%d)\n",
 						AXP20X_CHRG_CTRL1, ret);
+		return ret;
+	}
 
 	/* Disable OCV-SOC curve calibration */
 	ret = regmap_update_bits(info->regmap,
 				AXP20X_CC_CTRL,
 				FG_CNTL_OCV_ADJ_EN, 0);
-	if (ret < 0)
-		dev_warn(&info->pdev->dev, "register(%x) write error(%d)\n",
+	if (ret < 0) {
+		dev_err(&info->pdev->dev, "register(%x) write error(%d)\n",
 						AXP20X_CC_CTRL, ret);
+		return ret;
+	}
 
 	/* Init charging current and voltage */
 	info->max_cc = info->pdata->max_cc;
@@ -796,15 +810,21 @@ static void charger_init_hw_regs(struct axp288_chrg_info *info)
 		cv = min(info->pdata->def_cv, info->max_cv);
 
 		ret = axp288_charger_set_cc(info, cc);
-		if (ret < 0)
-			dev_warn(&info->pdev->dev,
+		if (ret < 0) {
+			dev_err(&info->pdev->dev,
 					"error(%d) in setting CC\n", ret);
+			return ret;
+		}
 
 		ret = axp288_charger_set_cv(info, cv);
-		if (ret < 0)
-			dev_warn(&info->pdev->dev,
+		if (ret < 0) {
+			dev_err(&info->pdev->dev,
 					"error(%d) in setting CV\n", ret);
+			return ret;
+		}
 	}
+
+	return 0;
 }
 
 static int axp288_charger_probe(struct platform_device *pdev)
@@ -910,7 +930,9 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		}
 	}
 
-	charger_init_hw_regs(info);
+	ret = charger_init_hw_regs(info);
+	if (ret)
+		goto intr_reg_failed;
 
 	return 0;
 
-- 
2.9.3
