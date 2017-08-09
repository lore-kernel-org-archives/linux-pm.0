From: Brian Bian <brian.bian@linux.intel.com>
Subject: [PATCH v2] thermal: int339x_thermal: process "thermal table changed" event
Date: Wed,  9 Aug 2017 10:53:00 -0700
Message-ID: <1502301180-4325-1-git-send-email-brian.bian@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61088 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752705AbdHIRxH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Aug 2017 13:53:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Brian Bian <brian.bian@linux.intel.com>

Some BIOS implement ACPI notification code 0x83 to indicate active
relationship table(ART) and/or thermal relationship table(TRT) changes
to INT3400 device. This event needs to be propagated to user space so
that it can be handled by the user space thermal daemon.

Signed-off-by: Brian Bian <brian.bian@linux.intel.com>
---
Changes in v2:
  - Directly propagate the event to user space as a uevent instead of
    calling thermal_zone_device_update().

 drivers/thermal/int340x_thermal/int3400_thermal.c | 41 +++++++++++++++++++++++
 include/linux/thermal.h                           |  1 +
 2 files changed, 42 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index a9ec94e..0ba8fe6 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -16,6 +16,8 @@
 #include <linux/thermal.h>
 #include "acpi_thermal_rel.h"
 
+#define INT3400_THERMAL_TABLE_CHANGED 0x83
+
 enum int3400_thermal_uuid {
 	INT3400_THERMAL_PASSIVE_1,
 	INT3400_THERMAL_ACTIVE,
@@ -185,6 +187,35 @@ static int int3400_thermal_run_osc(acpi_handle handle,
 	return result;
 }
 
+static void int3400_notify(acpi_handle handle,
+			u32 event,
+			void *data)
+{
+	struct int3400_thermal_priv *priv = data;
+	char *thermal_prop[5];
+
+	if (!priv)
+		return;
+
+	switch (event) {
+	case INT3400_THERMAL_TABLE_CHANGED:
+		thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s",
+				priv->thermal->type);
+		thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d",
+				priv->thermal->temperature);
+		thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=");
+		thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d",
+				THERMAL_TABLE_CHANGED);
+		thermal_prop[4] = NULL;
+		kobject_uevent_env(&priv->thermal->device.kobj, KOBJ_CHANGE,
+				thermal_prop);
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
@@ -290,6 +321,12 @@ static int int3400_thermal_probe(struct platform_device *pdev)
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
@@ -306,6 +343,10 @@ static int int3400_thermal_remove(struct platform_device *pdev)
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
