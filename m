From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM: Handle unregistering devices during
	suspend/hibernation
Date: Sat, 23 Feb 2008 00:53:11 +0100
Message-ID: <200802230053.12180.rjw__35187.8350637437$1203724671$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Greg,

The appended patch fixes the issue with the new code for suspending/resuming
devices, related to the fact that some device drivers and CPU hotplug notifiers
unregister device objects while suspend is in progress, which leads to
deadlocks.

Please consider taking it for 2.6.25.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce a mechanism preventing drivers and CPU hotplug notifiers
from deadlocking suspend/hibernation by unregistering device objects
while it is in progress.  Specifically, make device_del() detect if
it has been called by the suspending task and automatically defer the
removal of the device object if that's the case.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/base/core.c        |    5 +++++
 drivers/base/power/main.c  |    9 +++++++++
 drivers/base/power/power.h |    5 +++++
 3 files changed, 19 insertions(+)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -59,6 +59,13 @@ static DECLARE_RWSEM(pm_sleep_rwsem);
 
 int (*platform_enable_wakeup)(struct device *dev, int is_on);
 
+static struct task_struct *suspending_task;
+
+bool in_suspend_context(void)
+{
+	return (suspending_task == current);
+}
+
 /**
  *	device_pm_add - add a device to the list of active devices
  *	@dev:	Device to be added to the list
@@ -272,6 +279,7 @@ static void dpm_resume(void)
 		mutex_lock(&dpm_list_mtx);
 	}
 	mutex_unlock(&dpm_list_mtx);
+	suspending_task = NULL;
 }
 
 /**
@@ -460,6 +468,7 @@ static int dpm_suspend(pm_message_t stat
 {
 	int error = 0;
 
+	suspending_task = current;
 	mutex_lock(&dpm_list_mtx);
 	while (!list_empty(&dpm_locked)) {
 		struct list_head *entry = dpm_locked.prev;
Index: linux-2.6/drivers/base/core.c
===================================================================
--- linux-2.6.orig/drivers/base/core.c
+++ linux-2.6/drivers/base/core.c
@@ -929,6 +929,11 @@ void device_del(struct device *dev)
 	struct device *parent = dev->parent;
 	struct class_interface *class_intf;
 
+	if (in_suspend_context()) {
+		get_device(dev);
+		device_pm_schedule_removal(dev);
+		return;
+	}
 	device_pm_remove(dev);
 	if (parent)
 		klist_del(&dev->knode_parent);
Index: linux-2.6/drivers/base/power/power.h
===================================================================
--- linux-2.6.orig/drivers/base/power/power.h
+++ linux-2.6/drivers/base/power/power.h
@@ -11,6 +11,7 @@ static inline struct device *to_device(s
 	return container_of(entry, struct device, power.entry);
 }
 
+extern bool in_suspend_context(void);
 extern void device_pm_add(struct device *);
 extern void device_pm_remove(struct device *);
 extern int pm_sleep_lock(void);
@@ -18,6 +19,10 @@ extern void pm_sleep_unlock(void);
 
 #else /* CONFIG_PM_SLEEP */
 
+static inline bool in_suspend_context(void)
+{
+	return false;
+}
 
 static inline void device_pm_add(struct device *dev)
 {
