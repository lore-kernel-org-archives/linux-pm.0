From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] thermal: samsung: Remove Exynos5440 clock handling left-overs
Date: Tue, 17 Jul 2018 17:46:17 +0200
Message-ID: <20180717154617.29913-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Commit 8014220d48e7 ("thermal: samsung: Remove support for Exynos5440")
removed the Exynos5440 specific part of code for accessing TMU interrupt
registers but the surrounding clock handling was left.

Clean it up.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index a992e51ef065..48eef552cba4 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -789,11 +789,6 @@ static void exynos_tmu_work(struct work_struct *work)
 	struct exynos_tmu_data *data = container_of(work,
 			struct exynos_tmu_data, irq_work);
 
-	if (!IS_ERR(data->clk_sec))
-		clk_enable(data->clk_sec);
-	if (!IS_ERR(data->clk_sec))
-		clk_disable(data->clk_sec);
-
 	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
 
 	mutex_lock(&data->lock);
-- 
2.14.1
