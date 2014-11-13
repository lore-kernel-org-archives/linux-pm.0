From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 32/33] thermal: exynos: remove __EXYNOS5420_TMU_DATA macro
Date: Thu, 13 Nov 2014 16:01:27 +0100
Message-ID: <1415890888-8881-33-git-send-email-b.zolnierkie@samsung.com>
References: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

__EXYNOS5420_TMU_DATA macro is now identical to __EXYNOS5260_TMU_DATA
one and can be removed.

There should be no functional changes caused by this patch.

Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu_data.c | 40 ++-----------------------------
 1 file changed, 2 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 02a1c34..592c470 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -216,48 +216,12 @@ struct exynos_tmu_init_data const exynos5260_default_tmu_data = {
 	.tmu_count = 5,
 };
 
-#define __EXYNOS5420_TMU_DATA	\
-	.threshold_falling = 10, \
-	.trigger_levels[0] = 85, \
-	.trigger_levels[1] = 103, \
-	.trigger_levels[2] = 110, \
-	.trigger_levels[3] = 120, \
-	.trigger_enable[0] = true, \
-	.trigger_enable[1] = true, \
-	.trigger_enable[2] = true, \
-	.trigger_enable[3] = false, \
-	.trigger_type[0] = THROTTLE_ACTIVE, \
-	.trigger_type[1] = THROTTLE_ACTIVE, \
-	.trigger_type[2] = SW_TRIP, \
-	.trigger_type[3] = HW_TRIP, \
-	.max_trigger_level = 4, \
-	.non_hw_trigger_levels = 3, \
-	.gain = 8, \
-	.reference_voltage = 16, \
-	.noise_cancel_mode = 4, \
-	.cal_type = TYPE_ONE_POINT_TRIMMING, \
-	.efuse_value = 55, \
-	.min_efuse_value = 40, \
-	.max_efuse_value = 100, \
-	.first_point_trim = 25, \
-	.second_point_trim = 85, \
-	.default_temp_offset = 50, \
-	.freq_tab[0] = { \
-		.freq_clip_max = 800 * 1000, \
-		.temp_level = 85, \
-	}, \
-	.freq_tab[1] = { \
-		.freq_clip_max = 200 * 1000, \
-		.temp_level = 103, \
-	}, \
-	.freq_tab_count = 2, \
-
 #define EXYNOS5420_TMU_DATA \
-	__EXYNOS5420_TMU_DATA \
+	__EXYNOS5260_TMU_DATA \
 	.type = SOC_ARCH_EXYNOS5420
 
 #define EXYNOS5420_TMU_DATA_SHARED \
-	__EXYNOS5420_TMU_DATA \
+	__EXYNOS5260_TMU_DATA \
 	.type = SOC_ARCH_EXYNOS5420_TRIMINFO
 
 struct exynos_tmu_init_data const exynos5420_default_tmu_data = {
-- 
1.8.2.3
