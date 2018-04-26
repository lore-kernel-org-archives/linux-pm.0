From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 14/18] thermal: exynos: move trips setting to
 exynos_tmu_initialize()
Date: Thu, 26 Apr 2018 13:51:29 +0200
Message-ID: <1524743493-28113-15-git-send-email-b.zolnierkie@samsung.com>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115234epcas1p47cf54556fd061e8f90a4df4a2c62f7ce@epcas1p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

* Add dummy exynos4210_tmu_set_trip_hyst() helper.

* Add ->tmu_set_trip_temp and ->tmu_set_trip_hyst methods to struct
  exynos_tmu_data and set them in exynos_map_dt_data().

* Move trips setting to exynos_tmu_initialize().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 88 +++++++++++++++---------------------
 1 file changed, 37 insertions(+), 51 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 571511f..244aaf6 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -220,6 +220,10 @@ struct exynos_tmu_data {
 	unsigned int ntrip;
 	bool enabled;
 
+	void (*tmu_set_trip_temp)(struct exynos_tmu_data *data, int trip,
+				 u8 temp);
+	void (*tmu_set_trip_hyst)(struct exynos_tmu_data *data, int trip,
+				 u8 temp, u8 hyst);
 	void (*tmu_initialize)(struct platform_device *pdev);
 	void (*tmu_control)(struct platform_device *pdev, bool on);
 	int (*tmu_read)(struct exynos_tmu_data *data);
@@ -312,7 +316,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	const struct thermal_trip * const trips =
 		of_thermal_get_trip_points(tzd);
 	unsigned int status;
-	int ret = 0, temp;
+	int ret = 0, temp, hyst;
 
 	if (!trips) {
 		dev_err(&pdev->dev,
@@ -345,7 +349,24 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	if (!status)
 		ret = -EBUSY;
 	else {
+		int i, ntrips =
+			min_t(int, of_thermal_get_ntrips(tzd), data->ntrip);
+
 		data->tmu_initialize(pdev);
+
+		/* Write temperature code for rising and falling threshold */
+		for (i = 0; i < ntrips; i++) {
+			/* Write temperature code for rising threshold */
+			tzd->ops->get_trip_temp(tzd, i, &temp);
+			temp /= MCELSIUS;
+			data->tmu_set_trip_temp(data, i, temp);
+
+			/* Write temperature code for falling threshold */
+			tzd->ops->get_trip_hyst(tzd, i, &hyst);
+			hyst /= MCELSIUS;
+			data->tmu_set_trip_hyst(data, i, temp, hyst);
+		}
+
 		data->tmu_clear_irqs(data);
 	}
 
@@ -405,19 +426,17 @@ static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
 	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + trip * 4);
 }
 
+/* failing thresholds are not supported on Exynos4210 */
+static void exynos4210_tmu_set_trip_hyst(struct exynos_tmu_data *data,
+					 int trip, u8 temp, u8 hyst)
+{
+}
+
 static void exynos4210_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
-	int i, temp;
 
 	sanitize_temp_error(data, readl(data->base + EXYNOS_TMU_REG_TRIMINFO));
-
-	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
-		tz->ops->get_trip_temp(tz, i, &temp);
-		temp /= MCELSIUS;
-		exynos4210_tmu_set_trip_temp(data, i, temp);
-	}
 }
 
 static void exynos4412_tmu_set_trip_temp(struct exynos_tmu_data *data,
@@ -452,10 +471,7 @@ static void exynos4412_tmu_set_trip_hyst(struct exynos_tmu_data *data,
 static void exynos4412_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
 	unsigned int trim_info, ctrl;
-	int i, ntrips = min_t(int, of_thermal_get_ntrips(tz), data->ntrip);
-	int temp, hyst;
 
 	if (data->soc == SOC_ARCH_EXYNOS3250 ||
 	    data->soc == SOC_ARCH_EXYNOS4412 ||
@@ -477,17 +493,6 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 		trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 
 	sanitize_temp_error(data, trim_info);
-
-	/* Write temperature code for rising and falling threshold */
-	for (i = 0; i < ntrips; i++) {
-		tz->ops->get_trip_temp(tz, i, &temp);
-		temp /= MCELSIUS;
-		exynos4412_tmu_set_trip_temp(data, i, temp);
-
-		tz->ops->get_trip_hyst(tz, i, &hyst);
-		hyst /= MCELSIUS;
-		exynos4412_tmu_set_trip_hyst(data, i, temp, hyst);
-	}
 }
 
 static void exynos5433_tmu_set_trip_temp(struct exynos_tmu_data *data,
@@ -533,9 +538,8 @@ static void exynos5433_tmu_set_trip_hyst(struct exynos_tmu_data *data,
 static void exynos5433_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
 	unsigned int trim_info;
-	int sensor_id, cal_type, i, temp, hyst;
+	int sensor_id, cal_type;
 
 	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 	sanitize_temp_error(data, trim_info);
@@ -562,19 +566,6 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "Calibration type is %d-point calibration\n",
 			cal_type ?  2 : 1);
-
-	/* Write temperature code for rising and falling threshold */
-	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
-		/* Write temperature code for rising threshold */
-		tz->ops->get_trip_temp(tz, i, &temp);
-		temp /= MCELSIUS;
-		exynos5433_tmu_set_trip_temp(data, i, temp);
-
-		/* Write temperature code for falling threshold */
-		tz->ops->get_trip_hyst(tz, i, &hyst);
-		hyst /= MCELSIUS;
-		exynos5433_tmu_set_trip_hyst(data, i, temp, hyst);
-	}
 }
 
 static void exynos7_tmu_set_trip_temp(struct exynos_tmu_data *data,
@@ -610,23 +601,10 @@ static void exynos7_tmu_set_trip_hyst(struct exynos_tmu_data *data,
 static void exynos7_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
 	unsigned int trim_info;
-	int i, temp, hyst;
 
 	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 	sanitize_temp_error(data, trim_info);
-
-	/* Write temperature code for rising and falling threshold */
-	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
-		tz->ops->get_trip_temp(tz, i, &temp);
-		temp /= MCELSIUS;
-		exynos7_tmu_set_trip_temp(data, i, temp);
-
-		tz->ops->get_trip_hyst(tz, i, &hyst);
-		hyst /= MCELSIUS;
-		exynos7_tmu_set_trip_hyst(data, i, temp, hyst);
-	}
 }
 
 static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
@@ -989,6 +967,8 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 
 	switch (data->soc) {
 	case SOC_ARCH_EXYNOS4210:
+		data->tmu_set_trip_temp = exynos4210_tmu_set_trip_temp;
+		data->tmu_set_trip_hyst = exynos4210_tmu_set_trip_hyst;
 		data->tmu_initialize = exynos4210_tmu_initialize;
 		data->tmu_control = exynos4210_tmu_control;
 		data->tmu_read = exynos4210_tmu_read;
@@ -1006,6 +986,8 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	case SOC_ARCH_EXYNOS5260:
 	case SOC_ARCH_EXYNOS5420:
 	case SOC_ARCH_EXYNOS5420_TRIMINFO:
+		data->tmu_set_trip_temp = exynos4412_tmu_set_trip_temp;
+		data->tmu_set_trip_hyst = exynos4412_tmu_set_trip_hyst;
 		data->tmu_initialize = exynos4412_tmu_initialize;
 		data->tmu_control = exynos4210_tmu_control;
 		data->tmu_read = exynos4412_tmu_read;
@@ -1023,6 +1005,8 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->max_efuse_value = 100;
 		break;
 	case SOC_ARCH_EXYNOS5433:
+		data->tmu_set_trip_temp = exynos5433_tmu_set_trip_temp;
+		data->tmu_set_trip_hyst = exynos5433_tmu_set_trip_hyst;
 		data->tmu_initialize = exynos5433_tmu_initialize;
 		data->tmu_control = exynos5433_tmu_control;
 		data->tmu_read = exynos4412_tmu_read;
@@ -1039,6 +1023,8 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->max_efuse_value = 150;
 		break;
 	case SOC_ARCH_EXYNOS7:
+		data->tmu_set_trip_temp = exynos7_tmu_set_trip_temp;
+		data->tmu_set_trip_hyst = exynos7_tmu_set_trip_hyst;
 		data->tmu_initialize = exynos7_tmu_initialize;
 		data->tmu_control = exynos7_tmu_control;
 		data->tmu_read = exynos7_tmu_read;
-- 
1.9.1
