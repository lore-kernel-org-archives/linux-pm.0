From: Talel Shenhar <talel@amazon.com>
Subject: [PATCH 2/2] thermal: Introduce thermal MMIO
Date: Sun, 3 Mar 2019 10:49:26 +0200
Message-ID: <1551602966-2334-3-git-send-email-talel@amazon.com>
References: <1551602966-2334-1-git-send-email-talel@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551602966-2334-1-git-send-email-talel@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com, ronenk@amazon.com, hanochu@amazon.com
List-Id: linux-pm@vger.kernel.org

This patch introduces a generic thermal driver, which enables easy
connectivity between "simple" thermal HW devices and the thermal
subsystem.

"simple" may be any system that allows temperature reading via a single
memory-mapped read, be it register or shared memory, and that doesn't
require any HW configuration to be done by the driver.
Such "simple" HW is a candidate to work with this driver.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 drivers/thermal/Kconfig        |  11 +++
 drivers/thermal/Makefile       |   3 +
 drivers/thermal/thermal_mmio.c | 214 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)
 create mode 100644 drivers/thermal/thermal_mmio.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 1775d44..0033ba2 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -199,6 +199,17 @@ config THERMAL_EMULATION
 	  because userland can easily disable the thermal policy by simply
 	  flooding this sysfs node with low temperature values.
 
+config THERMAL_MMIO
+	bool
+	depends on OF || COMPILE_TEST
+	prompt "mmio thermal driver"
+	help
+	  This option enables the generic thermal MMIO driver that will use
+	  memory-mapped reads to get the temperature.  Any HW/System that
+	  allows temperature reading by a single memory-mapped reading, be it
+	  register or shared memory, is a potential candidate to work with this
+	  driver.
+
 config HISI_THERMAL
 	tristate "Hisilicon thermal driver"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 82bb50d..beec616 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -27,6 +27,9 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
 # devfreq cooling
 thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
+# generic memory mapped thermal driver
+thermal_sys-$(CONFIG_THERMAL_MMIO)	+= thermal_mmio.o
+
 # platform thermal drivers
 obj-y				+= broadcom/
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
new file mode 100644
index 0000000..1119e71
--- /dev/null
+++ b/drivers/thermal/thermal_mmio.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#define THERMAL_MMIO_DEFAULT_SENSOR_WIDTH sizeof(u32)
+#define THERMAL_MMIO_DEFAULT_SENSOR_FACTOR 1
+#define THERMAL_MMIO_DEFAULT_SENSOR_BIAS 0
+#define THERMAL_MMIO_DEFAULT_SENSOR_DIVIDER 1
+
+struct thermal_mmio {
+	void __iomem *mmio_base;
+	u32 (*read_mmio)(void __iomem *mmio_base);
+	int width;
+	u32 mask;
+	int factor;
+	int bias;
+	int divider;
+};
+
+static u32 thermal_mmio_readb(void __iomem *mmio_base)
+{
+	return readb(mmio_base);
+}
+
+static u32 thermal_mmio_readw(void __iomem *mmio_base)
+{
+	return readw(mmio_base);
+}
+
+static u32 thermal_mmio_readl(void __iomem *mmio_base)
+{
+	return readl(mmio_base);
+}
+
+static int thermal_mmio_get_temperature(void *private, int *temp)
+{
+	int t;
+	struct thermal_mmio *sensor =
+		(struct thermal_mmio *)private;
+
+	t = sensor->read_mmio(sensor->mmio_base) & sensor->mask;
+	t *= sensor->factor;
+	t += sensor->bias;
+	t /= sensor->divider;
+
+	*temp = t;
+
+	return 0;
+}
+
+static struct thermal_zone_of_device_ops thermal_mmio_ops = {
+	.get_temp = thermal_mmio_get_temperature,
+};
+
+static int thermal_mmio_parse_dt(struct platform_device *pdev,
+				 struct thermal_mmio *sensor)
+{
+	struct resource *resource;
+	int ret;
+
+	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (IS_ERR(resource)) {
+		dev_err(&pdev->dev,
+			"fail to get platform memory resource (%ld)\n",
+			PTR_ERR(resource));
+		return PTR_ERR(resource);
+	}
+
+	sensor->mmio_base = devm_ioremap_resource(&pdev->dev, resource);
+	if (IS_ERR(sensor->mmio_base)) {
+		dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",
+			PTR_ERR(sensor->mmio_base));
+		return PTR_ERR(sensor->mmio_base);
+	}
+
+	ret = of_property_read_u32(pdev->dev.of_node, "sensor-width",
+				   &sensor->width);
+	if (ret < 0) {
+		sensor->width = THERMAL_MMIO_DEFAULT_SENSOR_WIDTH;
+		dev_dbg(&pdev->dev,
+			"sensor-width undefined (%d) - using default: %d\n",
+			ret, sensor->width);
+	}
+
+	ret = of_property_read_u32(pdev->dev.of_node, "sensor-mask",
+				   &sensor->mask);
+	if (ret < 0) {
+		sensor->mask = GENMASK(sizeof(u32) * BITS_PER_BYTE - 1, 0);
+		dev_dbg(&pdev->dev,
+			"sensor-mask undefined (%d) - using default: 0x%x\n",
+			ret, sensor->mask);
+	}
+
+	ret = of_property_read_s32(pdev->dev.of_node, "sensor-factor",
+				   &sensor->factor);
+	if (ret < 0) {
+		sensor->factor = THERMAL_MMIO_DEFAULT_SENSOR_FACTOR;
+		dev_dbg(&pdev->dev,
+			"sensor-factor undefined (%d) - using default: %d\n",
+			ret, sensor->factor);
+	}
+
+	ret = of_property_read_s32(pdev->dev.of_node, "sensor-bias",
+				   &sensor->bias);
+	if (ret < 0) {
+		sensor->bias = THERMAL_MMIO_DEFAULT_SENSOR_BIAS;
+		dev_dbg(&pdev->dev,
+			"sensor-bias undefined (%d) - using default: %d\n",
+			ret, sensor->bias);
+	}
+
+	ret = of_property_read_u32(pdev->dev.of_node, "sensor-divider",
+				   &sensor->divider);
+	if (ret < 0) {
+		sensor->divider = THERMAL_MMIO_DEFAULT_SENSOR_DIVIDER;
+		dev_dbg(&pdev->dev,
+			"sensor-divider undefined (%d) - using default: %d\n",
+			ret, sensor->divider);
+	}
+
+	/* configuration value sanity */
+	if (sensor->width > resource_size(resource)) {
+		dev_err(&pdev->dev,
+			"too small MMIO size, expected (%d) < supplied (%d)\n",
+			sensor->width, (int)resource_size(resource));
+		return -EINVAL;
+	}
+
+	dev_dbg(&pdev->dev,
+		"width=%d, mask=0x%x factor=%d bias=%d divider=%d\n",
+		sensor->width, sensor->mask, sensor->factor, sensor->bias,
+		sensor->divider);
+
+	return 0;
+}
+
+static int thermal_mmio_probe(struct platform_device *pdev)
+{
+	struct thermal_mmio *sensor;
+	struct thermal_zone_device *thermal_zone;
+	int ret;
+	int temperature;
+
+	sensor = devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
+	if (!sensor)
+		return -ENOMEM;
+
+	ret = thermal_mmio_parse_dt(pdev, sensor);
+	if (ret) {
+		dev_err(&pdev->dev, "fail to parse dt\n");
+		return ret;
+	}
+
+	switch (sensor->width) {
+	case sizeof(u8):
+		sensor->read_mmio = thermal_mmio_readb;
+		break;
+	case sizeof(u16):
+		sensor->read_mmio = thermal_mmio_readw;
+		break;
+	case sizeof(u32):
+		sensor->read_mmio = thermal_mmio_readl;
+		break;
+	default:
+		dev_err(&pdev->dev, "bad sensor-width property supplied: %d\n",
+			sensor->width);
+		return -EINVAL;
+	}
+
+	thermal_zone = devm_thermal_zone_of_sensor_register(&pdev->dev,
+							    0,
+							    sensor,
+							    &thermal_mmio_ops);
+	if (IS_ERR(thermal_zone)) {
+		dev_err(&pdev->dev,
+			"failed to register sensor (%ld)\n",
+			PTR_ERR(thermal_zone));
+		return PTR_ERR(thermal_zone);
+	}
+
+	thermal_mmio_get_temperature(sensor, &temperature);
+	dev_info(&pdev->dev,
+		 "thermal mmio sensor %s registered, current temperature: %d\n",
+		 pdev->name, temperature);
+
+	return 0;
+}
+
+static const struct of_device_id thermal_mmio_id_table[] = {
+	{ .compatible = "thermal-mmio" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, thermal_mmio_id_table);
+
+static struct platform_driver thermal_mmio_driver = {
+	.probe = thermal_mmio_probe,
+	.driver = {
+		.name = "thermal-mmio",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(thermal_mmio_id_table),
+	},
+};
+
+module_platform_driver(thermal_mmio_driver);
+
+MODULE_AUTHOR("Talel Shenhar <talel@amazon.com>");
+MODULE_DESCRIPTION("Thermal MMIO Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
