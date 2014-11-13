From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 03/33] thermal: exynos: remove needless threshold_temp
 abstraction
Date: Thu, 13 Nov 2014 16:00:58 +0100
Message-ID: <1415890888-8881-4-git-send-email-b.zolnierkie@samsung.com>
References: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

reg->threshold_temp is used only in exynos_tmu_initialize() and
is accessed only on Exynos4210 (other SoC types don't even have
threshold_temp entry assigned in their struct exynos_tmu_registers
instances) so the register abstraction is not needed and can be
removed.

There should be no functional changes caused by this patch.

Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c      | 2 +-
 drivers/thermal/samsung/exynos_tmu.h      | 3 ---
 drivers/thermal/samsung/exynos_tmu_data.c | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ac43637..12e6f16 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -219,7 +219,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		/* Write temperature code for threshold */
 		threshold_code = temp_to_code(data, pdata->threshold);
 		writeb(threshold_code,
-			data->base + reg->threshold_temp);
+			data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
 		for (i = 0; i < pdata->non_hw_trigger_levels; i++)
 			writeb(pdata->trigger_levels[i], data->base +
 			reg->threshold_th0 + i * sizeof(reg->threshold_th0));
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 7849d8f..d693215 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -84,7 +84,6 @@ enum soc_type {
  * @therm_trip_mode_mask: mask bits of tripping mode in tmu_ctrl register.
  * @therm_trip_en_shift: shift bits of tripping enable in tmu_ctrl register.
  * @tmu_cur_temp: register containing the current temperature of the TMU.
- * @threshold_temp: register containing the base threshold level.
  * @threshold_th0: Register containing first set of rising levels.
  * @threshold_th1: Register containing second set of rising levels.
  * @threshold_th2: Register containing third set of rising levels.
@@ -116,8 +115,6 @@ struct exynos_tmu_registers {
 
 	u32	tmu_cur_temp;
 
-	u32	threshold_temp;
-
 	u32	threshold_th0;
 	u32	threshold_th1;
 	u32	threshold_th2;
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 49c8142..8153c41 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -28,7 +28,6 @@
 static const struct exynos_tmu_registers exynos4210_tmu_registers = {
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
-	.threshold_temp = EXYNOS4210_TMU_REG_THRESHOLD_TEMP,
 	.threshold_th0 = EXYNOS4210_TMU_REG_TRIG_LEVEL0,
 	.tmu_inten = EXYNOS_TMU_REG_INTEN,
 	.inten_rise0_shift = EXYNOS_TMU_INTEN_RISE0_SHIFT,
-- 
1.8.2.3
