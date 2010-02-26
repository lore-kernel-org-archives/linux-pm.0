From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: add dpm_use_runtime_{suspend,
	resume} helper functions
Date: Fri, 26 Feb 2010 11:46:57 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002261130440.2029-100000@iolanthe.rowland.org>
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

This patch (as1345) adds utility routines pm_is_runtime_suspended(),
dpm_use_runtime_suspend(), and dpm_use_runtime_resume() to the PM
core.  The first provides an API to access a device's runtime PM
status, and the other two give drivers an easy way to use the same
callback routines for both system PM and runtime PM.  The new
functions can be used as ->suspend() and ->resume() methods; they will
invoke the device's ->runtime_suspend() and runtime_resume() callbacks
to do the work.

This facility was requested by people working on embedded systems.

It is a little awkward, because it means the runtime callbacks may be
invoked whenever either CONFIG_PM_SLEEP or CONFIG_PM_RUNTIME is
enabled.  Since these settings are independent, the patch separates
out the code for invoking the callbacks into a new source file:
invoke_runtime.c.  The new file gets built if either config option is
on.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Note that this patch does introduce a small semantic change.  -ENOSYS
is no longer available for use as a return value from the runtime
callbacks, because it is reserved to mean that there is no callback
function.


Index: usb-2.6/include/linux/pm.h
===================================================================
--- usb-2.6.orig/include/linux/pm.h
+++ usb-2.6/include/linux/pm.h
@@ -508,6 +508,9 @@ extern void __suspend_report_result(cons
 		__suspend_report_result(__func__, fn, ret);		\
 	} while (0)
 
+extern int dpm_use_runtime_suspend(struct device *dev);
+extern int dpm_use_runtime_resume(struct device *dev);
+
 #else /* !CONFIG_PM_SLEEP */
 
 #define device_pm_lock() do {} while (0)
@@ -520,6 +523,9 @@ static inline int dpm_suspend_start(pm_m
 
 #define suspend_report_result(fn, ret)		do {} while (0)
 
+#define dpm_use_runtime_suspend		NULL
+#define dpm_use_runtime_resume		NULL
+
 #endif /* !CONFIG_PM_SLEEP */
 
 /* How to reorder dpm_list after device_move() */
Index: usb-2.6/include/linux/pm_runtime.h
===================================================================
--- usb-2.6.orig/include/linux/pm_runtime.h
+++ usb-2.6/include/linux/pm_runtime.h
@@ -60,6 +60,11 @@ static inline void device_set_run_wake(s
 	dev->power.run_wake = enable;
 }
 
+static inline bool pm_is_runtime_suspended(struct device *dev)
+{
+	return dev->power.runtime_status == RPM_SUSPENDED;
+}
+
 #else /* !CONFIG_PM_RUNTIME */
 
 static inline int pm_runtime_idle(struct device *dev) { return -ENOSYS; }
@@ -86,6 +91,9 @@ static inline void pm_runtime_put_noidle
 static inline bool device_run_wake(struct device *dev) { return false; }
 static inline void device_set_run_wake(struct device *dev, bool enable) {}
 
+static inline bool pm_is_runtime_suspended(struct device *dev)
+		{ return false; }
+
 #endif /* !CONFIG_PM_RUNTIME */
 
 static inline int pm_runtime_get(struct device *dev)
Index: usb-2.6/drivers/base/power/power.h
===================================================================
--- usb-2.6.orig/drivers/base/power/power.h
+++ usb-2.6/drivers/base/power/power.h
@@ -72,3 +72,14 @@ static inline void dpm_sysfs_remove(stru
 }
 
 #endif
+
+#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
+
+/*
+ * invoke_runtime.c
+ */
+extern void dpm_invoke_runtime_idle(struct device *dev);
+extern int dpm_invoke_runtime_suspend(struct device *dev);
+extern int dpm_invoke_runtime_resume(struct device *dev);
+
+#endif
Index: usb-2.6/drivers/base/power/Makefile
===================================================================
--- usb-2.6.orig/drivers/base/power/Makefile
+++ usb-2.6/drivers/base/power/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_PM)	+= sysfs.o
-obj-$(CONFIG_PM_SLEEP)	+= main.o
-obj-$(CONFIG_PM_RUNTIME)	+= runtime.o
+obj-$(CONFIG_PM_SLEEP)	+= main.o invoke_runtime.o
+obj-$(CONFIG_PM_RUNTIME)	+= runtime.o invoke_runtime.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
Index: usb-2.6/drivers/base/power/main.c
===================================================================
--- usb-2.6.orig/drivers/base/power/main.c
+++ usb-2.6/drivers/base/power/main.c
@@ -936,3 +936,51 @@ void __suspend_report_result(const char 
 		printk(KERN_ERR "%s(): %pF returns %d\n", function, fn, ret);
 }
 EXPORT_SYMBOL_GPL(__suspend_report_result);
+
+#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
+
+/* Convenience routines for drivers that want to use the same functions
+ * for system suspend/resume and runtime suspend/resume:
+ * Set driver->pm_ops->suspend = dpm_use_runtime_suspend and
+ * driver->pm_ops->resume = dpm_use_runtime_resume.
+ */
+
+/**
+ * dpm_use_runtime_suspend - Perform system suspend via runtime_suspend method
+ * @dev: Device to suspend.
+ *
+ * This convenience routine implements a system suspend by invoking the
+ * runtime_suspend method.  The method is invoked only if @dev isn't already
+ * runtime-suspended.
+ */
+int dpm_use_runtime_suspend(struct device *dev)
+{
+	if (pm_is_runtime_suspended(dev))
+		return 0;
+	return dpm_invoke_runtime_suspend(dev);
+}
+EXPORT_SYMBOL_GPL(dpm_use_runtime_suspend);
+
+/**
+ * dpm_use_runtime_resume - Perform system resume via runtime_resume method
+ * @dev: Device to resume.
+ *
+ * This convenience routine implements a system resume by invoking the
+ * runtime_resume method.  If the method is successful then the device's
+ * runtime status is set to RPM_ACTIVE.
+ */
+int dpm_use_runtime_resume(struct device *dev)
+{
+	int retval;
+
+	retval = dpm_invoke_runtime_resume(dev);
+	if (retval == 0) {
+		pm_runtime_disable(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	}
+	return retval;
+}
+EXPORT_SYMBOL_GPL(dpm_use_runtime_resume);
+
+#endif /* defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME) */
Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -10,6 +10,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/jiffies.h>
 
+#include "power.h"
+
 static int __pm_runtime_resume(struct device *dev, bool from_wq);
 static int __pm_request_idle(struct device *dev);
 static int __pm_request_resume(struct device *dev);
@@ -79,26 +81,9 @@ static int __pm_runtime_idle(struct devi
 
 	dev->power.idle_notification = true;
 
-	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_idle) {
-		spin_unlock_irq(&dev->power.lock);
-
-		dev->bus->pm->runtime_idle(dev);
-
-		spin_lock_irq(&dev->power.lock);
-	} else if (dev->type && dev->type->pm && dev->type->pm->runtime_idle) {
-		spin_unlock_irq(&dev->power.lock);
-
-		dev->type->pm->runtime_idle(dev);
-
-		spin_lock_irq(&dev->power.lock);
-	} else if (dev->class && dev->class->pm
-	    && dev->class->pm->runtime_idle) {
-		spin_unlock_irq(&dev->power.lock);
-
-		dev->class->pm->runtime_idle(dev);
-
-		spin_lock_irq(&dev->power.lock);
-	}
+	spin_unlock_irq(&dev->power.lock);
+	dpm_invoke_runtime_idle(dev);
+	spin_lock_irq(&dev->power.lock);
 
 	dev->power.idle_notification = false;
 	wake_up_all(&dev->power.wait_queue);
@@ -200,32 +185,11 @@ int __pm_runtime_suspend(struct device *
 	dev->power.runtime_status = RPM_SUSPENDING;
 	dev->power.deferred_resume = false;
 
-	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->bus->pm->runtime_suspend(dev);
-
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else if (dev->type && dev->type->pm
-	    && dev->type->pm->runtime_suspend) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->type->pm->runtime_suspend(dev);
-
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else if (dev->class && dev->class->pm
-	    && dev->class->pm->runtime_suspend) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->class->pm->runtime_suspend(dev);
-
-		spin_lock_irq(&dev->power.lock);
+	spin_unlock_irq(&dev->power.lock);
+	retval = dpm_invoke_runtime_suspend(dev);
+	spin_lock_irq(&dev->power.lock);
+	if (retval != -ENOSYS)
 		dev->power.runtime_error = retval;
-	} else {
-		retval = -ENOSYS;
-	}
 
 	if (retval) {
 		dev->power.runtime_status = RPM_ACTIVE;
@@ -381,32 +345,11 @@ int __pm_runtime_resume(struct device *d
 
 	dev->power.runtime_status = RPM_RESUMING;
 
-	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->bus->pm->runtime_resume(dev);
-
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else if (dev->type && dev->type->pm
-	    && dev->type->pm->runtime_resume) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->type->pm->runtime_resume(dev);
-
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else if (dev->class && dev->class->pm
-	    && dev->class->pm->runtime_resume) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->class->pm->runtime_resume(dev);
-
-		spin_lock_irq(&dev->power.lock);
+	spin_unlock_irq(&dev->power.lock);
+	retval = dpm_invoke_runtime_resume(dev);
+	spin_lock_irq(&dev->power.lock);
+	if (retval != -ENOSYS)
 		dev->power.runtime_error = retval;
-	} else {
-		retval = -ENOSYS;
-	}
 
 	if (retval) {
 		dev->power.runtime_status = RPM_SUSPENDED;
Index: usb-2.6/drivers/base/power/invoke_runtime.c
===================================================================
--- /dev/null
+++ usb-2.6/drivers/base/power/invoke_runtime.c
@@ -0,0 +1,80 @@
+/*
+ * drivers/base/power/invoke_runtime.c - Helper functions for device run-time PM
+ *
+ * Copyright (c) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
+ * Copyright (c) 2010 Alan Stern <stern@rowland.harvard.edu>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#include <linux/pm_runtime.h>
+
+/* The following functions are separated out from runtime.c so that they
+ * can be used even when CONFIG_PM_RUNTIME is disabled.
+ */
+
+/**
+ * dpm_invoke_runtime_idle - Invoke a device's runtime PM idle method(s)
+ * @dev: Device to handle.
+ */
+void dpm_invoke_runtime_idle(struct device *dev)
+{
+	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_idle) {
+		dev->bus->pm->runtime_idle(dev);
+	} else if (dev->type && dev->type->pm && dev->type->pm->runtime_idle) {
+		dev->type->pm->runtime_idle(dev);
+	} else if (dev->class && dev->class->pm
+	    && dev->class->pm->runtime_idle) {
+		dev->class->pm->runtime_idle(dev);
+	}
+}
+
+/**
+ * dpm_invoke_runtime_suspend - Invoke a device's runtime PM suspend method(s)
+ * @dev: Device to handle.
+ */
+int dpm_invoke_runtime_suspend(struct device *dev)
+{
+	int retval;
+
+	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend) {
+		retval = dev->bus->pm->runtime_suspend(dev);
+		dev->power.runtime_error = retval;
+	} else if (dev->type && dev->type->pm
+	    && dev->type->pm->runtime_suspend) {
+		retval = dev->type->pm->runtime_suspend(dev);
+		dev->power.runtime_error = retval;
+	} else if (dev->class && dev->class->pm
+	    && dev->class->pm->runtime_suspend) {
+		retval = dev->class->pm->runtime_suspend(dev);
+		dev->power.runtime_error = retval;
+	} else {
+		retval = -ENOSYS;
+	}
+	return retval;
+}
+
+/**
+ * dpm_invoke_runtime_resume - Invoke a device's runtime PM resume method(s)
+ * @dev: Device to handle.
+ */
+int dpm_invoke_runtime_resume(struct device *dev)
+{
+	int retval;
+
+	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume) {
+		retval = dev->bus->pm->runtime_resume(dev);
+		dev->power.runtime_error = retval;
+	} else if (dev->type && dev->type->pm
+	    && dev->type->pm->runtime_resume) {
+		retval = dev->type->pm->runtime_resume(dev);
+		dev->power.runtime_error = retval;
+	} else if (dev->class && dev->class->pm
+	    && dev->class->pm->runtime_resume) {
+		retval = dev->class->pm->runtime_resume(dev);
+		dev->power.runtime_error = retval;
+	} else {
+		retval = -ENOSYS;
+	}
+	return retval;
+}
Index: usb-2.6/Documentation/power/runtime_pm.txt
===================================================================
--- usb-2.6.orig/Documentation/power/runtime_pm.txt
+++ usb-2.6/Documentation/power/runtime_pm.txt
@@ -329,6 +329,11 @@ drivers/base/power/runtime.c and include
       'power.runtime_error' is set or 'power.disable_depth' is greater than
       zero)
 
+  bool pm_is_runtime_suspended(struct device *dev);
+    - returns 'true' if the device's run-time PM status is 'suspended'; the
+      status is constantly subject to change, hence this function should be
+      used only in contexts such as during a system sleep transition
+
 It is safe to execute the following helper functions from interrupt context:
 
 pm_request_idle()
@@ -342,6 +347,7 @@ pm_suspend_ignore_children()
 pm_runtime_set_active()
 pm_runtime_set_suspended()
 pm_runtime_enable()
+pm_is_runtime_suspended()
 
 5. Run-time PM Initialization, Device Probing and Removal
 
@@ -431,3 +437,21 @@ The PM core always increments the run-ti
 ->prepare() callback and decrements it after calling the ->complete() callback.
 Hence disabling run-time PM temporarily like this will not cause any run-time
 suspend callbacks to be lost.
+
+Subsystems may wish to conserve code space by using the same function as both a
+system suspend and run-time suspend callback, and similarly for system resume
+and run-time resume.  The PM core provides two utility functions to help make
+this easier:
+
+  int dpm_use_runtime_suspend(struct device *dev);
+    - system suspend handler that invokes the ->runtime_suspend() callback for
+      this device if the device is not already run-time suspended
+
+  int dpm_use_runtime_resume(struct device *dev);
+    - system resume handler that invokes the ->runtime_resume() callback for
+      this device and sets the device's run-time PM status to 'active' if the
+      callback is successful
+
+These functions can be assigned to the ->suspend(), ->freeze(), ->poweroff(),
+->resume(), ->thaw(), or ->restore() callback pointers in the subsystem-level
+dev_pm_ops structures.
