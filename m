From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 06/24] drivers: thermal: tsens: Function prototypes should have argument names
Date: Thu, 28 Feb 2019 17:50:56 +0530
Message-ID: <d60e24ac848607a8bf2815fd5daf7379c280f39d.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

check_patch complains a lot as follows:

WARNING: function definition argument 'struct tsens_priv *' should also have an identifier name
+       int (*init)(struct tsens_priv *);

Fix it.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 61ca2905ee7a..4d6a406f8dca 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -47,15 +47,15 @@ struct tsens_sensor {
  */
 struct tsens_ops {
 	/* mandatory callbacks */
-	int (*init)(struct tsens_priv *);
-	int (*calibrate)(struct tsens_priv *);
-	int (*get_temp)(struct tsens_priv *, int, int *);
+	int (*init)(struct tsens_priv *priv);
+	int (*calibrate)(struct tsens_priv *priv);
+	int (*get_temp)(struct tsens_priv *priv, int i, int *temp);
 	/* optional callbacks */
-	int (*enable)(struct tsens_priv *, int);
-	void (*disable)(struct tsens_priv *);
-	int (*suspend)(struct tsens_priv *);
-	int (*resume)(struct tsens_priv *);
-	int (*get_trend)(struct tsens_priv *, int, enum thermal_trend *);
+	int (*enable)(struct tsens_priv *priv, int i);
+	void (*disable)(struct tsens_priv *priv);
+	int (*suspend)(struct tsens_priv *priv);
+	int (*resume)(struct tsens_priv *priv);
+	int (*get_trend)(struct tsens_priv *priv, int i, enum thermal_trend *trend);
 };
 
 enum reg_list {
@@ -111,10 +111,10 @@ struct tsens_priv {
 	struct tsens_sensor		sensor[0];
 };
 
-char *qfprom_read(struct device *, const char *);
-void compute_intercept_slope(struct tsens_priv *, u32 *, u32 *, u32);
-int init_common(struct tsens_priv *);
-int get_temp_common(struct tsens_priv *, int, int *);
+char *qfprom_read(struct device *dev, const char *cname);
+void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
+int init_common(struct tsens_priv *priv);
+int get_temp_common(struct tsens_priv *priv, int i, int *temp);
 
 /* TSENS v1 targets */
 extern const struct tsens_plat_data data_8916, data_8974, data_8960;
-- 
2.17.1
