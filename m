From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 05/14] thermal: exynos: remove parsing of
 samsung,tmu_default_temp_offset property
Date: Mon, 16 Apr 2018 12:11:56 +0200
Message-ID: <1523873525-23718-6-git-send-email-b.zolnierkie@samsung.com>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101400epcas1p45e65b37b922a5d0265de7879eeb1df87@epcas1p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Trimming (one point based or two points based) is always used for
the temperature calibration and the default non-trimming code is
never reached. Remove it and then remove no longer needed parsing
of samsung,tmu_default_temp_offset property.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 48 ++++++++++--------------------------
 drivers/thermal/samsung/exynos_tmu.h |  2 --
 2 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index d7a3c3c..958a7c4 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -249,24 +249,14 @@ static void exynos_report_trigger(struct exynos_tmu_data *p)
 static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 {
 	struct exynos_tmu_platform_data *pdata = data->pdata;
-	int temp_code;
-
-	switch (pdata->cal_type) {
-	case TYPE_TWO_POINT_TRIMMING:
-		temp_code = (temp - pdata->first_point_trim) *
-			(data->temp_error2 - data->temp_error1) /
-			(pdata->second_point_trim - pdata->first_point_trim) +
-			data->temp_error1;
-		break;
-	case TYPE_ONE_POINT_TRIMMING:
-		temp_code = temp + data->temp_error1 - pdata->first_point_trim;
-		break;
-	default:
-		temp_code = temp + pdata->default_temp_offset;
-		break;
-	}
 
-	return temp_code;
+	if (pdata->cal_type == TYPE_ONE_POINT_TRIMMING)
+		return temp + data->temp_error1 - pdata->first_point_trim;
+
+	return (temp - pdata->first_point_trim) *
+		(data->temp_error2 - data->temp_error1) /
+		(pdata->second_point_trim - pdata->first_point_trim) +
+		data->temp_error1;
 }
 
 /*
@@ -276,24 +266,14 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 {
 	struct exynos_tmu_platform_data *pdata = data->pdata;
-	int temp;
 
-	switch (pdata->cal_type) {
-	case TYPE_TWO_POINT_TRIMMING:
-		temp = (temp_code - data->temp_error1) *
-			(pdata->second_point_trim - pdata->first_point_trim) /
-			(data->temp_error2 - data->temp_error1) +
-			pdata->first_point_trim;
-		break;
-	case TYPE_ONE_POINT_TRIMMING:
-		temp = temp_code - data->temp_error1 + pdata->first_point_trim;
-		break;
-	default:
-		temp = temp_code - pdata->default_temp_offset;
-		break;
-	}
+	if (pdata->cal_type == TYPE_ONE_POINT_TRIMMING)
+		return temp_code - data->temp_error1 + pdata->first_point_trim;
 
-	return temp;
+	return (temp_code - data->temp_error1) *
+		(pdata->second_point_trim - pdata->first_point_trim) /
+		(data->temp_error2 - data->temp_error1) +
+		pdata->first_point_trim;
 }
 
 static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
@@ -1166,8 +1146,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
 	pdata->first_point_trim = (u8)value;
 	of_property_read_u32(np, "samsung,tmu_second_point_trim", &value);
 	pdata->second_point_trim = (u8)value;
-	of_property_read_u32(np, "samsung,tmu_default_temp_offset", &value);
-	pdata->default_temp_offset = (u8)value;
 
 	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
 
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 8c468b6..a7e81b4 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -50,7 +50,6 @@ enum soc_type {
  * @efuse_value: platform defined fuse value
  * @min_efuse_value: minimum valid trimming data
  * @max_efuse_value: maximum valid trimming data
- * @default_temp_offset: default temperature offset in case of no trimming
  * @cal_type: calibration type for temperature
  *
  * This structure is required for configuration of exynos_tmu driver.
@@ -65,7 +64,6 @@ struct exynos_tmu_platform_data {
 	u32 max_efuse_value;
 	u8 first_point_trim;
 	u8 second_point_trim;
-	u8 default_temp_offset;
 
 	u32 cal_type;
 };
-- 
1.9.1
