From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 03/14] thermal/drivers/hisi: Set the thermal zone private data to the sensor pointer
Date: Tue, 25 Sep 2018 11:03:01 +0200
Message-ID: <1537866192-12320-4-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Store the sensor pointer in the thermal zone private data and use it
in the callback functions. That allows to continue the conversion to
sensor oriented code where the pointers are the sensors.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 1fdda55..567fde6 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -442,8 +442,8 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 
 static int hisi_thermal_get_temp(void *__data, int *temp)
 {
-	struct hisi_thermal_data *data = __data;
-	struct hisi_thermal_sensor *sensor = &data->sensor;
+	struct hisi_thermal_sensor *sensor = __data;
+	struct hisi_thermal_data *data = sensor->data;
 
 	*temp = data->ops->get_temp(sensor);
 
@@ -465,7 +465,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 
 	data->ops->irq_handler(sensor);
 
-	hisi_thermal_get_temp(data, &temp);
+	hisi_thermal_get_temp(sensor, &temp);
 
 	if (temp >= sensor->thres_temp) {
 		dev_crit(&data->pdev->dev, "THERMAL ALARM: %d > %d\n",
@@ -486,11 +486,10 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 					struct hisi_thermal_sensor *sensor)
 {
 	int ret, i;
-	struct hisi_thermal_data *data = sensor->data;
 	const struct thermal_trip *trip;
 
 	sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							   sensor->id, data,
+							   sensor->id, sensor,
 							   &hisi_of_thermal_ops);
 	if (IS_ERR(sensor->tzd)) {
 		ret = PTR_ERR(sensor->tzd);
-- 
2.7.4
