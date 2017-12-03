From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v2 3/4] thermal: armada: add support for CP110
Date: Sun,  3 Dec 2017 13:11:23 +0200
Message-ID: <d48c916a2502f9c75e9ea4ba41300e2ffbb254d8.1512299484.git.baruch@tkos.co.il>
References: <f8c589337a4fb78852eadf15058e8f8d132d4dc0.1512299484.git.baruch@tkos.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f8c589337a4fb78852eadf15058e8f8d132d4dc0.1512299484.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The CP110 component is integrated in the Armada 8k and 7k lines of processors.

This patch also adds an option of offset to the MSB of the control
register. The existing DT binding for Armada 38x refers to a single 32 bit
control register. It turns out that this is actually only the MSB of the
control area. Changing the binding to fix that would break existing DT files,
so the Armada 38x binding is left as is.

The new CP110 binding increases the size of the control area to 64 bits, thus
moving the MSB to offset 4.

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
v2: No change
---
 drivers/thermal/armada_thermal.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 0eb82097571f..59b75f63945d 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -73,6 +73,7 @@ struct armada_thermal_data {
 	unsigned int temp_shift;
 	unsigned int temp_mask;
 	unsigned int is_valid_shift;
+	unsigned int control_msb_offset;
 };
 
 static void armadaxp_init_sensor(struct platform_device *pdev,
@@ -142,12 +143,14 @@ static void armada375_init_sensor(struct platform_device *pdev,
 static void armada380_init_sensor(struct platform_device *pdev,
 				  struct armada_thermal_priv *priv)
 {
-	unsigned long reg = readl_relaxed(priv->control);
+	void __iomem *control_msb =
+		priv->control + priv->data->control_msb_offset;
+	unsigned long reg = readl_relaxed(control_msb);
 
 	/* Reset hardware once */
 	if (!(reg & A380_HW_RESET)) {
 		reg |= A380_HW_RESET;
-		writel(reg, priv->control);
+		writel(reg, control_msb);
 		mdelay(10);
 	}
 }
@@ -266,6 +269,19 @@ static const struct armada_thermal_data armada_ap806_data = {
 	.signed_sample = true,
 };
 
+static const struct armada_thermal_data armada_cp110_data = {
+	.is_valid = armada_is_valid,
+	.init_sensor = armada380_init_sensor,
+	.is_valid_shift = 10,
+	.temp_shift = 0,
+	.temp_mask = 0x3ff,
+	.control_msb_offset = 4,
+	.coef_b = 1172499100UL,
+	.coef_m = 2000096UL,
+	.coef_div = 4201,
+	.inverted = true,
+};
+
 static const struct of_device_id armada_thermal_id_table[] = {
 	{
 		.compatible = "marvell,armadaxp-thermal",
@@ -287,6 +303,10 @@ static const struct of_device_id armada_thermal_id_table[] = {
 		.compatible = "marvell,armada-ap806-thermal",
 		.data       = &armada_ap806_data,
 	},
+	{
+		.compatible = "marvell,armada-cp110-thermal",
+		.data       = &armada_cp110_data,
+	},
 	{
 		/* sentinel */
 	},
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
