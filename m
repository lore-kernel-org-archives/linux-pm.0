From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: [RFC PATCH 4/5] PM / AVS: thermal: MT8173: Introduce support for SVS engine
Date: Fri, 22 Jan 2016 16:40:28 +0800
Message-ID: <1453452029-20843-5-git-send-email-pi-cheng.chen@linaro.org>
References: <1453452029-20843-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34284 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbcAVIlD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2016 03:41:03 -0500
Received: by mail-pa0-f41.google.com with SMTP id uo6so38909387pac.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2016 00:41:03 -0800 (PST)
In-Reply-To: <1453452029-20843-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: Kevin Hilman <khilman@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>

The SVS (Smart Voltage Scaling) engine is a piece of hardware which is
used to caculate optimized voltage values of several power domains, e.g.
CPU clusters, according to chip process corner, temperatures, and other
factors. Then DVFS driver could apply those optimized voltage values to
reduce power consumption. This engine takes calibration data stored in
on-chip E-Fuse device as configuration input during initialization. Once
the initialization is done, SVS engine issues interrupts according to
temerature changes of power domains to notify DVFS driver to get
calculated voltage values.

The configuration registers of SVS engine are shared with Mediatek
thermal controller, and those registers are banked for different power
domains. In addition, the SVS engine also needs some information from
Mediatek thermal controller, e.g. the temperature of a specific power
domain, part of the thermal calibration data. Therefore the support for
SVS engine is integrated with Mediatek thermal controller driver.

Also, for platform specific requirement, to make SVS engine work
correctly, the initialization of SVS engine should be later then
Mediatek thermal controller, and prior to mt8173-cpufreq driver. Hence,
the platform device registration code of mt8173-cpufreq is removed here
after SVS initialization is done or skipped to ensure the platform
specific initialization flow.

The functionality of SVS engine is optional for Mediatek thermal
controller. If the required resources of SVS engine is absent or SVS
failed during initialization stage, the SVS control flow will be
skipped and the thermal controller will function normally.

CC: Stephen Boyd <sboyd@codeaurora.org>

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
This patch relies on the runtime voltage adjustment of OPP introduced in CPR
patchset done by Stephen Boyd[1].

[1] https://lkml.org/lkml/2015/9/18/833
---
 drivers/thermal/mtk_thermal.c | 704 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 704 insertions(+)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index f20e784..d8ba9dd 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -13,6 +13,9 @@
  */
 
 #include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -21,12 +24,15 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/thermal.h>
 #include <linux/reset.h>
 #include <linux/types.h>
 #include <linux/nvmem-consumer.h>
+#include <linux/workqueue.h>
 
 /* AUXADC Registers */
 #define AUXADC_CON0_V		0x000
@@ -73,7 +79,32 @@
 
 #define TEMP_SPARE0		0x0f0
 
+#define SVS_BANK_CONFIG0	0x200
+#define SVS_BANK_CONFIG1	0x204
+#define SVS_BANK_CONFIG2	0x208
+#define SVS_BANK_CONFIG3	0x20c
+#define SVS_BANK_CONFIG4	0x210
+#define SVS_BANK_CONFIG5	0x214
+#define SVS_BANK_FREQPCT30	0x218
+#define SVS_BANK_FREQPCT74	0x21c
+#define SVS_BANK_LIMITVALS	0x220
+#define SVS_BANK_CONFIG6	0x224
+#define SVS_BANK_CONFIG7	0x228
+#define SVS_BANK_CONFIG8	0x22c
+#define SVS_BANK_CONFIG9	0x230
+#define SVS_BANK_CONFIG10	0x234
+#define SVS_BANK_EN		0x238
+#define SVS_BANK_CONTROL0	0x23c
+#define SVS_BANK_CONTROL1	0x240
+#define SVS_BANK_CONTROL2	0x244
+#define SVS_BANK_VOP30		0x248
+#define SVS_BANK_VOP74		0x24c
+#define SVS_BANK_INTST		0x254
+#define SVS_BANK_CONTROL3	0x25c
+#define SVS_BANK_CONTROL4	0x264
+
 #define PTPCORESEL		0x400
+#define SVS_SVSINTST		0x408
 
 #define TEMP_MONCTL1_PERIOD_UNIT(x)	((x) & 0x3ff)
 
@@ -106,6 +137,24 @@
 /* The number of sensing points per bank */
 #define MT8173_NUM_SENSORS_PER_ZONE	4
 
+/* The number of OPPs supported by SVS */
+#define MT8173_NUM_SVS_OPP		8
+
+/* Bit masks of SVS enable and IRQ configrations */
+#define PHASE_EN_MASK		0x7
+#define PHASE_0_EN		0x1
+#define PHASE_CON_EN		0x2
+#define PHASE_1_EN		0x4
+#define PHASE_01_EN		(PHASE_0_EN | PHASE_1_EN)
+#define PHASE_01_IRQ		0x1
+#define PHASE_CON_IRQ		(0xff << 16)
+
+/* The number of SVS banks implemented */
+#define MT8173_NUM_SVS_BANKS	2
+
+#define MT8173_SVS_BANK_CA53	0
+#define MT8173_SVS_BANK_CA72	1
+
 /* Layout of the fuses providing the calibration data */
 #define MT8173_CALIB_BUF0_VALID		(1 << 0)
 #define MT8173_CALIB_BUF1_ADC_GE(x)	(((x) >> 22 ) & 0x3ff)
@@ -116,6 +165,22 @@
 #define MT8173_CALIB_BUF2_VTS_TSABB(x)	(((x) >> 14 ) & 0x1ff)
 #define MT8173_CALIB_BUF0_DEGC_CALI(x)	(((x) >> 1 ) & 0x3f)
 #define MT8173_CALIB_BUF0_O_SLOPE(x)	(((x) >> 26 ) & 0x3f)
+#define MT8173_CALIB_BUF0_O_SLOPE_S(x)	(((x) >> 7) & 0x1)
+
+/* Helpers to calculate configuration values from SVS calibration data */
+#define SVS_CALIB_VALID	(1)
+#define BANK_SHIFT(bank) ((bank == 0) ? 8 : 0)
+#define SVS_CALIB_BANK_CONFIG0(buf, s)				\
+	(((((buf[33] >> (s)) & 0xff)) << 8) |			\
+	((buf[32] >> (s)) & 0xff))
+#define SVS_CALIB_BANK_CONFIG1(buf, s)				\
+	((((buf[34] >> (s)) & 0xff) << 8) | 0x100006)
+#define SVS_CALIB_BANK_CONFIG2L(base, s)			\
+	((buf[0] >> (s)) & 0xff)
+#define SVS_CALIB_BANK_CONFIG2H(base, s)			\
+	((buf[1] >> (s)) & 0xff)
+#define SVS_CALIB_BANK_CONFIG3(base, s)				\
+	(((buf[2] >> (s)) & 0xff) << 8)
 
 #define THERMAL_NAME    "mtk-thermal"
 
@@ -126,14 +191,55 @@ struct mtk_thermal_bank {
 	int id;
 };
 
+enum svs_state {
+	SVS_PHASE_0 = 0,
+	SVS_PHASE_1,
+	SVS_PHASE_CONTINUOUS,
+};
+
+struct mtk_svs_bank {
+	int bank_id;
+	struct mtk_thermal *mt;
+	struct completion init_done;
+	struct work_struct work;
+
+	struct device *dev;
+	struct regulator *reg;
+
+	/* SVS per-bank calibration values */
+	u32 ctrl0;
+	u32 config0;
+	u32 config1;
+	u32 config2;
+	u32 config3;
+
+	unsigned long freq_table[MT8173_NUM_SVS_OPP];
+	int volt_table[MT8173_NUM_SVS_OPP];
+	int updated_volt_table[MT8173_NUM_SVS_OPP];
+};
+
+struct mtk_svs_bank_cfg {
+	const int dev_id;
+	const int ts;
+	const int vmin;
+	const int vmax;
+	const int vboot;
+	const unsigned long base_freq;
+};
+
 struct mtk_thermal {
 	struct device *dev;
 	void __iomem *thermal_base;
 
 	struct clk *clk_peri_therm;
 	struct clk *clk_auxadc;
+	struct clk *svs_mux;
+	struct clk *svs_pll;
 
 	struct mtk_thermal_bank banks[MT8173_NUM_ZONES];
+	struct mtk_svs_bank svs_banks[MT8173_NUM_SVS_BANKS];
+
+	int svs_irq;
 
 	spinlock_t lock;
 
@@ -142,6 +248,9 @@ struct mtk_thermal {
 	s32 degc_cali;
 	s32 o_slope;
 	s32 vts[MT8173_NUM_SENSORS];
+	s32 x_roomt[MT8173_NUM_SENSORS];
+	s32 bts[MT8173_NUM_ZONES];
+	s32 mts;
 
 	struct thermal_zone_device *tzd;
 };
@@ -198,6 +307,25 @@ static const struct mtk_thermal_sense_point
 	},
 };
 
+static const struct mtk_svs_bank_cfg svs_bank_cfgs[MT8173_NUM_SVS_BANKS] = {
+	[MT8173_SVS_BANK_CA53] = {
+		.dev_id = 0,
+		.vmax = 1125,
+		.vmin = 800,
+		.vboot = 1000,
+		.base_freq = 1600000,
+		.ts = MT8173_TS3
+	},
+	[MT8173_SVS_BANK_CA72] = {
+		.dev_id = 2,
+		.vmax = 1125,
+		.vmin = 800,
+		.vboot = 1000,
+		.base_freq = 2000000,
+		.ts = MT8173_TS4
+	}
+};
+
 /**
  * raw_to_mcelsius - convert a raw ADC value to mcelsius
  * @mt:		The thermal controller
@@ -222,6 +350,34 @@ static int raw_to_mcelsius(struct mtk_thermal *mt, int sensno, s32 raw)
 }
 
 /**
+ * mvolt_to_config - convert a voltage value to SVS voltage config value
+ * @mvolt:	voltage value
+ */
+static inline u32 mvolt_to_config(int mvolt)
+{
+	return ((mvolt - 700) * 100 + 625 - 1) / 625;
+}
+
+/**
+ * mvolt_to_config - convert a SVS voltage config value to voltage value
+ * @val:	SVS voltage config value
+ */
+static inline int config_to_mv(u32 val)
+{
+	return (val * 625 / 100) + 700;
+}
+
+/**
+ * khz_to_config - convert a frequency value to SVS frequency config value
+ * @rate:	frequency value
+ * @base_rate:	rate to be used to calculate frequency percentage
+ */
+static inline int khz_to_config(unsigned long rate, unsigned long base_rate)
+{
+	return (rate * 100 + base_rate - 1) / base_rate;
+}
+
+/**
  * mtk_thermal_switch_bank - switch to bank
  * @bank:	The bank
  *
@@ -240,6 +396,46 @@ static void mtk_thermal_switch_bank(struct mtk_thermal_bank *bank)
 }
 
 /**
+ * mtk_svs_update_voltage_table - update the calculated voltage table
+ * @svs: The SVS bank
+ * @offset: The voltage offset
+ *
+ * Read the calculated voltage values from registers and update the SVS bank
+ * voltage table which will be write to OPP table entries later. Caller should
+ * select the bank and hold mt->lock before calling it.
+ */
+static void mtk_svs_update_voltage_table(struct mtk_svs_bank *svs, int offset)
+{
+	struct mtk_thermal *mt = svs->mt;
+	int vmin, vmax, *volt_table;
+	u32 reg;
+
+	vmin = svs_bank_cfgs[svs->bank_id].vmin;
+	vmax = svs_bank_cfgs[svs->bank_id].vmax;
+	volt_table = svs->updated_volt_table;
+
+	reg = readl(mt->thermal_base + SVS_BANK_VOP30);
+	volt_table[0] = clamp(config_to_mv((reg & 0xff) + offset),
+			      vmin, vmax);
+	volt_table[1] = clamp(config_to_mv(((reg >> 8) & 0xff) + offset),
+			      vmin, vmax);
+	volt_table[2] = clamp(config_to_mv(((reg >> 16) & 0xff) + offset),
+			      vmin, vmax);
+	volt_table[3] = clamp(config_to_mv(((reg >> 24) & 0xff) + offset),
+			      vmin, vmax);
+
+	reg = readl(mt->thermal_base + SVS_BANK_VOP74);
+	volt_table[4] = clamp(config_to_mv((reg & 0xff) + offset),
+			      vmin, vmax);
+	volt_table[5] = clamp(config_to_mv(((reg >> 8) & 0xff) + offset),
+			      vmin, vmax);
+	volt_table[6] = clamp(config_to_mv(((reg >> 16) & 0xff) + offset),
+			      vmin, vmax);
+	volt_table[7] = clamp(config_to_mv(((reg >> 24) & 0xff) + offset),
+			      vmin, vmax);
+}
+
+/**
  * mtk_thermal_bank_temperature - get the temperature of a bank
  * @bank:	The bank
  *
@@ -426,6 +622,7 @@ static int mtk_thermal_get_calibration_data(struct device *dev, struct mtk_therm
 	u32 *buf;
 	size_t len;
 	int i, ret = 0;
+	s32 o_slope_s, ge, oe, gain, x_roomt, temp1, temp2;
 
 	/* Start with default values */
 	mt->adc_ge = 512;
@@ -433,6 +630,7 @@ static int mtk_thermal_get_calibration_data(struct device *dev, struct mtk_therm
 		mt->vts[i] = 260;
 	mt->degc_cali = 40;
 	mt->o_slope = 0;
+	o_slope_s = 0;
 
 	cell = nvmem_cell_get(dev, "calibration-data");
 	if (IS_ERR(cell)) {
@@ -463,23 +661,464 @@ static int mtk_thermal_get_calibration_data(struct device *dev, struct mtk_therm
 		mt->vts[MT8173_TSABB] = MT8173_CALIB_BUF2_VTS_TSABB(buf[2]);
 		mt->degc_cali = MT8173_CALIB_BUF0_DEGC_CALI(buf[0]);
 		mt->o_slope = MT8173_CALIB_BUF0_O_SLOPE(buf[0]);
+		o_slope_s = MT8173_CALIB_BUF0_O_SLOPE_S(buf[0]);
 	} else {
 		dev_info(dev, "Device not calibrated, using default calibration values\n");
 	}
 
+	oe = mt->adc_ge - 512;
+	ge = oe * 10000 / 4096;
+	gain = 10000 + ge;
+
+	/* calculating MTS */
+	mt->mts = (o_slope_s == 0) ?
+		  10000 * 100000 / gain * 15 / 18 / (165 + mt->o_slope) :
+		  10000 * 100000 / gain * 15 / 18 / (165 - mt->o_slope);
+
+	/* calculating per-bank BTS */
+	for (i = 0; i < MT8173_NUM_SVS_BANKS; i++) {
+		int ts = svs_bank_cfgs[i].ts;
+
+		x_roomt = mt->vts[ts] + 3350 - oe * 10000 / 4096 * 10000 / gain;
+		temp1 = (10000 * 100000 / 4096 / gain) *
+			ge + x_roomt * 10 * 15 / 18;
+		temp2 = (o_slope_s == 0) ? temp1 * 10 / (165 + mt->o_slope) :
+			temp1 * 10 / (165 - mt->o_slope);
+		mt->bts[i] = (mt->degc_cali * 10 / 2 + temp2 - 250) * 4 / 10;
+	}
+
 out:
 	kfree(buf);
 
 	return ret;
 }
 
+static int mtk_svs_get_calibration_data(struct device *dev,
+					struct mtk_thermal *mt)
+{
+	struct nvmem_cell *cell;
+	u32 *buf;
+	size_t len;
+	int i, ret = 0;
+
+	cell = nvmem_cell_get(dev, "svs-calibration-data");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = (u32 *)nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(buf)) {
+		dev_err(dev, "failed to get svs calibration data: %ld\n",
+			PTR_ERR(buf));
+		return PTR_ERR(buf);
+	}
+
+	if (len < 0x8c || !(buf[29] & SVS_CALIB_VALID)) {
+		dev_err(dev, "Invalid SVS calibration data\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (i = 0; i < MT8173_NUM_SVS_BANKS; i++) {
+		u32 temp;
+
+		mt->svs_banks[i].config0 =
+				SVS_CALIB_BANK_CONFIG0(buf, BANK_SHIFT(i));
+		mt->svs_banks[i].config1 =
+				SVS_CALIB_BANK_CONFIG1(buf, BANK_SHIFT(i));
+		mt->svs_banks[i].config3 =
+				SVS_CALIB_BANK_CONFIG3(buf, BANK_SHIFT(i));
+
+		temp = SVS_CALIB_BANK_CONFIG2H(buf, BANK_SHIFT(i));
+		if (temp < 128 && i == MT8173_SVS_BANK_CA72)
+			temp = (unsigned char)((temp - 256) / 2);
+		temp = ((temp & 0xff) << 8) |
+		       SVS_CALIB_BANK_CONFIG2L(buf, BANK_SHIFT(i));
+		mt->svs_banks[i].config2 = temp;
+	}
+
+out:
+	kfree(buf);
+
+	return ret;
+}
+
+/* Caller must call this function with mt->lock held */
+static void mtk_svs_set_phase(struct mtk_svs_bank *svs, int phase)
+{
+	struct mtk_thermal *mt = svs->mt;
+	unsigned long *freq_tbl, base_freq;
+	int id = svs->bank_id;
+
+	freq_tbl = svs->freq_table;
+	base_freq = svs_bank_cfgs[id].base_freq;
+
+	writel(svs->config0, mt->thermal_base + SVS_BANK_CONFIG0);
+	writel(svs->config1, mt->thermal_base + SVS_BANK_CONFIG1);
+	writel(svs->config2, mt->thermal_base + SVS_BANK_CONFIG2);
+	writel(svs->config3, mt->thermal_base + SVS_BANK_CONFIG3);
+	writel(0x555555, mt->thermal_base + SVS_BANK_CONFIG4);
+	writel(0x555555, mt->thermal_base + SVS_BANK_CONFIG5);
+	writel(0x80000000, mt->thermal_base + SVS_BANK_CONFIG10);
+
+	writel((khz_to_config(freq_tbl[0], base_freq) & 0xff) |
+	       ((khz_to_config(freq_tbl[1], base_freq) & 0xff) << 8) |
+	       ((khz_to_config(freq_tbl[2], base_freq) & 0xff) << 16) |
+	       ((khz_to_config(freq_tbl[3], base_freq) & 0xff) << 24),
+	       mt->thermal_base + SVS_BANK_FREQPCT30);
+
+	writel((khz_to_config(freq_tbl[4], base_freq) & 0xff) |
+	       ((khz_to_config(freq_tbl[5], base_freq) & 0xff) << 8) |
+	       ((khz_to_config(freq_tbl[6], base_freq) & 0xff) << 16) |
+	       ((khz_to_config(freq_tbl[7], base_freq) & 0xff) << 24),
+	       mt->thermal_base + SVS_BANK_FREQPCT74);
+
+	writel(((mvolt_to_config(svs_bank_cfgs[id].vmax) & 0xff) << 24) |
+	       ((mvolt_to_config(svs_bank_cfgs[id].vmin) & 0xff) << 16) | 0x1fe,
+	       mt->thermal_base + SVS_BANK_LIMITVALS);
+
+	writel(mvolt_to_config(svs_bank_cfgs[id].vboot),
+	       mt->thermal_base + SVS_BANK_CONFIG6);
+	writel(0xa28, mt->thermal_base + SVS_BANK_CONFIG7);
+	writel(0xffff, mt->thermal_base + SVS_BANK_CONFIG8);
+
+	/* clear all pending interrupt */
+	writel(0xffffffff, mt->thermal_base + SVS_BANK_INTST);
+
+	switch (phase) {
+	case SVS_PHASE_0:
+		writel(0x5f01, mt->thermal_base + SVS_BANK_CONTROL3);
+		writel(PHASE_0_EN, mt->thermal_base + SVS_BANK_EN);
+		break;
+	case SVS_PHASE_1:
+		writel(0x5f01, mt->thermal_base + SVS_BANK_CONTROL3);
+		writel(svs->ctrl0, mt->thermal_base + SVS_BANK_CONTROL0);
+		writel(PHASE_0_EN | PHASE_1_EN,
+		       mt->thermal_base + SVS_BANK_EN);
+		break;
+	case SVS_PHASE_CONTINUOUS:
+		writel(((mt->bts[id] & 0xfff) << 12) | (mt->mts & 0xfff),
+		       mt->thermal_base + SVS_BANK_CONFIG9);
+		writel(0xff0000, mt->thermal_base + SVS_BANK_CONTROL3);
+		writel(PHASE_CON_EN, mt->thermal_base + SVS_BANK_EN);
+	}
+}
+
+static void mtk_svs_adjust_voltage(struct mtk_svs_bank *svs)
+{
+	int i;
+
+	for (i = 0; i < MT8173_NUM_SVS_OPP; i++) {
+		if (!svs->freq_table[i])
+			continue;
+
+		dev_pm_opp_adjust_voltage(svs->dev, svs->freq_table[i] * 1000,
+					  svs->updated_volt_table[i] * 1000);
+	}
+}
+
+static void adjust_voltage_work(struct work_struct *work)
+{
+	struct mtk_svs_bank *svs = container_of(work, struct mtk_svs_bank,
+						work);
+	struct mtk_thermal *mt = svs->mt;
+	unsigned long flags;
+	int temp, low_temp_offset = 0;
+
+	spin_lock_irqsave(&mt->lock, flags);
+	mtk_thermal_switch_bank(&mt->banks[svs->bank_id]);
+
+	temp = mtk_thermal_bank_temperature(&mt->banks[svs->bank_id]);
+
+	spin_unlock_irqrestore(&mt->lock, flags);
+
+	if (temp <= 33000)
+		low_temp_offset = 10;
+
+	mtk_svs_update_voltage_table(svs, low_temp_offset);
+	mtk_svs_adjust_voltage(svs);
+}
+
+static void mtk_svs_bank_disable(struct mtk_svs_bank *svs)
+{
+	struct mtk_thermal *mt = svs->mt;
+	int i;
+
+	writel(0, mt->thermal_base + SVS_BANK_EN);
+	writel(0xffffff, mt->thermal_base + SVS_BANK_INTST);
+
+	for (i = 0; i < MT8173_NUM_SVS_OPP; i++) {
+		if (!svs->freq_table[i])
+			continue;
+
+		svs->updated_volt_table[i] = svs->volt_table[i];
+	}
+}
+
+static irqreturn_t mtk_svs_interrupt(int irqno, void *dev_id)
+{
+	struct mtk_thermal *mt = dev_id;
+	unsigned long flags;
+	u32 svs_intst, bank_en, bank_intst;
+	int i;
+
+	spin_lock_irqsave(&mt->lock, flags);
+
+	svs_intst = readl(mt->thermal_base + SVS_SVSINTST);
+	for (i = 0; i < MT8173_NUM_SVS_BANKS; i++) {
+		struct mtk_svs_bank *svs = &mt->svs_banks[i];
+
+		if ((svs_intst >> i) & 0x1)
+			continue;
+
+		mtk_thermal_switch_bank(&mt->banks[i]);
+
+		bank_intst = readl(mt->thermal_base + SVS_BANK_INTST);
+		bank_en = readl(mt->thermal_base + SVS_BANK_EN);
+
+		if (bank_intst == PHASE_01_IRQ && /* phase 0 */
+		    (bank_en & PHASE_EN_MASK) == PHASE_0_EN) {
+			u32 reg;
+
+			reg = readl(mt->thermal_base + SVS_BANK_CONTROL1);
+			svs->ctrl0 |= (~(reg & 0xffff) + 1) & 0xffff;
+			reg =  readl(mt->thermal_base + SVS_BANK_CONTROL2);
+			svs->ctrl0 |= (reg & 0xffff) << 16;
+
+			writel(0, mt->thermal_base + SVS_BANK_EN);
+			writel(PHASE_01_IRQ, mt->thermal_base + SVS_BANK_INTST);
+
+			mtk_svs_set_phase(svs, SVS_PHASE_1);
+		} else if (bank_intst == PHASE_01_IRQ && /* phase 1 */
+			   (bank_en & PHASE_EN_MASK) == PHASE_01_EN) {
+			/*
+			 * The cpufreq driver won't work during SVS
+			 * initialization stage, so it's safe to update OPP
+			 * table here since it won't trigger regulator
+			 * operation.
+			 */
+			mtk_svs_update_voltage_table(svs, 0);
+			mtk_svs_adjust_voltage(svs);
+
+			writel(0, mt->thermal_base + SVS_BANK_EN);
+			writel(PHASE_01_IRQ, mt->thermal_base + SVS_BANK_INTST);
+
+			complete(&svs->init_done);
+
+			mtk_svs_set_phase(svs, SVS_PHASE_CONTINUOUS);
+		} else if (bank_intst && PHASE_CON_IRQ) { /* phase continuous*/
+			/*
+			 * Schedule a work to update voltages of OPP table
+			 * entries.
+			 */
+			schedule_work(&svs->work);
+
+			writel(PHASE_CON_IRQ,
+			       mt->thermal_base + SVS_BANK_INTST);
+		} else {
+			mtk_svs_bank_disable(svs);
+			dev_err(mt->svs_banks[i].dev,
+				"SVS engine internal error. disabled.\n");
+
+			/*
+			 * Schedule a work to reset voltages of OPP table
+			 * entries.
+			 */
+			schedule_work(&svs->work);
+		}
+	}
+
+	spin_unlock_irqrestore(&mt->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static int mtk_svs_bank_init(struct mtk_svs_bank *svs)
+{
+	struct dev_pm_opp *opp;
+	cpumask_t cpus;
+	int ret = 0, count, i;
+	unsigned long rate;
+
+	init_completion(&svs->init_done);
+
+	INIT_WORK(&svs->work, adjust_voltage_work);
+
+	svs->dev = get_cpu_device(svs_bank_cfgs[svs->bank_id].dev_id);
+	if (!svs->dev) {
+		pr_err("failed to get cpu%d device\n",
+		       svs_bank_cfgs[svs->bank_id].dev_id);
+		return -ENODEV;
+	}
+
+	svs->reg = regulator_get_exclusive(svs->dev, "proc");
+	if (IS_ERR(svs->reg)) {
+		dev_err(svs->dev, "failed to get proc regulator\n");
+		return PTR_ERR(svs->reg);
+	}
+
+	ret = dev_pm_opp_of_get_sharing_cpus(svs->dev, &cpus);
+	if (ret) {
+		dev_err(svs->dev, "failed to get OPP-sharing information\n");
+		return ret;
+	}
+
+	ret = dev_pm_opp_of_cpumask_add_table(&cpus);
+	if (ret) {
+		dev_err(svs->dev, "no OPP table\n");
+		return ret;
+	}
+
+	rcu_read_lock();
+	count = dev_pm_opp_get_opp_count(svs->dev);
+	if (count > MT8173_NUM_SVS_OPP)
+		dev_warn(svs->dev, "%d OPP entries found.\n"
+			 "But only %d OPP entry supported.\n", count,
+			 MT8173_NUM_SVS_OPP);
+
+	for (i = 0, rate = (unsigned long)-1; i < MT8173_NUM_SVS_OPP &&
+	     i < count; i++, rate--) {
+		opp = dev_pm_opp_find_freq_floor(svs->dev, &rate);
+		if (IS_ERR(opp)) {
+			dev_err(svs->dev, "error opp entry!!\n");
+			rcu_read_unlock();
+			ret = PTR_ERR(opp);
+			goto out;
+		}
+
+		svs->freq_table[i] = rate / 1000;
+		svs->volt_table[i] = dev_pm_opp_get_voltage(opp) / 1000;
+	}
+
+out:
+	rcu_read_unlock();
+	if (ret) {
+		regulator_put(svs->reg);
+		dev_pm_opp_of_cpumask_remove_table(&cpus);
+	}
+
+	return ret;
+}
+
+static void mtk_svs_release(struct mtk_thermal *mt)
+{
+	int i, ret;
+	cpumask_t cpus;
+
+	if (!IS_ERR(mt->svs_pll))
+		clk_put(mt->svs_pll);
+
+	if (!IS_ERR(mt->svs_mux))
+		clk_put(mt->svs_mux);
+
+	if (mt->svs_irq != -1)
+		free_irq(mt->svs_irq, mt);
+
+	for (i = 0; i < MT8173_NUM_SVS_BANKS; i++) {
+		struct mtk_svs_bank *svs = &mt->svs_banks[i];
+
+		ret = dev_pm_opp_of_get_sharing_cpus(svs->dev, &cpus);
+		if (!ret)
+			dev_pm_opp_of_cpumask_remove_table(&cpus);
+
+		if (svs->reg)
+			regulator_put(svs->reg);
+	}
+}
+
+static int mtk_svs_init(struct platform_device *pdev, struct mtk_thermal *mt)
+{
+	struct clk *parent;
+	int i, ret, vboot;
+	unsigned long flags, timeout;
+	struct mtk_svs_bank *svs;
+
+	parent = clk_get_parent(mt->svs_mux);
+	ret = clk_set_parent(mt->svs_mux, mt->svs_pll);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to set svs_mux to svs_pll\n");
+		return ret;
+	}
+
+	for (i = 0; i < MT8173_NUM_SVS_BANKS; i++) {
+		svs = &mt->svs_banks[i];
+
+		vboot = regulator_get_voltage(svs->reg) / 1000;
+		if (mvolt_to_config(vboot) !=
+		    mvolt_to_config(svs_bank_cfgs[i].vboot)) {
+			dev_err(svs->dev, "Vboot value mismatch!\n");
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = regulator_set_mode(svs->reg, REGULATOR_MODE_FAST);
+		if (ret) {
+			dev_err(svs->dev,
+				"Failed to set regulator in PWM mode\n");
+			ret = -EINVAL;
+			break;
+		}
+
+		spin_lock_irqsave(&mt->lock, flags);
+		mtk_thermal_switch_bank(&mt->banks[i]);
+
+		mtk_svs_set_phase(svs, SVS_PHASE_0);
+
+		spin_unlock_irqrestore(&mt->lock, flags);
+
+		timeout = wait_for_completion_timeout(&svs->init_done, HZ);
+		if (timeout == 0) {
+			dev_err(svs->dev, "SVS initialization timeout.\n");
+			ret = -EINVAL;
+			goto err_bank_init;
+		}
+
+		ret = regulator_set_mode(svs->reg, REGULATOR_MODE_NORMAL);
+		if (ret)
+			dev_err(svs->dev,
+				"Failed to set regulator in normal mode\n");
+
+		regulator_put(svs->reg);
+		svs->reg = NULL;
+	}
+
+err_bank_init:
+
+	if (ret)
+		for (i = 0; i < MT8173_NUM_SVS_BANKS; i++) {
+			svs = &mt->svs_banks[i];
+
+			spin_lock_irqsave(&mt->lock, flags);
+			mtk_thermal_switch_bank(&mt->banks[i]);
+
+			mtk_svs_bank_disable(svs);
+
+			spin_unlock_irqrestore(&mt->lock, flags);
+
+			mtk_svs_adjust_voltage(svs);
+		}
+
+	ret = clk_set_parent(mt->svs_mux, parent);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to set svs_mux to original parent\n");
+		return ret;
+	}
+
+	return ret;
+}
+
 static int mtk_thermal_probe(struct platform_device *pdev)
 {
 	int ret, i;
 	struct device_node *auxadc, *apmixedsys, *np = pdev->dev.of_node;
 	struct mtk_thermal *mt;
 	struct resource *res;
+	struct platform_device *pdev_ret;
 	u64 auxadc_phys_base, apmixed_phys_base;
+	bool skip_svs_init = false;
 
 	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
 	if (!mt)
@@ -493,6 +1132,23 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(mt->clk_auxadc))
 		return PTR_ERR(mt->clk_auxadc);
 
+	/*
+	 * These two clks are optional for mtk-thermal. If present, SVS engine
+	 * will be activated.
+	 */
+	mt->svs_pll = devm_clk_get(&pdev->dev, "svs_pll");
+	mt->svs_mux = devm_clk_get(&pdev->dev, "svs_mux");
+	if (IS_ERR(mt->svs_pll) || IS_ERR(mt->svs_mux))
+		skip_svs_init = true;
+
+	mt->svs_irq = platform_get_irq(pdev, 1);
+	ret = devm_request_irq(&pdev->dev, mt->svs_irq, mtk_svs_interrupt,
+			       IRQF_TRIGGER_LOW, "mtk-svs", mt);
+	if (ret) {
+		mt->svs_irq = -1;
+		skip_svs_init = true;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mt->thermal_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(mt->thermal_base))
@@ -502,6 +1158,27 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = mtk_svs_get_calibration_data(&pdev->dev, mt);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	else if (ret)
+		skip_svs_init = true;
+
+	for (i = 0; i < MT8173_NUM_SVS_BANKS; i++) {
+		mt->svs_banks[i].bank_id = i;
+		mt->svs_banks[i].mt = mt;
+
+		ret = mtk_svs_bank_init(&mt->svs_banks[i]);
+		if (ret) {
+			if (ret == -EPROBE_DEFER)
+				return ret;
+
+			dev_err(&pdev->dev,
+				"failed to initialize mtk svs bank%d\n", i);
+			skip_svs_init = true;
+		}
+	}
+
 	spin_lock_init(&mt->lock);
 
 	mt->dev = &pdev->dev;
@@ -562,6 +1239,33 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(mt->tzd))
 		goto err_register;
 
+	/*
+	 * SVS engine needs to be initialized after mtk-thermal initialization
+	 * is done and before the initialization of cpufreq driver.
+	 */
+	if (!skip_svs_init) {
+		ret = mtk_svs_init(pdev, mt);
+		if (ret) {
+			/* Keep running system with SVS engine disabled. */
+			dev_err(&pdev->dev,
+				"Failed to initialze MTK SVS engine\n");
+			skip_svs_init = true;
+		}
+	}
+
+	/*
+	 * Release all resources needed by SVS if not all required resources
+	 * are present or SVS initialization failed.
+	 */
+	if (skip_svs_init)
+		mtk_svs_release(mt);
+
+	pdev_ret = platform_device_register_simple("mt8173-cpufreq", -1,
+						   NULL, 0);
+	if (IS_ERR(pdev_ret))
+		dev_err(&pdev->dev,
+			"failed to register mt8173-cpufreq device\n");
+
 	return 0;
 
 err_register:
-- 
1.9.1

