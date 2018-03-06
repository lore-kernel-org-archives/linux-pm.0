From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 07/12] thermal: exynos: remove parsing of samsung,tmu_gain
 property
Date: Tue, 06 Mar 2018 15:43:50 +0100
Message-ID: <1520347435-22970-8-git-send-email-b.zolnierkie@samsung.com>
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144458epcas2p1102a06fa3e58b88cad914be624e0c1db@epcas2p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Since pdata gain values are SoC (not platform) specific just move
it from platform data to struct exynos_tmu_data instance. Then
remove parsing of samsung,tmu_gain property.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 18 +++++++++---------
 drivers/thermal/samsung/exynos_tmu.h |  4 ----
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 12bbf79..262ab41 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -192,6 +192,8 @@
  * @max_efuse_value: maximum valid trimming data
  * @temp_error1: fused value of the first point trim.
  * @temp_error2: fused value of the second point trim.
+ * @gain: gain of amplifier in the positive-TC generator block
+ *	0 < gain <= 15
  * @reference_voltage: reference voltage of amplifier
  *	in the positive-TC generator block
  *	0 < reference_voltage <= 31
@@ -218,6 +220,7 @@ struct exynos_tmu_data {
 	u32 min_efuse_value;
 	u32 max_efuse_value;
 	u16 temp_error1, temp_error2;
+	u8 gain;
 	u8 reference_voltage;
 	struct regulator *regulator;
 	struct thermal_zone_device *tzd;
@@ -386,8 +389,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
 {
-	struct exynos_tmu_platform_data *pdata = data->pdata;
-
 	if (data->soc == SOC_ARCH_EXYNOS4412 ||
 	    data->soc == SOC_ARCH_EXYNOS3250)
 		con |= (EXYNOS4412_MUX_ADDR_VALUE << EXYNOS4412_MUX_ADDR_SHIFT);
@@ -396,7 +397,7 @@ static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
 	con |= data->reference_voltage << EXYNOS_TMU_REF_VOLTAGE_SHIFT;
 
 	con &= ~(EXYNOS_TMU_BUF_SLOPE_SEL_MASK << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
-	con |= (pdata->gain << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
+	con |= (data->gain << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
 
 	con &= ~(EXYNOS_TMU_TRIP_MODE_MASK << EXYNOS_TMU_TRIP_MODE_SHIFT);
 	con |= (EXYNOS_NOISE_CANCEL_MODE << EXYNOS_TMU_TRIP_MODE_SHIFT);
@@ -1153,14 +1154,8 @@ static int exynos_of_get_soc_type(struct device_node *np)
 static int exynos_of_sensor_conf(struct device_node *np,
 				 struct exynos_tmu_platform_data *pdata)
 {
-	u32 value;
-	int ret;
-
 	of_node_get(np);
 
-	ret = of_property_read_u32(np, "samsung,tmu_gain", &value);
-	pdata->gain = (u8)value;
-
 	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
 
 	of_node_put(np);
@@ -1214,6 +1209,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_read = exynos4210_tmu_read;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->gain = 15;
 		data->reference_voltage = 7;
 		data->efuse_value = 55;
 		data->min_efuse_value = 40;
@@ -1231,6 +1227,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->gain = 8;
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
 		if (data->soc != SOC_ARCH_EXYNOS5420 &&
@@ -1247,6 +1244,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 8;
+		data->gain = 8;
 		if (res.start == EXYNOS5433_G3D_BASE)
 			data->reference_voltage = 23;
 		else
@@ -1262,6 +1260,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos5440_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos5440_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->gain = 5;
 		data->reference_voltage = 16;
 		data->efuse_value = 0x5d2d;
 		data->min_efuse_value = 16;
@@ -1274,6 +1273,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 8;
+		data->gain = 9;
 		data->reference_voltage = 17;
 		data->efuse_value = 75;
 		data->min_efuse_value = 15;
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 9f4318c..689453d 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -40,15 +40,11 @@ enum soc_type {
 
 /**
  * struct exynos_tmu_platform_data
- * @gain: gain of amplifier in the positive-TC generator block
- *	0 < gain <= 15
  * @cal_type: calibration type for temperature
  *
  * This structure is required for configuration of exynos_tmu driver.
  */
 struct exynos_tmu_platform_data {
-	u8 gain;
-
 	u32 cal_type;
 };
 
-- 
1.9.1
