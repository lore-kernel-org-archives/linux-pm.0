From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 13/33] thermal: exynos: replace threshold_falling check by
 Exynos SoC type one
Date: Thu, 13 Nov 2014 16:01:08 +0100
Message-ID: <1415890888-8881-14-git-send-email-b.zolnierkie@samsung.com>
References: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Replace pdata->threshold_falling check for non-zero value in
exynos_tmu_initialize() by an explicit check for a SoC type
(all SoC types except Exynos5440 have pdata->threshold_falling
assigned to non-zero value in their struct exynos_tmu_registers
instances).

This is a preparation for introducing per-SoC type tmu_initialize
method.

There should be no functional changes caused by this patch.

Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 1c15b37..4f7cad9 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -231,7 +231,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 						pdata->trigger_levels[i]);
 			rising_threshold &= ~(0xff << 8 * i);
 			rising_threshold |= threshold_code << 8 * i;
-			if (pdata->threshold_falling) {
+			if (data->soc != SOC_ARCH_EXYNOS5440) {
 				threshold_code = temp_to_code(data,
 						pdata->trigger_levels[i] -
 						pdata->threshold_falling);
-- 
1.8.2.3
