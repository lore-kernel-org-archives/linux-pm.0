From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCHv3 11/23] drivers: thermal: tsens: Save reference to the device pointer and use it
Date: Wed, 20 Mar 2019 18:47:51 +0530
Message-ID: <8d368c678b3985cc58a0c314ee14756921d33746.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
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
index 0f9deec2517a..9d7a6c328ae0 100644
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
@@ -137,7 +138,7 @@ int __init init_common(struct tsens_priv *priv)
 			goto err_put_device;
 		}
 
-		priv->srot_map = devm_regmap_init_mmio(priv->dev, srot_base,
+		priv->srot_map = devm_regmap_init_mmio(dev, srot_base,
 							&tsens_srot_config);
 		if (IS_ERR(priv->srot_map)) {
 			ret = PTR_ERR(priv->srot_map);
@@ -155,13 +156,13 @@ int __init init_common(struct tsens_priv *priv)
 		goto err_put_device;
 	}
 
-	priv->tm_map = devm_regmap_init_mmio(priv->dev, tm_base, &tsens_config);
+	priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
 	if (IS_ERR(priv->tm_map)) {
 		ret = PTR_ERR(priv->tm_map);
 		goto err_put_device;
 	}
 
-	priv->rf[TSENS_EN] = devm_regmap_field_alloc(priv->dev, priv->srot_map,
+	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						     priv->fields[TSENS_EN]);
 	if (IS_ERR(priv->rf[TSENS_EN])) {
 		ret = PTR_ERR(priv->rf[TSENS_EN]);
@@ -171,12 +172,12 @@ int __init init_common(struct tsens_priv *priv)
 	if (ret)
 		goto err_put_device;
 	if (!enabled) {
-		dev_err(priv->dev, "tsens device is not enabled\n");
+		dev_err(dev, "tsens device is not enabled\n");
 		ret = -ENODEV;
 		goto err_put_device;
 	}
 
-	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(priv->dev, priv->srot_map,
+	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						      priv->fields[SENSOR_EN]);
 	if (IS_ERR(priv->rf[SENSOR_EN])) {
 		ret = PTR_ERR(priv->rf[SENSOR_EN]);
@@ -184,7 +185,7 @@ int __init init_common(struct tsens_priv *priv)
 	}
 	/* now alloc regmap_fields in tm_map */
 	for (i = 0, j = LAST_TEMP_0; i < priv->num_sensors; i++, j++) {
-		priv->rf[j] = devm_regmap_field_alloc(priv->dev, priv->tm_map,
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j])) {
 			ret = PTR_ERR(priv->rf[j]);
@@ -192,7 +193,7 @@ int __init init_common(struct tsens_priv *priv)
 		}
 	}
 	for (i = 0, j = VALID_0; i < priv->num_sensors; i++, j++) {
-		priv->rf[j] = devm_regmap_field_alloc(priv->dev, priv->tm_map,
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j])) {
 			ret = PTR_ERR(priv->rf[j]);
-- 
2.17.1
