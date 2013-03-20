From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 11/16] thermal: mvebu: Add support for Armada XP thermal sensor
Date: Wed, 20 Mar 2013 19:36:32 -0300
Message-ID: <1363818997-23137-12-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:50643 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab3CTWhc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Mar 2013 18:37:32 -0400
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

With the infrastructure introduced to support more SoC, we can
now easily add another thermal sensor.

The Armada XP sensor has no register to check for a valid temperature,
and has a special formula to obtain the temperature from the thermal
sensor output register.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/thermal/mvebu-thermal.txt  |   21 ++++++---
 drivers/thermal/mvebu_thermal.c                    |   50 ++++++++++++++++++++
 2 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/mvebu-thermal.txt b/Documentation/devicetree/bindings/thermal/mvebu-thermal.txt
index 8c0f5eb..7cc3fd4 100644
--- a/Documentation/devicetree/bindings/thermal/mvebu-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mvebu-thermal.txt
@@ -1,13 +1,20 @@
-* Kirkwood Thermal
-
-This version is for Kirkwood 88F8262 & 88F6283 SoCs. Other kirkwoods
-don't contain a thermal sensor.
+* Marvell EBU Thermal
 
 Required properties:
-- compatible : "marvell,kirkwood-thermal"
-- reg : Address range of the thermal registers
 
-Example:
+- compatible:	Should be set to one of the following:
+		marvell,kirkwood-thermal
+		marvell,armadaxp-thermal
+
+- reg:		Device's register space.
+		One or two entries are expected, see the examples below.
+		The first one is required for the sensor register;
+		the second one is optional and is used as the control
+		register for sensor calibration.
+		Currently the only SoC variant having one register range
+		is Kirkwood.
+
+Kirkwood example:
 
 	thermal@10078 {
 		compatible = "marvell,kirkwood-thermal";
diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
index bfe4817..50f13e7 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -1,6 +1,7 @@
 /*
  * Marvell EBU thermal sensor driver
  *
+ * Copyright (C) 2013 Marvell
  * Copyright (C) 2012 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
  *
  * This software is licensed under the terms of the GNU General Public
@@ -24,12 +25,21 @@
 #include <linux/thermal.h>
 
 #define MVEBU_THERMAL_SOC_VARIANT_KIRKWOOD    0x1
+#define MVEBU_THERMAL_SOC_VARIANT_ARMADA_XP   0x2
 
 #define MVEBU_THERMAL_VALID_OFFSET	9
 #define MVEBU_THERMAL_VALID_MASK	0x1
 #define MVEBU_THERMAL_TEMP_OFFSET	10
 #define MVEBU_THERMAL_TEMP_MASK		0x1FF
 
+/* Thermal Manager Control and Status Register */
+#define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
+#define PMU_TM_DISABLE_OFFS		0
+#define PMU_TM_DISABLE_MASK		(0x1 << PMU_TM_DISABLE_OFFS)
+#define PMU_TDC0_REF_CAL_CNT_OFFS	11
+#define PMU_TDC0_REF_CAL_CNT_MASK	(0x1ff << PMU_TDC0_REF_CAL_CNT_OFFS)
+#define PMU_TDC0_OTF_CAL_MASK		(0x1 << 30)
+
 /* Marvell EBU Thermal Sensor Dev Structure */
 struct mvebu_thermal_priv {
 	void __iomem *sensor;
@@ -43,6 +53,35 @@ struct mvebu_thermal_priv {
 	bool (*is_valid)(struct mvebu_thermal_priv *);
 };
 
+static void armadaxp_init_sensor(struct mvebu_thermal_priv *priv)
+{
+	unsigned long reg;
+
+	if (!priv->control)
+		return;
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
 static bool mvebu_is_valid(struct mvebu_thermal_priv *priv)
 {
 	unsigned long reg = readl_relaxed(priv->sensor);
@@ -71,6 +110,9 @@ static int mvebu_get_temp(struct thermal_zone_device *thermal,
 	case MVEBU_THERMAL_SOC_VARIANT_KIRKWOOD:
 		*temp = ((2363302UL - (7339*reg)) / 10);
 		break;
+	case MVEBU_THERMAL_SOC_VARIANT_ARMADA_XP:
+		*temp = (3153000000UL - (10000000UL*reg)) / 13825;
+		break;
 	default:
 		*temp = 0;
 		break;
@@ -88,6 +130,10 @@ static const struct of_device_id mvebu_thermal_id_table[] = {
 		.data       = (void *) MVEBU_THERMAL_SOC_VARIANT_KIRKWOOD,
 	},
 	{
+		.compatible = "marvell,armadaxp-thermal",
+		.data       = (void *) MVEBU_THERMAL_SOC_VARIANT_ARMADA_XP,
+	},
+	{
 		/* sentinel */
 	},
 };
@@ -130,6 +176,9 @@ static int mvebu_thermal_probe(struct platform_device *pdev)
 	case MVEBU_THERMAL_SOC_VARIANT_KIRKWOOD:
 		priv->is_valid = mvebu_is_valid;
 		break;
+	case MVEBU_THERMAL_SOC_VARIANT_ARMADA_XP:
+		priv->init_sensor = armadaxp_init_sensor;
+		break;
 	default:
 		break;
 	}
@@ -174,5 +223,6 @@ static struct platform_driver mvebu_thermal_driver = {
 module_platform_driver(mvebu_thermal_driver);
 
 MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu@nigauri.org>");
+MODULE_AUTHOR("Ezequiel Garcia <ezequiel.garcia@free-electrons.com>");
 MODULE_DESCRIPTION("mvebu thermal driver");
 MODULE_LICENSE("GPL v2");
-- 
1.7.8.6

