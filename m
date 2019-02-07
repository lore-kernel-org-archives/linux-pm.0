From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 17/24] drivers: thermal: tsens: simplify get_temp_tsens_v2 routine
Date: Thu,  7 Feb 2019 16:19:35 +0530
Message-ID: <9ee687bdeb1c0529038be823947da02f7d368f53.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The current implementation is based on an algorithm published in the
docs. Instead of reading the temperature thrice w/o any explanation,
improve the algorithm.

This will become the basis for a common get_temp routine in the future.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c | 55 ++++++++++-----------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 8052266447f5..0ea93b89bc65 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -25,58 +25,37 @@
 #define TM_Sn_STATUS_OFF		0x00a0
 #define TM_TRDY_OFF			0x00e4
 
-#define LAST_TEMP_MASK		0xfff
-
-static int get_temp_tsens_v2(struct tsens_priv *priv, int id, int *temp)
+static int get_temp_tsens_v2(struct tsens_priv *priv, int i, int *temp)
 {
-	struct tsens_sensor *s = &priv->sensor[id];
+	struct tsens_sensor *s = &priv->sensor[i];
 	u32 temp_idx = LAST_TEMP_0 + s->hw_id;
 	u32 valid_idx = VALID_0 + s->hw_id;
-	u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0, valid;
+	u32 last_temp = 0, valid, mask;
 	int ret;
 
-	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
-	if (ret)
-		return ret;
-
 	ret = regmap_field_read(priv->rf[valid_idx], &valid);
 	if (ret)
 		return ret;
-
-	if (valid)
-		goto done;
-
-	/* Try a second time */
-	ret = regmap_field_read(priv->rf[valid_idx], &valid);
-	if (ret)
-		return ret;
-	ret = regmap_field_read(priv->rf[temp_idx], &last_temp2);
-	if (ret)
-		return ret;
-	if (valid) {
-		last_temp = last_temp2;
-		goto done;
+	while (!valid) {
+		/* Valid bit is 0 for 6 AHB clock cycles.
+		 * At 19.2MHz, 1 AHB clock is ~60ns.
+		 * We should enter this loop very, very rarely.
+		 */
+		ndelay(400);
+		ret = regmap_field_read(priv->rf[valid_idx], &valid);
+		if (ret)
+			return ret;
 	}
 
-	/* Try a third/last time */
-	ret = regmap_field_read(priv->rf[valid_idx], &valid);
-	if (ret)
-		return ret;
-	ret = regmap_field_read(priv->rf[temp_idx], &last_temp3);
+	/* Valid bit is set, OK to read the temperature */
+	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
 	if (ret)
 		return ret;
-	if (valid) {
-		last_temp = last_temp3;
-		goto done;
-	}
 
-	if (last_temp == last_temp2)
-		last_temp = last_temp2;
-	else if (last_temp2 == last_temp3)
-		last_temp = last_temp3;
-done:
+	mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
+		       priv->fields[LAST_TEMP_0].lsb);
 	/* Convert temperature from deciCelsius to milliCelsius */
-	*temp = sign_extend32(last_temp, fls(LAST_TEMP_MASK) - 1) * 100;
+	*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
 
 	return 0;
 }
-- 
2.17.1
