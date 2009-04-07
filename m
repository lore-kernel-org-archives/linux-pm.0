From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: [RFC Disable suspend on a specific device] This is a
	little change	in linux power scheme
Date: Tue, 7 Apr 2009 12:29:14 +0200
Message-ID: <20090407102914.GA25796@gandalf.sssup.it>
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
Cc: len.brown@intel.com, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

This is a little rework of linux power scheme. TODO:
- remove recursive call
- clean-up code

Avoid suspend of a device that is connected with other coprocessor
like GSM chip.

Signed-off-by: Michael Trimarchi <trimarchi@gandalf.sssup.it>

---
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3098c46..2a6ddb3 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -63,6 +63,40 @@ void device_pm_unlock(void)
 	mutex_unlock(&dpm_list_mtx);
 }
 
+int device_set_may_suspend_enable(struct device *dev, void *data)
+{
+	/* if the device is suspend the subtree is in may_suspend status */
+	if (!dev->power.can_suspend)
+		goto out;
+
+	dev->power.may_suspend = (unsigned int)data;
+	device_for_each_child(dev, data,
+			      device_set_may_suspend_enable);
+out:
+	return 0;
+}
+
+/**
+ *	device_set_suspend_enable - enable/disable device to suspend
+ */
+int device_set_suspend_enable(struct device *dev, int enable)
+{
+	mutex_lock(&dpm_list_mtx);
+
+	if (dev->power.can_suspend == !!enable)
+		goto out;
+
+	/* Update device children to avoid suspend */
+	device_for_each_child(dev, (void *)!!enable,
+			      device_set_may_suspend_enable);
+
+	dev->power.can_suspend = !!enable;
+out:
+	mutex_unlock(&dpm_list_mtx);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(device_set_suspend_enable);
+
 /**
  *	device_pm_add - add a device to the list of active devices
  *	@dev:	Device to be added to the list
@@ -77,6 +111,13 @@ void device_pm_add(struct device *dev)
 		if (dev->parent->power.status >= DPM_SUSPENDING)
 			dev_warn(dev, "parent %s should not be sleeping\n",
 				 dev_name(dev->parent));
+		if (!device_can_suspend(dev->parent)) {
+			mutex_unlock(&dpm_list_mtx);
+			/* if the parent has suspend disable, propagate it
+			 * to the new child */
+			device_set_may_suspend_enable(dev, 0);
+			mutex_lock(&dpm_list_mtx);
+		}
 	} else if (transition_started) {
 		/*
 		 * We refuse to register parentless devices while a PM
@@ -120,13 +161,13 @@ static int pm_op(struct device *dev, struct dev_pm_ops *ops,
 	switch (state.event) {
 #ifdef CONFIG_SUSPEND
 	case PM_EVENT_SUSPEND:
-		if (ops->suspend) {
+		if (device_can_suspend(dev) && ops->suspend) {
 			error = ops->suspend(dev);
 			suspend_report_result(ops->suspend, error);
 		}
 		break;
 	case PM_EVENT_RESUME:
-		if (ops->resume) {
+		if (device_can_suspend(dev) && ops->resume) {
 			error = ops->resume(dev);
 			suspend_report_result(ops->resume, error);
 		}
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 41f51fa..1197b13 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -1,6 +1,13 @@
 static inline void device_pm_init(struct device *dev)
 {
 	dev->power.status = DPM_ON;
+	dev->power.can_suspend = 1;
+	dev->power.may_suspend = 1;
+}
+
+static inline int device_can_suspend(struct device *dev)
+{
+	return (dev->power.can_suspend && dev->power.may_suspend);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 596aeec..25236aa 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -43,6 +43,34 @@
 static const char enabled[] = "enabled";
 static const char disabled[] = "disabled";
 
+static ssize_t suspend_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	return sprintf(buf, "%s\n", device_can_suspend(dev)
+		? enabled : disabled);
+}
+
+static ssize_t
+suspend_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t n)
+{
+	char *cp;
+	int len = n;
+
+	cp = memchr(buf, '\n', n);
+	if (cp)
+		len = cp - buf;
+	if (len == sizeof enabled - 1
+			&& strncmp(buf, enabled, sizeof enabled - 1) == 0)
+		device_set_suspend_enable(dev, 1);
+	else if (len == sizeof disabled - 1
+			&& strncmp(buf, disabled, sizeof disabled - 1) == 0)
+		device_set_suspend_enable(dev, 0);
+	else
+		return -EINVAL;
+	return n;
+}
+
 static ssize_t
 wake_show(struct device * dev, struct device_attribute *attr, char * buf)
 {
@@ -76,10 +104,11 @@ wake_store(struct device * dev, struct device_attribute *attr,
 }
 
 static DEVICE_ATTR(wakeup, 0644, wake_show, wake_store);
-
+static DEVICE_ATTR(suspend, 0644, suspend_show, suspend_store);
 
 static struct attribute * power_attrs[] = {
 	&dev_attr_wakeup.attr,
+	&dev_attr_suspend.attr,
 	NULL,
 };
 static struct attribute_group pm_attr_group = {
diff --git a/include/linux/device.h b/include/linux/device.h
index fdb073b..dc9f242 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -487,6 +487,7 @@ extern struct device *device_find_child(struct device *dev, void *data,
 				int (*match)(struct device *dev, void *data));
 extern int device_rename(struct device *dev, char *new_name);
 extern int device_move(struct device *dev, struct device *new_parent);
+extern int device_set_suspend_enable(struct device *dev, int enable);
 
 /*
  * Root device objects for grouping under /sys/devices
diff --git a/include/linux/pm.h b/include/linux/pm.h
index de2e0a8..7586a90 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -319,6 +319,9 @@ struct dev_pm_info {
 	pm_message_t		power_state;
 	unsigned		can_wakeup:1;
 	unsigned		should_wakeup:1;
+	unsigned		can_suspend:1;
+	unsigned		may_suspend:1;
+
 	enum dpm_state		status;		/* Owned by the PM core */
 #ifdef	CONFIG_PM_SLEEP
 	struct list_head	entry;
