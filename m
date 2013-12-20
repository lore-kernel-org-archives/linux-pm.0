From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Subject: [PATCH] thermal: samsung: Add TMU support for Exynos5260 SoCs
Date: Fri, 20 Dec 2013 17:49:10 +0530
Message-ID: <1387541950-16312-1-git-send-email-ch.naveen@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:30627 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130Ab3LTMS0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 07:18:26 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, cpgs@samsung.com, t.figa@samsung.com

This patch adds the registers, bit fields and compatible strings
required to support for the 5 TMU channels on Exynos5260.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
This patch goes on top of the series (Reviewed and Acked)
https://www.mail-archive.com/devicetree@vger.kernel.org/msg08043.html

 .../devicetree/bindings/thermal/exynos-thermal.txt |    1 +
 drivers/thermal/samsung/exynos_tmu.c               |    5 ++
 drivers/thermal/samsung/exynos_tmu.h               |    2 +
 drivers/thermal/samsung/exynos_tmu_data.c          |   92 ++++++++++++++++++++
 drivers/thermal/samsung/exynos_tmu_data.h          |   19 ++++
 5 files changed, 119 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index 79c4055..c949092 100644
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
@@ -6,6 +6,7 @@
 	       "samsung,exynos4412-tmu"
 	       "samsung,exynos4210-tmu"
 	       "samsung,exynos5250-tmu"
+	       "samsung,exynos5260-tmu"
 	       "samsung,exynos5420-tmu" for TMU channel 0, 1 on Exynos5420
 	       "samsung,exynos5420-tmu-ext-triminfo" for TMU channels 2, 3 and 4
 			Exynos5420 (Must pass triminfo base and triminfo clock)
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 3246ace..557f9f3 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -512,6 +512,10 @@ static const struct of_device_id exynos_tmu_match[] = {
 		.data = (void *)EXYNOS5250_TMU_DRV_DATA,
 	},
 	{
+		.compatible = "samsung,exynos5260-tmu",
+		.data = (void *)EXYNOS5260_TMU_DRV_DATA,
+	},
+	{
 		.compatible = "samsung,exynos5420-tmu",
 		.data = (void *)EXYNOS5420_TMU_DRV_DATA,
 	},
@@ -673,6 +677,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (pdata->type == SOC_ARCH_EXYNOS4210 ||
 	    pdata->type == SOC_ARCH_EXYNOS4412 ||
 	    pdata->type == SOC_ARCH_EXYNOS5250 ||
+	    pdata->type == SOC_ARCH_EXYNOS5260 ||
 	    pdata->type == SOC_ARCH_EXYNOS5420_TRIMINFO ||
 	    pdata->type == SOC_ARCH_EXYNOS5440)
 		data->soc = pdata->type;
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 60cce28..edd08cf 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -43,6 +43,7 @@ enum soc_type {
 	SOC_ARCH_EXYNOS4210 = 1,
 	SOC_ARCH_EXYNOS4412,
 	SOC_ARCH_EXYNOS5250,
+	SOC_ARCH_EXYNOS5260,
 	SOC_ARCH_EXYNOS5420_TRIMINFO,
 	SOC_ARCH_EXYNOS5440,
 };
@@ -150,6 +151,7 @@ struct exynos_tmu_registers {
 	u32	triminfo_85_shift;
 
 	u32	triminfo_ctrl;
+	u32	triminfo_ctrl1;
 	u32	triminfo_reload_shift;
 
 	u32	tmu_ctrl;
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 2670cbe..4bb0b37 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -194,6 +194,98 @@ struct exynos_tmu_init_data const exynos5250_default_tmu_data = {
 };
 #endif
 
+#if defined(CONFIG_SOC_EXYNOS5260)
+static const struct exynos_tmu_registers exynos5260_tmu_registers = {
+	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
+	.triminfo_25_shift = EXYNOS_TRIMINFO_25_SHIFT,
+	.triminfo_85_shift = EXYNOS_TRIMINFO_85_SHIFT,
+	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
+	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL1,
+	.buf_vref_sel_shift = EXYNOS_TMU_REF_VOLTAGE_SHIFT,
+	.buf_vref_sel_mask = EXYNOS_TMU_REF_VOLTAGE_MASK,
+	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
+	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
+	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
+	.buf_slope_sel_shift = EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT,
+	.buf_slope_sel_mask = EXYNOS_TMU_BUF_SLOPE_SEL_MASK,
+	.core_en_shift = EXYNOS_TMU_CORE_EN_SHIFT,
+	.tmu_status = EXYNOS_TMU_REG_STATUS,
+	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
+	.threshold_th0 = EXYNOS_THD_TEMP_RISE,
+	.threshold_th1 = EXYNOS_THD_TEMP_FALL,
+	.tmu_inten = EXYNOS5260_TMU_REG_INTEN,
+	.inten_rise0_shift = EXYNOS_TMU_INTEN_RISE0_SHIFT,
+	.inten_rise1_shift = EXYNOS_TMU_INTEN_RISE1_SHIFT,
+	.inten_rise2_shift = EXYNOS_TMU_INTEN_RISE2_SHIFT,
+	.inten_rise3_shift = EXYNOS_TMU_INTEN_RISE3_SHIFT,
+	.inten_fall0_shift = EXYNOS_TMU_INTEN_FALL0_SHIFT,
+	.tmu_intstat = EXYNOS5260_TMU_REG_INTSTAT,
+	.tmu_intclear = EXYNOS5260_TMU_REG_INTCLEAR,
+	.intclr_fall_shift = EXYNOS5420_TMU_CLEAR_FALL_INT_SHIFT,
+	.intclr_rise_shift = EXYNOS_TMU_RISE_INT_SHIFT,
+	.intclr_rise_mask = EXYNOS5260_TMU_RISE_INT_MASK,
+	.intclr_fall_mask = EXYNOS5260_TMU_FALL_INT_MASK,
+	.emul_con = EXYNOS5260_EMUL_CON,
+	.emul_temp_shift = EXYNOS_EMUL_DATA_SHIFT,
+	.emul_time_shift = EXYNOS_EMUL_TIME_SHIFT,
+	.emul_time_mask = EXYNOS_EMUL_TIME_MASK,
+};
+
+#define __EXYNOS5260_TMU_DATA	\
+	.threshold_falling = 10, \
+	.trigger_levels[0] = 85, \
+	.trigger_levels[1] = 103, \
+	.trigger_levels[2] = 110, \
+	.trigger_levels[3] = 120, \
+	.trigger_enable[0] = true, \
+	.trigger_enable[1] = true, \
+	.trigger_enable[2] = true, \
+	.trigger_enable[3] = false, \
+	.trigger_type[0] = THROTTLE_ACTIVE, \
+	.trigger_type[1] = THROTTLE_ACTIVE, \
+	.trigger_type[2] = SW_TRIP, \
+	.trigger_type[3] = HW_TRIP, \
+	.max_trigger_level = 4, \
+	.gain = 8, \
+	.reference_voltage = 16, \
+	.noise_cancel_mode = 4, \
+	.cal_type = TYPE_ONE_POINT_TRIMMING, \
+	.efuse_value = 55, \
+	.min_efuse_value = 40, \
+	.max_efuse_value = 100, \
+	.first_point_trim = 25, \
+	.second_point_trim = 85, \
+	.default_temp_offset = 50, \
+	.freq_tab[0] = { \
+		.freq_clip_max = 800 * 1000, \
+		.temp_level = 85, \
+	}, \
+	.freq_tab[1] = { \
+		.freq_clip_max = 200 * 1000, \
+		.temp_level = 103, \
+	}, \
+	.freq_tab_count = 2, \
+	.registers = &exynos5260_tmu_registers, \
+
+#define EXYNOS5260_TMU_DATA \
+	__EXYNOS5260_TMU_DATA \
+	.type = SOC_ARCH_EXYNOS5260, \
+	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_TRIM_RELOAD | \
+			TMU_SUPPORT_FALLING_TRIP | TMU_SUPPORT_READY_STATUS | \
+			TMU_SUPPORT_EMUL_TIME)
+
+struct exynos_tmu_init_data const exynos5260_default_tmu_data = {
+	.tmu_data = {
+		{ EXYNOS5260_TMU_DATA },
+		{ EXYNOS5260_TMU_DATA },
+		{ EXYNOS5260_TMU_DATA },
+		{ EXYNOS5260_TMU_DATA },
+		{ EXYNOS5260_TMU_DATA },
+	},
+	.tmu_count = 5,
+};
+#endif
+
 #if defined(CONFIG_SOC_EXYNOS5420)
 static const struct exynos_tmu_registers exynos5420_tmu_registers = {
 	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
diff --git a/drivers/thermal/samsung/exynos_tmu_data.h b/drivers/thermal/samsung/exynos_tmu_data.h
index 41f06dc..d268981 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.h
+++ b/drivers/thermal/samsung/exynos_tmu_data.h
@@ -87,6 +87,7 @@
 #define EXYNOS_TMU_INTEN_FALL0_SHIFT	16
 #define EXYNOS_TMU_INTEN_FALL1_SHIFT	20
 #define EXYNOS_TMU_INTEN_FALL2_SHIFT	24
+#define EXYNOS_TMU_INTEN_FALL3_SHIFT	28
 
 #define EXYNOS_EMUL_TIME	0x57F0
 #define EXYNOS_EMUL_TIME_MASK	0xffff
@@ -97,6 +98,17 @@
 
 #define EXYNOS_MAX_TRIGGER_PER_REG	4
 
+/* Exynos5260 specific */
+#define EXYNOS_TMU_REG_CONTROL1			0x24
+#define EXYNOS5260_TMU_REG_INTEN		0xC0
+#define EXYNOS5260_TMU_REG_INTSTAT		0xC4
+#define EXYNOS5260_TMU_REG_INTCLEAR		0xC8
+#define EXYNOS5260_TMU_CLEAR_RISE_INT		0x1111
+#define EXYNOS5260_TMU_CLEAR_FALL_INT		(0x1111 << 16)
+#define EXYNOS5260_TMU_RISE_INT_MASK		0x1111
+#define EXYNOS5260_TMU_FALL_INT_MASK		0x1111
+#define EXYNOS5260_EMUL_CON			0x100
+
 /* Exynos4412 specific */
 #define EXYNOS4412_MUX_ADDR_VALUE          6
 #define EXYNOS4412_MUX_ADDR_SHIFT          20
@@ -157,6 +169,13 @@ extern struct exynos_tmu_init_data const exynos5250_default_tmu_data;
 #define EXYNOS5250_TMU_DRV_DATA (NULL)
 #endif
 
+#if defined(CONFIG_SOC_EXYNOS5260)
+extern struct exynos_tmu_init_data const exynos5260_default_tmu_data;
+#define EXYNOS5260_TMU_DRV_DATA (&exynos5260_default_tmu_data)
+#else
+#define EXYNOS5260_TMU_DRV_DATA (NULL)
+#endif
+
 #if defined(CONFIG_SOC_EXYNOS5420)
 extern struct exynos_tmu_init_data const exynos5420_default_tmu_data;
 #define EXYNOS5420_TMU_DRV_DATA (&exynos5420_default_tmu_data)
-- 
1.7.10.4

