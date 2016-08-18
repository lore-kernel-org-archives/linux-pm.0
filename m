From: Dawei Chien <dawei.chien@mediatek.com>
Subject: [PATCH v2 2/3] thermal: Add Mediatek thermal driver for mt2701.
Date: Thu, 18 Aug 2016 11:50:52 +0800
Message-ID: <1471492253-7185-3-git-send-email-dawei.chien@mediatek.com>
References: <1471492253-7185-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471492253-7185-1-git-send-email-dawei.chien@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Fan Chen <fan.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Erin Lo <erin.lo@mediatek.com>, Dawei Chien <dawei.chien@mediatek.com>
List-Id: linux-pm@vger.kernel.org

This patch adds support for mt2701 chip to mtk_thermal,
and integrate both mt8173 and mt2701 on the same driver.
MT8173 has four banks and five sensors, and MT2701 has
only one bank and three sensors.

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
This patch dependents on "Add clock support for Mediatek MT2701"[1].
Please accept this patch together with [1].
[1]http://lists.infradead.org/pipermail/linux-mediatek/2016-August/006620.html
---
 drivers/thermal/mtk_thermal.c |  215 +++++++++++++++++++++++++++++------------
 1 file changed, 152 insertions(+), 63 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 262ab0a..7b233c7 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2015 MediaTek Inc.
  * Author: Hanyi Wu <hanyi.wu@mediatek.com>
  *         Sascha Hauer <s.hauer@pengutronix.de>
+ *         Dawei Chien <dawei.chien@mediatek.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -21,6 +22,7 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/io.h>
@@ -88,6 +90,7 @@
 #define TEMP_ADCVALIDMASK_VALID_HIGH		BIT(5)
 #define TEMP_ADCVALIDMASK_VALID_POS(bit)	(bit)
 
+/* MT8173 thermal sensors */
 #define MT8173_TS1	0
 #define MT8173_TS2	1
 #define MT8173_TS3	2
@@ -106,7 +109,12 @@
 /* The number of sensing points per bank */
 #define MT8173_NUM_SENSORS_PER_ZONE	4
 
-/* Layout of the fuses providing the calibration data */
+/*
+ * Layout of the fuses providing the calibration data
+ * These macros could be used for both MT8173 and MT2701.
+ * MT8173 has five sensors and need five VTS calibration data,
+ * and MT2701 has three sensors and need three VTS calibration data.
+ */
 #define MT8173_CALIB_BUF0_VALID		BIT(0)
 #define MT8173_CALIB_BUF1_ADC_GE(x)	(((x) >> 22) & 0x3ff)
 #define MT8173_CALIB_BUF0_VTS_TS1(x)	(((x) >> 17) & 0x1ff)
@@ -117,24 +125,50 @@
 #define MT8173_CALIB_BUF0_DEGC_CALI(x)	(((x) >> 1) & 0x3f)
 #define MT8173_CALIB_BUF0_O_SLOPE(x)	(((x) >> 26) & 0x3f)
 
+/* MT2701 thermal sensors */
+#define MT2701_TS1	0
+#define MT2701_TS2	1
+#define MT2701_TSABB	2
+
+/* AUXADC channel 11 is used for the temperature sensors */
+#define MT2701_TEMP_AUXADC_CHANNEL	11
+
+/* The total number of temperature sensors in the MT2701 */
+#define MT2701_NUM_SENSORS	3
+
 #define THERMAL_NAME    "mtk-thermal"
 
+/* The number of sensing points per bank */
+#define MT2701_NUM_SENSORS_PER_ZONE	3
+
 struct mtk_thermal;
 
+struct thermal_bank_cfg {
+	unsigned int num_sensors;
+	const int *sensors;
+};
+
 struct mtk_thermal_bank {
 	struct mtk_thermal *mt;
 	int id;
 };
 
+struct mtk_thermal_data {
+	s32 num_banks;
+	s32 num_sensors;
+	s32 auxadc_channel;
+	const int *sensor_mux_values;
+	const int *msr;
+	const int *adcpnp;
+	struct thermal_bank_cfg bank_data[];
+};
+
 struct mtk_thermal {
 	struct device *dev;
 	void __iomem *thermal_base;
 
 	struct clk *clk_peri_therm;
 	struct clk *clk_auxadc;
-
-	struct mtk_thermal_bank banks[MT8173_NUM_ZONES];
-
 	/* lock: for getting and putting banks */
 	struct mutex lock;
 
@@ -144,16 +178,44 @@ struct mtk_thermal {
 	s32 o_slope;
 	s32 vts[MT8173_NUM_SENSORS];
 
+	const struct mtk_thermal_data *conf;
+	struct mtk_thermal_bank banks[];
 };
 
-struct mtk_thermal_bank_cfg {
-	unsigned int num_sensors;
-	unsigned int sensors[MT8173_NUM_SENSORS_PER_ZONE];
+/* MT8173 thermal sensor data */
+const int mt8173_bank_data[MT8173_NUM_ZONES][3] = {
+	{ MT8173_TS2, MT8173_TS3 },
+	{ MT8173_TS2, MT8173_TS4 },
+	{ MT8173_TS1, MT8173_TS2, MT8173_TSABB },
+	{ MT8173_TS2 },
 };
 
-static const int sensor_mux_values[MT8173_NUM_SENSORS] = { 0, 1, 2, 3, 16 };
+const int mt8173_msr[MT8173_NUM_SENSORS_PER_ZONE] = {
+	TEMP_MSR0, TEMP_MSR1, TEMP_MSR2, TEMP_MSR2
+};
 
-/*
+const int mt8173_adcpnp[MT8173_NUM_SENSORS_PER_ZONE] = {
+	TEMP_ADCPNP0, TEMP_ADCPNP1, TEMP_ADCPNP2, TEMP_ADCPNP3
+};
+
+const int mt8173_mux_values[MT8173_NUM_SENSORS] = { 0, 1, 2, 3, 16 };
+
+/* MT2701 thermal sensor data */
+const int mt2701_bank_data[MT2701_NUM_SENSORS] = {
+	MT2701_TS1, MT2701_TS2, MT2701_TSABB
+};
+
+const int mt2701_msr[MT2701_NUM_SENSORS_PER_ZONE] = {
+	TEMP_MSR0, TEMP_MSR1, TEMP_MSR2
+};
+
+const int mt2701_adcpnp[MT2701_NUM_SENSORS_PER_ZONE] = {
+	TEMP_ADCPNP0, TEMP_ADCPNP1, TEMP_ADCPNP2
+};
+
+const int mt2701_mux_values[MT2701_NUM_SENSORS] = { 0, 1, 16 };
+
+/**
  * The MT8173 thermal controller has four banks. Each bank can read up to
  * four temperature sensors simultaneously. The MT8173 has a total of 5
  * temperature sensors. We use each bank to measure a certain area of the
@@ -166,42 +228,53 @@ static const int sensor_mux_values[MT8173_NUM_SENSORS] = { 0, 1, 2, 3, 16 };
  * data, and this indeed needs the temperatures of the individual banks
  * for making better decisions.
  */
-static const struct mtk_thermal_bank_cfg bank_data[] = {
-	{
-		.num_sensors = 2,
-		.sensors = { MT8173_TS2, MT8173_TS3 },
-	}, {
-		.num_sensors = 2,
-		.sensors = { MT8173_TS2, MT8173_TS4 },
-	}, {
-		.num_sensors = 3,
-		.sensors = { MT8173_TS1, MT8173_TS2, MT8173_TSABB },
-	}, {
-		.num_sensors = 1,
-		.sensors = { MT8173_TS2 },
+static const struct mtk_thermal_data mt8173_thermal_data = {
+	.auxadc_channel = MT8173_TEMP_AUXADC_CHANNEL,
+	.num_banks = MT8173_NUM_ZONES,
+	.num_sensors = MT8173_NUM_SENSORS,
+	.bank_data = {
+		{
+			.num_sensors = 2,
+			.sensors = mt8173_bank_data[0],
+		}, {
+			.num_sensors = 2,
+			.sensors = mt8173_bank_data[1],
+		}, {
+			.num_sensors = 3,
+			.sensors = mt8173_bank_data[2],
+		}, {
+			.num_sensors = 1,
+			.sensors = mt8173_bank_data[3],
+		},
 	},
+	.msr = mt8173_msr,
+	.adcpnp = mt8173_adcpnp,
+	.sensor_mux_values = mt8173_mux_values,
 };
 
-struct mtk_thermal_sense_point {
-	int msr;
-	int adcpnp;
-};
-
-static const struct mtk_thermal_sense_point
-		sensing_points[MT8173_NUM_SENSORS_PER_ZONE] = {
-	{
-		.msr = TEMP_MSR0,
-		.adcpnp = TEMP_ADCPNP0,
-	}, {
-		.msr = TEMP_MSR1,
-		.adcpnp = TEMP_ADCPNP1,
-	}, {
-		.msr = TEMP_MSR2,
-		.adcpnp = TEMP_ADCPNP2,
-	}, {
-		.msr = TEMP_MSR3,
-		.adcpnp = TEMP_ADCPNP3,
+/**
+ * The MT2701 thermal controller has one bank, which can read up to
+ * three temperature sensors simultaneously. The MT2701 has a total of 3
+ * temperature sensors.
+ *
+ * The thermal core only gets the maximum temperature of this one bank,
+ * so the bank concept wouldn't be necessary here. However, the SVS (Smart
+ * Voltage Scaling) unit makes its decisions based on the same bank
+ * data.
+ */
+static const struct mtk_thermal_data mt2701_thermal_data = {
+	.auxadc_channel = MT2701_TEMP_AUXADC_CHANNEL,
+	.num_banks = 1,
+	.num_sensors = MT2701_NUM_SENSORS,
+	.bank_data = {
+		{
+			.num_sensors = 3,
+			.sensors = mt2701_bank_data,
+		},
 	},
+	.msr = mt2701_msr,
+	.adcpnp = mt2701_adcpnp,
+	.sensor_mux_values = mt2701_mux_values,
 };
 
 /**
@@ -270,13 +343,16 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
 static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 {
 	struct mtk_thermal *mt = bank->mt;
+	const struct mtk_thermal_data *conf = mt->conf;
 	int i, temp = INT_MIN, max = INT_MIN;
 	u32 raw;
 
-	for (i = 0; i < bank_data[bank->id].num_sensors; i++) {
-		raw = readl(mt->thermal_base + sensing_points[i].msr);
+	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
+		raw = readl(mt->thermal_base + conf->msr[i]);
 
-		temp = raw_to_mcelsius(mt, bank_data[bank->id].sensors[i], raw);
+		temp = raw_to_mcelsius(mt,
+				       conf->bank_data[bank->id].sensors[i],
+				       raw);
 
 		/*
 		 * The first read of a sensor often contains very high bogus
@@ -299,7 +375,7 @@ static int mtk_read_temp(void *data, int *temperature)
 	int i;
 	int tempmax = INT_MIN;
 
-	for (i = 0; i < MT8173_NUM_ZONES; i++) {
+	for (i = 0; i < mt->conf->num_banks; i++) {
 		struct mtk_thermal_bank *bank = &mt->banks[i];
 
 		mtk_thermal_get_bank(bank);
@@ -322,7 +398,7 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 				  u32 apmixed_phys_base, u32 auxadc_phys_base)
 {
 	struct mtk_thermal_bank *bank = &mt->banks[num];
-	const struct mtk_thermal_bank_cfg *cfg = &bank_data[num];
+	const struct mtk_thermal_data *conf = mt->conf;
 	int i;
 
 	bank->id = num;
@@ -368,7 +444,7 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 	 * this value will be stored to TEMP_PNPMUXADDR (TEMP_SPARE0)
 	 * automatically by hw
 	 */
-	writel(BIT(MT8173_TEMP_AUXADC_CHANNEL), mt->thermal_base + TEMP_ADCMUX);
+	writel(BIT(conf->auxadc_channel), mt->thermal_base + TEMP_ADCMUX);
 
 	/* AHB address for auxadc mux selection */
 	writel(auxadc_phys_base + AUXADC_CON1_CLR_V,
@@ -379,18 +455,18 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 	       mt->thermal_base + TEMP_PNPMUXADDR);
 
 	/* AHB value for auxadc enable */
-	writel(BIT(MT8173_TEMP_AUXADC_CHANNEL), mt->thermal_base + TEMP_ADCEN);
+	writel(BIT(conf->auxadc_channel), mt->thermal_base + TEMP_ADCEN);
 
 	/* AHB address for auxadc enable (channel 0 immediate mode selected) */
 	writel(auxadc_phys_base + AUXADC_CON1_SET_V,
 	       mt->thermal_base + TEMP_ADCENADDR);
 
 	/* AHB address for auxadc valid bit */
-	writel(auxadc_phys_base + AUXADC_DATA(MT8173_TEMP_AUXADC_CHANNEL),
+	writel(auxadc_phys_base + AUXADC_DATA(conf->auxadc_channel),
 	       mt->thermal_base + TEMP_ADCVALIDADDR);
 
 	/* AHB address for auxadc voltage output */
-	writel(auxadc_phys_base + AUXADC_DATA(MT8173_TEMP_AUXADC_CHANNEL),
+	writel(auxadc_phys_base + AUXADC_DATA(conf->auxadc_channel),
 	       mt->thermal_base + TEMP_ADCVOLTADDR);
 
 	/* read valid & voltage are at the same register */
@@ -407,11 +483,12 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 	writel(TEMP_ADCWRITECTRL_ADC_MUX_WRITE,
 	       mt->thermal_base + TEMP_ADCWRITECTRL);
 
-	for (i = 0; i < cfg->num_sensors; i++)
-		writel(sensor_mux_values[cfg->sensors[i]],
-		       mt->thermal_base + sensing_points[i].adcpnp);
+	for (i = 0; i < conf->bank_data[num].num_sensors; i++)
+		writel(conf->sensor_mux_values[conf->bank_data[num].sensors[i]],
+		       mt->thermal_base + conf->adcpnp[i]);
 
-	writel((1 << cfg->num_sensors) - 1, mt->thermal_base + TEMP_MONCTL0);
+	writel((1 << conf->bank_data[num].num_sensors) - 1,
+	       mt->thermal_base + TEMP_MONCTL0);
 
 	writel(TEMP_ADCWRITECTRL_ADC_PNP_WRITE |
 	       TEMP_ADCWRITECTRL_ADC_MUX_WRITE,
@@ -442,7 +519,7 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
 
 	/* Start with default values */
 	mt->adc_ge = 512;
-	for (i = 0; i < MT8173_NUM_SENSORS; i++)
+	for (i = 0; i < mt->conf->num_sensors; i++)
 		mt->vts[i] = 260;
 	mt->degc_cali = 40;
 	mt->o_slope = 0;
@@ -486,18 +563,36 @@ out:
 	return ret;
 }
 
+static const struct of_device_id mtk_thermal_of_match[] = {
+	{
+		.compatible = "mediatek,mt8173-thermal",
+		.data = (void *)&mt8173_thermal_data,
+	},
+	{
+		.compatible = "mediatek,mt2701-thermal",
+		.data = (void *)&mt2701_thermal_data,
+	}, {
+	},
+};
+MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
+
 static int mtk_thermal_probe(struct platform_device *pdev)
 {
 	int ret, i;
 	struct device_node *auxadc, *apmixedsys, *np = pdev->dev.of_node;
 	struct mtk_thermal *mt;
 	struct resource *res;
+	const struct of_device_id *of_id;
 	u64 auxadc_phys_base, apmixed_phys_base;
 
 	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
 	if (!mt)
 		return -ENOMEM;
 
+	of_id = of_match_device(mtk_thermal_of_match, &pdev->dev);
+	if (of_id)
+		mt->conf = (const struct mtk_thermal_data *)of_id->data;
+
 	mt->clk_peri_therm = devm_clk_get(&pdev->dev, "therm");
 	if (IS_ERR(mt->clk_peri_therm))
 		return PTR_ERR(mt->clk_peri_therm);
@@ -565,7 +660,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_auxadc;
 	}
 
-	for (i = 0; i < MT8173_NUM_ZONES; i++)
+	for (i = 0; i < mt->conf->num_banks; i++)
 		mtk_thermal_init_bank(mt, i, apmixed_phys_base,
 				      auxadc_phys_base);
 
@@ -592,13 +687,6 @@ static int mtk_thermal_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mtk_thermal_of_match[] = {
-	{
-		.compatible = "mediatek,mt8173-thermal",
-	}, {
-	},
-};
-
 static struct platform_driver mtk_thermal_driver = {
 	.probe = mtk_thermal_probe,
 	.remove = mtk_thermal_remove,
@@ -610,6 +698,7 @@ static struct platform_driver mtk_thermal_driver = {
 
 module_platform_driver(mtk_thermal_driver);
 
+MODULE_AUTHOR("Dawei Chien <dawei.chien@mediatek.com>");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
 MODULE_AUTHOR("Hanyi Wu <hanyi.wu@mediatek.com>");
 MODULE_DESCRIPTION("Mediatek thermal driver");
-- 
1.7.9.5
