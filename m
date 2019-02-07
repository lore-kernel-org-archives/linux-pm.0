From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 13/24] drivers: thermal: tsens: Print IP version
Date: Thu,  7 Feb 2019 16:19:31 +0530
Message-ID: <ab6dd34ce0236de12ec1e9984931780c3df643f9.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On some TSENS IP, version is stored. Print that version at init.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index aae3d71d7eed..39cd5733fd44 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -121,7 +121,7 @@ int __init init_common(struct tsens_priv *priv)
 	void __iomem *tm_base, *srot_base;
 	struct device *dev = priv->dev;
 	struct resource *res;
-	u32 enabled;
+	u32 enabled, maj_ver, min_ver;
 	int ret, i, j;
 	struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
 
@@ -155,6 +155,27 @@ int __init init_common(struct tsens_priv *priv)
 	if (IS_ERR(priv->tm_map))
 		return PTR_ERR(priv->tm_map);
 
+	for (i = 0; i < MAX_REGFIELDS; i++) {
+		priv->rf[i] = NULL;
+	}
+
+	/* alloc regmap_fields in srot_map */
+	if (priv->feat->ver_info) {
+		for (i = 0, j = VER_MAJOR; i < 2; i++, j++) {
+			priv->rf[j] = devm_regmap_field_alloc(dev, priv->srot_map,
+							      priv->fields[j]);
+			if (IS_ERR(priv->rf[j]))
+				return PTR_ERR(priv->rf[j]);
+		}
+		ret = regmap_field_read(priv->rf[VER_MAJOR], &maj_ver);
+		if (ret)
+			return ret;
+		ret = regmap_field_read(priv->rf[VER_MINOR], &min_ver);
+		if (ret)
+			return ret;
+		dev_info(dev, "version: %d.%d\n", maj_ver, min_ver);
+	}
+
 	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						     priv->fields[TSENS_EN]);
 	if (IS_ERR(priv->rf[TSENS_EN]))
-- 
2.17.1
