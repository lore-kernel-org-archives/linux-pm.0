From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] power: supply: axp288_fuel_gauge: Remove unnecessary irq?_en register writes
Date: Thu, 22 Dec 2016 13:00:11 +0100
Message-ID: <20161222120011.11652-2-hdegoede@redhat.com>
References: <20161222120011.11652-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934708AbcLVMAP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Dec 2016 07:00:15 -0500
In-Reply-To: <20161222120011.11652-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Setting the irq_enable bits is taken care of by the irq chip when we
request the irqs and the driver should not be meddling with the
irq?_en registers itself.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index abff422..a8dcabc 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -50,18 +50,6 @@
 #define CHRG_CCCV_CV_4350MV			0x3     /* 4.35V */
 #define CHRG_CCCV_CHG_EN			(1 << 7)
 
-#define TEMP_IRQ_CFG_QWBTU			(1 << 0)
-#define TEMP_IRQ_CFG_WBTU			(1 << 1)
-#define TEMP_IRQ_CFG_QWBTO			(1 << 2)
-#define TEMP_IRQ_CFG_WBTO			(1 << 3)
-#define TEMP_IRQ_CFG_MASK			0xf
-
-#define FG_IRQ_CFG_LOWBATT_WL2		(1 << 0)
-#define FG_IRQ_CFG_LOWBATT_WL1		(1 << 1)
-#define FG_IRQ_CFG_LOWBATT_MASK		0x3
-#define LOWBAT_IRQ_STAT_LOWBATT_WL2	(1 << 0)
-#define LOWBAT_IRQ_STAT_LOWBATT_WL1	(1 << 1)
-
 #define FG_CNTL_OCV_ADJ_STAT		(1 << 2)
 #define FG_CNTL_OCV_ADJ_EN			(1 << 3)
 #define FG_CNTL_CAP_ADJ_STAT		(1 << 4)
@@ -710,20 +698,6 @@ static void fuel_gauge_init_irq(struct axp288_fg_info *info)
 	}
 }
 
-static void fuel_gauge_init_hw_regs(struct axp288_fg_info *info)
-{
-	unsigned int val;
-
-	/* enable interrupts */
-	val = fuel_gauge_reg_readb(info, AXP20X_IRQ3_EN);
-	val |= TEMP_IRQ_CFG_MASK;
-	fuel_gauge_reg_writeb(info, AXP20X_IRQ3_EN, val);
-
-	val = fuel_gauge_reg_readb(info, AXP20X_IRQ4_EN);
-	val |= FG_IRQ_CFG_LOWBATT_MASK;
-	val = fuel_gauge_reg_writeb(info, AXP20X_IRQ4_EN, val);
-}
-
 static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 {
 	int ret = 0;
@@ -782,7 +756,6 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 
 	fuel_gauge_create_debugfs(info);
 	fuel_gauge_init_irq(info);
-	fuel_gauge_init_hw_regs(info);
 	schedule_delayed_work(&info->status_monitor, STATUS_MON_DELAY_JIFFIES);
 
 	return 0;
-- 
2.9.3

