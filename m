From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 03/18] thermal: exynos: always check for critical trip
 points existence
Date: Thu, 26 Apr 2018 13:51:18 +0200
Message-ID: <1524743493-28113-4-git-send-email-b.zolnierkie@samsung.com>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115206epcas1p2da6ae1d85708907dc99a97baf0791b4d@epcas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

* Check for critical trip point existence in exynos_tmu_initialize()
  so it is checked on all SoCs (except Exynos5433 for now).

* Use dev_err() instead of pr_err().

* Fix dev_err() to reference "device tree" not "of-thermal.c".

* Remove no longer needed check from exynos4412_tmu_initialize().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 9e040eb..a0c1604 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -331,7 +331,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	struct thermal_zone_device *tzd = data->tzd;
 	const struct thermal_trip * const trips =
 		of_thermal_get_trip_points(tzd);
-	int ret;
+	int ret = 0, temp;
 
 	if (!trips) {
 		dev_err(&pdev->dev,
@@ -339,6 +339,14 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (data->soc != SOC_ARCH_EXYNOS5433) /* FIXME */
+		ret = tzd->ops->get_crit_temp(tzd, &temp);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"No CRITICAL trip point defined in device tree!\n");
+		goto out;
+	}
+
 	if (of_thermal_get_ntrips(tzd) > data->ntrip) {
 		dev_info(&pdev->dev,
 			 "More trip points than supported by this TMU.\n");
@@ -356,7 +364,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	mutex_unlock(&data->lock);
 	if (!IS_ERR(data->clk_sec))
 		clk_disable(data->clk_sec);
-
+out:
 	return ret;
 }
 
@@ -480,13 +488,6 @@ static int exynos4412_tmu_initialize(struct platform_device *pdev)
 		}
 	}
 
-	if (i == of_thermal_get_ntrips(data->tzd)) {
-		pr_err("%s: No CRITICAL trip point defined at of-thermal.c!\n",
-		       __func__);
-		ret = -EINVAL;
-		goto out;
-	}
-
 	threshold_code = temp_to_code(data, crit_temp / MCELSIUS);
 	/* 1-4 level to be assigned in th0 reg */
 	rising_threshold &= ~(0xff << 8 * i);
-- 
1.9.1
