From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 5/9] thermal: exynos: remove redundant threshold_code checks
 from exynos_tmu_initialize()
Date: Tue, 17 Jun 2014 19:27:21 +0200
Message-ID: <1403026045-16024-6-git-send-email-b.zolnierkie@samsung.com>
References: <1403026045-16024-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1403026045-16024-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Remove runtime checks for negative return values of temp_to_code()
from exynos_tmu_initialize().

The current level temperature data hardcoded in pdata will never
cause a negative temp_to_code() return values and checking itself
is not proper.  The checks in question are done at runtime in
a production code for data that is hardcoded inside driver during
development time and later it doesn't change.  Such data should
be verified during development and review time (i.e. by a script
parsing relevant data from exynos_tmu_data.c, one can also argue
that verification to be done is so simple that the review by
a maintainer should be enough).

Theres should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index f061580..204f811 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -180,10 +180,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	if (data->soc == SOC_ARCH_EXYNOS4210) {
 		/* Write temperature code for threshold */
 		threshold_code = temp_to_code(data, pdata->threshold);
-		if (threshold_code < 0) {
-			ret = threshold_code;
-			goto out;
-		}
 		writeb(threshold_code,
 			data->base + reg->threshold_temp);
 		for (i = 0; i < trigger_levs; i++)
@@ -197,19 +193,13 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		i < trigger_levs && i < EXYNOS_MAX_TRIGGER_PER_REG; i++) {
 			threshold_code = temp_to_code(data,
 						pdata->trigger_levels[i]);
-			if (threshold_code < 0) {
-				ret = threshold_code;
-				goto out;
-			}
 			rising_threshold &= ~(0xff << 8 * i);
 			rising_threshold |= threshold_code << 8 * i;
 			if (pdata->threshold_falling) {
 				threshold_code = temp_to_code(data,
 						pdata->trigger_levels[i] -
 						pdata->threshold_falling);
-				if (threshold_code > 0)
-					falling_threshold |=
-						threshold_code << 8 * i;
+				falling_threshold |= threshold_code << 8 * i;
 			}
 		}
 
@@ -228,10 +218,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 				(pdata->trigger_type[i] == HW_TRIP)) {
 			threshold_code = temp_to_code(data,
 						pdata->trigger_levels[i]);
-			if (threshold_code < 0) {
-				ret = threshold_code;
-				goto out;
-			}
 			if (i == EXYNOS_MAX_TRIGGER_PER_REG - 1) {
 				/* 1-4 level to be assigned in th0 reg */
 				rising_threshold &= ~(0xff << 8 * i);
-- 
1.8.2.3
