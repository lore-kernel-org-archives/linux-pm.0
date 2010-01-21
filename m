From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] PM / Runtime: Add sysfs switch for disabling
	device run-time PM (rev. 2)
Date: Thu, 21 Jan 2010 23:59:38 +0100
Message-ID: <201001212359.38886.rjw__45115.0871850134$1264114950$gmane$org@sisk.pl>
References: <201001180129.55219.rjw@sisk.pl> <201001212357.46483.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001212357.46483.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Add new device sysfs attribute, power/control, allowing the user
space to block the run-time power management of devices.  If this
attribute is set to "on", the driver of the device won't be able to power
manage it at run time (without breaking the rules) and the device will
always be in the full power state (except when the entire system goes
into a sleep state).

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
+ *	control - Report/change current runtime PM setting of the device
+ *
+ *	Runtime power management of a device can be blocked with the help of
+ *	this attribute.  All devices have one of the following two values for
+ *	the power/control file:
+ *
+ *	 + "auto\n" to allow the device to be power managed at run time;
+ *	 + "on\n" to prevent the device from being power managed at run time;
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
+static const char ctrl_auto[] = "auto";
+static const char ctrl_on[] = "on";
+
+static ssize_t control_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	return sprintf(buf, "%s\n",
+				dev->power.runtime_auto ? ctrl_auto : ctrl_on);
+}
+
+static ssize_t control_store(struct device * dev, struct device_attribute *attr,
+			     const char * buf, size_t n)
+{
+	char *cp;
+	int len = n;
+
+	cp = memchr(buf, '\n', n);
+	if (cp)
+		len = cp - buf;
+	if (len == sizeof ctrl_auto - 1 && strncmp(buf, ctrl_auto, len) == 0)
+		pm_runtime_allow(dev);
+	else if (len == sizeof ctrl_on - 1 && strncmp(buf, ctrl_on, len) == 0)
+		pm_runtime_forbid(dev);
+	else
+		return -EINVAL;
+	return n;
+}
+
+static DEVICE_ATTR(control, 0644, control_show, control_store);
+#endif
+
 static ssize_t
 wake_show(struct device * dev, struct device_attribute *attr, char * buf)
 {
@@ -123,6 +170,9 @@ static DEVICE_ATTR(async, 0644, async_sh
 #endif /* CONFIG_PM_SLEEP_ADVANCED_DEBUG */
 
 static struct attribute * power_attrs[] = {
+#ifdef CONFIG_PM_RUNTIME
+	&dev_attr_control.attr,
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
