From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: [RFC PATCH 1/5] thermal: MT8173: Replace mutex with spinlock
Date: Fri, 22 Jan 2016 16:40:25 +0800
Message-ID: <1453452029-20843-2-git-send-email-pi-cheng.chen@linaro.org>
References: <1453452029-20843-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35155 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbcAVIkm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2016 03:40:42 -0500
Received: by mail-pa0-f41.google.com with SMTP id ho8so38035370pac.2
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2016 00:40:42 -0800 (PST)
In-Reply-To: <1453452029-20843-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: Kevin Hilman <khilman@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Currently switching between the block of banked registers of Mediatek
thermal controller is synchronized by a mutex. Replace it with spinlock
since switching between register banks might happen in interrupt
context in SVS driver which will be introduced later.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
 drivers/thermal/mtk_thermal.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 3c233b8..f20e784 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -135,7 +135,7 @@ struct mtk_thermal {
 
 	struct mtk_thermal_bank banks[MT8173_NUM_ZONES];
 
-	struct mutex lock;
+	spinlock_t lock;
 
 	/* Calibration values */
 	s32 adc_ge;
@@ -222,19 +222,17 @@ static int raw_to_mcelsius(struct mtk_thermal *mt, int sensno, s32 raw)
 }
 
 /**
- * mtk_thermal_get_bank - get bank
+ * mtk_thermal_switch_bank - switch to bank
  * @bank:	The bank
  *
  * The bank registers are banked, we have to select a bank in the
  * PTPCORESEL register to access it.
  */
-static void mtk_thermal_get_bank(struct mtk_thermal_bank *bank)
+static void mtk_thermal_switch_bank(struct mtk_thermal_bank *bank)
 {
 	struct mtk_thermal *mt = bank->mt;
 	u32 val;
 
-	mutex_lock(&mt->lock);
-
 	val = readl(mt->thermal_base + PTPCORESEL);
 	val &= ~0xf;
 	val |= bank->id;
@@ -242,19 +240,6 @@ static void mtk_thermal_get_bank(struct mtk_thermal_bank *bank)
 }
 
 /**
- * mtk_thermal_put_bank - release bank
- * @bank:	The bank
- *
- * release a bank previously taken with mtk_thermal_get_bank,
- */
-static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
-{
-	struct mtk_thermal *mt = bank->mt;
-
-	mutex_unlock(&mt->lock);
-}
-
-/**
  * mtk_thermal_bank_temperature - get the temperature of a bank
  * @bank:	The bank
  *
@@ -297,13 +282,15 @@ static int mtk_read_temp(void *data, int *temperature)
 
 	for (i = 0; i < MT8173_NUM_ZONES; i++) {
 		struct mtk_thermal_bank *bank = &mt->banks[i];
+		unsigned long flags;
 		int t;
 
-		mtk_thermal_get_bank(bank);
+		spin_lock_irqsave(&mt->lock, flags);
+		mtk_thermal_switch_bank(bank);
 
 		t = mtk_thermal_bank_temperature(bank);
 
-		mtk_thermal_put_bank(bank);
+		spin_unlock_irqrestore(&mt->lock, flags);
 
 		if (t > tempmax)
 			tempmax = t;
@@ -323,12 +310,14 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 {
 	struct mtk_thermal_bank *bank = &mt->banks[num];
 	const struct mtk_thermal_bank_cfg *cfg = &bank_data[num];
+	unsigned long flags;
 	int i;
 
 	bank->id = num;
 	bank->mt = mt;
 
-	mtk_thermal_get_bank(bank);
+	spin_lock_irqsave(&mt->lock, flags);
+	mtk_thermal_switch_bank(bank);
 
 	/* bus clock 66M counting unit is 12 * 15.15ns * 256 = 46.540us */
 	writel(TEMP_MONCTL1_PERIOD_UNIT(12), mt->thermal_base + TEMP_MONCTL1);
@@ -416,7 +405,7 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 	writel(TEMP_ADCWRITECTRL_ADC_PNP_WRITE | TEMP_ADCWRITECTRL_ADC_MUX_WRITE,
 			mt->thermal_base + TEMP_ADCWRITECTRL);
 
-	mtk_thermal_put_bank(bank);
+	spin_unlock_irqrestore(&mt->lock, flags);
 }
 
 static u64 of_get_phys_base(struct device_node *np)
@@ -513,7 +502,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	mutex_init(&mt->lock);
+	spin_lock_init(&mt->lock);
 
 	mt->dev = &pdev->dev;
 
-- 
1.9.1

