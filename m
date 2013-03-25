From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 1/4] thermal: Add driver for Armada 370/XP SoC thermal management
Date: Mon, 25 Mar 2013 12:27:06 -0300
Message-ID: <1364225229-2857-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1364225229-2857-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47639 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758128Ab3CYP1U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 11:27:20 -0400
In-Reply-To: <1364225229-2857-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lior Amsalem <alior@marvell.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This driver supports both Armada 370 and Armada XP SoC
thermal management controllers.

Armada 370 has a register to check a valid temperature, whereas
Armada XP does not. Each has a different initialization (i.e. calibration)
function. The temperature conversion formula is the same for both.

The controller present in each SoC have a very similar feature set,
so it corresponds to have one driver to support both of them.

Although this driver may present similarities to Dove and Kirkwood
thermal driver, the exact differences and coincidences are not fully
known. For this reason, support is given through a separate driver.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/thermal/armada-thermal.txt |   22 ++
 drivers/thermal/Kconfig                            |    8 +
 drivers/thermal/Makefile                           |    1 +
 drivers/thermal/armada_thermal.c                   |  236 ++++++++++++++++++++
 4 files changed, 267 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/armada-thermal.txt
 create mode 100644 drivers/thermal/armada_thermal.c

diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
new file mode 100644
index 0000000..fff93d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
@@ -0,0 +1,22 @@
+* Marvell Armada 370/XP thermal management
+
+Required properties:
+
+- compatible:	Should be set to one of the following:
+		marvell,armada370-thermal
+		marvell,armadaxp-thermal
+
+- reg:		Device's register space.
+		Two entries are expected, see the examples below.
+		The first one is required for the sensor register;
+		the second one is required for the control register
+		to be used for sensor initialization (a.k.a. calibration).
+
+Example:
+
+	thermal@d0018300 {
+		compatible = "marvell,armada370-thermal";
+                reg = <0xd0018300 0x4
+		       0xd0018304 0x4>;
+		status = "okay";
+	};
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index a764f16..fcd5a27 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -134,6 +134,14 @@ config DOVE_THERMAL
 	  Support for the Dove thermal sensor driver in the Linux thermal
 	  framework.
 
+config ARMADA_THERMAL
+	tristate "Armada 370/XP thermal management"
+	depends on ARCH_MVEBU
+	depends on OF
+	help
+	  Enable this option if you want to have support for thermal management
+	  controller present in Armada 370 and Armada XP SoC.
+
 config DB8500_THERMAL
 	bool "DB8500 thermal management"
 	depends on ARCH_U8500
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index d3a2b38..4209054 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_THERMAL_GOV_USER_SPACE)	+= user_space.o
 obj-$(CONFIG_CPU_THERMAL)	+= cpu_cooling.o
 
 # platform thermal drivers
+obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
 obj-$(CONFIG_KIRKWOOD_THERMAL)  += kirkwood_thermal.o
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
new file mode 100644
index 0000000..dc83a86
--- /dev/null
+++ b/drivers/thermal/armada_thermal.c
@@ -0,0 +1,236 @@
+/*
+ * Marvell Armada 370/XP thermal sensor driver
+ *
+ * Copyright (C) 2013 Marvell
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
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/thermal.h>
+
+#define THERMAL_VALID_OFFSET		9
+#define THERMAL_VALID_MASK		0x1
+#define THERMAL_TEMP_OFFSET		10
+#define THERMAL_TEMP_MASK		0x1ff
+
+/* Thermal Manager Control and Status Register */
+#define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
+#define PMU_TM_DISABLE_OFFS		0
+#define PMU_TM_DISABLE_MASK		(0x1 << PMU_TM_DISABLE_OFFS)
+#define PMU_TDC0_REF_CAL_CNT_OFFS	11
+#define PMU_TDC0_REF_CAL_CNT_MASK	(0x1ff << PMU_TDC0_REF_CAL_CNT_OFFS)
+#define PMU_TDC0_OTF_CAL_MASK		(0x1 << 30)
+#define PMU_TDC0_START_CAL_MASK		(0x1 << 25)
+
+struct armada_thermal_ops;
+
+/* Marvell EBU Thermal Sensor Dev Structure */
+struct armada_thermal_priv {
+	void __iomem *sensor;
+	void __iomem *control;
+	struct armada_thermal_ops *ops;
+};
+
+struct armada_thermal_ops {
+	/* Initialize the sensor */
+	void (*init_sensor)(struct armada_thermal_priv *);
+
+	/* Test for a valid sensor value (optional) */
+	bool (*is_valid)(struct armada_thermal_priv *);
+};
+
+static void armadaxp_init_sensor(struct armada_thermal_priv *priv)
+{
+	unsigned long reg;
+
+	/* ??? */
+	reg = readl_relaxed(priv->control);
+	reg |= PMU_TDC0_OTF_CAL_MASK;
+	writel(reg, priv->control);
+
+	/* Reference calibration value */
+	reg &= ~PMU_TDC0_REF_CAL_CNT_MASK;
+	reg |= (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
+	writel(reg, priv->control);
+
+	/* Reset the sensor */
+	reg = readl_relaxed(priv->control);
+	writel((reg | PMU_TDC0_SW_RST_MASK), priv->control);
+
+	writel(reg, priv->control);
+
+	/* Enable the sensor */
+	reg = readl_relaxed(priv->sensor);
+	reg &= ~PMU_TM_DISABLE_MASK;
+	writel(reg, priv->sensor);
+}
+
+static void armada370_init_sensor(struct armada_thermal_priv *priv)
+{
+	unsigned long reg;
+
+	/* ??? */
+	reg = readl_relaxed(priv->control);
+	reg |= PMU_TDC0_OTF_CAL_MASK;
+	writel(reg, priv->control);
+
+	/* Reference calibration value */
+	reg &= ~PMU_TDC0_REF_CAL_CNT_MASK;
+	reg |= (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
+	writel(reg, priv->control);
+
+	/* ??? */
+	reg &= ~PMU_TDC0_START_CAL_MASK;
+	writel(reg, priv->control);
+
+	/* FIXME: Why do we need this delay? */
+	mdelay(10);
+}
+
+static bool armada_is_valid(struct armada_thermal_priv *priv)
+{
+	unsigned long reg = readl_relaxed(priv->sensor);
+
+	return (reg >> THERMAL_VALID_OFFSET) & THERMAL_VALID_MASK;
+}
+
+static int armada_get_temp(struct thermal_zone_device *thermal,
+			  unsigned long *temp)
+{
+	struct armada_thermal_priv *priv = thermal->devdata;
+	unsigned long reg;
+
+	/* Valid check */
+	if (priv->ops->is_valid && !priv->ops->is_valid(priv)) {
+		dev_err(&thermal->device,
+			"Temperature sensor reading not valid\n");
+		return -EIO;
+	}
+
+	reg = (readl_relaxed(priv->sensor) >> THERMAL_TEMP_OFFSET) &
+		THERMAL_TEMP_MASK;
+	*temp = (3153000000UL - (10000000UL*reg)) / 13825;
+	return 0;
+}
+
+static struct thermal_zone_device_ops ops = {
+	.get_temp = armada_get_temp,
+};
+
+static const struct armada_thermal_ops armadaxp_ops = {
+	.init_sensor = armadaxp_init_sensor,
+};
+
+static const struct armada_thermal_ops armada370_ops = {
+	.is_valid = armada_is_valid,
+	.init_sensor = armada370_init_sensor,
+};
+
+static const struct of_device_id armada_thermal_id_table[] = {
+	{
+		.compatible = "marvell,armadaxp-thermal",
+		.data       = &armadaxp_ops,
+	},
+	{
+		.compatible = "marvell,armada370-thermal",
+		.data       = &armada370_ops,
+	},
+	{
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, armada_thermal_id_table);
+
+static int armada_thermal_probe(struct platform_device *pdev)
+{
+	struct thermal_zone_device *thermal;
+	const struct of_device_id *match;
+	struct armada_thermal_priv *priv;
+	struct resource *res;
+
+	match = of_match_device(armada_thermal_id_table, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get platform resource\n");
+		return -ENODEV;
+	}
+
+	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->sensor))
+		return PTR_ERR(priv->sensor);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get platform resource\n");
+		return -ENODEV;
+	}
+
+	priv->control = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->control))
+		return PTR_ERR(priv->control);
+
+	priv->ops = (struct armada_thermal_ops *)match->data;
+	priv->ops->init_sensor(priv);
+
+	thermal = thermal_zone_device_register("armada_thermal", 0, 0,
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
+static int armada_thermal_exit(struct platform_device *pdev)
+{
+	struct thermal_zone_device *armada_thermal =
+		platform_get_drvdata(pdev);
+
+	thermal_zone_device_unregister(armada_thermal);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver armada_thermal_driver = {
+	.probe = armada_thermal_probe,
+	.remove = armada_thermal_exit,
+	.driver = {
+		.name = "armada_thermal",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(armada_thermal_id_table),
+	},
+};
+
+module_platform_driver(armada_thermal_driver);
+
+MODULE_AUTHOR("Ezequiel Garcia <ezequiel.garcia@free-electrons.com>");
+MODULE_DESCRIPTION("Armada 370/XP thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.8.6

