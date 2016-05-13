From: Eduardo Valentin <edubezval@gmail.com>
Subject: [RFC PATCH 1/1] acpi: processor_driver: register cooling device per package
Date: Thu, 12 May 2016 23:19:30 -0700
Message-ID: <1463120370-2553-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34605 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbcEMGTj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2016 02:19:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, Eduardo Valentin <edubezval@gmail.com>

The current throttling strategy is to apply cooling levels
on all processors in a package. Therefore, if one cooling
device is requested to cap the frequency, the same request
is applied to all sibling processors in the same package.

For this reason, this patch removes the redundant cooling
devices, registering only one cooling device per package.

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
Srinivas,

This is the outcome of our discussion on the Processor cooling device.
As per your suggestion, I am now attempting to register a single
cooling device per package.

The only thing is about the sysfs links. Now the Processor cooling
device would look like:
$ ls /sys/class/thermal/cooling_device0/
cur_state  device.0  device.1  device.2  device.3  max_state  power  subsystem	type  uevent

Instead of:

$ ls /sys/class/thermal/cooling_device0/
cur_state  device  max_state  power  subsystem	type  uevent

This is obviously to keep a link between the cooling device and
its affected devices. Would this break userspace?

BR,

Eduardo Valentin

 drivers/acpi/processor_driver.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 11154a3..e1e17de 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -160,9 +160,29 @@ static struct notifier_block acpi_cpu_notifier = {
 };
 
 #ifdef CONFIG_ACPI_CPU_FREQ_PSS
+static struct thermal_cooling_device *
+acpi_pss_register_cooling(struct acpi_processor *pr, struct acpi_device *device)
+{
+	int i, cpu = pr->id;
+
+	for_each_online_cpu(i) {
+		if (topology_physical_package_id(i) ==
+		    topology_physical_package_id(cpu)) {
+			struct acpi_processor *pre = per_cpu(processors, i);
+
+			if (pre->cdev && !IS_ERR(pre->cdev))
+				return pre->cdev;
+		}
+	}
+
+	return thermal_cooling_device_register("Processor", device,
+					       &processor_cooling_ops);
+}
+
 static int acpi_pss_perf_init(struct acpi_processor *pr,
 		struct acpi_device *device)
 {
+	char cpu_id[15];
 	int result = 0;
 
 	acpi_processor_ppc_has_changed(pr, 0);
@@ -172,8 +192,7 @@ static int acpi_pss_perf_init(struct acpi_processor *pr,
 	if (pr->flags.throttling)
 		pr->flags.limit = 1;
 
-	pr->cdev = thermal_cooling_device_register("Processor", device,
-						   &processor_cooling_ops);
+	pr->cdev = acpi_pss_register_cooling(pr, device);
 	if (IS_ERR(pr->cdev)) {
 		result = PTR_ERR(pr->cdev);
 		return result;
@@ -191,9 +210,10 @@ static int acpi_pss_perf_init(struct acpi_processor *pr,
 		goto err_thermal_unregister;
 	}
 
+	snprintf(cpu_id, sizeof(cpu_id), "device.%d", pr->id);
 	result = sysfs_create_link(&pr->cdev->device.kobj,
 				   &device->dev.kobj,
-				   "device");
+				   cpu_id);
 	if (result) {
 		dev_err(&pr->cdev->device,
 			"Failed to create sysfs link 'device'\n");
@@ -213,11 +233,25 @@ static int acpi_pss_perf_init(struct acpi_processor *pr,
 static void acpi_pss_perf_exit(struct acpi_processor *pr,
 		struct acpi_device *device)
 {
+	char cpu_id[15];
+	int i;
+
 	if (pr->cdev) {
 		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+		snprintf(cpu_id, sizeof(cpu_id), "device.%d", pr->id);
 		sysfs_remove_link(&pr->cdev->device.kobj, "device");
 		thermal_cooling_device_unregister(pr->cdev);
 		pr->cdev = NULL;
+
+		for_each_online_cpu(i) {
+			if (topology_physical_package_id(i) ==
+			    topology_physical_package_id(pr->id)) {
+				struct acpi_processor *pre;
+
+				pre = per_cpu(processors, i);
+				pre->cdev = NULL;
+			}
+		}
 	}
 }
 #else
-- 
2.1.4

