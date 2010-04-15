From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v2] runtime pm: add sysfs debug files
Date: Thu, 15 Apr 2010 19:47:04 +0200
Message-ID: <20100415174704.GA31336@comet.dominikbrodowski.net>
References: <20100411150136.GA6693@comet.dominikbrodowski.net>
	<Pine.LNX.4.44L0.1004111445260.13658-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1004111445260.13658-100000@netrider.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Alan,

many thanks for your comments!

On Sun, Apr 11, 2010 at 02:54:56PM -0400, Alan Stern wrote:
> > +	if (dev->power.disable_depth)
> > +		return sprintf(buf, "disabled\n");
> > +	if (dev->power.runtime_auto == false)
> > +		return sprintf(buf, "forbidden\n");
> 
> The logic here isn't right.  A "disabled" device can be either 
> suspended or active.  The same holds for a "forbidden" device 
> (although the suspended-and-forbidden combination would be rather 
> unusual).  And a device can be both "disabled" and "forbidden".

Might it be better to move this to a different file, then?

> In addition, you need to check for the runtime error state.  In this 
> state, a device is neither active nor suspended.

Okay. Is the check I added sufficient?

> > +static DEVICE_ATTR(runtime_usage, 0444, usagecount_show, NULL);
> > +static DEVICE_ATTR(runtime_children, 0444, children_show, NULL);
> 
> "runtime_children" seems like a slightly odd name.  It isn't the number 
> of children; it's the number of _active_ children.  But I don't have 
> any suggestions for a better name.

What about "runtime_active_kids"?


From: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Sun, 11 Apr 2010 15:56:49 +0200
Subject: [PATCH] runtime pm: add sysfs debug files

Add a few sysfs files relating to runtime power management for
advanced debug purposes:

runtime_enabled: is runtime PM enabled for this device? States
	are "enabled", "disabled", "forbidden" or a combination
	of the latter two.

runtime_status:	what state is the device in currently? E.g., it
	reports "suspended" for runtime-suspended devices, and
        "active" for active devices. NOTE: if runtime_enabled
	returns "disabled", the value of this file may not
	reflect its physical state.

runtime_usage: the runtime PM usage count of a device

runtime_active_kids: the runtime PM children usage count of a device, or
	0 if the ignore_children flag is set.

Also, CONFIG_PM_SLEEP_ADVANCED_DEBUG is not defined in any Kconfig
file, so replace it with CONFIG_PM_ADVANCED_DEBUG.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 86fd937..a4c33bc 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -5,6 +5,7 @@
 #include <linux/device.h>
 #include <linux/string.h>
 #include <linux/pm_runtime.h>
+#include <asm/atomic.h>
 #include "power.h"
 
 /*
@@ -143,7 +144,59 @@ wake_store(struct device * dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(wakeup, 0644, wake_show, wake_store);
 
-#ifdef CONFIG_PM_SLEEP_ADVANCED_DEBUG
+#ifdef CONFIG_PM_ADVANCED_DEBUG
+#ifdef CONFIG_PM_RUNTIME
+
+static ssize_t rtpm_usagecount_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", atomic_read(&dev->power.usage_count));
+}
+
+static ssize_t rtpm_children_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", dev->power.ignore_children ?
+		0 : atomic_read(&dev->power.child_count));
+}
+
+static ssize_t rtpm_enabled_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	if ((dev->power.disable_depth) && (dev->power.runtime_auto == false))
+		return sprintf(buf, "disabled & forbidden\n");
+	else if (dev->power.disable_depth)
+		return sprintf(buf, "disabled\n");
+	else if (dev->power.runtime_auto == false)
+		return sprintf(buf, "forbidden\n");
+	return sprintf(buf, "enabled\n");
+}
+
+static ssize_t rtpm_status_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	if (dev->power.runtime_error)
+		return sprintf(buf, "error\n");
+	switch (dev->power.runtime_status) {
+	case RPM_SUSPENDED:
+		return sprintf(buf, "suspended\n");
+	case RPM_SUSPENDING:
+		return sprintf(buf, "suspending\n");
+	case RPM_RESUMING:
+		return sprintf(buf, "resuming\n");
+	case RPM_ACTIVE:
+		return sprintf(buf, "active\n");
+	}
+	return -EIO;
+}
+
+static DEVICE_ATTR(runtime_usage, 0444, rtpm_usagecount_show, NULL);
+static DEVICE_ATTR(runtime_active_kids, 0444, rtpm_children_show, NULL);
+static DEVICE_ATTR(runtime_status, 0444, rtpm_status_show, NULL);
+static DEVICE_ATTR(runtime_enabled, 0444, rtpm_enabled_show, NULL);
+
+#endif
+
 static ssize_t async_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
@@ -170,15 +223,21 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
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
+	&dev_attr_runtime_active_kids.attr,
+	&dev_attr_runtime_status.attr,
+	&dev_attr_runtime_enabled.attr,
+#endif
 #endif
 	NULL,
 };
