From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/4] thermal: int340x: New Interface to read trip and notify
Date: Fri, 26 Aug 2016 16:21:18 -0700
Message-ID: <1472253679-15084-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1472253679-15084-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:33186 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754209AbcHZXVc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Aug 2016 19:21:32 -0400
In-Reply-To: <1472253679-15084-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Separated the code for reading trip points from int340x_thermal_zone_add to
a standalone function int340x_thermal_read_trips. This standlone
interface to read is exported so that int340x drivers can re-read trips
on ACPI notification for trip point change.
Also the appropriate notification events are sent by int340x driver based
on the acpi event using int340x_thermal_zone_device_update().

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/int3402_thermal.c  |  3 +-
 drivers/thermal/int340x_thermal/int3403_thermal.c  |  3 +-
 .../thermal/int340x_thermal/int340x_thermal_zone.c | 60 ++++++++++++++--------
 .../thermal/int340x_thermal/int340x_thermal_zone.h |  6 ++-
 .../int340x_thermal/processor_thermal_device.c     |  3 +-
 5 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int3402_thermal.c b/drivers/thermal/int340x_thermal/int3402_thermal.c
index 69df3d9..8e90b31 100644
--- a/drivers/thermal/int340x_thermal/int3402_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3402_thermal.c
@@ -35,7 +35,8 @@ static void int3402_notify(acpi_handle handle, u32 event, void *data)
 	case INT3402_PERF_CHANGED_EVENT:
 		break;
 	case INT3402_THERMAL_EVENT:
-		int340x_thermal_zone_device_update(priv->int340x_zone);
+		int340x_thermal_zone_device_update(priv->int340x_zone,
+						   THERMAL_TRIP_VIOLATED);
 		break;
 	default:
 		break;
diff --git a/drivers/thermal/int340x_thermal/int3403_thermal.c b/drivers/thermal/int340x_thermal/int3403_thermal.c
index 50a7a08..7643489 100644
--- a/drivers/thermal/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3403_thermal.c
@@ -72,7 +72,8 @@ static void int3403_notify(acpi_handle handle,
 	case INT3403_PERF_CHANGED_EVENT:
 		break;
 	case INT3403_THERMAL_EVENT:
-		int340x_thermal_zone_device_update(obj->int340x_zone);
+		int340x_thermal_zone_device_update(obj->int340x_zone,
+						   THERMAL_TRIP_VIOLATED);
 		break;
 	default:
 		dev_err(&priv->pdev->dev, "Unsupported event [0x%x]\n", event);
diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
index b9b2666..145a5c5 100644
--- a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
@@ -177,6 +177,42 @@ static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
 	return 0;
 }
 
+int int340x_thermal_read_trips(struct int34x_thermal_zone *int34x_zone)
+{
+	int trip_cnt = int34x_zone->aux_trip_nr;
+	int i;
+
+	int34x_zone->crt_trip_id = -1;
+	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_CRT",
+					     &int34x_zone->crt_temp))
+		int34x_zone->crt_trip_id = trip_cnt++;
+
+	int34x_zone->hot_trip_id = -1;
+	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_HOT",
+					     &int34x_zone->hot_temp))
+		int34x_zone->hot_trip_id = trip_cnt++;
+
+	int34x_zone->psv_trip_id = -1;
+	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_PSV",
+					     &int34x_zone->psv_temp))
+		int34x_zone->psv_trip_id = trip_cnt++;
+
+	for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
+		char name[5] = { '_', 'A', 'C', '0' + i, '\0' };
+
+		if (int340x_thermal_get_trip_config(int34x_zone->adev->handle,
+					name,
+					&int34x_zone->act_trips[i].temp))
+			break;
+
+		int34x_zone->act_trips[i].id = trip_cnt++;
+		int34x_zone->act_trips[i].valid = true;
+	}
+
+	return trip_cnt;
+}
+EXPORT_SYMBOL_GPL(int340x_thermal_read_trips);
+
 static struct thermal_zone_params int340x_thermal_params = {
 	.governor_name = "user_space",
 	.no_hwmon = true,
@@ -188,7 +224,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 	struct int34x_thermal_zone *int34x_thermal_zone;
 	acpi_status status;
 	unsigned long long trip_cnt;
-	int trip_mask = 0, i;
+	int trip_mask = 0;
 	int ret;
 
 	int34x_thermal_zone = kzalloc(sizeof(*int34x_thermal_zone),
@@ -214,28 +250,8 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 		int34x_thermal_zone->aux_trip_nr = trip_cnt;
 	}
 
-	int34x_thermal_zone->crt_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(adev->handle, "_CRT",
-					     &int34x_thermal_zone->crt_temp))
-		int34x_thermal_zone->crt_trip_id = trip_cnt++;
-	int34x_thermal_zone->hot_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(adev->handle, "_HOT",
-					     &int34x_thermal_zone->hot_temp))
-		int34x_thermal_zone->hot_trip_id = trip_cnt++;
-	int34x_thermal_zone->psv_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(adev->handle, "_PSV",
-					     &int34x_thermal_zone->psv_temp))
-		int34x_thermal_zone->psv_trip_id = trip_cnt++;
-	for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
-		char name[5] = { '_', 'A', 'C', '0' + i, '\0' };
+	trip_cnt = int340x_thermal_read_trips(int34x_thermal_zone);
 
-		if (int340x_thermal_get_trip_config(adev->handle, name,
-				&int34x_thermal_zone->act_trips[i].temp))
-			break;
-
-		int34x_thermal_zone->act_trips[i].id = trip_cnt++;
-		int34x_thermal_zone->act_trips[i].valid = true;
-	}
 	int34x_thermal_zone->lpat_table = acpi_lpat_get_conversion_table(
 								adev->handle);
 
diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
index 65116b1..5f3ba47 100644
--- a/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
+++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
@@ -46,6 +46,7 @@ struct int34x_thermal_zone {
 struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *,
 				struct thermal_zone_device_ops *override_ops);
 void int340x_thermal_zone_remove(struct int34x_thermal_zone *);
+int int340x_thermal_read_trips(struct int34x_thermal_zone *int34x_zone);
 
 static inline void int340x_thermal_zone_set_priv_data(
 			struct int34x_thermal_zone *tzone, void *priv_data)
@@ -60,9 +61,10 @@ static inline void *int340x_thermal_zone_get_priv_data(
 }
 
 static inline void int340x_thermal_zone_device_update(
-			struct int34x_thermal_zone *tzone)
+					struct int34x_thermal_zone *tzone,
+					enum thermal_notify_event event)
 {
-	thermal_zone_device_update(tzone->zone, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_update(tzone->zone, event);
 }
 
 #endif
diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index 42c1ac0..ff3b36f 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -258,7 +258,8 @@ static void proc_thermal_notify(acpi_handle handle, u32 event, void *data)
 	switch (event) {
 	case PROC_POWER_CAPABILITY_CHANGED:
 		proc_thermal_read_ppcc(proc_priv);
-		int340x_thermal_zone_device_update(proc_priv->int340x_zone);
+		int340x_thermal_zone_device_update(proc_priv->int340x_zone,
+				THERMAL_DEVICE_POWER_CAPABILITY_CHANGED);
 		break;
 	default:
 		dev_err(proc_priv->dev, "Unsupported event [0x%x]\n", event);
-- 
2.7.4

