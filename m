From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/3] Thermal: handle thermal zone device properly during system sleep
Date: Sun, 27 Sep 2015 13:48:35 +0800
Message-ID: <1443332915-13988-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com, javi.merino@arm.com
Cc: rui.zhang@intel.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Current thermal code does not handle system sleep well because
1. the cooling device cooling state may be changed during suspend
2. the previous temperature reading becomes invalid after resumed because
   it is got before system sleep
3. updating thermal zone device during suspending/resuming
   is wrong because some devices may have already been suspended
   or may have not been resumed.

Thus, the proper way to do this is to cancel all thermal zone
device update requirements during suspend/resume, and after all
the devices have been resumed, reset and update every registered
thermal zone devices.

This also fixes a regression introduced by:
Commit 19593a1fb1f6 ("ACPI / fan: convert to platform driver")
Because, with above commit applied, all the fan devices are attached
to the acpi_general_pm_domain, and they are turned on by the pm_domain
automatically after resume, without the awareness of thermal core.

CC: <stable@vger.kernel.org> #3.18+
Reference: https://bugzilla.kernel.org/show_bug.cgi?id=78201
Reference: https://bugzilla.kernel.org/show_bug.cgi?id=91411
Tested-by: Manuel Krause <manuelkrause@netscape.net>
Tested-by: szegad <szegadlo@poczta.onet.pl>
Tested-by: prash <prash.n.rao@gmail.com>
Tested-by: amish <ammdispose-arch@yahoo.com>
Tested-by: Matthias <morpheusxyz123@yahoo.de>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/thermal/thermal_core.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 682bc1e..c3bdb48 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -37,6 +37,7 @@
 #include <linux/of.h>
 #include <net/netlink.h>
 #include <net/genetlink.h>
+#include <linux/suspend.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/thermal.h>
@@ -59,6 +60,8 @@ static LIST_HEAD(thermal_governor_list);
 static DEFINE_MUTEX(thermal_list_lock);
 static DEFINE_MUTEX(thermal_governor_lock);
 
+static atomic_t in_suspend;
+
 static struct thermal_governor *def_governor;
 
 static struct thermal_governor *__find_governor(const char *name)
@@ -554,6 +557,9 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 {
 	int count;
 
+	if (atomic_read(&in_suspend))
+		return;
+
 	if (!tz->ops->get_temp)
 		return;
 
@@ -2155,6 +2161,36 @@ static void thermal_unregister_governors(void)
 	thermal_gov_power_allocator_unregister();
 }
 
+static int thermal_pm_notify(struct notifier_block *nb,
+				unsigned long mode, void *_unused)
+{
+	struct thermal_zone_device *tz;
+
+	switch (mode) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_RESTORE_PREPARE:
+	case PM_SUSPEND_PREPARE:
+		atomic_set(&in_suspend, 1);
+		break;
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+	case PM_POST_SUSPEND:
+		atomic_set(&in_suspend, 0);
+		list_for_each_entry(tz, &thermal_tz_list, node) {
+			thermal_zone_device_reset(tz);
+			thermal_zone_device_update(tz);
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static struct notifier_block thermal_pm_nb = {
+	.notifier_call = thermal_pm_notify,
+};
+
 static int __init thermal_init(void)
 {
 	int result;
@@ -2175,6 +2211,8 @@ static int __init thermal_init(void)
 	if (result)
 		goto exit_netlink;
 
+	register_pm_notifier(&thermal_pm_nb);
+
 	return 0;
 
 exit_netlink:
@@ -2194,6 +2232,7 @@ error:
 
 static void __exit thermal_exit(void)
 {
+	unregister_pm_notifier(&thermal_pm_nb);
 	of_thermal_destroy_zones();
 	genetlink_exit();
 	class_unregister(&thermal_class);
-- 
1.8.4.2
