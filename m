From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v5 2/5] thermal: power_allocator: relax the requirement of a sustainable_power in tzp
Date: Mon,  7 Sep 2015 14:19:26 +0100
Message-ID: <1441631969-3272-3-git-send-email-javi.merino@arm.com>
References: <1440595604-27197-1-git-send-email-javi.merino@arm.com>
 <1441631969-3272-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441631969-3272-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, cywang@chromium.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, djkurtz@chromium.org, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

The power allocator governor currently requires that a sustainable power
is passed as part of the thermal zone's thermal zone parameters.  If
that parameter is not provided, it doesn't register with the thermal
zone.

While this parameter is strongly recommended for optimal performance, it
doesn't need to be mandatory.  Relax the requirement and allow the
governor to bind to thermal zones that don't provide it by estimating it
from the cooling devices' power model.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/power_allocator.c | 125 ++++++++++++++++++++++++++++++--------
 1 file changed, 100 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 251676902869..7fa6685f9c5b 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -73,6 +73,88 @@ struct power_allocator_params {
 };
 
 /**
+ * estimate_sustainable_power() - Estimate the sustainable power of a thermal zone
+ * @tz: thermal zone we are operating in
+ *
+ * For thermal zones that don't provide a sustainable_power in their
+ * thermal_zone_params, estimate one.  Calculate it using the minimum
+ * power of all the cooling devices as that gives a valid value that
+ * can give some degree of functionality.  For optimal performance of
+ * this governor, provide a sustainable_power in the thermal zone's
+ * thermal_zone_params.
+ */
+static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
+{
+	u32 sustainable_power = 0;
+	struct thermal_instance *instance;
+	struct power_allocator_params *params = tz->governor_data;
+
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		struct thermal_cooling_device *cdev = instance->cdev;
+		u32 min_power;
+
+		if (instance->trip != params->trip_max_desired_temperature)
+			continue;
+
+		if (power_actor_get_min_power(cdev, tz, &min_power))
+			continue;
+
+		sustainable_power += min_power;
+	}
+
+	return sustainable_power;
+}
+
+/**
+ * estimate_pid_constants() - Estimate the constants for the PID controller
+ * @tz:		thermal zone for which to estimate the constants
+ * @sustainable_power:	sustainable power for the thermal zone
+ * @trip_switch_on:	trip point number for the switch on temperature
+ * @control_temp:	target temperature for the power allocator governor
+ * @force:	whether to force the update of the constants
+ *
+ * This function is used to update the estimation of the PID
+ * controller constants in struct thermal_zone_parameters.
+ * Sustainable power is provided in case it was estimated.  The
+ * estimated sustainable_power should not be stored in the
+ * thermal_zone_parameters so it has to be passed explicitly to this
+ * function.
+ *
+ * If @force is not set, the values in the thermal zone's parameters
+ * are preserved if they are not zero.  If @force is set, the values
+ * in thermal zone's parameters are overwritten.
+ */
+static void estimate_pid_constants(struct thermal_zone_device *tz,
+				   u32 sustainable_power, int trip_switch_on,
+				   unsigned long control_temp, bool force)
+{
+	int ret;
+	unsigned long switch_on_temp;
+	u32 temperature_threshold;
+
+	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
+	if (ret)
+		switch_on_temp = 0;
+
+	temperature_threshold = control_temp - switch_on_temp;
+
+	if (!tz->tzp->k_po || force)
+		tz->tzp->k_po = int_to_frac(sustainable_power) /
+			temperature_threshold;
+
+	if (!tz->tzp->k_pu || force)
+		tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
+			temperature_threshold;
+
+	if (!tz->tzp->k_i || force)
+		tz->tzp->k_i = int_to_frac(10) / 1000;
+	/*
+	 * The default for k_d and integral_cutoff is 0, so we can
+	 * leave them as they are.
+	 */
+}
+
+/**
  * pid_controller() - PID controller
  * @tz:	thermal zone we are operating in
  * @current_temp:	the current temperature in millicelsius
@@ -98,10 +180,20 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 {
 	s64 p, i, d, power_range;
 	s32 err, max_power_frac;
+	u32 sustainable_power;
 	struct power_allocator_params *params = tz->governor_data;
 
 	max_power_frac = int_to_frac(max_allocatable_power);
 
+	if (tz->tzp->sustainable_power) {
+		sustainable_power = tz->tzp->sustainable_power;
+	} else {
+		sustainable_power = estimate_sustainable_power(tz);
+		estimate_pid_constants(tz, sustainable_power,
+				       params->trip_switch_on, control_temp,
+				       true);
+	}
+
 	err = ((s32)control_temp - (s32)current_temp);
 	err = int_to_frac(err);
 
@@ -139,7 +231,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 	power_range = p + i + d;
 
 	/* feed-forward the known sustainable dissipatable power */
-	power_range = tz->tzp->sustainable_power + frac_to_int(power_range);
+	power_range = sustainable_power + frac_to_int(power_range);
 
 	power_range = clamp(power_range, (s64)0, (s64)max_allocatable_power);
 
@@ -416,19 +508,18 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 {
 	int ret;
 	struct power_allocator_params *params;
-	unsigned long switch_on_temp, control_temp;
-	u32 temperature_threshold;
+	unsigned long control_temp;
 
-	if (!tz->tzp || !tz->tzp->sustainable_power) {
-		dev_err(&tz->device,
-			"power_allocator: missing sustainable_power\n");
+	if (!tz->tzp)
 		return -EINVAL;
-	}
 
 	params = kzalloc(sizeof(*params), GFP_KERNEL);
 	if (!params)
 		return -ENOMEM;
 
+	if (!tz->tzp->sustainable_power)
+		dev_warn(&tz->device, "power_allocator: sustainable_power will be estimated\n");
+
 	ret = get_governor_trips(tz, params);
 	if (ret) {
 		dev_err(&tz->device,
@@ -437,29 +528,13 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 		goto free;
 	}
 
-	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
-				     &switch_on_temp);
-	if (ret)
-		goto free;
-
 	ret = tz->ops->get_trip_temp(tz, params->trip_max_desired_temperature,
 				     &control_temp);
 	if (ret)
 		goto free;
 
-	temperature_threshold = control_temp - switch_on_temp;
-
-	tz->tzp->k_po = tz->tzp->k_po ?:
-		int_to_frac(tz->tzp->sustainable_power) / temperature_threshold;
-	tz->tzp->k_pu = tz->tzp->k_pu ?:
-		int_to_frac(2 * tz->tzp->sustainable_power) /
-		temperature_threshold;
-	tz->tzp->k_i = tz->tzp->k_i ?: int_to_frac(10) / 1000;
-	/*
-	 * The default for k_d and integral_cutoff is 0, so we can
-	 * leave them as they are.
-	 */
-
+	estimate_pid_constants(tz, tz->tzp->sustainable_power,
+			       params->trip_switch_on, control_temp, false);
 	reset_pid_controller(params);
 
 	tz->governor_data = params;
-- 
1.9.1
