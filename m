From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 07/18] thermal: exynos: remove threshold_code checking from
 exynos4210_tmu_initialize()
Date: Thu, 26 Apr 2018 13:51:22 +0200
Message-ID: <1524743493-28113-8-git-send-email-b.zolnierkie@samsung.com>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115216epcas1p3ed61f0fd8563e7ea72f3d7d17c9c039f@epcas1p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

On Exynos4210 one-point trimming is always used and data->temp_error1
is equal to 75. Therefore temp_to_code() will never return negative
value for the reference temperature conversion.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 58cd68e..26a0cb9 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -423,10 +423,6 @@ static int exynos4210_tmu_initialize(struct platform_device *pdev)
 	/* Write temperature code for threshold */
 	reference = trips[0].temperature / MCELSIUS;
 	threshold_code = temp_to_code(data, reference);
-	if (threshold_code < 0) {
-		ret = threshold_code;
-		goto out;
-	}
 	writeb(threshold_code, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
 
 	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
@@ -436,7 +432,7 @@ static int exynos4210_tmu_initialize(struct platform_device *pdev)
 	}
 
 	data->tmu_clear_irqs(data);
-out:
+
 	return ret;
 }
 
-- 
1.9.1
