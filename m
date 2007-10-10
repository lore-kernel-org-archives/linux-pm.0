From: <gregkh@suse.de>
Subject: patch
	pm-merge-device-power-management-source-files.patch added to
	gregkh-2.6 tree
Date: Wed, 10 Oct 2007 13:42:26 -0700
Message-ID: <20071010204236.BC4151454471@imap.suse.de>
References: <Pine.LNX.4.44L0.0709211535540.5816-100000@iolanthe.rowland.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0709211535540.5816-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: stern@rowland.harvard.edu, greg@kroah.com, gregkh@suse.de, linux-pm@lists.linux-foundation.org, rjw@sisk.pl
List-Id: linux-pm@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: PM: merge device power-management source files

to my gregkh-2.6 tree.  Its filename is

     pm-merge-device-power-management-source-files.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From stern@rowland.harvard.edu Fri Sep 21 12:37:01 2007
From: Alan Stern <stern@rowland.harvard.edu>
Date: Fri, 21 Sep 2007 15:36:56 -0400 (EDT)
Subject: PM: merge device power-management source files
To: Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Message-ID: <Pine.LNX.4.44L0.0709211535540.5816-100000@iolanthe.rowland.org>


This patch (as993) merges the suspend.c and resume.c files in
drivers/base/power into main.c, making some public symbols private.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/power/Makefile  |    2 
 drivers/base/power/main.c    |  344 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/base/power/power.h   |   32 ----
 drivers/base/power/resume.c  |  149 ------------------
 drivers/base/power/suspend.c |  210 --------------------------
 5 files changed, 343 insertions(+), 394 deletions(-)

--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -1,5 +1,5 @@
 obj-y			:= shutdown.o
-obj-$(CONFIG_PM_SLEEP)	+= main.o suspend.o resume.o sysfs.o
+obj-$(CONFIG_PM_SLEEP)	+= main.o sysfs.o
 obj-$(CONFIG_PM_TRACE)	+= trace.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -20,19 +20,24 @@
  */
 
 #include <linux/device.h>
+#include <linux/kallsyms.h>
 #include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/resume-trace.h>
 
+#include "../base.h"
 #include "power.h"
 
 LIST_HEAD(dpm_active);
-LIST_HEAD(dpm_off);
-LIST_HEAD(dpm_off_irq);
+static LIST_HEAD(dpm_off);
+static LIST_HEAD(dpm_off_irq);
 
-DEFINE_MUTEX(dpm_mtx);
-DEFINE_MUTEX(dpm_list_mtx);
+static DEFINE_MUTEX(dpm_mtx);
+static DEFINE_MUTEX(dpm_list_mtx);
 
 int (*platform_enable_wakeup)(struct device *dev, int is_on);
 
+
 int device_pm_add(struct device *dev)
 {
 	int error;
@@ -61,3 +66,334 @@ void device_pm_remove(struct device *dev
 }
 
 
+/*------------------------- Resume routines -------------------------*/
+
+/**
+ *	resume_device - Restore state for one device.
+ *	@dev:	Device.
+ *
+ */
+
+static int resume_device(struct device * dev)
+{
+	int error = 0;
+
+	TRACE_DEVICE(dev);
+	TRACE_RESUME(0);
+
+	down(&dev->sem);
+
+	if (dev->bus && dev->bus->resume) {
+		dev_dbg(dev,"resuming\n");
+		error = dev->bus->resume(dev);
+	}
+
+	if (!error && dev->type && dev->type->resume) {
+		dev_dbg(dev,"resuming\n");
+		error = dev->type->resume(dev);
+	}
+
+	if (!error && dev->class && dev->class->resume) {
+		dev_dbg(dev,"class resume\n");
+		error = dev->class->resume(dev);
+	}
+
+	up(&dev->sem);
+
+	TRACE_RESUME(error);
+	return error;
+}
+
+
+static int resume_device_early(struct device * dev)
+{
+	int error = 0;
+
+	TRACE_DEVICE(dev);
+	TRACE_RESUME(0);
+	if (dev->bus && dev->bus->resume_early) {
+		dev_dbg(dev,"EARLY resume\n");
+		error = dev->bus->resume_early(dev);
+	}
+	TRACE_RESUME(error);
+	return error;
+}
+
+/*
+ * Resume the devices that have either not gone through
+ * the late suspend, or that did go through it but also
+ * went through the early resume
+ */
+static void dpm_resume(void)
+{
+	mutex_lock(&dpm_list_mtx);
+	while(!list_empty(&dpm_off)) {
+		struct list_head * entry = dpm_off.next;
+		struct device * dev = to_device(entry);
+
+		get_device(dev);
+		list_move_tail(entry, &dpm_active);
+
+		mutex_unlock(&dpm_list_mtx);
+		resume_device(dev);
+		mutex_lock(&dpm_list_mtx);
+		put_device(dev);
+	}
+	mutex_unlock(&dpm_list_mtx);
+}
+
+
+/**
+ *	device_resume - Restore state of each device in system.
+ *
+ *	Walk the dpm_off list, remove each entry, resume the device,
+ *	then add it to the dpm_active list.
+ */
+
+void device_resume(void)
+{
+	might_sleep();
+	mutex_lock(&dpm_mtx);
+	dpm_resume();
+	mutex_unlock(&dpm_mtx);
+}
+
+EXPORT_SYMBOL_GPL(device_resume);
+
+
+/**
+ *	dpm_power_up - Power on some devices.
+ *
+ *	Walk the dpm_off_irq list and power each device up. This
+ *	is used for devices that required they be powered down with
+ *	interrupts disabled. As devices are powered on, they are moved
+ *	to the dpm_active list.
+ *
+ *	Interrupts must be disabled when calling this.
+ */
+
+static void dpm_power_up(void)
+{
+	while(!list_empty(&dpm_off_irq)) {
+		struct list_head * entry = dpm_off_irq.next;
+		struct device * dev = to_device(entry);
+
+		list_move_tail(entry, &dpm_off);
+		resume_device_early(dev);
+	}
+}
+
+
+/**
+ *	device_power_up - Turn on all devices that need special attention.
+ *
+ *	Power on system devices then devices that required we shut them down
+ *	with interrupts disabled.
+ *	Called with interrupts disabled.
+ */
+
+void device_power_up(void)
+{
+	sysdev_resume();
+	dpm_power_up();
+}
+
+EXPORT_SYMBOL_GPL(device_power_up);
+
+
+/*------------------------- Suspend routines -------------------------*/
+
+/*
+ * The entries in the dpm_active list are in a depth first order, simply
+ * because children are guaranteed to be discovered after parents, and
+ * are inserted at the back of the list on discovery.
+ *
+ * All list on the suspend path are done in reverse order, so we operate
+ * on the leaves of the device tree (or forests, depending on how you want
+ * to look at it ;) first. As nodes are removed from the back of the list,
+ * they are inserted into the front of their destintation lists.
+ *
+ * Things are the reverse on the resume path - iterations are done in
+ * forward order, and nodes are inserted at the back of their destination
+ * lists. This way, the ancestors will be accessed before their descendents.
+ */
+
+static inline char *suspend_verb(u32 event)
+{
+	switch (event) {
+	case PM_EVENT_SUSPEND:	return "suspend";
+	case PM_EVENT_FREEZE:	return "freeze";
+	case PM_EVENT_PRETHAW:	return "prethaw";
+	default:		return "(unknown suspend event)";
+	}
+}
+
+
+static void
+suspend_device_dbg(struct device *dev, pm_message_t state, char *info)
+{
+	dev_dbg(dev, "%s%s%s\n", info, suspend_verb(state.event),
+		((state.event == PM_EVENT_SUSPEND) && device_may_wakeup(dev)) ?
+		", may wakeup" : "");
+}
+
+/**
+ *	suspend_device - Save state of one device.
+ *	@dev:	Device.
+ *	@state:	Power state device is entering.
+ */
+
+static int suspend_device(struct device * dev, pm_message_t state)
+{
+	int error = 0;
+
+	down(&dev->sem);
+	if (dev->power.power_state.event) {
+		dev_dbg(dev, "PM: suspend %d-->%d\n",
+			dev->power.power_state.event, state.event);
+	}
+
+	if (dev->class && dev->class->suspend) {
+		suspend_device_dbg(dev, state, "class ");
+		error = dev->class->suspend(dev, state);
+		suspend_report_result(dev->class->suspend, error);
+	}
+
+	if (!error && dev->type && dev->type->suspend) {
+		suspend_device_dbg(dev, state, "type ");
+		error = dev->type->suspend(dev, state);
+		suspend_report_result(dev->type->suspend, error);
+	}
+
+	if (!error && dev->bus && dev->bus->suspend) {
+		suspend_device_dbg(dev, state, "");
+		error = dev->bus->suspend(dev, state);
+		suspend_report_result(dev->bus->suspend, error);
+	}
+	up(&dev->sem);
+	return error;
+}
+
+
+/*
+ * This is called with interrupts off, only a single CPU
+ * running. We can't acquire a mutex or semaphore (and we don't
+ * need the protection)
+ */
+static int suspend_device_late(struct device *dev, pm_message_t state)
+{
+	int error = 0;
+
+	if (dev->bus && dev->bus->suspend_late) {
+		suspend_device_dbg(dev, state, "LATE ");
+		error = dev->bus->suspend_late(dev, state);
+		suspend_report_result(dev->bus->suspend_late, error);
+	}
+	return error;
+}
+
+/**
+ *	device_suspend - Save state and stop all devices in system.
+ *	@state:		Power state to put each device in.
+ *
+ *	Walk the dpm_active list, call ->suspend() for each device, and move
+ *	it to the dpm_off list.
+ *
+ *	(For historical reasons, if it returns -EAGAIN, that used to mean
+ *	that the device would be called again with interrupts disabled.
+ *	These days, we use the "suspend_late()" callback for that, so we
+ *	print a warning and consider it an error).
+ *
+ *	If we get a different error, try and back out.
+ *
+ *	If we hit a failure with any of the devices, call device_resume()
+ *	above to bring the suspended devices back to life.
+ *
+ */
+
+int device_suspend(pm_message_t state)
+{
+	int error = 0;
+
+	might_sleep();
+	mutex_lock(&dpm_mtx);
+	mutex_lock(&dpm_list_mtx);
+	while (!list_empty(&dpm_active) && error == 0) {
+		struct list_head * entry = dpm_active.prev;
+		struct device * dev = to_device(entry);
+
+		get_device(dev);
+		mutex_unlock(&dpm_list_mtx);
+
+		error = suspend_device(dev, state);
+
+		mutex_lock(&dpm_list_mtx);
+
+		/* Check if the device got removed */
+		if (!list_empty(&dev->power.entry)) {
+			/* Move it to the dpm_off list */
+			if (!error)
+				list_move(&dev->power.entry, &dpm_off);
+		}
+		if (error)
+			printk(KERN_ERR "Could not suspend device %s: "
+				"error %d%s\n",
+				kobject_name(&dev->kobj), error,
+				error == -EAGAIN ? " (please convert to suspend_late)" : "");
+		put_device(dev);
+	}
+	mutex_unlock(&dpm_list_mtx);
+	if (error)
+		dpm_resume();
+
+	mutex_unlock(&dpm_mtx);
+	return error;
+}
+
+EXPORT_SYMBOL_GPL(device_suspend);
+
+/**
+ *	device_power_down - Shut down special devices.
+ *	@state:		Power state to enter.
+ *
+ *	Walk the dpm_off_irq list, calling ->power_down() for each device that
+ *	couldn't power down the device with interrupts enabled. When we're
+ *	done, power down system devices.
+ */
+
+int device_power_down(pm_message_t state)
+{
+	int error = 0;
+	struct device * dev;
+
+	while (!list_empty(&dpm_off)) {
+		struct list_head * entry = dpm_off.prev;
+
+		dev = to_device(entry);
+		error = suspend_device_late(dev, state);
+		if (error)
+			goto Error;
+		list_move(&dev->power.entry, &dpm_off_irq);
+	}
+
+	error = sysdev_suspend(state);
+ Done:
+	return error;
+ Error:
+	printk(KERN_ERR "Could not power down device %s: "
+		"error %d\n", kobject_name(&dev->kobj), error);
+	dpm_power_up();
+	goto Done;
+}
+
+EXPORT_SYMBOL_GPL(device_power_down);
+
+void __suspend_report_result(const char *function, void *fn, int ret)
+{
+	if (ret) {
+		printk(KERN_ERR "%s(): ", function);
+		print_fn_descriptor_symbol("%s() returns ", (unsigned long)fn);
+		printk("%d\n", ret);
+	}
+}
+EXPORT_SYMBOL_GPL(__suspend_report_result);
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -11,32 +11,11 @@ extern void device_shutdown(void);
  * main.c
  */
 
-/*
- * Used to synchronize global power management operations.
- */
-extern struct mutex dpm_mtx;
-
-/*
- * Used to serialize changes to the dpm_* lists.
- */
-extern struct mutex dpm_list_mtx;
-
-/*
- * The PM lists.
- */
-extern struct list_head dpm_active;
-extern struct list_head dpm_off;
-extern struct list_head dpm_off_irq;
-
-
-static inline struct dev_pm_info * to_pm_info(struct list_head * entry)
-{
-	return container_of(entry, struct dev_pm_info, entry);
-}
+extern struct list_head dpm_active;	/* The active device list */
 
 static inline struct device * to_device(struct list_head * entry)
 {
-	return container_of(to_pm_info(entry), struct device, power);
+	return container_of(entry, struct device, power.entry);
 }
 
 extern int device_pm_add(struct device *);
@@ -49,13 +28,6 @@ extern void device_pm_remove(struct devi
 extern int dpm_sysfs_add(struct device *);
 extern void dpm_sysfs_remove(struct device *);
 
-/*
- * resume.c
- */
-
-extern void dpm_resume(void);
-extern void dpm_power_up(void);
-
 #else /* CONFIG_PM_SLEEP */
 
 
--- a/drivers/base/power/resume.c
+++ /dev/null
@@ -1,149 +0,0 @@
-/*
- * resume.c - Functions for waking devices up.
- *
- * Copyright (c) 2003 Patrick Mochel
- * Copyright (c) 2003 Open Source Development Labs
- *
- * This file is released under the GPLv2
- *
- */
-
-#include <linux/device.h>
-#include <linux/resume-trace.h>
-#include "../base.h"
-#include "power.h"
-
-
-/**
- *	resume_device - Restore state for one device.
- *	@dev:	Device.
- *
- */
-
-static int resume_device(struct device * dev)
-{
-	int error = 0;
-
-	TRACE_DEVICE(dev);
-	TRACE_RESUME(0);
-
-	down(&dev->sem);
-
-	if (dev->bus && dev->bus->resume) {
-		dev_dbg(dev,"resuming\n");
-		error = dev->bus->resume(dev);
-	}
-
-	if (!error && dev->type && dev->type->resume) {
-		dev_dbg(dev,"resuming\n");
-		error = dev->type->resume(dev);
-	}
-
-	if (!error && dev->class && dev->class->resume) {
-		dev_dbg(dev,"class resume\n");
-		error = dev->class->resume(dev);
-	}
-
-	up(&dev->sem);
-
-	TRACE_RESUME(error);
-	return error;
-}
-
-
-static int resume_device_early(struct device * dev)
-{
-	int error = 0;
-
-	TRACE_DEVICE(dev);
-	TRACE_RESUME(0);
-	if (dev->bus && dev->bus->resume_early) {
-		dev_dbg(dev,"EARLY resume\n");
-		error = dev->bus->resume_early(dev);
-	}
-	TRACE_RESUME(error);
-	return error;
-}
-
-/*
- * Resume the devices that have either not gone through
- * the late suspend, or that did go through it but also
- * went through the early resume
- */
-void dpm_resume(void)
-{
-	mutex_lock(&dpm_list_mtx);
-	while(!list_empty(&dpm_off)) {
-		struct list_head * entry = dpm_off.next;
-		struct device * dev = to_device(entry);
-
-		get_device(dev);
-		list_move_tail(entry, &dpm_active);
-
-		mutex_unlock(&dpm_list_mtx);
-		resume_device(dev);
-		mutex_lock(&dpm_list_mtx);
-		put_device(dev);
-	}
-	mutex_unlock(&dpm_list_mtx);
-}
-
-
-/**
- *	device_resume - Restore state of each device in system.
- *
- *	Walk the dpm_off list, remove each entry, resume the device,
- *	then add it to the dpm_active list.
- */
-
-void device_resume(void)
-{
-	might_sleep();
-	mutex_lock(&dpm_mtx);
-	dpm_resume();
-	mutex_unlock(&dpm_mtx);
-}
-
-EXPORT_SYMBOL_GPL(device_resume);
-
-
-/**
- *	dpm_power_up - Power on some devices.
- *
- *	Walk the dpm_off_irq list and power each device up. This
- *	is used for devices that required they be powered down with
- *	interrupts disabled. As devices are powered on, they are moved
- *	to the dpm_active list.
- *
- *	Interrupts must be disabled when calling this.
- */
-
-void dpm_power_up(void)
-{
-	while(!list_empty(&dpm_off_irq)) {
-		struct list_head * entry = dpm_off_irq.next;
-		struct device * dev = to_device(entry);
-
-		list_move_tail(entry, &dpm_off);
-		resume_device_early(dev);
-	}
-}
-
-
-/**
- *	device_power_up - Turn on all devices that need special attention.
- *
- *	Power on system devices then devices that required we shut them down
- *	with interrupts disabled.
- *	Called with interrupts disabled.
- */
-
-void device_power_up(void)
-{
-	sysdev_resume();
-	dpm_power_up();
-}
-
-EXPORT_SYMBOL_GPL(device_power_up);
-
-
--- a/drivers/base/power/suspend.c
+++ /dev/null
@@ -1,210 +0,0 @@
-/*
- * suspend.c - Functions for putting devices to sleep.
- *
- * Copyright (c) 2003 Patrick Mochel
- * Copyright (c) 2003 Open Source Development Labs
- *
- * This file is released under the GPLv2
- *
- */
-
-#include <linux/device.h>
-#include <linux/kallsyms.h>
-#include <linux/pm.h>
-#include "../base.h"
-#include "power.h"
-
-/*
- * The entries in the dpm_active list are in a depth first order, simply
- * because children are guaranteed to be discovered after parents, and
- * are inserted at the back of the list on discovery.
- *
- * All list on the suspend path are done in reverse order, so we operate
- * on the leaves of the device tree (or forests, depending on how you want
- * to look at it ;) first. As nodes are removed from the back of the list,
- * they are inserted into the front of their destintation lists.
- *
- * Things are the reverse on the resume path - iterations are done in
- * forward order, and nodes are inserted at the back of their destination
- * lists. This way, the ancestors will be accessed before their descendents.
- */
-
-static inline char *suspend_verb(u32 event)
-{
-	switch (event) {
-	case PM_EVENT_SUSPEND:	return "suspend";
-	case PM_EVENT_FREEZE:	return "freeze";
-	case PM_EVENT_PRETHAW:	return "prethaw";
-	default:		return "(unknown suspend event)";
-	}
-}
-
-
-static void
-suspend_device_dbg(struct device *dev, pm_message_t state, char *info)
-{
-	dev_dbg(dev, "%s%s%s\n", info, suspend_verb(state.event),
-		((state.event == PM_EVENT_SUSPEND) && device_may_wakeup(dev)) ?
-		", may wakeup" : "");
-}
-
-/**
- *	suspend_device - Save state of one device.
- *	@dev:	Device.
- *	@state:	Power state device is entering.
- */
-
-static int suspend_device(struct device * dev, pm_message_t state)
-{
-	int error = 0;
-
-	down(&dev->sem);
-	if (dev->power.power_state.event) {
-		dev_dbg(dev, "PM: suspend %d-->%d\n",
-			dev->power.power_state.event, state.event);
-	}
-
-	if (dev->class && dev->class->suspend) {
-		suspend_device_dbg(dev, state, "class ");
-		error = dev->class->suspend(dev, state);
-		suspend_report_result(dev->class->suspend, error);
-	}
-
-	if (!error && dev->type && dev->type->suspend) {
-		suspend_device_dbg(dev, state, "type ");
-		error = dev->type->suspend(dev, state);
-		suspend_report_result(dev->type->suspend, error);
-	}
-
-	if (!error && dev->bus && dev->bus->suspend) {
-		suspend_device_dbg(dev, state, "");
-		error = dev->bus->suspend(dev, state);
-		suspend_report_result(dev->bus->suspend, error);
-	}
-	up(&dev->sem);
-	return error;
-}
-
-
-/*
- * This is called with interrupts off, only a single CPU
- * running. We can't acquire a mutex or semaphore (and we don't
- * need the protection)
- */
-static int suspend_device_late(struct device *dev, pm_message_t state)
-{
-	int error = 0;
-
-	if (dev->bus && dev->bus->suspend_late) {
-		suspend_device_dbg(dev, state, "LATE ");
-		error = dev->bus->suspend_late(dev, state);
-		suspend_report_result(dev->bus->suspend_late, error);
-	}
-	return error;
-}
-
-/**
- *	device_suspend - Save state and stop all devices in system.
- *	@state:		Power state to put each device in.
- *
- *	Walk the dpm_active list, call ->suspend() for each device, and move
- *	it to the dpm_off list.
- *
- *	(For historical reasons, if it returns -EAGAIN, that used to mean
- *	that the device would be called again with interrupts disabled.
- *	These days, we use the "suspend_late()" callback for that, so we
- *	print a warning and consider it an error).
- *
- *	If we get a different error, try and back out.
- *
- *	If we hit a failure with any of the devices, call device_resume()
- *	above to bring the suspended devices back to life.
- *
- */
-
-int device_suspend(pm_message_t state)
-{
-	int error = 0;
-
-	might_sleep();
-	mutex_lock(&dpm_mtx);
-	mutex_lock(&dpm_list_mtx);
-	while (!list_empty(&dpm_active) && error == 0) {
-		struct list_head * entry = dpm_active.prev;
-		struct device * dev = to_device(entry);
-
-		get_device(dev);
-		mutex_unlock(&dpm_list_mtx);
-
-		error = suspend_device(dev, state);
-
-		mutex_lock(&dpm_list_mtx);
-
-		/* Check if the device got removed */
-		if (!list_empty(&dev->power.entry)) {
-			/* Move it to the dpm_off list */
-			if (!error)
-				list_move(&dev->power.entry, &dpm_off);
-		}
-		if (error)
-			printk(KERN_ERR "Could not suspend device %s: "
-				"error %d%s\n",
-				kobject_name(&dev->kobj), error,
-				error == -EAGAIN ? " (please convert to suspend_late)" : "");
-		put_device(dev);
-	}
-	mutex_unlock(&dpm_list_mtx);
-	if (error)
-		dpm_resume();
-
-	mutex_unlock(&dpm_mtx);
-	return error;
-}
-
-EXPORT_SYMBOL_GPL(device_suspend);
-
-/**
- *	device_power_down - Shut down special devices.
- *	@state:		Power state to enter.
- *
- *	Walk the dpm_off_irq list, calling ->power_down() for each device that
- *	couldn't power down the device with interrupts enabled. When we're
- *	done, power down system devices.
- */
-
-int device_power_down(pm_message_t state)
-{
-	int error = 0;
-	struct device * dev;
-
-	while (!list_empty(&dpm_off)) {
-		struct list_head * entry = dpm_off.prev;
-
-		dev = to_device(entry);
-		error = suspend_device_late(dev, state);
-		if (error)
-			goto Error;
-		list_move(&dev->power.entry, &dpm_off_irq);
-	}
-
-	error = sysdev_suspend(state);
- Done:
-	return error;
- Error:
-	printk(KERN_ERR "Could not power down device %s: "
-		"error %d\n", kobject_name(&dev->kobj), error);
-	dpm_power_up();
-	goto Done;
-}
-
-EXPORT_SYMBOL_GPL(device_power_down);
-
-void __suspend_report_result(const char *function, void *fn, int ret)
-{
-	if (ret) {
-		printk(KERN_ERR "%s(): ", function);
-		print_fn_descriptor_symbol("%s() returns ", (unsigned long)fn);
-		printk("%d\n", ret);
-	}
-}
-EXPORT_SYMBOL_GPL(__suspend_report_result);


Patches currently in gregkh-2.6 which might be from stern@rowland.harvard.edu are

driver/sysfs-remove-first-pass-at-shadow-directory-support.patch
driver/sysfs-fix-i_mutex-locking-in-sysfs_get_dentry.patch
driver/sysfs-in-sysfs_lookup-don-t-open-code-sysfs_find_dirent.patch
driver/sysfs-cosmetic-changes-in-sysfs_lookup.patch
driver/sysfs-make-sysfs_add-remove_one-call-link-unlink_sibling-implictly.patch
driver/sysfs-make-sysfs_add_one-automatically-check-for-duplicate-entry.patch
driver/sysfs-make-sysfs_addrm_finish-return-void.patch
driver/sysfs-simplify-sysfs_rename_dir.patch
driver/sysfs-introduce-sysfs_rename_mutex.patch
driver/sysfs-clean-up-header-files.patch
driver/sysfs-make-sysfs_mount-static.patch
driver/sysfs-remove-s_dentry.patch
driver/sysfs-remove-sysfs_instantiate.patch
driver/sysfs-rewrite-rename-in-terms-of-sysfs-dirents.patch
driver/sysfs-move-all-of-inode-initialization-into-sysfs_init_inode.patch
driver/sysfs-rewrite-sysfs_drop_dentry.patch
driver/sysfs-rewrite-sysfs_move_dir-in-terms-of-sysfs-dirents.patch
driver/sysfs-simplify-readdir.patch
driver/sysfs-simply-sysfs_get_dentry.patch
driver/sysfs-use-kill_anon_super.patch
driver/sysfs-fix-comments-of-sysfs_add-remove_one.patch
driver/sysfs-fix-sysfs_chmod_file-such-that-it-updates-sd-s_mode-too.patch
driver/sysfs-implement-sysfs_open_dirent.patch
driver/sysfs-kill-sysfs_update_file.patch
driver/sysfs-kill-unnecessary-null-pointer-check-in-sysfs_release.patch
driver/sysfs-kill-unnecessary-sysfs_get-in-open-paths.patch
driver/sysfs-make-bin-attr-open-get-active-reference-of-parent-too.patch
driver/sysfs-make-s_elem-an-anonymous-union.patch
driver/sysfs-make-sysfs_root-a-regular-directory-dirent.patch
driver/sysfs-move-sysfs-file-poll-implementation-to-sysfs_open_dirent.patch
driver/sysfs-move-sysfs_dirent-s_children-into-sysfs_dirent-s_dir.patch
driver/sysfs-open-code-sysfs_attach_dentry.patch
driver/sysfs-reposition-sysfs_dirent-s_mode.patch
driver/pm-acquire-device-locks-prior-to-suspending.patch
driver/pm-merge-device-power-management-source-files.patch
driver/sysfs-add-copyrights.patch
usb/usb-add-ep-enable.patch
usb/usb-avoid-the-donelist-after-an-error-in-ohci-hcd.patch
usb/usb-add-direction-bit-to-urb-transfer_flags.patch
usb/usb-add-urb-ep.patch
usb/usb-address-0-handling-during-device-initialization.patch
usb/usb-avoid-urb-pipe-in-usbfs.patch
usb/usb-avoid-urb-pipe-in-usbmon.patch
usb/usb-avoid-using-urb-pipe-in-usbcore.patch
usb/usb-cleanup-for-previous-patches.patch
usb/usb-gadget-file-storage-gadget-cleanups.patch
usb/usb-separate-out-endpoint-queue-management-and-dma-mapping-routines.patch
usb/usb-update-spinlock-usage-for-root-hub-urbs.patch
usb/usb-fix-mistake-in-usb_hcd_giveback_urb.patch
usb/usb-less-restrictive-command-checking-in-g-file-storage.patch
usb/usb-reorganize-urb-status-use-in-dummy-hcd.patch
usb/usb-reorganize-urb-status-use-in-ehci-hcd.patch
usb/usb-reorganize-urb-status-use-in-ohci-hcd.patch
usb/usb-reorganize-urb-status-use-in-r8a66597-hcd.patch
usb/usb-reorganize-urb-status-use-in-sl811-hcd.patch
usb/usb-reorganize-urb-status-use-in-usbmon.patch
usb/usb-eliminate-urb-status-usage.patch
usb/usb-cleanups-for-g_file_storage.patch
usb/usb-don-t-touch-sysfs-stuff-when-altsetting-is-unchanged.patch
usb/usb-make-hcds-responsible-for-managing-endpoint-queues.patch
usb/usb-get-rid-of-urb-lock.patch
usb/usb-remove-traces-of-urb-status-from-usbcore.patch
usb/usb-usbmon-doc-update-mention-new-wildcard-bus.patch
usb/usbmon-update-pipe-removal-to-suit-my-taste.patch
usb/usb-break-apart-flush_endpoint-and-disable_endpoint.patch
usb/usb-fix-location-of-statement-label-in-dummy-hcd.patch
usb/usb-flush-outstanding-urbs-when-suspending.patch
usb/usb-get-rid-of-annoying-endpoint-release-message.patch
usb/usb-move-decision-to-ignore-freeze-events.patch
usb/usb-remove-unnecessary-tests-in-isp116x-and-sl811.patch
usb/usb-add-urb-unlinked-field.patch
usb/usb-centralize-eremoteio-handling.patch
usb/usb-driver-for-ch341-usb-serial-adaptor.patch
usb/usb-minor-fixes-for-r8a66597-driver.patch
usb/usb-remove-iso-status-value-in-uhci-hcd.patch
usb/usb-fix-double-frees-in-error-code-paths-of-ipaq-driver.patch
usb/usb-fix-limited_power-setting-mistake-in-hub.c.patch
usb/usb-don-t-propagate-freeze-or-prethaw-suspends.patch
usb/usb-remove-usb_quirk_no_autosuspend.patch
usb/usb-unusual_devs-modification-for-nikon-d200.patch
usb/usb-unusual_devs-update-for-nokia-6131.patch
usb/usb-unusual_devs-entry-for-nikon-dsc-d2xs.patch
