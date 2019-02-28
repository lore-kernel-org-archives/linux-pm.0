From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 05/24] drivers: thermal: tsens: Use consistent names for variables
Date: Thu, 28 Feb 2019 17:50:55 +0530
Message-ID: <22c775079adc2dae926cd71e6d6ebd429510eeba.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

tsens_get_temp() uses the name 'data' for the void pointer, use the same
in tsens_get_trend() for consistency.

Remove a stray space while we're at it.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 4582d2b30e94..0b5be08d515f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -20,13 +20,13 @@ static int tsens_get_temp(void *data, int *temp)
 	return priv->ops->get_temp(priv, s->id, temp);
 }
 
-static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
+static int tsens_get_trend(void *data, int trip, enum thermal_trend *trend)
 {
-	const struct tsens_sensor *s = p;
+	const struct tsens_sensor *s = data;
 	struct tsens_priv *priv = s->priv;
 
 	if (priv->ops->get_trend)
-		return  priv->ops->get_trend(priv, s->id, trend);
+		return priv->ops->get_trend(priv, s->id, trend);
 
 	return -ENOTSUPP;
 }
-- 
2.17.1
