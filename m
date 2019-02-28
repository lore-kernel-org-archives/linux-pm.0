From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 11/24] drivers: thermal: tsens: Save reference to the device pointer and use it
Date: Thu, 28 Feb 2019 17:51:01 +0530
Message-ID: <a2b7af050624a222c82584d1237cba46e5fff4f3.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Code cleanup making it easier to read

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index a82e4c928a78..aae3d71d7eed 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -119,6 +119,7 @@ static const struct regmap_config tsens_srot_config = {
 int __init init_common(struct tsens_priv *priv)
 {
 	void __iomem *tm_base, *srot_base;
+	struct device *dev = priv->dev;
 	struct resource *res;
 	u32 enabled;
 	int ret, i, j;
@@ -135,7 +136,7 @@ int __init init_common(struct tsens_priv *priv)
 		if (IS_ERR(srot_base))
 			return PTR_ERR(srot_base);
 
-		priv->srot_map = devm_regmap_init_mmio(priv->dev, srot_base,
+		priv->srot_map = devm_regmap_init_mmio(dev, srot_base,
 							&tsens_srot_config);
 		if (IS_ERR(priv->srot_map))
 			return PTR_ERR(priv->srot_map);
@@ -150,11 +151,11 @@ int __init init_common(struct tsens_priv *priv)
 	if (IS_ERR(tm_base))
 		return PTR_ERR(tm_base);
 
-	priv->tm_map = devm_regmap_init_mmio(priv->dev, tm_base, &tsens_config);
+	priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
 	if (IS_ERR(priv->tm_map))
 		return PTR_ERR(priv->tm_map);
 
-	priv->rf[TSENS_EN] = devm_regmap_field_alloc(priv->dev, priv->srot_map,
+	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						     priv->fields[TSENS_EN]);
 	if (IS_ERR(priv->rf[TSENS_EN]))
 		return PTR_ERR(priv->rf[TSENS_EN]);
@@ -162,24 +163,24 @@ int __init init_common(struct tsens_priv *priv)
 	if (ret)
 		return ret;
 	if (!enabled) {
-		dev_err(priv->dev, "tsens device is not enabled\n");
+		dev_err(dev, "tsens device is not enabled\n");
 		return -ENODEV;
 	}
 
-	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(priv->dev, priv->srot_map,
+	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						      priv->fields[SENSOR_EN]);
 	if (IS_ERR(priv->rf[SENSOR_EN]))
 		return PTR_ERR(priv->rf[SENSOR_EN]);
 
 	/* now alloc regmap_fields in tm_map */
 	for (i = 0, j = LAST_TEMP_0; i < priv->num_sensors; i++, j++) {
-		priv->rf[j] = devm_regmap_field_alloc(priv->dev, priv->tm_map,
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j]))
 			return PTR_ERR(priv->rf[j]);
 	}
 	for (i = 0, j = VALID_0; i < priv->num_sensors; i++, j++) {
-		priv->rf[j] = devm_regmap_field_alloc(priv->dev, priv->tm_map,
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j]))
 			return PTR_ERR(priv->rf[j]);
-- 
2.17.1
