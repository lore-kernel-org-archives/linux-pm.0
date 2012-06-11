From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 4/12] thermal: introduce .get_trend() callback
Date: Mon, 11 Jun 2012 11:20:06 +0800
Message-ID: <1339384806.1492.157.camel@rui.sh.intel.com>
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


tc1 and tc2 are ACPI platform specific concepts, introduce
.get_trend() as a more general solution.


Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c        |   32 ++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_sys.c |   19 +++++++++++++++++--
 include/linux/thermal.h       |    9 +++++++++
 3 files changed, 58 insertions(+), 2 deletions(-)

Index: rtd3/drivers/acpi/thermal.c
===================================================================
--- rtd3.orig/drivers/acpi/thermal.c
+++ rtd3/drivers/acpi/thermal.c
@@ -706,6 +706,37 @@ static int thermal_get_crit_temp(struct
 		return -EINVAL;
 }
 
+static int thermal_get_trend(struct thermal_zone_device *thermal,
+				int trip, enum thermal_trend *trend)
+{
+	struct acpi_thermal *tz = thermal->devdata;
+	enum thermal_trip_type type;
+	unsigned long trip_temp;
+	int i;
+
+	if (thermal_get_trip_type(thermal, trip, &type))
+		return -EINVAL;
+
+	/* Only PASSIVE trip points need TREND */
+	if (type != THERMAL_TRIP_PASSIVE)
+		return -EINVAL;
+
+	if (thermal_get_trip_temp(thermal, trip, &trip_temp))
+		return -EINVAL;
+
+	/*
+	 * tz->temperature has already been updated by generic thermal layer,
+	 * before this callback being invoked
+	 */
+	i = (tz->trips.passive.tc1 * (tz->temperature - tz->last_temperature))
+		+ (tz->trips.passive.tc2 * (tz->temperature - trip_temp));
+
+	*trend = i > 0 ? THERMAL_TREND_RAISING :
+		(i < 0 ? THERMAL_TREND_DROPPING : THERMAL_TREND_NONE);
+	return 0;
+}
+
+
 static int thermal_notify(struct thermal_zone_device *thermal, int trip,
 			   enum thermal_trip_type trip_type)
 {
@@ -835,6 +866,7 @@ static const struct thermal_zone_device_
 	.get_trip_type = thermal_get_trip_type,
 	.get_trip_temp = thermal_get_trip_temp,
 	.get_crit_temp = thermal_get_crit_temp,
+	.get_trend = thermal_get_trend,
 	.notify = thermal_notify,
 };
 
Index: rtd3/drivers/thermal/thermal_sys.c
===================================================================
--- rtd3.orig/drivers/thermal/thermal_sys.c
+++ rtd3/drivers/thermal/thermal_sys.c
@@ -657,6 +657,18 @@ thermal_remove_hwmon_sysfs(struct therma
 }
 #endif
 
+static void thermal_get_trend (struct thermal_zone_device *tz,
+		int trip, enum thermal_trend *trend)
+{
+	if (tz->ops->get_trend)
+		if (!tz->ops->get_trend(tz, trip, trend))
+			return;
+
+	*trend = tz->temperature >= tz->last_temperature ?
+		 THERMAL_TREND_RAISING : THERMAL_TREND_DROPPING;
+	return;
+}
+
 static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 					    int delay)
 {
@@ -691,6 +703,8 @@ static void thermal_zone_device_passive(
 	if (temp >= trip_temp) {
 		tz->passive = true;
 
+		thermal_get_trend(tz, trip, (enum thermal_trend *)&trend);
+
 		trend = (tz->tc1 * (temp - tz->last_temperature)) +
 			(tz->tc2 * (temp - trip_temp));
 
@@ -1049,6 +1063,9 @@ void thermal_zone_device_update(struct t
 		goto leave;
 	}
 
+	tz->last_temperature = tz->temperature;
+	tz->temperature = temp;
+
 	for (count = 0; count < tz->trips; count++) {
 		tz->ops->get_trip_type(tz, count, &trip_type);
 		tz->ops->get_trip_temp(tz, count, &trip_temp);
@@ -1108,8 +1125,6 @@ void thermal_zone_device_update(struct t
 		thermal_zone_device_passive(tz, temp, tz->forced_passive,
 					    THERMAL_TRIPS_NONE);
 
-	tz->last_temperature = temp;
-
 leave:
 	if (tz->passive)
 		thermal_zone_device_set_polling(tz, tz->passive_delay);
Index: rtd3/include/linux/thermal.h
===================================================================
--- rtd3.orig/include/linux/thermal.h
+++ rtd3/include/linux/thermal.h
@@ -44,6 +44,12 @@ enum thermal_trip_type {
 	THERMAL_TRIP_CRITICAL,
 };
 
+enum thermal_trend {
+	THERMAL_TREND_NONE,
+	THERMAL_TREND_RAISING,
+	THERMAL_TREND_DROPPING,
+};
+
 struct thermal_zone_device_ops {
 	int (*bind) (struct thermal_zone_device *,
 		     struct thermal_cooling_device *);
@@ -59,6 +65,8 @@ struct thermal_zone_device_ops {
 	int (*get_trip_temp) (struct thermal_zone_device *, int,
 			      unsigned long *);
 	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *);
+	int (*get_trend) (struct thermal_zone_device *, int,
+			  enum thermal_trend *);
 	int (*notify) (struct thermal_zone_device *, int,
 		       enum thermal_trip_type);
 };
@@ -95,6 +103,7 @@ struct thermal_zone_device {
 	int tc2;
 	int passive_delay;
 	int polling_delay;
+	int temperature;
 	int last_temperature;
 	bool passive;
 	unsigned int forced_passive;
