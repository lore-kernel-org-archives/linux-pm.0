From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/4] Thermal/int340x/int3403: Use int340x thermal API
Date: Tue, 23 Dec 2014 15:27:29 -0800
Message-ID: <1419377250-13869-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1419377250-13869-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:43130 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755962AbaLWX2H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Dec 2014 18:28:07 -0500
In-Reply-To: <1419377250-13869-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Using APIs from int340x thermal zone module to add and remove thermal
zones.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/int3403_thermal.c | 210 ++--------------------
 1 file changed, 13 insertions(+), 197 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int3403_thermal.c b/drivers/thermal/int340x_thermal/int3403_thermal.c
index 1431cb3..5470a8a 100644
--- a/drivers/thermal/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3403_thermal.c
@@ -19,6 +19,7 @@
 #include <linux/acpi.h>
 #include <linux/thermal.h>
 #include <linux/platform_device.h>
+#include "int340x_thermal_zone.h"
 
 #define INT3403_TYPE_SENSOR		0x03
 #define INT3403_TYPE_CHARGER		0x0B
@@ -26,18 +27,9 @@
 #define INT3403_PERF_CHANGED_EVENT	0x80
 #define INT3403_THERMAL_EVENT		0x90
 
-#define DECI_KELVIN_TO_MILLI_CELSIUS(t, off) (((t) - (off)) * 100)
-#define KELVIN_OFFSET	2732
-#define MILLI_CELSIUS_TO_DECI_KELVIN(t, off) (((t) / 100) + (off))
-
+/* Preserved structure for future expandbility */
 struct int3403_sensor {
-	struct thermal_zone_device *tzone;
-	unsigned long *thresholds;
-	unsigned long	crit_temp;
-	int		crit_trip_id;
-	unsigned long	psv_temp;
-	int		psv_trip_id;
-
+	struct int34x_thermal_zone *int340x_zone;
 };
 
 struct int3403_performance_state {
@@ -63,126 +55,6 @@ struct int3403_priv {
 	void *priv;
 };
 
-static int sys_get_curr_temp(struct thermal_zone_device *tzone,
-				unsigned long *temp)
-{
-	struct int3403_priv *priv = tzone->devdata;
-	struct acpi_device *device = priv->adev;
-	unsigned long long tmp;
-	acpi_status status;
-
-	status = acpi_evaluate_integer(device->handle, "_TMP", NULL, &tmp);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	*temp = DECI_KELVIN_TO_MILLI_CELSIUS(tmp, KELVIN_OFFSET);
-
-	return 0;
-}
-
-static int sys_get_trip_hyst(struct thermal_zone_device *tzone,
-		int trip, unsigned long *temp)
-{
-	struct int3403_priv *priv = tzone->devdata;
-	struct acpi_device *device = priv->adev;
-	unsigned long long hyst;
-	acpi_status status;
-
-	status = acpi_evaluate_integer(device->handle, "GTSH", NULL, &hyst);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	/*
-	 * Thermal hysteresis represents a temperature difference.
-	 * Kelvin and Celsius have same degree size. So the
-	 * conversion here between tenths of degree Kelvin unit
-	 * and Milli-Celsius unit is just to multiply 100.
-	 */
-	*temp = hyst * 100;
-
-	return 0;
-}
-
-static int sys_get_trip_temp(struct thermal_zone_device *tzone,
-		int trip, unsigned long *temp)
-{
-	struct int3403_priv *priv = tzone->devdata;
-	struct int3403_sensor *obj = priv->priv;
-
-	if (priv->type != INT3403_TYPE_SENSOR || !obj)
-		return -EINVAL;
-
-	if (trip == obj->crit_trip_id)
-		*temp = obj->crit_temp;
-	else if (trip == obj->psv_trip_id)
-		*temp = obj->psv_temp;
-	else {
-		/*
-		 * get_trip_temp is a mandatory callback but
-		 * PATx method doesn't return any value, so return
-		 * cached value, which was last set from user space
-		 */
-		*temp = obj->thresholds[trip];
-	}
-
-	return 0;
-}
-
-static int sys_get_trip_type(struct thermal_zone_device *thermal,
-		int trip, enum thermal_trip_type *type)
-{
-	struct int3403_priv *priv = thermal->devdata;
-	struct int3403_sensor *obj = priv->priv;
-
-	/* Mandatory callback, may not mean much here */
-	if (trip == obj->crit_trip_id)
-		*type = THERMAL_TRIP_CRITICAL;
-	else
-		*type = THERMAL_TRIP_PASSIVE;
-
-	return 0;
-}
-
-int sys_set_trip_temp(struct thermal_zone_device *tzone, int trip,
-							unsigned long temp)
-{
-	struct int3403_priv *priv = tzone->devdata;
-	struct acpi_device *device = priv->adev;
-	struct int3403_sensor *obj = priv->priv;
-	acpi_status status;
-	char name[10];
-	int ret = 0;
-
-	snprintf(name, sizeof(name), "PAT%d", trip);
-	if (acpi_has_method(device->handle, name)) {
-		status = acpi_execute_simple_method(device->handle, name,
-				MILLI_CELSIUS_TO_DECI_KELVIN(temp,
-							KELVIN_OFFSET));
-		if (ACPI_FAILURE(status))
-			ret = -EIO;
-		else
-			obj->thresholds[trip] = temp;
-	} else {
-		ret = -EIO;
-		dev_err(&device->dev, "sys_set_trip_temp: method not found\n");
-	}
-
-	return ret;
-}
-
-static struct thermal_zone_device_ops tzone_ops = {
-	.get_temp = sys_get_curr_temp,
-	.get_trip_temp = sys_get_trip_temp,
-	.get_trip_type = sys_get_trip_type,
-	.set_trip_temp = sys_set_trip_temp,
-	.get_trip_hyst =  sys_get_trip_hyst,
-};
-
-static struct thermal_zone_params int3403_thermal_params = {
-	.governor_name = "user_space",
-	.no_hwmon = true,
-};
-
 static void int3403_notify(acpi_handle handle,
 		u32 event, void *data)
 {
@@ -200,7 +72,7 @@ static void int3403_notify(acpi_handle handle,
 	case INT3403_PERF_CHANGED_EVENT:
 		break;
 	case INT3403_THERMAL_EVENT:
-		thermal_zone_device_update(obj->tzone);
+		int340x_thermal_zone_device_update(obj->int340x_zone);
 		break;
 	default:
 		dev_err(&priv->pdev->dev, "Unsupported event [0x%x]\n", event);
@@ -208,41 +80,10 @@ static void int3403_notify(acpi_handle handle,
 	}
 }
 
-static int sys_get_trip_crt(struct acpi_device *device, unsigned long *temp)
-{
-	unsigned long long crt;
-	acpi_status status;
-
-	status = acpi_evaluate_integer(device->handle, "_CRT", NULL, &crt);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	*temp = DECI_KELVIN_TO_MILLI_CELSIUS(crt, KELVIN_OFFSET);
-
-	return 0;
-}
-
-static int sys_get_trip_psv(struct acpi_device *device, unsigned long *temp)
-{
-	unsigned long long psv;
-	acpi_status status;
-
-	status = acpi_evaluate_integer(device->handle, "_PSV", NULL, &psv);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	*temp = DECI_KELVIN_TO_MILLI_CELSIUS(psv, KELVIN_OFFSET);
-
-	return 0;
-}
-
 static int int3403_sensor_add(struct int3403_priv *priv)
 {
 	int result = 0;
-	acpi_status status;
 	struct int3403_sensor *obj;
-	unsigned long long trip_cnt;
-	int trip_mask = 0;
 
 	obj = devm_kzalloc(&priv->pdev->dev, sizeof(*obj), GFP_KERNEL);
 	if (!obj)
@@ -250,37 +91,10 @@ static int int3403_sensor_add(struct int3403_priv *priv)
 
 	priv->priv = obj;
 
-	status = acpi_evaluate_integer(priv->adev->handle, "PATC", NULL,
-						&trip_cnt);
-	if (ACPI_FAILURE(status))
-		trip_cnt = 0;
-
-	if (trip_cnt) {
-		/* We have to cache, thresholds can't be readback */
-		obj->thresholds = devm_kzalloc(&priv->pdev->dev,
-					sizeof(*obj->thresholds) * trip_cnt,
-					GFP_KERNEL);
-		if (!obj->thresholds) {
-			result = -ENOMEM;
-			goto err_free_obj;
-		}
-		trip_mask = BIT(trip_cnt) - 1;
-	}
-
-	obj->psv_trip_id = -1;
-	if (!sys_get_trip_psv(priv->adev, &obj->psv_temp))
-		obj->psv_trip_id = trip_cnt++;
-
-	obj->crit_trip_id = -1;
-	if (!sys_get_trip_crt(priv->adev, &obj->crit_temp))
-		obj->crit_trip_id = trip_cnt++;
-
-	obj->tzone = thermal_zone_device_register(acpi_device_bid(priv->adev),
-				trip_cnt, trip_mask, priv, &tzone_ops,
-				&int3403_thermal_params, 0, 0);
-	if (IS_ERR(obj->tzone)) {
-		result = PTR_ERR(obj->tzone);
-		obj->tzone = NULL;
+	obj->int340x_zone = int340x_thermal_zone_add(priv->adev, NULL);
+	if (IS_ERR(obj->int340x_zone)) {
+		result = PTR_ERR(obj->int340x_zone);
+		obj->int340x_zone = NULL;
 		goto err_free_obj;
 	}
 
@@ -293,8 +107,9 @@ static int int3403_sensor_add(struct int3403_priv *priv)
 	return 0;
 
  err_free_obj:
-	if (obj->tzone)
-		thermal_zone_device_unregister(obj->tzone);
+	if (obj->int340x_zone)
+		int340x_thermal_zone_remove(obj->int340x_zone);
+
 	return result;
 }
 
@@ -304,7 +119,8 @@ static int int3403_sensor_remove(struct int3403_priv *priv)
 
 	acpi_remove_notify_handler(priv->adev->handle,
 				   ACPI_DEVICE_NOTIFY, int3403_notify);
-	thermal_zone_device_unregister(obj->tzone);
+	int340x_thermal_zone_remove(obj->int340x_zone);
+
 	return 0;
 }
 
-- 
1.9.3

