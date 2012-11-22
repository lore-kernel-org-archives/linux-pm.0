From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH V2 3/3] step_wise: Unify the code for both throttle and
 dethrottle
Date: Thu, 22 Nov 2012 15:53:27 +0800
Message-ID: <1353570807.2297.6.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51454 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965172Ab2KVTTW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 22 Nov 2012 14:19:22 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, durga <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

>From 9b298d2d7816074070567b9b20ba0c1eb5fb862b Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Thu, 22 Nov 2012 15:45:02 +0800
Subject: [PATCH 3/3] step_wise: Unify the code for both throttle and
 dethrottle

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/step_wise.c |   70 ++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 45 deletions(-)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index c3a0e87..dcc965d 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -99,52 +99,14 @@ static void update_passive_instance(struct thermal_zone_device *tz,
 		tz->passive += value;
 }
 
-static void update_instance_for_throttle(struct thermal_zone_device *tz,
-				int trip, enum thermal_trip_type trip_type,
-				enum thermal_trend trend)
-{
-	struct thermal_instance *instance;
-
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip)
-			continue;
-
-		instance->target = get_target_state(instance, trend, true);
-
-		/* Activate a passive thermal instance */
-		if (instance->target == THERMAL_NO_TARGET)
-			update_passive_instance(tz, trip_type, 1);
-
-		instance->cdev->updated = false; /* cdev needs update */
-	}
-}
-
-static void update_instance_for_dethrottle(struct thermal_zone_device *tz,
-				int trip, enum thermal_trip_type trip_type,
-				enum thermal_trend trend)
-{
-	struct thermal_instance *instance;
-
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip ||
-			instance->target == THERMAL_NO_TARGET)
-			continue;
-
-		instance->target = get_target_state(instance, trend, false);
-
-		/* Deactivate a passive thermal instance */
-		if (instance->target == THERMAL_NO_TARGET)
-			update_passive_instance(tz, trip_type, -1);
-
-		instance->cdev->updated = false; /* cdev needs update */
-	}
-}
-
 static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 {
 	long trip_temp;
 	enum thermal_trip_type trip_type;
 	enum thermal_trend trend;
+	struct thermal_instance *instance;
+	bool throttle = false;
+	int old_target;
 
 	if (trip == THERMAL_TRIPS_NONE) {
 		trip_temp = tz->forced_passive;
@@ -156,12 +118,30 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 
 	trend = get_tz_trend(tz, trip);
 
+	if (tz->temperature >= trip_temp)
+		throttle = true;
+
 	mutex_lock(&tz->lock);
 
-	if (tz->temperature >= trip_temp)
-		update_instance_for_throttle(tz, trip, trip_type, trend);
-	else
-		update_instance_for_dethrottle(tz, trip, trip_type, trend);
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		if (instance->trip != trip)
+			continue;
+
+		old_target = instance->target;
+		instance->target = get_target_state(instance, trend, throttle);
+
+		/* Activate a passive thermal instance */
+		if (old_target == THERMAL_NO_TARGET &&
+			instance->target != THERMAL_NO_TARGET)
+			update_passive_instance(tz, trip_type, 1);
+		/* Deactivate a passive thermal instance */
+		else if (old_target != THERMAL_NO_TARGET &&
+			instance->target == THERMAL_NO_TARGET)
+			update_passive_instance(tz, trip_type, -1);
+
+
+		instance->cdev->updated = false; /* cdev needs update */
+	}
 
 	mutex_unlock(&tz->lock);
 }
-- 
1.7.9.5



