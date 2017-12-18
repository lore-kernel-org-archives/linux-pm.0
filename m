From: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 03/12] thermal: armada: Simplify the check of the validity bit
Date: Mon, 18 Dec 2017 15:36:34 +0100
Message-ID: <20171218143643.7714-4-miquel.raynal@free-electrons.com>
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171218143643.7714-1-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

All Armada SoCs use one bit to declare if the sensor values are valid.
This bit moves across the versions of the IP.

The method until then was to do both a shift and compare with an useless
flag of "0x1". It is clearer and quicker to directly save the value that
must be ANDed instead of the bit position and do a single bitwise AND
operation.

Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/thermal/armada_thermal.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 6c4af2622d4f..f350d7efd35a 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -24,8 +24,6 @@
 #include <linux/of_device.h>
 #include <linux/thermal.h>
 
-#define THERMAL_VALID_MASK		0x1
-
 /* Thermal Manager Control and Status Register */
 #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
 #define PMU_TM_DISABLE_OFFS		0
@@ -67,7 +65,7 @@ struct armada_thermal_data {
 	/* Register shift and mask to access the sensor temperature */
 	unsigned int temp_shift;
 	unsigned int temp_mask;
-	unsigned int is_valid_shift;
+	u32 is_valid_bit;
 };
 
 static void armadaxp_init_sensor(struct platform_device *pdev,
@@ -149,9 +147,9 @@ static void armada380_init_sensor(struct platform_device *pdev,
 
 static bool armada_is_valid(struct armada_thermal_priv *priv)
 {
-	unsigned long reg = readl_relaxed(priv->sensor);
+	u32 reg = readl_relaxed(priv->sensor);
 
-	return (reg >> priv->data->is_valid_shift) & THERMAL_VALID_MASK;
+	return reg & priv->data->is_valid_bit;
 }
 
 static int armada_get_temp(struct thermal_zone_device *thermal,
@@ -199,7 +197,7 @@ static const struct armada_thermal_data armadaxp_data = {
 static const struct armada_thermal_data armada370_data = {
 	.is_valid = armada_is_valid,
 	.init_sensor = armada370_init_sensor,
-	.is_valid_shift = 9,
+	.is_valid_bit = BIT(9),
 	.temp_shift = 10,
 	.temp_mask = 0x1ff,
 	.coef_b = 3153000000UL,
@@ -210,7 +208,7 @@ static const struct armada_thermal_data armada370_data = {
 static const struct armada_thermal_data armada375_data = {
 	.is_valid = armada_is_valid,
 	.init_sensor = armada375_init_sensor,
-	.is_valid_shift = 10,
+	.is_valid_bit = BIT(10),
 	.temp_shift = 0,
 	.temp_mask = 0x1ff,
 	.coef_b = 3171900000UL,
@@ -221,7 +219,7 @@ static const struct armada_thermal_data armada375_data = {
 static const struct armada_thermal_data armada380_data = {
 	.is_valid = armada_is_valid,
 	.init_sensor = armada380_init_sensor,
-	.is_valid_shift = 10,
+	.is_valid_bit = BIT(10),
 	.temp_shift = 0,
 	.temp_mask = 0x3ff,
 	.coef_b = 1172499100UL,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
