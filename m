From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 4/8] thermal: exynos: remove redundant threshold_code checks
 from exynos_tmu_initialize()
Date: Thu, 31 Jul 2014 19:11:02 +0200
Message-ID: <1406826667-2289-5-git-send-email-b.zolnierkie@samsung.com>
References: <1406826667-2289-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1406826667-2289-1-git-send-email-b.zolnierkie@samsung.com>
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
index b9bffad..15574cc 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -215,10 +215,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
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
@@ -232,19 +228,13 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
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
 
@@ -263,10 +253,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
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
