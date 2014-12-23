From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] Thermal/int340x/int3402: Provide notification support
Date: Tue, 23 Dec 2014 15:29:57 -0800
Message-ID: <1419377397-13983-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53228 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411AbaLWXai (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Dec 2014 18:30:38 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This driver supports programmable trips, but didn't register
notification handler to receive threshold violation notification.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/int3402_thermal.c | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/int3402_thermal.c b/drivers/thermal/int340x_thermal/int3402_thermal.c
index 2f65db2..fcb2af1 100644
--- a/drivers/thermal/int340x_thermal/int3402_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3402_thermal.c
@@ -16,15 +16,37 @@
 #include <linux/thermal.h>
 #include "int340x_thermal_zone.h"
 
+#define INT3402_PERF_CHANGED_EVENT	0x80
+#define INT3402_THERMAL_EVENT		0x90
+
 struct int3402_thermal_data {
 	acpi_handle *handle;
 	struct int34x_thermal_zone *int340x_zone;
 };
 
+static void int3402_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct int3402_thermal_data *priv = data;
+
+	if (!priv)
+		return;
+
+	switch (event) {
+	case INT3402_PERF_CHANGED_EVENT:
+		break;
+	case INT3402_THERMAL_EVENT:
+		int340x_thermal_zone_device_update(priv->int340x_zone);
+		break;
+	default:
+		break;
+	}
+}
+
 static int int3402_thermal_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	struct int3402_thermal_data *d;
+	int ret;
 
 	if (!acpi_has_method(adev->handle, "_TMP"))
 		return -ENODEV;
@@ -37,6 +59,15 @@ static int int3402_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(d->int340x_zone))
 		return PTR_ERR(d->int340x_zone);
 
+	ret = acpi_install_notify_handler(adev->handle,
+					  ACPI_DEVICE_NOTIFY,
+					  int3402_notify,
+					  d);
+	if (ret) {
+		int340x_thermal_zone_remove(d->int340x_zone);
+		return ret;
+	}
+
 	d->handle = adev->handle;
 	platform_set_drvdata(pdev, d);
 
@@ -47,6 +78,8 @@ static int int3402_thermal_remove(struct platform_device *pdev)
 {
 	struct int3402_thermal_data *d = platform_get_drvdata(pdev);
 
+	acpi_remove_notify_handler(d->handle,
+				   ACPI_DEVICE_NOTIFY, int3402_notify);
 	int340x_thermal_zone_remove(d->int340x_zone);
 
 	return 0;
-- 
1.9.3

