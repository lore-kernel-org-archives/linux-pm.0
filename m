From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] runtime pm: add sysfs debug files
Date: Sun, 11 Apr 2010 17:01:36 +0200
Message-ID: <20100411150136.GA6693@comet.dominikbrodowski.net>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Add a few sysfs files relating to runtime power management for
advanced debug purposes:

runtime_status:	what state is the device in currently? E.g., it
	reports "disabled" if runtime power management is
	disabled for a device, "suspended" for runtime-suspended
	devices, and "active" for active devices.

runtime_usage: the runtime PM usage count of a device

runtime_children: the runtime PM children usage count of a device, or
	0 if the ignore_children flag is set.

Also, CONFIG_PM_SLEEP_ADVANCED_DEBUG is not defined in any Kconfig
file, so replace it with CONFIG_PM_ADVANCED_DEBUG.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 86fd937..6ba0f06 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -5,6 +5,7 @@
 #include <linux/device.h>
 #include <linux/string.h>
 #include <linux/pm_runtime.h>
+#include <asm/atomic.h>
 #include "power.h"
 
 /*
@@ -143,7 +144,49 @@ wake_store(struct device * dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(wakeup, 0644, wake_show, wake_store);
 
-#ifdef CONFIG_PM_SLEEP_ADVANCED_DEBUG
+#ifdef CONFIG_PM_ADVANCED_DEBUG
+#ifdef CONFIG_PM_RUNTIME
+
+static ssize_t usagecount_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", atomic_read(&dev->power.usage_count));
+}
+
+static ssize_t children_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", dev->power.ignore_children ?
+		0 : atomic_read(&dev->power.child_count));
+}
+
+static ssize_t rtpm_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	int status = dev->power.runtime_status;
+	if (dev->power.disable_depth)
+		return sprintf(buf, "disabled\n");
+	if (dev->power.runtime_auto == false)
+		return sprintf(buf, "forbidden\n");
+	switch (status) {
+	case RPM_SUSPENDED:
+		return sprintf(buf, "suspended\n");
+	case RPM_SUSPENDING:
+		return sprintf(buf, "to be suspended\n");
+	case RPM_RESUMING:
+		return sprintf(buf, "to be resumed\n");
+	case RPM_ACTIVE:
+		return sprintf(buf, "active\n");
+	}
+	return -EIO;
+}
+
+static DEVICE_ATTR(runtime_usage, 0444, usagecount_show, NULL);
+static DEVICE_ATTR(runtime_children, 0444, children_show, NULL);
+static DEVICE_ATTR(runtime_status, 0444, rtpm_show, NULL);
+
+#endif
+
 static ssize_t async_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
@@ -170,15 +213,20 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
 }
 
 static DEVICE_ATTR(async, 0644, async_show, async_store);
-#endif /* CONFIG_PM_SLEEP_ADVANCED_DEBUG */
+#endif /* CONFIG_PM_ADVANCED_DEBUG */
 
 static struct attribute * power_attrs[] = {
 #ifdef CONFIG_PM_RUNTIME
 	&dev_attr_control.attr,
 #endif
 	&dev_attr_wakeup.attr,
-#ifdef CONFIG_PM_SLEEP_ADVANCED_DEBUG
+#ifdef CONFIG_PM_ADVANCED_DEBUG
 	&dev_attr_async.attr,
+#ifdef CONFIG_PM_RUNTIME
+	&dev_attr_runtime_usage.attr,
+	&dev_attr_runtime_children.attr,
+	&dev_attr_runtime_status.attr,
+#endif
 #endif
 	NULL,
 };
