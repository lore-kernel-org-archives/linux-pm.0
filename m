From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: [RFC Add in_use attribute] Let the driver know if it's
	in use
Date: Thu, 16 Apr 2009 15:13:24 +0200
Message-ID: <20090416131323.GA16752@gandalf.sssup.it>
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

Drivers on embedded systems would be smart enough
to know that some of the devices should remain powered up, because
they could still be useful even when the CPU wasn't running.
The patch add the in_use attribute, that it can be used by the
the drivers to avoid power down during suspend.

Signed-off-by: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: "Alan Stern" <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Pavel Mackek" <pavel@ucw.cz>
Cc: "Len Brown" <lenb@kernel.org>

---
diff --git a/drivers/base/core.c b/drivers/base/core.c
index e73c92d..d67043b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1124,6 +1124,49 @@ static struct device *next_device(struct klist_iter *i)
 }
 
 /**
+ * device_visit_subtree - device subtree iterator.
+ * @root: root struct device.
+ * @data: data for the callback.
+ * @fn: function to be called for each device.
+ *
+ * Iterate the @parent's subtree devices, and call @fn for each,
+ * passing it @data.
+ *
+ */
+void device_visit_subtree(struct device *root, void *data,
+			  int (*fn)(struct device *dev, void *data))
+{
+	struct klist_iter i;
+	struct device *parent = root;
+	struct device *child = NULL;
+	int error;
+
+	klist_iter_init(&parent->p->klist_children, &i);
+move_down:
+	error = fn(parent, data);
+	if (error && parent != root)
+		goto move_up;
+
+	pr_debug("device: '%s': %s\n", dev_name(parent), __func__);
+
+	child = next_device(&i);
+	if (child) {
+		parent = child;
+		goto move_down;
+	}
+move_up:
+	klist_iter_exit(&i);
+	if (parent != root) {
+		klist_iter_init_node(&parent->parent->p->klist_children, &i,
+				     &parent->p->knode_parent);
+		parent = next_device(&i);
+		if (parent)
+			goto move_down;
+		klist_iter_exit(&i);
+	}
+}
+
+/**
  * device_for_each_child - device child iterator.
  * @parent: parent struct device.
  * @data: data for the callback.
@@ -1207,6 +1250,7 @@ int __init devices_init(void)
 	return -ENOMEM;
 }
 
+EXPORT_SYMBOL_GPL(device_visit_subtree);
 EXPORT_SYMBOL_GPL(device_for_each_child);
 EXPORT_SYMBOL_GPL(device_find_child);
 
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 69b4ddb..00ad150 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -64,6 +64,45 @@ void device_pm_unlock(void)
 	mutex_unlock(&dpm_list_mtx);
 }
 
+int device_set_may_inuse_enable(struct device *dev, void *data)
+{
+	pr_debug("PM: Device change in use status: %s\n", dev_name(dev));
+
+	/* if the device is suspend the subtree is in may_suspend status */
+	if (dev->power.is_inuse)
+		goto out;
+
+	dev->power.may_inuse = (unsigned int)data;
+	return 0;
+out:
+	/* cut the entire subtree */
+	return 1;
+}
+
+/**
+ *	device_set_inuse_enable - Mark the device as used by userspace
+ *	application
+ */
+int device_set_inuse_enable(struct device *dev, int enable)
+{
+	mutex_lock(&dpm_list_mtx);
+
+	/* the new status is equal the old one */
+	if (dev->power.is_inuse == enable)
+		goto out;
+
+	dev->power.is_inuse = enable;
+
+	/* Update device children to set the in use status */
+	device_visit_subtree(dev, (void *)enable,
+				device_set_may_inuse_enable);
+
+out:
+	mutex_unlock(&dpm_list_mtx);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(device_set_inuse_enable);
+
 /**
  *	device_pm_add - add a device to the list of active devices
  *	@dev:	Device to be added to the list
@@ -78,6 +117,13 @@ void device_pm_add(struct device *dev)
 		if (dev->parent->power.status >= DPM_SUSPENDING)
 			dev_warn(dev, "parent %s should not be sleeping\n",
 				 dev_name(dev->parent));
+		if (device_is_inuse(dev->parent)) {
+			mutex_unlock(&dpm_list_mtx);
+			/* if the parent has suspend disable, propagate it
+			 * to the new child */
+			device_set_may_inuse_enable(dev, (void *)1);
+			mutex_lock(&dpm_list_mtx);
+		}
 	} else if (transition_started) {
 		/*
 		 * We refuse to register parentless devices while a PM
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index c7cb4fc..e7d21bb 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -3,6 +3,11 @@ static inline void device_pm_init(struct device *dev)
 	dev->power.status = DPM_ON;
 }
 
+static inline int device_is_inuse(struct device *dev)
+{
+	return dev->power.is_inuse || dev->power.may_inuse;
+}
+
 #ifdef CONFIG_PM_SLEEP
 
 /*
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 596aeec..45d7f60 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -43,6 +43,34 @@
 static const char enabled[] = "enabled";
 static const char disabled[] = "disabled";
 
+static ssize_t inuse_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	return sprintf(buf, "%s\n", device_is_inuse(dev)
+		? enabled : disabled);
+}
+
+static ssize_t
+inuse_store(struct device *dev, struct device_attribute *attr,
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
+		device_set_inuse_enable(dev, 1);
+	else if (len == sizeof disabled - 1
+			&& strncmp(buf, disabled, sizeof disabled - 1) == 0)
+		device_set_inuse_enable(dev, 0);
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
+static DEVICE_ATTR(in_use, 0644, inuse_show, inuse_store);
 
 static struct attribute * power_attrs[] = {
 	&dev_attr_wakeup.attr,
+	&dev_attr_in_use.attr,
 	NULL,
 };
 static struct attribute_group pm_attr_group = {
diff --git a/include/linux/device.h b/include/linux/device.h
index 2918c0e..84a2bab 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -496,6 +496,9 @@ extern struct device *device_find_child(struct device *dev, void *data,
 extern int device_rename(struct device *dev, char *new_name);
 extern int device_move(struct device *dev, struct device *new_parent,
 		       enum dpm_order dpm_order);
+extern int device_set_inuse_enable(struct device *dev, int enable);
+extern void device_visit_subtree(struct device *root, void *data,
+				 int (*fn)(struct device *dev, void *data));
 
 /*
  * Root device objects for grouping under /sys/devices
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 1d4e2d2..85f3fb2 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -319,6 +319,9 @@ struct dev_pm_info {
 	pm_message_t		power_state;
 	unsigned		can_wakeup:1;
 	unsigned		should_wakeup:1;
+	unsigned		is_inuse:1;
+	unsigned		may_inuse:1;
+
 	enum dpm_state		status;		/* Owned by the PM core */
 #ifdef	CONFIG_PM_SLEEP
 	struct list_head	entry;
