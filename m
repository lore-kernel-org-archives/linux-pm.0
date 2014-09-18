From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 10/19] ACPI / fan: convert to platform driver
Date: Thu, 18 Sep 2014 09:53:41 +0800
Message-ID: <1411005230-2227-11-git-send-email-rui.zhang@intel.com>
References: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46477 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119AbaIRByf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Sep 2014 21:54:35 -0400
In-Reply-To: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, eduardo.valentin@ti.com, Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Aaron Lu <aaron.lu@intel.com>

Convert ACPI fan driver to a platform driver for the purpose of phasing
out ACPI bus.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/fan.c | 62 ++++++++++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index fff9696..8a5b450 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -30,17 +30,14 @@
 #include <asm/uaccess.h>
 #include <linux/thermal.h>
 #include <linux/acpi.h>
-
-#define PREFIX "ACPI: "
-
-#define ACPI_FAN_CLASS			"fan"
+#include <linux/platform_device.h>
 
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Fan Driver");
 MODULE_LICENSE("GPL");
 
-static int acpi_fan_add(struct acpi_device *device);
-static int acpi_fan_remove(struct acpi_device *device);
+static int acpi_fan_probe(struct platform_device *pdev);
+static int acpi_fan_remove(struct platform_device *pdev);
 
 static const struct acpi_device_id fan_device_ids[] = {
 	{"PNP0C0B", 0},
@@ -62,15 +59,14 @@ static struct dev_pm_ops acpi_fan_pm = {
 #define FAN_PM_OPS_PTR NULL
 #endif
 
-static struct acpi_driver acpi_fan_driver = {
-	.name = "fan",
-	.class = ACPI_FAN_CLASS,
-	.ids = fan_device_ids,
-	.ops = {
-		.add = acpi_fan_add,
-		.remove = acpi_fan_remove,
-		},
-	.drv.pm = FAN_PM_OPS_PTR,
+static struct platform_driver acpi_fan_driver = {
+	.probe = acpi_fan_probe,
+	.remove = acpi_fan_remove,
+	.driver = {
+		.name = "acpi-fan",
+		.acpi_match_table = fan_device_ids,
+		.pm = FAN_PM_OPS_PTR,
+	},
 };
 
 /* thermal cooling device callbacks */
@@ -126,17 +122,15 @@ static const struct thermal_cooling_device_ops fan_cooling_ops = {
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
-static int acpi_fan_add(struct acpi_device *device)
+static int acpi_fan_probe(struct platform_device *pdev)
 {
 	int result = 0;
 	struct thermal_cooling_device *cdev;
-
-	strcpy(acpi_device_name(device), "Fan");
-	strcpy(acpi_device_class(device), ACPI_FAN_CLASS);
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 
 	result = acpi_device_update_power(device, NULL);
 	if (result) {
-		printk(KERN_ERR PREFIX "Setting initial power state\n");
+		dev_err(&pdev->dev, "Setting initial power state\n");
 		goto end;
 	}
 
@@ -147,24 +141,24 @@ static int acpi_fan_add(struct acpi_device *device)
 		goto end;
 	}
 
-	dev_dbg(&device->dev, "registered as cooling_device%d\n", cdev->id);
+	dev_dbg(&pdev->dev, "registered as cooling_device%d\n", cdev->id);
 
-	device->driver_data = cdev;
-	result = sysfs_create_link(&device->dev.kobj,
+	platform_set_drvdata(pdev, cdev);
+	result = sysfs_create_link(&pdev->dev.kobj,
 				   &cdev->device.kobj,
 				   "thermal_cooling");
 	if (result)
-		dev_err(&device->dev, "Failed to create sysfs link "
+		dev_err(&pdev->dev, "Failed to create sysfs link "
 			"'thermal_cooling'\n");
 
 	result = sysfs_create_link(&cdev->device.kobj,
-				   &device->dev.kobj,
+				   &pdev->dev.kobj,
 				   "device");
 	if (result)
-		dev_err(&device->dev, "Failed to create sysfs link "
+		dev_err(&pdev->dev, "Failed to create sysfs link "
 			"'device'\n");
 
-	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
+	dev_info(&pdev->dev, "%s [%s] (%s)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
 	       !device->power.state ? "on" : "off");
 
@@ -172,11 +166,11 @@ static int acpi_fan_add(struct acpi_device *device)
 	return result;
 }
 
-static int acpi_fan_remove(struct acpi_device *device)
+static int acpi_fan_remove(struct platform_device *pdev)
 {
-	struct thermal_cooling_device *cdev = acpi_driver_data(device);
+	struct thermal_cooling_device *cdev = platform_get_drvdata(pdev);
 
-	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+	sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
 	sysfs_remove_link(&cdev->device.kobj, "device");
 	thermal_cooling_device_unregister(cdev);
 
@@ -186,7 +180,7 @@ static int acpi_fan_remove(struct acpi_device *device)
 #ifdef CONFIG_PM_SLEEP
 static int acpi_fan_suspend(struct device *dev)
 {
-	acpi_device_set_power(to_acpi_device(dev), ACPI_STATE_D0);
+	acpi_device_set_power(ACPI_COMPANION(dev), ACPI_STATE_D0);
 
 	return AE_OK;
 }
@@ -195,12 +189,12 @@ static int acpi_fan_resume(struct device *dev)
 {
 	int result;
 
-	result = acpi_device_update_power(to_acpi_device(dev), NULL);
+	result = acpi_device_update_power(ACPI_COMPANION(dev), NULL);
 	if (result)
-		printk(KERN_ERR PREFIX "Error updating fan power state\n");
+		dev_err(dev, "Error updating fan power state\n");
 
 	return result;
 }
 #endif
 
-module_acpi_driver(acpi_fan_driver);
+module_platform_driver(acpi_fan_driver);
-- 
1.8.3.2

