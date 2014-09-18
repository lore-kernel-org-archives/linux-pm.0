From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 06/19] Thermal: int3400 thermal: register to thermal framework
Date: Thu, 18 Sep 2014 09:53:37 +0800
Message-ID: <1411005230-2227-7-git-send-email-rui.zhang@intel.com>
References: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58946 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119AbaIRByZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Sep 2014 21:54:25 -0400
In-Reply-To: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, eduardo.valentin@ti.com, Zhang Rui <rui.zhang@intel.com>

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/Kconfig                           |   1 +
 drivers/thermal/int340x_thermal/int3400_thermal.c | 103 ++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 6f5a87a..b34c5f5 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -237,6 +237,7 @@ config INTEL_SOC_DTS_THERMAL
 config INT340X_THERMAL
 	tristate "ACPI INT340X thermal drivers"
 	depends on X86 && ACPI
+	select THERMAL_GOV_USER_SPACE
 	help
 	  Newer laptops and tablets that use ACPI may have thermal sensors and
 	  other devices with thermal control capabilities outside the core
diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index 65c63ba..9104b4f 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
+#include <linux/thermal.h>
 
 struct art {
 	acpi_handle source;
@@ -60,6 +61,8 @@ static u8 *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] = {
 
 struct int3400_thermal_priv {
 	struct acpi_device *adev;
+	struct thermal_zone_device *thermal;
+	int mode;
 	int art_count;
 	struct art *arts;
 	int trt_count;
@@ -114,6 +117,36 @@ static int int3400_thermal_get_uuids(struct int3400_thermal_priv *priv)
 	return result;
 }
 
+static int int3400_thermal_run_osc(acpi_handle handle,
+				enum int3400_thermal_uuid uuid, bool enable)
+{
+	u32 ret, buf[2];
+	acpi_status status;
+	int result = 0;
+	struct acpi_osc_context context = {
+		.uuid_str = int3400_thermal_uuids[uuid],
+		.rev = 1,
+		.cap.length = 8,
+	};
+
+	buf[OSC_QUERY_DWORD] = 0;
+	buf[OSC_SUPPORT_DWORD] = enable;
+
+	context.cap.pointer = buf;
+
+	status = acpi_run_osc(handle, &context);
+	if (ACPI_SUCCESS(status)) {
+		ret = *((u32 *)(context.ret.pointer + 4));
+		if (ret != enable)
+			result = -EPERM;
+	} else
+		result = -EPERM;
+
+	kfree(context.ret.pointer);
+	return result;
+}
+
+
 static int parse_art(struct int3400_thermal_priv *priv)
 {
 	acpi_handle handle = priv->adev->handle;
@@ -243,6 +276,61 @@ static int parse_trt(struct int3400_thermal_priv *priv)
 	return result;
 }
 
+static int int3400_thermal_get_temp(struct thermal_zone_device *thermal,
+			unsigned long *temp)
+{
+	*temp = 20 * 1000; /* faked temp sensor with 20C */
+	return 0;
+}
+
+static int int3400_thermal_get_mode(struct thermal_zone_device *thermal,
+				enum thermal_device_mode *mode)
+{
+	struct int3400_thermal_priv *priv = thermal->devdata;
+
+	if (!priv)
+		return -EINVAL;
+
+	*mode = priv->mode;
+
+	return 0;
+}
+
+static int int3400_thermal_set_mode(struct thermal_zone_device *thermal,
+				enum thermal_device_mode mode)
+{
+	struct int3400_thermal_priv *priv = thermal->devdata;
+	bool enable;
+	int result = 0;
+
+	if (!priv)
+		return -EINVAL;
+
+	if (mode == THERMAL_DEVICE_ENABLED)
+		enable = true;
+	else if (mode == THERMAL_DEVICE_DISABLED)
+		enable = false;
+	else
+		return -EINVAL;
+
+	if (enable != priv->mode) {
+		priv->mode = enable;
+		/* currently, only PASSIVE COOLING is supported */
+		result = int3400_thermal_run_osc(priv->adev->handle,
+					INT3400_THERMAL_PASSIVE_1, enable);
+	}
+	return result;
+}
+
+static struct thermal_zone_device_ops int3400_thermal_ops = {
+	.get_temp = int3400_thermal_get_temp,
+};
+
+static struct thermal_zone_params int3400_thermal_params = {
+	.governor_name = "user_space",
+	.no_hwmon = true,
+};
+
 static int int3400_thermal_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
@@ -272,7 +360,21 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	if (priv->uuid_bitmap & 1 << INT3400_THERMAL_PASSIVE_1) {
+		int3400_thermal_ops.get_mode = int3400_thermal_get_mode;
+		int3400_thermal_ops.set_mode = int3400_thermal_set_mode;
+	}
+	priv->thermal = thermal_zone_device_register("INT3400 Thermal", 0, 0,
+						priv, &int3400_thermal_ops,
+						&int3400_thermal_params, 0, 0);
+	if (IS_ERR(priv->thermal)) {
+		result = PTR_ERR(priv->thermal);
+		goto free_trt;
+	}
+
 	return 0;
+free_trt:
+	kfree(priv->trts);
 free_art:
 	kfree(priv->arts);
 free_priv:
@@ -284,6 +386,7 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 {
 	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
 
+	thermal_zone_device_unregister(priv->thermal);
 	kfree(priv->trts);
 	kfree(priv->arts);
 	kfree(priv);
-- 
1.8.3.2

