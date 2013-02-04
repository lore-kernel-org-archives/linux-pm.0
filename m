From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v4 1/4] thermal: Add support for the thermal sensor on Kirkwood SoCs
Date: Mon,  4 Feb 2013 20:19:17 +0100
Message-ID: <1360005560-21945-2-git-send-email-andrew@lunn.ch>
References: <1359946148.2250.47.camel@rzhang1-mobl4>
 <1360005560-21945-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:51675 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755360Ab3BDTTy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 Feb 2013 14:19:54 -0500
In-Reply-To: <1360005560-21945-1-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jason@lakedaemon.net, rui.zhang@intel.com
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>

From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

This patch adds support for Kirkwood 88F6282 and 88F6283 thermal sensor.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../bindings/thermal/kirkwood-thermal.txt          |   15 +++
 drivers/thermal/Kconfig                            |    8 ++
 drivers/thermal/Makefile                           |    1 +
 drivers/thermal/kirkwood_thermal.c                 |  136 ++++++++++++++++++++
 4 files changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
 create mode 100644 drivers/thermal/kirkwood_thermal.c

diff --git a/Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt b/Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
new file mode 100644
index 0000000..8c0f5eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
@@ -0,0 +1,15 @@
+* Kirkwood Thermal
+
+This version is for Kirkwood 88F8262 & 88F6283 SoCs. Other kirkwoods
+don't contain a thermal sensor.
+
+Required properties:
+- compatible : "marvell,kirkwood-thermal"
+- reg : Address range of the thermal registers
+
+Example:
+
+	thermal@10078 {
+		compatible = "marvell,kirkwood-thermal";
+		reg = <0x10078 0x4>;
+	};
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index c2c77d1..ff34a0a 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -93,6 +93,14 @@ config RCAR_THERMAL
 	  Enable this to plug the R-Car thermal sensor driver into the Linux
 	  thermal framework
 
+config KIRKWOOD_THERMAL
+	tristate "Temperature sensor on Marvell Kirkwood SoCs"
+	depends on ARCH_KIRKWOOD
+	depends on OF
+	help
+	  Support for the Kirkwood thermal sensor driver into the Linux thermal
+	  framework. Only kirkwood 88F6282 and 88F6283 have this sensor.
+
 config EXYNOS_THERMAL
 	tristate "Temperature sensor on Samsung EXYNOS"
 	depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5)
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index d8da683..99026b2 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_CPU_THERMAL)	+= cpu_cooling.o
 # platform thermal drivers
 obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
+obj-$(CONFIG_KIRKWOOD_THERMAL)  += kirkwood_thermal.o
 obj-$(CONFIG_EXYNOS_THERMAL)	+= exynos_thermal.o
 obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
 obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+= db8500_cpufreq_cooling.o
diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
new file mode 100644
index 0000000..000cfc9
--- /dev/null
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -0,0 +1,136 @@
+/*
+ * Kirkwood thermal sensor driver
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
+#define KIRKWOOD_THERMAL_VALID_OFFSET	9
+#define KIRKWOOD_THERMAL_VALID_MASK	0x1
+#define KIRKWOOD_THERMAL_TEMP_OFFSET	10
+#define KIRKWOOD_THERMAL_TEMP_MASK	0x1FF
+
+/* Kirkwood Thermal Sensor Dev Structure */
+struct kirkwood_thermal_priv {
+	void __iomem *sensor;
+};
+
+static int kirkwood_get_temp(struct thermal_zone_device *thermal,
+			  unsigned long *temp)
+{
+	unsigned long reg;
+	struct kirkwood_thermal_priv *priv = thermal->devdata;
+
+	reg = readl_relaxed(priv->sensor);
+
+	/* Valid check */
+	if (!(reg >> KIRKWOOD_THERMAL_VALID_OFFSET) &
+	    KIRKWOOD_THERMAL_VALID_MASK) {
+		dev_err(&thermal->device,
+			"Temperature sensor reading not valid\n");
+		return -EIO;
+	}
+
+	/*
+	 * Calculate temperature. See Section 8.10.1 of the 88AP510,
+	 * datasheet, which has the same sensor.
+	 * Documentation/arm/Marvell/README
+	 */
+	reg = (reg >> KIRKWOOD_THERMAL_TEMP_OFFSET) &
+		KIRKWOOD_THERMAL_TEMP_MASK;
+	*temp = ((2281638UL - (7298*reg)) / 10);
+
+	return 0;
+}
+
+static struct thermal_zone_device_ops ops = {
+	.get_temp = kirkwood_get_temp,
+};
+
+static const struct of_device_id kirkwood_thermal_id_table[] = {
+	{ .compatible = "marvell,kirkwood-thermal" },
+	{}
+};
+
+static int kirkwood_thermal_probe(struct platform_device *pdev)
+{
+	struct thermal_zone_device *thermal = NULL;
+	struct kirkwood_thermal_priv *priv;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get platform resource\n");
+		return -ENODEV;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(&pdev->dev, "kzalloc fail\n");
+		return -ENOMEM;
+	}
+
+	priv->sensor = devm_request_and_ioremap(&pdev->dev, res);
+	if (!priv->sensor) {
+		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
+		return -EADDRNOTAVAIL;
+	}
+
+	thermal = thermal_zone_device_register("kirkwood_thermal", 0, 0,
+					       priv, &ops, NULL, 0, 0);
+	if (IS_ERR(thermal)) {
+		dev_err(&pdev->dev,
+			"Failed to register thermal zone device\n");
+		return PTR_ERR(thermal);
+	}
+
+	platform_set_drvdata(pdev, thermal);
+
+	return 0;
+}
+
+static int kirkwood_thermal_exit(struct platform_device *pdev)
+{
+	struct thermal_zone_device *kirkwood_thermal =
+		platform_get_drvdata(pdev);
+
+	thermal_zone_device_unregister(kirkwood_thermal);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
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

