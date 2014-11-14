From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH 4/4] thermal: exynos: Add TMU support for Exynos7 SoC
Date: Fri, 14 Nov 2014 16:48:02 +0530
Message-ID: <1415963882-3460-5-git-send-email-a.kesavan@samsung.com>
References: <1415963882-3460-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:12059 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964995AbaKNLUn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 06:20:43 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NF100BJT0UIYU30@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 14 Nov 2014 20:20:42 +0900 (KST)
In-reply-to: <1415963882-3460-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, amit.daniel@samsung.com, kesavan.abhilash@gmail.com

Add registers, bit fields and compatible strings for Exynos7 TMU
(Thermal Management Unit). Following are a few of the differences
in the Exynos7 TMU from earlier SoCs:
	- 8 trigger levels
	- Different bit offsets and more registers for the rising
	and falling thresholds.
	- New power down detection bit in the TMU_CONTROL register
	which does not update the CURRENT_TEMP0 when tmu power down
	is detected.
	- Change in bit offset for the NEXT_DATA field of EMUL_CON
	register. EMUL_CON register address has also changed.
	- INTSTAT and INTCLEAR registers present in earlier SoCs
	have been combined into one INTPEND register. The register
	address for INTCLEAR and INTPEND is also different.
	- Since there are 8 rising/falling interrupts as against
	at most 4 in earlier SoCs the INTEN bit offsets are different.
	- Multiple probe support which is handled by a TMU_CONTROL1
	register (No support for this in the current patch).

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 .../devicetree/bindings/thermal/exynos-thermal.txt |    1 +
 drivers/thermal/samsung/exynos_tmu.c               |   60 ++++++++++-
 drivers/thermal/samsung/exynos_tmu.h               |   11 +-
 drivers/thermal/samsung/exynos_tmu_data.c          |  111 ++++++++++++++++++++
 drivers/thermal/samsung/exynos_tmu_data.h          |   27 +++++
 5 files changed, 204 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index 2393eac..7c1c6f1 100644
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
@@ -12,6 +12,7 @@
 	       "samsung,exynos5420-tmu-ext-triminfo" for TMU channels 2, 3 and 4
 			Exynos5420 (Must pass triminfo base and triminfo clock)
 	       "samsung,exynos5440-tmu"
+	       "samsung,exynos7-tmu"
 - interrupt-parent : The phandle for the interrupt controller
 - reg : Address range of the thermal registers. For soc's which has multiple
 	instances of TMU and some registers are shared across all TMU's like
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 9695638..1f658d2 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -147,6 +147,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	const struct exynos_tmu_registers *reg = pdata->registers;
 	unsigned int status, trim_info = 0, con, ctrl;
 	unsigned int rising_threshold = 0, falling_threshold = 0;
+	unsigned int reg_off, bit_off;
 	int ret = 0, threshold_code, i;
 
 	mutex_lock(&data->lock);
@@ -214,9 +215,10 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 			(pdata->efuse_value >> EXYNOS_TRIMINFO_85_SHIFT) &
 			reg->triminfo_mask;
 
-	rising_threshold = readl(data->base + reg->threshold_th0);
 
 	if (data->soc == SOC_ARCH_EXYNOS4210) {
+		rising_threshold = readl(data->base + reg->threshold_th0);
+
 		/* Write temperature code for threshold */
 		threshold_code = temp_to_code(data, pdata->threshold);
 		writeb(threshold_code,
@@ -226,7 +228,37 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 			reg->threshold_th0 + i * sizeof(reg->threshold_th0));
 
 		exynos_tmu_clear_irqs(data);
+	} else if (data->soc == SOC_ARCH_EXYNOS7) {
+		/* Write temperature code for rising and falling thresholds */
+		for (i = pdata->non_hw_trigger_levels; i >= 0; i--) {
+			reg_off = ((pdata->non_hw_trigger_levels - i) / 2) * 4;
+			bit_off = ((pdata->non_hw_trigger_levels - i) % 2);
+
+			threshold_code = temp_to_code(data,
+				pdata->trigger_levels[i]);
+			rising_threshold = readl(data->base +
+				reg->threshold_th0 + reg_off);
+			rising_threshold &= ~(0x1ff << (16 * bit_off));
+			rising_threshold |= threshold_code << (16 * bit_off);
+			writel(rising_threshold,
+				data->base + reg->threshold_th0 + reg_off);
+
+			threshold_code = temp_to_code(data,
+				pdata->trigger_levels[i] -
+				pdata->threshold_falling);
+			falling_threshold |= threshold_code << (16 * bit_off);
+			writel(falling_threshold,
+				data->base + reg->threshold_th1 + reg_off);
+		}
+
+		exynos_tmu_clear_irqs(data);
+
+		con = readl(data->base + reg->tmu_ctrl);
+		con |= (1 << reg->therm_trip_en_shift);
+		writel(con, data->base + reg->tmu_ctrl);
 	} else {
+		rising_threshold = readl(data->base + reg->threshold_th0);
+
 		/* Write temperature code for rising and falling threshold */
 		for (i = 0; i < pdata->non_hw_trigger_levels; i++) {
 			threshold_code = temp_to_code(data,
@@ -311,9 +343,16 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 		con |= (pdata->noise_cancel_mode << reg->therm_trip_mode_shift);
 	}
 
+	if (data->soc == SOC_ARCH_EXYNOS7)
+		con |= 1 << EXYNOS7_PD_DET_EN_SHIFT;
+
 	if (on) {
 		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
 		interrupt_en =
+			pdata->trigger_enable[7] << reg->inten_rise7_shift |
+			pdata->trigger_enable[6] << reg->inten_rise6_shift |
+			pdata->trigger_enable[5] << reg->inten_rise5_shift |
+			pdata->trigger_enable[4] << reg->inten_rise4_shift |
 			pdata->trigger_enable[3] << reg->inten_rise3_shift |
 			pdata->trigger_enable[2] << reg->inten_rise2_shift |
 			pdata->trigger_enable[1] << reg->inten_rise1_shift |
@@ -387,7 +426,11 @@ static int exynos_tmu_set_emulation(void *drv_data, unsigned long temp)
 			val &= ~(EXYNOS_EMUL_TIME_MASK << reg->emul_time_shift);
 			val |= (EXYNOS_EMUL_TIME << reg->emul_time_shift);
 		}
-		val &= ~(EXYNOS_EMUL_DATA_MASK << reg->emul_temp_shift);
+		if (data->soc == SOC_ARCH_EXYNOS7)
+			val &= ~(EXYNOS7_EMUL_DATA_MASK <<
+					reg->emul_temp_shift);
+		else
+			val &= ~(EXYNOS_EMUL_DATA_MASK << reg->emul_temp_shift);
 		val |= (temp_to_code(data, temp) << reg->emul_temp_shift) |
 			EXYNOS_EMUL_ENABLE;
 	} else {
@@ -482,6 +525,10 @@ static const struct of_device_id exynos_tmu_match[] = {
 		.compatible = "samsung,exynos5440-tmu",
 		.data = (void *)EXYNOS5440_TMU_DRV_DATA,
 	},
+	{
+		.compatible = "samsung,exynos7-tmu",
+		.data = (void *)EXYNOS7_TMU_DRV_DATA,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, exynos_tmu_match);
@@ -644,7 +691,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	    pdata->type == SOC_ARCH_EXYNOS5250 ||
 	    pdata->type == SOC_ARCH_EXYNOS5260 ||
 	    pdata->type == SOC_ARCH_EXYNOS5420_TRIMINFO ||
-	    pdata->type == SOC_ARCH_EXYNOS5440)
+	    pdata->type == SOC_ARCH_EXYNOS5440 ||
+	    pdata->type == SOC_ARCH_EXYNOS7)
 		data->soc = pdata->type;
 	else {
 		ret = -EINVAL;
@@ -673,8 +721,10 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		(int (*)(void *, unsigned long))exynos_tmu_set_emulation;
 	sensor_conf->driver_data = data;
 	sensor_conf->trip_data.trip_count = pdata->trigger_enable[0] +
-			pdata->trigger_enable[1] + pdata->trigger_enable[2]+
-			pdata->trigger_enable[3];
+			pdata->trigger_enable[1] + pdata->trigger_enable[2] +
+			pdata->trigger_enable[3] + pdata->trigger_enable[4] +
+			pdata->trigger_enable[5] + pdata->trigger_enable[6] +
+			pdata->trigger_enable[7];
 
 	for (i = 0; i < sensor_conf->trip_data.trip_count; i++) {
 		sensor_conf->trip_data.trip_val[i] =
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 70e0d961..a7e8758 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -42,6 +42,7 @@ enum soc_type {
 	SOC_ARCH_EXYNOS5260,
 	SOC_ARCH_EXYNOS5420_TRIMINFO,
 	SOC_ARCH_EXYNOS5440,
+	SOC_ARCH_EXYNOS7,
 };
 
 /**
@@ -98,6 +99,10 @@ enum soc_type {
  * @inten_rise1_shift: shift bits of rising 1 interrupt bits.
  * @inten_rise2_shift: shift bits of rising 2 interrupt bits.
  * @inten_rise3_shift: shift bits of rising 3 interrupt bits.
+ * @inten_rise4_shift: shift bits of rising 4 interrupt bits.
+ * @inten_rise5_shift: shift bits of rising 5 interrupt bits.
+ * @inten_rise6_shift: shift bits of rising 6 interrupt bits.
+ * @inten_rise7_shift: shift bits of rising 7 interrupt bits.
  * @inten_fall0_shift: shift bits of falling 0 interrupt bits.
  * @tmu_intstat: Register containing the interrupt status values.
  * @tmu_intclear: Register for clearing the raised interrupt status.
@@ -136,6 +141,10 @@ struct exynos_tmu_registers {
 	u32	inten_rise1_shift;
 	u32	inten_rise2_shift;
 	u32	inten_rise3_shift;
+	u32	inten_rise4_shift;
+	u32	inten_rise5_shift;
+	u32	inten_rise6_shift;
+	u32	inten_rise7_shift;
 	u32	inten_fall0_shift;
 
 	u32	tmu_intstat;
@@ -230,7 +239,7 @@ struct exynos_tmu_platform_data {
 
 	enum calibration_type cal_type;
 	enum soc_type type;
-	struct freq_clip_table freq_tab[4];
+	struct freq_clip_table freq_tab[8];
 	unsigned int freq_tab_count;
 	const struct exynos_tmu_registers *registers;
 	unsigned int features;
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index c4f12d0..523bf4d 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -491,3 +491,114 @@ struct exynos_tmu_init_data const exynos5440_default_tmu_data = {
 	.tmu_count = 3,
 };
 #endif
+
+#if defined(CONFIG_ARCH_EXYNOS7)
+static const struct exynos_tmu_registers exynos7_tmu_registers = {
+	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
+	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
+	.triminfo_mask = EXYNOS_TMU_TEMP_MASK,
+	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
+	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
+	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
+	.tmu_status = EXYNOS_TMU_REG_STATUS,
+	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
+	.threshold_th0 = EXYNOS7_THD_TEMP_RISE7_6,
+	.threshold_th1 = EXYNOS7_THD_TEMP_FALL7_6,
+	.tmu_inten = EXYNOS7_TMU_REG_INTEN,
+	.inten_rise0_shift = EXYNOS7_TMU_INTEN_RISE0_SHIFT,
+	.inten_rise1_shift = EXYNOS7_TMU_INTEN_RISE1_SHIFT,
+	.inten_rise2_shift = EXYNOS7_TMU_INTEN_RISE2_SHIFT,
+	.inten_rise3_shift = EXYNOS7_TMU_INTEN_RISE3_SHIFT,
+	.inten_rise4_shift = EXYNOS7_TMU_INTEN_RISE4_SHIFT,
+	.inten_rise5_shift = EXYNOS7_TMU_INTEN_RISE5_SHIFT,
+	.inten_rise6_shift = EXYNOS7_TMU_INTEN_RISE6_SHIFT,
+	.inten_rise7_shift = EXYNOS7_TMU_INTEN_RISE7_SHIFT,
+	.inten_fall0_shift = EXYNOS_TMU_INTEN_FALL0_SHIFT,
+	.tmu_intstat = EXYNOS7_TMU_REG_INTPEND,
+	.tmu_intclear = EXYNOS7_TMU_REG_INTPEND,
+	.emul_con = EXYNOS7_TMU_REG_EMUL_CON,
+	.emul_temp_shift = EXYNOS7_EMUL_DATA_SHIFT,
+	.emul_time_shift = EXYNOS_EMUL_TIME_SHIFT,
+};
+
+#define __EXYNOS7_TMU_DATA	\
+	.threshold_falling = 10, \
+	.trigger_levels[0] = 65, \
+	.trigger_levels[1] = 72, \
+	.trigger_levels[2] = 80, \
+	.trigger_levels[3] = 88, \
+	.trigger_levels[4] = 95, \
+	.trigger_levels[5] = 103, \
+	.trigger_levels[6] = 110, \
+	.trigger_levels[7] = 115, \
+	.trigger_enable[0] = true, \
+	.trigger_enable[1] = true, \
+	.trigger_enable[2] = true, \
+	.trigger_enable[3] = true, \
+	.trigger_enable[4] = true, \
+	.trigger_enable[5] = true, \
+	.trigger_enable[6] = true, \
+	.trigger_enable[7] = false, \
+	.trigger_type[0] = THROTTLE_ACTIVE, \
+	.trigger_type[1] = THROTTLE_ACTIVE, \
+	.trigger_type[2] = THROTTLE_ACTIVE, \
+	.trigger_type[3] = THROTTLE_ACTIVE, \
+	.trigger_type[4] = THROTTLE_ACTIVE, \
+	.trigger_type[5] = THROTTLE_ACTIVE, \
+	.trigger_type[6] = SW_TRIP, \
+	.trigger_type[7] = HW_TRIP, \
+	.max_trigger_level = 8, \
+	.non_hw_trigger_levels = 7, \
+	.gain = 8, \
+	.reference_voltage = 16, \
+	.noise_cancel_mode = 4, \
+	.cal_type = TYPE_ONE_POINT_TRIMMING, \
+	.efuse_value = 55, \
+	.min_efuse_value = 15, \
+	.max_efuse_value = 100, \
+	.first_point_trim = 25, \
+	.second_point_trim = 85, \
+	.default_temp_offset = 50, \
+	.freq_tab[0] = { \
+		.freq_clip_max = 1400 * 1000, \
+		.temp_level = 70, \
+	}, \
+	.freq_tab[1] = { \
+		.freq_clip_max = 1200 * 1000, \
+		.temp_level = 80, \
+	}, \
+	.freq_tab[2] = { \
+		.freq_clip_max = 1000 * 1000, \
+		.temp_level = 85, \
+	}, \
+	.freq_tab[3] = { \
+		.freq_clip_max = 800 * 1000, \
+		.temp_level = 90, \
+	}, \
+	.freq_tab[4] = { \
+		.freq_clip_max = 600 * 1000, \
+		.temp_level = 95, \
+	}, \
+	.freq_tab[5] = { \
+		.freq_clip_max = 200 * 1000, \
+		.temp_level = 100, \
+	}, \
+	.freq_tab_count = 6, \
+	.registers = &exynos7_tmu_registers, \
+
+#define EXYNOS7_TMU_DATA \
+	__EXYNOS7_TMU_DATA \
+	.type = SOC_ARCH_EXYNOS7, \
+	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_FALLING_TRIP | \
+			TMU_SUPPORT_READY_STATUS | TMU_SUPPORT_EMUL_TIME)
+
+struct exynos_tmu_init_data const exynos7_default_tmu_data = {
+	.tmu_data = {
+		{ EXYNOS7_TMU_DATA },
+		{ EXYNOS7_TMU_DATA },
+		{ EXYNOS7_TMU_DATA },
+		{ EXYNOS7_TMU_DATA },
+	},
+	.tmu_count = 4,
+};
+#endif
diff --git a/drivers/thermal/samsung/exynos_tmu_data.h b/drivers/thermal/samsung/exynos_tmu_data.h
index 63de598..5dc9b2f 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.h
+++ b/drivers/thermal/samsung/exynos_tmu_data.h
@@ -107,6 +107,26 @@
 #define EXYNOS5440_TMU_TH_RISE4_SHIFT		24
 #define EXYNOS5440_EFUSE_SWAP_OFFSET		8
 
+/* Exynos7 specific registers */
+#define EXYNOS7_THD_TEMP_RISE7_6		0x50
+#define EXYNOS7_THD_TEMP_FALL7_6		0x60
+#define EXYNOS7_TMU_REG_INTEN			0x110
+#define EXYNOS7_TMU_REG_INTPEND			0x118
+#define EXYNOS7_TMU_REG_EMUL_CON		0x160
+
+#define EXYNOS7_TMU_TEMP_MASK			0x1FF
+#define EXYNOS7_PD_DET_EN_SHIFT			23
+#define EXYNOS7_TMU_INTEN_RISE0_SHIFT		0
+#define EXYNOS7_TMU_INTEN_RISE1_SHIFT		1
+#define EXYNOS7_TMU_INTEN_RISE2_SHIFT		2
+#define EXYNOS7_TMU_INTEN_RISE3_SHIFT		3
+#define EXYNOS7_TMU_INTEN_RISE4_SHIFT		4
+#define EXYNOS7_TMU_INTEN_RISE5_SHIFT		5
+#define EXYNOS7_TMU_INTEN_RISE6_SHIFT		6
+#define EXYNOS7_TMU_INTEN_RISE7_SHIFT		7
+#define EXYNOS7_EMUL_DATA_SHIFT			7
+#define EXYNOS7_EMUL_DATA_MASK			0x1FF
+
 #if defined(CONFIG_SOC_EXYNOS3250)
 extern struct exynos_tmu_init_data const exynos3250_default_tmu_data;
 #define EXYNOS3250_TMU_DRV_DATA (&exynos3250_default_tmu_data)
@@ -156,4 +176,11 @@ extern struct exynos_tmu_init_data const exynos5440_default_tmu_data;
 #define EXYNOS5440_TMU_DRV_DATA (NULL)
 #endif
 
+#if defined(CONFIG_ARCH_EXYNOS7)
+extern struct exynos_tmu_init_data const exynos7_default_tmu_data;
+#define EXYNOS7_TMU_DRV_DATA (&exynos7_default_tmu_data)
+#else
+#define EXYNOS7_TMU_DRV_DATA (NULL)
+#endif
+
 #endif /*_EXYNOS_TMU_DATA_H*/
-- 
1.7.9.5

