From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] Thermal: int3403: Add CRT and PSV trip
Date: Fri, 30 May 2014 12:10:32 -0700
Message-ID: <1401477032-18627-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27509 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbaE3TG0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 30 May 2014 15:06:26 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, eduardo.valentin@ti.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The ACPI object definition can contain passive and critical
trip temperature. Export them via thermal sysfs.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int3403_thermal.c | 67 +++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/int3403_thermal.c b/drivers/thermal/int3403_thermal.c
index e93f025..17554ee 100644
--- a/drivers/thermal/int3403_thermal.c
+++ b/drivers/thermal/int3403_thermal.c
@@ -33,6 +33,10 @@
 struct int3403_sensor {
 	struct thermal_zone_device *tzone;
 	unsigned long *thresholds;
+	unsigned long	crit_temp;
+	int		crit_trip_id;
+	unsigned long	psv_temp;
+	int		psv_trip_id;
 };
 
 static int sys_get_curr_temp(struct thermal_zone_device *tzone,
@@ -79,12 +83,18 @@ static int sys_get_trip_temp(struct thermal_zone_device *tzone,
 	struct acpi_device *device = tzone->devdata;
 	struct int3403_sensor *obj = acpi_driver_data(device);
 
-	/*
-	 * get_trip_temp is a mandatory callback but
-	 * PATx method doesn't return any value, so return
-	 * cached value, which was last set from user space.
-	 */
-	*temp = obj->thresholds[trip];
+	if (trip == obj->crit_trip_id)
+		*temp = obj->crit_temp;
+	else if (trip == obj->psv_trip_id)
+		*temp = obj->psv_temp;
+	else {
+		/*
+		 * get_trip_temp is a mandatory callback but
+		 * PATx method doesn't return any value, so return
+		 * cached value, which was last set from user space.
+		 */
+		*temp = obj->thresholds[trip];
+	}
 
 	return 0;
 }
@@ -92,8 +102,14 @@ static int sys_get_trip_temp(struct thermal_zone_device *tzone,
 static int sys_get_trip_type(struct thermal_zone_device *thermal,
 		int trip, enum thermal_trip_type *type)
 {
+	struct acpi_device *device = thermal->devdata;
+	struct int3403_sensor *obj = acpi_driver_data(device);
+
 	/* Mandatory callback, may not mean much here */
-	*type = THERMAL_TRIP_PASSIVE;
+	if (trip == obj->crit_trip_id)
+		*type = THERMAL_TRIP_CRITICAL;
+	else
+		*type = THERMAL_TRIP_PASSIVE;
 
 	return 0;
 }
@@ -155,6 +171,34 @@ static void acpi_thermal_notify(struct acpi_device *device, u32 event)
 	}
 }
 
+static int sys_get_trip_crt(struct acpi_device *device, unsigned long *temp)
+{
+	unsigned long long crt;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(device->handle, "_CRT", NULL, &crt);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	*temp = DECI_KELVIN_TO_MILLI_CELSIUS(crt, KELVIN_OFFSET);
+
+	return 0;
+}
+
+static int sys_get_trip_psv(struct acpi_device *device, unsigned long *temp)
+{
+	unsigned long long psv;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(device->handle, "_PSV", NULL, &psv);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	*temp = DECI_KELVIN_TO_MILLI_CELSIUS(psv, KELVIN_OFFSET);
+
+	return 0;
+}
+
 static int acpi_int3403_add(struct acpi_device *device)
 {
 	int result = 0;
@@ -194,6 +238,15 @@ static int acpi_int3403_add(struct acpi_device *device)
 			return -ENOMEM;
 		trip_mask = BIT(trip_cnt) - 1;
 	}
+
+	obj->psv_trip_id = -1;
+	if (!sys_get_trip_psv(device, &obj->psv_temp))
+		obj->psv_trip_id = trip_cnt++;
+
+	obj->crit_trip_id = -1;
+	if (!sys_get_trip_crt(device, &obj->crit_temp))
+		obj->crit_trip_id = trip_cnt++;
+
 	obj->tzone = thermal_zone_device_register(acpi_device_bid(device),
 				trip_cnt, trip_mask, device, &tzone_ops,
 				NULL, 0, 0);
-- 
1.9.3

