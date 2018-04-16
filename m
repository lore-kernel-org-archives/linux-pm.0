From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 06/14] thermal: exynos: remove parsing of
 samsung,tmu_[first,second]_point_trim properties
Date: Mon, 16 Apr 2018 12:11:57 +0200
Message-ID: <1523873525-23718-7-git-send-email-b.zolnierkie@samsung.com>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101403epcas2p23c050a54c2cc8af9c8be76061d560937@epcas2p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

All SoCs use the same values (25, 85) for trim points (except
Exynos5440 which currently specifices value 70 for the second trim
point -> it seems to be a mistake because documentation uses value
85 and two points based trimming has never been used by the driver
for this SoC anyway) so just make it explicit and remove parsing of
samsung,tmu_[first,second]_point_trim properties.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 20 +++++++++-----------
 drivers/thermal/samsung/exynos_tmu.h |  2 --
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 958a7c4..7ec8061 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -165,6 +165,9 @@
 #define EXYNOS7_EMUL_DATA_SHIFT			7
 #define EXYNOS7_EMUL_DATA_MASK			0x1ff
 
+#define EXYNOS_FIRST_POINT_TRIM			25
+#define EXYNOS_SECOND_POINT_TRIM		85
+
 #define MCELSIUS	1000
 /**
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
@@ -251,11 +254,11 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 	struct exynos_tmu_platform_data *pdata = data->pdata;
 
 	if (pdata->cal_type == TYPE_ONE_POINT_TRIMMING)
-		return temp + data->temp_error1 - pdata->first_point_trim;
+		return temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
 
-	return (temp - pdata->first_point_trim) *
+	return (temp - EXYNOS_FIRST_POINT_TRIM) *
 		(data->temp_error2 - data->temp_error1) /
-		(pdata->second_point_trim - pdata->first_point_trim) +
+		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
 		data->temp_error1;
 }
 
@@ -268,12 +271,12 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 	struct exynos_tmu_platform_data *pdata = data->pdata;
 
 	if (pdata->cal_type == TYPE_ONE_POINT_TRIMMING)
-		return temp_code - data->temp_error1 + pdata->first_point_trim;
+		return temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
 
 	return (temp_code - data->temp_error1) *
-		(pdata->second_point_trim - pdata->first_point_trim) /
+		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
 		(data->temp_error2 - data->temp_error1) +
-		pdata->first_point_trim;
+		EXYNOS_FIRST_POINT_TRIM;
 }
 
 static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
@@ -1142,11 +1145,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
 	of_property_read_u32(np, "samsung,tmu_max_efuse_value",
 			     &pdata->max_efuse_value);
 
-	of_property_read_u32(np, "samsung,tmu_first_point_trim", &value);
-	pdata->first_point_trim = (u8)value;
-	of_property_read_u32(np, "samsung,tmu_second_point_trim", &value);
-	pdata->second_point_trim = (u8)value;
-
 	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
 
 	of_node_put(np);
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index a7e81b4..a5d8c9c 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -62,8 +62,6 @@ struct exynos_tmu_platform_data {
 	u32 efuse_value;
 	u32 min_efuse_value;
 	u32 max_efuse_value;
-	u8 first_point_trim;
-	u8 second_point_trim;
 
 	u32 cal_type;
 };
-- 
1.9.1
