From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 15/18] thermal: exynos: check return values of
 ->get_trip_[temp,hyst] methods
Date: Thu, 26 Apr 2018 13:51:30 +0200
Message-ID: <1524743493-28113-16-git-send-email-b.zolnierkie@samsung.com>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115236epcas2p3764927b3c23113fb4c3771b753a51199@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Check return values of ->get_trip_[temp,hyst] methods in
exynos_tmu_initialize().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 244aaf6..abe0737 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -357,19 +357,23 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		/* Write temperature code for rising and falling threshold */
 		for (i = 0; i < ntrips; i++) {
 			/* Write temperature code for rising threshold */
-			tzd->ops->get_trip_temp(tzd, i, &temp);
+			ret = tzd->ops->get_trip_temp(tzd, i, &temp);
+			if (ret)
+				goto err;
 			temp /= MCELSIUS;
 			data->tmu_set_trip_temp(data, i, temp);
 
 			/* Write temperature code for falling threshold */
-			tzd->ops->get_trip_hyst(tzd, i, &hyst);
+			ret = tzd->ops->get_trip_hyst(tzd, i, &hyst);
+			if (ret)
+				goto err;
 			hyst /= MCELSIUS;
 			data->tmu_set_trip_hyst(data, i, temp, hyst);
 		}
 
 		data->tmu_clear_irqs(data);
 	}
-
+err:
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 	if (!IS_ERR(data->clk_sec))
-- 
1.9.1
