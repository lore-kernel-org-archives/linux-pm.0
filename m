From: Srikar Srimath Tirumala <srikars@nvidia.com>
Subject: [PATCH v3 2/4] thermal: send notifications for tz temperature
Date: Tue, 29 Mar 2016 17:41:35 -0700
Message-ID: <1459298497-29481-3-git-send-email-srikars@nvidia.com>
References: <1459298497-29481-1-git-send-email-srikars@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9370 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbcC3Al3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 20:41:29 -0400
In-Reply-To: <1459298497-29481-1-git-send-email-srikars@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, srinivas.pandruvada@intel.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: mlongnecker@nvidia.com, Srikar Srimath Tirumala <srikars@nvidia.com>

* Update the 'temp' attr of a thermal_zone sysfs node, when the
  temperature goes above\below a trip point. Use sysfs_notify to send
  the notifications.

* Send the notification only if the temperature notifications are
  enabled. Use the hysteresis property to avoid sending too many
  notifications when the temperatures are bouncing around.

* Add ops that will allow thermal framework to:
  * find out if a temperature notification can be sent when a given
    trip point has been crossed.
  * get/set the trip state.

* Add a new state type for the trip points. A trip point can either
  be 'TRIPPED' or 'NOT_TRIPPED'.

Change-Id: If5b530b4045cdb2840eef855dc158cbce239ce79
Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
---
 drivers/thermal/thermal_core.c | 28 ++++++++++++++++++++++++++++
 include/linux/thermal.h        | 12 ++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b09fff1..37bdc32 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -419,6 +419,32 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
+static void handle_temp_notify(struct thermal_zone_device *tz, int trip)
+{
+	int trip_temp, hyst = 0;
+	enum thermal_trip_state s, ns;
+
+	s = ns = THERMAL_TRIP_NOT_TRIPPED;
+	tz->ops->get_trip_temp(tz, trip, &trip_temp);
+	tz->ops->get_trip_hyst(tz, trip, &hyst);
+
+	if (tz->ops->get_trip_state)
+		tz->ops->get_trip_state(tz, trip, &s);
+
+	if (s == THERMAL_TRIP_TRIPPED && tz->temperature < trip_temp - hyst)
+		ns = THERMAL_TRIP_NOT_TRIPPED;
+	else if (s == THERMAL_TRIP_NOT_TRIPPED && tz->temperature >= trip_temp)
+		ns = THERMAL_TRIP_TRIPPED;
+
+	if (tz->ops->set_trip_state)
+		tz->ops->set_trip_state(tz, trip, ns);
+
+	/* send if notifications are enabled and state has changed */
+	if (s != ns && tz->ops->enb_temp_notify &&
+		tz->ops->enb_temp_notify(tz, trip))
+		sysfs_notify(&tz->device.kobj, NULL, "temp");
+}
+
 static void handle_non_critical_trips(struct thermal_zone_device *tz,
 			int trip, enum thermal_trip_type trip_type)
 {
@@ -464,6 +490,8 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 		handle_critical_trips(tz, trip, type);
 	else
 		handle_non_critical_trips(tz, trip, type);
+
+	handle_temp_notify(tz, trip);
 	/*
 	 * Alright, we handled this trip successfully.
 	 * So, start monitoring again.
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a55d052..9182e36 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -84,6 +84,11 @@ enum thermal_trip_type {
 	THERMAL_TRIP_CRITICAL,
 };
 
+enum thermal_trip_state {
+	THERMAL_TRIP_NOT_TRIPPED = 0,
+	THERMAL_TRIP_TRIPPED
+};
+
 enum thermal_trend {
 	THERMAL_TREND_STABLE, /* temperature is stable */
 	THERMAL_TREND_RAISING, /* temperature is raising */
@@ -114,6 +119,11 @@ struct thermal_zone_device_ops {
 			  enum thermal_trend *);
 	int (*notify) (struct thermal_zone_device *, int,
 		       enum thermal_trip_type);
+	int (*get_trip_state)(struct thermal_zone_device *, int,
+			enum thermal_trip_state *);
+	int (*set_trip_state)(struct thermal_zone_device *, int,
+			enum thermal_trip_state);
+	bool (*enb_temp_notify)(struct thermal_zone_device *, int);
 };
 
 struct thermal_cooling_device_ops {
@@ -348,6 +358,7 @@ struct thermal_zone_of_device_ops {
  * @temperature: temperature value in miliCelsius
  * @hysteresis: relative hysteresis in miliCelsius
  * @type: trip point type
+ * @state: trip point state
  */
 
 struct thermal_trip {
@@ -355,6 +366,7 @@ struct thermal_trip {
 	unsigned long int temperature;
 	unsigned long int hysteresis;
 	enum thermal_trip_type type;
+	enum thermal_trip_state state;
 };
 
 /* Function declarations */
-- 
2.1.4

