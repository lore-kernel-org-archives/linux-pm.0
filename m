From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Sleep / Runtime: Add pm_runtime_suspend|resume_force functions
Date: Wed, 12 Feb 2014 18:16:14 +0100
Message-ID: <1392225374-28156-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:38741 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbaBLRQW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2014 12:16:22 -0500
Received: by mail-we0-f173.google.com with SMTP id x48so598251wes.32
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2014 09:16:21 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@linaro.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>

This patch provides two new runtime PM helper functions which intend to
be used from system suspend/resume callbacks, to make sure devices are
put into low power state during system suspend and brought back to full
power at system resume.

The prerequisite is to have all levels of a device's runtime PM
callbacks to be defined through the SET_PM_RUNTIME_PM_OPS macro, which
means these are available for CONFIG_PM.

By using the new runtime PM helper functions especially the two
scenarios below will be addressed.

1) The PM core prevents .runtime_suspend callbacks from being invoked
during system suspend. That means even for a runtime PM centric
subsystem and driver, the device needs to be put into low power state
from a system suspend callback. Otherwise it may very well be left in
full power state (runtime resumed) while the system is suspended. By
using the new helper functions, we make sure to walk the hierarchy of
a device's power domain, subsystem and driver.

2) Subsystems and drivers need to cope with all the combinations of
CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME. The two new helper functions
smothly addresses this.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Brown <broonie@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/Makefile  |    3 +-
 drivers/base/power/runtime.c |  110 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_runtime.h   |    4 ++
 3 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index 2e58ebb..1cb8544 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -1,6 +1,5 @@
-obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o
+obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
-obj-$(CONFIG_PM_RUNTIME)	+= runtime.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_PM_OPP)	+= opp.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 72e00e6..959c478 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -13,6 +13,7 @@
 #include <trace/events/rpm.h>
 #include "power.h"
 
+#ifdef CONFIG_PM_RUNTIME
 static int rpm_resume(struct device *dev, int rpmflags);
 static int rpm_suspend(struct device *dev, int rpmflags);
 
@@ -1401,3 +1402,112 @@ void pm_runtime_remove(struct device *dev)
 	if (dev->power.irq_safe && dev->parent)
 		pm_runtime_put(dev->parent);
 }
+#endif
+
+#ifdef CONFIG_PM
+/**
+ * pm_runtime_force_suspend - Force a device into suspend state if needed.
+ * @dev: Device to suspend.
+ *
+ * Disable runtime PM so we safely can check the device's runtime PM status and
+ * if it is active, invoke it's .runtime_suspend callback to bring it into
+ * suspend state. Keep runtime PM disabled to preserve the state unless we
+ * encounter errors.
+ *
+ * Typically this function may be invoked from a system suspend callback to make
+ * sure the device is put into low power state.
+ */
+int pm_runtime_force_suspend(struct device *dev)
+{
+	int (*callback)(struct device *);
+	int ret = 0;
+
+	pm_runtime_disable(dev);
+
+	/*
+	 * Note that pm_runtime_status_suspended() returns false while
+	 * !CONFIG_PM_RUNTIME, which means the device will be put into low
+	 * power state.
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
+	if (!callback) {
+		ret = -ENOSYS;
+		goto err;
+	}
+
+	ret = callback(dev);
+	if (ret)
+		goto err;
+
+	pm_runtime_set_suspended(dev);
+	return 0;
+err:
+	pm_runtime_enable(dev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_runtime_force_suspend);
+
+/**
+ * pm_runtime_force_resume - Force a device into resume state.
+ * @dev: Device to resume.
+ *
+ * Prior invoking this function we expect the user to have brought the device
+ * into low power state by a call to pm_runtime_force_suspend(). Here we reverse
+ * those actions and brings the device into full power. We update the runtime PM
+ * status and re-enables runtime PM.
+ *
+ * Typically this function may be invoked from a system resume callback to make
+ * sure the device is put into full power state.
+ */
+int pm_runtime_force_resume(struct device *dev)
+{
+	int (*callback)(struct device *);
+	int ret = 0;
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
+	if (!callback) {
+		ret = -ENOSYS;
+		goto out;
+	}
+
+	ret = callback(dev);
+	if (ret)
+		goto out;
+
+	pm_runtime_set_active(dev);
+	pm_runtime_mark_last_busy(dev);
+out:
+	pm_runtime_enable(dev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_runtime_force_resume);
+#endif
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 16c9a62..2a5897a 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -26,9 +26,13 @@
 #ifdef CONFIG_PM
 extern int pm_generic_runtime_suspend(struct device *dev);
 extern int pm_generic_runtime_resume(struct device *dev);
+extern int pm_runtime_force_suspend(struct device *dev);
+extern int pm_runtime_force_resume(struct device *dev);
 #else
 static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
 static inline int pm_generic_runtime_resume(struct device *dev) { return 0; }
+static inline int pm_runtime_force_suspend(struct device *dev) { return 0; }
+static inline int pm_runtime_force_resume(struct device *dev) { return 0; }
 #endif
 
 #ifdef CONFIG_PM_RUNTIME
-- 
1.7.9.5

