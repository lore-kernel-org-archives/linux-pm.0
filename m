From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCHv3 13/23] drivers: thermal: tsens: Add new operation to check if a sensor is enabled
Date: Wed, 20 Mar 2019 18:47:53 +0530
Message-ID: <4917d603944b606aa3a621ef6731d3dac7cca14c.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

is_sensor_enabled() checks if the sensors are enabled on this platform.
It is possible that the SoC might choose not to enable all the sensors
that the IP block is capable of supporting.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 14 ++++++++++++++
 drivers/thermal/qcom/tsens-v0_1.c   |  1 +
 drivers/thermal/qcom/tsens-v2.c     |  1 +
 drivers/thermal/qcom/tsens.c        |  5 +++++
 drivers/thermal/qcom/tsens.h        |  1 +
 5 files changed, 22 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 9d7a6c328ae0..c76f8cfb25a2 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -69,6 +69,20 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 	}
 }
 
+bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id)
+{
+	u32 val;
+	int ret;
+
+	if ((hw_id > (priv->num_sensors - 1)) || (hw_id < 0))
+		return -EINVAL;
+	ret = regmap_field_read(priv->rf[SENSOR_EN], &val);
+	if (ret)
+		return ret;
+
+	return val & (1 << hw_id);
+}
+
 static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 {
 	int degc, num, den;
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index d171a4a8c454..431255bfd0ef 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -333,6 +333,7 @@ const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
 	/* CTRL_OFFSET */
 	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF, 0,  0),
 	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF, 1,  1),
+	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF, 3, 13),
 
 	/* ----- TM ------ */
 	/* INTERRUPT ENABLE */
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index e15a302f7878..4b98dbe4e3c3 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -99,6 +99,7 @@ const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	/* CTRL_OFF */
 	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
 	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
+	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3, 18),
 
 	/* ----- TM ------ */
 	/* INTERRUPT ENABLE */
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 057b33353ba3..fc44cac31fa5 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -82,6 +82,11 @@ static int tsens_register(struct tsens_priv *priv)
 	struct thermal_zone_device *tzd;
 
 	for (i = 0;  i < priv->num_sensors; i++) {
+		if (!is_sensor_enabled(priv, priv->sensor[i].hw_id)) {
+			dev_err(priv->dev, "sensor %d: disabled\n",
+				priv->sensor[i].hw_id);
+			continue;
+		}
 		priv->sensor[i].priv = priv;
 		priv->sensor[i].id = i;
 		tzd = devm_thermal_zone_of_sensor_register(priv->dev, i,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index a9390e06b4dd..a3bf7de88ae8 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -307,6 +307,7 @@ char *qfprom_read(struct device *dev, const char *cname);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
 int init_common(struct tsens_priv *priv);
 int get_temp_common(struct tsens_priv *priv, int i, int *temp);
+bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id);
 
 /* TSENS target */
 extern const struct tsens_plat_data data_8960;
-- 
2.17.1
