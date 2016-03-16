From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V8 09/14] thermal: tegra: add thermtrip function
Date: Wed, 16 Mar 2016 16:58:15 +0800
Message-ID: <1458118695-29950-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add support for hardware critical thermal limits to the
SOC_THERM driver. It use the Linux thermal framework to
create critical trip temp, and set it to SOC_THERM hardware.
If these limits are breached, the chip will reset, and if
appropriately configured, will turn off the PMIC.

This support is critical for safe usage of the chip.

Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/thermal/tegra/soctherm.c          | 166 +++++++++++++++++++++++++++++-
 drivers/thermal/tegra/soctherm.h          |   7 ++
 drivers/thermal/tegra/tegra124-soctherm.c |  24 +++++
 drivers/thermal/tegra/tegra210-soctherm.c |  24 +++++
 4 files changed, 216 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index bb682acc6a89..67e4a094b430 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -73,9 +73,14 @@
 #define REG_SET_MASK(r, m, v)	(((r) & ~(m)) | \
 				 (((v) & (m >> (ffs(m) - 1))) << (ffs(m) - 1)))
 
+static const int min_low_temp = -127000;
+static const int max_high_temp = 127000;
+
 struct tegra_thermctl_zone {
 	void __iomem *reg;
-	u32 mask;
+	struct device *dev;
+	struct thermal_zone_device *tz;
+	const struct tegra_tsensor_group *sg;
 };
 
 struct tegra_soctherm {
@@ -145,22 +150,158 @@ static int tegra_thermctl_get_temp(void *data, int *out_temp)
 	u32 val;
 
 	val = readl(zone->reg);
-	val = REG_GET_MASK(val, zone->mask);
+	val = REG_GET_MASK(val, zone->sg->sensor_temp_mask);
 	*out_temp = translate_temp(val);
 
 	return 0;
 }
 
+static int
+thermtrip_program(struct device *dev, const struct tegra_tsensor_group *sg,
+		  int trip_temp);
+
+static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
+{
+	struct tegra_thermctl_zone *zone = data;
+	struct thermal_zone_device *tz = zone->tz;
+	const struct tegra_tsensor_group *sg = zone->sg;
+	struct device *dev = zone->dev;
+	enum thermal_trip_type type;
+	int ret;
+
+	if (!tz)
+		return -EINVAL;
+
+	ret = tz->ops->get_trip_type(tz, trip, &type);
+	if (ret)
+		return ret;
+
+	if (type != THERMAL_TRIP_CRITICAL)
+		return 0;
+
+	return thermtrip_program(dev, sg, temp);
+}
+
 static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
 	.get_temp = tegra_thermctl_get_temp,
+	.set_trip_temp = tegra_thermctl_set_trip_temp,
 };
 
+/**
+ * enforce_temp_range() - check and enforce temperature range [min, max]
+ * @trip_temp: the trip temperature to check
+ *
+ * Checks and enforces the permitted temperature range that SOC_THERM
+ * HW can support This is
+ * done while taking care of precision.
+ *
+ * Return: The precision adjusted capped temperature in millicelsius.
+ */
+static int enforce_temp_range(struct device *dev, int trip_temp)
+{
+	int temp;
+
+	temp = clamp_val(trip_temp, min_low_temp, max_high_temp);
+	if (temp != trip_temp)
+		dev_info(dev, "soctherm: trip temperature %d forced to %d\n",
+			 trip_temp, temp);
+	return temp;
+}
+
+/**
+ * thermtrip_program() - Configures the hardware to shut down the
+ * system if a given sensor group reaches a given temperature
+ * @dev: ptr to the struct device for the SOC_THERM IP block
+ * @sg: pointer to the sensor group to set the thermtrip temperature for
+ * @trip_temp: the temperature in millicelsius to trigger the thermal trip at
+ *
+ * Sets the thermal trip threshold of the given sensor group to be the
+ * @trip_temp.  If this threshold is crossed, the hardware will shut
+ * down.
+ *
+ * Note that, although @trip_temp is specified in millicelsius, the
+ * hardware is programmed in degrees Celsius.
+ *
+ * Return: 0 upon success, or %-EINVAL upon failure.
+ */
+static int thermtrip_program(struct device *dev,
+			     const struct tegra_tsensor_group *sg,
+			     int trip_temp)
+{
+	struct tegra_soctherm *ts = dev_get_drvdata(dev);
+	int temp;
+	u32 r;
+
+	if (!dev || !sg)
+		return -EINVAL;
+
+	if (!sg->thermtrip_threshold_mask)
+		return -EINVAL;
+
+	temp = enforce_temp_range(dev, trip_temp) / ts->soc->thresh_grain;
+
+	r = readl(ts->regs + THERMCTL_THERMTRIP_CTL);
+	r = REG_SET_MASK(r, sg->thermtrip_threshold_mask, temp);
+	r = REG_SET_MASK(r, sg->thermtrip_enable_mask, 1);
+	r = REG_SET_MASK(r, sg->thermtrip_any_en_mask, 0);
+	writel(r, ts->regs + THERMCTL_THERMTRIP_CTL);
+
+	return 0;
+}
+
+/**
+ * tegra_soctherm_set_hwtrips() - set HW trip point from DT data
+ * @dev: struct device * of the SOC_THERM instance
+ *
+ * Configure the SOC_THERM HW trip points, setting "THERMTRIP"
+ * trip points , using "critical" type trip_temp from thermal
+ * zone.
+ * After they have been configured, THERMTRIP will take action
+ * when the configured SoC thermal sensor group reaches a
+ * certain temperature.
+ *
+ * Return: 0 upon success, or a negative error code on failure.
+ * "Success" does not mean that trips was enabled; it could also
+ * mean that no node was found in DT.
+ * THERMTRIP has been enabled successfully when a message similar to
+ * this one appears on the serial console:
+ * "thermtrip: will shut down when sensor group XXX reaches YYYYYY mC"
+ */
+static int tegra_soctherm_set_hwtrips(struct device *dev,
+				      const struct tegra_tsensor_group *sg,
+				      struct thermal_zone_device *tz)
+{
+	int temperature;
+	int ret;
+
+	ret = tz->ops->get_crit_temp(tz, &temperature);
+	if (ret) {
+		dev_warn(dev, "thermtrip: %s: missing critical temperature\n",
+			sg->name);
+		return ret;
+	}
+
+	ret = thermtrip_program(dev, sg, temperature);
+	if (ret) {
+		dev_err(dev, "thermtrip: %s: error during enable\n",
+			sg->name);
+		return ret;
+	}
+
+	dev_info(dev,
+		 "thermtrip: will shut down when %s reaches %d mC\n",
+		 sg->name, temperature);
+
+	return 0;
+}
+
 #ifdef CONFIG_DEBUG_FS
 static int regs_show(struct seq_file *s, void *data)
 {
 	struct platform_device *pdev = s->private;
 	struct tegra_soctherm *ts = platform_get_drvdata(pdev);
 	const struct tegra_tsensor *tsensors = ts->soc->tsensors;
+	const struct tegra_tsensor_group **ttgs = ts->soc->ttgs;
 	u32 r, state;
 	int i;
 
@@ -236,6 +377,17 @@ static int regs_show(struct seq_file *s, void *data)
 	state = REG_GET_MASK(r, SENSOR_TEMP2_MEM_TEMP_MASK);
 	seq_printf(s, " MEM(%d)\n", translate_temp(state));
 
+	r = readl(ts->regs + THERMCTL_THERMTRIP_CTL);
+	state = REG_GET_MASK(r, ttgs[0]->thermtrip_any_en_mask);
+	seq_printf(s, "Thermtrip Any En(%d)\n", state);
+	for (i = 0; i < ts->soc->num_ttgs; i++) {
+		state = REG_GET_MASK(r, ttgs[i]->thermtrip_enable_mask);
+		seq_printf(s, "     %s En(%d) ", ttgs[i]->name, state);
+		state = REG_GET_MASK(r, ttgs[i]->thermtrip_threshold_mask);
+		state *= ts->soc->thresh_grain;
+		seq_printf(s, "Thresh(%d)\n", state);
+	}
+
 	return 0;
 }
 
@@ -394,8 +546,6 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	writel(pdiv, tegra->regs + SENSOR_PDIV);
 	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);
 
-	/* Initialize thermctl sensors */
-
 	for (i = 0; i < soc->num_ttgs; ++i) {
 		struct tegra_thermctl_zone *zone =
 			devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);
@@ -405,7 +555,8 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		}
 
 		zone->reg = tegra->regs + soc->ttgs[i]->sensor_temp_offset;
-		zone->mask = soc->ttgs[i]->sensor_temp_mask;
+		zone->dev = &pdev->dev;
+		zone->sg = soc->ttgs[i];
 
 		z = devm_thermal_zone_of_sensor_register(&pdev->dev,
 							 soc->ttgs[i]->id, zone,
@@ -416,6 +567,11 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 				err);
 			goto disable_clocks;
 		}
+
+		zone->tz = z;
+
+		/* Configure hw trip points */
+		tegra_soctherm_set_hwtrips(&pdev->dev, soc->ttgs[i], z);
 	}
 
 	soctherm_debug_init(pdev);
diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soctherm.h
index ec4b87616d01..f6dbbba80367 100644
--- a/drivers/thermal/tegra/soctherm.h
+++ b/drivers/thermal/tegra/soctherm.h
@@ -21,6 +21,9 @@
 #define SENSOR_CONFIG2_THERMB_MASK		0xffff
 #define SENSOR_CONFIG2_THERMB_SHIFT		0
 
+#define THERMCTL_THERMTRIP_CTL			0x80
+/* BITs are defined in device file */
+
 #define SENSOR_PDIV				0x1c0
 #define SENSOR_PDIV_CPU_MASK			(0xf << 12)
 #define SENSOR_PDIV_GPU_MASK			(0xf << 8)
@@ -59,6 +62,9 @@ struct tegra_tsensor_group {
 	u32 sensor_temp_mask;
 	u32 pdiv, pdiv_ate, pdiv_mask;
 	u32 pllx_hotspot_diff, pllx_hotspot_mask;
+	u32 thermtrip_enable_mask;
+	u32 thermtrip_any_en_mask;
+	u32 thermtrip_threshold_mask;
 };
 
 struct tegra_tsensor_configuration {
@@ -96,6 +102,7 @@ struct tegra_soctherm_soc {
 	const struct tegra_tsensor_group **ttgs;
 	const unsigned int num_ttgs;
 	const struct tegra_soctherm_fuse *tfuse;
+	const int thresh_grain;
 };
 
 int tegra_calc_shared_calib(const struct tegra_soctherm_fuse *tfuse,
diff --git a/drivers/thermal/tegra/tegra124-soctherm.c b/drivers/thermal/tegra/tegra124-soctherm.c
index 06aad13a979f..beb9d36b9c8a 100644
--- a/drivers/thermal/tegra/tegra124-soctherm.c
+++ b/drivers/thermal/tegra/tegra124-soctherm.c
@@ -19,6 +19,17 @@
 
 #include "soctherm.h"
 
+#define TEGRA124_THERMTRIP_ANY_EN_MASK		(0x1 << 28)
+#define TEGRA124_THERMTRIP_MEM_EN_MASK		(0x1 << 27)
+#define TEGRA124_THERMTRIP_GPU_EN_MASK		(0x1 << 26)
+#define TEGRA124_THERMTRIP_CPU_EN_MASK		(0x1 << 25)
+#define TEGRA124_THERMTRIP_TSENSE_EN_MASK	(0x1 << 24)
+#define TEGRA124_THERMTRIP_GPUMEM_THRESH_MASK	(0xff << 16)
+#define TEGRA124_THERMTRIP_CPU_THRESH_MASK	(0xff << 8)
+#define TEGRA124_THERMTRIP_TSENSE_THRESH_MASK	0xff
+
+#define TEGRA124_THRESH_GRAIN			1000
+
 static const struct tegra_tsensor_configuration tegra124_tsensor_config = {
 	.tall = 16300,
 	.tiddq_en = 1,
@@ -37,6 +48,9 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_cpu = {
 	.pdiv_mask = SENSOR_PDIV_CPU_MASK,
 	.pllx_hotspot_diff = 10,
 	.pllx_hotspot_mask = SENSOR_HOTSPOT_CPU_MASK,
+	.thermtrip_any_en_mask = TEGRA124_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA124_THERMTRIP_CPU_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA124_THERMTRIP_CPU_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group tegra124_tsensor_group_gpu = {
@@ -49,6 +63,9 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_gpu = {
 	.pdiv_mask = SENSOR_PDIV_GPU_MASK,
 	.pllx_hotspot_diff = 5,
 	.pllx_hotspot_mask = SENSOR_HOTSPOT_GPU_MASK,
+	.thermtrip_any_en_mask = TEGRA124_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA124_THERMTRIP_GPU_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA124_THERMTRIP_GPUMEM_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group tegra124_tsensor_group_pll = {
@@ -59,6 +76,9 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_pll = {
 	.pdiv = 8,
 	.pdiv_ate = 8,
 	.pdiv_mask = SENSOR_PDIV_PLLX_MASK,
+	.thermtrip_any_en_mask = TEGRA124_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA124_THERMTRIP_TSENSE_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA124_THERMTRIP_TSENSE_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group tegra124_tsensor_group_mem = {
@@ -71,6 +91,9 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_mem = {
 	.pdiv_mask = SENSOR_PDIV_MEM_MASK,
 	.pllx_hotspot_diff = 0,
 	.pllx_hotspot_mask = SENSOR_HOTSPOT_MEM_MASK,
+	.thermtrip_any_en_mask = TEGRA124_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA124_THERMTRIP_MEM_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA124_THERMTRIP_GPUMEM_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group *tegra124_tsensor_groups[] = {
@@ -169,4 +192,5 @@ const struct tegra_soctherm_soc tegra124_soctherm = {
 	.ttgs = tegra124_tsensor_groups,
 	.num_ttgs = ARRAY_SIZE(tegra124_tsensor_groups),
 	.tfuse = &tegra124_soctherm_fuse,
+	.thresh_grain = TEGRA124_THRESH_GRAIN,
 };
diff --git a/drivers/thermal/tegra/tegra210-soctherm.c b/drivers/thermal/tegra/tegra210-soctherm.c
index 0e76a89c557d..19cc0ab66f0e 100644
--- a/drivers/thermal/tegra/tegra210-soctherm.c
+++ b/drivers/thermal/tegra/tegra210-soctherm.c
@@ -20,6 +20,17 @@
 
 #include "soctherm.h"
 
+#define TEGRA210_THERMTRIP_ANY_EN_MASK		(0x1 << 31)
+#define TEGRA210_THERMTRIP_MEM_EN_MASK		(0x1 << 30)
+#define TEGRA210_THERMTRIP_GPU_EN_MASK		(0x1 << 29)
+#define TEGRA210_THERMTRIP_CPU_EN_MASK		(0x1 << 28)
+#define TEGRA210_THERMTRIP_TSENSE_EN_MASK	(0x1 << 27)
+#define TEGRA210_THERMTRIP_GPUMEM_THRESH_MASK	(0x1ff << 18)
+#define TEGRA210_THERMTRIP_CPU_THRESH_MASK	(0x1ff << 9)
+#define TEGRA210_THERMTRIP_TSENSE_THRESH_MASK	0x1ff
+
+#define TEGRA210_THRESH_GRAIN			500
+
 static const struct tegra_tsensor_configuration tegra210_tsensor_config = {
 	.tall = 16300,
 	.tiddq_en = 1,
@@ -38,6 +49,9 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_cpu = {
 	.pdiv_mask = SENSOR_PDIV_CPU_MASK,
 	.pllx_hotspot_diff = 10,
 	.pllx_hotspot_mask = SENSOR_HOTSPOT_CPU_MASK,
+	.thermtrip_any_en_mask = TEGRA210_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA210_THERMTRIP_CPU_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA210_THERMTRIP_CPU_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group tegra210_tsensor_group_gpu = {
@@ -50,6 +64,9 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_gpu = {
 	.pdiv_mask = SENSOR_PDIV_GPU_MASK,
 	.pllx_hotspot_diff = 5,
 	.pllx_hotspot_mask = SENSOR_HOTSPOT_GPU_MASK,
+	.thermtrip_any_en_mask = TEGRA210_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA210_THERMTRIP_GPU_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA210_THERMTRIP_GPUMEM_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group tegra210_tsensor_group_pll = {
@@ -60,6 +77,9 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_pll = {
 	.pdiv = 8,
 	.pdiv_ate = 8,
 	.pdiv_mask = SENSOR_PDIV_PLLX_MASK,
+	.thermtrip_any_en_mask = TEGRA210_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA210_THERMTRIP_TSENSE_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA210_THERMTRIP_TSENSE_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group tegra210_tsensor_group_mem = {
@@ -72,6 +92,9 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_mem = {
 	.pdiv_mask = SENSOR_PDIV_MEM_MASK,
 	.pllx_hotspot_diff = 0,
 	.pllx_hotspot_mask = SENSOR_HOTSPOT_MEM_MASK,
+	.thermtrip_any_en_mask = TEGRA210_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA210_THERMTRIP_MEM_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA210_THERMTRIP_GPUMEM_THRESH_MASK,
 };
 
 static const struct tegra_tsensor_group *tegra210_tsensor_groups[] = {
@@ -170,4 +193,5 @@ const struct tegra_soctherm_soc tegra210_soctherm = {
 	.ttgs = tegra210_tsensor_groups,
 	.num_ttgs = ARRAY_SIZE(tegra210_tsensor_groups),
 	.tfuse = &tegra210_soctherm_fuse,
+	.thresh_grain = TEGRA210_THRESH_GRAIN,
 };
-- 
1.9.1
