From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] ACPI/int340x_thermal: enumerate INT340X devices even if they're not in _ART/_TRT
Date: Sun,  4 Jan 2015 14:24:23 +0800
Message-ID: <1420352664-20808-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:30848 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbbADGYr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 4 Jan 2015 01:24:47 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, rui.zhang@intel.com

For some INT340X thermal devices, even if they are not referred in
_TRT/_ART table, they still can be used by userspace for thermal control.
Thus change the code to enumerated all the INT340X devices,
no matter if they're referred in _TRT/_ART or not.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/int340x_thermal.c                     |  6 ++----
 drivers/thermal/int340x_thermal/acpi_thermal_rel.c | 16 ++++------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/int340x_thermal.c b/drivers/acpi/int340x_thermal.c
index a27d31d..dc3553d 100644
--- a/drivers/acpi/int340x_thermal.c
+++ b/drivers/acpi/int340x_thermal.c
@@ -14,9 +14,8 @@
 
 #include "internal.h"
 
-#define DO_ENUMERATION 0x01
 static const struct acpi_device_id int340x_thermal_device_ids[] = {
-	{"INT3400", DO_ENUMERATION },
+	{"INT3400"},
 	{"INT3401"},
 	{"INT3402"},
 	{"INT3403"},
@@ -34,8 +33,7 @@ static int int340x_thermal_handler_attach(struct acpi_device *adev,
 					const struct acpi_device_id *id)
 {
 #if defined(CONFIG_INT340X_THERMAL) || defined(CONFIG_INT340X_THERMAL_MODULE)
-	if (id->driver_data == DO_ENUMERATION)
-		acpi_create_platform_device(adev);
+	acpi_create_platform_device(adev);
 #endif
 	return 1;
 }
diff --git a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
index 231cabc..2c2ec76 100644
--- a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
@@ -119,15 +119,11 @@ int acpi_parse_trt(acpi_handle handle, int *trt_count, struct trt **trtp,
 			continue;
 
 		result = acpi_bus_get_device(trt->source, &adev);
-		if (!result)
-			acpi_create_platform_device(adev);
-		else
+		if (result)
 			pr_warn("Failed to get source ACPI device\n");
 
 		result = acpi_bus_get_device(trt->target, &adev);
-		if (!result)
-			acpi_create_platform_device(adev);
-		else
+		if (result)
 			pr_warn("Failed to get target ACPI device\n");
 	}
 
@@ -206,16 +202,12 @@ int acpi_parse_art(acpi_handle handle, int *art_count, struct art **artp,
 
 		if (art->source) {
 			result = acpi_bus_get_device(art->source, &adev);
-			if (!result)
-				acpi_create_platform_device(adev);
-			else
+			if (result)
 				pr_warn("Failed to get source ACPI device\n");
 		}
 		if (art->target) {
 			result = acpi_bus_get_device(art->target, &adev);
-			if (!result)
-				acpi_create_platform_device(adev);
-			else
+			if (result)
 				pr_warn("Failed to get source ACPI device\n");
 		}
 	}
-- 
1.9.1

