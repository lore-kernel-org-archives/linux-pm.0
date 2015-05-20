From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 12/16] thermal: thermal: Add support for hardware-tracked trip points
Date: Wed, 20 May 2015 15:20:42 +0200
Message-ID: <1432128046-12921-13-git-send-email-s.hauer@pengutronix.de>
References: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34876 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbbETNVL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2015 09:21:11 -0400
In-Reply-To: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

This adds support for hardware-tracked trip points to the device tree
thermal sensor framework.

The framework supports an arbitrary number of trip points. Whenever
the current temperature is updated, the trip points immediately
below and above the current temperature are found. A .set_trips
callback is then called with the temperatures. If there is no trip
point above or below the current temperature, the passed trip
temperature will be -INT_MAX or INT_MAX respectively. In this callback,
the driver should program the hardware such that it is notified
when either of these trip points are triggered. When a trip point
is triggered, the driver should call `thermal_zone_device_update'
for the respective thermal zone. This will cause the trip points
to be updated again.

If .set_trips is not implemented, the framework behaves as before.

This patch is based on an earlier version from Mikko Perttunen
<mikko.perttunen@kapsi.fi>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/thermal_core.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |  3 +++
 2 files changed, 54 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6bbf61f..80eb4ea 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -453,6 +453,47 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
+static void thermal_zone_set_trips(struct thermal_zone_device *tz)
+{
+	int low = -INT_MAX;
+	int high = INT_MAX;
+	int trip_temp, hysteresis;
+	int temp = tz->temperature;
+	int i, ret;
+
+	if (!tz->ops->set_trips)
+		return;
+
+	for (i = 0; i < tz->trips; i++) {
+		int trip_low;
+
+		tz->ops->get_trip_temp(tz, i, &trip_temp);
+		tz->ops->get_trip_hyst(tz, i, &hysteresis);
+
+		trip_low = trip_temp - hysteresis;
+
+		if (trip_low < temp && trip_low > low)
+			low = trip_low;
+
+		if (trip_temp > temp && trip_temp < high)
+			high = trip_temp;
+	}
+
+	/* No need to change trip points */
+	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
+		return;
+
+	tz->prev_low_trip = low;
+	tz->prev_high_trip = high;
+
+	dev_dbg(&tz->device, "new temperature boundaries: %d < x < %d\n",
+			low, high);
+
+	ret = tz->ops->set_trips(tz, low, high);
+	if (ret)
+		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
+}
+
 void thermal_zone_device_update(struct thermal_zone_device *tz)
 {
 	int temp, ret, count;
@@ -479,6 +520,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 	dev_dbg(&tz->device, "last_temperature=%d, current_temperature=%d\n",
 				tz->last_temperature, tz->temperature);
 
+	thermal_zone_set_trips(tz);
+
 	for (count = 0; count < tz->trips; count++)
 		handle_thermal_trip(tz, count);
 }
@@ -611,6 +654,9 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 
 	ret = tz->ops->set_trip_temp(tz, trip, temperature);
 
+	if (!ret)
+		thermal_zone_set_trips(tz);
+
 	return ret ? ret : count;
 }
 
@@ -660,6 +706,9 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	 */
 	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
 
+	if (!ret)
+		thermal_zone_set_trips(tz);
+
 	return ret ? ret : count;
 }
 
@@ -1494,6 +1543,8 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	tz->trips = trips;
 	tz->passive_delay = passive_delay;
 	tz->polling_delay = polling_delay;
+	tz->prev_low_trip = INT_MAX;
+	tz->prev_high_trip = -INT_MAX;
 
 	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
 	result = device_register(&tz->device);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 07bd5e8..aef6e13 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -87,6 +87,7 @@ struct thermal_zone_device_ops {
 	int (*unbind) (struct thermal_zone_device *,
 		       struct thermal_cooling_device *);
 	int (*get_temp) (struct thermal_zone_device *, int *);
+	int (*set_trips) (struct thermal_zone_device *, int, int);
 	int (*get_mode) (struct thermal_zone_device *,
 			 enum thermal_device_mode *);
 	int (*set_mode) (struct thermal_zone_device *,
@@ -180,6 +181,8 @@ struct thermal_zone_device {
 	int last_temperature;
 	int emul_temperature;
 	int passive;
+	int prev_low_trip;
+	int prev_high_trip;
 	unsigned int forced_passive;
 	const struct thermal_zone_device_ops *ops;
 	const struct thermal_zone_params *tzp;
-- 
2.1.4

