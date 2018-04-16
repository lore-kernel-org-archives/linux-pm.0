From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 11/14] thermal: exynos: remove parsing of
 samsung,tmu_cal_type property
Date: Mon, 16 Apr 2018 12:12:02 +0200
Message-ID: <1523873525-23718-12-git-send-email-b.zolnierkie@samsung.com>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101419epcas2p17dfedf3e376603baa8a4e52ffc82f0cb@epcas2p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Since calibration type for temperature is SoC (not platform) specific
just move it from platform data to struct exynos_tmu_data instance.
Then remove parsing of samsung,tmu_cal_type property. Also remove no
longer needed platform data structure.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 43 ++++++++----------------------------
 drivers/thermal/samsung/exynos_tmu.h | 10 ---------
 2 files changed, 9 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 3cdbc09..7975f33 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -177,7 +177,6 @@
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
 	driver
  * @id: identifier of the one instance of the TMU controller.
- * @pdata: pointer to the tmu platform/configuration data
  * @base: base address of the single instance of the TMU controller.
  * @base_second: base address of the common registers of the TMU controller.
  * @irq: irq number of the TMU controller.
@@ -187,6 +186,7 @@
  * @clk: pointer to the clock structure.
  * @clk_sec: pointer to the clock structure for accessing the base_second.
  * @sclk: pointer to the clock structure for accessing the tmu special clk.
+ * @cal_type: calibration type for temperature
  * @efuse_value: SoC defined fuse value
  * @min_efuse_value: minimum valid trimming data
  * @max_efuse_value: maximum valid trimming data
@@ -209,7 +209,6 @@
  */
 struct exynos_tmu_data {
 	int id;
-	struct exynos_tmu_platform_data *pdata;
 	void __iomem *base;
 	void __iomem *base_second;
 	int irq;
@@ -217,6 +216,7 @@ struct exynos_tmu_data {
 	struct work_struct irq_work;
 	struct mutex lock;
 	struct clk *clk, *clk_sec, *sclk;
+	u32 cal_type;
 	u32 efuse_value;
 	u32 min_efuse_value;
 	u32 max_efuse_value;
@@ -268,9 +268,7 @@ static void exynos_report_trigger(struct exynos_tmu_data *p)
  */
 static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 {
-	struct exynos_tmu_platform_data *pdata = data->pdata;
-
-	if (pdata->cal_type == TYPE_ONE_POINT_TRIMMING)
+	if (data->cal_type == TYPE_ONE_POINT_TRIMMING)
 		return temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
 
 	return (temp - EXYNOS_FIRST_POINT_TRIM) *
@@ -285,9 +283,7 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
  */
 static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 {
-	struct exynos_tmu_platform_data *pdata = data->pdata;
-
-	if (pdata->cal_type == TYPE_ONE_POINT_TRIMMING)
+	if (data->cal_type == TYPE_ONE_POINT_TRIMMING)
 		return temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
 
 	return (temp_code - data->temp_error1) *
@@ -519,7 +515,6 @@ static int exynos4412_tmu_initialize(struct platform_device *pdev)
 static int exynos5433_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct exynos_tmu_platform_data *pdata = data->pdata;
 	struct thermal_zone_device *tz = data->tzd;
 	unsigned int status, trim_info;
 	unsigned int rising_threshold = 0, falling_threshold = 0;
@@ -546,14 +541,12 @@ static int exynos5433_tmu_initialize(struct platform_device *pdev)
 				>> EXYNOS5433_TRIMINFO_CALIB_SEL_SHIFT;
 
 	switch (cal_type) {
-	case EXYNOS5433_TRIMINFO_ONE_POINT_TRIMMING:
-		pdata->cal_type = TYPE_ONE_POINT_TRIMMING;
-		break;
 	case EXYNOS5433_TRIMINFO_TWO_POINT_TRIMMING:
-		pdata->cal_type = TYPE_TWO_POINT_TRIMMING;
+		data->cal_type = TYPE_TWO_POINT_TRIMMING;
 		break;
+	case EXYNOS5433_TRIMINFO_ONE_POINT_TRIMMING:
 	default:
-		pdata->cal_type = TYPE_ONE_POINT_TRIMMING;
+		data->cal_type = TYPE_ONE_POINT_TRIMMING;
 		break;
 	}
 
@@ -1133,21 +1126,9 @@ static irqreturn_t exynos_tmu_irq(int irq, void *id)
 };
 MODULE_DEVICE_TABLE(of, exynos_tmu_match);
 
-static int exynos_of_sensor_conf(struct device_node *np,
-				 struct exynos_tmu_platform_data *pdata)
-{
-	of_node_get(np);
-
-	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
-
-	of_node_put(np);
-	return 0;
-}
-
 static int exynos_map_dt_data(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct exynos_tmu_platform_data *pdata;
 	struct resource res;
 
 	if (!data || !pdev->dev.of_node)
@@ -1174,14 +1155,6 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		return -EADDRNOTAVAIL;
 	}
 
-	pdata = devm_kzalloc(&pdev->dev,
-			     sizeof(struct exynos_tmu_platform_data),
-			     GFP_KERNEL);
-	if (!pdata)
-		return -ENOMEM;
-
-	exynos_of_sensor_conf(pdev->dev.of_node, pdata);
-	data->pdata = pdata;
 	data->soc = (enum soc_type)of_device_get_match_data(&pdev->dev);
 
 	switch (data->soc) {
@@ -1266,6 +1239,8 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	data->cal_type = TYPE_ONE_POINT_TRIMMING;
+
 	/*
 	 * Check if the TMU shares some registers and then try to map the
 	 * memory of common registers.
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 689453d..8f56f86 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -38,14 +38,4 @@ enum soc_type {
 	SOC_ARCH_EXYNOS7,
 };
 
-/**
- * struct exynos_tmu_platform_data
- * @cal_type: calibration type for temperature
- *
- * This structure is required for configuration of exynos_tmu driver.
- */
-struct exynos_tmu_platform_data {
-	u32 cal_type;
-};
-
 #endif /* _EXYNOS_TMU_H */
-- 
1.9.1
