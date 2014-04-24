From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 06/10] thermal: armada: Support Armada 375 SoC
Date: Thu, 24 Apr 2014 17:23:20 -0300
Message-ID: <1398371004-15807-7-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40811 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752894AbaDXUY1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Apr 2014 16:24:27 -0400
In-Reply-To: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, devicetree@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Now that a generic infrastructure is in place, it's possible to support
the new Armada 375 SoC thermal sensor. This sensor is similar to the one
available in the already supported SoCs, with its specific temperature formula
and specific sensor initialization.

In addition, we also add support for the Z1 SoC stepping, which needs
an initialization-quirk to work properly.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/thermal/armada-thermal.txt | 11 +++-
 drivers/thermal/armada_thermal.c                   | 58 ++++++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
index fff93d5..2a67e51 100644
--- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
@@ -1,11 +1,20 @@
-* Marvell Armada 370/XP thermal management
+* Marvell Armada 370/375/XP thermal management
 
 Required properties:
 
 - compatible:	Should be set to one of the following:
 		marvell,armada370-thermal
+		marvell,armada375-thermal
+		marvell,armada375-z1-thermal
 		marvell,armadaxp-thermal
 
+		Note: As the name suggests, "marvell,armada375-z1-thermal"
+		applies for the SoC Z1 stepping only. On such stepping
+		some quirks need to be done and the register offset differs
+		from the one in the A0 stepping.
+		The operating system may auto-detect the SoC stepping and
+		update the compatible and register offsets at runtime.
+
 - reg:		Device's register space.
 		Two entries are expected, see the examples below.
 		The first one is required for the sensor register;
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index e228132..e40cc6e 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -35,6 +35,15 @@
 #define PMU_TDC0_OTF_CAL_MASK		(0x1 << 30)
 #define PMU_TDC0_START_CAL_MASK		(0x1 << 25)
 
+#define A375_Z1_CAL_RESET_LSB		0x8011e214
+#define A375_Z1_CAL_RESET_MSB		0x30a88019
+#define A375_Z1_WORKAROUND_BIT		BIT(9)
+
+#define A375_UNIT_CONTROL_OFFSET	27
+#define A375_UNIT_CONTROL_MASK		0x7
+#define A375_READOUT_INVERT		BIT(15)
+#define A375_HW_RESETn			BIT(8)
+
 struct armada_thermal_data;
 
 /* Marvell EBU Thermal Sensor Dev Structure */
@@ -110,6 +119,36 @@ static void armada370_init_sensor(struct platform_device *pdev,
 	mdelay(10);
 }
 
+static void armada375_init_sensor(struct platform_device *pdev,
+				  struct armada_thermal_priv *priv)
+{
+	unsigned long reg;
+	bool quirk_needed =
+		!!of_device_is_compatible(pdev->dev.of_node,
+					  "marvell,armada375-z1-thermal");
+
+	if (quirk_needed) {
+		/* Ensure these registers have the default (reset) values */
+		writel(A375_Z1_CAL_RESET_LSB, priv->control);
+		writel(A375_Z1_CAL_RESET_MSB, priv->control + 0x4);
+	}
+
+	reg = readl(priv->control + 4);
+	reg &= ~(A375_UNIT_CONTROL_MASK << A375_UNIT_CONTROL_OFFSET);
+	reg &= ~A375_READOUT_INVERT;
+	reg &= ~A375_HW_RESETn;
+
+	if (quirk_needed)
+		reg |= A375_Z1_WORKAROUND_BIT;
+
+	writel(reg, priv->control + 4);
+	mdelay(20);
+
+	reg |= A375_HW_RESETn;
+	writel(reg, priv->control + 4);
+	mdelay(50);
+}
+
 static bool armada_is_valid(struct armada_thermal_priv *priv)
 {
 	unsigned long reg = readl_relaxed(priv->sensor);
@@ -170,6 +209,17 @@ static const struct armada_thermal_data armada370_data = {
 	.coef_div = 13825,
 };
 
+static const struct armada_thermal_data armada375_data = {
+	.is_valid = armada_is_valid,
+	.init_sensor = armada375_init_sensor,
+	.is_valid_offset = 10,
+	.temp_offset = 0,
+	.temp_mask = 0x1ff,
+	.coef_b = 3171900000UL,
+	.coef_m = 10000000UL,
+	.coef_div = 13616,
+};
+
 static const struct of_device_id armada_thermal_id_table[] = {
 	{
 		.compatible = "marvell,armadaxp-thermal",
@@ -180,6 +230,14 @@ static const struct of_device_id armada_thermal_id_table[] = {
 		.data       = &armada370_data,
 	},
 	{
+		.compatible = "marvell,armada375-thermal",
+		.data       = &armada375_data,
+	},
+	{
+		.compatible = "marvell,armada375-z1-thermal",
+		.data       = &armada375_data,
+	},
+	{
 		/* sentinel */
 	},
 };
-- 
1.9.1

