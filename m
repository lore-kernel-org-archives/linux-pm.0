From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 19/24] drivers: thermal: tsens: Common get_temp() learns to do ADC conversion
Date: Thu,  7 Feb 2019 16:19:37 +0530
Message-ID: <187981aec80d2695c6cb4765600d2fe979122805.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

get_temp() learns to return temperature regardless of whether it is
returned as ADC code or direct temperature.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index ed975a2430d9..a935d2335eea 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -129,10 +129,15 @@ int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp)
 	if (ret)
 		return ret;
 
-	mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
-		       priv->fields[LAST_TEMP_0].lsb);
-	/* Convert temperature from deciCelsius to milliCelsius */
-	*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
+	if (priv->feat->adc) {
+		/* Convert temperature from ADC code to milliCelsius */
+		*temp = code_to_degc(last_temp, s) * 1000;
+	} else {
+		mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
+			       priv->fields[LAST_TEMP_0].lsb);
+		/* Convert temperature from deciCelsius to milliCelsius */
+		*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
+	}
 
 	return 0;
 }
-- 
2.17.1
