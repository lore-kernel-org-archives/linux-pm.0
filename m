From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 22/25] thermal/drivers/hisi: Add support for multi temp threshold
Date: Tue, 10 Oct 2017 20:02:47 +0200
Message-ID: <1507658570-32675-22-git-send-email-daniel.lezcano@linaro.org>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
 <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wangtao@linaro.org
List-Id: linux-pm@vger.kernel.org

From: Kevin Wangtao <kevin.wangtao@linaro.org>

The next patches will provide the support for the hi3660 where the temperature
sensor can have multiple alarm levels. In order to set the scene to support it,
we have to convert the current code to be able to support multiple threshold
values.

[Daniel Lezcano: Restated the log]

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index b5a7159..e87ca6c 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -46,10 +46,12 @@
 
 #define HI6220_DEFAULT_SENSOR		2
 
+#define MAX_THRES_NUM			2
+
 struct hisi_thermal_sensor {
 	struct thermal_zone_device *tzd;
 	uint32_t id;
-	uint32_t thres_temp;
+	uint32_t thres_temp[MAX_THRES_NUM];
 };
 
 struct hisi_thermal_data {
@@ -244,7 +246,7 @@ static int hi6220_thermal_enable_sensor(struct hisi_thermal_data *data)
 	hi6220_thermal_set_lag(data->regs, HI6220_TEMP_LAG);
 
 	/* enable for interrupt */
-	hi6220_thermal_alarm_set(data->regs, sensor->thres_temp);
+	hi6220_thermal_alarm_set(data->regs, sensor->thres_temp[0]);
 
 	hi6220_thermal_reset_set(data->regs, HI6220_TEMP_RESET);
 
@@ -303,7 +305,7 @@ static int hisi_thermal_get_temp(void *__data, int *temp)
 	*temp = data->get_temp(data);
 
 	dev_dbg(&data->pdev->dev, "id=%d, temp=%d, thres=%d\n",
-		sensor->id, *temp, sensor->thres_temp);
+		sensor->id, *temp, sensor->thres_temp[0]);
 
 	return 0;
 }
@@ -322,16 +324,16 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 
 	hisi_thermal_get_temp(data, &temp);
 
-	if (temp >= sensor->thres_temp) {
+	if (temp >= sensor->thres_temp[0]) {
 		dev_crit(&data->pdev->dev, "THERMAL ALARM: %d > %d\n",
-			 temp, sensor->thres_temp);
+			 temp, sensor->thres_temp[0]);
 
 		thermal_zone_device_update(data->sensor.tzd,
 					   THERMAL_EVENT_UNSPECIFIED);
 
 	} else {
 		dev_crit(&data->pdev->dev, "THERMAL ALARM stopped: %d < %d\n",
-			 temp, sensor->thres_temp);
+			 temp, sensor->thres_temp[0]);
 	}
 
 	return IRQ_HANDLED;
@@ -341,7 +343,7 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 					struct hisi_thermal_data *data,
 					struct hisi_thermal_sensor *sensor)
 {
-	int ret, i;
+	int ret, i, thres_idx = 0;
 	const struct thermal_trip *trip;
 
 	sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
@@ -359,8 +361,9 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 
 	for (i = 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
 		if (trip[i].type == THERMAL_TRIP_PASSIVE) {
-			sensor->thres_temp = trip[i].temperature;
-			break;
+			sensor->thres_temp[thres_idx++] = trip[i].temperature;
+			if (thres_idx >= MAX_THRES_NUM)
+				break;
 		}
 	}
 
-- 
2.7.4
