From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v4 3/5] thermal: power_allocator: relax the requirement of two passive trip points
Date: Wed, 26 Aug 2015 14:26:42 +0100
Message-ID: <1440595604-27197-4-git-send-email-javi.merino@arm.com>
References: <1439833008-26440-1-git-send-email-javi.merino@arm.com>
 <1440595604-27197-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45135 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbbHZN1Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 26 Aug 2015 09:27:24 -0400
In-Reply-To: <1440595604-27197-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, cywang@chromium.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, djkurtz@chromium.org, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>

The power allocator governor currently requires that the thermal zone
has at least two passive trip points.  If there aren't, the governor
refuses to bind to the thermal zone.

This commit relaxes that requirement.  Now the governor will bind to all
thermal zones regardless of how many trip points they have.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 Documentation/thermal/power_allocator.txt |  2 +-
 drivers/thermal/power_allocator.c         | 96 +++++++++++++++++--------------
 2 files changed, 53 insertions(+), 45 deletions(-)

diff --git a/Documentation/thermal/power_allocator.txt b/Documentation/thermal/power_allocator.txt
index c3797b529991..a1ce2235f121 100644
--- a/Documentation/thermal/power_allocator.txt
+++ b/Documentation/thermal/power_allocator.txt
@@ -4,7 +4,7 @@ Power allocator governor tunables
 Trip points
 -----------
 
-The governor requires the following two passive trip points:
+The governor works optimally with the following two passive trip points:
 
 1.  "switch on" trip point: temperature above which the governor
     control loop starts operating.  This is the first passive trip
diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index eae8a5ae794a..2dfb8ade4d1b 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -24,6 +24,8 @@
 
 #include "thermal_core.h"
 
+#define INVALID_TRIP -1
+
 #define FRAC_BITS 10
 #define int_to_frac(x) ((x) << FRAC_BITS)
 #define frac_to_int(x) ((x) >> FRAC_BITS)
@@ -61,6 +63,8 @@ static inline s64 div_frac(s64 x, s64 y)
  *		Used to calculate the derivative term.
  * @trip_switch_on:	first passive trip point of the thermal zone.  The
  *			governor switches on when this trip point is crossed.
+ *			If the thermal zone only has one passive trip point,
+ *			@trip_switch_on should be INVALID_TRIP.
  * @trip_max_desired_temperature:	last passive trip point of the thermal
  *					zone.  The temperature we are
  *					controlling for.
@@ -435,43 +439,66 @@ unlock:
 	return ret;
 }
 
-static int get_governor_trips(struct thermal_zone_device *tz,
-			      struct power_allocator_params *params)
+/**
+ * get_governor_trips() - get the number of the two trip points that are key for this governor
+ * @tz:	thermal zone to operate on
+ * @params:	pointer to private data for this governor
+ *
+ * The power allocator governor works optimally with two trips points:
+ * a "switch on" trip point and a "maximum desired temperature".  These
+ * are defined as the first and last passive trip points.
+ *
+ * If there is only one trip point, then that's considered to be the
+ * "maximum desired temperature" trip point and the governor is always
+ * on.  If there are no passive or active trip points, then the
+ * governor won't do anything.  In fact, its throttle function
+ * won't be called at all.
+ */
+static void get_governor_trips(struct thermal_zone_device *tz,
+			       struct power_allocator_params *params)
 {
-	int i, ret, last_passive;
+	int i, last_active, last_passive;
 	bool found_first_passive;
 
 	found_first_passive = false;
-	last_passive = -1;
-	ret = -EINVAL;
+	last_active = INVALID_TRIP;
+	last_passive = INVALID_TRIP;
 
 	for (i = 0; i < tz->trips; i++) {
 		enum thermal_trip_type type;
+		int ret;
 
 		ret = tz->ops->get_trip_type(tz, i, &type);
-		if (ret)
-			return ret;
+		if (ret) {
+			dev_warn(&tz->device,
+				 "Failed to get trip point %d type: %d\n", i,
+				 ret);
+			continue;
+		}
 
-		if (!found_first_passive) {
-			if (type == THERMAL_TRIP_PASSIVE) {
+		if (type == THERMAL_TRIP_PASSIVE) {
+			if (!found_first_passive) {
 				params->trip_switch_on = i;
 				found_first_passive = true;
+			} else  {
+				last_passive = i;
 			}
-		} else if (type == THERMAL_TRIP_PASSIVE) {
-			last_passive = i;
+		} else if (type == THERMAL_TRIP_ACTIVE) {
+			last_active = i;
 		} else {
 			break;
 		}
 	}
 
-	if (last_passive != -1) {
+	if (last_passive != INVALID_TRIP) {
 		params->trip_max_desired_temperature = last_passive;
-		ret = 0;
+	} else if (found_first_passive) {
+		params->trip_max_desired_temperature = params->trip_switch_on;
+		params->trip_switch_on = INVALID_TRIP;
 	} else {
-		ret = -EINVAL;
+		params->trip_switch_on = INVALID_TRIP;
+		params->trip_max_desired_temperature = last_active;
 	}
-
-	return ret;
 }
 
 static void reset_pid_controller(struct power_allocator_params *params)
@@ -500,11 +527,10 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
  * power_allocator_bind() - bind the power_allocator governor to a thermal zone
  * @tz:	thermal zone to bind it to
  *
- * Check that the thermal zone is valid for this governor, that is, it
- * has two thermal trips.  If so, initialize the PID controller
- * parameters and bind it to the thermal zone.
+ * Initialize the PID controller parameters and bind it to the thermal
+ * zone.
  *
- * Return: 0 on success, -EINVAL if the trips were invalid or -ENOMEM
+ * Return: 0 on success, -EINVAL if the thermal zone doesn't have tzp or -ENOMEM
  * if we ran out of memory.
  */
 static int power_allocator_bind(struct thermal_zone_device *tz)
@@ -523,31 +549,19 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	if (!tz->tzp->sustainable_power)
 		dev_warn(&tz->device, "power_allocator: sustainable_power will be estimated\n");
 
-	ret = get_governor_trips(tz, params);
-	if (ret) {
-		dev_err(&tz->device,
-			"thermal zone %s has wrong trip setup for power allocator\n",
-			tz->type);
-		goto free;
-	}
+	get_governor_trips(tz, params);
 
 	ret = tz->ops->get_trip_temp(tz, params->trip_max_desired_temperature,
 				     &control_temp);
-	if (ret)
-		goto free;
-
-	estimate_controller_constants(tz, tz->tzp->sustainable_power,
-				      params->trip_switch_on, control_temp,
-				      false);
+	if (!ret)
+		estimate_controller_constants(tz, tz->tzp->sustainable_power,
+					      params->trip_switch_on,
+					      control_temp, false);
 	reset_pid_controller(params);
 
 	tz->governor_data = params;
 
 	return 0;
-
-free:
-	kfree(params);
-	return ret;
 }
 
 static void power_allocator_unbind(struct thermal_zone_device *tz)
@@ -578,13 +592,7 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 
 	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
 				     &switch_on_temp);
-	if (ret) {
-		dev_warn(&tz->device,
-			 "Failed to get switch on temperature: %d\n", ret);
-		return ret;
-	}
-
-	if (current_temp < switch_on_temp) {
+	if (!ret && (current_temp < switch_on_temp)) {
 		tz->passive = 0;
 		reset_pid_controller(params);
 		allow_maximum_power(tz);
-- 
1.9.1

