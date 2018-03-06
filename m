From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 03/12] thermal: exynos: remove parsing of
 samsung,tmu_[first,second]_point_trim properties
Date: Tue, 06 Mar 2018 15:43:46 +0100
Message-ID: <1520347435-22970-4-git-send-email-b.zolnierkie@samsung.com>
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144440epcas2p30fd2531c12454051bfe6ae0cf0d35b2e@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
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
index e42a08b..5877dd4 100644
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
@@ -251,13 +254,13 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 
 	switch (pdata->cal_type) {
 	case TYPE_TWO_POINT_TRIMMING:
-		temp_code = (temp - pdata->first_point_trim) *
+		temp_code = (temp - EXYNOS_FIRST_POINT_TRIM) *
 			(data->temp_error2 - data->temp_error1) /
-			(pdata->second_point_trim - pdata->first_point_trim) +
+			(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
 			data->temp_error1;
 		break;
 	case TYPE_ONE_POINT_TRIMMING:
-		temp_code = temp + data->temp_error1 - pdata->first_point_trim;
+		temp_code = temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
 		break;
 	default:
 		WARN_ON(1);
@@ -279,12 +282,12 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 	switch (pdata->cal_type) {
 	case TYPE_TWO_POINT_TRIMMING:
 		temp = (temp_code - data->temp_error1) *
-			(pdata->second_point_trim - pdata->first_point_trim) /
+			(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
 			(data->temp_error2 - data->temp_error1) +
-			pdata->first_point_trim;
+			EXYNOS_FIRST_POINT_TRIM;
 		break;
 	case TYPE_ONE_POINT_TRIMMING:
-		temp = temp_code - data->temp_error1 + pdata->first_point_trim;
+		temp = temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
 		break;
 	default:
 		WARN_ON(1);
@@ -1160,11 +1163,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
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
