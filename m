From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V4 2/2] thermal: max77620: Add thermal driver for reporting junction temp
Date: Tue, 7 Jun 2016 16:22:34 +0530
Message-ID: <1465296754-13186-2-git-send-email-ldewangan@nvidia.com>
References: <1465296754-13186-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465296754-13186-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, robh+dt@kernel.org, Keerthy <a0393675@ti.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Maxim Semiconductor Max77620 supports alarm interrupts when
its die temperature crosses 120C and 140C. These threshold
temperatures are not configurable.

Add thermal driver to register PMIC die temperature as thermal
zone sensor and capture the die temperature warning interrupts
to notifying the client.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

---
The patch was sent earlier but dependent mfd header file was not available on tree and hence it was not applied.
The mfd patches are in rc-4.7 and hence resending again this patch.

Changes from V3:
- Added comment on the function get_temp() that absolute temp can not be
  available.

 drivers/thermal/Kconfig            |  10 +++
 drivers/thermal/Makefile           |   1 +
 drivers/thermal/thermal-max77620.c | 165 +++++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 drivers/thermal/thermal-max77620.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 2d702ca..a2b4433 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -195,6 +195,16 @@ config IMX_THERMAL
 	  cpufreq is used as the cooling device to throttle CPUs when the
 	  passive trip is crossed.
 
+config MAX77620_THERMAL
+	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
+	depends on MFD_MAX77620
+	depends on OF
+	help
+	  Support for die junction temperature warning alarm for Maxim
+	  Semiconductor PMIC MAX77620 device. Device generates two alarm
+	  interrupts when PMIC die temperature cross the threshold of
+	  120 degC and 140 degC.
+
 config SPEAR_THERMAL
 	tristate "SPEAr thermal sensor driver"
 	depends on PLAT_SPEAR || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 10b07c1..90e1d7e 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
 obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
+obj-$(CONFIG_MAX77620_THERMAL)	+= thermal-max77620.o
 obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+= db8500_cpufreq_cooling.o
 obj-$(CONFIG_INTEL_POWERCLAMP)	+= intel_powerclamp.o
 obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+= x86_pkg_temp_thermal.o
diff --git a/drivers/thermal/thermal-max77620.c b/drivers/thermal/thermal-max77620.c
new file mode 100644
index 0000000..32ae1be
--- /dev/null
+++ b/drivers/thermal/thermal-max77620.c
@@ -0,0 +1,165 @@
+/*
+ * Junction temperature thermal driver for Maxim Max77620.
+ *
+ * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Author: Laxman Dewangan <ldewangan@nvidia.com>
+ *	   Mallikarjun Kasoju <mkasoju@nvidia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/max77620.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+
+#define MAX77620_NORMAL_OPERATING_TEMP	100000
+#define MAX77620_TJALARM1_TEMP		120000
+#define MAX77620_TJALARM2_TEMP		140000
+
+struct max77620_therm_info {
+	struct device			*dev;
+	struct regmap			*rmap;
+	struct thermal_zone_device	*tz_device;
+	int				irq_tjalarm1;
+	int				irq_tjalarm2;
+};
+
+/**
+ * max77620_thermal_read_temp: Read PMIC die temperatue.
+ * @data:	Device specific data.
+ * temp:	Temperature in millidegrees Celsius
+ *
+ * The actual temperature of PMIC die is not available from PMIC.
+ * PMIC only tells the status if it has crossed or not the threshold level
+ * of 120degC or 140degC.
+ * If threshold has not been crossed then assume die temperature as 100degC
+ * else 120degC or 140deG based on the PMIC die temp threshold status.
+ *
+ * Return 0 on success otherwise error number to show reason of failure.
+ */
+
+static int max77620_thermal_read_temp(void *data, int *temp)
+{
+	struct max77620_therm_info *mtherm = data;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(mtherm->rmap, MAX77620_REG_STATLBT, &val);
+	if (ret < 0) {
+		dev_err(mtherm->dev, "Failed to read STATLBT: %d\n", ret);
+		return ret;
+	}
+
+	if (val & MAX77620_IRQ_TJALRM2_MASK)
+		*temp = MAX77620_TJALARM2_TEMP;
+	else if (val & MAX77620_IRQ_TJALRM1_MASK)
+		*temp = MAX77620_TJALARM1_TEMP;
+	else
+		*temp = MAX77620_NORMAL_OPERATING_TEMP;
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops max77620_thermal_ops = {
+	.get_temp = max77620_thermal_read_temp,
+};
+
+static irqreturn_t max77620_thermal_irq(int irq, void *data)
+{
+	struct max77620_therm_info *mtherm = data;
+
+	if (irq == mtherm->irq_tjalarm1)
+		dev_warn(mtherm->dev, "Junction Temp Alarm1(120C) occurred\n");
+	else if (irq == mtherm->irq_tjalarm2)
+		dev_crit(mtherm->dev, "Junction Temp Alarm2(140C) occurred\n");
+
+	thermal_zone_device_update(mtherm->tz_device);
+
+	return IRQ_HANDLED;
+}
+
+static int max77620_thermal_probe(struct platform_device *pdev)
+{
+	struct max77620_therm_info *mtherm;
+	int ret;
+
+	pdev->dev.of_node = pdev->dev.parent->of_node;
+
+	mtherm = devm_kzalloc(&pdev->dev, sizeof(*mtherm), GFP_KERNEL);
+	if (!mtherm)
+		return -ENOMEM;
+
+	mtherm->irq_tjalarm1 = platform_get_irq(pdev, 0);
+	mtherm->irq_tjalarm2 = platform_get_irq(pdev, 1);
+	if ((mtherm->irq_tjalarm1 < 0) || (mtherm->irq_tjalarm2 < 0)) {
+		dev_err(&pdev->dev, "Alarm irq number not available\n");
+		return -EINVAL;
+	}
+
+	mtherm->dev = &pdev->dev;
+	mtherm->rmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!mtherm->rmap) {
+		dev_err(&pdev->dev, "Failed to get parent regmap\n");
+		return -ENODEV;
+	}
+
+	mtherm->tz_device = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
+				mtherm, &max77620_thermal_ops);
+	if (IS_ERR(mtherm->tz_device)) {
+		ret = PTR_ERR(mtherm->tz_device);
+		dev_err(&pdev->dev, "Failed to register thermal zone: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm1, NULL,
+					max77620_thermal_irq,
+					IRQF_ONESHOT | IRQF_SHARED,
+					dev_name(&pdev->dev), mtherm);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to request irq1: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm2, NULL,
+					max77620_thermal_irq,
+					IRQF_ONESHOT | IRQF_SHARED,
+					dev_name(&pdev->dev), mtherm);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to request irq2: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, mtherm);
+
+	return 0;
+}
+
+static struct platform_device_id max77620_thermal_devtype[] = {
+	{ .name = "max77620-thermal", },
+	{},
+};
+
+static struct platform_driver max77620_thermal_driver = {
+	.driver = {
+		.name = "max77620-thermal",
+	},
+	.probe = max77620_thermal_probe,
+	.id_table = max77620_thermal_devtype,
+};
+
+module_platform_driver(max77620_thermal_driver);
+
+MODULE_DESCRIPTION("Max77620 Junction temperature Thermal driver");
+MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
+MODULE_AUTHOR("Mallikarjun Kasoju <mkasoju@nvidia.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4
