From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH RFC 1/2] thermal/drivers/of: Add a get_temp_id callback function
Date: Thu,  4 Apr 2019 10:06:46 +0200
Message-ID: <20190404080647.8173-1-daniel.lezcano@linaro.org>
References: <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andrew.smirnov@gmail.com
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Currently when we register a sensor, we specify the sensor id and a data
pointer to be passed when the get_temp function is called. However the
sensor_id is not passed to the get_temp callback forcing the driver to
do extra allocation and adding back pointer to find out from the sensor
information the driver data and then back to the sensor id.

Add a new callback get_temp_id() which will be called if set. It will
call the get_temp_id() with the sensor id.

That will be more consistent with the registering function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/of-thermal.c | 19 +++++++++++++------
 include/linux/thermal.h      |  1 +
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 2df059cc07e2..787d1cbe13f3 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -78,6 +78,8 @@ struct __thermal_zone {
 
 	/* sensor interface */
 	void *sensor_data;
+	int sensor_id;
+
 	const struct thermal_zone_of_device_ops *ops;
 };
 
@@ -88,10 +90,14 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
 {
 	struct __thermal_zone *data = tz->devdata;
 
-	if (!data->ops->get_temp)
-		return -EINVAL;
+	if (data->ops->get_temp)
+		return data->ops->get_temp(data->sensor_data, temp);
 
-	return data->ops->get_temp(data->sensor_data, temp);
+	if (data->ops->get_temp_id)
+		return data->ops->get_temp_id(data->sensor_id,
+					      data->sensor_data, temp);
+
+	return -EINVAL;
 }
 
 static int of_thermal_set_trips(struct thermal_zone_device *tz,
@@ -407,8 +413,8 @@ static struct thermal_zone_device_ops of_thermal_ops = {
 /***   sensor API   ***/
 
 static struct thermal_zone_device *
-thermal_zone_of_add_sensor(struct device_node *zone,
-			   struct device_node *sensor, void *data,
+thermal_zone_of_add_sensor(struct device_node *zone, struct device_node *sensor,
+			   int sensor_id, void *data,
 			   const struct thermal_zone_of_device_ops *ops)
 {
 	struct thermal_zone_device *tzd;
@@ -426,6 +432,7 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 	mutex_lock(&tzd->lock);
 	tz->ops = ops;
 	tz->sensor_data = data;
+	tz->sensor_id = sensor_id;
 
 	tzd->ops->get_temp = of_thermal_get_temp;
 	tzd->ops->get_trend = of_thermal_get_trend;
@@ -516,7 +523,7 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 		}
 
 		if (sensor_specs.np == sensor_np && id == sensor_id) {
-			tzd = thermal_zone_of_add_sensor(child, sensor_np,
+			tzd = thermal_zone_of_add_sensor(child, sensor_np, sensor_id,
 							 data, ops);
 			if (!IS_ERR(tzd))
 				tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5f4705f46c2f..2762d7e6dd86 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -351,6 +351,7 @@ struct thermal_genl_event {
  *		   hardware.
  */
 struct thermal_zone_of_device_ops {
+	int (*get_temp_id)(int, void *, int *);
 	int (*get_temp)(void *, int *);
 	int (*get_trend)(void *, int, enum thermal_trend *);
 	int (*set_trips)(void *, int, int);
-- 
2.17.1
