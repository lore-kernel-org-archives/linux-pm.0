From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 2/9] thermal: exynos: remove dead code for HW_MODE
 calibration
Date: Tue, 17 Jun 2014 19:27:18 +0200
Message-ID: <1403026045-16024-3-git-send-email-b.zolnierkie@samsung.com>
References: <1403026045-16024-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1403026045-16024-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

The commit 1928457 ("thermal: exynos: Add hardware mode thermal
calibration support") has added HW_MODE feature but it has never
been enabled.  As such it has been a dead code for almost a year
now and should be removed from the kernel.

We don't keep the unused/untested features in the kernel just
in case that some future hardware might need it.  Such code has
a real maintainance cost (all other code changes have to take
the dead code into account) and usually makes future changes
more difficult, not easier (i.e. recent additions of Exynos5420
SoC and Exynos5260 SoC thermal support has not made use of any
of the driver's currently unused/untested features, moreover
the recently added code is more complex than needed because of
the existing dead code).  Also all removed dead code is still
accessible in the kernel git repository and can be easily
brought back if/when needed.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c      | 33 +------------------------------
 drivers/thermal/samsung/exynos_tmu.h      | 13 ------------
 drivers/thermal/samsung/exynos_tmu_data.c |  3 ---
 drivers/thermal/samsung/exynos_tmu_data.h |  2 --
 4 files changed, 1 insertion(+), 50 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index d7ca9f4..1050b36 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -77,9 +77,6 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 	struct exynos_tmu_platform_data *pdata = data->pdata;
 	int temp_code;
 
-	if (pdata->cal_mode == HW_MODE)
-		return temp;
-
 	if (data->soc == SOC_ARCH_EXYNOS4210)
 		/* temp should range between 25 and 125 */
 		if (temp < 25 || temp > 125) {
@@ -114,9 +111,6 @@ static int code_to_temp(struct exynos_tmu_data *data, u8 temp_code)
 	struct exynos_tmu_platform_data *pdata = data->pdata;
 	int temp;
 
-	if (pdata->cal_mode == HW_MODE)
-		return temp_code;
-
 	if (data->soc == SOC_ARCH_EXYNOS4210)
 		/* temp_code should range between 75 and 175 */
 		if (temp_code < 75 || temp_code > 175) {
@@ -167,9 +161,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	if (TMU_SUPPORTS(pdata, TRIM_RELOAD))
 		__raw_writel(1, data->base + reg->triminfo_ctrl);
 
-	if (pdata->cal_mode == HW_MODE)
-		goto skip_calib_data;
-
 	/* Save trimming info in order to perform calibration */
 	if (data->soc == SOC_ARCH_EXYNOS5440) {
 		/*
@@ -210,7 +201,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 			(pdata->efuse_value >> reg->triminfo_85_shift) &
 			EXYNOS_TMU_TEMP_MASK;
 
-skip_calib_data:
 	if (pdata->max_trigger_level > MAX_THRESHOLD_LEVS) {
 		dev_err(&pdev->dev, "Invalid max trigger level\n");
 		ret = -EINVAL;
@@ -325,7 +315,7 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct exynos_tmu_platform_data *pdata = data->pdata;
 	const struct exynos_tmu_registers *reg = pdata->registers;
-	unsigned int con, interrupt_en, cal_val;
+	unsigned int con, interrupt_en;
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
@@ -351,27 +341,6 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 		con |= (pdata->noise_cancel_mode << reg->therm_trip_mode_shift);
 	}
 
-	if (pdata->cal_mode == HW_MODE) {
-		con &= ~(reg->calib_mode_mask << reg->calib_mode_shift);
-		cal_val = 0;
-		switch (pdata->cal_type) {
-		case TYPE_TWO_POINT_TRIMMING:
-			cal_val = 3;
-			break;
-		case TYPE_ONE_POINT_TRIMMING_85:
-			cal_val = 2;
-			break;
-		case TYPE_ONE_POINT_TRIMMING_25:
-			cal_val = 1;
-			break;
-		case TYPE_NONE:
-			break;
-		default:
-			dev_err(&pdev->dev, "Invalid calibration type, using none\n");
-		}
-		con |= cal_val << reg->calib_mode_shift;
-	}
-
 	if (on) {
 		con |= (1 << reg->core_en_shift);
 		interrupt_en =
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 59799ef..86c5531 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -34,11 +34,6 @@ enum calibration_type {
 	TYPE_NONE,
 };
 
-enum calibration_mode {
-	SW_MODE,
-	HW_MODE,
-};
-
 enum soc_type {
 	SOC_ARCH_EXYNOS4210 = 1,
 	SOC_ARCH_EXYNOS4412,
@@ -94,10 +89,6 @@ enum soc_type {
  * @buf_slope_sel_shift: shift bits of amplifier gain value in tmu_ctrl
 	register.
  * @buf_slope_sel_mask: mask bits of amplifier gain value in tmu_ctrl register.
- * @calib_mode_shift: shift bits of calibration mode value in tmu_ctrl
-	register.
- * @calib_mode_mask: mask bits of calibration mode value in tmu_ctrl
-	register.
  * @core_en_shift: shift bits of TMU core enable bit in tmu_ctrl register.
  * @tmu_status: register drescribing the TMU status.
  * @tmu_cur_temp: register containing the current temperature of the TMU.
@@ -142,8 +133,6 @@ struct exynos_tmu_registers {
 	u32	therm_trip_en_shift;
 	u32	buf_slope_sel_shift;
 	u32	buf_slope_sel_mask;
-	u32	calib_mode_shift;
-	u32	calib_mode_mask;
 	u32	core_en_shift;
 
 	u32	tmu_status;
@@ -225,7 +214,6 @@ struct exynos_tmu_registers {
  * @default_temp_offset: default temperature offset in case of no trimming
  * @test_mux; information if SoC supports test MUX
  * @cal_type: calibration type for temperature
- * @cal_mode: calibration mode for temperature
  * @freq_clip_table: Table representing frequency reduction percentage.
  * @freq_tab_count: Count of the above table as frequency reduction may
  *	applicable to only some of the trigger levels.
@@ -256,7 +244,6 @@ struct exynos_tmu_platform_data {
 	u8 test_mux;
 
 	enum calibration_type cal_type;
-	enum calibration_mode cal_mode;
 	enum soc_type type;
 	struct freq_clip_table freq_tab[4];
 	unsigned int freq_tab_count;
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 41e8168..3349e13 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -394,8 +394,6 @@ static const struct exynos_tmu_registers exynos5440_tmu_registers = {
 	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
 	.buf_slope_sel_shift = EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT,
 	.buf_slope_sel_mask = EXYNOS_TMU_BUF_SLOPE_SEL_MASK,
-	.calib_mode_shift = EXYNOS_TMU_CALIB_MODE_SHIFT,
-	.calib_mode_mask = EXYNOS_TMU_CALIB_MODE_MASK,
 	.core_en_shift = EXYNOS_TMU_CORE_EN_SHIFT,
 	.tmu_status = EXYNOS5440_TMU_S0_7_STATUS,
 	.tmu_cur_temp = EXYNOS5440_TMU_S0_7_TEMP,
@@ -432,7 +430,6 @@ static const struct exynos_tmu_registers exynos5440_tmu_registers = {
 	.reference_voltage = 16, \
 	.noise_cancel_mode = 4, \
 	.cal_type = TYPE_ONE_POINT_TRIMMING, \
-	.cal_mode = 0, \
 	.efuse_value = 0x5b2d, \
 	.min_efuse_value = 16, \
 	.max_efuse_value = 76, \
diff --git a/drivers/thermal/samsung/exynos_tmu_data.h b/drivers/thermal/samsung/exynos_tmu_data.h
index 8018815..dd8d659 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.h
+++ b/drivers/thermal/samsung/exynos_tmu_data.h
@@ -62,8 +62,6 @@
 #define EXYNOS_TMU_TRIP_MODE_SHIFT	13
 #define EXYNOS_TMU_TRIP_MODE_MASK	0x7
 #define EXYNOS_TMU_THERM_TRIP_EN_SHIFT	12
-#define EXYNOS_TMU_CALIB_MODE_SHIFT	4
-#define EXYNOS_TMU_CALIB_MODE_MASK	0x3
 
 #define EXYNOS_TMU_INTEN_RISE0_SHIFT	0
 #define EXYNOS_TMU_INTEN_RISE1_SHIFT	4
-- 
1.8.2.3
