From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 09/11] thermal: tsens: Get rid of 'id' field
Date: Tue, 28 Aug 2018 19:08:38 +0530
Message-ID: <6c23d113e19a9ddf9dc9def18943eaf7f5ad4d79.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The hw_id field in 'struct tsens_sensor' can do the job of tracking
unique ids for each sensor connected to each tsens device instance. It
also allows hw_ids to be overridden (e.g. 8916) in cases where some
sensors in a sequence are disabled on a particular platform.

Use the hw_id field instead of the id field consistently across the
tsens code.

While we're at it, document the fields of struct tsens_sensor.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom/tsens.c |  5 ++---
 drivers/thermal/qcom/tsens.h | 10 +++++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 9a8e8f7b4ae1..fb728ec5d77f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -17,7 +17,7 @@ static int tsens_get_temp(void *data, int *temp)
 	const struct tsens_sensor *s = data;
 	struct tsens_device *tmdev = s->tmdev;
 
-	return tmdev->ops->get_temp(tmdev, s->id, temp);
+	return tmdev->ops->get_temp(tmdev, s->hw_id, temp);
 }
 
 static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
@@ -26,7 +26,7 @@ static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
 	struct tsens_device *tmdev = s->tmdev;
 
 	if (tmdev->ops->get_trend)
-		return  tmdev->ops->get_trend(tmdev, s->id, trend);
+		return  tmdev->ops->get_trend(tmdev, s->hw_id, trend);
 
 	return -ENOTSUPP;
 }
@@ -83,7 +83,6 @@ static int tsens_register(struct tsens_device *tmdev)
 
 	for (i = 0;  i < tmdev->num_sensors; i++) {
 		tmdev->sensor[i].tmdev = tmdev;
-		tmdev->sensor[i].id = i;
 		tzd = devm_thermal_zone_of_sensor_register(tmdev->dev, i,
 							   &tmdev->sensor[i],
 							   &tsens_of_ops);
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index b9c4bcf255fa..2a3174dfc1a9 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -14,11 +14,19 @@
 
 struct tsens_device;
 
+/**
+ * struct tsens_sensor - sensor-specific data
+ * @tmdev: tsens device instance this sensor is connected to
+ * @tzd: thermal zone corresponding to this sensor
+ * @offset: offset from calibration data to convert ADC data to degrees
+ * @hw_id: unique sensor ID for each sensor connected to tsens device instance
+ * @slope: slope from calibration data to convert ADC data to degrees
+ * @status: 8960-specific status register addresses
+ */
 struct tsens_sensor {
 	struct tsens_device		*tmdev;
 	struct thermal_zone_device	*tzd;
 	int				offset;
-	int				id;
 	int				hw_id;
 	int				slope;
 	u32				status;
-- 
2.17.1
