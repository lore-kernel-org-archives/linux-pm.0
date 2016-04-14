From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V3 2/2] thermal: generic-adc: Add ADC based thermal sensor driver
Date: Thu, 14 Apr 2016 20:11:18 +0530
Message-ID: <1460644878-19943-2-git-send-email-ldewangan@nvidia.com>
References: <1460644878-19943-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460644878-19943-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh@kernel.org, edubezval@gmail.com, rui.zhang@intel.com, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, jic23@kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pm@vger.kernel.org

In some of platform, thermal sensors like NCT thermistors are
connected to the one of ADC channel. The temperature is read by
reading the voltage across the sensor resistance via ADC. Lookup
table for ADC read value to temperature is referred to get
temperature. ADC is read via IIO framework.

Add support for thermal sensor driver which read the voltage across
sensor resistance from ADC through IIO framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

---
Changes from V1:
- Use the two dimensional lookup table for temperature vs ADC value.
- Use non devm_ for thermal zone sensor registration as there may be
  race between IIO channel release and temperature read.

Changes from V2:
- None.

 drivers/thermal/Kconfig               |  10 ++
 drivers/thermal/Makefile              |   1 +
 drivers/thermal/thermal-generic-adc.c | 195 ++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100644 drivers/thermal/thermal-generic-adc.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 594748e..d7d0136 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -400,4 +400,14 @@ config QCOM_SPMI_TEMP_ALARM
 	  real time die temperature if an ADC is present or an estimate of the
 	  temperature based upon the over temperature stage value.
 
+config GENERIC_ADC_THERMAL
+	tristate "Generic ADC based thermal sensor"
+	depends on IIO
+	help
+	  This enabled a thermal sysfs driver for the temperature sensor
+	  which is connected to the General Purpose ADC. The ADC channel
+	  is read via IIO framework and the channel information is provided
+	  to this driver. This driver reports the temperature by reading ADC
+	  channel and converts it to temperature based on lookup table.
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index d64f7f7..904593a 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -49,3 +49,4 @@ obj-$(CONFIG_ST_THERMAL)	+= st/
 obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra/
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
 obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
+obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
new file mode 100644
index 0000000..902cf12
--- /dev/null
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -0,0 +1,195 @@
+/*
+ * Generic ADC thermal driver
+ *
+ * Copyright (C) 2016 NVIDIA CORPORATION. All rights reserved.
+ *
+ * Author: Laxman Dewangan <ldewangan@nvidia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/iio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+
+struct gadc_thermal_info {
+	struct device *dev;
+	struct thermal_zone_device *tz_dev;
+	struct iio_channel *channel;
+	s32 *lookup_table;
+	int nlookup_table;
+};
+
+static int gadc_thermal_read_channel(struct gadc_thermal_info *gti, int *val)
+{
+	int ret;
+
+	ret = iio_read_channel_processed(gti->channel, val);
+	if (ret < 0)
+		ret = iio_read_channel_raw(gti->channel, val);
+	if (ret < 0)
+		return ret;
+
+	return ret;
+}
+
+static int gadc_thermal_adc_to_temp(struct gadc_thermal_info *gti, int val)
+{
+	int temp, adc_hi, adc_lo;
+	int i;
+
+	for (i = 0; i < gti->nlookup_table; i++) {
+		if (val >= gti->lookup_table[2 * i + 1])
+			break;
+	}
+
+	if (i == 0) {
+		temp = gti->lookup_table[0];
+	} else if (i >= (gti->nlookup_table - 1)) {
+		temp = gti->lookup_table[2 * (gti->nlookup_table - 1)];
+	} else {
+		adc_hi = gti->lookup_table[2 * i - 1];
+		adc_lo = gti->lookup_table[2 * i + 1];
+		temp = gti->lookup_table[2 * i];
+		temp -= ((val - adc_lo) * 1000) / (adc_hi - adc_lo);
+	}
+
+	return temp;
+}
+
+static int gadc_thermal_get_temp(void *data, int *temp)
+{
+	struct gadc_thermal_info *gti = data;
+	int val;
+	int ret;
+
+	ret = gadc_thermal_read_channel(gti, &val);
+	if (ret < 0) {
+		dev_err(gti->dev, "IIO channel read failed %d\n", ret);
+		return ret;
+	}
+	*temp = gadc_thermal_adc_to_temp(gti, val);
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops gadc_thermal_ops = {
+	.get_temp = gadc_thermal_get_temp,
+};
+
+static int gadc_thermal_read_linear_lookup_table(struct device *dev,
+						 struct gadc_thermal_info *gti)
+{
+	struct device_node *np = dev->of_node;
+	int ntable;
+	int ret;
+
+	ntable = of_property_count_elems_of_size(np, "temperature-lookup-table",
+						 sizeof(u32));
+	if (ntable < 0) {
+		dev_err(dev, "Lookup table is not provided\n");
+		return ntable;
+	}
+
+	if (ntable % 2) {
+		dev_err(dev, "Pair of temperature vs ADC read value missing\n");
+		return -EINVAL;
+	}
+
+	gti->lookup_table = devm_kzalloc(dev, sizeof(*gti->lookup_table) *
+					 ntable, GFP_KERNEL);
+	if (!gti->lookup_table)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, "temperature-lookup-table",
+					 (u32 *)gti->lookup_table, ntable);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read temperature lookup table: %d\n",
+			ret);
+		return ret;
+	}
+
+	gti->nlookup_table = ntable / 2;
+
+	return 0;
+}
+
+static int gadc_thermal_probe(struct platform_device *pdev)
+{
+	struct gadc_thermal_info *gti;
+	int ret;
+
+	if (!pdev->dev.of_node) {
+		dev_err(&pdev->dev, "Only DT based supported\n");
+		return -ENODEV;
+	}
+
+	gti = devm_kzalloc(&pdev->dev, sizeof(*gti), GFP_KERNEL);
+	if (!gti)
+		return -ENOMEM;
+
+	ret = gadc_thermal_read_linear_lookup_table(&pdev->dev, gti);
+	if (ret < 0)
+		return ret;
+
+	gti->dev = &pdev->dev;
+	platform_set_drvdata(pdev, gti);
+
+	gti->channel = iio_channel_get(&pdev->dev, "sensor-channel");
+	if (IS_ERR(gti->channel)) {
+		ret = PTR_ERR(gti->channel);
+		dev_err(&pdev->dev, "IIO channel not found: %d\n", ret);
+		return ret;
+	}
+
+	gti->tz_dev = thermal_zone_of_sensor_register(&pdev->dev, 0,
+						      gti, &gadc_thermal_ops);
+	if (IS_ERR(gti->tz_dev)) {
+		ret = PTR_ERR(gti->tz_dev);
+		dev_err(&pdev->dev, "Thermal zone sensor register failed: %d\n",
+			ret);
+		goto sensor_fail;
+	}
+
+	return 0;
+
+sensor_fail:
+	iio_channel_release(gti->channel);
+
+	return ret;
+}
+
+static int gadc_thermal_remove(struct platform_device *pdev)
+{
+	struct gadc_thermal_info *gti = platform_get_drvdata(pdev);
+
+	thermal_zone_of_sensor_unregister(&pdev->dev, gti->tz_dev);
+	iio_channel_release(gti->channel);
+
+	return 0;
+}
+
+static const struct of_device_id of_adc_thermal_match[] = {
+	{ .compatible = "generic-adc-thermal", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_adc_thermal_match);
+
+static struct platform_driver gadc_thermal_driver = {
+	.driver = {
+		.name = "generic-adc-thermal",
+		.of_match_table = of_adc_thermal_match,
+	},
+	.probe = gadc_thermal_probe,
+	.remove = gadc_thermal_remove,
+};
+
+module_platform_driver(gadc_thermal_driver);
+
+MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
+MODULE_DESCRIPTION("Generic ADC thermal driver using IIO framework with DT");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4
