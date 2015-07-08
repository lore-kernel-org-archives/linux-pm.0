From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 1/9] thermal: qcom: tsens: Add a skeletal TSENS drivers
Date: Wed,  8 Jul 2015 15:17:10 +0530
Message-ID: <1436348838-22671-2-git-send-email-rnayak@codeaurora.org>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

TSENS is Qualcomms' thermal temperature sensor device. It
supports reading temperatures from multiple thermal sensors
present on various QCOM SoCs.
Calibration data is generally read from a eeprom device.

Add a skeleton driver with all the necessary abstractions so
a variety of qcom device families which support TSENS can
add driver extensions.

Also add the required device tree bindings which can be used
to descibe the TSENS device in DT.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Lina Iyer <lina.iyer@linaro.org>
---
 .../devicetree/bindings/thermal/qcom-tsens.txt     |  37 ++++
 drivers/thermal/Kconfig                            |   5 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/qcom/Kconfig                       |  10 +
 drivers/thermal/qcom/Makefile                      |   2 +
 drivers/thermal/qcom/tsens.c                       | 207 +++++++++++++++++++++
 drivers/thermal/qcom/tsens.h                       |  58 ++++++
 7 files changed, 320 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
 create mode 100644 drivers/thermal/qcom/Kconfig
 create mode 100644 drivers/thermal/qcom/Makefile
 create mode 100644 drivers/thermal/qcom/tsens.c
 create mode 100644 drivers/thermal/qcom/tsens.h

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
new file mode 100644
index 0000000..cfb79fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -0,0 +1,37 @@
+* QCOM SoC Temperature Sensor (TSENS)
+
+Required properties:
+- compatible :
+ - "qcom,msm8916-tsens" : For 8916 Family of SoCs
+ - "qcom,msm8974-tsens" : For 8974 Family of SoCs
+ - "qcom,msm8960-tsens" : For 8960 Family of SoCs
+
+- reg: Address range of the thermal registers
+- qcom,tsens-slopes : Must contain slope value for each of the sensors controlled
+			by this device
+- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
+- Refer to Documentation/devicetree/bindings/eeprom/eeprom.txt to know how to specify
+an eeprom cell
+
+Optional properties:
+- qcom,sensor-id: List of sensor instances used in a given SoC. A TSENS IP can
+		  have a fixed number of sensors (like 11) but a given SoC can
+		  use only 5 of these and they might not always the first 5. They
+		  could be sensors 0, 1, 4, 8 and 9. This property is used to
+		  describe the subset of the sensors used. If this property is
+		  missing they are assumed to be the first 'n' sensors numbered
+		  sequentially in which case the number of sensors defaults to
+		  the number of slope values.
+
+Example:
+tsens: thermal-sensor@900000 {
+		compatible = "qcom,msm8916-tsens";
+		qcom,tsens-slopes = <1176 1176 1154 1176 1111
+				1132 1132 1199 1132 1199
+				1132>;
+		calib_data = <&tsens_caldata>;
+		calib_sel = <&tsens_calsel>;
+		qcom,tsens-slopes = <3200 3200 3200 3200 3200>;
+		qcom,sensor-id = <0 1 2 4 5>;
+		#thermal-sensor-cells = <1>;
+	};
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 118938e..8f47021 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -365,4 +365,9 @@ config QCOM_SPMI_TEMP_ALARM
 	  real time die temperature if an ADC is present or an estimate of the
 	  temperature based upon the over temperature stage value.
 
+menu "Qualcomm thermal drivers"
+depends on ARCH_QCOM && OF
+source "drivers/thermal/qcom/Kconfig"
+endmenu
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 535dfee..011fa57 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -42,5 +42,6 @@ obj-$(CONFIG_INTEL_QUARK_DTS_THERMAL)	+= intel_quark_dts_thermal.o
 obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
 obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
 obj-$(CONFIG_ST_THERMAL)	+= st/
+obj-$(CONFIG_QCOM_TSENS)	+= qcom/
 obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra_soctherm.o
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
new file mode 100644
index 0000000..9bfde94e
--- /dev/null
+++ b/drivers/thermal/qcom/Kconfig
@@ -0,0 +1,10 @@
+config QCOM_TSENS
+	tristate "Qualcomm TSENS Temperature Alarm"
+	depends on THERMAL
+	depends on QCOM_QFPROM
+	help
+	  This enables the thermal sysfs driver for the Tsens device. It shows
+	  up in Sysfs as a thermal zone with multiple trip points. Disabling the
+	  thermal zone device via the mode file results in disabling the sensor.
+	  Also able to set threshold temperature for both hot and cold and update
+	  when a threshold is reached.
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
new file mode 100644
index 0000000..401069b
--- /dev/null
+++ b/drivers/thermal/qcom/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
+qcom_tsens-y			+= tsens.o
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
new file mode 100644
index 0000000..d32d278
--- /dev/null
+++ b/drivers/thermal/qcom/tsens.c
@@ -0,0 +1,207 @@
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include "tsens.h"
+
+static int tsens_get_temp(void *data, long *temp)
+{
+	const struct tsens_sensor *s = data;
+	struct tsens_device *tmdev = s->tmdev;
+
+	return tmdev->ops->get_temp(tmdev, s->id, temp);
+}
+
+static int tsens_get_trend(void *data, long *temp)
+{
+	const struct tsens_sensor *s = data;
+	struct tsens_device *tmdev = s->tmdev;
+
+	if (tmdev->ops->get_trend)
+		return tmdev->ops->get_trend(tmdev, s->id, temp);
+
+	return -ENOSYS;
+}
+
+#ifdef CONFIG_PM
+static int tsens_suspend(struct device *dev)
+{
+	struct tsens_device *tmdev = dev_get_drvdata(dev);
+
+	if (tmdev->ops && tmdev->ops->suspend)
+		return tmdev->ops->suspend(tmdev);
+
+	return 0;
+}
+
+static int tsens_resume(struct device *dev)
+{
+	struct tsens_device *tmdev = dev_get_drvdata(dev);
+
+	if (tmdev->ops && tmdev->ops->resume)
+		return tmdev->ops->resume(tmdev);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
+#define TSENS_PM_OPS   (&tsens_pm_ops)
+
+#else /* CONFIG_PM_SLEEP */
+#define TSENS_PM_OPS NULL
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct of_device_id tsens_table[] = {
+	{
+		.compatible = "qcom,msm8960-tsens",
+	}, {
+		.compatible = "qcom,msm8916-tsens",
+		.data = &ops_8916,
+	}, {
+		.compatible = "qcom,msm8974-tsens",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, tsens_table);
+
+static const struct thermal_zone_of_device_ops tsens_of_ops = {
+	.get_temp = tsens_get_temp,
+	.get_trend = tsens_get_trend,
+};
+
+static int tsens_register(struct tsens_device *tmdev)
+{
+	int i, ret;
+	struct thermal_zone_device *tzd;
+	u32 *hw_id, n = tmdev->num_sensors;
+	struct device_node *np = tmdev->dev->of_node;
+
+	hw_id = devm_kcalloc(tmdev->dev, n, sizeof(u32), GFP_KERNEL);
+	if (!hw_id)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, "qcom,sensor-id", hw_id, n);
+	if (ret)
+		for (i = 0;  i < tmdev->num_sensors; i++)
+			tmdev->sensor[i].hw_id = i;
+	else
+		for (i = 0;  i < tmdev->num_sensors; i++)
+			tmdev->sensor[i].hw_id = hw_id[i];
+
+	for (i = 0;  i < tmdev->num_sensors; i++) {
+		tmdev->sensor[i].tmdev = tmdev;
+		tmdev->sensor[i].id = i;
+		tzd = thermal_zone_of_sensor_register(tmdev->dev, i,
+						      &tmdev->sensor[i],
+						      &tsens_of_ops);
+		if (IS_ERR(tzd))
+			continue;
+		tmdev->sensor[i].tzd = tzd;
+		if (tmdev->ops->enable)
+			tmdev->ops->enable(tmdev, i);
+	}
+	return 0;
+}
+
+static int tsens_probe(struct platform_device *pdev)
+{
+	int ret, i, num;
+	struct device_node *np = pdev->dev.of_node;
+	struct tsens_sensor *s;
+	struct tsens_device *tmdev;
+	const struct of_device_id *id;
+
+	num = of_property_count_u32_elems(np, "qcom,tsens-slopes");
+	if (num <= 0) {
+		dev_err(&pdev->dev, "invalid tsens slopes\n");
+		return -EINVAL;
+	}
+
+	tmdev = devm_kzalloc(&pdev->dev, sizeof(*tmdev) +
+			     num * sizeof(*s), GFP_KERNEL);
+	if (!tmdev)
+		return -ENOMEM;
+
+	tmdev->dev = &pdev->dev;
+	tmdev->num_sensors = num;
+
+	for (i = 0, s = tmdev->sensor; i < tmdev->num_sensors; i++, s++)
+		of_property_read_u32_index(np, "qcom,tsens-slopes", i,
+					   &s->slope);
+
+	id = of_match_node(tsens_table, np);
+	if (!id)
+		return -ENODEV;
+
+	tmdev->ops = id->data;
+	if (!tmdev->ops || !tmdev->ops->init || !tmdev->ops->calibrate ||
+	    !tmdev->ops->get_temp)
+		return -EINVAL;
+
+	ret = tmdev->ops->init(tmdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "tsens init failed\n");
+		return ret;
+	}
+
+	ret = tmdev->ops->calibrate(tmdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "tsens calibration failed\n");
+		return ret;
+	}
+
+	ret = tsens_register(tmdev);
+
+	platform_set_drvdata(pdev, tmdev);
+
+	return ret;
+}
+
+static int tsens_remove(struct platform_device *pdev)
+{
+	int i;
+	struct tsens_device *tmdev = platform_get_drvdata(pdev);
+	struct thermal_zone_device *tzd;
+
+	if (tmdev->ops->disable)
+		tmdev->ops->disable(tmdev);
+
+	for (i = 0; i < tmdev->num_sensors; i++) {
+		tzd = tmdev->sensor[i].tzd;
+		thermal_zone_of_sensor_unregister(&pdev->dev, tzd);
+	}
+
+	return 0;
+}
+
+static struct platform_driver tsens_driver = {
+	.probe = tsens_probe,
+	.remove = tsens_remove,
+	.driver = {
+		.name = "qcom-tsens",
+		.pm	= TSENS_PM_OPS,
+		.of_match_table = tsens_table,
+	},
+};
+module_platform_driver(tsens_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("QCOM Temperature Sensor driver");
+MODULE_ALIAS("platform:qcom-tsens");
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
new file mode 100644
index 0000000..9b274e1
--- /dev/null
+++ b/drivers/thermal/qcom/tsens.h
@@ -0,0 +1,58 @@
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __QCOM_TSENS_H__
+#define __QCOM_TSENS_H__
+
+struct tsens_device;
+
+struct tsens_sensor {
+	struct tsens_device		*tmdev;
+	struct thermal_zone_device	*tzd;
+	int				offset;
+	int				id;
+	int				hw_id;
+	u32				slope;
+	u32				status;
+};
+
+struct tsens_ops {
+	/* mandatory callbacks */
+	int (*init)(struct tsens_device *);
+	int (*calibrate)(struct tsens_device *);
+	int (*get_temp)(struct tsens_device *, int, long *);
+	/* optional callbacks */
+	int (*enable)(struct tsens_device *, int);
+	void (*disable)(struct tsens_device *);
+	int (*suspend)(struct tsens_device *);
+	int (*resume)(struct tsens_device *);
+	int (*get_trend)(struct tsens_device *, int, long *);
+};
+
+/* Registers to be saved/restored across a context loss */
+struct tsens_context {
+	int	threshold;
+	int	control;
+};
+
+struct tsens_device {
+	struct device			*dev;
+	u32				num_sensors;
+	struct regmap			*map;
+	struct regmap_field		*status_field;
+	struct tsens_context		ctx;
+	bool				trdy;
+	const struct tsens_ops		*ops;
+	struct tsens_sensor		sensor[0];
+};
+
+#endif /* __QCOM_TSENS_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
