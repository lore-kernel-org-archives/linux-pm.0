From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] PM / Sleep: Add pm_generic functions to re-use runtime PM callbacks
Date: Fri, 22 Nov 2013 13:43:55 +0100
Message-ID: <1385124235-25484-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

To put devices into low power state during sleep, it sometimes makes
sense at subsystem-level to re-use device's runtime PM callbacks.

The PM core will at device_suspend_late disable runtime PM, after that
we can safely operate on these callbacks. At suspend_late the device
will be put into low power state by invoking the device's
runtime_suspend callback, unless the runtime status is already
suspended. At resume_early the state is restored by invoking the
device's runtime_resume callback. Soon after the PM core will re-enable
runtime PM before returning from device_resume_early.

These are new pm_generic functions, which are supposed to be used in
pairs:
- pm_generic_suspend_late_runtime / pm_generic_resume_early_runtime
- pm_generic_freeze_late_runtime / pm_generic_thaw_early_runtime
- pm_generic_poweroff_late_runtime / pm_generic_restore_early_runtime

Do note that these new pm_generic late and early callbacks will work
smothly even with and without CONFIG_PM_RUNTIME, as long as the runtime
PM callbacks are implemented inside CONFIG_PM instead of
CONFIG_PM_RUNTIME.

A special thanks to Alan Stern who came up with this idea.

Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/base/power/generic_ops.c |  130 ++++++++++++++++++++++++++++++++++++++
 include/linux/pm.h               |    6 ++
 2 files changed, 136 insertions(+)

diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
index 5ee030a..b8d31f6 100644
--- a/drivers/base/power/generic_ops.c
+++ b/drivers/base/power/generic_ops.c
@@ -93,6 +93,49 @@ int pm_generic_suspend_late(struct device *dev)
 EXPORT_SYMBOL_GPL(pm_generic_suspend_late);
 
 /**
+ * pm_generic_suspend_late_runtime - Generic suspend_late callback for
+ * subsystems that wants to use runtime_suspend callbacks at suspend_late.
+ * @dev: Device to suspend.
+ */
+int pm_generic_suspend_late_runtime(struct device *dev)
+{
+	int (*callback)(struct device *);
+	int ret = 0;
+
+	/*
+	 * PM core has disabled runtime PM in device_suspend_late, thus we can
+	 * safely check the device's runtime status and decide whether
+	 * additional actions are needed to put the device into low power state.
+	 * If so, we invoke the device's runtime_suspend callback.
+	 * For the !CONFIG_PM_RUNTIME case, pm_runtime_status_suspended() always
+	 * returns false and therefore the runtime_suspend callback will be
+	 * invoked.
+	 */
+	if (pm_runtime_status_suspended(dev))
+		return 0;
+
+	if (dev->pm_domain)
+		callback = dev->pm_domain->ops.runtime_suspend;
+	else if (dev->type && dev->type->pm)
+		callback = dev->type->pm->runtime_suspend;
+	else if (dev->class && dev->class->pm)
+		callback = dev->class->pm->runtime_suspend;
+	else if (dev->bus && dev->bus->pm)
+		callback = dev->bus->pm->runtime_suspend;
+	else
+		callback = NULL;
+
+	if (!callback && dev->driver && dev->driver->pm)
+		callback = dev->driver->pm->runtime_suspend;
+
+	if (callback)
+		ret = callback(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_generic_suspend_late_runtime);
+
+/**
  * pm_generic_suspend - Generic suspend callback for subsystems.
  * @dev: Device to suspend.
  */
@@ -129,6 +172,17 @@ int pm_generic_freeze_late(struct device *dev)
 EXPORT_SYMBOL_GPL(pm_generic_freeze_late);
 
 /**
+ * pm_generic_freeze_late_runtime - Generic freeze_late callback for
+ * subsystems that wants to use runtime_suspend callbacks at freeze_late.
+ * @dev: Device to freeze.
+ */
+int pm_generic_freeze_late_runtime(struct device *dev)
+{
+	return pm_generic_suspend_late_runtime(dev);
+}
+EXPORT_SYMBOL_GPL(pm_generic_freeze_late_runtime);
+
+/**
  * pm_generic_freeze - Generic freeze callback for subsystems.
  * @dev: Device to freeze.
  */
@@ -165,6 +219,17 @@ int pm_generic_poweroff_late(struct device *dev)
 EXPORT_SYMBOL_GPL(pm_generic_poweroff_late);
 
 /**
+ * pm_generic_poweroff_late_runtime - Generic poweroff_late callback for
+ * subsystems that wants to use runtime_suspend callbacks at poweroff_late.
+ * @dev: Device to handle.
+ */
+int pm_generic_poweroff_late_runtime(struct device *dev)
+{
+	return pm_generic_suspend_late_runtime(dev);
+}
+EXPORT_SYMBOL_GPL(pm_generic_poweroff_late_runtime);
+
+/**
  * pm_generic_poweroff - Generic poweroff callback for subsystems.
  * @dev: Device to handle.
  */
@@ -201,6 +266,17 @@ int pm_generic_thaw_early(struct device *dev)
 EXPORT_SYMBOL_GPL(pm_generic_thaw_early);
 
 /**
+ * pm_generic_thaw_early_runtime - Generic thaw_early callback for subsystems
+ * that wants to use runtime_resume callbacks at thaw_early.
+ * @dev: Device to thaw.
+ */
+int pm_generic_thaw_early_runtime(struct device *dev)
+{
+	return pm_generic_resume_early_runtime(dev);
+}
+EXPORT_SYMBOL_GPL(pm_generic_thaw_early_runtime);
+
+/**
  * pm_generic_thaw - Generic thaw callback for subsystems.
  * @dev: Device to thaw.
  */
@@ -237,6 +313,49 @@ int pm_generic_resume_early(struct device *dev)
 EXPORT_SYMBOL_GPL(pm_generic_resume_early);
 
 /**
+ * pm_generic_resume_early_runtime - Generic resume_early callback for
+ * subsystems that wants to use runtime_resume callbacks at resume_early.
+ * @dev: Device to resume.
+ */
+int pm_generic_resume_early_runtime(struct device *dev)
+{
+	int (*callback)(struct device *);
+	int ret = 0;
+
+	/*
+	 * PM core has not yet enabled runtime PM in device_resume_early,
+	 * thus we can safely check the device's runtime status and restore the
+	 * previous state we had in device_suspend_late. If restore is needed
+	 * we invoke the device's runtime_resume callback.
+	 * For the !CONFIG_PM_RUNTIME case, pm_runtime_status_suspended() always
+	 * returns false and therefore the runtime_resume callback will be
+	 * invoked.
+	 */
+	if (pm_runtime_status_suspended(dev))
+		return 0;
+
+	if (dev->pm_domain)
+		callback = dev->pm_domain->ops.runtime_resume;
+	else if (dev->type && dev->type->pm)
+		callback = dev->type->pm->runtime_resume;
+	else if (dev->class && dev->class->pm)
+		callback = dev->class->pm->runtime_resume;
+	else if (dev->bus && dev->bus->pm)
+		callback = dev->bus->pm->runtime_resume;
+	else
+		callback = NULL;
+
+	if (!callback && dev->driver && dev->driver->pm)
+		callback = dev->driver->pm->runtime_resume;
+
+	if (callback)
+		ret = callback(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_generic_resume_early_runtime);
+
+/**
  * pm_generic_resume - Generic resume callback for subsystems.
  * @dev: Device to resume.
  */
@@ -273,6 +392,17 @@ int pm_generic_restore_early(struct device *dev)
 EXPORT_SYMBOL_GPL(pm_generic_restore_early);
 
 /**
+ * pm_generic_restore_early_runtime - Generic restore_early callback for
+ * subsystems that wants to use runtime_resume callbacks at restore_early.
+ * @dev: Device to restore
+ */
+int pm_generic_restore_early_runtime(struct device *dev)
+{
+	return pm_generic_resume_early_runtime(dev);
+}
+EXPORT_SYMBOL_GPL(pm_generic_restore_early_runtime);
+
+/**
  * pm_generic_restore - Generic restore callback for subsystems.
  * @dev: Device to restore.
  */
diff --git a/include/linux/pm.h b/include/linux/pm.h
index a224c7f..c7c2db7 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -656,22 +656,28 @@ extern void dpm_for_each_dev(void *data, void (*fn)(struct device *, void *));
 
 extern int pm_generic_prepare(struct device *dev);
 extern int pm_generic_suspend_late(struct device *dev);
+extern int pm_generic_suspend_late_runtime(struct device *dev);
 extern int pm_generic_suspend_noirq(struct device *dev);
 extern int pm_generic_suspend(struct device *dev);
 extern int pm_generic_resume_early(struct device *dev);
+extern int pm_generic_resume_early_runtime(struct device *dev);
 extern int pm_generic_resume_noirq(struct device *dev);
 extern int pm_generic_resume(struct device *dev);
 extern int pm_generic_freeze_noirq(struct device *dev);
 extern int pm_generic_freeze_late(struct device *dev);
+extern int pm_generic_freeze_late_runtime(struct device *dev);
 extern int pm_generic_freeze(struct device *dev);
 extern int pm_generic_thaw_noirq(struct device *dev);
 extern int pm_generic_thaw_early(struct device *dev);
+extern int pm_generic_thaw_early_runtime(struct device *dev);
 extern int pm_generic_thaw(struct device *dev);
 extern int pm_generic_restore_noirq(struct device *dev);
 extern int pm_generic_restore_early(struct device *dev);
+extern int pm_generic_restore_early_runtime(struct device *dev);
 extern int pm_generic_restore(struct device *dev);
 extern int pm_generic_poweroff_noirq(struct device *dev);
 extern int pm_generic_poweroff_late(struct device *dev);
+extern int pm_generic_poweroff_late_runtime(struct device *dev);
 extern int pm_generic_poweroff(struct device *dev);
 extern void pm_generic_complete(struct device *dev);
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
