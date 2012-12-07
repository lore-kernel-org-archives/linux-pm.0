From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH 1/2] thermal: Add support for thermal sensor for Kirkwood SoC
Date: Sat,  8 Dec 2012 08:15:50 +0900
Message-ID: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49833 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031009Ab2LGXD0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Dec 2012 18:03:26 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so780216pad.19
        for <linux-pm@vger.kernel.org>; Fri, 07 Dec 2012 15:03:25 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, jason@lakedaemon.net, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Some kirkwood SoC has thermal sensor.
This patch adds support for 88F6282 and 88F6283.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/thermal/Kconfig            |    7 ++
 drivers/thermal/Makefile           |    1 +
 drivers/thermal/kirkwood_thermal.c |  131 ++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 drivers/thermal/kirkwood_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e1cb6bd..8710ac2 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -55,3 +55,10 @@ config EXYNOS_THERMAL
 	help
 	  If you say yes here you get support for TMU (Thermal Managment
 	  Unit) on SAMSUNG EXYNOS series of SoC.
+
+config KIRKWOOD_THERMAL
+	tristate "Temperature sensor on Marvel Kirkwood"
+	depends on ARCH_KIRKWOOD && THERMAL
+	help
+	  Support for the Kirkwood thermal sensor driver into the Linux thermal
+	  framework. This supports only 88F6282 and 88F6283.
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 885550d..4dbe5e1 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -6,4 +6,5 @@ obj-$(CONFIG_THERMAL)		+= thermal_sys.o
 obj-$(CONFIG_CPU_THERMAL)		+= cpu_cooling.o
 obj-$(CONFIG_SPEAR_THERMAL)		+= spear_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
+obj-$(CONFIG_KIRKWOOD_THERMAL)         += kirkwood_thermal.o
 obj-$(CONFIG_EXYNOS_THERMAL)		+= exynos_thermal.o
diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
new file mode 100644
index 0000000..bddcf49
--- /dev/null
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -0,0 +1,131 @@
+/*
+ * kirkwood thermal sensor driver
+ *
+ * Copyright (C) 2012 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#define THERMAL_VALID_OFFSET	9
+#define THERMAL_VALID_MASK	0x1
+#define THERMAL_TEMP_OFFSET	10
+#define THERMAL_TEMP_MASK	0x1FF
+
+/* Kirkwood Thermal Sensor Dev Structure */
+struct kirkwood_thermal_dev {
+	void __iomem *base_addr;
+};
+
+static inline int kirkwood_get_temp(struct thermal_zone_device *thermal,
+			unsigned long *temp)
+{
+	unsigned long reg;
+	struct kirkwood_thermal_dev *thermal_dev = thermal->devdata;
+
+	reg = readl_relaxed(thermal_dev->base_addr);
+
+	/* Valid check */
+	if (!(reg >> THERMAL_VALID_OFFSET) & THERMAL_VALID_MASK) {
+		dev_info(&thermal->device, "Reading temperature is not valid\n");
+		return -EIO;
+	}
+
+	reg = (reg >> THERMAL_TEMP_OFFSET) & THERMAL_TEMP_MASK;
+	/* Calculate temperature. See Table 814 in hardware manual. */
+	*temp = ((322 - reg) * 10000) / 13625;
+
+	return 0;
+}
+
+static struct thermal_zone_device_ops ops = {
+	.get_temp = kirkwood_get_temp,
+};
+
+static int kirkwood_thermal_probe(struct platform_device *pdev)
+{
+	struct thermal_zone_device *thermal = NULL;
+	struct kirkwood_thermal_dev *thermal_dev;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get platform resource\n");
+		return -ENODEV;
+	}
+
+	thermal_dev
+		= devm_kzalloc(&pdev->dev, sizeof(*thermal_dev), GFP_KERNEL);
+	if (!thermal_dev) {
+		dev_err(&pdev->dev, "kzalloc fail\n");
+		return -ENOMEM;
+	}
+
+	thermal_dev->base_addr = devm_ioremap(&pdev->dev, res->start,
+				resource_size(res));
+	if (!thermal_dev->base_addr) {
+		dev_err(&pdev->dev, "Failed to ioremap memory\n");
+		return -ENOMEM;
+	}
+
+	thermal = thermal_zone_device_register("kirkwood_thermal", 0, 0,
+				   thermal_dev, &ops, 0, 0);
+	if (IS_ERR(thermal)) {
+		dev_err(&pdev->dev, "Failed to register thermal zone device\n");
+		return  PTR_ERR(thermal);
+	}
+
+	platform_set_drvdata(pdev, thermal);
+
+	dev_info(&thermal->device, KBUILD_MODNAME ": Thermal sensor registered\n");
+
+	return 0;
+}
+
+static int kirkwood_thermal_exit(struct platform_device *pdev)
+{
+	struct thermal_zone_device *kirkwood_thermal
+			= platform_get_drvdata(pdev);
+
+	thermal_zone_device_unregister(kirkwood_thermal);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static const struct of_device_id kirkwood_thermal_id_table[] = {
+	{ .compatible = "marvel,thermal-kirkwood" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, kirkwood_thermal_id_table);
+
+static struct platform_driver kirkwood_thermal_driver = {
+	.probe = kirkwood_thermal_probe,
+	.remove = kirkwood_thermal_exit,
+	.driver = {
+		.name = "kirkwood_thermal",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(kirkwood_thermal_id_table),
+	},
+};
+
+module_platform_driver(kirkwood_thermal_driver);
+
+MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu@nigauri.org>");
+MODULE_DESCRIPTION("kirkwood thermal driver");
+MODULE_LICENSE("GPL");
-- 
1.7.10.4

