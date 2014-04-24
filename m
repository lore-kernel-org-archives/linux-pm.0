From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 07/10] thermal: armada: Support Armada 380 SoC
Date: Thu, 24 Apr 2014 17:23:21 -0300
Message-ID: <1398371004-15807-8-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398371004-15807-1-git-send-email-ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Now that a generic infrastructure is in place, it's possible to support
the Armada 380 SoC thermal sensor. This sensor is similar to the one
available in the already supported SoCs, with its specific temperature formula
and specific sensor initialization.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
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
index e40cc6e..a48d0ca 100644
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
+	if (reg & A380_HW_RESET) {
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
+	.is_valid_offset = 10,
+	.temp_offset = 0,
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
