From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6/7] PM: add no_callbacks flag
Date: Fri, 24 Sep 2010 16:39:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009241636520.1287-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Some devices, such as USB interfaces, cannot be power-managed
independently of their parents, i.e., they cannot be put in low power
while the parent remains at full power.  This patch (as1425) creates a
new "no_callbacks" flag, which tells the PM core not to invoke the
runtime-PM callback routines for the such devices but instead to
assume that the callbacks always succeed.  In addition, the
non-debugging runtime-PM sysfs attributes for the devices are removed,
since they are pretty much meaningless.

The advantage of this scheme comes not so much from avoiding the
callbacks themselves, but rather from the fact that without the need
for a process context in which to run the callbacks, more work can be
done in interrupt context.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/include/linux/pm.h
===================================================================
--- usb-2.6.orig/include/linux/pm.h
+++ usb-2.6/include/linux/pm.h
@@ -41,6 +41,12 @@ extern void (*pm_power_off_prepare)(void
 
 struct device;
 
+#ifdef CONFIG_PM
+extern const char power_group_name[];		/* = "power" */
+#else
+#define power_group_name	NULL
+#endif
+
 typedef struct pm_message {
 	int event;
 } pm_message_t;
@@ -474,6 +480,7 @@ struct dev_pm_info {
 	unsigned int		deferred_resume:1;
 	unsigned int		run_wake:1;
 	unsigned int		runtime_auto:1;
+	unsigned int		no_callbacks:1;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
 	int			runtime_error;
Index: usb-2.6/include/linux/pm_runtime.h
===================================================================
--- usb-2.6.orig/include/linux/pm_runtime.h
+++ usb-2.6/include/linux/pm_runtime.h
@@ -36,6 +36,7 @@ extern void pm_runtime_forbid(struct dev
 extern int pm_generic_runtime_idle(struct device *dev);
 extern int pm_generic_runtime_suspend(struct device *dev);
 extern int pm_generic_runtime_resume(struct device *dev);
+extern void pm_runtime_no_callbacks(struct device *dev);
 
 static inline bool pm_children_suspended(struct device *dev)
 {
@@ -110,6 +111,7 @@ static inline bool pm_runtime_suspended(
 static inline int pm_generic_runtime_idle(struct device *dev) { return 0; }
 static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
 static inline int pm_generic_runtime_resume(struct device *dev) { return 0; }
+static inline void pm_runtime_no_callbacks(struct device *dev) {}
 
 #endif /* !CONFIG_PM_RUNTIME */
 
Index: usb-2.6/drivers/base/power/power.h
===================================================================
--- usb-2.6.orig/drivers/base/power/power.h
+++ usb-2.6/drivers/base/power/power.h
@@ -59,6 +59,7 @@ static inline void device_pm_move_last(s
 
 extern int dpm_sysfs_add(struct device *);
 extern void dpm_sysfs_remove(struct device *);
+extern void rpm_sysfs_remove(struct device *);
 
 #else /* CONFIG_PM */
 
Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -10,8 +10,10 @@
 #include <linux/sched.h>
 #include <linux/pm_runtime.h>
 #include <linux/jiffies.h>
+#include "power.h"
 
 static int rpm_resume(struct device *dev, int rpmflags);
+static int rpm_suspend(struct device *dev, int rpmflags);
 
 /**
  * update_pm_runtime_accounting - Update the time accounting of power states
@@ -148,6 +150,12 @@ static int rpm_idle(struct device *dev, 
 	/* Pending requests need to be canceled. */
 	dev->power.request = RPM_REQ_NONE;
 
+	if (dev->power.no_callbacks) {
+		/* Assume ->runtime_idle() callback would have suspended. */
+		retval = rpm_suspend(dev, rpmflags);
+		goto out;
+	}
+
 	/* Carry out an asynchronous or a synchronous idle notification. */
 	if (rpmflags & RPM_ASYNC) {
 		dev->power.request = RPM_REQ_IDLE;
@@ -254,6 +262,10 @@ static int rpm_suspend(struct device *de
 		goto repeat;
 	}
 
+	dev->power.deferred_resume = false;
+	if (dev->power.no_callbacks)
+		goto no_callback;	/* Assume success. */
+
 	/* Carry out an asynchronous or a synchronous suspend. */
 	if (rpmflags & RPM_ASYNC) {
 		dev->power.request = RPM_REQ_SUSPEND;
@@ -265,7 +277,6 @@ static int rpm_suspend(struct device *de
 	}
 
 	__update_runtime_status(dev, RPM_SUSPENDING);
-	dev->power.deferred_resume = false;
 
 	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend) {
 		spin_unlock_irq(&dev->power.lock);
@@ -305,6 +316,7 @@ static int rpm_suspend(struct device *de
 			pm_runtime_cancel_pending(dev);
 		}
 	} else {
+ no_callback:
 		__update_runtime_status(dev, RPM_SUSPENDED);
 		pm_runtime_deactivate_timer(dev);
 
@@ -409,6 +421,23 @@ static int rpm_resume(struct device *dev
 		goto repeat;
 	}
 
+	/*
+	 * See if we can skip waking up the parent.  This is safe only if
+	 * power.no_callbacks is set, because otherwise we don't know whether
+	 * the resume will actually succeed.
+	 */
+	if (dev->power.no_callbacks && !parent && dev->parent) {
+		spin_lock(&dev->parent->power.lock);
+		if (dev->parent->power.disable_depth > 0
+		    || dev->parent->power.ignore_children
+		    || dev->parent->power.runtime_status == RPM_ACTIVE) {
+			atomic_inc(&dev->parent->power.child_count);
+			spin_unlock(&dev->parent->power.lock);
+			goto no_callback;	/* Assume success. */
+		}
+		spin_unlock(&dev->parent->power.lock);
+	}
+
 	/* Carry out an asynchronous or a synchronous resume. */
 	if (rpmflags & RPM_ASYNC) {
 		dev->power.request = RPM_REQ_RESUME;
@@ -449,6 +478,9 @@ static int rpm_resume(struct device *dev
 		goto repeat;
 	}
 
+	if (dev->power.no_callbacks)
+		goto no_callback;	/* Assume success. */
+
 	__update_runtime_status(dev, RPM_RESUMING);
 
 	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume) {
@@ -482,6 +514,7 @@ static int rpm_resume(struct device *dev
 		__update_runtime_status(dev, RPM_SUSPENDED);
 		pm_runtime_cancel_pending(dev);
 	} else {
+ no_callback:
 		__update_runtime_status(dev, RPM_ACTIVE);
 		if (parent)
 			atomic_inc(&parent->power.child_count);
@@ -955,6 +988,25 @@ void pm_runtime_allow(struct device *dev
 EXPORT_SYMBOL_GPL(pm_runtime_allow);
 
 /**
+ * pm_runtime_no_callbacks - Ignore run-time PM callbacks for a device.
+ * @dev: Device to handle.
+ *
+ * Set the power.no_callbacks flag, which tells the PM core that this
+ * device is power-managed through its parent and has no run-time PM
+ * callbacks of its own.  The run-time sysfs attributes will be removed.
+ *
+ */
+void pm_runtime_no_callbacks(struct device *dev)
+{
+	spin_lock_irq(&dev->power.lock);
+	dev->power.no_callbacks = 1;
+	spin_unlock_irq(&dev->power.lock);
+	if (device_is_registered(dev))
+		rpm_sysfs_remove(dev);
+}
+EXPORT_SYMBOL_GPL(pm_runtime_no_callbacks);
+
+/**
  * pm_runtime_init - Initialize run-time PM fields in given device object.
  * @dev: Device object to initialize.
  */
Index: usb-2.6/drivers/base/power/sysfs.c
===================================================================
--- usb-2.6.orig/drivers/base/power/sysfs.c
+++ usb-2.6/drivers/base/power/sysfs.c
@@ -81,6 +81,9 @@
 static const char enabled[] = "enabled";
 static const char disabled[] = "disabled";
 
+const char power_group_name[] = "power";
+EXPORT_SYMBOL_GPL(power_group_name);
+
 #ifdef CONFIG_PM_RUNTIME
 static const char ctrl_auto[] = "auto";
 static const char ctrl_on[] = "on";
@@ -279,12 +282,6 @@ static DEVICE_ATTR(async, 0644, async_sh
 #endif /* CONFIG_PM_ADVANCED_DEBUG */
 
 static struct attribute * power_attrs[] = {
-#ifdef CONFIG_PM_RUNTIME
-	&dev_attr_control.attr,
-	&dev_attr_runtime_status.attr,
-	&dev_attr_runtime_suspended_time.attr,
-	&dev_attr_runtime_active_time.attr,
-#endif
 	&dev_attr_wakeup.attr,
 #ifdef CONFIG_PM_SLEEP
 	&dev_attr_wakeup_count.attr,
@@ -292,6 +289,7 @@ static struct attribute * power_attrs[] 
 #ifdef CONFIG_PM_ADVANCED_DEBUG
 	&dev_attr_async.attr,
 #ifdef CONFIG_PM_RUNTIME
+	&dev_attr_runtime_status.attr,
 	&dev_attr_runtime_usage.attr,
 	&dev_attr_runtime_active_kids.attr,
 	&dev_attr_runtime_enabled.attr,
@@ -300,10 +298,52 @@ static struct attribute * power_attrs[] 
 	NULL,
 };
 static struct attribute_group pm_attr_group = {
-	.name	= "power",
+	.name	= power_group_name,
 	.attrs	= power_attrs,
 };
 
+#ifdef CONFIG_PM_RUNTIME
+
+static struct attribute *runtime_attrs[] = {
+#ifndef CONFIG_PM_ADVANCED_DEBUG
+	&dev_attr_runtime_status.attr,
+#endif
+	&dev_attr_control.attr,
+	&dev_attr_runtime_suspended_time.attr,
+	&dev_attr_runtime_active_time.attr,
+	NULL,
+};
+static struct attribute_group pm_runtime_attr_group = {
+	.name	= power_group_name,
+	.attrs	= runtime_attrs,
+};
+
+int dpm_sysfs_add(struct device *dev)
+{
+	int rc;
+
+	rc = sysfs_create_group(&dev->kobj, &pm_attr_group);
+	if (rc == 0 && !dev->power.no_callbacks) {
+		rc = sysfs_merge_group(&dev->kobj, &pm_runtime_attr_group);
+		if (rc)
+			sysfs_remove_group(&dev->kobj, &pm_attr_group);
+	}
+	return rc;
+}
+
+void rpm_sysfs_remove(struct device *dev)
+{
+	sysfs_unmerge_group(&dev->kobj, &pm_runtime_attr_group);
+}
+
+void dpm_sysfs_remove(struct device *dev)
+{
+	rpm_sysfs_remove(dev);
+	sysfs_remove_group(&dev->kobj, &pm_attr_group);
+}
+
+#else /* CONFIG_PM_RUNTIME */
+
 int dpm_sysfs_add(struct device * dev)
 {
 	return sysfs_create_group(&dev->kobj, &pm_attr_group);
@@ -313,3 +353,5 @@ void dpm_sysfs_remove(struct device * de
 {
 	sysfs_remove_group(&dev->kobj, &pm_attr_group);
 }
+
+#endif
Index: usb-2.6/Documentation/power/runtime_pm.txt
===================================================================
--- usb-2.6.orig/Documentation/power/runtime_pm.txt
+++ usb-2.6/Documentation/power/runtime_pm.txt
@@ -1,6 +1,7 @@
 Run-time Power Management Framework for I/O Devices
 
 (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
+(C) 2010 Alan Stern <stern@rowland.harvard.edu>
 
 1. Introduction
 
@@ -230,6 +231,11 @@ defined in include/linux/pm.h:
       interface; it may only be modified with the help of the pm_runtime_allow()
       and pm_runtime_forbid() helper functions
 
+  unsigned int no_callbacks;
+    - indicates that the device does not use the run-time PM callbacks (see
+      Section 8); it may be modified only by the pm_runtime_no_callbacks()
+      helper function
+
 All of the above fields are members of the 'power' member of 'struct device'.
 
 4. Run-time PM Device Helper Functions
@@ -349,6 +355,11 @@ drivers/base/power/runtime.c and include
       counter (used by the /sys/devices/.../power/control interface to
       effectively prevent the device from being power managed at run time)
 
+  void pm_runtime_no_callbacks(struct device *dev);
+    - set the power.no_callbacks flag for the device and remove the run-time
+      PM attributes from /sys/devices/.../power (or prevent them from being
+      added when the device is registered)
+
 It is safe to execute the following helper functions from interrupt context:
 
 pm_request_idle()
@@ -524,3 +535,29 @@ poweroff and run-time suspend callback, 
 restore, and run-time resume, can achieve this with the help of the
 UNIVERSAL_DEV_PM_OPS macro defined in include/linux/pm.h (possibly setting its
 last argument to NULL).
+
+8. "No-Callback" Devices
+
+Some "devices" are only logical sub-devices of their parent and cannot be
+power-managed on their own.  (The prototype example is a USB interface.  Entire
+USB devices can go into low-power mode or send wake-up requests, but neither is
+possible for individual interfaces.)  The drivers for these devices have no
+need of run-time PM callbacks; if the callbacks did exist, ->runtime_suspend()
+and ->runtime_resume() would always return 0 without doing anything else and
+->runtime_idle() would always call pm_runtime_suspend().
+
+Subsystems can tell the PM core about these devices by calling
+pm_runtime_no_callbacks().  This should be done after the device structure is
+initialized and before it is registered (although after device registration is
+also okay).  The routine will set the device's power.no_callbacks flag and
+prevent the non-debugging run-time PM sysfs attributes from being created.
+
+When power.no_callbacks is set, the PM core will not invoke the
+->runtime_idle(), ->runtime_suspend(), or ->runtime_resume() callbacks.
+Instead it will assume that suspends and resumes always succeed and that idle
+devices should be suspended.
+
+As a consequence, the PM core will never directly inform the device's subsystem
+or driver about run-time power changes.  Instead, the driver for the device's
+parent must take responsibility for telling the device's driver when the
+parent's power state changes.
