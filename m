From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 3/3] Thermal:core: Handle trips focused on current trip point
 only.
Date: Sat, 18 May 2013 18:51:03 +0900
Message-ID: <1368870663-1225-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:39407 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980Ab3ERJvJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 May 2013 05:51:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Dinel Kachhap <amit.kachhap@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>

When thermal zone device is updated, it doesn't need to check
every trip points and its handling mathod even current temperature
doesn't exceed the trip's temperature. To modify those dissipatve
mechanism, this patch introduces the way to get current thermal
trip point to call only correspond trip point handling.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/thermal/thermal_core.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index ce4384a..1cc4825 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -333,14 +333,6 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz,
 static void handle_critical_trips(struct thermal_zone_device *tz,
 				int trip, enum thermal_trip_type trip_type)
 {
-	long trip_temp;
-
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
-
-	/* If we have not crossed the trip_temp, we do not care. */
-	if (tz->temperature < trip_temp)
-		return;
-
 	if (tz->ops->notify)
 		tz->ops->notify(tz, trip, trip_type);
 
@@ -437,14 +429,28 @@ static void update_temperature(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
+static int thermal_zone_get_current_trip(struct thermal_zone_device *tz)
+{
+	int trip;
+	long trip_temp;
+
+	for (trip = tz->trips - 1; trip > 0; trip--) {
+		tz->ops->get_trip_temp(tz, trip, &trip_temp);
+		if (tz->temperature > trip_temp)
+			continue;
+	}
+	return trip;
+}
+
 void thermal_zone_device_update(struct thermal_zone_device *tz)
 {
-	int count;
+	int trip;
 
 	update_temperature(tz);
 
-	for (count = 0; count < tz->trips; count++)
-		handle_thermal_trip(tz, count);
+	trip = thermal_zone_get_current_trip(tz);
+
+	handle_thermal_trip(tz, trip);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
-- 
1.7.9.5

