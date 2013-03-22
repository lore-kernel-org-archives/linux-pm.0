From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 09/14] thermal: mvebu: Add support for Armada XP thermal sensor
Date: Fri, 22 Mar 2013 19:25:09 -0300
Message-ID: <1363991114-4225-10-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33464 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423385Ab3CVWZ6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 18:25:58 -0400
In-Reply-To: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

With the infrastructure introduced to support more SoC, we can
now easily add another thermal sensor.

The Armada XP sensor has no register to check for a valid temperature,
and has a special formula to obtain the temperature from the thermal
sensor output register.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/thermal/mvebu-thermal.txt  |   21 +++++---
 drivers/thermal/mvebu_thermal.c                    |   57 ++++++++++++++++++++
 2 files changed, 71 insertions(+), 7 deletions(-)

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
index a7c9b34..fc4d9f4 100644
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
@@ -28,6 +29,14 @@
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
 struct mvebu_thermal_ops;
 
 /* Marvell EBU Thermal Sensor Dev Structure */
@@ -48,6 +57,35 @@ struct mvebu_thermal_ops {
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
@@ -65,6 +103,15 @@ static unsigned long orion_sensor_temp(struct mvebu_thermal_priv *priv)
 	return (3220000000UL - (10000000UL * reg)) / 13625;
 }
 
+static unsigned long armada_sensor_temp(struct mvebu_thermal_priv *priv)
+{
+	unsigned long reg = readl_relaxed(priv->sensor);
+
+	reg = (reg >> MVEBU_THERMAL_TEMP_OFFSET) &
+		MVEBU_THERMAL_TEMP_MASK;
+	return (3153000000UL - (10000000UL*reg)) / 13825;
+}
+
 static int mvebu_get_temp(struct thermal_zone_device *thermal,
 			  unsigned long *temp)
 {
@@ -90,12 +137,21 @@ static const struct mvebu_thermal_ops kirkwood_ops = {
 	.is_valid = mvebu_is_valid,
 };
 
+static const struct mvebu_thermal_ops armadaxp_ops = {
+	.sensor_temp = armada_sensor_temp,
+	.init_sensor = armadaxp_init_sensor,
+};
+
 static const struct of_device_id mvebu_thermal_id_table[] = {
 	{
 		.compatible = "marvell,kirkwood-thermal",
 		.data       = &kirkwood_ops,
 	},
 	{
+		.compatible = "marvell,armadaxp-thermal",
+		.data       = &armadaxp_ops,
+	},
+	{
 		/* sentinel */
 	},
 };
@@ -175,5 +231,6 @@ static struct platform_driver mvebu_thermal_driver = {
 module_platform_driver(mvebu_thermal_driver);
 
 MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu@nigauri.org>");
+MODULE_AUTHOR("Ezequiel Garcia <ezequiel.garcia@free-electrons.com>");
 MODULE_DESCRIPTION("mvebu thermal driver");
 MODULE_LICENSE("GPL v2");
-- 
1.7.8.6

