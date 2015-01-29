From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] Thermal/int3400 thermal: support _ART/_TRT change event
Date: Thu, 29 Jan 2015 21:04:52 +0800
Message-ID: <1422536692-18632-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48305 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755582AbbA2NFH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 29 Jan 2015 08:05:07 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, rui.zhang@intel.com

In some cases, the _ART/_TRT data may be changed at runtime, and
ACPI notification 0x83/0x84 will be delivered to INT3400 ACPI device object
when this happens.
Add this support in int3400_thermal driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 54 ++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index 25d244c..3780b39 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -16,6 +16,9 @@
 #include <linux/thermal.h>
 #include "acpi_thermal_rel.h"
 
+#define INT3400_THERMAL_ART_CHANGED	0x83
+#define INT3400_THERMAL_TRT_CHANGED	0x84
+
 enum int3400_thermal_uuid {
 	INT3400_THERMAL_PASSIVE_1,
 	INT3400_THERMAL_ACTIVE,
@@ -240,6 +243,42 @@ static struct thermal_zone_params int3400_thermal_params = {
 	.no_hwmon = true,
 };
 
+static void int3400_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct platform_device *pdev = data;
+	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
+	int count;
+	struct art *arts;
+	struct trt *trts;
+	int result;
+
+	if (!priv)
+		return;
+
+	switch (event) {
+	case INT3400_THERMAL_ART_CHANGED:
+		result = acpi_parse_art(priv->adev->handle, &count,
+					&arts, false);
+		if (result)
+			return;
+		priv->art_count = count;
+		priv->arts = arts;
+		kobject_uevent(&pdev->dev.kobj, KOBJ_CHANGE);
+		return;
+	case INT3400_THERMAL_TRT_CHANGED:
+		result = acpi_parse_trt(priv->adev->handle, &count,
+					&trts, false);
+		if (result)
+			return;
+		priv->trt_count = count;
+		priv->trts = trts;
+		kobject_uevent(&pdev->dev.kobj, KOBJ_CHANGE);
+		return;
+	default:
+		return;
+	}
+}
+
 static int int3400_thermal_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
@@ -287,13 +326,22 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	priv->rel_misc_dev_res = acpi_thermal_rel_misc_device_add(
 							priv->adev->handle);
 
+        result = acpi_install_notify_handler(priv->adev->handle,
+			ACPI_DEVICE_NOTIFY, int3400_notify, (void *)pdev);
+	if (result)
+		goto free_misc;
+
 	result = sysfs_create_group(&pdev->dev.kobj, &uuid_attribute_group);
 	if (result)
-		goto free_zone;
+		goto free_notify;
 
 	return 0;
 
-free_zone:
+free_notify:
+	acpi_remove_notify_handler(priv->adev->handle, ACPI_DEVICE_NOTIFY,
+				   int3400_notify);
+free_misc:
+	acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 	thermal_zone_device_unregister(priv->thermal);
 free_trt:
 	kfree(priv->trts);
@@ -311,6 +359,8 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 	if (!priv->rel_misc_dev_res)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 
+	acpi_remove_notify_handler(priv->adev->handle, ACPI_DEVICE_NOTIFY,
+				   int3400_notify);
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
 	thermal_zone_device_unregister(priv->thermal);
 	kfree(priv->trts);
-- 
1.9.1

