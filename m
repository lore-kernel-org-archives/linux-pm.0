From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 08/12] thermal: exynos: remove parsing of
 samsung,tmu_cal_type property
Date: Tue, 06 Mar 2018 15:43:51 +0100
Message-ID: <1520347435-22970-9-git-send-email-b.zolnierkie@samsung.com>
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144502epcas2p2818ee9c6d378d91fbff666549fb01931@epcas2p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Since calibration type for temperature is SoC (not platform) specific
just move it from platform data to struct exynos_tmu_data instance.
Then remove parsing of samsung,tmu_cal_type property. Also remove no
longer needed platform data structure.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 41 ++++++++----------------------------
 drivers/thermal/samsung/exynos_tmu.h | 10 ---------
 2 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 262ab41..ab5062b 100644
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
@@ -208,7 +208,6 @@
  */
 struct exynos_tmu_data {
 	int id;
-	struct exynos_tmu_platform_data *pdata;
 	void __iomem *base;
 	void __iomem *base_second;
 	int irq;
@@ -216,6 +215,7 @@ struct exynos_tmu_data {
 	struct work_struct irq_work;
 	struct mutex lock;
 	struct clk *clk, *clk_sec, *sclk;
+	u32 cal_type;
 	u32 efuse_value;
 	u32 min_efuse_value;
 	u32 max_efuse_value;
@@ -266,10 +266,9 @@ static void exynos_report_trigger(struct exynos_tmu_data *p)
  */
 static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 {
-	struct exynos_tmu_platform_data *pdata = data->pdata;
 	int temp_code;
 
-	switch (pdata->cal_type) {
+	switch (data->cal_type) {
 	case TYPE_TWO_POINT_TRIMMING:
 		temp_code = (temp - EXYNOS_FIRST_POINT_TRIM) *
 			(data->temp_error2 - data->temp_error1) /
@@ -293,10 +292,9 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
  */
 static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 {
-	struct exynos_tmu_platform_data *pdata = data->pdata;
 	int temp;
 
-	switch (pdata->cal_type) {
+	switch (data->cal_type) {
 	case TYPE_TWO_POINT_TRIMMING:
 		temp = (temp_code - data->temp_error1) *
 			(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
@@ -536,7 +534,6 @@ static int exynos4412_tmu_initialize(struct platform_device *pdev)
 static int exynos5433_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct exynos_tmu_platform_data *pdata = data->pdata;
 	struct thermal_zone_device *tz = data->tzd;
 	unsigned int status, trim_info;
 	unsigned int rising_threshold = 0, falling_threshold = 0;
@@ -563,14 +560,12 @@ static int exynos5433_tmu_initialize(struct platform_device *pdev)
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
 
@@ -1151,21 +1146,9 @@ static int exynos_of_get_soc_type(struct device_node *np)
 	return -EINVAL;
 }
 
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
@@ -1192,14 +1175,6 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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
 	data->soc = exynos_of_get_soc_type(pdev->dev.of_node);
 
 	switch (data->soc) {
@@ -1284,6 +1259,8 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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
