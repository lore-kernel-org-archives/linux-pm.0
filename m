From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 06/33] thermal: exynos: remove needless
 therm_trip_[mode,mask]_shift abstractions
Date: Thu, 13 Nov 2014 16:01:01 +0100
Message-ID: <1415890888-8881-7-git-send-email-b.zolnierkie@samsung.com>
References: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

reg->therm_trip_mode_shift and reg->therm_trip_mode_mask are
used only in exynos_tmu_control() and accessed only if
pdata->noise_cancel_mode is non-zero.  pdata->noise_cancel
field is not defined on Exynos4210 (also therm_trip_mode_shift
and therm_trip_mode_mask entries are not even assigned in
exynos4210_tmu_registers but they are assigned to identical
values for all other SoC types) so the abstractions are not
needed and can be removed.

There should be no functional changes caused by this patch.

Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c      |  5 ++---
 drivers/thermal/samsung/exynos_tmu.h      |  4 ----
 drivers/thermal/samsung/exynos_tmu_data.c | 10 ----------
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index c8d6cdde..fb38411 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -304,9 +304,8 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 	con |= (pdata->gain << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
 
 	if (pdata->noise_cancel_mode) {
-		con &= ~(reg->therm_trip_mode_mask <<
-					reg->therm_trip_mode_shift);
-		con |= (pdata->noise_cancel_mode << reg->therm_trip_mode_shift);
+		con &= ~(EXYNOS_TMU_TRIP_MODE_MASK << EXYNOS_TMU_TRIP_MODE_SHIFT);
+		con |= (pdata->noise_cancel_mode << EXYNOS_TMU_TRIP_MODE_SHIFT);
 	}
 
 	if (on) {
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 0fb10d1..88c16d7 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -77,8 +77,6 @@ enum soc_type {
  * bitfields. The register validity, offsets and bitfield values may vary
  * slightly across different exynos SOC's.
  * @tmu_ctrl: TMU main controller register.
- * @therm_trip_mode_shift: shift bits of tripping mode in tmu_ctrl register.
- * @therm_trip_mode_mask: mask bits of tripping mode in tmu_ctrl register.
  * @therm_trip_en_shift: shift bits of tripping enable in tmu_ctrl register.
  * @tmu_cur_temp: register containing the current temperature of the TMU.
  * @threshold_th0: Register containing first set of rising levels.
@@ -102,8 +100,6 @@ enum soc_type {
  */
 struct exynos_tmu_registers {
 	u32	tmu_ctrl;
-	u32	therm_trip_mode_shift;
-	u32	therm_trip_mode_mask;
 	u32	therm_trip_en_shift;
 
 	u32	tmu_cur_temp;
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 4ca1283..4a44eb7 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -83,8 +83,6 @@ struct exynos_tmu_init_data const exynos4210_default_tmu_data = {
 #if defined(CONFIG_SOC_EXYNOS3250)
 static const struct exynos_tmu_registers exynos3250_tmu_registers = {
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
-	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
-	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
 	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.threshold_th0 = EXYNOS_THD_TEMP_RISE,
@@ -158,8 +156,6 @@ struct exynos_tmu_init_data const exynos3250_default_tmu_data = {
 #if defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250)
 static const struct exynos_tmu_registers exynos4412_tmu_registers = {
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
-	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
-	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
 	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.threshold_th0 = EXYNOS_THD_TEMP_RISE,
@@ -246,8 +242,6 @@ struct exynos_tmu_init_data const exynos5250_default_tmu_data = {
 #if defined(CONFIG_SOC_EXYNOS5260)
 static const struct exynos_tmu_registers exynos5260_tmu_registers = {
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
-	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
-	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
 	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.threshold_th0 = EXYNOS_THD_TEMP_RISE,
@@ -323,8 +317,6 @@ struct exynos_tmu_init_data const exynos5260_default_tmu_data = {
 #if defined(CONFIG_SOC_EXYNOS5420)
 static const struct exynos_tmu_registers exynos5420_tmu_registers = {
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
-	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
-	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
 	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.threshold_th0 = EXYNOS_THD_TEMP_RISE,
@@ -408,8 +400,6 @@ struct exynos_tmu_init_data const exynos5420_default_tmu_data = {
 #if defined(CONFIG_SOC_EXYNOS5440)
 static const struct exynos_tmu_registers exynos5440_tmu_registers = {
 	.tmu_ctrl = EXYNOS5440_TMU_S0_7_CTRL,
-	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
-	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
 	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
 	.tmu_cur_temp = EXYNOS5440_TMU_S0_7_TEMP,
 	.threshold_th0 = EXYNOS5440_TMU_S0_7_TH0,
-- 
1.8.2.3
