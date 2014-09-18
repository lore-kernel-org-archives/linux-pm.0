From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 13/19] Thermal: move the KELVIN_TO_MILLICELSIUS macro to thermal.h
Date: Thu, 18 Sep 2014 09:53:44 +0800
Message-ID: <1411005230-2227-14-git-send-email-rui.zhang@intel.com>
References: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, eduardo.valentin@ti.com, Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Aaron Lu <aaron.lu@intel.com>

This macro can be used by other component so move it to a common header,
but in a slightly different way: define two macros, one macro with an
offset and the other doesn't.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c  | 18 +++++++++---------
 include/linux/thermal.h |  2 ++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 112817e..d24fa19 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -528,7 +528,6 @@ static void acpi_thermal_check(void *data)
 }
 
 /* sys I/F for generic thermal sysfs support */
-#define KELVIN_TO_MILLICELSIUS(t, off) (((t) - (off)) * 100)
 
 static int thermal_get_temp(struct thermal_zone_device *thermal,
 			    unsigned long *temp)
@@ -543,7 +542,8 @@ static int thermal_get_temp(struct thermal_zone_device *thermal,
 	if (result)
 		return result;
 
-	*temp = KELVIN_TO_MILLICELSIUS(tz->temperature, tz->kelvin_offset);
+	*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(tz->temperature,
+							tz->kelvin_offset);
 	return 0;
 }
 
@@ -647,7 +647,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.critical.flags.valid) {
 		if (!trip) {
-			*temp = KELVIN_TO_MILLICELSIUS(
+			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
 				tz->trips.critical.temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -657,7 +657,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.hot.flags.valid) {
 		if (!trip) {
-			*temp = KELVIN_TO_MILLICELSIUS(
+			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
 				tz->trips.hot.temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -667,7 +667,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.passive.flags.valid) {
 		if (!trip) {
-			*temp = KELVIN_TO_MILLICELSIUS(
+			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
 				tz->trips.passive.temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -678,7 +678,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
 		tz->trips.active[i].flags.valid; i++) {
 		if (!trip) {
-			*temp = KELVIN_TO_MILLICELSIUS(
+			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
 				tz->trips.active[i].temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -694,7 +694,7 @@ static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
 	struct acpi_thermal *tz = thermal->devdata;
 
 	if (tz->trips.critical.flags.valid) {
-		*temperature = KELVIN_TO_MILLICELSIUS(
+		*temperature = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
 				tz->trips.critical.temperature,
 				tz->kelvin_offset);
 		return 0;
@@ -714,8 +714,8 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
 
 	if (type == THERMAL_TRIP_ACTIVE) {
 		unsigned long trip_temp;
-		unsigned long temp = KELVIN_TO_MILLICELSIUS(tz->temperature,
-							tz->kelvin_offset);
+		unsigned long temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+					tz->temperature, tz->kelvin_offset);
 		if (thermal_get_trip_temp(thermal, trip, &trip_temp))
 			return -EINVAL;
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 0305cde..79ce6b9 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -44,6 +44,8 @@
 #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
 				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
 #define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
+#define DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(t, off) (((t) - (off)) * 100)
+#define DECI_KELVIN_TO_MILLICELSIUS(t) DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(t, 2732)
 
 /* Adding event notification support elements */
 #define THERMAL_GENL_FAMILY_NAME                "thermal_event"
-- 
1.8.3.2

