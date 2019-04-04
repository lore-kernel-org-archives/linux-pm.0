From: Talel Shenhar <talel@amazon.com>
Subject: [PATCH v2 2/2] thermal: Introduce Amazon's Annapurna Labs Thermal Driver
Date: Thu, 4 Apr 2019 13:16:56 +0300
Message-ID: <1554373016-1442-3-git-send-email-talel@amazon.com>
References: <1554373016-1442-1-git-send-email-talel@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554373016-1442-1-git-send-email-talel@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: talel@amazon.com, robh@kernel.org, edubezval@gmail.com, dwmw@amazon.co.uk, jonnyc@amazon.com, rui.zhang@intel.com, hhhawa@amazon.com, ronenk@amazon.com, hanochu@amazon.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is a generic thermal driver for simple MMIO sensors, of which
amazon,al-thermal is one.

This device uses a single MMIO transaction to read the temperature and
report it to the thermal subsystem.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
 MAINTAINERS                    |   6 ++
 drivers/thermal/Kconfig        |  10 ++++
 drivers/thermal/Makefile       |   1 +
 drivers/thermal/thermal_mmio.c | 129 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 146 insertions(+)
 create mode 100644 drivers/thermal/thermal_mmio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 955463f..262cb2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -727,6 +727,12 @@ S:	Supported
 F:	Documentation/networking/ena.txt
 F:	drivers/net/ethernet/amazon/
 
+AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
+M:	Talel Shenhar <talel@amazon.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
+F:	drivers/thermal/thermal_mmio.c
+
 AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER
 M:	Tom Lendacky <thomas.lendacky@amd.com>
 M:	Gary Hook <gary.hook@amd.com>
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 1775d44..96d9236 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -199,6 +199,16 @@ config THERMAL_EMULATION
 	  because userland can easily disable the thermal policy by simply
 	  flooding this sysfs node with low temperature values.
 
+config THERMAL_MMIO
+	tristate "Generic Thermal MMIO driver"
+	depends on OF || COMPILE_TEST
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
index 82bb50d..d4c9ae7 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -29,6 +29,7 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
 # platform thermal drivers
 obj-y				+= broadcom/
+obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
 obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
 obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
new file mode 100644
index 0000000..de3ccee
--- /dev/null
+++ b/drivers/thermal/thermal_mmio.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+struct thermal_mmio {
+	void __iomem *mmio_base;
+	u32 (*read_mmio)(void __iomem *mmio_base);
+	u32 mask;
+	int factor;
+};
+
+static u32 thermal_mmio_readb(void __iomem *mmio_base)
+{
+	return readb(mmio_base);
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
+static int thermal_mmio_probe(struct platform_device *pdev)
+{
+	struct resource *resource;
+	struct thermal_mmio *sensor;
+	int (*sensor_init_func)(struct platform_device *pdev,
+				struct thermal_mmio *sensor);
+	struct thermal_zone_device *thermal_zone;
+	int ret;
+	int temperature;
+
+	sensor = devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
+	if (!sensor)
+		return -ENOMEM;
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
+	sensor_init_func = device_get_match_data(&pdev->dev);
+	if (sensor_init_func) {
+		ret = sensor_init_func(pdev, sensor);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to initialize sensor (%d)\n",
+				ret);
+			return ret;
+		}
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
+static int al_thermal_init(struct platform_device *pdev,
+			   struct thermal_mmio *sensor)
+{
+	sensor->read_mmio = thermal_mmio_readb;
+	sensor->mask = 0xff;
+	sensor->factor = 1000;
+
+	return 0;
+}
+
+static const struct of_device_id thermal_mmio_id_table[] = {
+	{ .compatible = "amazon,al-thermal", .data = al_thermal_init},
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
