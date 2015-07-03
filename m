From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH RESEND] thermal: power_allocator: trace the real requested power
Date: Fri,  3 Jul 2015 10:24:33 +0100
Message-ID: <1435915473-7407-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52385 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753846AbbGCJZN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 Jul 2015 05:25:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

The power allocator governor uses ftrace to output a bunch of internal
data for debugging and tuning.  Currently, the requested power it
outputs is the "weighted" requested power, that is, what each cooling
device has requested multiplied by the cooling device weight.  It is
more useful to trace the real request, without any weight being
applied.

This commit only affects the data traced, there is no functional change.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/power_allocator.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 4672250b329f..63a448f9d93b 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -229,7 +229,8 @@ static int allocate_power(struct thermal_zone_device *tz,
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
 	u32 *req_power, *max_power, *granted_power, *extra_actor_power;
-	u32 total_req_power, max_allocatable_power;
+	u32 *weighted_req_power;
+	u32 total_req_power, max_allocatable_power, total_weighted_req_power;
 	u32 total_granted_power, power_range;
 	int i, num_actors, total_weight, ret = 0;
 	int trip_max_desired_temperature = params->trip_max_desired_temperature;
@@ -247,16 +248,17 @@ static int allocate_power(struct thermal_zone_device *tz,
 	}
 
 	/*
-	 * We need to allocate three arrays of the same size:
-	 * req_power, max_power and granted_power.  They are going to
-	 * be needed until this function returns.  Allocate them all
-	 * in one go to simplify the allocation and deallocation
-	 * logic.
+	 * We need to allocate five arrays of the same size:
+	 * req_power, max_power, granted_power, extra_actor_power and
+	 * weighted_req_power.  They are going to be needed until this
+	 * function returns.  Allocate them all in one go to simplify
+	 * the allocation and deallocation logic.
 	 */
 	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*max_power));
 	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*granted_power));
 	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*extra_actor_power));
-	req_power = devm_kcalloc(&tz->device, num_actors * 4,
+	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*weighted_req_power));
+	req_power = devm_kcalloc(&tz->device, num_actors * 5,
 				 sizeof(*req_power), GFP_KERNEL);
 	if (!req_power) {
 		ret = -ENOMEM;
@@ -266,8 +268,10 @@ static int allocate_power(struct thermal_zone_device *tz,
 	max_power = &req_power[num_actors];
 	granted_power = &req_power[2 * num_actors];
 	extra_actor_power = &req_power[3 * num_actors];
+	weighted_req_power = &req_power[4 * num_actors];
 
 	i = 0;
+	total_weighted_req_power = 0;
 	total_req_power = 0;
 	max_allocatable_power = 0;
 
@@ -289,13 +293,14 @@ static int allocate_power(struct thermal_zone_device *tz,
 		else
 			weight = instance->weight;
 
-		req_power[i] = frac_to_int(weight * req_power[i]);
+		weighted_req_power[i] = frac_to_int(weight * req_power[i]);
 
 		if (power_actor_get_max_power(cdev, tz, &max_power[i]))
 			continue;
 
 		total_req_power += req_power[i];
 		max_allocatable_power += max_power[i];
+		total_weighted_req_power += weighted_req_power[i];
 
 		i++;
 	}
@@ -303,8 +308,9 @@ static int allocate_power(struct thermal_zone_device *tz,
 	power_range = pid_controller(tz, current_temp, control_temp,
 				     max_allocatable_power);
 
-	divvy_up_power(req_power, max_power, num_actors, total_req_power,
-		       power_range, granted_power, extra_actor_power);
+	divvy_up_power(weighted_req_power, max_power, num_actors,
+		       total_weighted_req_power, power_range, granted_power,
+		       extra_actor_power);
 
 	total_granted_power = 0;
 	i = 0;
-- 
1.9.1

