From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 18/24] drivers: thermal: tsens: Move get_temp_tsens_v2 to allow sharing
Date: Thu, 28 Feb 2019 17:51:08 +0530
Message-ID: <30911f4ce9cd5094d4dea29d1e92da3cca6f7537.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Just rename the function and move it to allow code sharing with future
versions of TSENS IP

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 35 +++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens-v2.c     | 37 +----------------------------
 drivers/thermal/qcom/tsens.h        |  1 +
 3 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 5f838fd798c3..7bab0e640806 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -102,6 +102,41 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 	return degc;
 }
 
+int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp)
+{
+	struct tsens_sensor *s = &priv->sensor[i];
+	u32 temp_idx = LAST_TEMP_0 + s->hw_id;
+	u32 valid_idx = VALID_0 + s->hw_id;
+	u32 last_temp = 0, valid, mask;
+	int ret;
+
+	ret = regmap_field_read(priv->rf[valid_idx], &valid);
+	if (ret)
+		return ret;
+	while (!valid) {
+		/* Valid bit is 0 for 6 AHB clock cycles.
+		 * At 19.2MHz, 1 AHB clock is ~60ns.
+		 * We should enter this loop very, very rarely.
+		 */
+		ndelay(400);
+		ret = regmap_field_read(priv->rf[valid_idx], &valid);
+		if (ret)
+			return ret;
+	}
+
+	/* Valid bit is set, OK to read the temperature */
+	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
+	if (ret)
+		return ret;
+
+	mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
+		       priv->fields[LAST_TEMP_0].lsb);
+	/* Convert temperature from deciCelsius to milliCelsius */
+	*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
+
+	return 0;
+}
+
 int get_temp_common(struct tsens_priv *priv, int i, int *temp)
 {
 	struct tsens_sensor *s = &priv->sensor[i];
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index e180e80f533c..2e2331f5c248 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -25,41 +25,6 @@
 #define TM_Sn_STATUS_OFF		0x00a0
 #define TM_TRDY_OFF			0x00e4
 
-static int get_temp_tsens_v2(struct tsens_priv *priv, int i, int *temp)
-{
-	struct tsens_sensor *s = &priv->sensor[i];
-	u32 temp_idx = LAST_TEMP_0 + s->hw_id;
-	u32 valid_idx = VALID_0 + s->hw_id;
-	u32 last_temp = 0, valid, mask;
-	int ret;
-
-	ret = regmap_field_read(priv->rf[valid_idx], &valid);
-	if (ret)
-		return ret;
-	while (!valid) {
-		/* Valid bit is 0 for 6 AHB clock cycles.
-		 * At 19.2MHz, 1 AHB clock is ~60ns.
-		 * We should enter this loop very, very rarely.
-		 */
-		ndelay(400);
-		ret = regmap_field_read(priv->rf[valid_idx], &valid);
-		if (ret)
-			return ret;
-	}
-
-	/* Valid bit is set, OK to read the temperature */
-	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
-	if (ret)
-		return ret;
-
-	mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
-		       priv->fields[LAST_TEMP_0].lsb);
-	/* Convert temperature from deciCelsius to milliCelsius */
-	*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
-
-	return 0;
-}
-
 /* v2.x: 8996, 8998, sdm845 */
 
 const struct tsens_features tsens_v2_feat = {
@@ -114,7 +79,7 @@ const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 
 static const struct tsens_ops ops_generic_v2 = {
 	.init		= init_common,
-	.get_temp	= get_temp_tsens_v2,
+	.get_temp	= get_temp_tsens_valid,
 };
 
 const struct tsens_plat_data data_tsens_v2 = {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index eb988c1d17c4..1cef2b8431eb 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -363,6 +363,7 @@ struct tsens_priv {
 char *qfprom_read(struct device *dev, const char *cname);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
 int init_common(struct tsens_priv *priv);
+int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp);
 int get_temp_common(struct tsens_priv *priv, int i, int *temp);
 bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id);
 
-- 
2.17.1
