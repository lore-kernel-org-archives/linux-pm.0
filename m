From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 6/12] thermal: introduce active cooling
	algorithm
Date: Mon, 11 Jun 2012 11:20:17 +0800
Message-ID: <1339384817.1492.160.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


Introduce thermal_zone_trip_update() to update the cooling state
of all the cooling devices that are binded to an active trip point.

This will be used for passive cooling as well, in the future patches.
as both active and passive cooling can share the same algorithm,
which is

1. if the temperature is higher than a trip point,
   a. if the trend is THERMAL_TREND_RAISING, use higher cooling
      state for this trip point
   b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
      state for this trip point

2. if the temperature is lower than a trip point, use lower
   cooling state for this trip point.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c        |    7 ++-
 drivers/thermal/thermal_sys.c |   91 ++++++++++++++++++++++++++++++------------
 2 files changed, 71 insertions(+), 27 deletions(-)

Index: rtd3/drivers/thermal/thermal_sys.c
===================================================================
--- rtd3.orig/drivers/thermal/thermal_sys.c
+++ rtd3/drivers/thermal/thermal_sys.c
@@ -1035,6 +1035,70 @@ void thermal_cooling_device_unregister(s
 }
 EXPORT_SYMBOL(thermal_cooling_device_unregister);
 
+/*
+ * Cooling algorithm for active trip points
+ *
+ * 1. if the temperature is higher than a trip point,
+ *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
+ *       state for this trip point
+ *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
+ *       state for this trip point
+ *
+ * 2. if the temperature is lower than a trip point, use lower
+ *    cooling state for this trip point
+ *
+ * Note that this behaves the same as the previous passive cooling
+ * algorithm.
+ */
+
+static void thermal_zone_trip_update(struct thermal_zone_device *tz,
+				     int trip, long temp)
+{
+	struct thermal_cooling_device_instance *instance;
+	struct thermal_cooling_device *cdev = NULL;
+	unsigned long cur_state, max_state;
+	long trip_temp;
+	enum thermal_trend trend;
+
+	tz->ops->get_trip_temp(tz, trip, &trip_temp);
+
+	if (temp >= trip_temp) {
+		thermal_get_trend(tz, trip, &trend);
+
+		list_for_each_entry(instance, &tz->cooling_devices, node) {
+			if (instance->trip != trip)
+				continue;
+
+			cdev = instance->cdev;
+
+			cdev->ops->get_cur_state(cdev, &cur_state);
+			cdev->ops->get_max_state(cdev, &max_state);
+
+			if (trend == THERMAL_TREND_RAISING) {
+				cur_state = cur_state < instance->upper ?
+					    (cur_state + 1) : instance->upper;
+			} else if (trend == THERMAL_TREND_DROPPING) {
+				cur_state = cur_state > instance->lower ?
+				    (cur_state - 1) : instance->lower;
+			}
+			cdev->ops->set_cur_state(cdev, cur_state);
+		}
+	} else {	/* below trip */
+		list_for_each_entry(instance, &tz->cooling_devices, node) {
+			if (instance->trip != trip)
+				continue;
+
+			cdev = instance->cdev;
+			cdev->ops->get_cur_state(cdev, &cur_state);
+
+			cur_state = cur_state > instance->lower ?
+				    (cur_state - 1) : instance->lower;
+			cdev->ops->set_cur_state(cdev, cur_state);
+		}
+	}
+
+	return;
+}
 /**
  * thermal_zone_device_update - force an update of a thermal zone's state
  * @ttz:	the thermal zone to update
@@ -1045,9 +1109,6 @@ void thermal_zone_device_update(struct t
 	int count, ret = 0;
 	long temp, trip_temp;
 	enum thermal_trip_type trip_type;
-	struct thermal_cooling_device_instance *instance;
-	struct thermal_cooling_device *cdev;
-	unsigned long cur_state, max_state;
 
 	mutex_lock(&tz->lock);
 
@@ -1083,29 +1144,7 @@ void thermal_zone_device_update(struct t
 					tz->ops->notify(tz, count, trip_type);
 			break;
 		case THERMAL_TRIP_ACTIVE:
-			list_for_each_entry(instance, &tz->cooling_devices,
-					    node) {
-				if (instance->trip != count)
-					continue;
-
-				cdev = instance->cdev;
-
-				cdev->ops->get_cur_state(cdev, &cur_state);
-				cdev->ops->get_max_state(cdev, &max_state);
-
-				if (temp >= trip_temp)
-					cur_state =
-						cur_state < instance->upper ?
-						(cur_state + 1) :
-						instance->upper;
-				else
-					cur_state =
-						cur_state > instance->lower ?
-						(cur_state - 1) :
-						instance->lower;
-
-				cdev->ops->set_cur_state(cdev, cur_state);
-			}
+			thermal_zone_trip_update(tz, count, temp);
 			break;
 		case THERMAL_TRIP_PASSIVE:
 			if (temp >= trip_temp || tz->passive)
Index: rtd3/drivers/acpi/thermal.c
===================================================================
--- rtd3.orig/drivers/acpi/thermal.c
+++ rtd3/drivers/acpi/thermal.c
@@ -717,7 +717,12 @@ static int thermal_get_trend(struct ther
 	if (thermal_get_trip_type(thermal, trip, &type))
 		return -EINVAL;
 
-	/* Only PASSIVE trip points need TREND */
+	if (type == THERMAL_TRIP_ACTIVE) {
+		/* aggressive active cooling */
+		*trend = THERMAL_TREND_RAISING;
+		return 0;
+	}
+
 	if (type != THERMAL_TRIP_PASSIVE)
 		return -EINVAL;
 
