From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 12/18] thermal/drivers/hisi: Remove thermal data back pointer
Date: Thu, 19 Oct 2017 19:05:54 +0200
Message-ID: <1508432760-17847-12-git-send-email-daniel.lezcano@linaro.org>
References: <6ac48f08-7fe6-92e9-0801-6ed3bcd05ff1@linaro.org>
 <1508432760-17847-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508432760-17847-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The presence of the thermal data pointer in the sensor structure has the unique
purpose of accessing the thermal data in the interrupt handler.

The sensor pointer is passed when registering the interrupt handler, replace the
cookie by the thermal data pointer, so the back pointer is no longer needed.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 5382073..b77ca19 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -47,7 +47,6 @@
 #define HISI_DEFAULT_SENSOR		2
 
 struct hisi_thermal_sensor {
-	struct hisi_thermal_data *thermal;
 	struct thermal_zone_device *tzd;
 	uint32_t id;
 	uint32_t thres_temp;
@@ -211,10 +210,10 @@ static void hisi_thermal_disable_sensor(struct hisi_thermal_data *data)
 	mutex_unlock(&data->thermal_lock);
 }
 
-static int hisi_thermal_get_temp(void *_sensor, int *temp)
+static int hisi_thermal_get_temp(void *__data, int *temp)
 {
-	struct hisi_thermal_sensor *sensor = _sensor;
-	struct hisi_thermal_data *data = sensor->thermal;
+	struct hisi_thermal_data *data = __data;
+	struct hisi_thermal_sensor *sensor = &data->sensor;
 
 	*temp = hisi_thermal_get_temperature(data->regs);
 
@@ -262,10 +261,10 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 	const struct thermal_trip *trip;
 
 	sensor->id = index;
-	sensor->thermal = data;
 
 	sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
-				sensor->id, sensor, &hisi_of_thermal_ops);
+							   sensor->id, data,
+							   &hisi_of_thermal_ops);
 	if (IS_ERR(sensor->tzd)) {
 		ret = PTR_ERR(sensor->tzd);
 		sensor->tzd = NULL;
-- 
2.7.4
