From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 11/19] ACPI / Fan: add ACPI 4.0 style fan support
Date: Thu, 18 Sep 2014 09:53:42 +0800
Message-ID: <1411005230-2227-12-git-send-email-rui.zhang@intel.com>
References: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46477 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932165AbaIRByi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Sep 2014 21:54:38 -0400
In-Reply-To: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, eduardo.valentin@ti.com, Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Aaron Lu <aaron.lu@intel.com>

This patch adds support for ACPI 4.0 style fan, lacking part is: no
support for 'Low Speed Notification Support', 'Fine Grain Control' is
not used yet.

It's not clear what to do on suspend/resume callback for 4.0 style ACPI
fan, so it does nothing for now.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/fan.c | 268 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 241 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 8a5b450..f7d1c80 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -31,6 +31,7 @@
 #include <linux/thermal.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
+#include <linux/sort.h>
 
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Fan Driver");
@@ -59,6 +60,29 @@ static struct dev_pm_ops acpi_fan_pm = {
 #define FAN_PM_OPS_PTR NULL
 #endif
 
+struct acpi_fan_fps {
+	u64 control;
+	u64 trip_point;
+	u64 speed;
+	u64 noise_level;
+	u64 power;
+};
+
+struct acpi_fan_fif {
+	u64 revision;
+	u64 fine_grain_ctrl;
+	u64 step_size;
+	u64 low_speed_notification;
+};
+
+struct acpi_fan {
+	bool acpi4;
+	struct acpi_fan_fif fif;
+	struct acpi_fan_fps *fps;
+	int fps_count;
+	struct thermal_cooling_device *cdev;
+};
+
 static struct platform_driver acpi_fan_driver = {
 	.probe = acpi_fan_probe,
 	.remove = acpi_fan_remove,
@@ -73,21 +97,62 @@ static struct platform_driver acpi_fan_driver = {
 static int fan_get_max_state(struct thermal_cooling_device *cdev, unsigned long
 			     *state)
 {
-	/* ACPI fan device only support two states: ON/OFF */
-	*state = 1;
+	struct acpi_device *device = cdev->devdata;
+	struct acpi_fan *fan = acpi_driver_data(device);
+
+	if (fan->acpi4)
+		*state = fan->fps_count - 1;
+	else
+		*state = 1;
 	return 0;
 }
 
-static int fan_get_cur_state(struct thermal_cooling_device *cdev, unsigned long
-			     *state)
+static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_fan *fan = acpi_driver_data(device);
+	union acpi_object *obj;
+	acpi_status status;
+	int control, i;
+
+	status = acpi_evaluate_object(device->handle, "_FST", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&device->dev, "Get fan state failed\n");
+		return status;
+	}
+
+	obj = buffer.pointer;
+	if (!obj || obj->type != ACPI_TYPE_PACKAGE ||
+	    obj->package.count != 3 ||
+	    obj->package.elements[1].type != ACPI_TYPE_INTEGER) {
+		dev_err(&device->dev, "Invalid _FST data\n");
+		status = -EINVAL;
+		goto err;
+	}
+
+	control = obj->package.elements[1].integer.value;
+	for (i = 0; i < fan->fps_count; i++) {
+		if (control == fan->fps[i].control)
+			break;
+	}
+	if (i == fan->fps_count) {
+		dev_dbg(&device->dev, "Invalid control value returned\n");
+		status = -EINVAL;
+		goto err;
+	}
+
+	*state = i;
+
+err:
+	kfree(obj);
+	return status;
+}
+
+static int fan_get_state(struct acpi_device *device, unsigned long *state)
 {
-	struct acpi_device *device = cdev->devdata;
 	int result;
 	int acpi_state = ACPI_STATE_D0;
 
-	if (!device)
-		return -EINVAL;
-
 	result = acpi_device_update_power(device, &acpi_state);
 	if (result)
 		return result;
@@ -97,21 +162,57 @@ static int fan_get_cur_state(struct thermal_cooling_device *cdev, unsigned long
 	return 0;
 }
 
-static int
-fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
+static int fan_get_cur_state(struct thermal_cooling_device *cdev, unsigned long
+			     *state)
 {
 	struct acpi_device *device = cdev->devdata;
-	int result;
+	struct acpi_fan *fan = acpi_driver_data(device);
+
+	if (fan->acpi4)
+		return fan_get_state_acpi4(device, state);
+	else
+		return fan_get_state(device, state);
+}
 
-	if (!device || (state != 0 && state != 1))
+static int fan_set_state(struct acpi_device *device, unsigned long state)
+{
+	if (state != 0 && state != 1)
 		return -EINVAL;
 
-	result = acpi_device_set_power(device,
-				state ? ACPI_STATE_D0 : ACPI_STATE_D3_COLD);
+	return acpi_device_set_power(device,
+				     state ? ACPI_STATE_D0 : ACPI_STATE_D3_COLD);
+}
 
-	return result;
+static int fan_set_state_acpi4(struct acpi_device *device, unsigned long state)
+{
+	struct acpi_fan *fan = acpi_driver_data(device);
+	acpi_status status;
+
+	if (state >= fan->fps_count)
+		return -EINVAL;
+
+	status = acpi_execute_simple_method(device->handle, "_FSL",
+					    fan->fps[state].control);
+	if (ACPI_FAILURE(status)) {
+		dev_dbg(&device->dev, "Failed to set state by _FSL\n");
+		return status;
+	}
+
+	return 0;
 }
 
+static int
+fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
+{
+	struct acpi_device *device = cdev->devdata;
+	struct acpi_fan *fan = acpi_driver_data(device);
+
+	if (fan->acpi4)
+		return fan_set_state_acpi4(device, state);
+	else
+		return fan_set_state(device, state);
+ }
+
 static const struct thermal_cooling_device_ops fan_cooling_ops = {
 	.get_max_state = fan_get_max_state,
 	.get_cur_state = fan_get_cur_state,
@@ -122,16 +223,125 @@ static const struct thermal_cooling_device_ops fan_cooling_ops = {
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
+static bool acpi_fan_is_acpi4(struct acpi_device *device)
+{
+	return acpi_has_method(device->handle, "_FIF") &&
+	       acpi_has_method(device->handle, "_FPS") &&
+	       acpi_has_method(device->handle, "_FSL") &&
+	       acpi_has_method(device->handle, "_FST");
+}
+
+static int acpi_fan_get_fif(struct acpi_device *device)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_fan *fan = acpi_driver_data(device);
+	struct acpi_buffer format = { sizeof("NNNN"), "NNNN" };
+	struct acpi_buffer fif = { sizeof(fan->fif), &fan->fif };
+	union acpi_object *obj;
+	acpi_status status;
+
+	status = acpi_evaluate_object(device->handle, "_FIF", NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	obj = buffer.pointer;
+	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
+		dev_err(&device->dev, "Invalid _FIF data\n");
+		status = -EINVAL;
+		goto err;
+	}
+
+	status = acpi_extract_package(obj, &format, &fif);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&device->dev, "Invalid _FIF element\n");
+		status = -EINVAL;
+	}
+
+err:
+	kfree(obj);
+	return status;
+}
+
+static int acpi_fan_speed_cmp(const void *a, const void *b)
+{
+	const struct acpi_fan_fps *fps1 = a;
+	const struct acpi_fan_fps *fps2 = b;
+	return fps1->speed - fps2->speed;
+}
+
+static int acpi_fan_get_fps(struct acpi_device *device)
+{
+	struct acpi_fan *fan = acpi_driver_data(device);
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+	int i;
+
+	status = acpi_evaluate_object(device->handle, "_FPS", NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	obj = buffer.pointer;
+	if (!obj || obj->type != ACPI_TYPE_PACKAGE || obj->package.count < 2) {
+		dev_err(&device->dev, "Invalid _FPS data\n");
+		status = -EINVAL;
+		goto err;
+	}
+
+	fan->fps_count = obj->package.count - 1; /* minus revision field */
+	fan->fps = devm_kzalloc(&device->dev,
+				fan->fps_count * sizeof(struct acpi_fan_fps),
+				GFP_KERNEL);
+	if (!fan->fps) {
+		dev_err(&device->dev, "Not enough memory\n");
+		status = -ENOMEM;
+		goto err;
+	}
+	for (i = 0; i < fan->fps_count; i++) {
+		struct acpi_buffer format = { sizeof("NNNNN"), "NNNNN" };
+		struct acpi_buffer fps = { sizeof(fan->fps[i]), &fan->fps[i] };
+		status = acpi_extract_package(&obj->package.elements[i + 1],
+					      &format, &fps);
+		if (ACPI_FAILURE(status)) {
+			dev_err(&device->dev, "Invalid _FPS element\n");
+			break;
+		}
+	}
+
+	/* sort the state array according to fan speed in increase order */
+	sort(fan->fps, fan->fps_count, sizeof(*fan->fps),
+	     acpi_fan_speed_cmp, NULL);
+
+err:
+	kfree(obj);
+	return status;
+}
+
 static int acpi_fan_probe(struct platform_device *pdev)
 {
 	int result = 0;
 	struct thermal_cooling_device *cdev;
+	struct acpi_fan *fan;
 	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 
-	result = acpi_device_update_power(device, NULL);
-	if (result) {
-		dev_err(&pdev->dev, "Setting initial power state\n");
-		goto end;
+	fan = devm_kzalloc(&pdev->dev, sizeof(*fan), GFP_KERNEL);
+	if (!fan) {
+		dev_err(&device->dev, "No memory for fan\n");
+		return -ENOMEM;
+	}
+	device->driver_data = fan;
+	platform_set_drvdata(pdev, fan);
+
+	if (acpi_fan_is_acpi4(device)) {
+		if (acpi_fan_get_fif(device) || acpi_fan_get_fps(device))
+			goto end;
+		fan->acpi4 = true;
+	} else {
+		result = acpi_device_update_power(device, NULL);
+		if (result) {
+			dev_err(&device->dev, "Setting initial power state\n");
+			goto end;
+		}
 	}
 
 	cdev = thermal_cooling_device_register("Fan", device,
@@ -143,7 +353,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "registered as cooling_device%d\n", cdev->id);
 
-	platform_set_drvdata(pdev, cdev);
+	fan->cdev = cdev;
 	result = sysfs_create_link(&pdev->dev.kobj,
 				   &cdev->device.kobj,
 				   "thermal_cooling");
@@ -158,21 +368,17 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to create sysfs link "
 			"'device'\n");
 
-	dev_info(&pdev->dev, "%s [%s] (%s)\n",
-	       acpi_device_name(device), acpi_device_bid(device),
-	       !device->power.state ? "on" : "off");
-
 end:
 	return result;
 }
 
 static int acpi_fan_remove(struct platform_device *pdev)
 {
-	struct thermal_cooling_device *cdev = platform_get_drvdata(pdev);
+	struct acpi_fan *fan = platform_get_drvdata(pdev);
 
 	sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
-	sysfs_remove_link(&cdev->device.kobj, "device");
-	thermal_cooling_device_unregister(cdev);
+	sysfs_remove_link(&fan->cdev->device.kobj, "device");
+	thermal_cooling_device_unregister(fan->cdev);
 
 	return 0;
 }
@@ -180,6 +386,10 @@ static int acpi_fan_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int acpi_fan_suspend(struct device *dev)
 {
+	struct acpi_fan *fan = dev_get_drvdata(dev);
+	if (fan->acpi4)
+		return 0;
+
 	acpi_device_set_power(ACPI_COMPANION(dev), ACPI_STATE_D0);
 
 	return AE_OK;
@@ -188,6 +398,10 @@ static int acpi_fan_suspend(struct device *dev)
 static int acpi_fan_resume(struct device *dev)
 {
 	int result;
+	struct acpi_fan *fan = dev_get_drvdata(dev);
+
+	if (fan->acpi4)
+		return 0;
 
 	result = acpi_device_update_power(ACPI_COMPANION(dev), NULL);
 	if (result)
-- 
1.8.3.2

