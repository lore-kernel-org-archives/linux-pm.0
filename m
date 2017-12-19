From: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 07/11] thermal: armada: Add support for Armada CP110
Date: Tue, 19 Dec 2017 14:57:15 +0100
Message-ID: <20171219135719.9531-8-miquel.raynal@free-electrons.com>
References: <20171219135719.9531-1-miquel.raynal@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171219135719.9531-1-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>

The CP110 component is integrated in the Armada 8k and 7k lines of
processors.

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
[<miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>: renamed the register pointers as
well as some definitions related to the new register names and
simplified the init sequence for Armada 380]
Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/thermal/armada_thermal.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c7dcac39cbf9..3785b5248bf5 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -37,7 +37,6 @@
 #define A375_UNIT_CONTROL_MASK		0x7
 #define A375_READOUT_INVERT		BIT(15)
 #define A375_HW_RESETn			BIT(8)
-#define A380_HW_RESET			BIT(8)
 
 /* Legacy bindings */
 #define LEGACY_CONTROL_MEM_LEN		0x4
@@ -52,6 +51,10 @@
 #define CONTROL0_TSEN_RESET		BIT(1)
 #define CONTROL0_TSEN_ENABLE		BIT(2)
 
+/* EXT_TSEN refers to the external temperature sensors, out of the AP */
+#define CONTROL1_EXT_TSEN_SW_RESET	BIT(7)
+#define CONTROL1_EXT_TSEN_HW_RESETn	BIT(8)
+
 struct armada_thermal_data;
 
 /* Marvell EBU Thermal Sensor Dev Structure */
@@ -153,12 +156,11 @@ static void armada380_init_sensor(struct platform_device *pdev,
 {
 	u32 reg = readl_relaxed(priv->control1);
 
-	/* Reset hardware once */
-	if (!(reg & A380_HW_RESET)) {
-		reg |= A380_HW_RESET;
-		writel(reg, priv->control1);
-		msleep(10);
-	}
+	/* Disable the HW/SW reset */
+	reg |= CONTROL1_EXT_TSEN_HW_RESETn;
+	reg &= ~CONTROL1_EXT_TSEN_SW_RESET;
+	writel(reg, priv->control1);
+	msleep(10);
 }
 
 static void armada_ap806_init_sensor(struct platform_device *pdev,
@@ -279,6 +281,19 @@ static const struct armada_thermal_data armada_ap806_data = {
 	.needs_control0 = true,
 };
 
+static const struct armada_thermal_data armada_cp110_data = {
+	.is_valid = armada_is_valid,
+	.init_sensor = armada380_init_sensor,
+	.is_valid_bit = BIT(10),
+	.temp_shift = 0,
+	.temp_mask = 0x3ff,
+	.coef_b = 1172499100ULL,
+	.coef_m = 2000096ULL,
+	.coef_div = 4201,
+	.inverted = true,
+	.needs_control0 = true,
+};
+
 static const struct of_device_id armada_thermal_id_table[] = {
 	{
 		.compatible = "marvell,armadaxp-thermal",
@@ -301,6 +316,10 @@ static const struct of_device_id armada_thermal_id_table[] = {
 		.data       = &armada_ap806_data,
 	},
 	{
+		.compatible = "marvell,armada-cp110-thermal",
+		.data       = &armada_cp110_data,
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
