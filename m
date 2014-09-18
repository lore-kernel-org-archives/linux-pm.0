From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 04/19] Thermal: introduce int3400 thermal driver
Date: Thu, 18 Sep 2014 09:53:35 +0800
Message-ID: <1411005230-2227-5-git-send-email-rui.zhang@intel.com>
References: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5126 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071AbaIRByV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Sep 2014 21:54:21 -0400
In-Reply-To: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, eduardo.valentin@ti.com, Zhang Rui <rui.zhang@intel.com>

Introduce int3400 thermal driver. And make INT3400 driver
enumerate the other int340x thermal components shown in _ART/_TRT.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/int340x_thermal.c                    |   2 +-
 drivers/thermal/Kconfig                           |   2 +-
 drivers/thermal/Makefile                          |   1 +
 drivers/thermal/int340x_thermal/Makefile          |   1 +
 drivers/thermal/int340x_thermal/int3400_thermal.c | 245 ++++++++++++++++++++++
 5 files changed, 249 insertions(+), 2 deletions(-)
 create mode 100644 drivers/thermal/int340x_thermal/Makefile
 create mode 100644 drivers/thermal/int340x_thermal/int3400_thermal.c

diff --git a/drivers/acpi/int340x_thermal.c b/drivers/acpi/int340x_thermal.c
index 2103bb6..a27d31d 100644
--- a/drivers/acpi/int340x_thermal.c
+++ b/drivers/acpi/int340x_thermal.c
@@ -33,7 +33,7 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 static int int340x_thermal_handler_attach(struct acpi_device *adev,
 					const struct acpi_device_id *id)
 {
-#ifdef CONFIG_INT340X_THERMAL
+#if defined(CONFIG_INT340X_THERMAL) || defined(CONFIG_INT340X_THERMAL_MODULE)
 	if (id->driver_data == DO_ENUMERATION)
 		acpi_create_platform_device(adev);
 #endif
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 2ff7416..6f5a87a 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -235,7 +235,7 @@ config INTEL_SOC_DTS_THERMAL
 	  was set by the driver based on the TJ MAX temperature.
 
 config INT340X_THERMAL
-	bool
+	tristate "ACPI INT340X thermal drivers"
 	depends on X86 && ACPI
 	help
 	  Newer laptops and tablets that use ACPI may have thermal sensors and
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 31e232f..216503e 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -32,4 +32,5 @@ obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+= x86_pkg_temp_thermal.o
 obj-$(CONFIG_INTEL_SOC_DTS_THERMAL)	+= intel_soc_dts_thermal.o
 obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
 obj-$(CONFIG_ACPI_INT3403_THERMAL)	+= int3403_thermal.o
+obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
 obj-$(CONFIG_ST_THERMAL)	+= st/
diff --git a/drivers/thermal/int340x_thermal/Makefile b/drivers/thermal/int340x_thermal/Makefile
new file mode 100644
index 0000000..e10a53b
--- /dev/null
+++ b/drivers/thermal/int340x_thermal/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_INT340X_THERMAL)	+= int3400_thermal.o
diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
new file mode 100644
index 0000000..308c185
--- /dev/null
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -0,0 +1,245 @@
+/*
+ * INT3400 thermal driver
+ *
+ * Copyright (C) 2014, Intel Corporation
+ * Authors: Zhang Rui <rui.zhang@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+
+struct art {
+	acpi_handle source;
+	acpi_handle target;
+	u64 weight;
+	u64 ac0_max;
+	u64 ac1_max;
+	u64 ac2_max;
+	u64 ac3_max;
+	u64 ac4_max;
+	u64 ac5_max;
+	u64 ac6_max;
+	u64 ac7_max;
+	u64 ac8_max;
+	u64 ac9_max;
+};
+
+struct trt {
+	acpi_handle source;
+	acpi_handle target;
+	u64 influence;
+	u64 sampling_period;
+	u64 reverved1;
+	u64 reverved2;
+	u64 reverved3;
+	u64 reverved4;
+};
+
+struct int3400_thermal_priv {
+	struct acpi_device *adev;
+	int art_count;
+	struct art *arts;
+	int trt_count;
+	struct trt *trts;
+};
+
+static int parse_art(struct int3400_thermal_priv *priv)
+{
+	acpi_handle handle = priv->adev->handle;
+	acpi_status status;
+	int result = 0;
+	int i;
+	struct acpi_device *adev;
+	union acpi_object *p;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer element = { 0, NULL };
+	struct acpi_buffer art_format = {
+				sizeof("RRNNNNNNNNNNN"), "RRNNNNNNNNNNN" };
+
+	if (!acpi_has_method(handle, "_ART"))
+		return 0;
+
+	status = acpi_evaluate_object(handle, "_ART", NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	p = buffer.pointer;
+	if (!p || (p->type != ACPI_TYPE_PACKAGE)) {
+		pr_err("Invalid _ART data\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	/* ignore p->package.elements[0], as this is _ART Revision field */
+	priv->art_count = p->package.count - 1;
+	priv->arts = kzalloc(sizeof(struct art) * priv->art_count, GFP_KERNEL);
+	if (!priv->arts) {
+		result = -ENOMEM;
+		goto end;
+	}
+
+	for (i = 0; i < priv->art_count; i++) {
+		struct art *art = &(priv->arts[i]);
+
+		element.length = sizeof(struct art);
+		element.pointer = art;
+
+		status = acpi_extract_package(&(p->package.elements[i + 1]),
+					      &art_format, &element);
+		if (ACPI_FAILURE(status)) {
+			pr_err("Invalid _ART data");
+			result = -EFAULT;
+			kfree(priv->arts);
+			goto end;
+		}
+		result = acpi_bus_get_device(art->source, &adev);
+		if (!result)
+			acpi_create_platform_device(adev, NULL);
+		else
+			pr_warn("Failed to get source ACPI device\n");
+		result = acpi_bus_get_device(art->target, &adev);
+		if (!result)
+			acpi_create_platform_device(adev, NULL);
+		else
+			pr_warn("Failed to get source ACPI device\n");
+	}
+end:
+	kfree(buffer.pointer);
+	return result;
+}
+
+static int parse_trt(struct int3400_thermal_priv *priv)
+{
+	acpi_handle handle = priv->adev->handle;
+	acpi_status status;
+	int result = 0;
+	int i;
+	struct acpi_device *adev;
+	union acpi_object *p;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer element = { 0, NULL };
+	struct acpi_buffer trt_format = { sizeof("RRNNNNNN"), "RRNNNNNN" };
+
+	if (!acpi_has_method(handle, "_TRT"))
+		return 0;
+
+	status = acpi_evaluate_object(handle, "_TRT", NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	p = buffer.pointer;
+	if (!p || (p->type != ACPI_TYPE_PACKAGE)) {
+		pr_err("Invalid _TRT data\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	priv->trt_count = p->package.count;
+	priv->trts = kzalloc(sizeof(struct trt) * priv->trt_count, GFP_KERNEL);
+	if (!priv->trts) {
+		result = -ENOMEM;
+		goto end;
+	}
+
+	for (i = 0; i < priv->trt_count; i++) {
+		struct trt *trt = &(priv->trts[i]);
+
+		element.length = sizeof(struct trt);
+		element.pointer = trt;
+
+		status = acpi_extract_package(&(p->package.elements[i]),
+					      &trt_format, &element);
+		if (ACPI_FAILURE(status)) {
+			pr_err("Invalid _ART data");
+			result = -EFAULT;
+			kfree(priv->trts);
+			goto end;
+		}
+
+		result = acpi_bus_get_device(trt->source, &adev);
+		if (!result)
+			acpi_create_platform_device(adev, NULL);
+		else
+			pr_warn("Failed to get source ACPI device\n");
+		result = acpi_bus_get_device(trt->target, &adev);
+		if (!result)
+			acpi_create_platform_device(adev, NULL);
+		else
+			pr_warn("Failed to get target ACPI device\n");
+	}
+end:
+	kfree(buffer.pointer);
+	return result;
+}
+
+static int int3400_thermal_probe(struct platform_device *pdev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	struct int3400_thermal_priv *priv;
+	int result;
+
+	if (!adev)
+		return -ENODEV;
+
+	priv = kzalloc(sizeof(struct int3400_thermal_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->adev = adev;
+
+	result = parse_art(priv);
+	if (result)
+		goto free_priv;
+
+	result = parse_trt(priv);
+	if (result)
+		goto free_art;
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+free_art:
+	kfree(priv->arts);
+free_priv:
+	kfree(priv);
+	return result;
+}
+
+static int int3400_thermal_remove(struct platform_device *pdev)
+{
+	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
+
+	kfree(priv->trts);
+	kfree(priv->arts);
+	kfree(priv);
+	return 0;
+}
+
+static const struct acpi_device_id int3400_thermal_match[] = {
+	{"INT3400", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(acpi, int3400_thermal_match);
+
+static struct platform_driver int3400_thermal_driver = {
+	.probe = int3400_thermal_probe,
+	.remove = int3400_thermal_remove,
+	.driver = {
+		   .name = "int3400 thermal",
+		   .owner = THIS_MODULE,
+		   .acpi_match_table = ACPI_PTR(int3400_thermal_match),
+		   },
+};
+
+module_platform_driver(int3400_thermal_driver);
+
+MODULE_DESCRIPTION("INT3400 Thermal driver");
+MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
+MODULE_LICENSE("GPL");
-- 
1.8.3.2

