From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 07/33] thermal: exynos: remove needless therm_trip_en_shift
 abstraction
Date: Thu, 18 Sep 2014 17:27:24 +0200
Message-ID: <1411054070-25757-8-git-send-email-b.zolnierkie@samsung.com>
References: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

reg->therm_trip_en_shift is used only in exynos_tmu_initialize()
and not accessed on Exynos4210 (also reg->therm_trip_en_shift is
not even assigned in exynos4210_tmu_registers but it is assigned
to identical value for all other SoC types) so the register
abstraction is not needed and can be removed.

There should be no functional changes caused by this patch.

Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c      | 2 +-
 drivers/thermal/samsung/exynos_tmu.h      | 2 --
 drivers/thermal/samsung/exynos_tmu_data.c | 5 -----
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 7c9793a..350a1f5 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -251,7 +251,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 					data->base + reg->threshold_th2);
 			}
 			con = readl(data->base + reg->tmu_ctrl);
-			con |= (1 << reg->therm_trip_en_shift);
+			con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
 			writel(con, data->base + reg->tmu_ctrl);
 		}
 	}
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 6341d74..8f5ffcb 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -77,7 +77,6 @@ enum soc_type {
  * bitfields. The register validity, offsets and bitfield values may vary
  * slightly across different exynos SOC's.
  * @tmu_ctrl: TMU main controller register.
- * @therm_trip_en_shift: shift bits of tripping enable in tmu_ctrl register.
  * @tmu_cur_temp: register containing the current temperature of the TMU.
  * @threshold_th0: Register containing first set of rising levels.
  * @threshold_th1: Register containing second set of rising levels.
@@ -104,7 +103,6 @@ enum soc_type {
  */
 struct exynos_tmu_registers {
 	u32	tmu_ctrl;
-	u32	therm_trip_en_shift;
 
 	u32	tmu_cur_temp;
 
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 22a0ade..a37f490 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -84,7 +84,6 @@ struct exynos_tmu_init_data const exynos4210_default_tmu_data = {
 #if defined(CONFIG_SOC_EXYNOS3250)
 static const struct exynos_tmu_registers exynos3250_tmu_registers = {
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
-	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.threshold_th0 = EXYNOS_THD_TEMP_RISE,
 	.threshold_th1 = EXYNOS_THD_TEMP_FALL,
@@ -161,7 +160,6 @@ struct exynos_tmu_init_data const exynos3250_default_tmu_data = {
 #if defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250)
 static const struct exynos_tmu_registers exynos4412_tmu_registers = {
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
-	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.threshold_th0 = EXYNOS_THD_TEMP_RISE,
 	.threshold_th1 = EXYNOS_THD_TEMP_FALL,
@@ -251,7 +249,6 @@ struct exynos_tmu_init_data const exynos5250_default_tmu_data = {
 #if defined(CONFIG_SOC_EXYNOS5260)
 static const struct exynos_tmu_registers exynos5260_tmu_registers = {
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
-	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.threshold_th0 = EXYNOS_THD_TEMP_RISE,
 	.threshold_th1 = EXYNOS_THD_TEMP_FALL,
@@ -330,7 +327,6 @@ struct exynos_tmu_init_data const exynos5260_default_tmu_data = {
 #if defined(CONFIG_SOC_EXYNOS5420)
 static const struct exynos_tmu_registers exynos5420_tmu_registers = {
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
-	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.threshold_th0 = EXYNOS_THD_TEMP_RISE,
 	.threshold_th1 = EXYNOS_THD_TEMP_FALL,
@@ -417,7 +413,6 @@ struct exynos_tmu_init_data const exynos5420_default_tmu_data = {
 #if defined(CONFIG_SOC_EXYNOS5440)
 static const struct exynos_tmu_registers exynos5440_tmu_registers = {
 	.tmu_ctrl = EXYNOS5440_TMU_S0_7_CTRL,
-	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
 	.tmu_cur_temp = EXYNOS5440_TMU_S0_7_TEMP,
 	.threshold_th0 = EXYNOS5440_TMU_S0_7_TH0,
 	.threshold_th1 = EXYNOS5440_TMU_S0_7_TH1,
-- 
1.8.2.3
