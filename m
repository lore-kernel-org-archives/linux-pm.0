From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 08/19] ACPI / fan: remove no need check for device pointer
Date: Thu, 18 Sep 2014 09:53:39 +0800
Message-ID: <1411005230-2227-9-git-send-email-rui.zhang@intel.com>
References: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, eduardo.valentin@ti.com, Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Aaron Lu <aaron.lu@intel.com>

The device pointer will not be NULL in the PM callback and ACPI driver's
add/remove callback, so checking NULL for them isn't necessary.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/fan.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 562d5f3..df861bb 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -131,9 +131,6 @@ static int acpi_fan_add(struct acpi_device *device)
 	int result = 0;
 	struct thermal_cooling_device *cdev;
 
-	if (!device)
-		return -EINVAL;
-
 	strcpy(acpi_device_name(device), "Fan");
 	strcpy(acpi_device_class(device), ACPI_FAN_CLASS);
 
@@ -177,14 +174,7 @@ static int acpi_fan_add(struct acpi_device *device)
 
 static int acpi_fan_remove(struct acpi_device *device)
 {
-	struct thermal_cooling_device *cdev;
-
-	if (!device)
-		return -EINVAL;
-
-	cdev =  acpi_driver_data(device);
-	if (!cdev)
-		return -EINVAL;
+	struct thermal_cooling_device *cdev = acpi_driver_data(device);
 
 	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
 	sysfs_remove_link(&cdev->device.kobj, "device");
@@ -196,9 +186,6 @@ static int acpi_fan_remove(struct acpi_device *device)
 #ifdef CONFIG_PM_SLEEP
 static int acpi_fan_suspend(struct device *dev)
 {
-	if (!dev)
-		return -EINVAL;
-
 	acpi_bus_set_power(to_acpi_device(dev)->handle, ACPI_STATE_D0);
 
 	return AE_OK;
@@ -208,9 +195,6 @@ static int acpi_fan_resume(struct device *dev)
 {
 	int result;
 
-	if (!dev)
-		return -EINVAL;
-
 	result = acpi_bus_update_power(to_acpi_device(dev)->handle, NULL);
 	if (result)
 		printk(KERN_ERR PREFIX "Error updating fan power state\n");
-- 
1.8.3.2

