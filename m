From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] thermal: add imx thermal driver support
Date: Tue, 4 Jun 2013 15:13:28 +0800
Message-ID: <1370330008-5982-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:46794
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751803Ab3FDHMb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2013 03:12:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

This is based on the initial imx thermal work done by
Rob Lee <rob.lee@linaro.org> (Not sure if the email address is still
valid).  Since he is no longer interested in the work and I have
rewritten a significant amount of the code, I just took the authorship
over from him.

It adds the imx thermal support using Temperature Monitor (TEMPMON)
block found on some Freescale i.MX SoCs.  The driver uses syscon regmap
interface to access TEMPMON control registers and calibration data, and
supports cpufreq as the cooling device.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/thermal/imx-thermal.txt    |   14 +
 drivers/thermal/Kconfig                            |    8 +
 drivers/thermal/Makefile                           |    1 +
 drivers/thermal/imx_thermal.c                      |  421 ++++++++++++++++++++
 4 files changed, 444 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/imx-thermal.txt
 create mode 100644 drivers/thermal/imx_thermal.c

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
new file mode 100644
index 0000000..c606e2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
@@ -0,0 +1,14 @@
+* Temperature Monitor (TEMPMON) on Freescale i.MX SoCs
+
+Required properties:
+- compatible : "fsl,imx6q-thermal"
+- fsl,tempmon : phandle pointer to TEMPMON control registers
+- fsl,tempmon-data : phandle pointer to TEMPMON calibration data
+
+Example:
+
+tempmon {
+	compatible = "fsl,imx6q-tempmon";
+	fsl,tempmon = <&anatop>;
+	fsl,tempmon-data = <&ocotp>;
+};
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5e3c025..935fcbe 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -91,6 +91,14 @@ config THERMAL_EMULATION
 	  because userland can easily disable the thermal policy by simply
 	  flooding this sysfs node with low temperature values.
 
+config IMX_THERMAL
+	tristate "Temperature sensor driver for Freescale i.MX SoCs"
+	depends on CPU_THERMAL
+	depends on MFD_SYSCON
+	depends on OF
+	help
+	  Support for Temperature Monitor (TEMPMON) found on Freescale i.MX SoCs.
+
 config SPEAR_THERMAL
 	bool "SPEAr thermal sensor driver"
 	depends on PLAT_SPEAR
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index c054d41..6910b2d 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_EXYNOS_THERMAL)	+= exynos_thermal.o
 obj-$(CONFIG_DOVE_THERMAL)  	+= dove_thermal.o
 obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
 obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
+obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
 obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+= db8500_cpufreq_cooling.o
 obj-$(CONFIG_INTEL_POWERCLAMP)	+= intel_powerclamp.o
 
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
new file mode 100644
index 0000000..bdfcadb
--- /dev/null
+++ b/drivers/thermal/imx_thermal.c
@@ -0,0 +1,421 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/cpu_cooling.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/types.h>
+
+#define REG_SET		0x4
+#define REG_CLR		0x8
+#define REG_TOG		0xc
+
+#define MISC0				0x0150
+#define MISC0_REFTOP_SELBIASOFF		(1 << 3)
+
+#define TEMPSENSE0			0x0180
+#define TEMPSENSE0_TEMP_CNT_SHIFT	8
+#define TEMPSENSE0_TEMP_CNT_MASK	(0xfff << TEMPSENSE0_TEMP_CNT_SHIFT)
+#define TEMPSENSE0_FINISHED		(1 << 2)
+#define TEMPSENSE0_MEASURE_TEMP		(1 << 1)
+#define TEMPSENSE0_POWER_DOWN		(1 << 0)
+
+#define TEMPSENSE1			0x0190
+#define TEMPSENSE1_MEASURE_FREQ		0xffff
+
+#define OCOTP_ANA1			0x04e0
+
+/* The driver supports 1 active trip point and 1 critical trip point */
+enum imx_thermal_trip {
+	IMX_TRIP_ACTIVE,
+	IMX_TRIP_CRITICAL,
+	IMX_TRIP_NUM,
+};
+
+/*
+ * It defines the temperature in millicelsius for active trip point
+ * that will trigger cooling action when crossed.
+ */
+#define IMX_TEMP_ACTIVE			85000
+
+/*
+ * The maximum die temperature on imx parts is 105C, let's give some cushion
+ * for noise and possible temperature rise between measurements.
+ */
+#define IMX_TEMP_CRITICAL		100000
+
+#define IMX_THERMAL_POLLING_INTERVAL	1000 /* millisecond */
+
+struct imx_thermal_data {
+	struct thermal_zone_device *tz;
+	struct thermal_cooling_device *cdev;
+	enum thermal_device_mode mode;
+	struct regmap *tempmon;
+	bool meas_suspended;
+	int c1, c2; /* See forumla in imx_get_sensor_data() */
+};
+
+static int imx_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
+{
+	struct imx_thermal_data *data = tz->devdata;
+	struct regmap *map = data->tempmon;
+	static unsigned long last_temp;
+	unsigned int n_meas;
+	u32 val;
+
+	/*
+	 * Every time we measure the temperature, we will power on the
+	 * temperature sensor, enable measurements, take a reading,
+	 * disable measurements, power off the temperature sensor.
+	 */
+	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
+	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+
+	/*
+	 * According to the temp sensor designers, it may require up to ~17us
+	 * to complete a measurement.  But this timing isn't checked on every
+	 * part nor is it specified in the datasheet, so sleeping at least 1ms
+	 * should provide plenty of time.  Sleeping longer than 1ms is ok so no
+	 * need for usleep_range.
+	 */
+	msleep(1);
+
+	regmap_read(map, TEMPSENSE0, &val);
+	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
+	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+
+	if ((val & TEMPSENSE0_FINISHED) == 0) {
+		dev_dbg(&tz->device, "temp measurement never finished\n");
+		return -EAGAIN;
+	}
+
+	n_meas = (val & TEMPSENSE0_TEMP_CNT_MASK) >> TEMPSENSE0_TEMP_CNT_SHIFT;
+
+	/* See imx_get_sensor_data() for forumla derivation */
+	*temp = data->c2 + data->c1 * n_meas;
+
+	if (*temp != last_temp) {
+		dev_dbg(&tz->device, "millicelsius: %ld\n", *temp);
+		last_temp = *temp;
+	}
+
+	return 0;
+}
+
+static int imx_get_mode(struct thermal_zone_device *tz,
+			enum thermal_device_mode *mode)
+{
+	struct imx_thermal_data *data = tz->devdata;
+
+	*mode = data->mode;
+
+	return 0;
+}
+
+static int imx_set_mode(struct thermal_zone_device *tz,
+			enum thermal_device_mode mode)
+{
+	struct imx_thermal_data *data = tz->devdata;
+
+	tz->polling_delay = (mode == THERMAL_DEVICE_ENABLED) ?
+				IMX_THERMAL_POLLING_INTERVAL : 0;
+	data->mode = mode;
+	thermal_zone_device_update(tz);
+
+	return 0;
+}
+
+static int imx_get_trip_type(struct thermal_zone_device *tz, int trip,
+			     enum thermal_trip_type *type)
+{
+	*type = (trip == IMX_TRIP_ACTIVE) ? THERMAL_TRIP_ACTIVE :
+					    THERMAL_TRIP_CRITICAL;
+	return 0;
+}
+
+static int imx_get_crit_temp(struct thermal_zone_device *tz,
+			     unsigned long *temp)
+{
+	*temp = IMX_TEMP_CRITICAL;
+	return 0;
+}
+
+static int imx_get_trip_temp(struct thermal_zone_device *tz, int trip,
+			     unsigned long *temp)
+{
+	*temp = (trip == IMX_TRIP_ACTIVE) ? IMX_TEMP_ACTIVE :
+					    IMX_TEMP_CRITICAL;
+	return 0;
+}
+
+static int imx_bind(struct thermal_zone_device *tz,
+		    struct thermal_cooling_device *cdev)
+{
+	int ret;
+
+	ret = thermal_zone_bind_cooling_device(tz, IMX_TRIP_ACTIVE, cdev,
+					       THERMAL_NO_LIMIT,
+					       THERMAL_NO_LIMIT);
+	if (ret) {
+		dev_err(&tz->device,
+			"binding zone %s with cdev %s failed:%d\n",
+			tz->type, cdev->type, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imx_unbind(struct thermal_zone_device *tz,
+		      struct thermal_cooling_device *cdev)
+{
+	int ret;
+
+	ret = thermal_zone_unbind_cooling_device(tz, IMX_TRIP_ACTIVE, cdev);
+	if (ret) {
+		dev_err(&tz->device,
+			"unbinding zone %s with cdev %s failed:%d\n",
+			tz->type, cdev->type, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct thermal_zone_device_ops imx_tz_ops = {
+	.bind = imx_bind,
+	.unbind = imx_unbind,
+	.get_temp = imx_get_temp,
+	.get_mode = imx_get_mode,
+	.set_mode = imx_set_mode,
+	.get_trip_type = imx_get_trip_type,
+	.get_trip_temp = imx_get_trip_temp,
+	.get_crit_temp = imx_get_crit_temp,
+};
+
+static int imx_get_sensor_data(struct platform_device *pdev)
+{
+	struct imx_thermal_data *data = platform_get_drvdata(pdev);
+	struct regmap *map;
+	int t1, t2, n1, n2;
+	int ret;
+	u32 val;
+
+	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+					      "fsl,tempmon-data");
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		dev_err(&pdev->dev, "failed to get sensor regmap: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(map, OCOTP_ANA1, &val);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
+		return ret;
+	}
+
+	if (val == 0 || val == ~0) {
+		dev_err(&pdev->dev, "invalid sensor calibration data\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Sensor data layout:
+	 *   [31:20] - sensor value @ 25C
+	 *    [19:8] - sensor value of hot
+	 *     [7:0] - hot temperature value
+	 */
+	n1 = val >> 20;
+	n2 = (val & 0xfff00) >> 8;
+	t2 = val & 0xff;
+	t1 = 25; /* t1 always 25C */
+
+	/*
+	 * Derived from linear interpolation,
+	 * Tmeas = T2 + (Nmeas - N2) * (T1 - T2) / (N1 - N2)
+	 * We want to reduce this down to the minimum computation necessary
+	 * for each temperature read.  Also, we want Tmeas in millicelsius
+	 * and we don't want to lose precision from integer division. So...
+	 * milli_Tmeas = 1000 * T2 + 1000 * (Nmeas - N2) * (T1 - T2) / (N1 - N2)
+	 * Let constant c1 = 1000 * (T1 - T2) / (N1 - N2)
+	 * milli_Tmeas = (1000 * T2) + c1 * (Nmeas - N2)
+	 * milli_Tmeas = (1000 * T2) + (c1 * Nmeas) - (c1 * N2)
+	 * Let constant c2 = (1000 * T2) - (c1 * N2)
+	 * milli_Tmeas = c2 + (c1 * Nmeas)
+	 */
+	data->c1 = 1000 * (t1 - t2) / (n1 - n2);
+	data->c2 = 1000 * t2 - data->c1 * n2;
+
+	return 0;
+}
+
+static int imx_thermal_probe(struct platform_device *pdev)
+{
+	struct imx_thermal_data *data;
+	struct cpumask clip_cpus;
+	struct regmap *map;
+	int ret;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "fsl,tempmon");
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		dev_err(&pdev->dev, "failed to get tempmon regmap: %d\n", ret);
+		return ret;
+	}
+	data->tempmon = map;
+
+	platform_set_drvdata(pdev, data);
+
+	ret = imx_get_sensor_data(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get sensor data\n");
+		return ret;
+	}
+
+	/* Make sure sensor is in known good state for measurements */
+	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
+	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
+	regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
+	regmap_write(map, MISC0 + REG_SET, MISC0_REFTOP_SELBIASOFF);
+	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+
+	cpumask_set_cpu(0, &clip_cpus);
+	data->cdev = cpufreq_cooling_register(&clip_cpus);
+	if (IS_ERR(data->cdev)) {
+		ret = PTR_ERR(data->cdev);
+		dev_err(&pdev->dev,
+			"failed to register cpufreq cooling device: %d\n", ret);
+		return ret;
+	}
+
+	data->tz = thermal_zone_device_register("imx_thermal_zone",
+						IMX_TRIP_NUM, 0, data,
+						&imx_tz_ops, NULL, 0,
+						IMX_THERMAL_POLLING_INTERVAL);
+	if (IS_ERR(data->tz)) {
+		ret = PTR_ERR(data->tz);
+		dev_err(&pdev->dev,
+			"failed to register thermal zone device %d\n", ret);
+		cpufreq_cooling_unregister(data->cdev);
+		return ret;
+	}
+
+	data->mode = THERMAL_DEVICE_ENABLED;
+
+	return 0;
+}
+
+static int imx_thermal_remove(struct platform_device *pdev)
+{
+	struct imx_thermal_data *data = platform_get_drvdata(pdev);
+
+	thermal_zone_device_unregister(data->tz);
+	cpufreq_cooling_unregister(data->cdev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int imx_thermal_suspend(struct device *dev)
+{
+	struct imx_thermal_data *data = dev_get_drvdata(dev);
+	struct regmap *map = data->tempmon;
+	u32 val;
+
+	regmap_read(map, TEMPSENSE0, &val);
+
+	/* Was a measurement taking place?  If not, nothing to do. */
+	if (val & TEMPSENSE0_POWER_DOWN)
+		return 0;
+
+	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
+	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+
+	data->meas_suspended = true;
+
+	return 0;
+}
+
+static int imx_thermal_resume(struct device *dev)
+{
+	struct imx_thermal_data *data = dev_get_drvdata(dev);
+	struct regmap *map = data->tempmon;
+
+	/*
+	 * If a measurement was taking place while suspend, re-take the
+	 * measurement.
+	 */
+	if (data->meas_suspended) {
+		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
+		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+		/*
+		 * According to the temp sensor designers, it may require
+		 * up to ~17us to complete a measurement.  But this timing
+		 * isn't checked on every part nor is it specified in the
+		 * datasheet, so delay 50us for timing margin.
+		 */
+		udelay(50);
+		data->meas_suspended = false;
+	}
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(imx_thermal_pm_ops,
+			 imx_thermal_suspend, imx_thermal_resume);
+
+static const struct of_device_id of_imx_thermal_match[] = {
+	{ .compatible = "fsl,imx6q-tempmon", },
+	{ /* end */ }
+};
+
+static struct platform_driver imx_thermal = {
+	.driver = {
+		.name	= "imx_thermal",
+		.owner  = THIS_MODULE,
+		.pm	= &imx_thermal_pm_ops,
+		.of_match_table = of_imx_thermal_match,
+	},
+	.probe		= imx_thermal_probe,
+	.remove		= imx_thermal_remove,
+};
+
+static int __init imx_thermal_init(void)
+{
+	return platform_driver_register(&imx_thermal);
+}
+late_initcall(imx_thermal_init);
+
+static void __exit imx_thermal_exit(void)
+{
+	platform_driver_unregister(&imx_thermal);
+}
+module_exit(imx_thermal_exit);
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_DESCRIPTION("Thermal driver for Freescale i.MX SoCs");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imx-thermal");
-- 
1.7.9.5


