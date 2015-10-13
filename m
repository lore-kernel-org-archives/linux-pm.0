From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: [PATCH] thermal: power_allocator: Use temperature reading from tz
Date: Tue, 13 Oct 2015 12:30:01 +0100
Message-ID: <1444735801-18267-1-git-send-email-kapileshwar.singh@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52051 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316AbbJMLa0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Oct 2015 07:30:26 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Kapileshwar Singh <kapileshwar.singh@arm.com>, Javi Merino <javi.merino@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Andrea Arcangeli <aarcange@redhat.com>

All thermal governors use the temperature value stored in
struct thermal_zone_device.

   thermal_zone_device->temperature

power_allocator governor should not deviate from this and use
the same.

Cc: Javi Merino <javi.merino@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Reported-by: Sugumar Natarajan <sugumar.natarajan@arm.com>
Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
---
 drivers/thermal/power_allocator.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index e570ff084add..d97f152c7e43 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -174,7 +174,6 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 /**
  * pid_controller() - PID controller
  * @tz:	thermal zone we are operating in
- * @current_temp:	the current temperature in millicelsius
  * @control_temp:	the target temperature in millicelsius
  * @max_allocatable_power:	maximum allocatable power for this thermal zone
  *
@@ -191,7 +190,6 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
  * Return: The power budget for the next period.
  */
 static u32 pid_controller(struct thermal_zone_device *tz,
-			  int current_temp,
 			  int control_temp,
 			  u32 max_allocatable_power)
 {
@@ -211,7 +209,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 				       true);
 	}
 
-	err = control_temp - current_temp;
+	err = control_temp - tz->temperature;
 	err = int_to_frac(err);
 
 	/* Calculate the proportional term */
@@ -332,7 +330,6 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 }
 
 static int allocate_power(struct thermal_zone_device *tz,
-			  int current_temp,
 			  int control_temp)
 {
 	struct thermal_instance *instance;
@@ -418,8 +415,7 @@ static int allocate_power(struct thermal_zone_device *tz,
 		i++;
 	}
 
-	power_range = pid_controller(tz, current_temp, control_temp,
-				     max_allocatable_power);
+	power_range = pid_controller(tz, control_temp, max_allocatable_power);
 
 	divvy_up_power(weighted_req_power, max_power, num_actors,
 		       total_weighted_req_power, power_range, granted_power,
@@ -444,8 +440,8 @@ static int allocate_power(struct thermal_zone_device *tz,
 	trace_thermal_power_allocator(tz, req_power, total_req_power,
 				      granted_power, total_granted_power,
 				      num_actors, power_range,
-				      max_allocatable_power, current_temp,
-				      control_temp - current_temp);
+				      max_allocatable_power, tz->temperature,
+				      control_temp - tz->temperature);
 
 	kfree(req_power);
 unlock:
@@ -612,7 +608,7 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 {
 	int ret;
-	int switch_on_temp, control_temp, current_temp;
+	int switch_on_temp, control_temp;
 	struct power_allocator_params *params = tz->governor_data;
 
 	/*
@@ -622,15 +618,9 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 	if (trip != params->trip_max_desired_temperature)
 		return 0;
 
-	ret = thermal_zone_get_temp(tz, &current_temp);
-	if (ret) {
-		dev_warn(&tz->device, "Failed to get temperature: %d\n", ret);
-		return ret;
-	}
-
 	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
 				     &switch_on_temp);
-	if (!ret && (current_temp < switch_on_temp)) {
+	if (!ret && (tz->temperature < switch_on_temp)) {
 		tz->passive = 0;
 		reset_pid_controller(params);
 		allow_maximum_power(tz);
@@ -648,7 +638,7 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 		return ret;
 	}
 
-	return allocate_power(tz, current_temp, control_temp);
+	return allocate_power(tz, control_temp);
 }
 
 static struct thermal_governor thermal_gov_power_allocator = {
-- 
1.9.1

