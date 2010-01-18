From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Update][RFC][PATCH] PM / Runtime: Add sysfs switch for
	disabling device run-time PM
Date: Mon, 18 Jan 2010 23:25:27 +0100
Message-ID: <201001182325.28094.rjw__33286.5861863413$1263853564$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1001181102460.6554-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1001181102460.6554-100000@netrider.rowland.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Monday 18 January 2010, Alan Stern wrote:
> On Mon, 18 Jan 2010, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: PM / Runtime: Add sysfs switch for disabling device run-time PM
> > 
> > Add new device sysfs attribute, power/runtime, allowing the user
> > space to block the run-time power management of the device.  If this
> > attribute is set to "disabled", the driver of the device won't be
> > able to enable run-time power management for it (without breaking the
> > rules).
> 
> Ouch.  This does nearly the same thing as the power/level attribute in
> the USB subsystem, but in an incompatible and more complicated way.
> 
> The power/level attribute can contain either "on" or "auto", meaning
> that the device is always on or that it is subject to automatic runtime
> power management (autosuspend).

It looks like my "disable" is similar to "on", while my "enable" is similar to
"auto".  I can use "auto" and "on" just fine.

> Changing the setting from "auto" to "on" merely does sets a flag and does
> pm_runtime_get_sync(); changing it from "on" to "auto" clears the flag and
> does pm_runtime_put_sync().

We can do it almost this way in general, although I think the flag should be
changed under the power.lock.

Updated patch is appended.

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM / Runtime: Add sysfs switch for disabling device run-time PM

Add new device sysfs attribute, power/runtime, allowing the user
space to block the run-time power management of the devices.  If this
attribute is set to "on", the driver of the device won't be able to power
manage it at run time (without breaking the rules).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/power.h   |    4 +++
 drivers/base/power/runtime.c |   43 ++++++++++++++++++++++++++++++++++++
 drivers/base/power/sysfs.c   |   50 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm.h           |    1 
 4 files changed, 98 insertions(+)

Index: linux-2.6/drivers/base/power/power.h
===================================================================
--- linux-2.6.orig/drivers/base/power/power.h
+++ linux-2.6/drivers/base/power/power.h
@@ -2,11 +2,15 @@
 
 extern void pm_runtime_init(struct device *dev);
 extern void pm_runtime_remove(struct device *dev);
+extern void pm_runtime_allow(struct device *dev);
+extern void pm_runtime_forbid(struct device *dev);
 
 #else /* !CONFIG_PM_RUNTIME */
 
 static inline void pm_runtime_init(struct device *dev) {}
 static inline void pm_runtime_remove(struct device *dev) {}
+static inline void pm_runtime_allow(struct device *dev) {}
+static inline void pm_runtime_forbid(struct device *dev) {}
 
 #endif /* !CONFIG_PM_RUNTIME */
 
Index: linux-2.6/drivers/base/power/sysfs.c
===================================================================
--- linux-2.6.orig/drivers/base/power/sysfs.c
+++ linux-2.6/drivers/base/power/sysfs.c
@@ -7,6 +7,21 @@
 #include "power.h"
 
 /*
+ *	runtime - Report/change current runtime PM setting of the device
+ *
+ *	Runtime power management of a device can be blocked with the help of
+ *	this attribute.  All devices have one of the following two values for
+ *	the power/runtime file:
+ *
+ *	 + "auto\n" to allow the device to be power managed at run time;
+ *	 + "on\n" to prevent the device from being power managemed at run time;
+ *
+ *	The default for all devices is "auto", which means that devices may be
+ *	subject to automatic power management, depending on their drivers.
+ *	Changing this attribute to "on" prevents the driver from power managing
+ *	the device at run time.  Doing that while the device is suspended causes
+ *	it to be woken up.
+ *
  *	wakeup - Report/change current wakeup option for device
  *
  *	Some devices support "wakeup" events, which are hardware signals
@@ -59,6 +74,38 @@
 static const char enabled[] = "enabled";
 static const char disabled[] = "disabled";
 
+#ifdef CONFIG_PM_RUNTIME
+static const char str_auto[] = "auto";
+static const char str_on[] = "on";
+
+static ssize_t runtime_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	return sprintf(buf, "%s\n",
+				dev->power.runtime_auto ? str_auto : str_on);
+}
+
+static ssize_t runtime_store(struct device * dev, struct device_attribute *attr,
+			     const char * buf, size_t n)
+{
+	char *cp;
+	int len = n;
+
+	cp = memchr(buf, '\n', n);
+	if (cp)
+		len = cp - buf;
+	if (len == sizeof str_auto - 1 && strncmp(buf, str_auto, len) == 0)
+		pm_runtime_allow(dev);
+	else if (len == sizeof str_on - 1 && strncmp(buf, str_on, len) == 0)
+		pm_runtime_forbid(dev);
+	else
+		return -EINVAL;
+	return n;
+}
+
+static DEVICE_ATTR(runtime, 0644, runtime_show, runtime_store);
+#endif
+
 static ssize_t
 wake_show(struct device * dev, struct device_attribute *attr, char * buf)
 {
@@ -123,6 +170,9 @@ static DEVICE_ATTR(async, 0644, async_sh
 #endif /* CONFIG_PM_SLEEP_ADVANCED_DEBUG */
 
 static struct attribute * power_attrs[] = {
+#ifdef CONFIG_PM_RUNTIME
+	&dev_attr_runtime.attr,
+#endif
 	&dev_attr_wakeup.attr,
 #ifdef CONFIG_PM_SLEEP_ADVANCED_DEBUG
 	&dev_attr_async.attr,
Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -433,6 +433,7 @@ struct dev_pm_info {
 	unsigned int		request_pending:1;
 	unsigned int		deferred_resume:1;
 	unsigned int		run_wake:1;
+	unsigned int		runtime_auto:1;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
 	int			runtime_error;
Index: linux-2.6/drivers/base/power/runtime.c
===================================================================
--- linux-2.6.orig/drivers/base/power/runtime.c
+++ linux-2.6/drivers/base/power/runtime.c
@@ -1011,6 +1011,48 @@ void pm_runtime_enable(struct device *de
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
 /**
+ * pm_runtime_forbid - Block run-time PM of a device.
+ * @dev: Device to handle.
+ *
+ * Increase the device's usage count and clear its power.runtime_auto flag,
+ * so that it cannot be suspended at run time until pm_runtime_allow() is called
+ * for it.
+ */
+void pm_runtime_forbid(struct device *dev)
+{
+	spin_lock_irq(&dev->power.lock);
+	if (!dev->power.runtime_auto)
+		goto out;
+
+	dev->power.runtime_auto = false;
+	atomic_inc(&dev->power.usage_count);
+	__pm_runtime_resume(dev, false);
+
+ out:
+	spin_unlock_irq(&dev->power.lock);
+}
+
+/**
+ * pm_runtime_allow - Unblock run-time PM of a device.
+ * @dev: Device to handle.
+ *
+ * Decrease the device's usage count and set its power.runtime_auto flag.
+ */
+void pm_runtime_allow(struct device *dev)
+{
+	spin_lock_irq(&dev->power.lock);
+	if (dev->power.runtime_auto)
+		goto out;
+
+	dev->power.runtime_auto = true;
+	if (atomic_dec_and_test(&dev->power.usage_count))
+		__pm_runtime_idle(dev);
+
+ out:
+	spin_unlock_irq(&dev->power.lock);
+}
+
+/**
  * pm_runtime_init - Initialize run-time PM fields in given device object.
  * @dev: Device object to initialize.
  */
@@ -1028,6 +1070,7 @@ void pm_runtime_init(struct device *dev)
 
 	atomic_set(&dev->power.child_count, 0);
 	pm_suspend_ignore_children(dev, false);
+	dev->power.runtime_auto = true;
 
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
