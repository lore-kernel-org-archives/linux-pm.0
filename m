From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 3/8] thermal: exynos: remove redundant pdata checks from
 exynos_tmu_initialize()
Date: Thu, 31 Jul 2014 19:11:01 +0200
Message-ID: <1406826667-2289-4-git-send-email-b.zolnierkie@samsung.com>
References: <1406826667-2289-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1406826667-2289-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Remove runtime checks for pdata sanity from exynos_tmu_initialize().

The current values hardcoded in pdata will never trigger the checks
and checking itself is not proper.  The checks in question are done
at runtime in a production code for data that is hardcoded inside
driver during development time and later it doesn't change.  Such
data should be verified during development and review time (i.e. by
a script parsing relevant data from exynos_tmu_data.c, one can also
argue that verification to be done is so simple that the review by
a maintainer should be enough).

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_thermal_common.h |  1 -
 drivers/thermal/samsung/exynos_tmu.c            | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_thermal_common.h b/drivers/thermal/samsung/exynos_thermal_common.h
index 3eb2ed9..cd44719 100644
--- a/drivers/thermal/samsung/exynos_thermal_common.h
+++ b/drivers/thermal/samsung/exynos_thermal_common.h
@@ -27,7 +27,6 @@
 #define SENSOR_NAME_LEN	16
 #define MAX_TRIP_COUNT	8
 #define MAX_COOLING_DEVICE 4
-#define MAX_THRESHOLD_LEVS 5
 
 #define ACTIVE_INTERVAL 500
 #define IDLE_INTERVAL 10000
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 4a55f11..b9bffad 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -201,23 +201,10 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 			(pdata->efuse_value >> reg->triminfo_85_shift) &
 			EXYNOS_TMU_TEMP_MASK;
 
-	if (pdata->max_trigger_level > MAX_THRESHOLD_LEVS) {
-		dev_err(&pdev->dev, "Invalid max trigger level\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
 	for (i = 0; i < pdata->max_trigger_level; i++) {
 		if (!pdata->trigger_levels[i])
 			continue;
 
-		if ((pdata->trigger_type[i] == HW_TRIP) &&
-		(!pdata->trigger_levels[pdata->max_trigger_level - 1])) {
-			dev_err(&pdev->dev, "Invalid hw trigger level\n");
-			ret = -EINVAL;
-			goto out;
-		}
-
 		/* Count trigger levels except the HW trip*/
 		if (!(pdata->trigger_type[i] == HW_TRIP))
 			trigger_levs++;
-- 
1.8.2.3
