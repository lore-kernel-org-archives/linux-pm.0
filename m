From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 17/33] thermal: exynos: add get_th_reg() helper
Date: Thu, 18 Sep 2014 17:27:34 +0200
Message-ID: <1411054070-25757-18-git-send-email-b.zolnierkie@samsung.com>
References: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Factor out code for preparing threshold register value from
exynos_tmu_initialize() into get_th_reg().

This is a preparation for introducing per-SoC type tmu_initialize
method.

There should be no functional changes caused by this patch.

Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 37 ++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index a32ca04..80b781d 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -141,6 +141,25 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 			EXYNOS_TMU_TEMP_MASK;
 }
 
+static u32 get_th_reg(struct exynos_tmu_data *data, u32 threshold, bool falling)
+{
+	struct exynos_tmu_platform_data *pdata = data->pdata;
+	int i;
+
+	for (i = 0; i < pdata->non_hw_trigger_levels; i++) {
+		u8 temp = pdata->trigger_levels[i];
+
+		if (falling)
+			temp -= pdata->threshold_falling;
+		else
+			threshold &= ~(0xff << 8 * i);
+
+		threshold |= temp_to_code(data, temp) << 8 * i;
+	}
+
+	return threshold;
+}
+
 static int exynos_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
@@ -204,8 +223,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	}
 	sanitize_temp_error(data, trim_info);
 
-	rising_threshold = readl(data->base + reg->threshold_th0);
-
 	if (data->soc == SOC_ARCH_EXYNOS4210) {
 		/* Write temperature code for threshold */
 		threshold_code = temp_to_code(data, pdata->threshold);
@@ -218,18 +235,10 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		writel(reg->intclr_rise_mask, data->base + reg->tmu_intclear);
 	} else {
 		/* Write temperature code for rising and falling threshold */
-		for (i = 0; i < pdata->non_hw_trigger_levels; i++) {
-			threshold_code = temp_to_code(data,
-						pdata->trigger_levels[i]);
-			rising_threshold &= ~(0xff << 8 * i);
-			rising_threshold |= threshold_code << 8 * i;
-			if (data->soc != SOC_ARCH_EXYNOS5440) {
-				threshold_code = temp_to_code(data,
-						pdata->trigger_levels[i] -
-						pdata->threshold_falling);
-				falling_threshold |= threshold_code << 8 * i;
-			}
-		}
+		rising_threshold = readl(data->base + reg->threshold_th0);
+		rising_threshold = get_th_reg(data, rising_threshold, false);
+		if (data->soc != SOC_ARCH_EXYNOS5440)
+			falling_threshold = get_th_reg(data, 0, true);
 
 		writel(rising_threshold,
 				data->base + reg->threshold_th0);
-- 
1.8.2.3
