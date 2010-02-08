From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: runtime PM: common hooks for static and runtime PM
Date: Mon, 8 Feb 2010 09:54:07 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002080952150.1809-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1002061110560.15298-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1002061110560.15298-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 6 Feb 2010, Alan Stern wrote:

> On Sat, 6 Feb 2010, Mark Brown wrote:
> 
> > On Fri, Feb 05, 2010 at 09:57:46PM -0500, Alan Stern wrote:
> > > On Fri, 5 Feb 2010, Mark Brown wrote:
> > 
> > > > It's not that it's hard per se, it's that it feels like it's peering
> > > > inside the implementation of the API.  Having the PM core provide
> > 
> > > You mean like providing an is_runtime_suspended() test?  Then you could 
> > > write:
> > 
> > > 	int my_suspend(struct device *dev)
> > > 	{
> > > 		if (is_runtime_suspended(dev))
> > > 			return 0;
> > > 		return my_runtime_suspend(dev);
> > > 	}
> > 
> > > Or maybe you'd prefer to see a convenient pm_use_runtime_suspend() 
> > > function that you could use for your dev_pm_ops.suspend pointer, which 
> > > would do essentially the same as the above?  (Along with a 
> > > corresponding pm_use_runtime_resume() function, of course.)
> > 
> > Either (or both, of course - implementing the second would probably
> > imply the former).  The ops that can be assigned would be the clearest
> > option but the accessor function should be enough to make it clear that
> > this is something drivers are supposed to be doing.
> 
> Providing the new ops would be a little awkward because 
> CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME are independent: Either can be 
> enabled without the other.  This means the code to call the 
> runtime_suspend and runtime_resume methods would have to be split out 
> into a separate source file that would get built whenever either config 
> option is enabled.  It's doable, just somewhat awkward.
> 
> I'll give it a try and we'll see how it turns out...

And here it is.  You can see that the patch isn't ideal.

Anyway, it should do what you want -- I haven't tested it.

Alan Stern


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
@@ -520,8 +523,15 @@ static inline int dpm_suspend_start(pm_m
 
 #define suspend_report_result(fn, ret)		do {} while (0)
 
+#define dpm_use_runtime_suspend		NULL
+#define dpm_use_runtime_resume		NULL
+
 #endif /* !CONFIG_PM_SLEEP */
 
+void rpm_invoke_runtime_idle(struct device *dev);
+int rpm_invoke_runtime_suspend(struct device *dev);
+int rpm_invoke_runtime_resume(struct device *dev);
+
 /* How to reorder dpm_list after device_move() */
 enum dpm_order {
 	DPM_ORDER_NONE,
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
@@ -936,3 +936,52 @@ void __suspend_report_result(const char 
 		printk(KERN_ERR "%s(): %pF returns %d\n", function, fn, ret);
 }
 EXPORT_SYMBOL_GPL(__suspend_report_result);
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
+	int retval;
+
+	if (pm_is_runtime_suspended(dev))
+		return 0;
+	retval = rpm_invoke_runtime_suspend(dev);
+	if (retval == -ENOSYS)
+		retval = 0;
+	return retval;
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
+	retval = rpm_invoke_runtime_resume(dev);
+	if (retval == 0) {
+		pm_runtime_disable(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	}
+	return retval;
+}
+EXPORT_SYMBOL_GPL(dpm_use_runtime_resume);
Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -79,26 +79,9 @@ static int __pm_runtime_idle(struct devi
 
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
+	rpm_invoke_runtime_idle(dev);
+	spin_lock_irq(&dev->power.lock);
 
 	dev->power.idle_notification = false;
 	wake_up_all(&dev->power.wait_queue);
@@ -200,32 +183,11 @@ int __pm_runtime_suspend(struct device *
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
+	retval = rpm_invoke_runtime_suspend(dev);
+	spin_lock_irq(&dev->power.lock);
+	if (retval != -ENOSYS)
 		dev->power.runtime_error = retval;
-	} else {
-		retval = -ENOSYS;
-	}
 
 	if (retval) {
 		dev->power.runtime_status = RPM_ACTIVE;
@@ -381,32 +343,11 @@ int __pm_runtime_resume(struct device *d
 
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
+	retval = rpm_invoke_runtime_resume(dev);
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
+ * drivers/base/power/runtime.c - Helper functions for device run-time PM
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
+ * rpm_invoke_runtime_idle - Invoke a device's runtime PM idle method(s)
+ * @dev: Device to handle.
+ */
+void rpm_invoke_runtime_idle(struct device *dev)
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
+ * rpm_invoke_runtime_suspend - Invoke a device's runtime PM suspend method(s)
+ * @dev: Device to handle.
+ */
+int rpm_invoke_runtime_suspend(struct device *dev)
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
+ * rpm_invoke_runtime_resume - Invoke a device's runtime PM resume method(s)
+ * @dev: Device to handle.
+ */
+int rpm_invoke_runtime_resume(struct device *dev)
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
 
