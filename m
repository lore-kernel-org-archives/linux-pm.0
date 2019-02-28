From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 13/24] drivers: thermal: tsens: Track IP version
Date: Thu, 28 Feb 2019 17:51:03 +0530
Message-ID: <4a91bf86d985129397312c25dec1f1f559c1ab53.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Version information is available on some TSENS IP. Allow reading it by
allocating memory for the regmap_field.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index aae3d71d7eed..8d632de2c7f8 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -155,6 +155,16 @@ int __init init_common(struct tsens_priv *priv)
 	if (IS_ERR(priv->tm_map))
 		return PTR_ERR(priv->tm_map);
 
+	/* alloc regmap_fields in srot_map */
+	if (priv->feat->ver_info) {
+		for (i = 0, j = VER_MAJOR; i < 2; i++, j++) {
+			priv->rf[j] = devm_regmap_field_alloc(dev, priv->srot_map,
+							      priv->fields[j]);
+			if (IS_ERR(priv->rf[j]))
+				return PTR_ERR(priv->rf[j]);
+		}
+	}
+
 	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						     priv->fields[TSENS_EN]);
 	if (IS_ERR(priv->rf[TSENS_EN]))
-- 
2.17.1
