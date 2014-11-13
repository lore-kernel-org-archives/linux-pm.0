From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 01/33] thermal: exynos: remove needless triminfo_data
 abstraction
Date: Thu, 13 Nov 2014 16:00:56 +0100
Message-ID: <1415890888-8881-2-git-send-email-b.zolnierkie@samsung.com>
References: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

reg->triminfo_data is used only in exynos_tmu_initialize() and
the code has already different paths for Exynos5440 and other
SoC types (on which TRIMINFO_DATA register offset is identical)
so the register abstraction is not needed and can be removed.

There should be no functional changes caused by this patch.

Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c      | 10 +++++-----
 drivers/thermal/samsung/exynos_tmu.h      |  3 ---
 drivers/thermal/samsung/exynos_tmu_data.c |  6 ------
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 49c0924..bb05355 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -182,22 +182,22 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		switch (data->id) {
 		case 0:
 			trim_info = readl(data->base +
-			EXYNOS5440_EFUSE_SWAP_OFFSET + reg->triminfo_data);
+			EXYNOS5440_EFUSE_SWAP_OFFSET + EXYNOS5440_TMU_S0_7_TRIM);
 			break;
 		case 1:
-			trim_info = readl(data->base + reg->triminfo_data);
+			trim_info = readl(data->base + EXYNOS5440_TMU_S0_7_TRIM);
 			break;
 		case 2:
 			trim_info = readl(data->base -
-			EXYNOS5440_EFUSE_SWAP_OFFSET + reg->triminfo_data);
+			EXYNOS5440_EFUSE_SWAP_OFFSET + EXYNOS5440_TMU_S0_7_TRIM);
 		}
 	} else {
 		/* On exynos5420 the triminfo register is in the shared space */
 		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
 			trim_info = readl(data->base_second +
-							reg->triminfo_data);
+						EXYNOS_TMU_REG_TRIMINFO);
 		else
-			trim_info = readl(data->base + reg->triminfo_data);
+			trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 	}
 	data->temp_error1 = trim_info & EXYNOS_TMU_TEMP_MASK;
 	data->temp_error2 = ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index c58c766..91e2317 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -76,7 +76,6 @@ enum soc_type {
  * struct exynos_tmu_register - register descriptors to access registers and
  * bitfields. The register validity, offsets and bitfield values may vary
  * slightly across different exynos SOC's.
- * @triminfo_data: register containing 2 pont trimming data
  * @triminfo_ctrl: trim info controller register.
  * @triminfo_ctrl_count: the number of trim info controller register.
  * @tmu_ctrl: TMU main controller register.
@@ -107,8 +106,6 @@ enum soc_type {
  * @tmu_pmin: register to get/set the Pmin value.
  */
 struct exynos_tmu_registers {
-	u32	triminfo_data;
-
 	u32	triminfo_ctrl[MAX_TRIMINFO_CTRL_REG];
 	u32	triminfo_ctrl_count;
 
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 1724f6c..a6088ff 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -26,7 +26,6 @@
 
 #if defined(CONFIG_CPU_EXYNOS4210)
 static const struct exynos_tmu_registers exynos4210_tmu_registers = {
-	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
 	.tmu_status = EXYNOS_TMU_REG_STATUS,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
@@ -85,7 +84,6 @@ struct exynos_tmu_init_data const exynos4210_default_tmu_data = {
 
 #if defined(CONFIG_SOC_EXYNOS3250)
 static const struct exynos_tmu_registers exynos3250_tmu_registers = {
-	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
 	.triminfo_ctrl[0] = EXYNOS_TMU_TRIMINFO_CON1,
 	.triminfo_ctrl[1] = EXYNOS_TMU_TRIMINFO_CON2,
 	.triminfo_ctrl_count = 2,
@@ -168,7 +166,6 @@ struct exynos_tmu_init_data const exynos3250_default_tmu_data = {
 
 #if defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250)
 static const struct exynos_tmu_registers exynos4412_tmu_registers = {
-	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
 	.triminfo_ctrl[0] = EXYNOS_TMU_TRIMINFO_CON2,
 	.triminfo_ctrl_count = 1,
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
@@ -262,7 +259,6 @@ struct exynos_tmu_init_data const exynos5250_default_tmu_data = {
 
 #if defined(CONFIG_SOC_EXYNOS5260)
 static const struct exynos_tmu_registers exynos5260_tmu_registers = {
-	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
 	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
 	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
@@ -341,7 +337,6 @@ struct exynos_tmu_init_data const exynos5260_default_tmu_data = {
 
 #if defined(CONFIG_SOC_EXYNOS5420)
 static const struct exynos_tmu_registers exynos5420_tmu_registers = {
-	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
 	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
 	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
@@ -428,7 +423,6 @@ struct exynos_tmu_init_data const exynos5420_default_tmu_data = {
 
 #if defined(CONFIG_SOC_EXYNOS5440)
 static const struct exynos_tmu_registers exynos5440_tmu_registers = {
-	.triminfo_data = EXYNOS5440_TMU_S0_7_TRIM,
 	.tmu_ctrl = EXYNOS5440_TMU_S0_7_CTRL,
 	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
 	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
-- 
1.8.2.3
