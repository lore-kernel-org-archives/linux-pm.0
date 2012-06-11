From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 12/12] thermal: Unify the code for both active and
 passive cooling
Date: Mon, 11 Jun 2012 11:20:43 +0800
Message-ID: <1339384843.1492.166.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, eduardo <eduardo.valentin@ti.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Len, Brown" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "R, Durgadoss" <durgadoss.r@intel.com>
List-Id: linux-pm@vger.kernel.org


Unify the code for both active and passive cooling.

Remove thermal_zone_device_passive(). And use
thermal_zone_trip_update() and thermal_zone_do_update()
for both active and passive cooling.

Note that with this patch applied, we are able to support
multiple passive trip points for one thermal zone.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |   97 +++++++++---------------------------------
 1 file changed, 23 insertions(+), 74 deletions(-)

Index: rtd3/drivers/thermal/thermal_sys.c
===================================================================
--- rtd3.orig/drivers/thermal/thermal_sys.c
+++ rtd3/drivers/thermal/thermal_sys.c
@@ -684,73 +684,6 @@ static void thermal_zone_device_set_poll
 				      msecs_to_jiffies(delay));
 }
 
-static void thermal_zone_device_passive(struct thermal_zone_device *tz,
-					int temp, int trip_temp, int trip)
-{
-	int trend = 0;
-	struct thermal_instance *instance;
-	struct thermal_cooling_device *cdev;
-	long state, max_state;
-
-	/*
-	 * Above Trip?
-	 * -----------
-	 * Calculate the thermal trend (using the passive cooling equation)
-	 * and modify the performance limit for all passive cooling devices
-	 * accordingly.  Note that we assume symmetry.
-	 */
-	if (temp >= trip_temp) {
-		tz->passive = true;
-
-		thermal_get_trend(tz, trip, (enum thermal_trend *)&trend);
-
-		/* Heating up? */
-		if (trend > 0) {
-			list_for_each_entry(instance, &tz->instances,
-					    tz_node) {
-				if (instance->trip != trip)
-					continue;
-				cdev = instance->cdev;
-				cdev->ops->get_cur_state(cdev, &state);
-				cdev->ops->get_max_state(cdev, &max_state);
-				if (state++ < max_state)
-					cdev->ops->set_cur_state(cdev, state);
-			}
-		} else if (trend < 0) { /* Cooling off? */
-			list_for_each_entry(instance, &tz->instances,
-					    tz_node) {
-				if (instance->trip != trip)
-					continue;
-				cdev = instance->cdev;
-				cdev->ops->get_cur_state(cdev, &state);
-				cdev->ops->get_max_state(cdev, &max_state);
-				if (state > 0)
-					cdev->ops->set_cur_state(cdev, --state);
-			}
-		}
-		return;
-	}
-
-	/*
-	 * Below Trip?
-	 * -----------
-	 * Implement passive cooling hysteresis to slowly increase performance
-	 * and avoid thrashing around the passive trip point.  Note that we
-	 * assume symmetry.
-	 */
-	list_for_each_entry(instance, &tz->instances, tz_node) {
-		if (instance->trip != trip)
-			continue;
-		cdev = instance->cdev;
-		cdev->ops->get_cur_state(cdev, &state);
-		cdev->ops->get_max_state(cdev, &max_state);
-		if (state > 0)
-			cdev->ops->set_cur_state(cdev, --state);
-		if (state == 0)
-			tz->passive = false;
-	}
-}
-
 static void thermal_zone_device_check(struct work_struct *work)
 {
 	struct thermal_zone_device *tz = container_of(work, struct
@@ -1070,7 +1003,7 @@ static void thermal_zone_do_update(struc
 }
 
 /*
- * Cooling algorithm for active trip points
+ * Cooling algorithm for both active and passive cooling
  *
  * 1. if the temperature is higher than a trip point,
  *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
@@ -1092,9 +1025,16 @@ static void thermal_zone_trip_update(str
 	struct thermal_cooling_device *cdev = NULL;
 	unsigned long cur_state, max_state;
 	long trip_temp;
+	enum thermal_trip_type trip_type;
 	enum thermal_trend trend;
 
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
+	if (trip == THERMAL_TRIPS_NONE) {
+		trip_temp = tz->forced_passive;
+		trip_type = THERMAL_TRIPS_NONE;
+	} else {
+		tz->ops->get_trip_temp(tz, trip, &trip_temp);
+		tz->ops->get_trip_type(tz, trip, &trip_type);
+	}
 
 	if (temp >= trip_temp) {
 		thermal_get_trend(tz, trip, &trend);
@@ -1115,6 +1055,12 @@ static void thermal_zone_trip_update(str
 				cur_state = cur_state > instance->lower ?
 				    (cur_state - 1) : instance->lower;
 			}
+
+			/* activate a passive thermal instance */
+			if (trip_type == THERMAL_TRIP_PASSIVE &&
+			    instance->target == -1)
+				tz->passive++;
+
 			instance->target = cur_state;
 			cdev->updated = 0; /* cooling device needs update */
 		}
@@ -1131,6 +1077,11 @@ static void thermal_zone_trip_update(str
 
 			cur_state = cur_state > instance->lower ?
 				    (cur_state - 1) : -1;
+
+			/* deactivate a passive thermal instance */
+			if (trip_type == THERMAL_TRIP_PASSIVE &&
+			    cur_state == -1)
+				tz->passive--;
 			instance->target = cur_state;
 			cdev->updated = 0; /* cooling device needs update */
 		}
@@ -1187,16 +1138,14 @@ void thermal_zone_device_update(struct t
 			break;
 		case THERMAL_TRIP_PASSIVE:
 			if (temp >= trip_temp || tz->passive)
-				thermal_zone_device_passive(tz, temp,
-							    trip_temp, count);
+				thermal_zone_trip_update(tz, count, temp);
 			break;
 		}
 	}
 
-	thermal_zone_do_update(tz);
 	if (tz->forced_passive)
-		thermal_zone_device_passive(tz, temp, tz->forced_passive,
-					    THERMAL_TRIPS_NONE);
+		thermal_zone_trip_update(tz, THERMAL_TRIPS_NONE, temp);
+	thermal_zone_do_update(tz);
 
 leave:
 	if (tz->passive)


