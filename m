From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 7/9] thermal: of: Add support for hardware-tracked trip points
Date: Mon, 18 Apr 2016 11:35:59 +0800
Message-ID: <1460950562-20652-8-git-send-email-wxt@rock-chips.com>
References: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, Mikko Perttunen <mperttunen@nvidia.com>, Paul Walmsley <pwalmsley@nvidia.com>, Wei Ni <wni@nvidia.com>, Caesar Wang <wxt@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

This adds support for hardware-tracked trip points to the device tree
thermal sensor framework.

The framework supports an arbitrary number of trip points. Whenever
the current temperature is updated, the trip points immediately
below and above the current temperature are found. A sensor driver
callback `set_trips' is then called with the temperatures.
If there is no trip point above or below the current temperature,
the passed trip temperature will be LONG_MAX or LONG_MIN respectively.
In this callback, the driver should program the hardware such that
it is notified when either of these trip points are triggered.
When a trip point is triggered, the driver should call
`thermal_zone_device_update' for the respective thermal zone. This
will cause the trip points to be updated again.

If the `set_trips' callback is not implemented (is NULL), the framework
behaves as before.

CQ-DEPEND=CL:*210768
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
Signed-off-by: Wei Ni <wni@nvidia.com>
 https://chromium-review.googlesource.com/212425
Reviewed-by: Olof Johansson <olofj@chromium.org>
Tested-by: Olof Johansson <olofj@chromium.org>
Reviewed-by: Dylan Reid <dgreid@chromium.org>
Tested-by: Dylan Reid <dgreid@chromium.org>
Tested-by: David Riley <davidriley@chromium.org>
Reviewed-by: David Riley <davidriley@chromium.org>
(cherry-picked from https://chromium.googlesource.com/chromiumos/
 third_party/kernel/+/v3.18 commit 397befabb2a52fc16586509a970f8c98268b8040)
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>

---

 drivers/thermal/of-thermal.c | 82 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/thermal.h      |  2 ++
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 8528802..cffa2a2 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -60,6 +60,8 @@ struct __thermal_bind_params {
  * @polling_delay: zone polling interval
  * @slope: slope of the temperature adjustment curve
  * @offset: offset of the temperature adjustment curve
+ * @prev_low_trip: previous low trip point temperature
+ * @prev_high_trip: previous high trip point temperature
  * @ntrips: number of trip points
  * @trips: an array of trip points (0..ntrips - 1)
  * @num_tbps: number of thermal bind params
@@ -74,6 +76,7 @@ struct __thermal_zone {
 	int polling_delay;
 	int slope;
 	int offset;
+	int prev_low_trip, prev_high_trip;
 
 	/* trip data */
 	int ntrips;
@@ -88,17 +91,63 @@ struct __thermal_zone {
 	const struct thermal_zone_of_device_ops *ops;
 };
 
+/***   Automatic trip handling   ***/
+
+static int of_thermal_set_trips(struct thermal_zone_device *tz, int temp)
+{
+	struct __thermal_zone *data = tz->devdata;
+	int low = INT_MIN, high = INT_MAX;
+	int i;
+
+	/* Hardware trip points not supported */
+	if (!data->ops->set_trips)
+		return 0;
+
+	/* No need to change trip points */
+	if (temp > data->prev_low_trip && temp < data->prev_high_trip)
+		return 0;
+
+	for (i = 0; i < data->ntrips; ++i) {
+		struct thermal_trip *trip = data->trips + i;
+		int trip_low = trip->temperature - trip->hysteresis;
+
+		if (trip_low < temp && trip_low > low)
+			low = trip_low;
+
+		if (trip->temperature > temp && trip->temperature < high)
+			high = trip->temperature;
+	}
+
+	dev_dbg(&tz->device,
+		"temperature %d, updating trip points to %d, %d\n",
+		temp, low, high);
+
+	data->prev_low_trip = low;
+	data->prev_high_trip = high;
+
+	return data->ops->set_trips(data->sensor_data, low, high);
+}
+
 /***   DT thermal zone device callbacks   ***/
 
 static int of_thermal_get_temp(struct thermal_zone_device *tz,
 			       int *temp)
 {
 	struct __thermal_zone *data = tz->devdata;
+	int err;
 
 	if (!data->ops->get_temp)
 		return -EINVAL;
 
-	return data->ops->get_temp(data->sensor_data, temp);
+	err = data->ops->get_temp(data->sensor_data, temp);
+	if (err)
+		return err;
+
+	err = of_thermal_set_trips(tz, *temp);
+	if (err)
+		return err;
+
+	return 0;
 }
 
 /**
@@ -297,6 +346,22 @@ static int of_thermal_set_mode(struct thermal_zone_device *tz,
 	return 0;
 }
 
+static int of_thermal_update_trips(struct thermal_zone_device *tz)
+{
+	int temp;
+	int err;
+
+	err = of_thermal_get_temp(tz, &temp);
+	if (err)
+		return err;
+
+	err = of_thermal_set_trips(tz, temp);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
 				    enum thermal_trip_type *type)
 {
@@ -327,6 +392,7 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 				    int temp)
 {
 	struct __thermal_zone *data = tz->devdata;
+	int err;
 
 	if (trip >= data->ntrips || trip < 0)
 		return -EDOM;
@@ -342,6 +408,10 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 	/* thermal framework should take care of data->mask & (1 << trip) */
 	data->trips[trip].temperature = temp;
 
+	err = of_thermal_update_trips(tz);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -362,6 +432,7 @@ static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
 	struct __thermal_zone *data = tz->devdata;
+	int err;
 
 	if (trip >= data->ntrips || trip < 0)
 		return -EDOM;
@@ -369,6 +440,10 @@ static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 	/* thermal framework should take care of data->mask & (1 << trip) */
 	data->trips[trip].hysteresis = hyst;
 
+	err = of_thermal_update_trips(tz);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -425,6 +500,8 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 	tz->ops = ops;
 	tz->sensor_data = data;
 
+	of_thermal_update_trips(tzd);
+
 	tzd->ops->get_temp = of_thermal_get_temp;
 	tzd->ops->get_trend = of_thermal_get_trend;
 	tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
@@ -859,6 +936,9 @@ thermal_of_build_thermal_zone(struct device_node *np)
 	/* trips */
 	child = of_get_child_by_name(np, "trips");
 
+	tz->prev_high_trip = INT_MIN;
+	tz->prev_low_trip = INT_MAX;
+
 	/* No trips provided */
 	if (!child)
 		goto finish;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 97b86c5..6ef932a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -335,12 +335,14 @@ struct thermal_genl_event {
  * @get_trend: a pointer to a function that reads the sensor temperature trend.
  * @set_emul_temp: a pointer to a function that sets sensor emulated
  *		   temperature.
+ * @set_trips: a pointer to a function that set low/high trip temperature.
  */
 struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, int *);
 	int (*get_trend)(void *, long *);
 	int (*set_emul_temp)(void *, int);
 	int (*set_trip_temp)(void *, int, int);
+	int (*set_trips)(void *, int, int);
 };
 
 /**
-- 
1.9.1
