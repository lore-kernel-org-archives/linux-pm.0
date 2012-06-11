From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 5/12] thermal: remove tc1/tc2 in generic thermal layer
Date: Mon, 11 Jun 2012 11:20:12 +0800
Message-ID: <1339384812.1492.158.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, eduardo <eduardo.valentin@ti.com>, "R, Durgadoss" <durgadoss.r@intel.com>, "Len, Brown" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org


Remove tc1/tc2 in generic thermal layer.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c                   |    5 +----
 drivers/platform/x86/acerhdf.c           |    2 +-
 drivers/platform/x86/intel_mid_thermal.c |    2 +-
 drivers/thermal/spear_thermal.c          |    2 +-
 drivers/thermal/thermal_sys.c            |   15 ++-------------
 include/linux/thermal.h                  |    4 +---
 6 files changed, 7 insertions(+), 23 deletions(-)

Index: rtd3/drivers/thermal/thermal_sys.c
===================================================================
--- rtd3.orig/drivers/thermal/thermal_sys.c
+++ rtd3/drivers/thermal/thermal_sys.c
@@ -266,9 +266,6 @@ passive_store(struct device *dev, struct
 		tz->passive_delay = 0;
 	}
 
-	tz->tc1 = 1;
-	tz->tc2 = 1;
-
 	tz->forced_passive = state;
 
 	thermal_zone_device_update(tz);
@@ -705,9 +702,6 @@ static void thermal_zone_device_passive(
 
 		thermal_get_trend(tz, trip, (enum thermal_trend *)&trend);
 
-		trend = (tz->tc1 * (temp - tz->last_temperature)) +
-			(tz->tc2 * (temp - trip_temp));
-
 		/* Heating up? */
 		if (trend > 0) {
 			list_for_each_entry(instance, &tz->cooling_devices,
@@ -1143,8 +1137,6 @@ EXPORT_SYMBOL(thermal_zone_device_update
  * @trips:	the number of trip points the thermal zone support
  * @devdata:	private device data
  * @ops:	standard thermal zone device callbacks
- * @tc1:	thermal coefficient 1 for passive calculations
- * @tc2:	thermal coefficient 2 for passive calculations
  * @passive_delay: number of milliseconds to wait between polls when
  *		   performing passive cooling
  * @polling_delay: number of milliseconds to wait between polls when checking
@@ -1152,13 +1144,12 @@ EXPORT_SYMBOL(thermal_zone_device_update
  *		   driven systems)
  *
  * thermal_zone_device_unregister() must be called when the device is no
- * longer needed. The passive cooling formula uses tc1 and tc2 as described in
- * section 11.1.5.1 of the ACPI specification 3.0.
+ * longer needed. The passive cooling depends on the .get_trend() return value.
  */
 struct thermal_zone_device *thermal_zone_device_register(char *type,
 	int trips, void *devdata,
 	const struct thermal_zone_device_ops *ops,
-	int tc1, int tc2, int passive_delay, int polling_delay)
+	int passive_delay, int polling_delay)
 {
 	struct thermal_zone_device *tz;
 	struct thermal_cooling_device *pos;
@@ -1194,8 +1185,6 @@ struct thermal_zone_device *thermal_zone
 	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
 	tz->trips = trips;
-	tz->tc1 = tc1;
-	tz->tc2 = tc2;
 	tz->passive_delay = passive_delay;
 	tz->polling_delay = polling_delay;
 
Index: rtd3/include/linux/thermal.h
===================================================================
--- rtd3.orig/include/linux/thermal.h
+++ rtd3/include/linux/thermal.h
@@ -99,8 +99,6 @@ struct thermal_zone_device {
 	struct device device;
 	void *devdata;
 	int trips;
-	int tc1;
-	int tc2;
 	int passive_delay;
 	int polling_delay;
 	int temperature;
@@ -147,7 +145,7 @@ enum {
 #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
 
 struct thermal_zone_device *thermal_zone_device_register(char *, int, void *,
-		const struct thermal_zone_device_ops *, int tc1, int tc2,
+		const struct thermal_zone_device_ops *,
 		int passive_freq, int polling_freq);
 void thermal_zone_device_unregister(struct thermal_zone_device *);
 
Index: rtd3/drivers/acpi/thermal.c
===================================================================
--- rtd3.orig/drivers/acpi/thermal.c
+++ rtd3/drivers/acpi/thermal.c
@@ -893,16 +893,13 @@ static int acpi_thermal_register_thermal
 		tz->thermal_zone =
 			thermal_zone_device_register("acpitz", trips, tz,
 						     &acpi_thermal_zone_ops,
-						     tz->trips.passive.tc1,
-						     tz->trips.passive.tc2,
 						     tz->trips.passive.tsp*100,
 						     tz->polling_frequency*100);
 	else
 		tz->thermal_zone =
 			thermal_zone_device_register("acpitz", trips, tz,
 						     &acpi_thermal_zone_ops,
-						     0, 0, 0,
-						     tz->polling_frequency*100);
+						     0, tz->polling_frequency*100);
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
Index: rtd3/drivers/platform/x86/acerhdf.c
===================================================================
--- rtd3.orig/drivers/platform/x86/acerhdf.c
+++ rtd3/drivers/platform/x86/acerhdf.c
@@ -661,7 +661,7 @@ static int acerhdf_register_thermal(void
 		return -EINVAL;
 
 	thz_dev = thermal_zone_device_register("acerhdf", 1, NULL,
-					      &acerhdf_dev_ops, 0, 0, 0,
+					      &acerhdf_dev_ops, 0,
 					      (kernelmode) ? interval*1000 : 0);
 	if (IS_ERR(thz_dev))
 		return -EINVAL;
Index: rtd3/drivers/platform/x86/intel_mid_thermal.c
===================================================================
--- rtd3.orig/drivers/platform/x86/intel_mid_thermal.c
+++ rtd3/drivers/platform/x86/intel_mid_thermal.c
@@ -499,7 +499,7 @@ static int mid_thermal_probe(struct plat
 			goto err;
 		}
 		pinfo->tzd[i] = thermal_zone_device_register(name[i],
-				0, td_info, &tzd_ops, 0, 0, 0, 0);
+				0, td_info, &tzd_ops, 0, 0);
 		if (IS_ERR(pinfo->tzd[i])) {
 			kfree(td_info);
 			ret = PTR_ERR(pinfo->tzd[i]);
Index: rtd3/drivers/thermal/spear_thermal.c
===================================================================
--- rtd3.orig/drivers/thermal/spear_thermal.c
+++ rtd3/drivers/thermal/spear_thermal.c
@@ -148,7 +148,7 @@ static int spear_thermal_probe(struct pl
 	writel_relaxed(stdev->flags, stdev->thermal_base);
 
 	spear_thermal = thermal_zone_device_register("spear_thermal", 0,
-				stdev, &ops, 0, 0, 0, 0);
+				stdev, &ops, 0, 0);
 	if (IS_ERR(spear_thermal)) {
 		dev_err(&pdev->dev, "thermal zone device is NULL\n");
 		ret = PTR_ERR(spear_thermal);


