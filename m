From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC] PM: Using runtime PM callbacks for system suspend/resume
Date: Thu, 07 Sep 2017 00:14:06 +0200
Message-ID: <5559236.6K256zbtpK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

It occurred to me earlier today that it should be possible to modify the
PM core to get the functionality of pm_runtime_force_suspend/resume() from it
in a somewhat nicer way which should be possible to extend to middle layers
(bus types, PM domains etc).

Say we have a flag telling the PM core to use the runtime PM path at the
late suspend and early resume stages of system suspend/resume directly if
it can't find "proper" callbacks for that.  It is called DPM_FLAG_USE_RPM in
the prototype patch below.

The idea is to set only ->runtime_suspend and ->runtime_resume in the driver's
dev_pm_ops and then set that flag in ->probe and be done.  If the core sees
the flag and doesn't see any "original" system sleep callbacks at the stages
in question, it will automatically switch over to the runtime PM path and
leave the device alone if it is already runtime-suspended.

One nice thing about it is that it will happen at the core level and not in
a driver callback, so all of the concerns regarding layering violations are
simply not relevant any more.  Also, at least in principle, it should be
possible to extend this to middle layers that need to do some non-trivial PM
handling, simply by making them look at that flag and honor in the same way
as the core does that.  This way drivers may still be able to reuse their
runtime PM stuff for handling system sleep transitions even if the middle
layers they need to work with have different things to do for runtime PM
and system suspend/resume.  Even modifying *all* middle layers in the tree to
do take DPM_FLAG_USE_RPM into accout if set is not out of the question as far
as I'm concerned.

On top of this it should be possible to add the optimization allowing devices
to stay suspended after system resume even if they were not suspended before.
IMO it is better to add a separate flag for enabling it in case some drivers
don't want it, though.

So the below is just the core part and mostly a prototype to illustrate the
idea, but at this point it looks promising to me.

Comments?  Concerns?


Prototype-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/dd.c            |    2 ++
 drivers/base/power/main.c    |   23 ++++++++++++++++++++---
 drivers/base/power/runtime.c |   12 ++++++++++--
 include/linux/device.h       |   10 ++++++++++
 include/linux/pm.h           |   26 ++++++++++++++++++++++++++
 include/linux/pm_runtime.h   |    3 +++
 6 files changed, 71 insertions(+), 5 deletions(-)

Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -63,6 +63,8 @@ typedef struct pm_message {
 	int event;
 } pm_message_t;
 
+typedef int (*pm_callback_t)(struct device *);
+
 /**
  * struct dev_pm_ops - device PM callbacks.
  *
@@ -550,6 +552,29 @@ struct pm_subsys_data {
 #endif
 };
 
+/*
+ * Driver flags to control system suspend/resume behavior.
+ *
+ * These flags can be set by device drivers at the probe time.  They need not be
+ * cleared by the drivers as the driver core will take care of that.
+ *
+ * USE_RPM: Use runtime PM callbacks for system suspend and resume.
+ *
+ * Setting USE_RPM instructs the PM core that if the device's ->suspend_late
+ * callback turns out to be NULL, the ->runtime_suspend one should be used
+ * instead of it unless the device is already runtime-suspended at that point.
+ * Analogously, if this flag is set and the device's ->resume_early callback
+ * turns out to be NULL, ->runtime_resume should be used instead of it unless
+ * the device was runtime-suspended during system suspend (in which case it
+ * can remain suspended).  However, if any of these callbacks is present, it
+ * will be invoked normally under the assumption that the provider of it (a bus
+ * type, a PM domain etc) will honor the driver's request to use its
+ * ->runtime_suspend as ->suspend_late (unless the device is already suspended)
+ * and its ->runtime_resume as ->resume_early (unless the device was suspended
+ * before, so it can remain suspended).
+ */
+#define DPM_FLAG_USE_RPM	BIT(0)
+
 struct dev_pm_info {
 	pm_message_t		power_state;
 	unsigned int		can_wakeup:1;
@@ -561,6 +586,7 @@ struct dev_pm_info {
 	bool			is_late_suspended:1;
 	bool			early_init:1;	/* Owned by the PM core */
 	bool			direct_complete:1;	/* Owned by the PM core */
+	unsigned int		driver_flags;
 	spinlock_t		lock;
 #ifdef CONFIG_PM_SLEEP
 	struct list_head	entry;
Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -436,6 +436,7 @@ pinctrl_bind_failed:
 	if (dev->pm_domain && dev->pm_domain->dismiss)
 		dev->pm_domain->dismiss(dev);
 	pm_runtime_reinit(dev);
+	dev_pm_set_driver_flags(dev, 0);
 
 	switch (ret) {
 	case -EPROBE_DEFER:
@@ -841,6 +842,7 @@ static void __device_release_driver(stru
 		if (dev->pm_domain && dev->pm_domain->dismiss)
 			dev->pm_domain->dismiss(dev);
 		pm_runtime_reinit(dev);
+		dev_pm_set_driver_flags(dev, 0);
 
 		klist_remove(&dev->p->knode_driver);
 		device_pm_check_callbacks(dev);
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -38,8 +38,6 @@
 #include "../base.h"
 #include "power.h"
 
-typedef int (*pm_callback_t)(struct device *);
-
 /*
  * The entries in the dpm_list list are in a depth first order, simply
  * because children are guaranteed to be discovered after parents, and
@@ -712,6 +710,12 @@ static int device_resume_early(struct de
 		callback = pm_late_early_op(dev->driver->pm, state);
 	}
 
+	if (!callback && dev_pm_driver_flag_set(dev, DPM_FLAG_USE_RPM) &&
+	    !pm_runtime_status_suspended(dev)) {
+		info = "runtime PM resume ";
+		callback = pm_runtime_resume_hook(dev);
+	}
+
 	error = dpm_run_callback(callback, dev, state, info);
 	dev->power.is_late_suspended = false;
 
@@ -1259,6 +1263,12 @@ static int __device_suspend_late(struct
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
 
+	if (WARN_ON(!pm_runtime_enabled(dev) &&
+		    dev_pm_driver_flag_set(dev, DPM_FLAG_USE_RPM))) {
+		error = -EINVAL;
+		async_error = error;
+	}
+
 	__pm_runtime_disable(dev, false);
 
 	dpm_wait_for_subordinate(dev, async);
@@ -1293,6 +1303,12 @@ static int __device_suspend_late(struct
 		callback = pm_late_early_op(dev->driver->pm, state);
 	}
 
+	if (!callback && dev_pm_driver_flag_set(dev, DPM_FLAG_USE_RPM) &&
+	    !pm_runtime_status_suspended(dev)) {
+		info = "runtime PM suspend ";
+		callback = pm_runtime_suspend_hook(dev);
+	}
+
 	error = dpm_run_callback(callback, dev, state, info);
 	if (!error)
 		dev->power.is_late_suspended = true;
@@ -1864,6 +1880,7 @@ void device_pm_check_callbacks(struct de
 		(!dev->class || pm_ops_is_empty(dev->class->pm)) &&
 		(!dev->type || pm_ops_is_empty(dev->type->pm)) &&
 		(!dev->pm_domain || pm_ops_is_empty(&dev->pm_domain->ops)) &&
-		(!dev->driver || pm_ops_is_empty(dev->driver->pm));
+		(!dev->driver || pm_ops_is_empty(dev->driver->pm)) &&
+		!dev_pm_driver_flag_set(dev, DPM_FLAG_USE_RPM);
 	spin_unlock_irq(&dev->power.lock);
 }
Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -26,6 +26,9 @@
 #ifdef CONFIG_PM
 extern struct workqueue_struct *pm_wq;
 
+extern pm_callback_t pm_runtime_suspend_hook(struct device *dev);
+extern pm_callback_t pm_runtime_resume_hook(struct device *dev);
+
 static inline bool queue_pm_work(struct work_struct *work)
 {
 	return queue_work(pm_wq, work);
Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -16,8 +16,6 @@
 #include "../base.h"
 #include "power.h"
 
-typedef int (*pm_callback_t)(struct device *);
-
 static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
 {
 	pm_callback_t cb;
@@ -48,6 +46,16 @@ static pm_callback_t __rpm_get_callback(
 #define RPM_GET_CALLBACK(dev, callback) \
 		__rpm_get_callback(dev, offsetof(struct dev_pm_ops, callback))
 
+pm_callback_t pm_runtime_suspend_hook(struct device *dev)
+{
+	return RPM_GET_CALLBACK(dev, runtime_suspend);
+}
+
+pm_callback_t pm_runtime_resume_hook(struct device *dev)
+{
+	return RPM_GET_CALLBACK(dev, runtime_resume);
+}
+
 static int rpm_resume(struct device *dev, int rpmflags);
 static int rpm_suspend(struct device *dev, int rpmflags);
 
Index: linux-pm/include/linux/device.h
===================================================================
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -1076,6 +1076,16 @@ static inline void dev_pm_syscore_device
 #endif
 }
 
+static inline void dev_pm_set_driver_flags(struct device *dev, unsigned int flags)
+{
+	dev->power.driver_flags = flags;
+}
+
+static inline bool dev_pm_driver_flag_set(struct device *dev, unsigned int flag)
+{
+	return !!(dev->power.driver_flags & flag);
+}
+
 static inline void device_lock(struct device *dev)
 {
 	mutex_lock(&dev->mutex);
