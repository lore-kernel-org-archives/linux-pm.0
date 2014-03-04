From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] ACPI / Thermal: make acpi_thermal_check asynchronous on resume
Date: Tue, 04 Mar 2014 14:24:46 +0800
Message-ID: <531571AE.30408@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59501 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518AbaCDGY1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 4 Mar 2014 01:24:27 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>

On resume we do not need to wait for acpi_thermal_check to finish.
Instead, we can run it asynchronously and not block the whole system
resume. Also, we make sure when we are suspending again, previously
queued work for acpi_thermal_check is done.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/thermal.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 08626c851be7..964068553334 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -43,6 +43,7 @@
 #include <linux/device.h>
 #include <linux/thermal.h>
 #include <linux/acpi.h>
+#include <linux/workqueue.h>
 #include <asm/uaccess.h>
 
 #define PREFIX "ACPI: "
@@ -90,6 +91,8 @@ static int psv;
 module_param(psv, int, 0644);
 MODULE_PARM_DESC(psv, "Disable or override all passive trip points.");
 
+static struct workqueue_struct *acpi_thermal_pm_queue;
+
 static int acpi_thermal_add(struct acpi_device *device);
 static int acpi_thermal_remove(struct acpi_device *device);
 static void acpi_thermal_notify(struct acpi_device *device, u32 event);
@@ -101,11 +104,13 @@ static const struct acpi_device_id  thermal_device_ids[] = {
 MODULE_DEVICE_TABLE(acpi, thermal_device_ids);
 
 #ifdef CONFIG_PM_SLEEP
+static int acpi_thermal_suspend(struct device *dev);
 static int acpi_thermal_resume(struct device *dev);
 #else
+#define acpi_thermal_suspend NULL
 #define acpi_thermal_resume NULL
 #endif
-static SIMPLE_DEV_PM_OPS(acpi_thermal_pm, NULL, acpi_thermal_resume);
+static SIMPLE_DEV_PM_OPS(acpi_thermal_pm, acpi_thermal_suspend, acpi_thermal_resume);
 
 static struct acpi_driver acpi_thermal_driver = {
 	.name = "thermal",
@@ -186,6 +191,7 @@ struct acpi_thermal {
 	struct thermal_zone_device *thermal_zone;
 	int tz_enabled;
 	int kelvin_offset;
+	struct work_struct thermal_check_work;
 };
 
 /* --------------------------------------------------------------------------
@@ -1064,6 +1070,13 @@ static void acpi_thermal_guess_offset(struct acpi_thermal *tz)
 		tz->kelvin_offset = 2732;
 }
 
+static void acpi_thermal_check_fn(struct work_struct *work)
+{
+	struct acpi_thermal *tz = container_of(work, struct acpi_thermal,
+					       thermal_check_work);
+	acpi_thermal_check(tz);
+}
+
 static int acpi_thermal_add(struct acpi_device *device)
 {
 	int result = 0;
@@ -1093,6 +1106,8 @@ static int acpi_thermal_add(struct acpi_device *device)
 	if (result)
 		goto free_memory;
 
+	INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
+
 	pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
 		acpi_device_bid(device), KELVIN_TO_CELSIUS(tz->temperature));
 	goto end;
@@ -1110,6 +1125,7 @@ static int acpi_thermal_remove(struct acpi_device *device)
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
+	flush_workqueue(acpi_thermal_pm_queue);
 	tz = acpi_driver_data(device);
 
 	acpi_thermal_unregister_thermal_zone(tz);
@@ -1118,6 +1134,13 @@ static int acpi_thermal_remove(struct acpi_device *device)
 }
 
 #ifdef CONFIG_PM_SLEEP
+static int acpi_thermal_suspend(struct device *dev)
+{
+	/* Make sure the previously queued thermal check work has been done */
+	flush_workqueue(acpi_thermal_pm_queue);
+	return 0;
+}
+
 static int acpi_thermal_resume(struct device *dev)
 {
 	struct acpi_thermal *tz;
@@ -1148,7 +1171,7 @@ static int acpi_thermal_resume(struct device *dev)
 		tz->state.active |= tz->trips.active[i].flags.enabled;
 	}
 
-	acpi_thermal_check(tz);
+	queue_work(acpi_thermal_pm_queue, &tz->thermal_check_work);
 
 	return AE_OK;
 }
@@ -1240,16 +1263,22 @@ static int __init acpi_thermal_init(void)
 		return -ENODEV;
 	}
 
+	acpi_thermal_pm_queue = create_workqueue("acpi_thermal_pm");
+	if (!acpi_thermal_pm_queue)
+		return -ENODEV;
+
 	result = acpi_bus_register_driver(&acpi_thermal_driver);
-	if (result < 0)
+	if (result < 0) {
+		destroy_workqueue(acpi_thermal_pm_queue);
 		return -ENODEV;
+	}
 
 	return 0;
 }
 
 static void __exit acpi_thermal_exit(void)
 {
-
+	destroy_workqueue(acpi_thermal_pm_queue);
 	acpi_bus_unregister_driver(&acpi_thermal_driver);
 
 	return;
-- 
1.8.5.3

