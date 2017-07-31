From: Brian Bian <brian.bian@intel.com>
Subject: [PATCH] thermal: int340x_thermal: process "thermal table changed" event
Date: Mon, 31 Jul 2017 16:09:15 -0700
Message-ID: <1501542555-3906-1-git-send-email-brian.bian@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20013 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbdGaXJL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 31 Jul 2017 19:09:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Brian Bian <brian.bian@intel.com>

Some BIOS implement ACPI notification code 0x83 to indicate active
relationship table(ART) and/or thermal relationship table(TRT) changes
to INT3400 device. This event needs to be propagated to user space so
that it can be handled by the user space thermal daemon.

In order to propagate the event using standard
thermal_zone_device_update() call, a fake passive trip point is added
to INT3400 thermal zone.

Signed-off-by: Brian Bian <brian.bian@intel.com>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 61 ++++++++++++++++++++++-
 include/linux/thermal.h                           |  1 +
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index a9ec94e..3a0f4ae 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -16,6 +16,16 @@
 #include <linux/thermal.h>
 #include "acpi_thermal_rel.h"
 
+#define INT3400_FAKE_TEMP (20 * 1000) /* faked temp sensor with 20C */
+
+/*
+ * To support thermal table change notification, we add a fake trip point
+ * as well, so that the event can be propagated to user space through the
+ * thermal_zone_device_update() call.
+ */
+#define INT3400_THERMAL_TABLE_CHANGED 0x83
+#define INT3400_FAKE_TRIP_COUNT 1
+
 enum int3400_thermal_uuid {
 	INT3400_THERMAL_PASSIVE_1,
 	INT3400_THERMAL_ACTIVE,
@@ -185,10 +195,45 @@ static int int3400_thermal_run_osc(acpi_handle handle,
 	return result;
 }
 
+static void int3400_notify(acpi_handle handle,
+			u32 event,
+			void *data)
+{
+	struct int3400_thermal_priv *priv = data;
+
+	if (!priv)
+		return;
+
+	switch (event) {
+	case INT3400_THERMAL_TABLE_CHANGED:
+		thermal_zone_device_update(priv->thermal, THERMAL_TABLE_CHANGED);
+		break;
+	default:
+		dev_err(&priv->adev->dev, "Unsupported event [0x%x]\n", event);
+		break;
+	}
+}
+
 static int int3400_thermal_get_temp(struct thermal_zone_device *thermal,
 			int *temp)
 {
-	*temp = 20 * 1000; /* faked temp sensor with 20C */
+	*temp = INT3400_FAKE_TEMP;
+	return 0;
+}
+
+static int int3400_thermal_get_trip_temp(struct thermal_zone_device *thermal,
+			int trip,
+			int *temp)
+{
+	*temp = INT3400_FAKE_TEMP + 1;
+	return 0;
+}
+
+static int int3400_thermal_get_trip_type(struct thermal_zone_device *thermal,
+			int trip,
+			enum thermal_trip_type *type)
+{
+	*type = THERMAL_TRIP_PASSIVE;
 	return 0;
 }
 
@@ -233,6 +278,8 @@ static int int3400_thermal_set_mode(struct thermal_zone_device *thermal,
 
 static struct thermal_zone_device_ops int3400_thermal_ops = {
 	.get_temp = int3400_thermal_get_temp,
+	.get_trip_temp = int3400_thermal_get_trip_temp,
+	.get_trip_type = int3400_thermal_get_trip_type,
 };
 
 static struct thermal_zone_params int3400_thermal_params = {
@@ -275,7 +322,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 		int3400_thermal_ops.get_mode = int3400_thermal_get_mode;
 		int3400_thermal_ops.set_mode = int3400_thermal_set_mode;
 	}
-	priv->thermal = thermal_zone_device_register("INT3400 Thermal", 0, 0,
+	priv->thermal = thermal_zone_device_register("INT3400 Thermal", 1, 1,
 						priv, &int3400_thermal_ops,
 						&int3400_thermal_params, 0, 0);
 	if (IS_ERR(priv->thermal)) {
@@ -290,6 +337,12 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (result)
 		goto free_zone;
 
+	result = acpi_install_notify_handler(
+			priv->adev->handle, ACPI_DEVICE_NOTIFY, int3400_notify,
+			(void *)priv);
+	if (result)
+		goto free_zone;
+
 	return 0;
 
 free_zone:
@@ -306,6 +359,10 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 {
 	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
 
+	acpi_remove_notify_handler(
+			priv->adev->handle, ACPI_DEVICE_NOTIFY,
+			int3400_notify);
+
 	if (!priv->rel_misc_dev_res)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index dab11f9..fd5b959 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -102,6 +102,7 @@ enum thermal_notify_event {
 	THERMAL_DEVICE_DOWN, /* Thermal device is down */
 	THERMAL_DEVICE_UP, /* Thermal device is up after a down event */
 	THERMAL_DEVICE_POWER_CAPABILITY_CHANGED, /* power capability changed */
+	THERMAL_TABLE_CHANGED, /* Thermal table(s) changed */
 };
 
 struct thermal_zone_device_ops {
-- 
2.7.4
