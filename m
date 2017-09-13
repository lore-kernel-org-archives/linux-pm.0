From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [RFC 1/3] thermal: rcar_gen3_thermal: read calibration from hardware
Date: Wed, 13 Sep 2017 13:01:35 +0200
Message-ID: <20170913110137.13490-2-niklas.soderlund+renesas@ragnatech.se>
References: <20170913110137.13490-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170913110137.13490-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-pm@vger.kernel.org

In production hardware the calibration values used to convert register
values to temperatures can be read from hardware. While pre-production
hardware still depends on pseudo values hard-coded in the driver.

Add support for reading out calibration values from hardware if it's
fused. The presence of fused calibration is indicated in the THSCP
register, unfortunately this register where not present in early
datasheets. The resource size used in early DT descriptions do not cover
this register. This change takes this into account and fallback to the
pseudo values if the resource size in DT is to small.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 70 +++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 528a65b05b304ca3..29d041d79c6856d6 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -43,6 +43,10 @@
 #define REG_GEN3_THCODE1	0x50
 #define REG_GEN3_THCODE2	0x54
 #define REG_GEN3_THCODE3	0x58
+#define REG_GEN3_PTAT1		0x5c
+#define REG_GEN3_PTAT2		0x60
+#define REG_GEN3_PTAT3		0x64
+#define REG_GEN3_THSCP		0x68
 
 /* IRQ{STR,MSK,EN} bits */
 #define IRQ_TEMP1		BIT(0)
@@ -64,6 +68,9 @@
 #define THCTR_PONM	BIT(6)
 #define THCTR_THSST	BIT(0)
 
+/* THSCP bits */
+#define THSCP_COR_PARA_VLD	(BIT(15) | BIT(14))
+
 #define CTEMP_MASK	0xFFF
 
 #define MCELSIUS(temp)	((temp) * 1000)
@@ -81,6 +88,7 @@ struct equation_coefs {
 
 struct rcar_gen3_thermal_tsc {
 	void __iomem *base;
+	resource_size_t size;
 	struct thermal_zone_device *zone;
 	struct equation_coefs coef;
 	int low;
@@ -284,6 +292,55 @@ static const struct soc_device_attribute r8a7795es1[] = {
 	{ /* sentinel */ }
 };
 
+static bool rcar_gen3_thermal_update_fuses(struct rcar_gen3_thermal_priv *priv)
+{
+	int i, ptat[3], thcode[3];
+	u32 thscp;
+
+	if (!priv->num_tscs)
+		return false;
+
+	/*
+	 * If resource size of TSC1 is less then 0x6c0 old DT is used, not
+	 * possible to read all fusees, fallback to pseudo values.
+	 */
+	if (priv->tscs[0]->size < 0x6c)
+		return false;
+
+	/* If fuses are not set, fallback to pseudo values. */
+	thscp = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_THSCP);
+	if ((thscp & THSCP_COR_PARA_VLD) != THSCP_COR_PARA_VLD)
+		return false;
+
+	/*
+	 * Update the pseudo calibration points with fused values.
+	 * PTAT is shared between all TSC:s but only fused for the first
+	 * TSC while THCODEs are fused for each TSC.
+	 */
+
+	ptat[0] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT1) &
+		GEN3_FUSE_MASK;
+	ptat[1] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT2) &
+		GEN3_FUSE_MASK;
+	ptat[2] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT3) &
+		GEN3_FUSE_MASK;
+
+	for (i = 0; i < priv->num_tscs; i++) {
+		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
+
+		thcode[0] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE1) &
+			GEN3_FUSE_MASK;
+		thcode[1] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE2) &
+			GEN3_FUSE_MASK;
+		thcode[2] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE3) &
+			GEN3_FUSE_MASK;
+
+		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode);
+	}
+
+	return true;
+}
+
 static void r8a7796_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 {
 	u32 reg_val;
@@ -432,11 +489,22 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			ret = PTR_ERR(tsc->base);
 			goto error_unregister;
 		}
+		tsc->size = resource_size(res);
 
 		priv->tscs[i] = tsc;
 
 		priv->data->thermal_init(tsc);
+
 		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i]);
+	}
+
+	priv->num_tscs = i;
+
+	if (rcar_gen3_thermal_update_fuses(priv))
+		dev_info(dev, "Using fused calibration values\n");
+
+	for (i = 0; i < priv->num_tscs; i++) {
+		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
 							    &rcar_gen3_tz_of_ops);
@@ -454,8 +522,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
 	}
 
-	priv->num_tscs = i;
-
 	if (!priv->num_tscs) {
 		ret = -ENODEV;
 		goto error_unregister;
-- 
2.14.1
