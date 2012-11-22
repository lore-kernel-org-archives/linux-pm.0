From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH  V2 2/3] Introduce THERMAL_TREND_RAISE/DROP_FULL support for
 step_wise governor
Date: Thu, 22 Nov 2012 15:52:32 +0800
Message-ID: <1353570752.2297.5.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30911 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756698Ab2KVTSb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 22 Nov 2012 14:18:31 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, durga <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

>From ac2224a47b88ca64f4ae25da78fb032b31856624 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Mon, 19 Nov 2012 16:10:20 +0800
Subject: [PATCH 2/3] Introduce THERMAL_TREND_RAISE/DROP_FULL support for
 step_wise governor

step_wise governor should set the device cooling state to
upper/lower limit directly when THERMAL_TREND_RAISE/DROP_FULL.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/step_wise.c |   64 +++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 1242cff..c3a0e87 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -35,21 +35,54 @@
  *       state for this trip point
  *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
  *       state for this trip point
+ *    c. if the trend is THERMAL_TREND_RAISE_FULL, use upper limit
+ *       for this trip point
+ *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit
+ *       for this trip point
+ * If the temperature is lower than a trip point,
+ *    a. if the trend is THERMAL_TREND_RAISING, do nothing
+ *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
+ *       state for this trip point, if the cooling state already
+ *       equals lower limit, deactivate the thermal instance
+ *    c. if the trend is THERMAL_TREND_RAISE_FULL, do nothing
+ *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit,
+ *       if the cooling state already equals lower limit,
+ *       deactive the thermal instance
  */
 static unsigned long get_target_state(struct thermal_instance *instance,
-					enum thermal_trend trend)
+				enum thermal_trend trend, bool throttle)
 {
 	struct thermal_cooling_device *cdev = instance->cdev;
 	unsigned long cur_state;
 
 	cdev->ops->get_cur_state(cdev, &cur_state);
 
-	if (trend == THERMAL_TREND_RAISING) {
-		cur_state = cur_state < instance->upper ?
-			    (cur_state + 1) : instance->upper;
-	} else if (trend == THERMAL_TREND_DROPPING) {
-		cur_state = cur_state > instance->lower ?
-			    (cur_state - 1) : instance->lower;
+	switch (trend) {
+	case THERMAL_TREND_RAISING:
+		if (throttle)
+			cur_state = cur_state < instance->upper ?
+				    (cur_state + 1) : instance->upper;
+		break;
+	case THERMAL_TREND_RAISE_FULL:
+		if (throttle)
+			cur_state = instance->upper;
+		break;
+	case THERMAL_TREND_DROPPING:
+		if (cur_state == instance->lower) {
+			if (!throttle)
+				cur_state = -1;
+		} else
+			cur_state -= 1;
+		break;
+	case THERMAL_TREND_DROP_FULL:
+		if (cur_state == instance->lower) {
+			if (!throttle)
+				cur_state = -1;
+		} else
+			cur_state = instance->lower;
+		break;
+	default:
+		break;
 	}
 
 	return cur_state;
@@ -76,7 +109,7 @@ static void update_instance_for_throttle(struct thermal_zone_device *tz,
 		if (instance->trip != trip)
 			continue;
 
-		instance->target = get_target_state(instance, trend);
+		instance->target = get_target_state(instance, trend, true);
 
 		/* Activate a passive thermal instance */
 		if (instance->target == THERMAL_NO_TARGET)
@@ -87,28 +120,23 @@ static void update_instance_for_throttle(struct thermal_zone_device *tz,
 }
 
 static void update_instance_for_dethrottle(struct thermal_zone_device *tz,
-				int trip, enum thermal_trip_type trip_type)
+				int trip, enum thermal_trip_type trip_type,
+				enum thermal_trend trend)
 {
 	struct thermal_instance *instance;
-	struct thermal_cooling_device *cdev;
-	unsigned long cur_state;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip ||
 			instance->target == THERMAL_NO_TARGET)
 			continue;
 
-		cdev = instance->cdev;
-		cdev->ops->get_cur_state(cdev, &cur_state);
-
-		instance->target = cur_state > instance->lower ?
-			    (cur_state - 1) : THERMAL_NO_TARGET;
+		instance->target = get_target_state(instance, trend, false);
 
 		/* Deactivate a passive thermal instance */
 		if (instance->target == THERMAL_NO_TARGET)
 			update_passive_instance(tz, trip_type, -1);
 
-		cdev->updated = false; /* cdev needs update */
+		instance->cdev->updated = false; /* cdev needs update */
 	}
 }
 
@@ -133,7 +161,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 	if (tz->temperature >= trip_temp)
 		update_instance_for_throttle(tz, trip, trip_type, trend);
 	else
-		update_instance_for_dethrottle(tz, trip, trip_type);
+		update_instance_for_dethrottle(tz, trip, trip_type, trend);
 
 	mutex_unlock(&tz->lock);
 }
-- 
1.7.9.5



