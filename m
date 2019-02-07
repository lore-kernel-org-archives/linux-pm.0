From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 16/24] drivers: thermal: tsens: Introduce IP-specific max_sensor count
Date: Thu,  7 Feb 2019 16:19:34 +0530
Message-ID: <d112623568e98a6329547d4692d50e3b3ba09274.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The IP can support 'm' sensors while the platform can enable 'n' sensors
of the 'm' where n <= m.

Track maximum sensors supported by the IP so that we can correctly track
what subset of the sensors are supported on the platform.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 4 ++--
 drivers/thermal/qcom/tsens-v0_1.c   | 1 +
 drivers/thermal/qcom/tsens-v2.c     | 1 +
 drivers/thermal/qcom/tsens.h        | 2 ++
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 020409d8daf0..d981effed493 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -208,13 +208,13 @@ int __init init_common(struct tsens_priv *priv)
 		return PTR_ERR(priv->rf[SENSOR_EN]);
 
 	/* now alloc regmap_fields in tm_map */
-	for (i = 0, j = LAST_TEMP_0; i < priv->num_sensors; i++, j++) {
+	for (i = 0, j = LAST_TEMP_0; i < priv->feat->max_sensors; i++, j++) {
 		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j]))
 			return PTR_ERR(priv->rf[j]);
 	}
-	for (i = 0, j = VALID_0; i < priv->num_sensors; i++, j++) {
+	for (i = 0, j = VALID_0; i < priv->feat->max_sensors; i++, j++) {
 		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j]))
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index ad1052e05e45..4f17b4b781b0 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -324,6 +324,7 @@ const struct tsens_features tsens_v0_1_feat = {
 	.crit_int	= 0,
 	.adc		= 1,
 	.srot_split	= 1,
+	.max_sensors	= 11,
 };
 
 /* v0.1: 8916, 8974 */
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index e0aac59d72ec..8052266447f5 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -88,6 +88,7 @@ const struct tsens_features tsens_v2_feat = {
 	.crit_int	= 1,
 	.adc		= 0,
 	.srot_split	= 1,
+	.max_sensors	= 16,
 };
 
 const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index e0c1ca1a7467..9db89dffb719 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -189,12 +189,14 @@ enum regfield_ids {
  * @adc:      do the sensors only output adc code (instead of temperature)?
  * @srot_split: does the IP neatly splits the register space into SROT and TM,
  *              with SROT only being available to secure boot firmware?
+ * @max_sensors: maximum sensors supported by this version of the IP
  */
 struct tsens_features {
 	unsigned int ver_info:1;
 	unsigned int crit_int:1;
 	unsigned int adc:1;
 	unsigned int srot_split:1;
+	unsigned int max_sensors;
 };
 
 /**
-- 
2.17.1
