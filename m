From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v2 2/4] thermal: armada: add support for AP806
Date: Sun,  3 Dec 2017 13:11:22 +0200
Message-ID: <0aa7ef4c48974f5973ff637ab37aee620d35b8fe.1512299484.git.baruch@tkos.co.il>
References: <f8c589337a4fb78852eadf15058e8f8d132d4dc0.1512299484.git.baruch@tkos.co.il>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:57338 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750891AbdLCLSy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 Dec 2017 06:18:54 -0500
In-Reply-To: <f8c589337a4fb78852eadf15058e8f8d132d4dc0.1512299484.git.baruch@tkos.co.il>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, Miquel Raynal <miquel.raynal@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baruch Siach <baruch@tkos.co.il>

The AP806 component is integrated in the Armada 8k and 7k lines of processors.

The thermal sensor sample field on the status register is a signed
value. Extend armada_get_temp() to handle signed values.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2:
  Use msleep instead of mdelay (RMK).
  Fix temperature calculation formula according to recent documentation
  and vendor code. Update the commit log.
---
 drivers/thermal/armada_thermal.c | 44 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 706d74798cbe..0eb82097571f 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -41,6 +41,10 @@
 #define A375_HW_RESETn			BIT(8)
 #define A380_HW_RESET			BIT(8)
 
+#define AP806_START			BIT(0)
+#define AP806_RESET			BIT(1)
+#define AP806_ENABLE			BIT(2)
+
 struct armada_thermal_data;
 
 /* Marvell EBU Thermal Sensor Dev Structure */
@@ -63,6 +67,7 @@ struct armada_thermal_data {
 	unsigned long coef_m;
 	unsigned long coef_div;
 	bool inverted;
+	bool signed_sample;
 
 	/* Register shift and mask to access the sensor temperature */
 	unsigned int temp_shift;
@@ -147,6 +152,18 @@ static void armada380_init_sensor(struct platform_device *pdev,
 	}
 }
 
+static void armada_ap806_init_sensor(struct platform_device *pdev,
+				     struct armada_thermal_priv *priv)
+{
+	u32 reg = readl_relaxed(priv->control);
+
+	reg &= ~AP806_RESET;
+	reg |= AP806_START;
+	reg |= AP806_ENABLE;
+	writel(reg, priv->control);
+	msleep(10);
+}
+
 static bool armada_is_valid(struct armada_thermal_priv *priv)
 {
 	unsigned long reg = readl_relaxed(priv->sensor);
@@ -160,6 +177,7 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 	struct armada_thermal_priv *priv = thermal->devdata;
 	unsigned long reg;
 	unsigned long m, b, div;
+	int sample;
 
 	/* Valid check */
 	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
@@ -170,6 +188,11 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 
 	reg = readl_relaxed(priv->sensor);
 	reg = (reg >> priv->data->temp_shift) & priv->data->temp_mask;
+	if (priv->data->signed_sample)
+		/* The most significant bit is the sign bit */
+		sample = sign_extend32(reg, fls(priv->data->temp_mask) - 1);
+	else
+		sample = reg;
 
 	/* Get formula coeficients */
 	b = priv->data->coef_b;
@@ -177,9 +200,9 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 	div = priv->data->coef_div;
 
 	if (priv->data->inverted)
-		*temp = ((m * reg) - b) / div;
+		*temp = ((m * sample) - b) / div;
 	else
-		*temp = (b - (m * reg)) / div;
+		*temp = (b - (m * sample)) / div;
 	return 0;
 }
 
@@ -230,6 +253,19 @@ static const struct armada_thermal_data armada380_data = {
 	.inverted = true,
 };
 
+static const struct armada_thermal_data armada_ap806_data = {
+	.is_valid = armada_is_valid,
+	.init_sensor = armada_ap806_init_sensor,
+	.is_valid_shift = 16,
+	.temp_shift = 0,
+	.temp_mask = 0x3ff,
+	.coef_b = -150000,
+	.coef_m = 423UL,
+	.coef_div = 1,
+	.inverted = true,
+	.signed_sample = true,
+};
+
 static const struct of_device_id armada_thermal_id_table[] = {
 	{
 		.compatible = "marvell,armadaxp-thermal",
@@ -247,6 +283,10 @@ static const struct of_device_id armada_thermal_id_table[] = {
 		.compatible = "marvell,armada380-thermal",
 		.data       = &armada380_data,
 	},
+	{
+		.compatible = "marvell,armada-ap806-thermal",
+		.data       = &armada_ap806_data,
+	},
 	{
 		/* sentinel */
 	},
-- 
2.15.0
