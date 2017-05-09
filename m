From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v2 1/2] thermal: IPA: add new divvy-up algorithm
Date: Tue,  9 May 2017 15:13:55 +0100
Message-ID: <1494339236-22666-2-git-send-email-lukasz.luba@arm.com>
References: <1494339236-22666-1-git-send-email-lukasz.luba@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752576AbdEIOOQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 May 2017 10:14:16 -0400
In-Reply-To: <1494339236-22666-1-git-send-email-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: lukasz.luba@arm.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com

The IPA algorithm grants actors with some extra power when the following
conditions are meet:
- there is at least one actor which got more power than it's max_power
  value,
- there is at least one actor which is capable to receive some more power
  (it's requested power is below max_power value). The IPA grants this
extra power to all capable actors.

Before this commit the algorithm did not take into account the actor's type
(cpu or devfreq), so the extra power was shared fairly to all capable
actors. Therefore, the extra power can be granted to some actor which is
not related to this higher computation request.

Example related to the previous algorithm: Let's focus on ARM big.LITTLE
platform which has two cooling devices (one per cluster). If the big CPU
cluster gets more power that it can consume, the power above the limit is
cut from the big and spread between other actors.  In this case even the
GPU gets some extra power, but it does not need it and cannot help to
offload the big CPU.  The CPU overall performance suffers.

This new algorithm takes into account the actor's type and constructs
families/groups - which are containers for actors of the same type: CPUfreq
or devfreq. Currently it supports only these two families/groups.  The
families/groups are created based on cooling device name (string matching).

The algorithm calculates extra power in two phases: Phase 1: Calculates the
power budget for each group (CPU or devfreq devices).  Phase 2: The extra
power in each family/group is shared to the same actor's family/group
members.  Phase 3: If there is still some extra power (left because the
family/group actors were not able to consume it), it is shared fairly to
all of the capable actors in the system (so in this round, the same idea to
the former algorithm).

Example for current proposed algorithm: If the 'cpu type' actor gives some
extra power to the 'cpu type' family/group pool, it is shared fairly among
capable actors in this family/group ('cpu type'). If some extra power left,
it will be granted to 'devfreq type' actors which are capable to consume
it.

Suggested-by: Alex Wang <alex.wang@spreadtrum.com>
Suggested-by: Xin Wang <Xin.Wang@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/power_allocator.c | 179 +++++++++++++++++++++++++++++++++-----
 1 file changed, 155 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index b4d3116..1929e9c 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -30,6 +30,18 @@
 #define int_to_frac(x) ((x) << FRAC_BITS)
 #define frac_to_int(x) ((x) >> FRAC_BITS)
 
+enum thermal_actor_type {
+	OTHER_CDEV = 0,
+	CPUFREQ_CDEV,
+	DEVFREQ_CDEV,
+	NUM_CDEV_TYPES
+};
+
+struct thermal_actor {
+	struct thermal_cooling_device *cdev;
+	enum thermal_actor_type type;
+};
+
 /**
  * mul_frac() - multiply two fixed-point numbers
  * @x:	first multiplicand
@@ -258,6 +270,108 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 	return power_range;
 }
 
+
+/**
+ * siblings_grants() - splits the extra power
+ * @max_power:		each actor's maximum available power
+ * @granted_power:	each actor's granted power which is the output array
+ *			and will be increased here
+ * @avail_room:		each actor's capability to consume some more power
+ * @spare_power:	each actor's power value above it's max_power limit,
+ *			which will be consumed by other actors
+ * @num_actors:		size of the @avail_room, @spare_power, @max_power and
+ *			@granted_power's array
+ * @thermal_actor:	array of filtered actors which will be involved in
+ *			this process
+ *
+ * The algorithm calculates the total extra power available per actor's family
+ * and splits this power equally between the family members.
+ * The algorithm distinguishes actors based on their names and adds them to the
+ * proper family. Each family has its own sum of available power to consume
+ * (which can be equal 0).
+ * When the family sharing is done and some power still is available, it goes
+ * to generic power sum, which will be split fairly between all capable actors.
+ */
+static void siblings_grants(struct thermal_zone_device *tz,
+			u32 *max_power, u32 *granted_power,
+			u32 *avail_room, u32 *spare_power,
+			int num_actors,	struct thermal_actor *thermal_actor)
+{
+	struct thermal_cooling_device *cdev;
+	int i;
+	const char *devfreq_name = "thermal-devfreq-";
+	const char *cpufreq_name = "thermal-cpufreq-";
+	u64 sum_spare_power[NUM_CDEV_TYPES] = {0};
+	u64 sum_avail_room[NUM_CDEV_TYPES] = {0};
+	u64 min_sum_extra_power = 0;
+	enum thermal_actor_type type;
+	u64 rest_avail_room = 0;
+	u64 total_spare_power = 0;
+	u64 total_avail_room = 0;
+	unsigned int rounding_gap = num_actors - 1;
+
+	/* Group the thermal actors and calculate power budget
+	 * for each family.
+	 */
+	for (i = 0; i < num_actors; i++) {
+		cdev = thermal_actor[i].cdev;
+		if (!cdev)
+			continue;
+		if (strstarts(cdev->type, cpufreq_name))
+			type = CPUFREQ_CDEV;
+		else if (strstarts(cdev->type, devfreq_name))
+			type = DEVFREQ_CDEV;
+		else
+			type = OTHER_CDEV;
+
+		thermal_actor[i].type = type;
+		sum_spare_power[type] += spare_power[i];
+		sum_avail_room[type] += avail_room[i];
+		total_spare_power += spare_power[i];
+		total_avail_room += avail_room[i];
+	}
+
+	trace_thermal_power_allocator_divvyup(tz, granted_power, avail_room,
+					      spare_power, max_power,
+					      num_actors);
+
+	/* Share the extra power inside the same family. */
+	for (i = 0; i < num_actors; i++) {
+		u64 power;
+
+		type = thermal_actor[i].type;
+
+		if (sum_avail_room[type] && avail_room[i]) {
+			min_sum_extra_power = min(sum_spare_power[type],
+						  sum_avail_room[type]);
+			power = avail_room[i] * min_sum_extra_power;
+			power = div_u64(power, sum_avail_room[type]);
+			granted_power[i] += power;
+			avail_room[i] -= power;
+			total_spare_power -= power;
+			rest_avail_room += avail_room[i];
+		}
+	}
+
+	/* Share the rest (if any) of power between all actors,
+	 *  no mater the group they belong to.
+	 */
+	if (rest_avail_room && total_spare_power > rounding_gap) {
+		u32 min_extra_power;
+		u64 power;
+
+		min_extra_power = min(total_spare_power, rest_avail_room);
+		for (i = 0; i < num_actors; i++) {
+			if (!avail_room[i])
+				continue;
+
+			power = avail_room[i] * min_extra_power;
+			power = div_u64(power, rest_avail_room);
+			granted_power[i] += power;
+		}
+	}
+}
+
 /**
  * divvy_up_power() - divvy the allocated power between the actors
  * @req_power:	each actor's requested power
@@ -266,9 +380,12 @@ static u32 pid_controller(struct thermal_zone_device *tz,
  * @total_req_power: sum of @req_power
  * @power_range:	total allocated power
  * @granted_power:	output array: each actor's granted power
- * @extra_actor_power:	an appropriately sized array to be used in the
- *			function as temporary storage of the extra power given
- *			to the actors
+ * @avail_room:		an appropriately sized array to be used in the
+ *			function as temporary storage of the available room for
+ *			extra power for each actor
+ * @spare_power:	an appropriately sized array to be used in the
+ *			function as temporary storage of the spare power
+ *			for each actor, which can be taken by some other actors
  *
  * This function divides the total allocated power (@power_range)
  * fairly between the actors.  It first tries to give each actor a
@@ -285,12 +402,16 @@ static u32 pid_controller(struct thermal_zone_device *tz,
  * Granted power for each actor is written to @granted_power, which
  * should've been allocated by the calling function.
  */
-static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
+static void divvy_up_power(struct thermal_zone_device *tz, u32 *req_power,
+			   u32 *max_power, int num_actors,
 			   u32 total_req_power, u32 power_range,
-			   u32 *granted_power, u32 *extra_actor_power)
+			   u32 *granted_power, u32 *avail_room,
+			   u32 *spare_power,
+			   struct thermal_actor *thermal_actor)
 {
-	u32 extra_power, capped_extra_power;
 	int i;
+	u64 sum_avail_room = 0;
+	u64 sum_spare_power = 0;
 
 	/*
 	 * Prevent division by 0 if none of the actors request power.
@@ -298,8 +419,6 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 	if (!total_req_power)
 		total_req_power = 1;
 
-	capped_extra_power = 0;
-	extra_power = 0;
 	for (i = 0; i < num_actors; i++) {
 		u64 req_range = (u64)req_power[i] * power_range;
 
@@ -307,26 +426,25 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 							 total_req_power);
 
 		if (granted_power[i] > max_power[i]) {
-			extra_power += granted_power[i] - max_power[i];
+			spare_power[i] = granted_power[i] - max_power[i];
+			sum_spare_power += spare_power[i];
 			granted_power[i] = max_power[i];
 		}
 
-		extra_actor_power[i] = max_power[i] - granted_power[i];
-		capped_extra_power += extra_actor_power[i];
+		avail_room[i] = max_power[i] - granted_power[i];
+		sum_avail_room += avail_room[i];
 	}
 
-	if (!extra_power)
+	if (!sum_avail_room || !sum_spare_power)
 		return;
 
 	/*
 	 * Re-divvy the reclaimed extra among actors based on
 	 * how far they are from the max
 	 */
-	extra_power = min(extra_power, capped_extra_power);
-	if (capped_extra_power > 0)
-		for (i = 0; i < num_actors; i++)
-			granted_power[i] += (extra_actor_power[i] *
-					extra_power) / capped_extra_power;
+	siblings_grants(tz, max_power, granted_power, avail_room,
+			spare_power, num_actors, thermal_actor);
+
 }
 
 static int allocate_power(struct thermal_zone_device *tz,
@@ -334,12 +452,13 @@ static int allocate_power(struct thermal_zone_device *tz,
 {
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
-	u32 *req_power, *max_power, *granted_power, *extra_actor_power;
-	u32 *weighted_req_power;
+	u32 *req_power, *max_power, *granted_power, *avail_room;
+	u32 *weighted_req_power, *spare_power;
 	u32 total_req_power, max_allocatable_power, total_weighted_req_power;
 	u32 total_granted_power, power_range;
 	int i, num_actors, total_weight, ret = 0;
 	int trip_max_desired_temperature = params->trip_max_desired_temperature;
+	struct thermal_actor *thermal_actor;
 
 	mutex_lock(&tz->lock);
 
@@ -358,6 +477,13 @@ static int allocate_power(struct thermal_zone_device *tz,
 		goto unlock;
 	}
 
+	thermal_actor = kcalloc(num_actors, sizeof(struct thermal_actor),
+				GFP_KERNEL);
+	if (!thermal_actor) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
 	/*
 	 * We need to allocate five arrays of the same size:
 	 * req_power, max_power, granted_power, extra_actor_power and
@@ -367,18 +493,21 @@ static int allocate_power(struct thermal_zone_device *tz,
 	 */
 	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*max_power));
 	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*granted_power));
-	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*extra_actor_power));
+	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*avail_room));
 	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*weighted_req_power));
-	req_power = kcalloc(num_actors * 5, sizeof(*req_power), GFP_KERNEL);
+	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*spare_power));
+	req_power = kzalloc(num_actors * 6 * sizeof(*req_power), GFP_KERNEL);
 	if (!req_power) {
 		ret = -ENOMEM;
+		kfree(thermal_actor);
 		goto unlock;
 	}
 
 	max_power = &req_power[num_actors];
 	granted_power = &req_power[2 * num_actors];
-	extra_actor_power = &req_power[3 * num_actors];
+	avail_room = &req_power[3 * num_actors];
 	weighted_req_power = &req_power[4 * num_actors];
+	spare_power = &req_power[5 * num_actors];
 
 	i = 0;
 	total_weighted_req_power = 0;
@@ -412,14 +541,15 @@ static int allocate_power(struct thermal_zone_device *tz,
 		max_allocatable_power += max_power[i];
 		total_weighted_req_power += weighted_req_power[i];
 
+		thermal_actor[i].cdev = cdev;
 		i++;
 	}
 
 	power_range = pid_controller(tz, control_temp, max_allocatable_power);
 
-	divvy_up_power(weighted_req_power, max_power, num_actors,
+	divvy_up_power(tz, weighted_req_power, max_power, num_actors,
 		       total_weighted_req_power, power_range, granted_power,
-		       extra_actor_power);
+		       avail_room, spare_power, thermal_actor);
 
 	total_granted_power = 0;
 	i = 0;
@@ -444,6 +574,7 @@ static int allocate_power(struct thermal_zone_device *tz,
 				      control_temp - tz->temperature);
 
 	kfree(req_power);
+	kfree(thermal_actor);
 unlock:
 	mutex_unlock(&tz->lock);
 
-- 
1.9.1
