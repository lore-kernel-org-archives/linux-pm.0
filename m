From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 13/34] Thermal: Remove throttling logic out of thermal_sys.c
Date: Sun,  2 Dec 2012 22:44:47 +0800
Message-ID: <1354459508-3707-13-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:6656 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441Ab2LBOpj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:39 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Durgadoss R <durgadoss.r@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Durgadoss R <durgadoss.r@intel.com>

This patch removes the throttling logic out of
thermal_sys.c; also refactors the code into smaller
functions so that are easy to read/maintain.
 * Seperates the handling of critical and non-critical trips
 * Re-arranges the set_polling and device_check methods, so
   that all related functions are arranged in one place.
 * Removes the 'do_update' and 'trip_update' method, as part
   of moving the throttling logic out of thermal_sys.c

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |  307 +++++++++++++++--------------------------
 1 files changed, 109 insertions(+), 198 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 9d21f82..64f3e97 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -306,6 +306,115 @@ static void bind_tz(struct thermal_zone_device *tz)
 	mutex_unlock(&thermal_list_lock);
 }
 
+static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
+					    int delay)
+{
+	if (delay > 1000)
+		mod_delayed_work(system_freezable_wq, &tz->poll_queue,
+				 round_jiffies(msecs_to_jiffies(delay)));
+	else if (delay)
+		mod_delayed_work(system_freezable_wq, &tz->poll_queue,
+				 msecs_to_jiffies(delay));
+	else
+		cancel_delayed_work(&tz->poll_queue);
+}
+
+static void monitor_thermal_zone(struct thermal_zone_device *tz)
+{
+	mutex_lock(&tz->lock);
+
+	if (tz->passive)
+		thermal_zone_device_set_polling(tz, tz->passive_delay);
+	else if (tz->polling_delay)
+		thermal_zone_device_set_polling(tz, tz->polling_delay);
+	else
+		thermal_zone_device_set_polling(tz, 0);
+
+	mutex_unlock(&tz->lock);
+}
+
+static void handle_non_critical_trips(struct thermal_zone_device *tz,
+			int trip, enum thermal_trip_type trip_type)
+{
+	tz->governor->throttle(tz, trip);
+}
+
+static void handle_critical_trips(struct thermal_zone_device *tz,
+				int trip, enum thermal_trip_type trip_type)
+{
+	long trip_temp;
+
+	tz->ops->get_trip_temp(tz, trip, &trip_temp);
+
+	/* If we have not crossed the trip_temp, we do not care. */
+	if (tz->temperature < trip_temp)
+		return;
+
+	if (tz->ops->notify)
+		tz->ops->notify(tz, trip, trip_type);
+
+	if (trip_type == THERMAL_TRIP_CRITICAL) {
+		pr_emerg("Critical temperature reached(%d C),shutting down\n",
+			 tz->temperature / 1000);
+		orderly_poweroff(true);
+	}
+}
+
+static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
+{
+	enum thermal_trip_type type;
+
+	tz->ops->get_trip_type(tz, trip, &type);
+
+	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
+		handle_critical_trips(tz, trip, type);
+	else
+		handle_non_critical_trips(tz, trip, type);
+	/*
+	 * Alright, we handled this trip successfully.
+	 * So, start monitoring again.
+	 */
+	monitor_thermal_zone(tz);
+}
+
+static void update_temperature(struct thermal_zone_device *tz)
+{
+	long temp;
+	int ret;
+
+	mutex_lock(&tz->lock);
+
+	ret = tz->ops->get_temp(tz, &temp);
+	if (ret) {
+		pr_warn("failed to read out thermal zone %d\n", tz->id);
+		return;
+	}
+
+	tz->last_temperature = tz->temperature;
+	tz->temperature = temp;
+
+	mutex_unlock(&tz->lock);
+}
+
+void thermal_zone_device_update(struct thermal_zone_device *tz)
+{
+	int count;
+
+	update_temperature(tz);
+
+	for (count = 0; count < tz->trips; count++)
+		handle_thermal_trip(tz, count);
+}
+EXPORT_SYMBOL(thermal_zone_device_update);
+
+static void thermal_zone_device_check(struct work_struct *work)
+{
+	struct thermal_zone_device *tz = container_of(work, struct
+						      thermal_zone_device,
+						      poll_queue.work);
+	thermal_zone_device_update(tz);
+}
+
 /* sys I/F for thermal zone */
 
 #define to_thermal_zone(_dev) \
@@ -936,27 +1045,6 @@ thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 }
 #endif
 
-static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
-					    int delay)
-{
-	if (delay > 1000)
-		mod_delayed_work(system_freezable_wq, &tz->poll_queue,
-				 round_jiffies(msecs_to_jiffies(delay)));
-	else if (delay)
-		mod_delayed_work(system_freezable_wq, &tz->poll_queue,
-				 msecs_to_jiffies(delay));
-	else
-		cancel_delayed_work(&tz->poll_queue);
-}
-
-static void thermal_zone_device_check(struct work_struct *work)
-{
-	struct thermal_zone_device *tz = container_of(work, struct
-						      thermal_zone_device,
-						      poll_queue.work);
-	thermal_zone_device_update(tz);
-}
-
 /**
  * thermal_zone_bind_cooling_device - bind a cooling device to a thermal zone
  * @tz:		thermal zone device
@@ -1280,183 +1368,6 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 }
 EXPORT_SYMBOL(thermal_cdev_update);
 
-static void thermal_zone_do_update(struct thermal_zone_device *tz)
-{
-	struct thermal_instance *instance;
-
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-		thermal_cdev_update(instance->cdev);
-}
-
-/*
- * Cooling algorithm for both active and passive cooling
- *
- * 1. if the temperature is higher than a trip point,
- *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
- *       state for this trip point
- *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
- *       state for this trip point
- *
- * 2. if the temperature is lower than a trip point, use lower
- *    cooling state for this trip point
- *
- * Note that this behaves the same as the previous passive cooling
- * algorithm.
- */
-
-static void thermal_zone_trip_update(struct thermal_zone_device *tz,
-				     int trip, long temp)
-{
-	struct thermal_instance *instance;
-	struct thermal_cooling_device *cdev = NULL;
-	unsigned long cur_state, max_state;
-	long trip_temp;
-	enum thermal_trip_type trip_type;
-	enum thermal_trend trend;
-
-	if (trip == THERMAL_TRIPS_NONE) {
-		trip_temp = tz->forced_passive;
-		trip_type = THERMAL_TRIPS_NONE;
-	} else {
-		tz->ops->get_trip_temp(tz, trip, &trip_temp);
-		tz->ops->get_trip_type(tz, trip, &trip_type);
-	}
-
-	if (!tz->ops->get_trend || tz->ops->get_trend(tz, trip, &trend)) {
-		/*
-		 * compare the current temperature and previous temperature
-		 * to get the thermal trend, if no special requirement
-		 */
-		if (tz->temperature > tz->last_temperature)
-			trend = THERMAL_TREND_RAISING;
-		else if (tz->temperature < tz->last_temperature)
-			trend = THERMAL_TREND_DROPPING;
-		else
-			trend = THERMAL_TREND_STABLE;
-	}
-
-	if (temp >= trip_temp) {
-		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-			if (instance->trip != trip)
-				continue;
-
-			cdev = instance->cdev;
-
-			cdev->ops->get_cur_state(cdev, &cur_state);
-			cdev->ops->get_max_state(cdev, &max_state);
-
-			if (trend == THERMAL_TREND_RAISING) {
-				cur_state = cur_state < instance->upper ?
-					    (cur_state + 1) : instance->upper;
-			} else if (trend == THERMAL_TREND_DROPPING) {
-				cur_state = cur_state > instance->lower ?
-				    (cur_state - 1) : instance->lower;
-			}
-
-			/* activate a passive thermal instance */
-			if ((trip_type == THERMAL_TRIP_PASSIVE ||
-			     trip_type == THERMAL_TRIPS_NONE) &&
-			     instance->target == THERMAL_NO_TARGET)
-				tz->passive++;
-
-			instance->target = cur_state;
-			cdev->updated = false; /* cooling device needs update */
-		}
-	} else {	/* below trip */
-		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-			if (instance->trip != trip)
-				continue;
-
-			/* Do not use the inactive thermal instance */
-			if (instance->target == THERMAL_NO_TARGET)
-				continue;
-			cdev = instance->cdev;
-			cdev->ops->get_cur_state(cdev, &cur_state);
-
-			cur_state = cur_state > instance->lower ?
-				    (cur_state - 1) : THERMAL_NO_TARGET;
-
-			/* deactivate a passive thermal instance */
-			if ((trip_type == THERMAL_TRIP_PASSIVE ||
-			     trip_type == THERMAL_TRIPS_NONE) &&
-			     cur_state == THERMAL_NO_TARGET)
-				tz->passive--;
-			instance->target = cur_state;
-			cdev->updated = false; /* cooling device needs update */
-		}
-	}
-
-	return;
-}
-/**
- * thermal_zone_device_update - force an update of a thermal zone's state
- * @ttz:	the thermal zone to update
- */
-
-void thermal_zone_device_update(struct thermal_zone_device *tz)
-{
-	int count, ret = 0;
-	long temp, trip_temp;
-	enum thermal_trip_type trip_type;
-
-	mutex_lock(&tz->lock);
-
-	if (tz->ops->get_temp(tz, &temp)) {
-		/* get_temp failed - retry it later */
-		pr_warn("failed to read out thermal zone %d\n", tz->id);
-		goto leave;
-	}
-
-	tz->last_temperature = tz->temperature;
-	tz->temperature = temp;
-
-	for (count = 0; count < tz->trips; count++) {
-		tz->ops->get_trip_type(tz, count, &trip_type);
-		tz->ops->get_trip_temp(tz, count, &trip_temp);
-
-		switch (trip_type) {
-		case THERMAL_TRIP_CRITICAL:
-			if (temp >= trip_temp) {
-				if (tz->ops->notify)
-					ret = tz->ops->notify(tz, count,
-							      trip_type);
-				if (!ret) {
-					pr_emerg("Critical temperature reached (%ld C), shutting down\n",
-						 temp/1000);
-					orderly_poweroff(true);
-				}
-			}
-			break;
-		case THERMAL_TRIP_HOT:
-			if (temp >= trip_temp)
-				if (tz->ops->notify)
-					tz->ops->notify(tz, count, trip_type);
-			break;
-		case THERMAL_TRIP_ACTIVE:
-			thermal_zone_trip_update(tz, count, temp);
-			break;
-		case THERMAL_TRIP_PASSIVE:
-			if (temp >= trip_temp || tz->passive)
-				thermal_zone_trip_update(tz, count, temp);
-			break;
-		}
-	}
-
-	if (tz->forced_passive)
-		thermal_zone_trip_update(tz, THERMAL_TRIPS_NONE, temp);
-	thermal_zone_do_update(tz);
-
-leave:
-	if (tz->passive)
-		thermal_zone_device_set_polling(tz, tz->passive_delay);
-	else if (tz->polling_delay)
-		thermal_zone_device_set_polling(tz, tz->polling_delay);
-	else
-		thermal_zone_device_set_polling(tz, 0);
-	mutex_unlock(&tz->lock);
-}
-EXPORT_SYMBOL(thermal_zone_device_update);
-
 /**
  * create_trip_attrs - create attributes for trip points
  * @tz:		the thermal zone device
-- 
1.7.7.6

