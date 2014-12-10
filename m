From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 07/17] thermal: cpu_cooling: Modify exynos thermal code to
 use device tree for cpu cooling configuration
Date: Wed, 10 Dec 2014 13:09:46 +0100
Message-ID: <1418213396-743-8-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Up till now exynos_tmu_data.c was used for storing CPU cooling configuration
data. Now the Exynos thermal core code uses device tree to get this data.
For this purpose generic thermal code for configuring CPU cooling was
used.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- None
---
 drivers/cpufreq/exynos-cpufreq.c                |  23 ++++-
 drivers/thermal/samsung/exynos_thermal_common.c | 122 ++++++++++++++----------
 drivers/thermal/samsung/exynos_tmu.c            |   7 --
 drivers/thermal/samsung/exynos_tmu.h            |   5 -
 drivers/thermal/samsung/exynos_tmu_data.c       |  42 +-------
 5 files changed, 94 insertions(+), 105 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 1e0ec57..fdedb8d 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -18,10 +18,13 @@
 #include <linux/cpufreq.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/cpu_cooling.h>
+#include <linux/cpu.h>
 
 #include "exynos-cpufreq.h"
 
 static struct exynos_dvfs_info *exynos_info;
+static struct thermal_cooling_device *cdev;
 static struct regulator *arm_regulator;
 static unsigned int locking_frequency;
 
@@ -156,6 +159,7 @@ static struct cpufreq_driver exynos_driver = {
 
 static int exynos_cpufreq_probe(struct platform_device *pdev)
 {
+	struct device_node *np;
 	int ret = -EINVAL;
 
 	exynos_info = kzalloc(sizeof(*exynos_info), GFP_KERNEL);
@@ -198,9 +202,24 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 	/* Done here as we want to capture boot frequency */
 	locking_frequency = clk_get_rate(exynos_info->cpu_clk) / 1000;
 
-	if (!cpufreq_register_driver(&exynos_driver))
-		return 0;
+	if (cpufreq_register_driver(&exynos_driver))
+		goto err;
 
+	np = of_find_node_by_path("/cpus/cpu@0");
+	if (!np) {
+		pr_err("failed to find cpu0 node\n");
+		return -ENOENT;
+	}
+	if (of_find_property(np, "#cooling-cells", NULL)) {
+		cdev = of_cpufreq_cooling_register(np, cpu_present_mask);
+		if (IS_ERR(cdev))
+			pr_err("running cpufreq without cooling device: %ld\n",
+			       PTR_ERR(cdev));
+	}
+	of_node_put(np);
+
+	return 0;
+ err:
 	dev_err(&pdev->dev, "failed to register cpufreq driver\n");
 	regulator_put(arm_regulator);
 err_vdd_arm:
diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
index 6dc3815..00aa688 100644
--- a/drivers/thermal/samsung/exynos_thermal_common.c
+++ b/drivers/thermal/samsung/exynos_thermal_common.c
@@ -133,47 +133,62 @@ static int exynos_get_crit_temp(struct thermal_zone_device *thermal,
 static int exynos_bind(struct thermal_zone_device *thermal,
 			struct thermal_cooling_device *cdev)
 {
-	int ret = 0, i, tab_size, level;
-	struct freq_clip_table *tab_ptr, *clip_data;
 	struct exynos_thermal_zone *th_zone = thermal->devdata;
 	struct thermal_sensor_conf *data = th_zone->sensor_conf;
+	struct device_node *child, *gchild, *np;
+	struct of_phandle_args cooling_spec;
+	unsigned long max, state = 0;
+	int ret = 0, i = 0;
 
-	tab_ptr = (struct freq_clip_table *)data->cooling_data.freq_data;
-	tab_size = data->cooling_data.freq_clip_count;
-
-	if (tab_ptr == NULL || tab_size == 0)
+	/*
+	 * Below code is necessary to skip binding when cpufreq's
+	 * frequency table is not yet initialized.
+	 */
+	cdev->ops->get_max_state(cdev, &state);
+	if (!state && !th_zone->cool_dev_size) {
+		th_zone->cool_dev_size = 1;
+		th_zone->cool_dev[0] = cdev;
+		th_zone->bind = false;
 		return 0;
+	}
 
-	/* find the cooling device registered*/
-	for (i = 0; i < th_zone->cool_dev_size; i++)
-		if (cdev == th_zone->cool_dev[i])
-			break;
+	np = of_find_node_by_path("/thermal-zones/cpu-thermal");
+	if (!np) {
+		pr_err("failed to find thmerla-zones/cpu-thermal node\n");
+		return -ENOENT;
+	}
 
-	/* No matching cooling device */
-	if (i == th_zone->cool_dev_size)
-		return 0;
+	child = of_get_child_by_name(np, "cooling-maps");
 
-	/* Bind the thermal zone to the cpufreq cooling device */
-	for (i = 0; i < tab_size; i++) {
-		clip_data = (struct freq_clip_table *)&(tab_ptr[i]);
-		level = cpufreq_cooling_get_level(0, clip_data->freq_clip_max);
-		if (level == THERMAL_CSTATE_INVALID)
-			return 0;
-		switch (GET_ZONE(i)) {
-		case MONITOR_ZONE:
-		case WARN_ZONE:
-			if (thermal_zone_bind_cooling_device(thermal, i, cdev,
-								level, 0)) {
-				dev_err(data->dev,
-					"error unbinding cdev inst=%d\n", i);
-				ret = -EINVAL;
-			}
-			th_zone->bind = true;
-			break;
-		default:
+	for_each_child_of_node(child, gchild) {
+		ret = of_parse_phandle_with_args(gchild, "cooling-device",
+						 "#cooling-cells",
+						 0, &cooling_spec);
+		if (ret < 0) {
+			pr_err("missing cooling_device property\n");
+			goto end;
+		}
+
+		if (cooling_spec.args_count < 2) {
 			ret = -EINVAL;
+			goto end;
 		}
+
+		max = cooling_spec.args[0];
+		if (thermal_zone_bind_cooling_device(thermal, i, cdev,
+						     max, 0)) {
+			dev_err(data->dev,
+				"thermal error unbinding cdev inst=%d\n", i);
+
+			ret = -EINVAL;
+			goto end;
+		}
+		i++;
 	}
+	th_zone->bind = true;
+end:
+	of_node_put(child);
+	of_node_put(np);
 
 	return ret;
 }
@@ -182,16 +197,12 @@ static int exynos_bind(struct thermal_zone_device *thermal,
 static int exynos_unbind(struct thermal_zone_device *thermal,
 			struct thermal_cooling_device *cdev)
 {
-	int ret = 0, i, tab_size;
+	int ret = 0, i;
 	struct exynos_thermal_zone *th_zone = thermal->devdata;
 	struct thermal_sensor_conf *data = th_zone->sensor_conf;
+	struct device_node *child, *gchild, *np;
 
-	if (th_zone->bind == false)
-		return 0;
-
-	tab_size = data->cooling_data.freq_clip_count;
-
-	if (tab_size == 0)
+	if (th_zone->bind == false || !th_zone->cool_dev_size)
 		return 0;
 
 	/* find the cooling device registered*/
@@ -203,23 +214,30 @@ static int exynos_unbind(struct thermal_zone_device *thermal,
 	if (i == th_zone->cool_dev_size)
 		return 0;
 
-	/* Bind the thermal zone to the cpufreq cooling device */
-	for (i = 0; i < tab_size; i++) {
-		switch (GET_ZONE(i)) {
-		case MONITOR_ZONE:
-		case WARN_ZONE:
-			if (thermal_zone_unbind_cooling_device(thermal, i,
-								cdev)) {
-				dev_err(data->dev,
-					"error unbinding cdev inst=%d\n", i);
-				ret = -EINVAL;
-			}
-			th_zone->bind = false;
-			break;
-		default:
+	np = of_find_node_by_path("/thermal-zones/cpu-thermal");
+	if (!np) {
+		pr_err("failed to find thmerla-zones/cpu-thermal node\n");
+		return -ENOENT;
+	}
+
+	child = of_get_child_by_name(np, "cooling-maps");
+
+	i = 0;
+	for_each_child_of_node(child, gchild) {
+		if (thermal_zone_unbind_cooling_device(thermal, i,
+						       cdev)) {
+			dev_err(data->dev,
+				"error unbinding cdev inst=%d\n", i);
 			ret = -EINVAL;
+			goto end;
 		}
+		i++;
 	}
+	th_zone->bind = false;
+end:
+	of_node_put(child);
+	of_node_put(np);
+
 	return ret;
 }
 
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 936d16f..d2d6b53 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -916,13 +916,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 
 	sensor_conf->trip_data.trigger_falling = pdata->threshold_falling;
 
-	sensor_conf->cooling_data.freq_clip_count = pdata->freq_tab_count;
-	for (i = 0; i < pdata->freq_tab_count; i++) {
-		sensor_conf->cooling_data.freq_data[i].freq_clip_max =
-					pdata->freq_tab[i].freq_clip_max;
-		sensor_conf->cooling_data.freq_data[i].temp_level =
-					pdata->freq_tab[i].temp_level;
-	}
 	sensor_conf->dev = &pdev->dev;
 	/* Register the sensor with thermal management interface */
 	ret = exynos_register_thermal(sensor_conf);
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 03ebdd0..fcdb2fc 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -73,9 +73,6 @@
  * @second_point_trim: temp value of the second point trimming
  * @default_temp_offset: default temperature offset in case of no trimming
  * @cal_type: calibration type for temperature
- * @freq_clip_table: Table representing frequency reduction percentage.
- * @freq_tab_count: Count of the above table as frequency reduction may
- *	applicable to only some of the trigger levels.
  *
  * This structure is required for configuration of exynos_tmu driver.
  */
@@ -101,8 +98,6 @@ struct exynos_tmu_platform_data {
 	u32 cal_type;
 	u32 cal_mode;
 	u32 type;
-	struct freq_clip_table freq_tab[4];
-	unsigned int freq_tab_count;
 };
 
 /**
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index b239100..a993f3d 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -47,15 +47,6 @@ struct exynos_tmu_init_data const exynos4210_default_tmu_data = {
 		.first_point_trim = 25,
 		.second_point_trim = 85,
 		.default_temp_offset = 50,
-		.freq_tab[0] = {
-			.freq_clip_max = 800 * 1000,
-			.temp_level = 85,
-			},
-		.freq_tab[1] = {
-			.freq_clip_max = 200 * 1000,
-			.temp_level = 100,
-		},
-		.freq_tab_count = 2,
 		.type = SOC_ARCH_EXYNOS4210,
 		},
 	},
@@ -87,16 +78,7 @@ struct exynos_tmu_init_data const exynos4210_default_tmu_data = {
 	.max_efuse_value = 100, \
 	.first_point_trim = 25, \
 	.second_point_trim = 85, \
-	.default_temp_offset = 50, \
-	.freq_tab[0] = { \
-		.freq_clip_max = 800 * 1000, \
-		.temp_level = 70, \
-	}, \
-	.freq_tab[1] = { \
-		.freq_clip_max = 400 * 1000, \
-		.temp_level = 95, \
-	}, \
-	.freq_tab_count = 2
+	.default_temp_offset = 50
 
 struct exynos_tmu_init_data const exynos3250_default_tmu_data = {
 	.tmu_data = {
@@ -133,16 +115,7 @@ struct exynos_tmu_init_data const exynos3250_default_tmu_data = {
 	.max_efuse_value = 100, \
 	.first_point_trim = 25, \
 	.second_point_trim = 85, \
-	.default_temp_offset = 50, \
-	.freq_tab[0] = { \
-		.freq_clip_max = 1400 * 1000, \
-		.temp_level = 70, \
-	}, \
-	.freq_tab[1] = { \
-		.freq_clip_max = 400 * 1000, \
-		.temp_level = 95, \
-	}, \
-	.freq_tab_count = 2
+	.default_temp_offset = 50
 
 struct exynos_tmu_init_data const exynos4412_default_tmu_data = {
 	.tmu_data = {
@@ -189,16 +162,7 @@ struct exynos_tmu_init_data const exynos5250_default_tmu_data = {
 	.max_efuse_value = 100, \
 	.first_point_trim = 25, \
 	.second_point_trim = 85, \
-	.default_temp_offset = 50, \
-	.freq_tab[0] = { \
-		.freq_clip_max = 800 * 1000, \
-		.temp_level = 85, \
-	}, \
-	.freq_tab[1] = { \
-		.freq_clip_max = 200 * 1000, \
-		.temp_level = 103, \
-	}, \
-	.freq_tab_count = 2, \
+	.default_temp_offset = 50,
 
 #define EXYNOS5260_TMU_DATA \
 	__EXYNOS5260_TMU_DATA \
-- 
2.0.0.rc2
