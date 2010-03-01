From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add dpm_use_runtime_{suspend,
	resume} helper functions
Date: Mon, 1 Mar 2010 23:06:38 +0100
Message-ID: <201003012306.38235.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1003011329550.1341-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1003011329550.1341-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 01 March 2010, Alan Stern wrote:
> On Sat, 27 Feb 2010, Rafael J. Wysocki wrote:
> 
> > What about the patch below, then (untested)?
> > 
> > Use GENERIC_SUBSYS_PM_OPS for the subsystem and then
> > UNIVERSAL_DEV_PM_OPS for drivers, possibly passing NULL as idle_fn.
> 
> 
> > +#ifdef CONFIG_PM_SLEEP
> > +#define GENERIC_SYSTEM_SLEEP_PM_OPS \
> > +	.suspend = pm_generic_suspend, \
> > +	.resume = pm_generic_resume,
> > +#else
> > +#define GENERIC_SYSTEM_SLEEP_PM_OPS
> 
> Wouldn't you want to have this work for hibernation as well as suspend?  
> So the .freeze, .thaw, etc. members should be defined too.

Right, thanks.

> > +/*
> > + * Use this for subsystems (bus types, device types, device classes) that only
> > + * need to invoke PM callbacks provided by device drivers supporting both the
> > + * system sleep PM and runtime PM.
> > + */  
> > +#define GENERIC_SUBSYS_PM_OPS(name) \
> > +const struct dev_pm_ops name = { \
> > +GENERIC_SYSTEM_SLEEP_PM_OPS \
> > +GENERIC_RUNTIME_PM_OPS \
> >  }
> 
> There's no reason for this to have "name" as a parameter, since all
> instances of the structure will be identical.  Instead you can put
> 
> 	extern const struct dev_pm_ops generic_subsys_pm_ops;
> 	EXPORT_SYMBOL_GPL(generic_subsys_pm_ops);
> 
> in the header file and define the structure in generic_ops.c.

Right again, thanks a lot!

Updated patch is appended.  In the meantime I decided it would be better
to return error code from pm_generic_runtime_[suspend|resume]() if the driver
callback is not defined and I chose EINVAL (ie. shouldn't be called for a
device whose driver has no corresponding runtime callback).

Rafael

---
 drivers/base/power/Makefile      |    1 
 drivers/base/power/generic_ops.c |  134 +++++++++++++++++++++++++++++++++++++++
 include/linux/pm.h               |   54 +++++++++++++--
 include/linux/pm_runtime.h       |    6 +
 4 files changed, 189 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/base/power/Makefile
===================================================================
--- linux-2.6.orig/drivers/base/power/Makefile
+++ linux-2.6/drivers/base/power/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_PM)	+= sysfs.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o
 obj-$(CONFIG_PM_RUNTIME)	+= runtime.o
+obj-$(CONFIG_PM_OPS)	+= generic_ops.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
Index: linux-2.6/drivers/base/power/generic_ops.c
===================================================================
--- linux-2.6.orig/drivers/base/power/generic_ops.c
+++ linux-2.6/drivers/base/power/generic_ops.c
@@ -6,3 +6,137 @@
  * This file is released under the GPLv2.
  */
 
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+
+#ifdef CONFIG_PM_RUNTIME
+/**
+ * pm_generic_runtime_idle - Generic runtime idle callback for subsystems.
+ * @dev: Device to handle.
+ *
+ * If PM operations are defined for the driver of @dev and they include
+ * ->runtime_idle(), execute it and return the error code returned by it if
+ * nonzero.  Otherwise, execute pm_runtime_suspend() for the device.
+ */
+int pm_generic_runtime_idle(struct device *dev)
+{
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+
+	if (pm && pm->runtime_idle) {
+		int ret = pm->runtime_idle(dev);
+		if (ret)
+			return ret;
+	}
+
+	pm_runtime_suspend(dev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pm_generic_runtime_idle);
+
+/**
+ * pm_generic_runtime_suspend - Generic runtime suspend callback for subsystems.
+ * @dev: Device to suspend.
+ *
+ * If PM operations are defined for the driver of @dev and they include
+ * ->runtime_suspend(), execute it and return the error code returned by it.
+ * Otherwise, return zero.
+ */
+int pm_generic_runtime_suspend(struct device *dev)
+{
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	int ret;
+
+	ret = pm && pm->runtime_suspend ? pm->runtime_suspend(dev) : -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_generic_runtime_suspend);
+
+/**
+ * pm_generic_runtime_resume - Generic runtime resume callback for subsystems.
+ * @dev: Device to resume.
+ *
+ * If PM operations are defined for the driver of @dev and they include
+ * ->runtime_resume(), execute it and return the error code returned by it.
+ * Otherwise, return zero.
+ */
+int pm_generic_runtime_resume(struct device *dev)
+{
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	int ret;
+
+	ret = pm && pm->runtime_resume ? pm->runtime_resume(dev) : -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_generic_runtime_resume);
+#endif /* CONFIG_PM_RUNTIME */
+
+#ifdef CONFIG_PM_SLEEP
+/**
+ * pm_generic_suspend - Generic suspend callback for subsystems.
+ * @dev: Device to suspend.
+ *
+ * If the device has not been suspended at run time, execute the suspend
+ * callback provided by its driver, if defined, and return the error code
+ * returned by it.  Otherwise, return zero.
+ */
+int pm_generic_suspend(struct device *dev)
+{
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	int ret = 0;
+
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	if (pm && pm->suspend)
+		ret = pm->suspend(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_generic_suspend);
+
+/**
+ * pm_generic_resume - Generic resume callback for subsystems.
+ * @dev: Device to resume.
+ *
+ * Execute the resume callback provided by the driver of @dev, if defined.
+ * If it returns 0, change the device's runtime PM status to 'active'.  Return
+ * the error code returned by it.
+ */
+int pm_generic_resume(struct device *dev)
+{
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	int ret;
+
+	if (!pm || !pm->resume)
+		return 0;
+
+	ret = pm->resume(dev);
+	if (!ret) {
+		pm_runtime_disable(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_generic_resume);
+#endif /* CONFIG_PM_SLEEP */
+
+struct dev_pm_ops generic_subsys_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend = pm_generic_suspend,
+	.resume = pm_generic_resume,
+	.freeze = pm_generic_suspend,
+	.thaw = pm_generic_resume,
+	.poweroff = pm_generic_suspend,
+	.restore = pm_generic_resume,
+#endif
+#ifdef CONFIG_PM_RUNTIME
+	.runtime_suspend = pm_generic_runtime_suspend,
+	.runtime_resume = pm_generic_runtime_resume,
+	.runtime_idle = pm_generic_runtime_idle,
+#endif
+};
+EXPORT_SYMBOL_GPL(generic_subsys_pm_ops);
Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -215,20 +215,62 @@ struct dev_pm_ops {
 	int (*runtime_idle)(struct device *dev);
 };
 
+#ifdef CONFIG_PM_SLEEP
+#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	.suspend = suspend_fn, \
+	.resume = resume_fn, \
+	.freeze = suspend_fn, \
+	.thaw = resume_fn, \
+	.poweroff = suspend_fn, \
+	.restore = resume_fn,
+#else
+#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
+#endif
+
+#ifdef CONFIG_PM_RUNTIME
+#define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	.runtime_suspend = suspend_fn, \
+	.runtime_resume = resume_fn, \
+	.runtime_idle = idle_fn,
+#else
+#define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
+#endif
+
 /*
  * Use this if you want to use the same suspend and resume callbacks for suspend
  * to RAM and hibernation.
  */
 #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
 const struct dev_pm_ops name = { \
-	.suspend = suspend_fn, \
-	.resume = resume_fn, \
-	.freeze = suspend_fn, \
-	.thaw = resume_fn, \
-	.poweroff = suspend_fn, \
-	.restore = resume_fn, \
+	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 }
 
+#define SET_UNIVERSAL_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
+
+/*
+ * Use this for defining a set of PM operations to be used in all situations
+ * (system suspend, hibernation or runtime PM).
+ */
+#define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
+const struct dev_pm_ops name = { \
+	SET_UNIVERSAL_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+}
+
+/*
+ * Use this for subsystems (bus types, device types, device classes) that don't
+ * need any special suspend/resume handling in addition to invoking the PM
+ * callbacks provided by device drivers supporting both the system sleep PM and
+ * runtime PM, make the pm member point to generic_subsys_pm_ops.
+ */
+#ifdef CONFIG_PM_OPS
+extern struct dev_pm_ops generic_subsys_pm_ops;
+#define GENERIC_SUBSYS_PM_OPS	(&generic_subsys_pm_ops)
+#else
+#define GENERIC_SUBSYS_PM_OPS	NULL
+#endif
+
 /**
  * PM_EVENT_ messages
  *
Index: linux-2.6/include/linux/pm_runtime.h
===================================================================
--- linux-2.6.orig/include/linux/pm_runtime.h
+++ linux-2.6/include/linux/pm_runtime.h
@@ -62,6 +62,11 @@ static inline void device_set_run_wake(s
 	dev->power.run_wake = enable;
 }
 
+static inline bool pm_runtime_suspended(struct device *dev)
+{
+	return dev->power.runtime_status == RPM_SUSPENDED;
+}
+
 #else /* !CONFIG_PM_RUNTIME */
 
 static inline int pm_runtime_idle(struct device *dev) { return -ENOSYS; }
@@ -89,6 +94,7 @@ static inline void pm_runtime_get_noresu
 static inline void pm_runtime_put_noidle(struct device *dev) {}
 static inline bool device_run_wake(struct device *dev) { return false; }
 static inline void device_set_run_wake(struct device *dev, bool enable) {}
+static inline bool pm_runtime_suspended(struct device *dev) { return false; }
 
 #endif /* !CONFIG_PM_RUNTIME */
 
