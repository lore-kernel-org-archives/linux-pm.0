From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/6] ACPI ac: convert ACPI ac driver to platform bus
Date: Wed, 25 Sep 2013 20:39:45 +0800
Message-ID: <1380112790-2321-2-git-send-email-rui.zhang@intel.com>
References: <1380112790-2321-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42714 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755111Ab3IYMj7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Sep 2013 08:39:59 -0400
In-Reply-To: <1380112790-2321-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/ac.c            |  163 +++++++++++++++++++++---------------------
 drivers/acpi/acpi_platform.c |    1 +
 2 files changed, 81 insertions(+), 83 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index f37beaa3..324b5a0 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -34,6 +34,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #endif
+#include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -61,39 +62,12 @@ extern void *acpi_unlock_ac_dir(struct proc_dir_entry *acpi_ac_dir);
 static int acpi_ac_open_fs(struct inode *inode, struct file *file);
 #endif
 
-static int acpi_ac_add(struct acpi_device *device);
-static int acpi_ac_remove(struct acpi_device *device);
-static void acpi_ac_notify(struct acpi_device *device, u32 event);
-
-static const struct acpi_device_id ac_device_ids[] = {
-	{"ACPI0003", 0},
-	{"", 0},
-};
-MODULE_DEVICE_TABLE(acpi, ac_device_ids);
-
-#ifdef CONFIG_PM_SLEEP
-static int acpi_ac_resume(struct device *dev);
-#endif
-static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
-
 static int ac_sleep_before_get_state_ms;
 
-static struct acpi_driver acpi_ac_driver = {
-	.name = "ac",
-	.class = ACPI_AC_CLASS,
-	.ids = ac_device_ids,
-	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
-	.ops = {
-		.add = acpi_ac_add,
-		.remove = acpi_ac_remove,
-		.notify = acpi_ac_notify,
-		},
-	.drv.pm = &acpi_ac_pm,
-};
-
 struct acpi_ac {
 	struct power_supply charger;
-	struct acpi_device * device;
+	struct acpi_device *adev;
+	struct platform_device *pdev;
 	unsigned long long state;
 };
 
@@ -115,15 +89,13 @@ static const struct file_operations acpi_ac_fops = {
 
 static int acpi_ac_get_state(struct acpi_ac *ac)
 {
-	acpi_status status = AE_OK;
-
+	acpi_status status;
 
-	if (!ac)
-		return -EINVAL;
-
-	status = acpi_evaluate_integer(ac->device->handle, "_PSR", NULL, &ac->state);
+	status = acpi_evaluate_integer(ac->adev->handle, "_PSR", NULL,
+				       &ac->state);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Error reading AC Adapter state"));
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Error reading AC Adapter state"));
 		ac->state = ACPI_AC_STATUS_UNKNOWN;
 		return -ENODEV;
 	}
@@ -201,36 +173,36 @@ static int acpi_ac_open_fs(struct inode *inode, struct file *file)
 	return single_open(file, acpi_ac_seq_show, PDE_DATA(inode));
 }
 
-static int acpi_ac_add_fs(struct acpi_device *device)
+static int acpi_ac_add_fs(struct acpi_ac *ac)
 {
 	struct proc_dir_entry *entry = NULL;
 
 	printk(KERN_WARNING PREFIX "Deprecated procfs I/F for AC is loaded,"
 			" please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
-	if (!acpi_device_dir(device)) {
-		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
-						     acpi_ac_dir);
-		if (!acpi_device_dir(device))
+	if (!acpi_device_dir(ac->adev)) {
+		acpi_device_dir(ac->adev) =
+			proc_mkdir(acpi_device_bid(ac->adev), acpi_ac_dir);
+		if (!acpi_device_dir(ac->adev))
 			return -ENODEV;
 	}
 
 	/* 'state' [R] */
 	entry = proc_create_data(ACPI_AC_FILE_STATE,
-				 S_IRUGO, acpi_device_dir(device),
-				 &acpi_ac_fops, acpi_driver_data(device));
+				 S_IRUGO, acpi_device_dir(ac->adev),
+				 &acpi_ac_fops, ac);
 	if (!entry)
 		return -ENODEV;
 	return 0;
 }
 
-static int acpi_ac_remove_fs(struct acpi_device *device)
+static int acpi_ac_remove_fs(struct acpi_ac *ac)
 {
 
-	if (acpi_device_dir(device)) {
-		remove_proc_entry(ACPI_AC_FILE_STATE, acpi_device_dir(device));
-
-		remove_proc_entry(acpi_device_bid(device), acpi_ac_dir);
-		acpi_device_dir(device) = NULL;
+	if (acpi_device_dir(ac->adev)) {
+		remove_proc_entry(ACPI_AC_FILE_STATE,
+				  acpi_device_dir(ac->adev));
+		remove_proc_entry(acpi_device_bid(ac->adev), acpi_ac_dir);
+		acpi_device_dir(ac->adev) = NULL;
 	}
 
 	return 0;
@@ -241,10 +213,9 @@ static int acpi_ac_remove_fs(struct acpi_device *device)
                                    Driver Model
    -------------------------------------------------------------------------- */
 
-static void acpi_ac_notify(struct acpi_device *device, u32 event)
+static void acpi_ac_notify_handler(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_ac *ac = acpi_driver_data(device);
-
+	struct acpi_ac *ac = data;
 
 	if (!ac)
 		return;
@@ -267,10 +238,10 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
 			msleep(ac_sleep_before_get_state_ms);
 
 		acpi_ac_get_state(ac);
-		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  dev_name(&device->dev), event,
-						  (u32) ac->state);
-		acpi_notifier_call_chain(device, event, (u32) ac->state);
+		acpi_bus_generate_netlink_event(ac->adev->pnp.device_class,
+						dev_name(&ac->pdev->dev),
+						event, (u32) ac->state);
+		acpi_notifier_call_chain(ac->adev, event, (u32) ac->state);
 		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
 	}
 
@@ -295,50 +266,61 @@ static struct dmi_system_id ac_dmi_table[] = {
 	{},
 };
 
-static int acpi_ac_add(struct acpi_device *device)
+static int acpi_ac_probe(struct platform_device *pdev)
 {
 	int result = 0;
 	struct acpi_ac *ac = NULL;
+	struct acpi_device *adev;
 
-
-	if (!device)
+	if (!pdev)
 		return -EINVAL;
 
+	result = acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev);
+	if (result)
+		return -ENODEV;
+
 	ac = kzalloc(sizeof(struct acpi_ac), GFP_KERNEL);
 	if (!ac)
 		return -ENOMEM;
 
-	ac->device = device;
-	strcpy(acpi_device_name(device), ACPI_AC_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_AC_CLASS);
-	device->driver_data = ac;
+	strcpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME);
+	strcpy(acpi_device_class(adev), ACPI_AC_CLASS);
+	ac->adev = adev;
+	ac->pdev = pdev;
+	platform_set_drvdata(pdev, ac);
 
 	result = acpi_ac_get_state(ac);
 	if (result)
 		goto end;
 
 #ifdef CONFIG_ACPI_PROCFS_POWER
-	result = acpi_ac_add_fs(device);
-#endif
+	result = acpi_ac_add_fs(ac);
 	if (result)
 		goto end;
-	ac->charger.name = acpi_device_bid(device);
+#endif
+	ac->charger.name = acpi_device_bid(adev);
 	ac->charger.type = POWER_SUPPLY_TYPE_MAINS;
 	ac->charger.properties = ac_props;
 	ac->charger.num_properties = ARRAY_SIZE(ac_props);
 	ac->charger.get_property = get_ac_property;
-	result = power_supply_register(&ac->device->dev, &ac->charger);
+	result = power_supply_register(&pdev->dev, &ac->charger);
 	if (result)
 		goto end;
 
+	result = acpi_install_notify_handler(ACPI_HANDLE(&pdev->dev),
+			ACPI_DEVICE_NOTIFY, acpi_ac_notify_handler, ac);
+	if (result) {
+		power_supply_unregister(&ac->charger);
+		goto end;
+	}
 	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
-	       acpi_device_name(device), acpi_device_bid(device),
+	       acpi_device_name(adev), acpi_device_bid(adev),
 	       ac->state ? "on-line" : "off-line");
 
       end:
 	if (result) {
 #ifdef CONFIG_ACPI_PROCFS_POWER
-		acpi_ac_remove_fs(device);
+		acpi_ac_remove_fs(ac);
 #endif
 		kfree(ac);
 	}
@@ -356,7 +338,7 @@ static int acpi_ac_resume(struct device *dev)
 	if (!dev)
 		return -EINVAL;
 
-	ac = acpi_driver_data(to_acpi_device(dev));
+	ac = platform_get_drvdata(to_platform_device(dev));
 	if (!ac)
 		return -EINVAL;
 
@@ -368,21 +350,24 @@ static int acpi_ac_resume(struct device *dev)
 	return 0;
 }
 #endif
+static SIMPLE_DEV_PM_OPS(acpi_ac_pm_ops, NULL, acpi_ac_resume);
 
-static int acpi_ac_remove(struct acpi_device *device)
+static int acpi_ac_remove(struct platform_device *pdev)
 {
-	struct acpi_ac *ac = NULL;
-
+	struct acpi_ac *ac;
 
-	if (!device || !acpi_driver_data(device))
+	if (!pdev)
 		return -EINVAL;
 
-	ac = acpi_driver_data(device);
+	acpi_remove_notify_handler(ACPI_HANDLE(&pdev->dev),
+			ACPI_DEVICE_NOTIFY, acpi_ac_notify_handler);
 
+	ac = platform_get_drvdata(pdev);
 	if (ac->charger.dev)
 		power_supply_unregister(&ac->charger);
+
 #ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_ac_remove_fs(device);
+	acpi_ac_remove_fs(ac);
 #endif
 
 	kfree(ac);
@@ -390,6 +375,23 @@ static int acpi_ac_remove(struct acpi_device *device)
 	return 0;
 }
 
+static const struct acpi_device_id acpi_ac_match[] = {
+	{ "ACPI0003", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, acpi_ac_match);
+
+static struct platform_driver acpi_ac_driver = {
+	.probe          = acpi_ac_probe,
+	.remove         = acpi_ac_remove,
+	.driver         = {
+		.name   = "acpi-ac",
+		.owner  = THIS_MODULE,
+		.pm     = &acpi_ac_pm_ops,
+		.acpi_match_table = ACPI_PTR(acpi_ac_match),
+	},
+};
+
 static int __init acpi_ac_init(void)
 {
 	int result;
@@ -403,7 +405,7 @@ static int __init acpi_ac_init(void)
 		return -ENODEV;
 #endif
 
-	result = acpi_bus_register_driver(&acpi_ac_driver);
+	result = platform_driver_register(&acpi_ac_driver);
 	if (result < 0) {
 #ifdef CONFIG_ACPI_PROCFS_POWER
 		acpi_unlock_ac_dir(acpi_ac_dir);
@@ -416,15 +418,10 @@ static int __init acpi_ac_init(void)
 
 static void __exit acpi_ac_exit(void)
 {
-
-	acpi_bus_unregister_driver(&acpi_ac_driver);
-
+	platform_driver_unregister(&acpi_ac_driver);
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_unlock_ac_dir(acpi_ac_dir);
 #endif
-
-	return;
 }
-
 module_init(acpi_ac_init);
 module_exit(acpi_ac_exit);
diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 1bde127..6259bc2 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -29,6 +29,7 @@ ACPI_MODULE_NAME("platform");
 static const struct acpi_device_id acpi_platform_device_ids[] = {
 
 	{ "PNP0D40" },
+	{ "ACPI0003" },
 
 	{ }
 };
-- 
1.7.9.5

