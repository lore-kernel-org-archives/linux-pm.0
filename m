From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 17/21] thermal: samsung: core: Exynos TMU rework to use device
 tree for configuration
Date: Thu, 09 Oct 2014 18:38:53 +0200
Message-ID: <1412872737-624-18-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch brings support for providing configuration via device tree.
Previously, data hardcoded in the exynos_tmu_data.c file was used, which is
not scalable and error prone.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/thermal/samsung/Makefile     |   2 -
 drivers/thermal/samsung/exynos_tmu.c | 266 ++++++++++++++++++++---------------
 drivers/thermal/samsung/exynos_tmu.h |  51 -------
 3 files changed, 154 insertions(+), 165 deletions(-)

diff --git a/drivers/thermal/samsung/Makefile b/drivers/thermal/samsung/Makefile
index c09d830..1e47d0d 100644
--- a/drivers/thermal/samsung/Makefile
+++ b/drivers/thermal/samsung/Makefile
@@ -3,5 +3,3 @@
 #
 obj-$(CONFIG_EXYNOS_THERMAL)			+= exynos_thermal.o
 exynos_thermal-y				:= exynos_tmu.o
-exynos_thermal-y				+= exynos_tmu_data.o
-exynos_thermal-$(CONFIG_EXYNOS_THERMAL_CORE)	+= exynos_thermal_common.o
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 1d6b1cb..e26042a 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1,6 +1,10 @@
 /*
  * exynos_tmu.c - Samsung EXYNOS TMU (Thermal Management Unit)
  *
+ *  Copyright (C) 2014 Samsung Electronics
+ *  Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
+ *  Lukasz Majewski <l.majewski@samsung.com>
+ *
  *  Copyright (C) 2011 Samsung Electronics
  *  Donggeun Kim <dg77.kim@samsung.com>
  *  Amit Daniel Kachhap <amit.kachhap@linaro.org>
@@ -31,8 +35,8 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-#include "exynos_thermal_common.h"
 #include "exynos_tmu.h"
+#include "../thermal_core.h"
 
 /* Exynos generic registers */
 #define EXYNOS_TMU_REG_TRIMINFO		0x0
@@ -130,6 +134,7 @@
 #define EXYNOS5440_TMU_TH_RISE4_SHIFT		24
 #define EXYNOS5440_EFUSE_SWAP_OFFSET		8
 
+#define MCELSIUS	1000
 /**
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
 	driver
@@ -165,7 +170,8 @@ struct exynos_tmu_data {
 	struct clk *clk, *clk_sec;
 	u8 temp_error1, temp_error2;
 	struct regulator *regulator;
-	struct thermal_sensor_conf *reg_conf;
+	struct thermal_zone_device *tzd;
+
 	int (*tmu_initialize)(struct platform_device *pdev);
 	void (*tmu_control)(struct platform_device *pdev, bool on);
 	int (*tmu_read)(struct exynos_tmu_data *data);
@@ -174,6 +180,33 @@ struct exynos_tmu_data {
 	void (*tmu_clear_irqs)(struct exynos_tmu_data *data);
 };
 
+static void exynos_report_trigger(struct exynos_tmu_data *p)
+{
+	char data[10], *envp[] = { data, NULL };
+	struct thermal_zone_device *tz = p->tzd;
+	unsigned long temp;
+	unsigned int i;
+
+	if (!p) {
+		pr_err("Wrong temperature configuration data\n");
+		return;
+	}
+
+	thermal_zone_device_update(tz);
+
+	mutex_lock(&tz->lock);
+	/* Find the level for which trip happened */
+	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
+		tz->ops->get_trip_temp(tz, i, &temp);
+		if (tz->last_temperature < temp)
+			break;
+	}
+
+	snprintf(data, sizeof(data), "%u", i);
+	kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, envp);
+	mutex_unlock(&tz->lock);
+}
+
 /*
  * TMU treats temperature as a mapped temperature code.
  * The temperature is converted differently depending on the calibration type.
@@ -249,16 +282,22 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 
 static u32 get_th_reg(struct exynos_tmu_data *data, u32 threshold, bool falling)
 {
-	struct exynos_tmu_platform_data *pdata = data->pdata;
-	int i;
+	struct thermal_zone_device *tz = data->tzd;
+	unsigned long temp, temp_hist;
+	int i, ret;
 
-	for (i = 0; i < pdata->non_hw_trigger_levels; i++) {
-		u8 temp = pdata->trigger_levels[i];
+	for (i = 0; i < of_thermal_get_non_crit_ntrips(tz); i++) {
+		ret = tz->ops->get_trip_temp(tz, i, &temp);
+		if (ret)
+			return 0;
 
-		if (falling)
-			temp -= pdata->threshold_falling;
-		else
+		temp /= MCELSIUS;
+		if (falling) {
+			tz->ops->get_trip_hyst(tz, i, &temp_hist);
+			temp -= (temp_hist / MCELSIUS);
+		} else {
 			threshold &= ~(0xff << 8 * i);
+		}
 
 		threshold |= temp_to_code(data, temp) << 8 * i;
 	}
@@ -320,9 +359,10 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 static int exynos4210_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct exynos_tmu_platform_data *pdata = data->pdata;
-	unsigned int status;
+	struct thermal_zone_device *tz = data->tzd;
 	int ret = 0, threshold_code, i;
+	unsigned long reference, temp;
+	unsigned int status;
 
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 	if (!status) {
@@ -333,12 +373,21 @@ static int exynos4210_tmu_initialize(struct platform_device *pdev)
 	sanitize_temp_error(data, readl(data->base + EXYNOS_TMU_REG_TRIMINFO));
 
 	/* Write temperature code for threshold */
-	threshold_code = temp_to_code(data, pdata->threshold);
+	tz->ops->get_trip_temp(tz, 0, &reference);
+	reference /= MCELSIUS;
+	threshold_code = temp_to_code(data, reference);
+	if (threshold_code < 0) {
+		ret = threshold_code;
+		goto out;
+	}
 	writeb(threshold_code, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
 
-	for (i = 0; i < pdata->non_hw_trigger_levels; i++)
-		writeb(pdata->trigger_levels[i], data->base +
+	for (i = 0; i < of_thermal_get_non_crit_ntrips(tz); i++) {
+		tz->ops->get_trip_temp(tz, i, &temp);
+		temp /= MCELSIUS;
+		writeb(temp - reference, data->base +
 		       EXYNOS4210_TMU_REG_TRIG_LEVEL0 + i * 4);
+	}
 
 	writel(EXYNOS4210_TMU_TRIG_LEVEL_MASK,
 	       data->base + EXYNOS_TMU_REG_INTCLEAR);
@@ -349,9 +398,9 @@ out:
 static int exynos4412_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct exynos_tmu_platform_data *pdata = data->pdata;
 	unsigned int status, trim_info, con, ctrl, rising_threshold;
 	int ret = 0, threshold_code, i;
+	unsigned long crit_temp = 0;
 
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 	if (!status) {
@@ -401,9 +450,9 @@ static int exynos4412_tmu_initialize(struct platform_device *pdev)
 		       data->base + EXYNOS_TMU_REG_INTCLEAR);
 
 	/* if last threshold limit is also present */
-	i = pdata->max_trigger_level - 1;
-	if (pdata->trigger_levels[i] && pdata->trigger_type[i] == HW_TRIP) {
-		threshold_code = temp_to_code(data, pdata->trigger_levels[i]);
+	i = of_thermal_get_non_crit_ntrips(data->tzd);
+	if (!data->tzd->ops->get_crit_temp(data->tzd, &crit_temp)) {
+		threshold_code = temp_to_code(data, crit_temp / MCELSIUS);
 		/* 1-4 level to be assigned in th0 reg */
 		rising_threshold &= ~(0xff << 8 * i);
 		rising_threshold |= threshold_code << 8 * i;
@@ -419,9 +468,9 @@ out:
 static int exynos5440_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct exynos_tmu_platform_data *pdata = data->pdata;
 	unsigned int trim_info = 0, con, rising_threshold;
-	int ret = 0, threshold_code, i;
+	int ret = 0, threshold_code;
+	unsigned long crit_temp = 0;
 
 	/*
 	 * For exynos5440 soc triminfo value is swapped between TMU0 and
@@ -452,9 +501,8 @@ static int exynos5440_tmu_initialize(struct platform_device *pdev)
 	       data->base + EXYNOS5440_TMU_S0_7_IRQ);
 
 	/* if last threshold limit is also present */
-	i = pdata->max_trigger_level - 1;
-	if (pdata->trigger_levels[i] && pdata->trigger_type[i] == HW_TRIP) {
-		threshold_code = temp_to_code(data, pdata->trigger_levels[i]);
+	if (!data->tzd->ops->get_crit_temp(data->tzd, &crit_temp)) {
+		threshold_code = temp_to_code(data, crit_temp / MCELSIUS);
 		/* 5th level to be assigned in th2 reg */
 		rising_threshold =
 			threshold_code << EXYNOS5440_TMU_TH_RISE4_SHIFT;
@@ -472,7 +520,7 @@ static int exynos5440_tmu_initialize(struct platform_device *pdev)
 static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct exynos_tmu_platform_data *pdata = data->pdata;
+	struct thermal_zone_device *tz = data->tzd;
 	unsigned int con, interrupt_en;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
@@ -480,10 +528,11 @@ static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 	if (on) {
 		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
 		interrupt_en =
-			pdata->trigger_enable[3] << EXYNOS_TMU_INTEN_RISE3_SHIFT |
-			pdata->trigger_enable[2] << EXYNOS_TMU_INTEN_RISE2_SHIFT |
-			pdata->trigger_enable[1] << EXYNOS_TMU_INTEN_RISE1_SHIFT |
-			pdata->trigger_enable[0] << EXYNOS_TMU_INTEN_RISE0_SHIFT;
+			of_thermal_is_trip_en(tz, 3) << EXYNOS_TMU_INTEN_RISE3_SHIFT |
+			of_thermal_is_trip_en(tz, 2) << EXYNOS_TMU_INTEN_RISE2_SHIFT |
+			of_thermal_is_trip_en(tz, 1) << EXYNOS_TMU_INTEN_RISE1_SHIFT |
+			of_thermal_is_trip_en(tz, 0) << EXYNOS_TMU_INTEN_RISE0_SHIFT;
+
 		if (data->soc != SOC_ARCH_EXYNOS4210)
 			interrupt_en |=
 				interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
@@ -498,7 +547,7 @@ static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 static void exynos5440_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct exynos_tmu_platform_data *pdata = data->pdata;
+	struct thermal_zone_device *tz = data->tzd;
 	unsigned int con, interrupt_en;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS5440_TMU_S0_7_CTRL));
@@ -506,10 +555,10 @@ static void exynos5440_tmu_control(struct platform_device *pdev, bool on)
 	if (on) {
 		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
 		interrupt_en =
-			pdata->trigger_enable[3] << EXYNOS5440_TMU_INTEN_RISE3_SHIFT |
-			pdata->trigger_enable[2] << EXYNOS5440_TMU_INTEN_RISE2_SHIFT |
-			pdata->trigger_enable[1] << EXYNOS5440_TMU_INTEN_RISE1_SHIFT |
-			pdata->trigger_enable[0] << EXYNOS5440_TMU_INTEN_RISE0_SHIFT;
+			of_thermal_is_trip_en(tz, 3) << EXYNOS5440_TMU_INTEN_RISE3_SHIFT |
+			of_thermal_is_trip_en(tz, 2) << EXYNOS5440_TMU_INTEN_RISE2_SHIFT |
+			of_thermal_is_trip_en(tz, 1) << EXYNOS5440_TMU_INTEN_RISE1_SHIFT |
+			of_thermal_is_trip_en(tz, 0) << EXYNOS5440_TMU_INTEN_RISE0_SHIFT;
 		interrupt_en |= interrupt_en << EXYNOS5440_TMU_INTEN_FALL0_SHIFT;
 	} else {
 		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
@@ -519,19 +568,21 @@ static void exynos5440_tmu_control(struct platform_device *pdev, bool on)
 	writel(con, data->base + EXYNOS5440_TMU_S0_7_CTRL);
 }
 
-static int exynos_tmu_read(struct exynos_tmu_data *data)
+int exynos_get_temp(void *p, long *temp)
 {
-	int ret;
+	struct exynos_tmu_data *data = p;
+	if (!data)
+		return -EINVAL;
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
-	ret = data->tmu_read(data);
-	if (ret >= 0)
-		ret = code_to_temp(data, ret);
+
+	*temp = code_to_temp(data, data->tmu_read(data)) * MCELSIUS;
+
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_THERMAL_EMULATION
@@ -643,7 +694,7 @@ static void exynos_tmu_work(struct work_struct *work)
 	if (!IS_ERR(data->clk_sec))
 		clk_disable(data->clk_sec);
 
-	exynos_report_trigger(data->reg_conf);
+	exynos_report_trigger(data);
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
 	/* TODO: take action based on particular interrupt */
@@ -694,55 +745,63 @@ static irqreturn_t exynos_tmu_irq(int irq, void *id)
 static const struct of_device_id exynos_tmu_match[] = {
 	{
 		.compatible = "samsung,exynos3250-tmu",
-		.data = &exynos3250_default_tmu_data,
 	},
 	{
 		.compatible = "samsung,exynos4210-tmu",
-		.data = &exynos4210_default_tmu_data,
 	},
 	{
 		.compatible = "samsung,exynos4412-tmu",
-		.data = &exynos4412_default_tmu_data,
 	},
 	{
 		.compatible = "samsung,exynos5250-tmu",
-		.data = &exynos5250_default_tmu_data,
 	},
 	{
 		.compatible = "samsung,exynos5260-tmu",
-		.data = &exynos5260_default_tmu_data,
 	},
 	{
 		.compatible = "samsung,exynos5420-tmu",
-		.data = &exynos5420_default_tmu_data,
 	},
 	{
 		.compatible = "samsung,exynos5420-tmu-ext-triminfo",
-		.data = &exynos5420_default_tmu_data,
 	},
 	{
 		.compatible = "samsung,exynos5440-tmu",
-		.data = &exynos5440_default_tmu_data,
 	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, exynos_tmu_match);
 
-static inline struct  exynos_tmu_platform_data *exynos_get_driver_data(
-			struct platform_device *pdev, int id)
+static int exynos_of_sensor_conf(struct device_node *np,
+				 struct exynos_tmu_platform_data *pdata)
 {
-	struct  exynos_tmu_init_data *data_table;
-	struct exynos_tmu_platform_data *tmu_data;
-	const struct of_device_id *match;
-
-	match = of_match_node(exynos_tmu_match, pdev->dev.of_node);
-	if (!match)
-		return NULL;
-	data_table = (struct exynos_tmu_init_data *) match->data;
-	if (!data_table || id >= data_table->tmu_count)
-		return NULL;
-	tmu_data = data_table->tmu_data;
-	return (struct exynos_tmu_platform_data *) (tmu_data + id);
+	u32 value;
+	int ret;
+
+	of_node_get(np);
+
+	ret = of_property_read_u32(np, "gain", &value);
+	pdata->gain = (u8) value;
+	of_property_read_u32(np, "reference_voltage", &value);
+	pdata->reference_voltage = (u8) value;
+	of_property_read_u32(np, "noise_cancel_mode", &value);
+	pdata->noise_cancel_mode = (u8) value;;
+
+	of_property_read_u32(np, "efuse_value", &pdata->efuse_value);
+	of_property_read_u32(np, "min_efuse_value", &pdata->min_efuse_value);
+	of_property_read_u32(np, "max_efuse_value", &pdata->max_efuse_value);
+
+	of_property_read_u32(np, "first_point_trim", &value);
+	pdata->first_point_trim = (u8) value;
+	of_property_read_u32(np, "second_point_trim", &value);
+	pdata->second_point_trim = (u8) value;
+	of_property_read_u32(np, "default_temp_offset", &value);
+	pdata->default_temp_offset = (u8) value;
+
+	of_property_read_u32(np, "cal_type", &pdata->cal_type);
+	of_property_read_u32(np, "type", &pdata->type);
+
+	of_node_put(np);
+	return 0;
 }
 
 static int exynos_map_dt_data(struct platform_device *pdev)
@@ -792,12 +851,13 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		return -EADDRNOTAVAIL;
 	}
 
-	pdata = exynos_get_driver_data(pdev, data->id);
-	if (!pdata) {
-		dev_err(&pdev->dev, "No platform init data supplied.\n");
-		return -ENODEV;
-	}
+	pdata = devm_kzalloc(&pdev->dev,
+			     sizeof(struct exynos_tmu_platform_data),
+			     GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
 
+	exynos_of_sensor_conf(pdev->dev.of_node, pdata);
 	data->pdata = pdata;
 	data->soc = pdata->type;
 
@@ -857,10 +917,9 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 
 static int exynos_tmu_probe(struct platform_device *pdev)
 {
-	struct exynos_tmu_data *data;
 	struct exynos_tmu_platform_data *pdata;
-	struct thermal_sensor_conf *sensor_conf;
-	int ret, i;
+	struct exynos_tmu_data *data;
+	int ret;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(struct exynos_tmu_data),
 					GFP_KERNEL);
@@ -870,9 +929,16 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 	mutex_init(&data->lock);
 
+	data->tzd = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
+						    exynos_get_temp, NULL,
+						    exynos_tmu_set_emulation);
+	if (IS_ERR(data->tzd)) {
+		pr_err("thermal: tz: %p ERROR\n", data->tzd);
+		return PTR_ERR(data->tzd);
+	}
 	ret = exynos_map_dt_data(pdev);
 	if (ret)
-		return ret;
+		goto err_sensor;
 
 	pdata = data->pdata;
 
@@ -881,20 +947,22 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");
 	if (IS_ERR(data->clk)) {
 		dev_err(&pdev->dev, "Failed to get clock\n");
-		return  PTR_ERR(data->clk);
+		ret = PTR_ERR(data->clk);
+		goto err_sensor;
 	}
 
 	data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
 	if (IS_ERR(data->clk_sec)) {
 		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
 			dev_err(&pdev->dev, "Failed to get triminfo clock\n");
-			return PTR_ERR(data->clk_sec);
+			ret = PTR_ERR(data->clk_sec);
+			goto err_sensor;
 		}
 	} else {
 		ret = clk_prepare(data->clk_sec);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to get clock\n");
-			return ret;
+			goto err_sensor;
 		}
 	}
 
@@ -910,42 +978,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	exynos_tmu_control(pdev, true);
-
-	/* Allocate a structure to register with the exynos core thermal */
-	sensor_conf = devm_kzalloc(&pdev->dev,
-				sizeof(struct thermal_sensor_conf), GFP_KERNEL);
-	if (!sensor_conf) {
-		ret = -ENOMEM;
-		goto err_clk;
-	}
-	sprintf(sensor_conf->name, "therm_zone%d", data->id);
-	sensor_conf->read_temperature = (int (*)(void *))exynos_tmu_read;
-	sensor_conf->write_emul_temp =
-		(int (*)(void *, unsigned long))exynos_tmu_set_emulation;
-	sensor_conf->driver_data = data;
-	sensor_conf->trip_data.trip_count = pdata->trigger_enable[0] +
-			pdata->trigger_enable[1] + pdata->trigger_enable[2]+
-			pdata->trigger_enable[3];
-
-	for (i = 0; i < sensor_conf->trip_data.trip_count; i++) {
-		sensor_conf->trip_data.trip_val[i] =
-			pdata->threshold + pdata->trigger_levels[i];
-		sensor_conf->trip_data.trip_type[i] =
-					pdata->trigger_type[i];
-	}
-
-	sensor_conf->trip_data.trigger_falling = pdata->threshold_falling;
-
-	sensor_conf->dev = &pdev->dev;
-	/* Register the sensor with thermal management interface */
-	ret = exynos_register_thermal(sensor_conf);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to register thermal interface\n");
-		goto err_clk;
-	}
-	data->reg_conf = sensor_conf;
-
 	ret = devm_request_irq(&pdev->dev, data->irq, exynos_tmu_irq,
 		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
 	if (ret) {
@@ -953,21 +985,31 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
+	ret = exynos_tmu_initialize(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to initialize TMU\n");
+		goto err_clk;
+	}
+	exynos_tmu_control(pdev, true);
 	return 0;
+
 err_clk:
 	clk_unprepare(data->clk);
 err_clk_sec:
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
+err_sensor:
+	thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
+
 	return ret;
 }
 
 static int exynos_tmu_remove(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
+	struct thermal_zone_device *tzd = data->tzd;
 
-	exynos_unregister_thermal(data->reg_conf);
-
+	thermal_zone_of_sensor_unregister(&pdev->dev, tzd);
 	exynos_tmu_control(pdev, false);
 
 	clk_unprepare(data->clk);
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 1e87f0f..6f176ef 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -24,40 +24,10 @@
 #define _EXYNOS_TMU_H
 #include <linux/cpu_cooling.h>
 
-#include "exynos_thermal_common.h"
-
 #include <dt-bindings/thermal/thermal_exynos.h>
 
 /**
  * struct exynos_tmu_platform_data
- * @threshold: basic temperature for generating interrupt
- *	       25 <= threshold <= 125 [unit: degree Celsius]
- * @threshold_falling: differntial value for setting threshold
- *		       of temperature falling interrupt.
- * @trigger_levels: array for each interrupt levels
- *	[unit: degree Celsius]
- *	0: temperature for trigger_level0 interrupt
- *	   condition for trigger_level0 interrupt:
- *		current temperature > threshold + trigger_levels[0]
- *	1: temperature for trigger_level1 interrupt
- *	   condition for trigger_level1 interrupt:
- *		current temperature > threshold + trigger_levels[1]
- *	2: temperature for trigger_level2 interrupt
- *	   condition for trigger_level2 interrupt:
- *		current temperature > threshold + trigger_levels[2]
- *	3: temperature for trigger_level3 interrupt
- *	   condition for trigger_level3 interrupt:
- *		current temperature > threshold + trigger_levels[3]
- * @trigger_type: defines the type of trigger. Possible values are,
- *	THROTTLE_ACTIVE trigger type
- *	THROTTLE_PASSIVE trigger type
- *	SW_TRIP trigger type
- *	HW_TRIP
- * @trigger_enable[]: array to denote which trigger levels are enabled.
- *	1 = enable trigger_level[] interrupt,
- *	0 = disable trigger_level[] interrupt
- * @max_trigger_level: max trigger level supported by the TMU
- * @non_hw_trigger_levels: number of defined non-hardware trigger levels
  * @gain: gain of amplifier in the positive-TC generator block
  *	0 < gain <= 15
  * @reference_voltage: reference voltage of amplifier
@@ -69,21 +39,12 @@
  * @efuse_value: platform defined fuse value
  * @min_efuse_value: minimum valid trimming data
  * @max_efuse_value: maximum valid trimming data
- * @first_point_trim: temp value of the first point trimming
- * @second_point_trim: temp value of the second point trimming
  * @default_temp_offset: default temperature offset in case of no trimming
  * @cal_type: calibration type for temperature
  *
  * This structure is required for configuration of exynos_tmu driver.
  */
 struct exynos_tmu_platform_data {
-	u8 threshold;
-	u8 threshold_falling;
-	u8 trigger_levels[MAX_TRIP_COUNT];
-	enum trigger_type trigger_type[MAX_TRIP_COUNT];
-	bool trigger_enable[MAX_TRIP_COUNT];
-	u8 max_trigger_level;
-	u8 non_hw_trigger_levels;
 	u8 gain;
 	u8 reference_voltage;
 	u8 noise_cancel_mode;
@@ -99,18 +60,6 @@ struct exynos_tmu_platform_data {
 	u32 type;
 };
 
-/**
- * struct exynos_tmu_init_data
- * @tmu_count: number of TMU instances.
- * @tmu_data: platform data of all TMU instances.
- * This structure is required to store data for multi-instance exynos tmu
- * driver.
- */
-struct exynos_tmu_init_data {
-	int tmu_count;
-	struct exynos_tmu_platform_data tmu_data[];
-};
-
 extern struct exynos_tmu_init_data const exynos3250_default_tmu_data;
 extern struct exynos_tmu_init_data const exynos4210_default_tmu_data;
 extern struct exynos_tmu_init_data const exynos4412_default_tmu_data;
-- 
2.0.0.rc2
