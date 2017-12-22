From: Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH v6 06/11] thermal: armada: Add support for Armada AP806
Date: Fri, 22 Dec 2017 10:32:21 +0100
Message-ID: <20171222093226.23456-7-miquel.raynal@free-electrons.com>
References: <20171222093226.23456-1-miquel.raynal@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:43069 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758138AbdLVJcw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Dec 2017 04:32:52 -0500
In-Reply-To: <20171222093226.23456-1-miquel.raynal@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Miquel Raynal <miquel.raynal@free-electrons.com>, Baruch Siach <baruch@tkos.co.il>, David Sniatkiwicz <davidsn@marvell.com>

From: Baruch Siach <baruch@tkos.co.il>

The AP806 component is integrated in the Armada 8K and 7K lines of
processors.

The thermal sensor sample field on the status register is a signed
value. Extend armada_get_temp() and the driver structure to handle
signed values.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
[<miquel.raynal@free-electrons.com>: Changes when applying over the
previous patches, including the register names changes, also switched
the coefficients values to s64 instead of unsigned long to deal with
negative values and used do_div instead of the traditionnal '/']
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/thermal/armada_thermal.c | 78 +++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index ceebabf45c53..28ff2d0412ac 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -47,6 +47,11 @@
 #define CONTROL0_OFFSET			0x0
 #define CONTROL1_OFFSET			0x4
 
+/* TSEN refers to the temperature sensors within the AP */
+#define CONTROL0_TSEN_START		BIT(0)
+#define CONTROL0_TSEN_RESET		BIT(1)
+#define CONTROL0_TSEN_ENABLE		BIT(2)
+
 struct armada_thermal_data;
 
 /* Marvell EBU Thermal Sensor Dev Structure */
@@ -66,10 +71,11 @@ struct armada_thermal_data {
 	bool (*is_valid)(struct armada_thermal_priv *);
 
 	/* Formula coeficients: temp = (b - m * reg) / div */
-	unsigned long coef_b;
-	unsigned long coef_m;
-	unsigned long coef_div;
+	s64 coef_b;
+	s64 coef_m;
+	u32 coef_div;
 	bool inverted;
+	bool signed_sample;
 
 	/* Register shift and mask to access the sensor temperature */
 	unsigned int temp_shift;
@@ -155,6 +161,18 @@ static void armada380_init_sensor(struct platform_device *pdev,
 	}
 }
 
+static void armada_ap806_init_sensor(struct platform_device *pdev,
+				     struct armada_thermal_priv *priv)
+{
+	u32 reg;
+
+	reg = readl_relaxed(priv->control0);
+	reg &= ~CONTROL0_TSEN_RESET;
+	reg |= CONTROL0_TSEN_START | CONTROL0_TSEN_ENABLE;
+	writel(reg, priv->control0);
+	msleep(10);
+}
+
 static bool armada_is_valid(struct armada_thermal_priv *priv)
 {
 	u32 reg = readl_relaxed(priv->status);
@@ -163,11 +181,12 @@ static bool armada_is_valid(struct armada_thermal_priv *priv)
 }
 
 static int armada_get_temp(struct thermal_zone_device *thermal,
-			  int *temp)
+			   int *temperature)
 {
 	struct armada_thermal_priv *priv = thermal->devdata;
-	unsigned long reg;
-	unsigned long m, b, div;
+	u32 reg, div;
+	s64 sample, b, m;
+	u64 tmp;
 
 	/* Valid check */
 	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
@@ -178,6 +197,11 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 
 	reg = readl_relaxed(priv->status);
 	reg = (reg >> priv->data->temp_shift) & priv->data->temp_mask;
+	if (priv->data->signed_sample)
+		/* The most significant bit is the sign bit */
+		sample = sign_extend32(reg, fls(priv->data->temp_mask) - 1);
+	else
+		sample = reg;
 
 	/* Get formula coeficients */
 	b = priv->data->coef_b;
@@ -185,9 +209,13 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 	div = priv->data->coef_div;
 
 	if (priv->data->inverted)
-		*temp = ((m * reg) - b) / div;
+		tmp = (m * sample) - b;
 	else
-		*temp = (b - (m * reg)) / div;
+		tmp = b - (m * sample);
+
+	do_div(tmp, div);
+	*temperature = (int)tmp;
+
 	return 0;
 }
 
@@ -199,8 +227,8 @@ static const struct armada_thermal_data armadaxp_data = {
 	.init_sensor = armadaxp_init_sensor,
 	.temp_shift = 10,
 	.temp_mask = 0x1ff,
-	.coef_b = 3153000000UL,
-	.coef_m = 10000000UL,
+	.coef_b = 3153000000ULL,
+	.coef_m = 10000000ULL,
 	.coef_div = 13825,
 };
 
@@ -210,8 +238,8 @@ static const struct armada_thermal_data armada370_data = {
 	.is_valid_bit = BIT(9),
 	.temp_shift = 10,
 	.temp_mask = 0x1ff,
-	.coef_b = 3153000000UL,
-	.coef_m = 10000000UL,
+	.coef_b = 3153000000ULL,
+	.coef_m = 10000000ULL,
 	.coef_div = 13825,
 };
 
@@ -221,8 +249,8 @@ static const struct armada_thermal_data armada375_data = {
 	.is_valid_bit = BIT(10),
 	.temp_shift = 0,
 	.temp_mask = 0x1ff,
-	.coef_b = 3171900000UL,
-	.coef_m = 10000000UL,
+	.coef_b = 3171900000ULL,
+	.coef_m = 10000000ULL,
 	.coef_div = 13616,
 	.needs_control0 = true,
 };
@@ -233,12 +261,26 @@ static const struct armada_thermal_data armada380_data = {
 	.is_valid_bit = BIT(10),
 	.temp_shift = 0,
 	.temp_mask = 0x3ff,
-	.coef_b = 1172499100UL,
-	.coef_m = 2000096UL,
+	.coef_b = 1172499100ULL,
+	.coef_m = 2000096ULL,
 	.coef_div = 4201,
 	.inverted = true,
 };
 
+static const struct armada_thermal_data armada_ap806_data = {
+	.is_valid = armada_is_valid,
+	.init_sensor = armada_ap806_init_sensor,
+	.is_valid_bit = BIT(16),
+	.temp_shift = 0,
+	.temp_mask = 0x3ff,
+	.coef_b = -150000LL,
+	.coef_m = 423ULL,
+	.coef_div = 1,
+	.inverted = true,
+	.signed_sample = true,
+	.needs_control0 = true,
+};
+
 static const struct of_device_id armada_thermal_id_table[] = {
 	{
 		.compatible = "marvell,armadaxp-thermal",
@@ -257,6 +299,10 @@ static const struct of_device_id armada_thermal_id_table[] = {
 		.data       = &armada380_data,
 	},
 	{
+		.compatible = "marvell,armada-ap806-thermal",
+		.data       = &armada_ap806_data,
+	},
+	{
 		/* sentinel */
 	},
 };
-- 
2.11.0
