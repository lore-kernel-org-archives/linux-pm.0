From: Srikar Srimath Tirumala <srikars@nvidia.com>
Subject: [RFC][PATCH v2] thermal: add sysfs_notify on some attributes
Date: Thu, 25 Feb 2016 16:24:29 -0800
Message-ID: <1456446269-3176-1-git-send-email-srikars@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9279 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbcBZAY1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 19:24:27 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: srikars@nvidia.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mlongnecker@nvidia.com

Add a sysfs_notify on thermal_zone*/temp and cooling_device*/
cur_state whenever any trip is triggered or cur state is changed.

This change allows usermode apps to register themselves to get
notified, when certain thermal conditions occur and reduce their
workload. This workload throttling allows usermode to react before
hardware clocks are throttled and keep some critical apps running
reliably longer.

Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
---

Changes from v1:
 - Calling sysfs_notify for thermal_zone*/temp only when there is a
   trip violated on the thermal zone.
 - Modified commit message.

 drivers/thermal/thermal_core.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a0a8fd1..f54519e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -419,14 +419,23 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
-static void handle_non_critical_trips(struct thermal_zone_device *tz,
+static int handle_non_critical_trips(struct thermal_zone_device *tz,
 			int trip, enum thermal_trip_type trip_type)
 {
+	int trip_temp;
+	int ret = 0;
+
 	tz->governor ? tz->governor->throttle(tz, trip) :
 		       def_governor->throttle(tz, trip);
+
+	tz->ops->get_trip_temp(tz, trip, &trip_temp);
+	if (tz->temperature >= trip_temp)
+		ret = 1;
+
+	return ret;
 }
 
-static void handle_critical_trips(struct thermal_zone_device *tz,
+static int handle_critical_trips(struct thermal_zone_device *tz,
 				int trip, enum thermal_trip_type trip_type)
 {
 	int trip_temp;
@@ -435,7 +444,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 
 	/* If we have not crossed the trip_temp, we do not care. */
 	if (trip_temp <= 0 || tz->temperature < trip_temp)
-		return;
+		return 0;
 
 	trace_thermal_zone_trip(tz, trip, trip_type);
 
@@ -448,23 +457,28 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 			  tz->temperature / 1000);
 		orderly_poweroff(true);
 	}
+
+	return 1;
 }
 
-static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
+static int handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 {
+	int ret = 0;
 	enum thermal_trip_type type;
 
 	tz->ops->get_trip_type(tz, trip, &type);
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
-		handle_critical_trips(tz, trip, type);
+		ret = handle_critical_trips(tz, trip, type);
 	else
-		handle_non_critical_trips(tz, trip, type);
+		ret = handle_non_critical_trips(tz, trip, type);
 	/*
 	 * Alright, we handled this trip successfully.
 	 * So, start monitoring again.
 	 */
 	monitor_thermal_zone(tz);
+
+	return ret;
 }
 
 /**
@@ -556,7 +570,7 @@ static void thermal_zone_device_reset(struct thermal_zone_device *tz)
 void thermal_zone_device_update(struct thermal_zone_device *tz)
 {
 	int count;
-
+	int trips = 0;
 	if (atomic_read(&in_suspend))
 		return;
 
@@ -566,7 +580,10 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 	update_temperature(tz);
 
 	for (count = 0; count < tz->trips; count++)
-		handle_thermal_trip(tz, count);
+		trips += handle_thermal_trip(tz, count);
+
+	if (trips)
+		sysfs_notify(&tz->device.kobj, NULL, "temp");
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
@@ -1638,6 +1655,7 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	cdev->updated = true;
 	trace_cdev_update(cdev, target);
 	dev_dbg(&cdev->device, "set to state %lu\n", target);
+	sysfs_notify(&cdev->device.kobj, NULL, "cur_state");
 }
 EXPORT_SYMBOL(thermal_cdev_update);
 
-- 
2.1.4

