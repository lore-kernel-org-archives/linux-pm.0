From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 5/9] thermal: tegra: add hw-throttle function
Date: Wed, 27 Apr 2016 11:25:50 +0800
Message-ID: <1461727554-15065-6-git-send-email-wni@nvidia.com>
References: <1461727554-15065-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461727554-15065-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Tegra soctherm support HW throttle, when the soctherm snesors'
temperature is above the throttle trip point, it will trigger
pulse skiper to tune clocks accroding to the throttle depth.
Add this function for Tegra124 and Tegra210.
Since Tegra132 use different registers to configure pulse skiper,
will support it in next patch.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c          | 667 +++++++++++++++++++++++++++++-
 drivers/thermal/tegra/soctherm.h          |  10 +
 drivers/thermal/tegra/tegra124-soctherm.c |  18 +
 drivers/thermal/tegra/tegra132-soctherm.c |   1 +
 drivers/thermal/tegra/tegra210-soctherm.c |  18 +
 5 files changed, 699 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index b8651726201e..e6c4085f876d 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -30,6 +30,7 @@
 
 #include <dt-bindings/thermal/tegra124-soctherm.h>
 
+#include "../thermal_core.h"
 #include "soctherm.h"
 
 #define SENSOR_CONFIG0				0
@@ -67,35 +68,179 @@
 #define READBACK_ADD_HALF			BIT(7)
 #define READBACK_NEGATE				BIT(0)
 
+/*
+ * THERMCTL_LEVEL0_GROUP_CPU is defined in soctherm.h
+ * because it will be used by tegraxxx_soctherm.c
+ */
+#define THERMCTL_LVL0_CPU0_EN_MASK		BIT(8)
+#define THERMCTL_LVL0_CPU0_CPU_THROT_MASK	(0x3 << 5)
+#define THERMCTL_LVL0_CPU0_CPU_THROT_LIGHT	0x1
+#define THERMCTL_LVL0_CPU0_CPU_THROT_HEAVY	0x2
+#define THERMCTL_LVL0_CPU0_GPU_THROT_MASK	(0x3 << 3)
+#define THERMCTL_LVL0_CPU0_GPU_THROT_LIGHT	0x1
+#define THERMCTL_LVL0_CPU0_GPU_THROT_HEAVY	0x2
+#define THERMCTL_LVL0_CPU0_MEM_THROT_MASK	BIT(2)
+#define THERMCTL_LVL0_CPU0_STATUS_MASK		0x3
+
+#define THERMCTL_LVL0_UP_STATS			0x10
+#define THERMCTL_LVL0_DN_STATS			0x14
+
+#define THERMCTL_STATS_CTL			0x94
+#define STATS_CTL_CLR_DN			0x8
+#define STATS_CTL_EN_DN				0x4
+#define STATS_CTL_CLR_UP			0x2
+#define STATS_CTL_EN_UP				0x1
+
+#define THROT_GLOBAL_CFG			0x400
+#define THROT_GLOBAL_ENB_MASK			BIT(0)
+
+#define CPU_PSKIP_STATUS			0x418
+#define XPU_PSKIP_STATUS_M_MASK			(0xff << 12)
+#define XPU_PSKIP_STATUS_N_MASK			(0xff << 4)
+#define XPU_PSKIP_STATUS_SW_OVERRIDE_MASK	BIT(1)
+#define XPU_PSKIP_STATUS_ENABLED_MASK		BIT(0)
+
+#define THROT_PRIORITY_LOCK			0x424
+#define THROT_PRIORITY_LOCK_PRIORITY_MASK	0xff
+
+#define THROT_STATUS				0x428
+#define THROT_STATUS_BREACH_MASK		BIT(12)
+#define THROT_STATUS_STATE_MASK			(0xff << 4)
+#define THROT_STATUS_ENABLED_MASK		BIT(0)
+
+#define THROT_PSKIP_CTRL_LITE_CPU		0x430
+#define THROT_PSKIP_CTRL_ENABLE_MASK            BIT(31)
+#define THROT_PSKIP_CTRL_DIVIDEND_MASK          (0xff << 8)
+#define THROT_PSKIP_CTRL_DIVISOR_MASK           0xff
+#define THROT_PSKIP_CTRL_VECT_GPU_MASK          (0x7 << 16)
+#define THROT_PSKIP_CTRL_VECT_CPU_MASK          (0x7 << 8)
+#define THROT_PSKIP_CTRL_VECT2_CPU_MASK         0x7
+
+#define THROT_VECT_NONE				0x0 /* 3'b000 */
+#define THROT_VECT_LOW				0x1 /* 3'b001 */
+#define THROT_VECT_MED				0x3 /* 3'b011 */
+#define THROT_VECT_HIGH				0x7 /* 3'b111 */
+
+#define THROT_PSKIP_RAMP_LITE_CPU		0x434
+#define THROT_PSKIP_RAMP_SEQ_BYPASS_MODE_MASK	BIT(31)
+#define THROT_PSKIP_RAMP_DURATION_MASK		(0xffff << 8)
+#define THROT_PSKIP_RAMP_STEP_MASK		0xff
+
+#define THROT_PRIORITY_LITE			0x444
+#define THROT_PRIORITY_LITE_PRIO_MASK		0xff
+
+#define THROT_DELAY_LITE			0x448
+#define THROT_DELAY_LITE_DELAY_MASK		0xff
+
+/* car register offsets needed for enabling HW throttling */
+#define CAR_SUPER_CCLKG_DIVIDER			0x36c
+#define CDIVG_USE_THERM_CONTROLS_MASK		BIT(30)
+
 /* get val from register(r) mask bits(m) */
 #define REG_GET_MASK(r, m)	(((r) & (m)) >> (ffs(m) - 1))
 /* set val(v) to mask bits(m) of register(r) */
 #define REG_SET_MASK(r, m, v)	(((r) & ~(m)) | \
 				 (((v) & (m >> (ffs(m) - 1))) << (ffs(m) - 1)))
 
+/* get dividend from the depth */
+#define THROT_DEPTH_DIVIDEND(depth)	((256 * (100 - (depth)) / 100) - 1)
+
+/* get THROT_PSKIP_xxx offset per LIGHT/HEAVY throt and CPU/GPU dev */
+#define THROT_OFFSET			0x30
+#define THROT_PSKIP_CTRL(throt, dev)	(THROT_PSKIP_CTRL_LITE_CPU + \
+					(THROT_OFFSET * throt) + (8 * dev))
+#define THROT_PSKIP_RAMP(throt, dev)	(THROT_PSKIP_RAMP_LITE_CPU + \
+					(THROT_OFFSET * throt) + (8 * dev))
+
+/* get THROT_xxx_CTRL offset per LIGHT/HEAVY throt */
+#define THROT_PRIORITY_CTRL(throt)	(THROT_PRIORITY_LITE + \
+					(THROT_OFFSET * throt))
+#define THROT_DELAY_CTRL(throt)		(THROT_DELAY_LITE + \
+					(THROT_OFFSET * throt))
+
+/* get THERMCTL_LEVELx offset per CPU/GPU/MEM/TSENSE rg and LEVEL0~3 lv */
+#define THERMCTL_LVL_REGS_SIZE		0x20
+#define THERMCTL_LVL_REG(rg, lv)	((rg) + ((lv) * THERMCTL_LVL_REGS_SIZE))
+
 static const int min_low_temp = -127000;
 static const int max_high_temp = 127000;
 
+enum soctherm_throttle_id {
+	THROTTLE_LIGHT = 0,
+	THROTTLE_HEAVY,
+	THROTTLE_SIZE,
+};
+
+enum soctherm_throttle_dev_id {
+	THROTTLE_DEV_CPU = 0,
+	THROTTLE_DEV_GPU,
+	THROTTLE_DEV_SIZE,
+};
+
+static const char *const throt_names[] = {
+	[THROTTLE_LIGHT] = "light",
+	[THROTTLE_HEAVY] = "heavy",
+};
+
+struct tegra_soctherm;
 struct tegra_thermctl_zone {
 	void __iomem *reg;
 	struct device *dev;
+	struct tegra_soctherm *ts;
 	struct thermal_zone_device *tz;
 	const struct tegra_tsensor_group *sg;
 };
 
+struct soctherm_throt_cfg {
+	const char *name;
+	unsigned int id;
+	u8 priority;
+	u32 cpu_throt_depth;
+	struct thermal_cooling_device *cdev;
+	bool init;
+};
+
 struct tegra_soctherm {
 	struct reset_control *reset;
 	struct clk *clock_tsensor;
 	struct clk *clock_soctherm;
 	void __iomem *regs;
-	struct thermal_zone_device **thermctl_tzs;
+	void __iomem *clk_regs;
 
 	u32 *calib;
+	struct thermal_zone_device **thermctl_tzs;
 	struct tegra_soctherm_soc *soc;
 
+	struct soctherm_throt_cfg throt_cfgs[THROTTLE_SIZE];
+
 	struct dentry *debugfs_dir;
 };
 
+/**
+ * clk_writel() - writes a value to a CAR register
+ * @ts: pointer to a struct tegra_soctherm
+ * @v: the value to write
+ * @reg: the register offset
+ *
+ * Writes @v to @reg.  No return value.
+ */
+static inline void clk_writel(struct tegra_soctherm *ts, u32 value, u32 reg)
+{
+	writel(value, (ts->clk_regs + reg));
+}
+
+/**
+ * clk_readl() - reads specified register from CAR IP block
+ * @ts: pointer to a struct tegra_soctherm
+ * @reg: register address to be read
+ *
+ * Return: the value of the register
+ */
+static inline u32 clk_readl(struct tegra_soctherm *ts, u32 reg)
+{
+	return readl(ts->clk_regs + reg);
+}
+
 static void enable_tsensor(struct tegra_soctherm *tegra, unsigned int i)
 {
 	const struct tegra_tsensor *sensor = &tegra->soc->tsensors[i];
@@ -150,11 +295,17 @@ static int tegra_thermctl_get_temp(void *data, int *out_temp)
 static int
 thermtrip_program(struct device *dev, const struct tegra_tsensor_group *sg,
 		  int trip_temp);
+static int
+throttrip_program(struct device *dev, const struct tegra_tsensor_group *sg,
+		  struct soctherm_throt_cfg *stc, int trip_temp);
+static struct soctherm_throt_cfg *
+find_throttle_cfg_by_name(struct tegra_soctherm *ts, const char *name);
 
 static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
 {
 	struct tegra_thermctl_zone *zone = data;
 	struct thermal_zone_device *tz = zone->tz;
+	struct tegra_soctherm *ts = zone->ts;
 	const struct tegra_tsensor_group *sg = zone->sg;
 	struct device *dev = zone->dev;
 	enum thermal_trip_type type;
@@ -167,10 +318,29 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
 	if (ret)
 		return ret;
 
-	if (type != THERMAL_TRIP_CRITICAL)
-		return 0;
+	if (type == THERMAL_TRIP_CRITICAL) {
+		return thermtrip_program(dev, sg, temp);
+	} else if (type == THERMAL_TRIP_HOT) {
+		int i;
+
+		for (i = 0; i < THROTTLE_SIZE; i++) {
+			struct thermal_cooling_device *cdev;
+			struct soctherm_throt_cfg *stc;
 
-	return thermtrip_program(dev, sg, temp);
+			if (!ts->throt_cfgs[i].init)
+				continue;
+
+			cdev = ts->throt_cfgs[i].cdev;
+			if (get_thermal_instance(tz, cdev, trip))
+				stc = find_throttle_cfg_by_name(ts, cdev->type);
+			else
+				continue;
+
+			return throttrip_program(dev, sg, stc, temp);
+		}
+	}
+
+	return 0;
 }
 
 static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
@@ -238,14 +408,110 @@ static int thermtrip_program(struct device *dev,
 }
 
 /**
+ * throttrip_program() - Configures the hardware to throttle the
+ * pulse if a given sensor group reaches a given temperature
+ * @dev: ptr to the struct device for the SOC_THERM IP block
+ * @sg: pointer to the sensor group to set the thermtrip temperature for
+ * @stc: pointer to the throttle need to be triggered
+ * @trip_temp: the temperature in millicelsius to trigger the thermal trip at
+ *
+ * Sets the thermal trip threshold and throttle event of the given sensor
+ * group. If this threshold is crossed, the hardware will trigger the
+ * throttle.
+ *
+ * Note that, although @trip_temp is specified in millicelsius, the
+ * hardware is programmed in degrees Celsius.
+ *
+ * Return: 0 upon success, or %-EINVAL upon failure.
+ */
+static int throttrip_program(struct device *dev,
+			     const struct tegra_tsensor_group *sg,
+			     struct soctherm_throt_cfg *stc,
+			     int trip_temp)
+{
+	struct tegra_soctherm *ts = dev_get_drvdata(dev);
+	int temp, cpu_throt, gpu_throt;
+	unsigned int throt;
+	u32 r, reg_off;
+
+	if (!dev || !sg || !stc || !stc->init)
+		return -EINVAL;
+
+	temp = enforce_temp_range(dev, trip_temp) / ts->soc->thresh_grain;
+
+	/* Hardcode LIGHT on LEVEL1 and HEAVY on LEVEL2 */
+	throt = stc->id;
+	reg_off = THERMCTL_LVL_REG(sg->thermctl_lvl0_offset, throt + 1);
+
+	if (throt == THROTTLE_LIGHT) {
+		cpu_throt = THERMCTL_LVL0_CPU0_CPU_THROT_LIGHT;
+		gpu_throt = THERMCTL_LVL0_CPU0_GPU_THROT_LIGHT;
+	} else {
+		cpu_throt = THERMCTL_LVL0_CPU0_CPU_THROT_HEAVY;
+		gpu_throt = THERMCTL_LVL0_CPU0_GPU_THROT_HEAVY;
+		if (throt != THROTTLE_HEAVY)
+			dev_warn(dev,
+				 "invalid throt id %d - assuming HEAVY",
+				 throt);
+	}
+
+	r = readl(ts->regs + reg_off);
+	r = REG_SET_MASK(r, sg->thermctl_lvl0_up_thresh_mask, temp);
+	r = REG_SET_MASK(r, sg->thermctl_lvl0_dn_thresh_mask, temp);
+	r = REG_SET_MASK(r, THERMCTL_LVL0_CPU0_CPU_THROT_MASK, cpu_throt);
+	r = REG_SET_MASK(r, THERMCTL_LVL0_CPU0_GPU_THROT_MASK, gpu_throt);
+	r = REG_SET_MASK(r, THERMCTL_LVL0_CPU0_EN_MASK, 1);
+	writel(r, ts->regs + reg_off);
+
+	return 0;
+}
+
+static struct soctherm_throt_cfg *
+find_throttle_cfg_by_name(struct tegra_soctherm *ts, const char *name)
+{
+	unsigned int i;
+
+	for (i = 0; ts->throt_cfgs[i].name; i++)
+		if (!strcmp(ts->throt_cfgs[i].name, name))
+			return &ts->throt_cfgs[i];
+
+	return NULL;
+}
+
+static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
+{
+	int ntrips, i, ret;
+	enum thermal_trip_type type;
+
+	ntrips = of_thermal_get_ntrips(tz);
+	if (ntrips <= 0)
+		return -EINVAL;
+
+	for (i = 0; i < ntrips; i++) {
+		ret = tz->ops->get_trip_type(tz, i, &type);
+		if (ret)
+			return -EINVAL;
+		if (type == THERMAL_TRIP_HOT) {
+			ret = tz->ops->get_trip_temp(tz, i, temp);
+			if (!ret)
+				*trip = i;
+
+			return ret;
+		}
+	}
+
+	return -EINVAL;
+}
+
+/**
  * tegra_soctherm_set_hwtrips() - set HW trip point from DT data
  * @dev: struct device * of the SOC_THERM instance
  *
  * Configure the SOC_THERM HW trip points, setting "THERMTRIP"
- * trip points , using "critical" type trip_temp from thermal
- * zone.
- * After they have been configured, THERMTRIP will take action
- * when the configured SoC thermal sensor group reaches a
+ * "THROTTLE" trip points , using "critical" or "hot" type trip_temp
+ * from thermal zone.
+ * After they have been configured, THERMTRIP or THROTTLE will take
+ * action when the configured SoC thermal sensor group reaches a
  * certain temperature.
  *
  * Return: 0 upon success, or a negative error code on failure.
@@ -254,19 +520,24 @@ static int thermtrip_program(struct device *dev,
  * THERMTRIP has been enabled successfully when a message similar to
  * this one appears on the serial console:
  * "thermtrip: will shut down when sensor group XXX reaches YYYYYY mC"
+ * THROTTLE has been enabled successfully when a message similar to
+ * this one appears on the serial console:
+ * ""throttrip: will throttle when sensor group XXX reaches YYYYYY mC"
  */
 static int tegra_soctherm_set_hwtrips(struct device *dev,
 				      const struct tegra_tsensor_group *sg,
 				      struct thermal_zone_device *tz)
 {
-	int temperature;
+	struct tegra_soctherm *ts = dev_get_drvdata(dev);
+	struct soctherm_throt_cfg *stc;
+	int i, trip, temperature;
 	int ret;
 
 	ret = tz->ops->get_crit_temp(tz, &temperature);
 	if (ret) {
 		dev_warn(dev, "thermtrip: %s: missing critical temperature\n",
 			 sg->name);
-		return ret;
+		goto set_throttle;
 	}
 
 	ret = thermtrip_program(dev, sg, temperature);
@@ -280,6 +551,46 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 		 "thermtrip: will shut down when %s reaches %d mC\n",
 		 sg->name, temperature);
 
+set_throttle:
+	if (ts->soc->use_ccroc)
+		return 0;
+
+	ret = get_hot_temp(tz, &trip, &temperature);
+	if (ret) {
+		dev_warn(dev, "throttle: %s: missing hot temperature\n",
+			 sg->name);
+		return 0;
+	}
+
+	for (i = 0; i < THROTTLE_SIZE; i++) {
+		struct thermal_cooling_device *cdev;
+
+		if (!ts->throt_cfgs[i].init)
+			continue;
+
+		cdev = ts->throt_cfgs[i].cdev;
+		if (get_thermal_instance(tz, cdev, trip))
+			stc = find_throttle_cfg_by_name(ts, cdev->type);
+		else
+			continue;
+
+		ret = throttrip_program(dev, sg, stc, temperature);
+		if (ret) {
+			dev_err(dev, "throttrip: %s: error during enable\n",
+				sg->name);
+			return ret;
+		}
+
+		dev_info(dev,
+			 "throttrip: will throttle when %s reaches %d mC\n",
+			 sg->name, temperature);
+		break;
+	}
+
+	if (i == THROTTLE_SIZE)
+		dev_warn(dev, "throttrip: %s: missing throttle cdev\n",
+			 sg->name);
+
 	return 0;
 }
 
@@ -291,7 +602,7 @@ static int regs_show(struct seq_file *s, void *data)
 	const struct tegra_tsensor *tsensors = ts->soc->tsensors;
 	const struct tegra_tsensor_group **ttgs = ts->soc->ttgs;
 	u32 r, state;
-	int i;
+	int i, level;
 
 	seq_puts(s, "-----TSENSE (convert HW)-----\n");
 
@@ -365,6 +676,84 @@ static int regs_show(struct seq_file *s, void *data)
 	state = REG_GET_MASK(r, SENSOR_TEMP2_MEM_TEMP_MASK);
 	seq_printf(s, " MEM(%d)\n", translate_temp(state));
 
+	if (ts->soc->use_ccroc)
+		return 0;
+
+	for (i = 0; i < ts->soc->num_ttgs; i++) {
+		seq_printf(s, "%s:\n", ttgs[i]->name);
+		for (level = 0; level < 4; level++) {
+			s32 v;
+			u32 mask;
+			u16 off = ttgs[i]->thermctl_lvl0_offset;
+
+			r = readl(ts->regs + THERMCTL_LVL_REG(off, level));
+
+			mask = ttgs[i]->thermctl_lvl0_up_thresh_mask;
+			state = REG_GET_MASK(r, mask);
+			v = sign_extend32(state, ts->soc->bptt - 1);
+			v *= ts->soc->thresh_grain;
+			seq_printf(s, "   %d: Up/Dn(%d /", level, v);
+
+			mask = ttgs[i]->thermctl_lvl0_dn_thresh_mask;
+			state = REG_GET_MASK(r, mask);
+			v = sign_extend32(state, ts->soc->bptt - 1);
+			v *= ts->soc->thresh_grain;
+			seq_printf(s, "%d ) ", v);
+
+			mask = THERMCTL_LVL0_CPU0_EN_MASK;
+			state = REG_GET_MASK(r, mask);
+			seq_printf(s, "En(%d) ", state);
+
+			mask = THERMCTL_LVL0_CPU0_CPU_THROT_MASK;
+			state = REG_GET_MASK(r, mask);
+			seq_puts(s, "CPU Throt");
+			if (!state)
+				seq_printf(s, "(%s) ", "none");
+			else if (state == THERMCTL_LVL0_CPU0_CPU_THROT_LIGHT)
+				seq_printf(s, "(%s) ", "L");
+			else if (state == THERMCTL_LVL0_CPU0_CPU_THROT_HEAVY)
+				seq_printf(s, "(%s) ", "H");
+			else
+				seq_printf(s, "(%s) ", "H+L");
+
+			mask = THERMCTL_LVL0_CPU0_GPU_THROT_MASK;
+			state = REG_GET_MASK(r, mask);
+			seq_puts(s, "GPU Throt");
+			if (!state)
+				seq_printf(s, "(%s) ", "none");
+			else if (state == THERMCTL_LVL0_CPU0_GPU_THROT_LIGHT)
+				seq_printf(s, "(%s) ", "L");
+			else if (state == THERMCTL_LVL0_CPU0_GPU_THROT_HEAVY)
+				seq_printf(s, "(%s) ", "H");
+			else
+				seq_printf(s, "(%s) ", "H+L");
+
+			mask = THERMCTL_LVL0_CPU0_STATUS_MASK;
+			state = REG_GET_MASK(r, mask);
+			seq_printf(s, "Status(%s)\n",
+				   state == 0 ? "LO" :
+				   state == 1 ? "In" :
+				   state == 2 ? "Res" : "HI");
+		}
+	}
+
+	r = readl(ts->regs + THERMCTL_STATS_CTL);
+	seq_printf(s, "STATS: Up(%s) Dn(%s)\n",
+		   r & STATS_CTL_EN_UP ? "En" : "--",
+		   r & STATS_CTL_EN_DN ? "En" : "--");
+
+	for (level = 0; level < 4; level++) {
+		u16 off;
+
+		off = THERMCTL_LVL0_UP_STATS;
+		r = readl(ts->regs + THERMCTL_LVL_REG(off, level));
+		seq_printf(s, "  Level_%d Up(%d) ", level, r);
+
+		off = THERMCTL_LVL0_DN_STATS;
+		r = readl(ts->regs + THERMCTL_LVL_REG(off, level));
+		seq_printf(s, "Dn(%d)\n", r);
+	}
+
 	r = readl(ts->regs + THERMCTL_THERMTRIP_CTL);
 	state = REG_GET_MASK(r, ttgs[0]->thermtrip_any_en_mask);
 	seq_printf(s, "Thermtrip Any En(%d)\n", state);
@@ -376,6 +765,27 @@ static int regs_show(struct seq_file *s, void *data)
 		seq_printf(s, "Thresh(%d)\n", state);
 	}
 
+	r = readl(ts->regs + THROT_GLOBAL_CFG);
+	seq_puts(s, "\n");
+	seq_printf(s, "GLOBAL THROTTLE CONFIG: 0x%08x\n", r);
+
+	seq_puts(s, "---------------------------------------------------\n");
+	r = readl(ts->regs + THROT_STATUS);
+	state = REG_GET_MASK(r, THROT_STATUS_BREACH_MASK);
+	seq_printf(s, "THROT STATUS: breach(%d) ", state);
+	state = REG_GET_MASK(r, THROT_STATUS_STATE_MASK);
+	seq_printf(s, "state(%d) ", state);
+	state = REG_GET_MASK(r, THROT_STATUS_ENABLED_MASK);
+	seq_printf(s, "enabled(%d)\n", state);
+
+	r = readl(ts->regs + CPU_PSKIP_STATUS);
+	state = REG_GET_MASK(r, XPU_PSKIP_STATUS_M_MASK);
+	seq_printf(s, "CPU PSKIP STATUS: M(%d) ", state);
+	state = REG_GET_MASK(r, XPU_PSKIP_STATUS_N_MASK);
+	seq_printf(s, "N(%d) ", state);
+	state = REG_GET_MASK(r, XPU_PSKIP_STATUS_ENABLED_MASK);
+	seq_printf(s, "enabled(%d)\n", state);
+
 	return 0;
 }
 
@@ -449,6 +859,203 @@ static int soctherm_clk_enable(struct platform_device *pdev, bool enable)
 	return 0;
 }
 
+static int throt_get_cdev_max_state(struct thermal_cooling_device *cdev,
+				    unsigned long *max_state)
+{
+	*max_state = 1;
+	return 0;
+}
+
+static int throt_get_cdev_cur_state(struct thermal_cooling_device *cdev,
+				    unsigned long *cur_state)
+{
+	struct tegra_soctherm *ts = cdev->devdata;
+	u32 r;
+
+	r = readl(ts->regs + THROT_STATUS);
+	if (REG_GET_MASK(r, THROT_STATUS_STATE_MASK))
+		*cur_state = 1;
+	else
+		*cur_state = 0;
+
+	return 0;
+}
+
+static int throt_set_cdev_state(struct thermal_cooling_device *cdev,
+				unsigned long cur_state)
+{
+	return 0;
+}
+
+static struct thermal_cooling_device_ops throt_cooling_ops = {
+	.get_max_state = throt_get_cdev_max_state,
+	.get_cur_state = throt_get_cdev_cur_state,
+	.set_cur_state = throt_set_cdev_state,
+};
+
+/**
+ * soctherm_init_hw_throt_cdev() - Parse the HW throttle configurations
+ * and register them as cooling devices.
+ */
+static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tegra_soctherm *ts = dev_get_drvdata(dev);
+	struct device_node *np_stc, *np_stcc;
+	const char *name;
+	u32 val;
+	int i, r;
+
+	for (i = 0; i < THROTTLE_SIZE; i++) {
+		ts->throt_cfgs[i].name = throt_names[i];
+		ts->throt_cfgs[i].id = i;
+		ts->throt_cfgs[i].init = false;
+	}
+
+	np_stc = of_get_child_by_name(dev->of_node, "throttle-cfgs");
+	if (!np_stc) {
+		dev_info(dev,
+			 "throttle-cfg: no throttle-cfgs - not enabling\n");
+		return;
+	}
+
+	for_each_child_of_node(np_stc, np_stcc) {
+		struct soctherm_throt_cfg *stc;
+		struct thermal_cooling_device *tcd;
+
+		name = np_stcc->name;
+		stc = find_throttle_cfg_by_name(ts, name);
+		if (!stc) {
+			dev_err(dev,
+				"throttle-cfg: could not find %s\n", name);
+			continue;
+		}
+
+		r = of_property_read_u32(np_stcc, "priority", &val);
+		if (r) {
+			dev_info(dev,
+				 "throttle-cfg: %s: missing priority\n", name);
+			continue;
+		}
+		stc->priority = val;
+
+		r = of_property_read_u32(np_stcc, "cpu-throt-depth", &val);
+		if (r) {
+			dev_info(dev,
+				 "throttle-cfg: %s: missing cpu_throt_depth\n",
+				 name);
+			continue;
+		}
+		stc->cpu_throt_depth = val;
+
+		tcd = thermal_of_cooling_device_register(np_stcc,
+							 (char *)name, ts,
+							 &throt_cooling_ops);
+		of_node_put(np_stcc);
+		if (IS_ERR_OR_NULL(tcd)) {
+			dev_err(dev,
+				"throttle-cfg: %s: failed to register cooling device\n",
+				name);
+			continue;
+		}
+
+		stc->cdev = tcd;
+		stc->init = true;
+	}
+
+	of_node_put(np_stc);
+}
+
+/**
+ * throttlectl_cpu_mn() - program CPU pulse skipper configuration
+ * @throt: the LIGHT/HEAVY of throttle event id
+ *
+ * Pulse skippers are used to throttle clock frequencies.  This
+ * function programs the pulse skippers based on @throt and platform
+ * data.  This function is used for CPUs that have "remote" pulse
+ * skipper control, e.g., the CPU pulse skipper is controlled by the
+ * SOC_THERM IP block.  (SOC_THERM is located outside the CPU
+ * complex.)
+ */
+static void throttlectl_cpu_mn(struct tegra_soctherm *ts,
+			       enum soctherm_throttle_id throt)
+{
+	u32 r;
+	int depth;
+	u8 dividend;
+
+	depth = ts->throt_cfgs[throt].cpu_throt_depth;
+	dividend = THROT_DEPTH_DIVIDEND(depth);
+
+	r = readl(ts->regs + THROT_PSKIP_CTRL(throt, THROTTLE_DEV_CPU));
+	r = REG_SET_MASK(r, THROT_PSKIP_CTRL_ENABLE_MASK, 1);
+	r = REG_SET_MASK(r, THROT_PSKIP_CTRL_DIVIDEND_MASK, dividend);
+	r = REG_SET_MASK(r, THROT_PSKIP_CTRL_DIVISOR_MASK, 0xff);
+	writel(r, ts->regs + THROT_PSKIP_CTRL(throt, THROTTLE_DEV_CPU));
+
+	r = readl(ts->regs + THROT_PSKIP_RAMP(throt, THROTTLE_DEV_CPU));
+	r = REG_SET_MASK(r, THROT_PSKIP_RAMP_DURATION_MASK, 0xff);
+	r = REG_SET_MASK(r, THROT_PSKIP_RAMP_STEP_MASK, 0xf);
+	writel(r, ts->regs + THROT_PSKIP_RAMP(throt, THROTTLE_DEV_CPU));
+}
+
+/**
+ * soctherm_throttle_program() - programs pulse skippers' configuration
+ * @throt: the LIGHT/HEAVY of the throttle event id.
+ *
+ * Pulse skippers are used to throttle clock frequencies.
+ * This function programs the pulse skippers.
+ */
+static void soctherm_throttle_program(struct tegra_soctherm *ts,
+				      enum soctherm_throttle_id throt)
+{
+	u32 r;
+	struct soctherm_throt_cfg stc = ts->throt_cfgs[throt];
+
+	if (!stc.init)
+		return;
+
+	/* Setup PSKIP parameters */
+	throttlectl_cpu_mn(ts, throt);
+
+	r = REG_SET_MASK(0, THROT_PRIORITY_LITE_PRIO_MASK, stc.priority);
+	writel(r, ts->regs + THROT_PRIORITY_CTRL(throt));
+
+	r = REG_SET_MASK(0, THROT_DELAY_LITE_DELAY_MASK, 0);
+	writel(r, ts->regs + THROT_DELAY_CTRL(throt));
+
+	r = readl(ts->regs + THROT_PRIORITY_LOCK);
+	r = REG_GET_MASK(r, THROT_PRIORITY_LOCK_PRIORITY_MASK);
+	if (r >= stc.priority)
+		return;
+	r = REG_SET_MASK(0, THROT_PRIORITY_LOCK_PRIORITY_MASK,
+			 stc.priority);
+	writel(r, ts->regs + THROT_PRIORITY_LOCK);
+}
+
+static void tegra_soctherm_throttle(struct device *dev)
+{
+	struct tegra_soctherm *ts = dev_get_drvdata(dev);
+	u32 v;
+	int i;
+
+	/* Thermal HW throttle programming */
+	for (i = 0; i < THROTTLE_SIZE; i++)
+		soctherm_throttle_program(ts, i);
+
+	v = REG_SET_MASK(0, THROT_GLOBAL_ENB_MASK, 1);
+	writel(v, ts->regs + THROT_GLOBAL_CFG);
+
+	v = clk_readl(ts, CAR_SUPER_CCLKG_DIVIDER);
+	v = REG_SET_MASK(v, CDIVG_USE_THERM_CONTROLS_MASK, 1);
+	clk_writel(ts, v, CAR_SUPER_CCLKG_DIVIDER);
+
+	/* initialize stats collection */
+	v = STATS_CTL_CLR_DN | STATS_CTL_EN_DN |
+	    STATS_CTL_CLR_UP | STATS_CTL_EN_UP;
+	writel(v, ts->regs + THERMCTL_STATS_CTL);
+}
+
 static void soctherm_init(struct platform_device *pdev)
 {
 	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
@@ -475,6 +1082,12 @@ static void soctherm_init(struct platform_device *pdev)
 	}
 	writel(pdiv, tegra->regs + SENSOR_PDIV);
 	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);
+
+	if (tegra->soc->use_ccroc)
+		return;
+
+	/* Configure hw throttle */
+	tegra_soctherm_throttle(&pdev->dev);
 }
 
 static const struct of_device_id tegra_soctherm_of_match[] = {
@@ -527,10 +1140,23 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 
 	tegra->soc = soc;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "soctherm-reg");
 	tegra->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(tegra->regs))
+	if (IS_ERR(tegra->regs)) {
+		dev_err(&pdev->dev, "can't get soctherm registers");
 		return PTR_ERR(tegra->regs);
+	}
+
+	if (!tegra->soc->use_ccroc) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "car-reg");
+		tegra->clk_regs = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(tegra->clk_regs)) {
+			dev_err(&pdev->dev, "can't get car clk registers");
+			return PTR_ERR(tegra->clk_regs);
+		}
+	}
 
 	tegra->reset = devm_reset_control_get(&pdev->dev, "soctherm");
 	if (IS_ERR(tegra->reset)) {
@@ -580,6 +1206,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	if (!tegra->soc->use_ccroc)
+		soctherm_init_hw_throt_cdev(pdev);
+
 	soctherm_init(pdev);
 
 	for (i = 0; i < soc->num_ttgs; ++i) {
@@ -593,6 +1222,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		zone->reg = tegra->regs + soc->ttgs[i]->sensor_temp_offset;
 		zone->dev = &pdev->dev;
 		zone->sg = soc->ttgs[i];
+		zone->ts = tegra;
 
 		z = devm_thermal_zone_of_sensor_register(&pdev->dev,
 							 soc->ttgs[i]->id, zone,
@@ -608,7 +1238,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		tegra->thermctl_tzs[soc->ttgs[i]->id] = z;
 
 		/* Configure hw trip points */
-		tegra_soctherm_set_hwtrips(&pdev->dev, soc->ttgs[i], z);
+		err = tegra_soctherm_set_hwtrips(&pdev->dev, soc->ttgs[i], z);
+		if (err)
+			goto disable_clocks;
 	}
 
 	soctherm_debug_init(pdev);
@@ -661,7 +1293,12 @@ static int __maybe_unused soctherm_resume(struct device *dev)
 		struct thermal_zone_device *tz;
 
 		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
-		tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
+		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
+		if (err) {
+			dev_err(&pdev->dev,
+				"Resume failed: set hwtrips failed\n");
+			return err;
+		}
 	}
 
 	return 0;
diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soctherm.h
index 28e18ec4b4c3..e96ca73fd780 100644
--- a/drivers/thermal/tegra/soctherm.h
+++ b/drivers/thermal/tegra/soctherm.h
@@ -15,6 +15,11 @@
 #ifndef __DRIVERS_THERMAL_TEGRA_SOCTHERM_H
 #define __DRIVERS_THERMAL_TEGRA_SOCTHERM_H
 
+#define THERMCTL_LEVEL0_GROUP_CPU               0x0
+#define THERMCTL_LEVEL0_GROUP_GPU		0x4
+#define THERMCTL_LEVEL0_GROUP_MEM		0x8
+#define THERMCTL_LEVEL0_GROUP_TSENSE		0xc
+
 #define SENSOR_CONFIG2                          8
 #define SENSOR_CONFIG2_THERMA_MASK		(0xffff << 16)
 #define SENSOR_CONFIG2_THERMA_SHIFT		16
@@ -65,6 +70,9 @@ struct tegra_tsensor_group {
 	u32 thermtrip_enable_mask;
 	u32 thermtrip_any_en_mask;
 	u32 thermtrip_threshold_mask;
+	u16 thermctl_lvl0_offset;
+	u32 thermctl_lvl0_up_thresh_mask;
+	u32 thermctl_lvl0_dn_thresh_mask;
 };
 
 struct tegra_tsensor_configuration {
@@ -103,6 +111,8 @@ struct tegra_soctherm_soc {
 	const unsigned int num_ttgs;
 	const struct tegra_soctherm_fuse *tfuse;
 	const int thresh_grain;
+	const unsigned int bptt;
+	const bool use_ccroc;
 };
 
 int tegra_calc_shared_calib(const struct tegra_soctherm_fuse *tfuse,
diff --git a/drivers/thermal/tegra/tegra124-soctherm.c b/drivers/thermal/tegra/tegra124-soctherm.c
index beb9d36b9c8a..36768630f78c 100644
--- a/drivers/thermal/tegra/tegra124-soctherm.c
+++ b/drivers/thermal/tegra/tegra124-soctherm.c
@@ -28,7 +28,11 @@
 #define TEGRA124_THERMTRIP_CPU_THRESH_MASK	(0xff << 8)
 #define TEGRA124_THERMTRIP_TSENSE_THRESH_MASK	0xff
 
+#define TEGRA124_THERMCTL_LVL0_UP_THRESH_MASK	(0xff << 17)
+#define TEGRA124_THERMCTL_LVL0_DN_THRESH_MASK	(0xff << 9)
+
 #define TEGRA124_THRESH_GRAIN			1000
+#define TEGRA124_BPTT				8
 
 static const struct tegra_tsensor_configuration tegra124_tsensor_config = {
 	.tall = 16300,
@@ -51,6 +55,9 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_cpu = {
 	.thermtrip_any_en_mask = TEGRA124_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA124_THERMTRIP_CPU_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA124_THERMTRIP_CPU_THRESH_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_CPU,
+	.thermctl_lvl0_up_thresh_mask = TEGRA124_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA124_THERMCTL_LVL0_DN_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group tegra124_tsensor_group_gpu = {
@@ -66,6 +73,9 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_gpu = {
 	.thermtrip_any_en_mask = TEGRA124_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA124_THERMTRIP_GPU_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA124_THERMTRIP_GPUMEM_THRESH_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_GPU,
+	.thermctl_lvl0_up_thresh_mask = TEGRA124_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA124_THERMCTL_LVL0_DN_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group tegra124_tsensor_group_pll = {
@@ -79,6 +89,9 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_pll = {
 	.thermtrip_any_en_mask = TEGRA124_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA124_THERMTRIP_TSENSE_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA124_THERMTRIP_TSENSE_THRESH_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_TSENSE,
+	.thermctl_lvl0_up_thresh_mask = TEGRA124_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA124_THERMCTL_LVL0_DN_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group tegra124_tsensor_group_mem = {
@@ -94,6 +107,9 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_mem = {
 	.thermtrip_any_en_mask = TEGRA124_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA124_THERMTRIP_MEM_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA124_THERMTRIP_GPUMEM_THRESH_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_MEM,
+	.thermctl_lvl0_up_thresh_mask = TEGRA124_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA124_THERMCTL_LVL0_DN_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group *tegra124_tsensor_groups[] = {
@@ -193,4 +209,6 @@ const struct tegra_soctherm_soc tegra124_soctherm = {
 	.num_ttgs = ARRAY_SIZE(tegra124_tsensor_groups),
 	.tfuse = &tegra124_soctherm_fuse,
 	.thresh_grain = TEGRA124_THRESH_GRAIN,
+	.bptt = TEGRA124_BPTT,
+	.use_ccroc = false,
 };
diff --git a/drivers/thermal/tegra/tegra132-soctherm.c b/drivers/thermal/tegra/tegra132-soctherm.c
index e2aa84e1b307..ae5d61af2df3 100644
--- a/drivers/thermal/tegra/tegra132-soctherm.c
+++ b/drivers/thermal/tegra/tegra132-soctherm.c
@@ -193,4 +193,5 @@ const struct tegra_soctherm_soc tegra132_soctherm = {
 	.num_ttgs = ARRAY_SIZE(tegra132_tsensor_groups),
 	.tfuse = &tegra132_soctherm_fuse,
 	.thresh_grain = TEGRA132_THRESH_GRAIN,
+	.use_ccroc = true,
 };
diff --git a/drivers/thermal/tegra/tegra210-soctherm.c b/drivers/thermal/tegra/tegra210-soctherm.c
index 19cc0ab66f0e..ad53169a8e95 100644
--- a/drivers/thermal/tegra/tegra210-soctherm.c
+++ b/drivers/thermal/tegra/tegra210-soctherm.c
@@ -29,7 +29,11 @@
 #define TEGRA210_THERMTRIP_CPU_THRESH_MASK	(0x1ff << 9)
 #define TEGRA210_THERMTRIP_TSENSE_THRESH_MASK	0x1ff
 
+#define TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK	(0x1ff << 18)
+#define TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK	(0x1ff << 9)
+
 #define TEGRA210_THRESH_GRAIN			500
+#define TEGRA210_BPTT				9
 
 static const struct tegra_tsensor_configuration tegra210_tsensor_config = {
 	.tall = 16300,
@@ -52,6 +56,9 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_cpu = {
 	.thermtrip_any_en_mask = TEGRA210_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA210_THERMTRIP_CPU_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA210_THERMTRIP_CPU_THRESH_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_CPU,
+	.thermctl_lvl0_up_thresh_mask = TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group tegra210_tsensor_group_gpu = {
@@ -67,6 +74,9 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_gpu = {
 	.thermtrip_any_en_mask = TEGRA210_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA210_THERMTRIP_GPU_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA210_THERMTRIP_GPUMEM_THRESH_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_GPU,
+	.thermctl_lvl0_up_thresh_mask = TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group tegra210_tsensor_group_pll = {
@@ -80,6 +90,9 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_pll = {
 	.thermtrip_any_en_mask = TEGRA210_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA210_THERMTRIP_TSENSE_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA210_THERMTRIP_TSENSE_THRESH_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_TSENSE,
+	.thermctl_lvl0_up_thresh_mask = TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group tegra210_tsensor_group_mem = {
@@ -95,6 +108,9 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_mem = {
 	.thermtrip_any_en_mask = TEGRA210_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA210_THERMTRIP_MEM_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA210_THERMTRIP_GPUMEM_THRESH_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_MEM,
+	.thermctl_lvl0_up_thresh_mask = TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group *tegra210_tsensor_groups[] = {
@@ -194,4 +210,6 @@ const struct tegra_soctherm_soc tegra210_soctherm = {
 	.num_ttgs = ARRAY_SIZE(tegra210_tsensor_groups),
 	.tfuse = &tegra210_soctherm_fuse,
 	.thresh_grain = TEGRA210_THRESH_GRAIN,
+	.bptt = TEGRA210_BPTT,
+	.use_ccroc = false,
 };
-- 
1.9.1
