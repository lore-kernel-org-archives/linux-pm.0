From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 02/18] thermal: exynos: always check for trips points
 existence
Date: Thu, 26 Apr 2018 13:51:17 +0200
Message-ID: <1524743493-28113-3-git-send-email-b.zolnierkie@samsung.com>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115204epcas2p3a0b53d8b2bdd687b1acc19db98f30227@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

* Check for trip points existence in exynos_tmu_initialize() so it is
  checked on all SoCs.

* Use dev_err() instead of pr_err().

* Fix dev_err() to reference "device tree" not "of-thermal.c".

* Remove no longer needed checks from exynos4210_tmu_initialize() and
  get_th_reg().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 523d26e..9e040eb 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -309,12 +309,6 @@ static u32 get_th_reg(struct exynos_tmu_data *data, u32 threshold, bool falling)
 	unsigned long temp;
 	int i;
 
-	if (!trips) {
-		pr_err("%s: Cannot get trip points from of-thermal.c!\n",
-		       __func__);
-		return 0;
-	}
-
 	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
 		if (trips[i].type == THERMAL_TRIP_CRITICAL)
 			continue;
@@ -334,14 +328,23 @@ static u32 get_th_reg(struct exynos_tmu_data *data, u32 threshold, bool falling)
 static int exynos_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
+	struct thermal_zone_device *tzd = data->tzd;
+	const struct thermal_trip * const trips =
+		of_thermal_get_trip_points(tzd);
 	int ret;
 
-	if (of_thermal_get_ntrips(data->tzd) > data->ntrip) {
+	if (!trips) {
+		dev_err(&pdev->dev,
+			"Cannot get trip points from device tree!\n");
+		return -ENODEV;
+	}
+
+	if (of_thermal_get_ntrips(tzd) > data->ntrip) {
 		dev_info(&pdev->dev,
 			 "More trip points than supported by this TMU.\n");
 		dev_info(&pdev->dev,
 			 "%d trip points should be configured in polling mode.\n",
-			 (of_thermal_get_ntrips(data->tzd) - data->ntrip));
+			 (of_thermal_get_ntrips(tzd) - data->ntrip));
 	}
 
 	mutex_lock(&data->lock);
@@ -397,13 +400,6 @@ static int exynos4210_tmu_initialize(struct platform_device *pdev)
 	unsigned long reference, temp;
 	unsigned int status;
 
-	if (!trips) {
-		pr_err("%s: Cannot get trip points from of-thermal.c!\n",
-		       __func__);
-		ret = -ENODEV;
-		goto out;
-	}
-
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 	if (!status) {
 		ret = -EBUSY;
-- 
1.9.1
