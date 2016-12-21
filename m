From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 11/12] power: supply: axp288_charger: Remove unnecessary irq?_en register writes
Date: Wed, 21 Dec 2016 15:36:56 +0100
Message-ID: <20161221143657.322-12-hdegoede@redhat.com>
References: <20161221143657.322-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161221143657.322-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

Setting the irq_enable bits is taken care of by the irq chip when we
request the irqs and the driver should not be meddling with the
irq?_en registers itself.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index d3932cd..6e588e6 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -90,20 +90,6 @@
 #define CHRG_VLTFC_0C			0xA5	/* 0 DegC */
 #define CHRG_VHTFC_45C			0x1F	/* 45 DegC */
 
-#define BAT_IRQ_CFG_CHRG_DONE		(1 << 2)
-#define BAT_IRQ_CFG_CHRG_START		(1 << 3)
-#define BAT_IRQ_CFG_BAT_SAFE_EXIT	(1 << 4)
-#define BAT_IRQ_CFG_BAT_SAFE_ENTER	(1 << 5)
-#define BAT_IRQ_CFG_BAT_DISCON		(1 << 6)
-#define BAT_IRQ_CFG_BAT_CONN		(1 << 7)
-#define BAT_IRQ_CFG_BAT_MASK		0xFC
-
-#define TEMP_IRQ_CFG_QCBTU		(1 << 4)
-#define TEMP_IRQ_CFG_CBTU		(1 << 5)
-#define TEMP_IRQ_CFG_QCBTO		(1 << 6)
-#define TEMP_IRQ_CFG_CBTO		(1 << 7)
-#define TEMP_IRQ_CFG_MASK		0xF0
-
 #define FG_CNTL_OCV_ADJ_EN		(1 << 3)
 
 #define CV_4100MV			4100	/* 4100mV */
@@ -713,24 +699,6 @@ static int charger_init_hw_regs(struct axp288_chrg_info *info)
 		return ret;
 	}
 
-	/* Enable interrupts */
-	ret = regmap_update_bits(info->regmap,
-				AXP20X_IRQ2_EN,
-				BAT_IRQ_CFG_BAT_MASK, 1);
-	if (ret < 0) {
-		dev_err(&info->pdev->dev, "register(%x) write error(%d)\n",
-						AXP20X_IRQ2_EN, ret);
-		return ret;
-	}
-
-	ret = regmap_update_bits(info->regmap, AXP20X_IRQ3_EN,
-				TEMP_IRQ_CFG_MASK, 1);
-	if (ret < 0) {
-		dev_err(&info->pdev->dev, "register(%x) write error(%d)\n",
-						AXP20X_IRQ3_EN, ret);
-		return ret;
-	}
-
 	/* Setup ending condition for charging to be 10% of I(chrg) */
 	ret = regmap_update_bits(info->regmap,
 				AXP20X_CHRG_CTRL1,
-- 
2.9.3
