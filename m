From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 7/7] thermal: armada: Support Armada 380 SoC
Date: Tue,  6 May 2014 13:59:51 -0300
Message-ID: <1399395591-5713-8-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1399395591-5713-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:53327 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750821AbaEFRAz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 May 2014 13:00:55 -0400
In-Reply-To: <1399395591-5713-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Now that a generic infrastructure is in place, it's possible to support
the Armada 380 SoC thermal sensor. This sensor is similar to the one
available in the already supported SoCs, with its specific temperature formula
and specific sensor initialization.

Acked-by: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/thermal/armada-thermal.txt |  3 ++-
 drivers/thermal/armada_thermal.c                   | 30 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
index 2a67e51..4cf0249 100644
--- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
@@ -1,4 +1,4 @@
-* Marvell Armada 370/375/XP thermal management
+* Marvell Armada 370/375/380/XP thermal management
 
 Required properties:
 
@@ -6,6 +6,7 @@ Required properties:
 		marvell,armada370-thermal
 		marvell,armada375-thermal
 		marvell,armada375-z1-thermal
+		marvell,armada380-thermal
 		marvell,armadaxp-thermal
 
 		Note: As the name suggests, "marvell,armada375-z1-thermal"
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index e65c5e4..9d1420a 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -43,6 +43,7 @@
 #define A375_UNIT_CONTROL_MASK		0x7
 #define A375_READOUT_INVERT		BIT(15)
 #define A375_HW_RESETn			BIT(8)
+#define A380_HW_RESET			BIT(8)
 
 struct armada_thermal_data;
 
@@ -149,6 +150,19 @@ static void armada375_init_sensor(struct platform_device *pdev,
 	mdelay(50);
 }
 
+static void armada380_init_sensor(struct platform_device *pdev,
+				  struct armada_thermal_priv *priv)
+{
+	unsigned long reg = readl_relaxed(priv->control);
+
+	/* Reset hardware once */
+	if (!(reg & A380_HW_RESET)) {
+		reg |= A380_HW_RESET;
+		writel(reg, priv->control);
+		mdelay(10);
+	}
+}
+
 static bool armada_is_valid(struct armada_thermal_priv *priv)
 {
 	unsigned long reg = readl_relaxed(priv->sensor);
@@ -220,6 +234,18 @@ static const struct armada_thermal_data armada375_data = {
 	.coef_div = 13616,
 };
 
+static const struct armada_thermal_data armada380_data = {
+	.is_valid = armada_is_valid,
+	.init_sensor = armada380_init_sensor,
+	.is_valid_shift = 10,
+	.temp_shift = 0,
+	.temp_mask = 0x3ff,
+	.coef_b = 1169498786UL,
+	.coef_m = 2000000UL,
+	.coef_div = 4289,
+	.inverted = true,
+};
+
 static const struct of_device_id armada_thermal_id_table[] = {
 	{
 		.compatible = "marvell,armadaxp-thermal",
@@ -238,6 +264,10 @@ static const struct of_device_id armada_thermal_id_table[] = {
 		.data       = &armada375_data,
 	},
 	{
+		.compatible = "marvell,armada380-thermal",
+		.data       = &armada380_data,
+	},
+	{
 		/* sentinel */
 	},
 };
-- 
1.9.1

