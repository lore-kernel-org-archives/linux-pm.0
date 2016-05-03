From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v3 03/11] thermal: tegra: add hw-throttle for Tegra132
Date: Tue, 3 May 2016 18:13:22 +0800
Message-ID: <1462270410-2425-4-git-send-email-wni@nvidia.com>
References: <1462270410-2425-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462270410-2425-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Tegra132 use CCROC throttle registers to configure
pulse skiper, set these registers to enable throttle
function for Tegra132.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c                | 234 +++++++++++++++++++++---
 drivers/thermal/tegra/tegra132-soctherm.c       |  17 ++
 include/dt-bindings/thermal/tegra124-soctherm.h |   5 +
 3 files changed, 226 insertions(+), 30 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index d7fd67928607..452e20f6c8b0 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -136,6 +136,21 @@
 #define CAR_SUPER_CCLKG_DIVIDER			0x36c
 #define CDIVG_USE_THERM_CONTROLS_MASK		BIT(30)
 
+/* ccroc register offsets needed for enabling HW throttling for Tegra132 */
+#define CCROC_SUPER_CCLKG_DIVIDER		0x024
+
+#define CCROC_GLOBAL_CFG			0x148
+
+#define CCROC_THROT_PSKIP_RAMP_CPU		0x150
+#define CCROC_THROT_PSKIP_RAMP_SEQ_BYPASS_MODE_MASK	BIT(31)
+#define CCROC_THROT_PSKIP_RAMP_DURATION_MASK	(0xffff << 8)
+#define CCROC_THROT_PSKIP_RAMP_STEP_MASK	0xff
+
+#define CCROC_THROT_PSKIP_CTRL_CPU		0x154
+#define CCROC_THROT_PSKIP_CTRL_ENB_MASK		BIT(31)
+#define CCROC_THROT_PSKIP_CTRL_DIVIDEND_MASK	(0xff << 8)
+#define CCROC_THROT_PSKIP_CTRL_DIVISOR_MASK	0xff
+
 /* get val from register(r) mask bits(m) */
 #define REG_GET_MASK(r, m)	(((r) & (m)) >> (ffs(m) - 1))
 /* set val(v) to mask bits(m) of register(r) */
@@ -158,6 +173,13 @@
 #define THROT_DELAY_CTRL(throt)		(THROT_DELAY_LITE + \
 					(THROT_OFFSET * throt))
 
+/* get CCROC_THROT_PSKIP_xxx offset per HIGH/MED/LOW vect*/
+#define CCROC_THROT_OFFSET			0x0c
+#define CCROC_THROT_PSKIP_CTRL_CPU_REG(vect)    (CCROC_THROT_PSKIP_CTRL_CPU + \
+						(CCROC_THROT_OFFSET * vect))
+#define CCROC_THROT_PSKIP_RAMP_CPU_REG(vect)    (CCROC_THROT_PSKIP_RAMP_CPU + \
+						(CCROC_THROT_OFFSET * vect))
+
 /* get THERMCTL_LEVELx offset per CPU/GPU/MEM/TSENSE rg and LEVEL0~3 lv */
 #define THERMCTL_LVL_REGS_SIZE		0x20
 #define THERMCTL_LVL_REG(rg, lv)	((rg) + ((lv) * THERMCTL_LVL_REGS_SIZE))
@@ -195,6 +217,7 @@ struct soctherm_throt_cfg {
 	const char *name;
 	unsigned int id;
 	u8 priority;
+	u8 cpu_throt_level;
 	u32 cpu_throt_depth;
 	struct thermal_cooling_device *cdev;
 	bool init;
@@ -206,6 +229,7 @@ struct tegra_soctherm {
 	struct clk *clock_soctherm;
 	void __iomem *regs;
 	void __iomem *clk_regs;
+	void __iomem *ccroc_regs;
 
 	u32 *calib;
 	struct thermal_zone_device **thermctl_tzs;
@@ -241,6 +265,31 @@ static inline u32 clk_readl(struct tegra_soctherm *ts, u32 reg)
 	return readl(ts->clk_regs + reg);
 }
 
+/**
+ * ccroc_writel() - writes a value to a CCROC register
+ * @ts: pointer to a struct tegra_soctherm
+ * @v: the value to write
+ * @reg: the register offset
+ *
+ * Writes @v to @reg.  No return value.
+ */
+static inline void ccroc_writel(struct tegra_soctherm *ts, u32 value, u32 reg)
+{
+	writel(value, (ts->ccroc_regs + reg));
+}
+
+/**
+ * ccroc_readl() - reads specified register from CCROC IP block
+ * @ts: pointer to a struct tegra_soctherm
+ * @reg: register address to be read
+ *
+ * Return: the value of the register
+ */
+static inline u32 ccroc_readl(struct tegra_soctherm *ts, u32 reg)
+{
+	return readl(ts->ccroc_regs + reg);
+}
+
 static void enable_tsensor(struct tegra_soctherm *tegra, unsigned int i)
 {
 	const struct tegra_tsensor *sensor = &tegra->soc->tsensors[i];
@@ -552,9 +601,6 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 		 sg->name, temperature);
 
 set_throttle:
-	if (ts->soc->use_ccroc)
-		return 0;
-
 	ret = get_hot_temp(tz, &trip, &temperature);
 	if (ret) {
 		dev_warn(dev, "throttrip: %s: missing hot temperature\n",
@@ -676,9 +722,6 @@ static int regs_show(struct seq_file *s, void *data)
 	state = REG_GET_MASK(r, SENSOR_TEMP2_MEM_TEMP_MASK);
 	seq_printf(s, " MEM(%d)\n", translate_temp(state));
 
-	if (ts->soc->use_ccroc)
-		return 0;
-
 	for (i = 0; i < ts->soc->num_ttgs; i++) {
 		seq_printf(s, "%s:\n", ttgs[i]->name);
 		for (level = 0; level < 4; level++) {
@@ -779,12 +822,17 @@ static int regs_show(struct seq_file *s, void *data)
 	seq_printf(s, "enabled(%d)\n", state);
 
 	r = readl(ts->regs + CPU_PSKIP_STATUS);
-	state = REG_GET_MASK(r, XPU_PSKIP_STATUS_M_MASK);
-	seq_printf(s, "CPU PSKIP STATUS: M(%d) ", state);
-	state = REG_GET_MASK(r, XPU_PSKIP_STATUS_N_MASK);
-	seq_printf(s, "N(%d) ", state);
-	state = REG_GET_MASK(r, XPU_PSKIP_STATUS_ENABLED_MASK);
-	seq_printf(s, "enabled(%d)\n", state);
+	if (ts->soc->use_ccroc) {
+		state = REG_GET_MASK(r, XPU_PSKIP_STATUS_ENABLED_MASK);
+		seq_printf(s, "CPU PSKIP STATUS: enabled(%d)\n", state);
+	} else {
+		state = REG_GET_MASK(r, XPU_PSKIP_STATUS_M_MASK);
+		seq_printf(s, "CPU PSKIP STATUS: M(%d) ", state);
+		state = REG_GET_MASK(r, XPU_PSKIP_STATUS_N_MASK);
+		seq_printf(s, "N(%d) ", state);
+		state = REG_GET_MASK(r, XPU_PSKIP_STATUS_ENABLED_MASK);
+		seq_printf(s, "enabled(%d)\n", state);
+	}
 
 	return 0;
 }
@@ -939,15 +987,29 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 		}
 		stc->priority = val;
 
-		r = of_property_read_u32(np_stcc, "nvidia,cpu-throt-depth",
-					 &val);
-		if (r) {
-			dev_info(dev,
-				 "throttle-cfg: %s: missing cpu_throt_depth\n",
-				 name);
-			continue;
+		if (ts->soc->use_ccroc) {
+			r = of_property_read_u32(np_stcc,
+						 "nvidia,cpu-throt-level",
+						 &val);
+			if (r) {
+				dev_info(dev,
+					 "throttle-cfg: %s: missing cpu_throt_level\n",
+					 name);
+				continue;
+			}
+			stc->cpu_throt_level = val;
+		} else {
+			r = of_property_read_u32(np_stcc,
+						 "nvidia,cpu-throt-depth",
+						 &val);
+			if (r) {
+				dev_info(dev,
+					 "throttle-cfg: %s: missing cpu_throt_depth\n",
+					 name);
+				continue;
+			}
+			stc->cpu_throt_depth = val;
 		}
-		stc->cpu_throt_depth = val;
 
 		tcd = thermal_of_cooling_device_register(np_stcc,
 							 (char *)name, ts,
@@ -968,6 +1030,96 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 }
 
 /**
+ * throttlectl_cpu_level_cfg() - programs CCROC NV_THERM level config
+ * @level: describing the level LOW/MED/HIGH of throttling
+ *
+ * It's necessary to set up the CPU-local CCROC NV_THERM instance with
+ * the M/N values desired for each level. This function does this.
+ *
+ * This function pre-programs the CCROC NV_THERM levels in terms of
+ * pre-configured "Low", "Medium" or "Heavy" throttle levels which are
+ * mapped to THROT_LEVEL_LOW, THROT_LEVEL_MED and THROT_LEVEL_HVY.
+ */
+static void throttlectl_cpu_level_cfg(struct tegra_soctherm *ts, int level)
+{
+	u8 depth, dividend;
+	u32 r;
+
+	switch (level) {
+	case TEGRA_SOCTHERM_THROT_LEVEL_LOW:
+		depth = 50;
+		break;
+	case TEGRA_SOCTHERM_THROT_LEVEL_MED:
+		depth = 75;
+		break;
+	case TEGRA_SOCTHERM_THROT_LEVEL_HIGH:
+		depth = 80;
+		break;
+	case TEGRA_SOCTHERM_THROT_LEVEL_NONE:
+		return;
+	default:
+		return;
+	}
+
+	dividend = THROT_DEPTH_DIVIDEND(depth);
+
+	/* setup PSKIP in ccroc nv_therm registers */
+	r = ccroc_readl(ts, CCROC_THROT_PSKIP_RAMP_CPU_REG(level));
+	r = REG_SET_MASK(r, CCROC_THROT_PSKIP_RAMP_DURATION_MASK, 0xff);
+	r = REG_SET_MASK(r, CCROC_THROT_PSKIP_RAMP_STEP_MASK, 0xf);
+	ccroc_writel(ts, r, CCROC_THROT_PSKIP_RAMP_CPU_REG(level));
+
+	r = ccroc_readl(ts, CCROC_THROT_PSKIP_CTRL_CPU_REG(level));
+	r = REG_SET_MASK(r, CCROC_THROT_PSKIP_CTRL_ENB_MASK, 1);
+	r = REG_SET_MASK(r, CCROC_THROT_PSKIP_CTRL_DIVIDEND_MASK, dividend);
+	r = REG_SET_MASK(r, CCROC_THROT_PSKIP_CTRL_DIVISOR_MASK, 0xff);
+	ccroc_writel(ts, r, CCROC_THROT_PSKIP_CTRL_CPU_REG(level));
+}
+
+/**
+ * throttlectl_cpu_level_select() - program CPU pulse skipper config
+ * @throt: the LIGHT/HEAVY of throttle event id
+ *
+ * Pulse skippers are used to throttle clock frequencies.  This
+ * function programs the pulse skippers based on @throt and platform
+ * data.  This function is used on SoCs which have CPU-local pulse
+ * skipper control, such as T13x. It programs soctherm's interface to
+ * Denver:CCROC NV_THERM in terms of Low, Medium and HIGH throttling
+ * vectors. PSKIP_BYPASS mode is set as required per HW spec.
+ */
+static void throttlectl_cpu_level_select(struct tegra_soctherm *ts,
+					 enum soctherm_throttle_id throt)
+{
+	u32 r, throt_vect;
+
+	/* Denver:CCROC NV_THERM interface N:3 Mapping */
+	switch (ts->throt_cfgs[throt].cpu_throt_level) {
+	case TEGRA_SOCTHERM_THROT_LEVEL_LOW:
+		throt_vect = THROT_VECT_LOW;
+		break;
+	case TEGRA_SOCTHERM_THROT_LEVEL_MED:
+		throt_vect = THROT_VECT_MED;
+		break;
+	case TEGRA_SOCTHERM_THROT_LEVEL_HIGH:
+		throt_vect = THROT_VECT_HIGH;
+		break;
+	default:
+		throt_vect = THROT_VECT_NONE;
+		break;
+	}
+
+	r = readl(ts->regs + THROT_PSKIP_CTRL(throt, THROTTLE_DEV_CPU));
+	r = REG_SET_MASK(r, THROT_PSKIP_CTRL_ENABLE_MASK, 1);
+	r = REG_SET_MASK(r, THROT_PSKIP_CTRL_VECT_CPU_MASK, throt_vect);
+	r = REG_SET_MASK(r, THROT_PSKIP_CTRL_VECT2_CPU_MASK, throt_vect);
+	writel(r, ts->regs + THROT_PSKIP_CTRL(throt, THROTTLE_DEV_CPU));
+
+	/* bypass sequencer in soc_therm as it is programmed in ccroc */
+	r = REG_SET_MASK(0, THROT_PSKIP_RAMP_SEQ_BYPASS_MODE_MASK, 1);
+	writel(r, ts->regs + THROT_PSKIP_RAMP(throt, THROTTLE_DEV_CPU));
+}
+
+/**
  * throttlectl_cpu_mn() - program CPU pulse skipper configuration
  * @throt: the LIGHT/HEAVY of throttle event id
  *
@@ -1017,7 +1169,10 @@ static void soctherm_throttle_program(struct tegra_soctherm *ts,
 		return;
 
 	/* Setup PSKIP parameters */
-	throttlectl_cpu_mn(ts, throt);
+	if (ts->soc->use_ccroc)
+		throttlectl_cpu_level_select(ts, throt);
+	else
+		throttlectl_cpu_mn(ts, throt);
 
 	r = REG_SET_MASK(0, THROT_PRIORITY_LITE_PRIO_MASK, stc.priority);
 	writel(r, ts->regs + THROT_PRIORITY_CTRL(throt));
@@ -1040,16 +1195,31 @@ static void tegra_soctherm_throttle(struct device *dev)
 	u32 v;
 	int i;
 
+	/* configure LOW, MED and HIGH levels for CCROC NV_THERM */
+	if (ts->soc->use_ccroc) {
+		throttlectl_cpu_level_cfg(ts, TEGRA_SOCTHERM_THROT_LEVEL_LOW);
+		throttlectl_cpu_level_cfg(ts, TEGRA_SOCTHERM_THROT_LEVEL_MED);
+		throttlectl_cpu_level_cfg(ts, TEGRA_SOCTHERM_THROT_LEVEL_HIGH);
+	}
+
 	/* Thermal HW throttle programming */
 	for (i = 0; i < THROTTLE_SIZE; i++)
 		soctherm_throttle_program(ts, i);
 
 	v = REG_SET_MASK(0, THROT_GLOBAL_ENB_MASK, 1);
-	writel(v, ts->regs + THROT_GLOBAL_CFG);
+	if (ts->soc->use_ccroc) {
+		ccroc_writel(ts, v, CCROC_GLOBAL_CFG);
 
-	v = clk_readl(ts, CAR_SUPER_CCLKG_DIVIDER);
-	v = REG_SET_MASK(v, CDIVG_USE_THERM_CONTROLS_MASK, 1);
-	clk_writel(ts, v, CAR_SUPER_CCLKG_DIVIDER);
+		v = ccroc_readl(ts, CCROC_SUPER_CCLKG_DIVIDER);
+		v = REG_SET_MASK(v, CDIVG_USE_THERM_CONTROLS_MASK, 1);
+		ccroc_writel(ts, v, CCROC_SUPER_CCLKG_DIVIDER);
+	} else {
+		writel(v, ts->regs + THROT_GLOBAL_CFG);
+
+		v = clk_readl(ts, CAR_SUPER_CCLKG_DIVIDER);
+		v = REG_SET_MASK(v, CDIVG_USE_THERM_CONTROLS_MASK, 1);
+		clk_writel(ts, v, CAR_SUPER_CCLKG_DIVIDER);
+	}
 
 	/* initialize stats collection */
 	v = STATS_CTL_CLR_DN | STATS_CTL_EN_DN |
@@ -1084,9 +1254,6 @@ static void soctherm_init(struct platform_device *pdev)
 	writel(pdiv, tegra->regs + SENSOR_PDIV);
 	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);
 
-	if (tegra->soc->use_ccroc)
-		return;
-
 	/* Configure hw throttle */
 	tegra_soctherm_throttle(&pdev->dev);
 }
@@ -1157,6 +1324,14 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "can't get car clk registers");
 			return PTR_ERR(tegra->clk_regs);
 		}
+	} else {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "ccroc-reg");
+		tegra->ccroc_regs = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(tegra->ccroc_regs)) {
+			dev_err(&pdev->dev, "can't get ccroc registers");
+			return PTR_ERR(tegra->ccroc_regs);
+		}
 	}
 
 	tegra->reset = devm_reset_control_get(&pdev->dev, "soctherm");
@@ -1207,8 +1382,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	if (!tegra->soc->use_ccroc)
-		soctherm_init_hw_throt_cdev(pdev);
+	soctherm_init_hw_throt_cdev(pdev);
 
 	soctherm_init(pdev);
 
diff --git a/drivers/thermal/tegra/tegra132-soctherm.c b/drivers/thermal/tegra/tegra132-soctherm.c
index ae5d61af2df3..97fa30501eb1 100644
--- a/drivers/thermal/tegra/tegra132-soctherm.c
+++ b/drivers/thermal/tegra/tegra132-soctherm.c
@@ -28,7 +28,11 @@
 #define TEGRA132_THERMTRIP_CPU_THRESH_MASK	(0xff << 8)
 #define TEGRA132_THERMTRIP_TSENSE_THRESH_MASK	0xff
 
+#define TEGRA132_THERMCTL_LVL0_UP_THRESH_MASK	(0xff << 17)
+#define TEGRA132_THERMCTL_LVL0_DN_THRESH_MASK	(0xff << 9)
+
 #define TEGRA132_THRESH_GRAIN			1000
+#define TEGRA132_BPTT				8
 
 static const struct tegra_tsensor_configuration tegra132_tsensor_config = {
 	.tall = 16300,
@@ -51,6 +55,9 @@ static const struct tegra_tsensor_group tegra132_tsensor_group_cpu = {
 	.thermtrip_any_en_mask = TEGRA132_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA132_THERMTRIP_CPU_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA132_THERMTRIP_CPU_THRESH_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_CPU,
+	.thermctl_lvl0_up_thresh_mask = TEGRA132_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA132_THERMCTL_LVL0_DN_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group tegra132_tsensor_group_gpu = {
@@ -66,6 +73,9 @@ static const struct tegra_tsensor_group tegra132_tsensor_group_gpu = {
 	.thermtrip_any_en_mask = TEGRA132_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA132_THERMTRIP_GPU_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA132_THERMTRIP_GPUMEM_THRESH_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_GPU,
+	.thermctl_lvl0_up_thresh_mask = TEGRA132_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA132_THERMCTL_LVL0_DN_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group tegra132_tsensor_group_pll = {
@@ -79,6 +89,9 @@ static const struct tegra_tsensor_group tegra132_tsensor_group_pll = {
 	.thermtrip_any_en_mask = TEGRA132_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA132_THERMTRIP_TSENSE_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA132_THERMTRIP_TSENSE_THRESH_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_TSENSE,
+	.thermctl_lvl0_up_thresh_mask = TEGRA132_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA132_THERMCTL_LVL0_DN_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group tegra132_tsensor_group_mem = {
@@ -94,6 +107,9 @@ static const struct tegra_tsensor_group tegra132_tsensor_group_mem = {
 	.thermtrip_any_en_mask = TEGRA132_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA132_THERMTRIP_MEM_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA132_THERMTRIP_GPUMEM_THRESH_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_MEM,
+	.thermctl_lvl0_up_thresh_mask = TEGRA132_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA132_THERMCTL_LVL0_DN_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group *tegra132_tsensor_groups[] = {
@@ -193,5 +209,6 @@ const struct tegra_soctherm_soc tegra132_soctherm = {
 	.num_ttgs = ARRAY_SIZE(tegra132_tsensor_groups),
 	.tfuse = &tegra132_soctherm_fuse,
 	.thresh_grain = TEGRA132_THRESH_GRAIN,
+	.bptt = TEGRA132_BPTT,
 	.use_ccroc = true,
 };
diff --git a/include/dt-bindings/thermal/tegra124-soctherm.h b/include/dt-bindings/thermal/tegra124-soctherm.h
index 729ab9fc325e..2a99f1d52bb5 100644
--- a/include/dt-bindings/thermal/tegra124-soctherm.h
+++ b/include/dt-bindings/thermal/tegra124-soctherm.h
@@ -11,4 +11,9 @@
 #define TEGRA124_SOCTHERM_SENSOR_PLLX 3
 #define TEGRA124_SOCTHERM_SENSOR_NUM 4
 
+#define TEGRA_SOCTHERM_THROT_LEVEL_LOW  0
+#define TEGRA_SOCTHERM_THROT_LEVEL_MED  1
+#define TEGRA_SOCTHERM_THROT_LEVEL_HIGH 2
+#define TEGRA_SOCTHERM_THROT_LEVEL_NONE -1
+
 #endif
-- 
1.9.1
