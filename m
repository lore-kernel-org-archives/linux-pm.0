From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 17/19] Thermal: int3400_thermal: use acpi_thermal_rel parsing APIs
Date: Thu, 18 Sep 2014 09:53:48 +0800
Message-ID: <1411005230-2227-18-git-send-email-rui.zhang@intel.com>
References: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, eduardo.valentin@ti.com, Jacob Pan <jacob.jun.pan@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

ACPI _TRT and _ART parsing code has been moved to acpi_thermal_rel such
that it can be used by other devices in the future. Use the parsing APIs
in acpi_thermal_rel.c instead.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 172 ++--------------------
 1 file changed, 13 insertions(+), 159 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index 9104b4f..edc1cce 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -14,33 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
 #include <linux/thermal.h>
-
-struct art {
-	acpi_handle source;
-	acpi_handle target;
-	u64 weight;
-	u64 ac0_max;
-	u64 ac1_max;
-	u64 ac2_max;
-	u64 ac3_max;
-	u64 ac4_max;
-	u64 ac5_max;
-	u64 ac6_max;
-	u64 ac7_max;
-	u64 ac8_max;
-	u64 ac9_max;
-};
-
-struct trt {
-	acpi_handle source;
-	acpi_handle target;
-	u64 influence;
-	u64 sampling_period;
-	u64 reverved1;
-	u64 reverved2;
-	u64 reverved3;
-	u64 reverved4;
-};
+#include "acpi_thermal_rel.h"
 
 enum int3400_thermal_uuid {
 	INT3400_THERMAL_PASSIVE_1,
@@ -68,6 +42,7 @@ struct int3400_thermal_priv {
 	int trt_count;
 	struct trt *trts;
 	u8 uuid_bitmap;
+	int rel_misc_dev_res;
 };
 
 static int int3400_thermal_get_uuids(struct int3400_thermal_priv *priv)
@@ -146,136 +121,6 @@ static int int3400_thermal_run_osc(acpi_handle handle,
 	return result;
 }
 
-
-static int parse_art(struct int3400_thermal_priv *priv)
-{
-	acpi_handle handle = priv->adev->handle;
-	acpi_status status;
-	int result = 0;
-	int i;
-	struct acpi_device *adev;
-	union acpi_object *p;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_buffer element = { 0, NULL };
-	struct acpi_buffer art_format = {
-				sizeof("RRNNNNNNNNNNN"), "RRNNNNNNNNNNN" };
-
-	if (!acpi_has_method(handle, "_ART"))
-		return 0;
-
-	status = acpi_evaluate_object(handle, "_ART", NULL, &buffer);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	p = buffer.pointer;
-	if (!p || (p->type != ACPI_TYPE_PACKAGE)) {
-		pr_err("Invalid _ART data\n");
-		result = -EFAULT;
-		goto end;
-	}
-
-	/* ignore p->package.elements[0], as this is _ART Revision field */
-	priv->art_count = p->package.count - 1;
-	priv->arts = kzalloc(sizeof(struct art) * priv->art_count, GFP_KERNEL);
-	if (!priv->arts) {
-		result = -ENOMEM;
-		goto end;
-	}
-
-	for (i = 0; i < priv->art_count; i++) {
-		struct art *art = &(priv->arts[i]);
-
-		element.length = sizeof(struct art);
-		element.pointer = art;
-
-		status = acpi_extract_package(&(p->package.elements[i + 1]),
-					      &art_format, &element);
-		if (ACPI_FAILURE(status)) {
-			pr_err("Invalid _ART data");
-			result = -EFAULT;
-			kfree(priv->arts);
-			goto end;
-		}
-		result = acpi_bus_get_device(art->source, &adev);
-		if (!result)
-			acpi_create_platform_device(adev, NULL);
-		else
-			pr_warn("Failed to get source ACPI device\n");
-		result = acpi_bus_get_device(art->target, &adev);
-		if (!result)
-			acpi_create_platform_device(adev, NULL);
-		else
-			pr_warn("Failed to get source ACPI device\n");
-	}
-end:
-	kfree(buffer.pointer);
-	return result;
-}
-
-static int parse_trt(struct int3400_thermal_priv *priv)
-{
-	acpi_handle handle = priv->adev->handle;
-	acpi_status status;
-	int result = 0;
-	int i;
-	struct acpi_device *adev;
-	union acpi_object *p;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_buffer element = { 0, NULL };
-	struct acpi_buffer trt_format = { sizeof("RRNNNNNN"), "RRNNNNNN" };
-
-	if (!acpi_has_method(handle, "_TRT"))
-		return 0;
-
-	status = acpi_evaluate_object(handle, "_TRT", NULL, &buffer);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	p = buffer.pointer;
-	if (!p || (p->type != ACPI_TYPE_PACKAGE)) {
-		pr_err("Invalid _TRT data\n");
-		result = -EFAULT;
-		goto end;
-	}
-
-	priv->trt_count = p->package.count;
-	priv->trts = kzalloc(sizeof(struct trt) * priv->trt_count, GFP_KERNEL);
-	if (!priv->trts) {
-		result = -ENOMEM;
-		goto end;
-	}
-
-	for (i = 0; i < priv->trt_count; i++) {
-		struct trt *trt = &(priv->trts[i]);
-
-		element.length = sizeof(struct trt);
-		element.pointer = trt;
-
-		status = acpi_extract_package(&(p->package.elements[i]),
-					      &trt_format, &element);
-		if (ACPI_FAILURE(status)) {
-			pr_err("Invalid _ART data");
-			result = -EFAULT;
-			kfree(priv->trts);
-			goto end;
-		}
-
-		result = acpi_bus_get_device(trt->source, &adev);
-		if (!result)
-			acpi_create_platform_device(adev, NULL);
-		else
-			pr_warn("Failed to get source ACPI device\n");
-		result = acpi_bus_get_device(trt->target, &adev);
-		if (!result)
-			acpi_create_platform_device(adev, NULL);
-		else
-			pr_warn("Failed to get target ACPI device\n");
-	}
-end:
-	kfree(buffer.pointer);
-	return result;
-}
-
 static int int3400_thermal_get_temp(struct thermal_zone_device *thermal,
 			unsigned long *temp)
 {
@@ -350,11 +195,14 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (result)
 		goto free_priv;
 
-	result = parse_art(priv);
+	result = acpi_parse_art(priv->adev->handle, &priv->art_count,
+				&priv->arts, true);
 	if (result)
 		goto free_priv;
 
-	result = parse_trt(priv);
+
+	result = acpi_parse_trt(priv->adev->handle, &priv->trt_count,
+				&priv->trts, true);
 	if (result)
 		goto free_art;
 
@@ -372,6 +220,9 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 		goto free_trt;
 	}
 
+	priv->rel_misc_dev_res = acpi_thermal_rel_misc_device_add(
+							priv->adev->handle);
+
 	return 0;
 free_trt:
 	kfree(priv->trts);
@@ -386,6 +237,9 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 {
 	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
 
+	if (!priv->rel_misc_dev_res)
+		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
+
 	thermal_zone_device_unregister(priv->thermal);
 	kfree(priv->trts);
 	kfree(priv->arts);
-- 
1.8.3.2

