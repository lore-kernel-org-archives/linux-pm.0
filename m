From: Ognjen Galic <smclt30p@gmail.com>
Subject: [PATCH v12 1/4] battery: Add the battery hooking API
Date: Wed, 3 Jan 2018 12:58:47 +0100
Message-ID: <20180103115847.GA10092@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44615 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeACL6x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jan 2018 06:58:53 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>

This is a patch that implements a generic hooking API for the
generic ACPI battery driver.

With this new generic API, drivers can expose platform specific
behaviour via sysfs attributes in /sys/class/power_supply/BATn/
in a generic way.

A perfect example of the need for this API are Lenovo ThinkPads.

Lenovo ThinkPads have a ACPI extension that allows the setting of
start and stop charge thresholds in the EC and battery firmware
via ACPI. The thinkpad_acpi module can use this API to expose
sysfs attributes that it controls inside the ACPI battery driver
sysfs tree, under /sys/class/power_supply/BATN/.

The file drivers/acpi/battery.h has been moved to
include/acpi/battery.h and the includes inside ac.c, sbs.c, and
battery.c have been adjusted to reflect that.

When drivers hooks into the API, the API calls add_battery() for
each battery in the system that passes it a acpi_battery
struct. Then, the drivers can use device_create_file() to create
new sysfs attributes with that struct and identify the batteries
for per-battery attributes.

Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
---

Notes:
    v7:
    * Implemented mutual exclusion for hooking methods and battery
    callbacks
    * Fixed a BUG where errors in other modules would occur when the
    modules that depend on battery get unloaded
    
    v8:
    * Use list_for_each_safe instead of list_for_each for the module
    exit function where deletion of nodes occurs
    
    v9:
    * No changes in this patch in v9
    
    v10:
    * Fix compiler warnings in Intel's 0-day CI
    
    v11:
    * Fix changelog formatting
    * Make lists and mutex static
    
    v12:
    * Change all applicable list_for_each to list_for_each_entry
    * Define pr_fmt to include module name for pr_*

 drivers/acpi/ac.c      |   2 +-
 drivers/acpi/battery.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/battery.h |  11 ----
 drivers/acpi/sbs.c     |   2 +-
 include/acpi/battery.h |  21 +++++++
 5 files changed, 171 insertions(+), 16 deletions(-)
 delete mode 100644 drivers/acpi/battery.h
 create mode 100644 include/acpi/battery.h

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 47a7ed5..2d8de2f 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -33,7 +33,7 @@
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/acpi.h>
-#include "battery.h"
+#include <acpi/battery.h>
 
 #define PREFIX "ACPI: "
 
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 13e7b56..7089e31 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -21,8 +21,12 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/jiffies.h>
@@ -42,7 +46,7 @@
 #include <linux/acpi.h>
 #include <linux/power_supply.h>
 
-#include "battery.h"
+#include <acpi/battery.h>
 
 #define PREFIX "ACPI: "
 
@@ -124,6 +128,7 @@ struct acpi_battery {
 	struct power_supply_desc bat_desc;
 	struct acpi_device *device;
 	struct notifier_block pm_nb;
+	struct list_head list;
 	unsigned long update_time;
 	int revision;
 	int rate_now;
@@ -626,6 +631,142 @@ static const struct device_attribute alarm_attr = {
 	.store = acpi_battery_alarm_store,
 };
 
+/*
+ * The Battery Hooking API
+ *
+ * This API is used inside other drivers that need to expose
+ * platform-specific behaviour within the generic driver in a
+ * generic way.
+ *
+ */
+
+static LIST_HEAD(acpi_battery_list);
+static LIST_HEAD(battery_hook_list);
+static DEFINE_MUTEX(hook_mutex);
+
+void __battery_hook_unregister(struct acpi_battery_hook *hook, int lock)
+{
+	struct list_head *position;
+	struct acpi_battery *battery;
+	/*
+	 * In order to remove a hook, we first need to
+	 * de-register all the batteries that are registered.
+	 */
+	if (lock)
+		mutex_lock(&hook_mutex);
+	list_for_each(position, &acpi_battery_list) {
+		battery = list_entry(position, struct acpi_battery, list);
+		hook->remove_battery(battery->bat);
+	}
+	list_del(&hook->list);
+	if (lock)
+		mutex_unlock(&hook_mutex);
+	pr_info("extension unregistered: %s\n", hook->name);
+}
+
+void battery_hook_unregister(struct acpi_battery_hook *hook)
+{
+	__battery_hook_unregister(hook, 1);
+}
+EXPORT_SYMBOL_GPL(battery_hook_unregister);
+
+void battery_hook_register(struct acpi_battery_hook *hook)
+{
+	struct acpi_battery *battery;
+
+	mutex_lock(&hook_mutex);
+	INIT_LIST_HEAD(&hook->list);
+	list_add(&hook->list, &battery_hook_list);
+	/*
+	 * Now that the driver is registered, we need
+	 * to notify the hook that a battery is available
+	 * for each battery, so that the driver may add
+	 * its attributes.
+	 */
+	list_for_each_entry(battery, &acpi_battery_list, list) {
+		if (hook->add_battery(battery->bat)) {
+			/*
+			 * If a add-battery returns non-zero,
+			 * the registration of the extension has failed,
+			 * and we will not add it to the list of loaded
+			 * hooks.
+			 */
+			pr_err("extension failed to load: %s",
+					hook->name);
+			__battery_hook_unregister(hook, 0);
+			return;
+		}
+	}
+	pr_info("new extension: %s\n", hook->name);
+	mutex_unlock(&hook_mutex);
+}
+EXPORT_SYMBOL_GPL(battery_hook_register);
+
+static void battery_hook_add_battery(struct acpi_battery *battery)
+{
+	/*
+	 * This function gets called right after the battery sysfs
+	 * attributes have been added, so that the drivers that
+	 * define custom sysfs attributes can add their own.
+	 */
+	struct acpi_battery_hook *hook_node;
+
+	mutex_lock(&hook_mutex);
+	INIT_LIST_HEAD(&battery->list);
+	list_add(&battery->list, &acpi_battery_list);
+	/*
+	 * Since we added a new battery to the list, we need to
+	 * iterate over the hooks and call add_battery for each
+	 * hook that was registered. This usually happens
+	 * when a battery gets hotplugged or initialized
+	 * during the battery module initialization.
+	 */
+	list_for_each_entry(hook_node, &battery_hook_list, list) {
+		if (hook_node->add_battery(battery->bat)) {
+			/*
+			 * The notification of the extensions has failed, to
+			 * prevent further errors we will unload the extension.
+			 */
+			__battery_hook_unregister(hook_node, 0);
+			pr_err("error in extension, unloading: %s",
+					hook_node->name);
+		}
+	}
+	mutex_unlock(&hook_mutex);
+}
+
+static void battery_hook_remove_battery(struct acpi_battery *battery)
+{
+	struct acpi_battery_hook *hook;
+
+	mutex_lock(&hook_mutex);
+	/*
+	 * Before removing the hook, we need to remove all
+	 * custom attributes from the battery.
+	 */
+	list_for_each_entry(hook, &battery_hook_list, list) {
+		hook->remove_battery(battery->bat);
+	}
+	/* Then, just remove the battery from the list */
+	list_del(&battery->list);
+	mutex_unlock(&hook_mutex);
+}
+
+static void __exit battery_hook_exit(void)
+{
+	struct acpi_battery_hook *hook;
+	struct acpi_battery_hook *ptr;
+	/*
+	 * At this point, the acpi_bus_unregister_driver
+	 * has called remove for all batteries. We just
+	 * need to remove the hooks.
+	 */
+	list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
+		__battery_hook_unregister(hook, 1);
+	}
+	mutex_destroy(&hook_mutex);
+}
+
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
 	struct power_supply_config psy_cfg = { .drv_data = battery, };
@@ -647,6 +788,8 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 	battery->bat = power_supply_register_no_ws(&battery->device->dev,
 				&battery->bat_desc, &psy_cfg);
 
+	battery_hook_add_battery(battery);
+
 	if (IS_ERR(battery->bat)) {
 		int result = PTR_ERR(battery->bat);
 
@@ -663,7 +806,7 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 		mutex_unlock(&battery->sysfs_lock);
 		return;
 	}
-
+	battery_hook_remove_battery(battery);
 	device_remove_file(&battery->bat->dev, &alarm_attr);
 	power_supply_unregister(battery->bat);
 	battery->bat = NULL;
@@ -1359,8 +1502,10 @@ static int __init acpi_battery_init(void)
 static void __exit acpi_battery_exit(void)
 {
 	async_synchronize_cookie(async_cookie + 1);
-	if (battery_driver_registered)
+	if (battery_driver_registered) {
 		acpi_bus_unregister_driver(&acpi_battery_driver);
+		battery_hook_exit();
+	}
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	if (acpi_battery_dir)
 		acpi_unlock_battery_dir(acpi_battery_dir);
diff --git a/drivers/acpi/battery.h b/drivers/acpi/battery.h
deleted file mode 100644
index 225f493..0000000
--- a/drivers/acpi/battery.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ACPI_BATTERY_H
-#define __ACPI_BATTERY_H
-
-#define ACPI_BATTERY_CLASS "battery"
-
-#define ACPI_BATTERY_NOTIFY_STATUS	0x80
-#define ACPI_BATTERY_NOTIFY_INFO	0x81
-#define ACPI_BATTERY_NOTIFY_THRESHOLD   0x82
-
-#endif
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index a2428e9..295b592 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -32,9 +32,9 @@
 #include <linux/delay.h>
 #include <linux/power_supply.h>
 #include <linux/platform_data/x86/apple.h>
+#include <acpi/battery.h>
 
 #include "sbshc.h"
-#include "battery.h"
 
 #define PREFIX "ACPI: "
 
diff --git a/include/acpi/battery.h b/include/acpi/battery.h
new file mode 100644
index 0000000..5d8f5d9
--- /dev/null
+++ b/include/acpi/battery.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ACPI_BATTERY_H
+#define __ACPI_BATTERY_H
+
+#define ACPI_BATTERY_CLASS "battery"
+
+#define ACPI_BATTERY_NOTIFY_STATUS	0x80
+#define ACPI_BATTERY_NOTIFY_INFO	0x81
+#define ACPI_BATTERY_NOTIFY_THRESHOLD   0x82
+
+struct acpi_battery_hook {
+	const char *name;
+	int (*add_battery)(struct power_supply *battery);
+	int (*remove_battery)(struct power_supply *battery);
+	struct list_head list;
+};
+
+void battery_hook_register(struct acpi_battery_hook *hook);
+void battery_hook_unregister(struct acpi_battery_hook *hook);
+
+#endif
-- 
2.7.4
