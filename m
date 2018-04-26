From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 12/18] thermal: exynos: do not use trips structure directly
 in ->tmu_initialize
Date: Thu, 26 Apr 2018 13:51:27 +0200
Message-ID: <1524743493-28113-13-git-send-email-b.zolnierkie@samsung.com>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115229epcas1p42ebcc547531485a4f30284dd3be7e43a@epcas1p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Use ->get_trip_[temp,hyst] methods instead of using trips structure
directly in all ->tmu_initialize method implementations.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 80265d2..12b60e2 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -409,15 +409,13 @@ static void exynos4210_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
-	const struct thermal_trip * const trips =
-		of_thermal_get_trip_points(tz);
-	unsigned long temp;
-	int i;
+	int i, temp;
 
 	sanitize_temp_error(data, readl(data->base + EXYNOS_TMU_REG_TRIMINFO));
 
 	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
-		temp = trips[i].temperature / MCELSIUS;
+		tz->ops->get_trip_temp(tz, i, &temp);
+		temp /= MCELSIUS;
 		exynos4210_tmu_set_trip_temp(data, i, temp);
 	}
 }
@@ -455,11 +453,9 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
-	const struct thermal_trip * const trips =
-		of_thermal_get_trip_points(tz);
-	unsigned long temp, hyst;
 	unsigned int trim_info, ctrl;
 	int i, ntrips = min_t(int, of_thermal_get_ntrips(tz), data->ntrip);
+	int temp, hyst;
 
 	if (data->soc == SOC_ARCH_EXYNOS3250 ||
 	    data->soc == SOC_ARCH_EXYNOS4412 ||
@@ -484,10 +480,12 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 
 	/* Write temperature code for rising and falling threshold */
 	for (i = 0; i < ntrips; i++) {
-		temp = trips[i].temperature / MCELSIUS;
+		tz->ops->get_trip_temp(tz, i, &temp);
+		temp /= MCELSIUS;
 		exynos4412_tmu_set_trip_temp(data, i, temp);
 
-		hyst = trips[i].hysteresis / MCELSIUS;
+		tz->ops->get_trip_hyst(tz, i, &hyst);
+		hyst /= MCELSIUS;
 		exynos4412_tmu_set_trip_hyst(data, i, temp, hyst);
 	}
 }
-- 
1.9.1
