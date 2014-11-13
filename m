From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 02/33] thermal: exynos: remove needless tmu_status
 abstraction
Date: Thu, 13 Nov 2014 16:00:57 +0100
Message-ID: <1415890888-8881-3-git-send-email-b.zolnierkie@samsung.com>
References: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

reg->tmu_status is used only in exynos_tmu_initialize() and it
is accessed only if TMU_SUPPORT_READY_STATUS flag is set.  This
flag is not set for Exynos5440 and TMU_STATUS register offset
is identical for all other SoC types so the abstraction is not
needed and can be removed.

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
 drivers/thermal/samsung/exynos_tmu_data.c | 6 ------
 drivers/thermal/samsung/exynos_tmu_data.h | 1 -
 4 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index bb05355..ac43637 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -154,7 +154,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		clk_enable(data->clk_sec);
 
 	if (TMU_SUPPORTS(pdata, READY_STATUS)) {
-		status = readb(data->base + reg->tmu_status);
+		status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 		if (!status) {
 			ret = -EBUSY;
 			goto out;
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 91e2317..7849d8f 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -83,7 +83,6 @@ enum soc_type {
  * @therm_trip_mode_shift: shift bits of tripping mode in tmu_ctrl register.
  * @therm_trip_mode_mask: mask bits of tripping mode in tmu_ctrl register.
  * @therm_trip_en_shift: shift bits of tripping enable in tmu_ctrl register.
- * @tmu_status: register drescribing the TMU status.
  * @tmu_cur_temp: register containing the current temperature of the TMU.
  * @threshold_temp: register containing the base threshold level.
  * @threshold_th0: Register containing first set of rising levels.
@@ -115,8 +114,6 @@ struct exynos_tmu_registers {
 	u32	therm_trip_mode_mask;
 	u32	therm_trip_en_shift;
 
-	u32	tmu_status;
-
 	u32	tmu_cur_temp;
 
 	u32	threshold_temp;
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index a6088ff..49c8142 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -27,7 +27,6 @@
 #if defined(CONFIG_CPU_EXYNOS4210)
 static const struct exynos_tmu_registers exynos4210_tmu_registers = {
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
-	.tmu_status = EXYNOS_TMU_REG_STATUS,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.threshold_temp = EXYNOS4210_TMU_REG_THRESHOLD_TEMP,
 	.threshold_th0 = EXYNOS4210_TMU_REG_TRIG_LEVEL0,
@@ -92,7 +91,6 @@ static const struct exynos_tmu_registers exynos3250_tmu_registers = {
 	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
 	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
 	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
-	.tmu_status = EXYNOS_TMU_REG_STATUS,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.threshold_th0 = EXYNOS_THD_TEMP_RISE,
 	.threshold_th1 = EXYNOS_THD_TEMP_FALL,
@@ -173,7 +171,6 @@ static const struct exynos_tmu_registers exynos4412_tmu_registers = {
 	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
 	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
 	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
-	.tmu_status = EXYNOS_TMU_REG_STATUS,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.threshold_th0 = EXYNOS_THD_TEMP_RISE,
 	.threshold_th1 = EXYNOS_THD_TEMP_FALL,
@@ -263,7 +260,6 @@ static const struct exynos_tmu_registers exynos5260_tmu_registers = {
 	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
 	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
 	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
-	.tmu_status = EXYNOS_TMU_REG_STATUS,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.threshold_th0 = EXYNOS_THD_TEMP_RISE,
 	.threshold_th1 = EXYNOS_THD_TEMP_FALL,
@@ -341,7 +337,6 @@ static const struct exynos_tmu_registers exynos5420_tmu_registers = {
 	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
 	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
 	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
-	.tmu_status = EXYNOS_TMU_REG_STATUS,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.threshold_th0 = EXYNOS_THD_TEMP_RISE,
 	.threshold_th1 = EXYNOS_THD_TEMP_FALL,
@@ -427,7 +422,6 @@ static const struct exynos_tmu_registers exynos5440_tmu_registers = {
 	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
 	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
 	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
-	.tmu_status = EXYNOS5440_TMU_S0_7_STATUS,
 	.tmu_cur_temp = EXYNOS5440_TMU_S0_7_TEMP,
 	.threshold_th0 = EXYNOS5440_TMU_S0_7_TH0,
 	.threshold_th1 = EXYNOS5440_TMU_S0_7_TH1,
diff --git a/drivers/thermal/samsung/exynos_tmu_data.h b/drivers/thermal/samsung/exynos_tmu_data.h
index 63de598..e02ef99 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.h
+++ b/drivers/thermal/samsung/exynos_tmu_data.h
@@ -88,7 +88,6 @@
 #define EXYNOS5440_TMU_S0_7_TRIM		0x000
 #define EXYNOS5440_TMU_S0_7_CTRL		0x020
 #define EXYNOS5440_TMU_S0_7_DEBUG		0x040
-#define EXYNOS5440_TMU_S0_7_STATUS		0x060
 #define EXYNOS5440_TMU_S0_7_TEMP		0x0f0
 #define EXYNOS5440_TMU_S0_7_TH0			0x110
 #define EXYNOS5440_TMU_S0_7_TH1			0x130
-- 
1.8.2.3
