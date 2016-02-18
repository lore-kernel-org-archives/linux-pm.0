From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/1] thermal: small style cleanup in mtk_thermal
Date: Thu, 18 Feb 2016 07:50:25 -0800
Message-ID: <1455810625-20509-1-git-send-email-edubezval@gmail.com>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36399 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425202AbcBRPub (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 10:50:31 -0500
In-Reply-To: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: s.hauer@pengutronix.de
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, rui.zhang@intel.com, linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com, djkurtz@chromium.org, eddie.huang@mediatek.com, Eduardo Valentin <edubezval@gmail.com>

Remove all checkpatch.pl --strict errors, checks, and warnings.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
Sascha,

Add your v12 in my forlinus branch. But also, on top of it
I cleaned the patch further with the following patch.

BR,

Eduardo

 drivers/thermal/mtk_thermal.c | 56 ++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 589a138..3d93b1c 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -78,7 +78,7 @@
 
 #define TEMP_MONCTL1_PERIOD_UNIT(x)	((x) & 0x3ff)
 
-#define TEMP_MONCTL2_FILTER_INTERVAL(x)	(((x) & 0x3ff)) << 16
+#define TEMP_MONCTL2_FILTER_INTERVAL(x)	(((x) & 0x3ff) << 16)
 #define TEMP_MONCTL2_SENSOR_INTERVAL(x)	((x) & 0x3ff)
 
 #define TEMP_AHBPOLL_ADC_POLL_INTERVAL(x)	(x)
@@ -108,15 +108,15 @@
 #define MT8173_NUM_SENSORS_PER_ZONE	4
 
 /* Layout of the fuses providing the calibration data */
-#define MT8173_CALIB_BUF0_VALID		(1 << 0)
-#define MT8173_CALIB_BUF1_ADC_GE(x)	(((x) >> 22 ) & 0x3ff)
-#define MT8173_CALIB_BUF0_VTS_TS1(x)	(((x) >> 17 ) & 0x1ff)
-#define MT8173_CALIB_BUF0_VTS_TS2(x)	(((x) >> 8 ) & 0x1ff)
-#define MT8173_CALIB_BUF1_VTS_TS3(x)	(((x) >> 0 ) & 0x1ff)
-#define MT8173_CALIB_BUF2_VTS_TS4(x)	(((x) >> 23 ) & 0x1ff)
-#define MT8173_CALIB_BUF2_VTS_TSABB(x)	(((x) >> 14 ) & 0x1ff)
-#define MT8173_CALIB_BUF0_DEGC_CALI(x)	(((x) >> 1 ) & 0x3f)
-#define MT8173_CALIB_BUF0_O_SLOPE(x)	(((x) >> 26 ) & 0x3f)
+#define MT8173_CALIB_BUF0_VALID		BIT(0)
+#define MT8173_CALIB_BUF1_ADC_GE(x)	(((x) >> 22) & 0x3ff)
+#define MT8173_CALIB_BUF0_VTS_TS1(x)	(((x) >> 17) & 0x1ff)
+#define MT8173_CALIB_BUF0_VTS_TS2(x)	(((x) >> 8) & 0x1ff)
+#define MT8173_CALIB_BUF1_VTS_TS3(x)	(((x) >> 0) & 0x1ff)
+#define MT8173_CALIB_BUF2_VTS_TS4(x)	(((x) >> 23) & 0x1ff)
+#define MT8173_CALIB_BUF2_VTS_TSABB(x)	(((x) >> 14) & 0x1ff)
+#define MT8173_CALIB_BUF0_DEGC_CALI(x)	(((x) >> 1) & 0x3f)
+#define MT8173_CALIB_BUF0_O_SLOPE(x)	(((x) >> 26) & 0x3f)
 
 #define THERMAL_NAME    "mtk-thermal"
 
@@ -136,6 +136,7 @@ struct mtk_thermal {
 
 	struct mtk_thermal_bank banks[MT8173_NUM_ZONES];
 
+	/* lock: for getting and putting banks */
 	struct mutex lock;
 
 	/* Calibration values */
@@ -271,11 +272,9 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
 static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 {
 	struct mtk_thermal *mt = bank->mt;
-	int temp, i, max;
+	int i, temp = INT_MIN, max = INT_MIN;
 	u32 raw;
 
-	temp = max = INT_MIN;
-
 	for (i = 0; i < bank_data[bank->id].num_sensors; i++) {
 		raw = readl(mt->thermal_base + sensing_points[i].msr);
 
@@ -322,7 +321,7 @@ static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
 };
 
 static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
-		u32 apmixed_phys_base, u32 auxadc_phys_base)
+				  u32 apmixed_phys_base, u32 auxadc_phys_base)
 {
 	struct mtk_thermal_bank *bank = &mt->banks[num];
 	const struct mtk_thermal_bank_cfg *cfg = &bank_data[num];
@@ -346,7 +345,7 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 
 	/* poll is set to 10u */
 	writel(TEMP_AHBPOLL_ADC_POLL_INTERVAL(768),
-			mt->thermal_base + TEMP_AHBPOLL);
+	       mt->thermal_base + TEMP_AHBPOLL);
 
 	/* temperature sampling control, 1 sample */
 	writel(0x0, mt->thermal_base + TEMP_MSRCTL0);
@@ -375,49 +374,50 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 
 	/* AHB address for auxadc mux selection */
 	writel(auxadc_phys_base + AUXADC_CON1_CLR_V,
-			mt->thermal_base + TEMP_ADCMUXADDR);
+	       mt->thermal_base + TEMP_ADCMUXADDR);
 
 	/* AHB address for pnp sensor mux selection */
 	writel(apmixed_phys_base + APMIXED_SYS_TS_CON1,
-			mt->thermal_base + TEMP_PNPMUXADDR);
+	       mt->thermal_base + TEMP_PNPMUXADDR);
 
 	/* AHB value for auxadc enable */
 	writel(BIT(MT8173_TEMP_AUXADC_CHANNEL), mt->thermal_base + TEMP_ADCEN);
 
 	/* AHB address for auxadc enable (channel 0 immediate mode selected) */
 	writel(auxadc_phys_base + AUXADC_CON1_SET_V,
-			mt->thermal_base + TEMP_ADCENADDR);
+	       mt->thermal_base + TEMP_ADCENADDR);
 
 	/* AHB address for auxadc valid bit */
 	writel(auxadc_phys_base + AUXADC_DATA(MT8173_TEMP_AUXADC_CHANNEL),
-			mt->thermal_base + TEMP_ADCVALIDADDR);
+	       mt->thermal_base + TEMP_ADCVALIDADDR);
 
 	/* AHB address for auxadc voltage output */
 	writel(auxadc_phys_base + AUXADC_DATA(MT8173_TEMP_AUXADC_CHANNEL),
-			mt->thermal_base + TEMP_ADCVOLTADDR);
+	       mt->thermal_base + TEMP_ADCVOLTADDR);
 
 	/* read valid & voltage are at the same register */
 	writel(0x0, mt->thermal_base + TEMP_RDCTRL);
 
 	/* indicate where the valid bit is */
 	writel(TEMP_ADCVALIDMASK_VALID_HIGH | TEMP_ADCVALIDMASK_VALID_POS(12),
-			mt->thermal_base + TEMP_ADCVALIDMASK);
+	       mt->thermal_base + TEMP_ADCVALIDMASK);
 
 	/* no shift */
 	writel(0x0, mt->thermal_base + TEMP_ADCVOLTAGESHIFT);
 
 	/* enable auxadc mux write transaction */
 	writel(TEMP_ADCWRITECTRL_ADC_MUX_WRITE,
-			mt->thermal_base + TEMP_ADCWRITECTRL);
+	       mt->thermal_base + TEMP_ADCWRITECTRL);
 
 	for (i = 0; i < cfg->num_sensors; i++)
 		writel(sensor_mux_values[cfg->sensors[i]],
-				mt->thermal_base + sensing_points[i].adcpnp);
+		       mt->thermal_base + sensing_points[i].adcpnp);
 
 	writel((1 << cfg->num_sensors) - 1, mt->thermal_base + TEMP_MONCTL0);
 
-	writel(TEMP_ADCWRITECTRL_ADC_PNP_WRITE | TEMP_ADCWRITECTRL_ADC_MUX_WRITE,
-			mt->thermal_base + TEMP_ADCWRITECTRL);
+	writel(TEMP_ADCWRITECTRL_ADC_PNP_WRITE |
+	       TEMP_ADCWRITECTRL_ADC_MUX_WRITE,
+	       mt->thermal_base + TEMP_ADCWRITECTRL);
 
 	mtk_thermal_put_bank(bank);
 }
@@ -434,7 +434,8 @@ static u64 of_get_phys_base(struct device_node *np)
 	return of_translate_address(np, regaddr_p);
 }
 
-static int mtk_thermal_get_calibration_data(struct device *dev, struct mtk_thermal *mt)
+static int mtk_thermal_get_calibration_data(struct device *dev,
+					    struct mtk_thermal *mt)
 {
 	struct nvmem_cell *cell;
 	u32 *buf;
@@ -567,7 +568,8 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < MT8173_NUM_ZONES; i++)
-		mtk_thermal_init_bank(mt, i, apmixed_phys_base, auxadc_phys_base);
+		mtk_thermal_init_bank(mt, i, apmixed_phys_base,
+				      auxadc_phys_base);
 
 	platform_set_drvdata(pdev, mt);
 
-- 
2.1.4

