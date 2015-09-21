From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 2/5] thermal: rockchip: Support the RK3368 SoCs in thermal driver
Date: Mon, 21 Sep 2015 12:16:08 +0800
Message-ID: <1442808971-2619-3-git-send-email-wxt@rock-chips.com>
References: <1442808971-2619-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34711 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbbIUEQs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2015 00:16:48 -0400
In-Reply-To: <1442808971-2619-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de, edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, will.deacon@arm.com, robh+dt@kernel.org, inux-kernel@vger.kernel.org, galak@codeaurora.org, linux-rockchip@lists.infradead.org, dmitry.torokhov@gmail.com, mark.rutland@arm.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, ijc+devicetree@hellion.org.uk, Caesar Wang <wxt@rock-chips.com>

The RK3368 SoCs support to 2 channel TS-ADC, the temperature criteria
of each channel can be configurable.

The system has two Temperature Sensors, channel 0 is for CPU,
and channel 1 is for GPU.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/thermal/rockchip_thermal.c | 201 ++++++++++++++++++++++++++++++++-----
 1 file changed, 176 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 4d5b7d4..16d2476 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1,6 +1,9 @@
 /*
  * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
  *
+ * Copyright (c) 2015, Fuzhou Rockchip Electronics Co., Ltd
+ * Caesar Wang <wxt@rock-chips.com>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
  * version 2, as published by the Free Software Foundation.
@@ -43,16 +46,11 @@ enum tshut_polarity {
 	TSHUT_HIGH_ACTIVE,
 };
 
-/**
- * The system has three Temperature Sensors.  channel 0 is reserved,
- * channel 1 is for CPU, and channel 2 is for GPU.
- */
-enum sensor_id {
-	SENSOR_CPU = 1,
-	SENSOR_GPU,
-};
-
 struct rockchip_tsadc_chip {
+	/* The sensor id of chip correspond to the ADC channel */
+	int cpu_id;
+	int gpu_id;
+
 	/* The hardware-controlled tshut property */
 	long tshut_temp;
 	enum tshut_mode tshut_mode;
@@ -72,10 +70,11 @@ struct rockchip_tsadc_chip {
 struct rockchip_thermal_sensor {
 	struct rockchip_thermal_data *thermal;
 	struct thermal_zone_device *tzd;
-	enum sensor_id id;
+	int id;
 };
 
-#define NUM_SENSORS	2 /* Ignore unused sensor 0 */
+/* Two sensors: CPU and GPU */
+#define NUM_SENSORS	2
 
 struct rockchip_thermal_data {
 	const struct rockchip_tsadc_chip *chip;
@@ -94,7 +93,7 @@ struct rockchip_thermal_data {
 	enum tshut_polarity tshut_polarity;
 };
 
-/* TSADC V2 Sensor info define: */
+/* TSADC Sensor info define: */
 #define TSADCV2_AUTO_CON			0x04
 #define TSADCV2_INT_EN				0x08
 #define TSADCV2_INT_PD				0x0c
@@ -116,6 +115,8 @@ struct rockchip_thermal_data {
 #define TSADCV2_INT_PD_CLEAR_MASK		~BIT(8)
 
 #define TSADCV2_DATA_MASK			0xfff
+#define TSADCV3_DATA_MASK			0x3ff
+
 #define TSADCV2_HIGHT_INT_DEBOUNCE_COUNT	4
 #define TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT	4
 #define TSADCV2_AUTO_PERIOD_TIME		250 /* msec */
@@ -164,6 +165,45 @@ static const struct tsadc_table v2_code_table[] = {
 	{3421, 125000},
 };
 
+static const struct tsadc_table v3_code_table[] = {
+	{0, -40000},
+	{106, -40000},
+	{108, -35000},
+	{110, -30000},
+	{112, -25000},
+	{114, -20000},
+	{116, -15000},
+	{118, -10000},
+	{120, -5000},
+	{122, 0},
+	{124, 5000},
+	{126, 10000},
+	{128, 15000},
+	{130, 20000},
+	{132, 25000},
+	{134, 30000},
+	{136, 35000},
+	{138, 40000},
+	{140, 45000},
+	{142, 50000},
+	{144, 55000},
+	{146, 60000},
+	{148, 65000},
+	{150, 70000},
+	{152, 75000},
+	{154, 80000},
+	{156, 85000},
+	{158, 90000},
+	{160, 95000},
+	{162, 100000},
+	{163, 105000},
+	{165, 110000},
+	{167, 115000},
+	{169, 120000},
+	{171, 125000},
+	{TSADCV3_DATA_MASK, 125000},
+};
+
 static u32 rk_tsadcv2_temp_to_code(long temp)
 {
 	int high, low, mid;
@@ -227,16 +267,83 @@ static int rk_tsadcv2_code_to_temp(u32 code, int *temp)
 	return 0;
 }
 
+static u32 rk_tsadcv3_temp_to_code(long temp)
+{
+	int high, low, mid;
+
+	low = 0;
+	high = ARRAY_SIZE(v3_code_table) - 1;
+	mid = (high + low) / 2;
+
+	if (temp < v3_code_table[low].temp || temp > v3_code_table[high].temp)
+		return 0;
+
+	while (low <= high) {
+		if (temp == v3_code_table[mid].temp)
+			return v3_code_table[mid].code;
+		else if (temp < v3_code_table[mid].temp)
+			high = mid - 1;
+		else
+			low = mid + 1;
+		mid = (low + high) / 2;
+	}
+
+	return 0;
+}
+
+static int rk_tsadcv3_code_to_temp(u32 code, int *temp)
+{
+	unsigned int low = 1;
+	unsigned int high = ARRAY_SIZE(v3_code_table) - 1;
+	unsigned int mid = (low + high) / 2;
+	unsigned int num;
+	unsigned long denom;
+
+	BUILD_BUG_ON(ARRAY_SIZE(v3_code_table) < 2);
+
+	code &= TSADCV3_DATA_MASK;
+	if (code < v3_code_table[low].code)
+		return -EAGAIN;		/* Incorrect reading */
+
+	while (low <= high) {
+		if (code >= v3_code_table[mid - 1].code &&
+		    code < v3_code_table[mid].code)
+			break;
+		else if (code > v3_code_table[mid].code)
+			low = mid + 1;
+		else
+			high = mid - 1;
+		mid = (low + high) / 2;
+	}
+
+	/*
+	 * The 5C granularity provided by the table is too much. Let's
+	 * assume that the relationship between sensor readings and
+	 * temperature between 2 table entries is linear and interpolate
+	 * to produce less granular result.
+	 */
+	num = v3_code_table[mid].temp - v3_code_table[mid - 1].temp;
+	num *= code - v3_code_table[mid - 1].code;
+	denom = v3_code_table[mid].code - v3_code_table[mid - 1].code;
+	*temp = v3_code_table[mid - 1].temp + (num / denom);
+
+	return 0;
+}
+
 /**
- * rk_tsadcv2_initialize - initialize TASDC Controller
- * (1) Set TSADCV2_AUTO_PERIOD, configure the interleave between
- * every two accessing of TSADC in normal operation.
- * (2) Set TSADCV2_AUTO_PERIOD_HT, configure the interleave between
- * every two accessing of TSADC after the temperature is higher
- * than COM_SHUT or COM_INT.
- * (3) Set TSADCV2_HIGH_INT_DEBOUNCE and TSADC_HIGHT_TSHUT_DEBOUNCE,
- * if the temperature is higher than COMP_INT or COMP_SHUT for
- * "debounce" times, TSADC controller will generate interrupt or TSHUT.
+ * rk_tsadcv2_initialize - initialize TASDC Controller.
+ *
+ * (1) Set TSADC_V2_AUTO_PERIOD:
+ *     Configure the interleave between every two accessing of
+ *     TSADC in normal operation.
+ *
+ * (2) Set TSADCV2_AUTO_PERIOD_HT:
+ *     Configure the interleave between every two accessing of
+ *     TSADC after the temperature is higher than COM_SHUT or COM_INT.
+ *
+ * (3) Set TSADCV2_HIGH_INT_DEBOUNCE and TSADC_HIGHT_TSHUT_DEBOUNCE:
+ *     If the temperature is higher than COMP_INT or COMP_SHUT for
+ *     "debounce" times, TSADC controller will generate interrupt or TSHUT.
  */
 static void rk_tsadcv2_initialize(void __iomem *regs,
 				  enum tshut_polarity tshut_polarity)
@@ -316,7 +423,31 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 	writel_relaxed(val, regs + TSADCV2_INT_EN);
 }
 
+static int rk_tsadcv3_get_temp(int chn, void __iomem *regs, int *temp)
+{
+	u32 val;
+
+	val = readl_relaxed(regs + TSADCV2_DATA(chn));
+
+	return rk_tsadcv3_code_to_temp(val, temp);
+}
+
+static void rk_tsadcv3_tshut_temp(int chn, void __iomem *regs, long temp)
+{
+	u32 tshut_value, val;
+
+	tshut_value = rk_tsadcv3_temp_to_code(temp);
+	writel_relaxed(tshut_value, regs + TSADCV2_COMP_SHUT(chn));
+
+	/* TSHUT will be valid */
+	val = readl_relaxed(regs + TSADCV2_AUTO_CON);
+	writel_relaxed(val | TSADCV2_AUTO_SRC_EN(chn), regs + TSADCV2_AUTO_CON);
+}
+
 static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
+	.cpu_id = 1,
+	.gpu_id = 2,
+
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -329,11 +460,31 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
 	.set_tshut_mode = rk_tsadcv2_tshut_mode,
 };
 
+static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
+	.cpu_id = 0,
+	.gpu_id = 1,
+
+	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
+	.tshut_temp = 95000,
+
+	.initialize = rk_tsadcv2_initialize,
+	.irq_ack = rk_tsadcv2_irq_ack,
+	.control = rk_tsadcv2_control,
+	.get_temp = rk_tsadcv3_get_temp,
+	.set_tshut_temp = rk_tsadcv3_tshut_temp,
+	.set_tshut_mode = rk_tsadcv2_tshut_mode,
+};
+
 static const struct of_device_id of_rockchip_thermal_match[] = {
 	{
 		.compatible = "rockchip,rk3288-tsadc",
 		.data = (void *)&rk3288_tsadc_data,
 	},
+	{
+		.compatible = "rockchip,rk3368-tsadc",
+		.data = (void *)&rk3368_tsadc_data,
+	},
 	{ /* end */ },
 };
 MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
@@ -441,7 +592,7 @@ static int
 rockchip_thermal_register_sensor(struct platform_device *pdev,
 				 struct rockchip_thermal_data *thermal,
 				 struct rockchip_thermal_sensor *sensor,
-				 enum sensor_id id)
+				 int id)
 {
 	const struct rockchip_tsadc_chip *tsadc = thermal->chip;
 	int error;
@@ -557,7 +708,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	error = rockchip_thermal_register_sensor(pdev, thermal,
 						 &thermal->sensors[0],
-						 SENSOR_CPU);
+						 thermal->chip->cpu_id);
 	if (error) {
 		dev_err(&pdev->dev,
 			"failed to register CPU thermal sensor: %d\n", error);
@@ -566,7 +717,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	error = rockchip_thermal_register_sensor(pdev, thermal,
 						 &thermal->sensors[1],
-						 SENSOR_GPU);
+						 thermal->chip->gpu_id);
 	if (error) {
 		dev_err(&pdev->dev,
 			"failed to register GPU thermal sensor: %d\n", error);
@@ -661,7 +812,7 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 	thermal->chip->initialize(thermal->regs, thermal->tshut_polarity);
 
 	for (i = 0; i < ARRAY_SIZE(thermal->sensors); i++) {
-		enum sensor_id id = thermal->sensors[i].id;
+		int id = thermal->sensors[i].id;
 
 		thermal->chip->set_tshut_mode(id, thermal->regs,
 					      thermal->tshut_mode);
-- 
1.9.1

