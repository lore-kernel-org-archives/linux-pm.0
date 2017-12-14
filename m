From: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v3 05/11] thermal: armada: Add support for Armada AP806
Date: Thu, 14 Dec 2017 11:30:05 +0100
Message-ID: <20171214103011.24713-6-miquel.raynal@free-electrons.com>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171214103011.24713-1-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>

The AP806 component is integrated in the Armada 8k and 7k lines of
processors.

The thermal sensor sample field on the status register is a signed
value. Extend armada_get_temp() to handle signed values.

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/thermal/armada_thermal.c | 51 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index e5b184cee79b..279d01937bb8 100644
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
@@ -70,6 +75,7 @@ struct armada_thermal_data {
 	unsigned long coef_m;
 	unsigned long coef_div;
 	bool inverted;
+	bool signed_sample;
 
 	/* Register shift and mask to access the sensor temperature */
 	unsigned int temp_shift;
@@ -154,6 +160,24 @@ static void armada380_init_sensor(struct platform_device *pdev,
 	}
 }
 
+static void armada_ap806_init_sensor(struct platform_device *pdev,
+				     struct armada_thermal_priv *priv)
+{
+	u32 reg;
+
+	if (!priv->control0) {
+		dev_err(&pdev->dev,
+			"Cannot access to control0 (control LSB) register\n");
+		return;
+	}
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
@@ -167,6 +191,7 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 	struct armada_thermal_priv *priv = thermal->devdata;
 	u32 reg;
 	unsigned long m, b, div;
+	int sample;
 
 	/* Valid check */
 	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
@@ -177,6 +202,11 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 
 	reg = readl_relaxed(priv->status);
 	reg = (reg >> priv->data->temp_shift) & priv->data->temp_mask;
+	if (priv->data->signed_sample)
+		/* The most significant bit is the sign bit */
+		sample = sign_extend32(reg, fls(priv->data->temp_mask) - 1);
+	else
+		sample = reg;
 
 	/* Get formula coeficients */
 	b = priv->data->coef_b;
@@ -184,9 +214,9 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 	div = priv->data->coef_div;
 
 	if (priv->data->inverted)
-		*temp = ((m * reg) - b) / div;
+		*temp = ((m * sample) - b) / div;
 	else
-		*temp = (b - (m * reg)) / div;
+		*temp = (b - (m * sample)) / div;
 	return 0;
 }
 
@@ -237,6 +267,19 @@ static const struct armada_thermal_data armada380_data = {
 	.inverted = true,
 };
 
+static const struct armada_thermal_data armada_ap806_data = {
+	.is_valid = armada_is_valid,
+	.init_sensor = armada_ap806_init_sensor,
+	.is_valid_bit = BIT(16),
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
@@ -255,6 +298,10 @@ static const struct of_device_id armada_thermal_id_table[] = {
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
