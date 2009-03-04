From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC] [Patch] Fix device_move() vs. dpm list ordering, v2
Date: Wed, 4 Mar 2009 12:44:00 +0100
Message-ID: <20090304124400.6822dd83@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Marcel Holtmann <marcel@>
List-Id: linux-pm@vger.kernel.org

dpm_list currently relies on the fact that child devices will
be registered after their parents to get a correct suspend
order. Using device_move() however destroys this assumption, as
an already registered device may be moved under a newly registered
one.

This patch adds a new argument to device_move(), allowing callers
to specify how dpm_list should be adapted.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/core.c        |   19 ++++++++++++++++++-
 drivers/base/power/main.c  |   44 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/power/power.h |    8 ++++++++
 drivers/s390/cio/device.c  |    9 +++++----
 include/linux/device.h     |    3 ++-
 include/linux/pm.h         |   11 +++++++++++
 net/bluetooth/hci_sysfs.c  |    2 +-
 net/bluetooth/rfcomm/tty.c |    5 +++--
 8 files changed, 92 insertions(+), 9 deletions(-)

--- linux-2.6.orig/drivers/base/core.c
+++ linux-2.6/drivers/base/core.c
@@ -1545,8 +1545,10 @@ out:
  * device_move - moves a device to a new parent
  * @dev: the pointer to the struct device to be moved
  * @new_parent: the new parent of the device (can by NULL)
+ * @dpm_order: how to reorder the dpm_list
  */
-int device_move(struct device *dev, struct device *new_parent)
+int device_move(struct device *dev, struct device *new_parent,
+		enum dpm_order dpm_order)
 {
 	int error;
 	struct device *old_parent;
@@ -1556,6 +1558,7 @@ int device_move(struct device *dev, stru
 	if (!dev)
 		return -EINVAL;
 
+	device_pm_lock();
 	new_parent = get_device(new_parent);
 	new_parent_kobj = get_device_parent(dev, new_parent);
 
@@ -1596,9 +1599,23 @@ int device_move(struct device *dev, stru
 		put_device(new_parent);
 		goto out;
 	}
+	switch (dpm_order) {
+	case DPM_ORDER_NONE:
+		break;
+	case DPM_ORDER_DEV_AFTER_PARENT:
+		device_pm_move_after(dev, new_parent);
+		break;
+	case DPM_ORDER_PARENT_BEFORE_DEV:
+		device_pm_move_before(new_parent, dev);
+		break;
+	case DPM_ORDER_DEV_LAST:
+		device_pm_move_last(dev);
+		break;
+	}
 out_put:
 	put_device(old_parent);
 out:
+	device_pm_unlock();
 	put_device(dev);
 	return error;
 }
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -107,6 +107,50 @@ void device_pm_remove(struct device *dev
 }
 
 /**
+ *	device_pm_move_before - move device in dpm_list
+ *	@deva:  Device to move in dpm_list
+ *	@devb:  Device @deva should come before
+ */
+void device_pm_move_before(struct device *deva, struct device *devb)
+{
+	pr_debug("PM: Moving %s:%s before %s:%s\n",
+		 deva->bus ? deva->bus->name : "No Bus",
+		 kobject_name(&deva->kobj),
+		 devb->bus ? devb->bus->name : "No Bus",
+		 kobject_name(&devb->kobj));
+	/* Delete deva from dpm_list and reinsert before devb. */
+	list_move_tail(&deva->power.entry, &devb->power.entry);
+}
+
+/**
+ *	device_pm_move_after - move device in dpm_list
+ *	@deva:  Device to move in dpm_list
+ *	@devb:  Device @deva should come after
+ */
+void device_pm_move_after(struct device *deva, struct device *devb)
+{
+	pr_debug("PM: Moving %s:%s after %s:%s\n",
+		 deva->bus ? deva->bus->name : "No Bus",
+		 kobject_name(&deva->kobj),
+		 devb->bus ? devb->bus->name : "No Bus",
+		 kobject_name(&devb->kobj));
+	/* Delete deva from dpm_list and reinsert after devb. */
+	list_move(&deva->power.entry, &devb->power.entry);
+}
+
+/**
+ * 	device_pm_move_last - move device to end of dpm_list
+ * 	@dev:   Device to move in dpm_list
+ */
+void device_pm_move_last(struct device *dev)
+{
+	pr_debug("PM: Moving %s:%s to end of list\n",
+		 dev->bus ? dev->bus->name : "No Bus",
+		 kobject_name(&dev->kobj));
+	list_move_tail(&dev->power.entry, &dpm_list);
+}
+
+/**
  *	pm_op - execute the PM operation appropiate for given PM event
  *	@dev:	Device.
  *	@ops:	PM operations to choose from.
--- linux-2.6.orig/drivers/base/power/power.h
+++ linux-2.6/drivers/base/power/power.h
@@ -18,11 +18,19 @@ static inline struct device *to_device(s
 
 extern void device_pm_add(struct device *);
 extern void device_pm_remove(struct device *);
+extern void device_pm_move_before(struct device *, struct device *);
+extern void device_pm_move_after(struct device *, struct device *);
+extern void device_pm_move_last(struct device *);
 
 #else /* CONFIG_PM_SLEEP */
 
 static inline void device_pm_add(struct device *dev) {}
 static inline void device_pm_remove(struct device *dev) {}
+static inline void device_pm_move_before(struct device *deva,
+					 struct device *devb) {}
+static inline void device_pm_move_after(struct device *deva,
+					struct device *devb) {}
+static inline void device_pm_move_last(struct device *dev) {}
 
 #endif
 
--- linux-2.6.orig/drivers/s390/cio/device.c
+++ linux-2.6/drivers/s390/cio/device.c
@@ -799,7 +799,7 @@ static void sch_attach_disconnected_devi
 		return;
 	other_sch = to_subchannel(cdev->dev.parent);
 	/* Note: device_move() changes cdev->dev.parent */
-	ret = device_move(&cdev->dev, &sch->dev);
+	ret = device_move(&cdev->dev, &sch->dev, DPM_ORDER_PARENT_BEFORE_DEV);
 	if (ret) {
 		CIO_MSG_EVENT(0, "Moving disconnected device 0.%x.%04x failed "
 			      "(ret=%d)!\n", cdev->private->dev_id.ssid,
@@ -830,7 +830,7 @@ static void sch_attach_orphaned_device(s
 	 * Try to move the ccw device to its new subchannel.
 	 * Note: device_move() changes cdev->dev.parent
 	 */
-	ret = device_move(&cdev->dev, &sch->dev);
+	ret = device_move(&cdev->dev, &sch->dev, DPM_ORDER_PARENT_BEFORE_DEV);
 	if (ret) {
 		CIO_MSG_EVENT(0, "Moving device 0.%x.%04x from orphanage "
 			      "failed (ret=%d)!\n",
@@ -897,7 +897,8 @@ void ccw_device_move_to_orphanage(struct
 	 * ccw device can take its place on the subchannel.
 	 * Note: device_move() changes cdev->dev.parent
 	 */
-	ret = device_move(&cdev->dev, &css->pseudo_subchannel->dev);
+	ret = device_move(&cdev->dev, &css->pseudo_subchannel->dev,
+		DPM_ORDER_NONE);
 	if (ret) {
 		CIO_MSG_EVENT(0, "Moving device 0.%x.%04x to orphanage failed "
 			      "(ret=%d)!\n", cdev->private->dev_id.ssid,
@@ -1129,7 +1130,7 @@ static void ccw_device_move_to_sch(struc
 	 * Try to move the ccw device to its new subchannel.
 	 * Note: device_move() changes cdev->dev.parent
 	 */
-	rc = device_move(&cdev->dev, &sch->dev);
+	rc = device_move(&cdev->dev, &sch->dev, DPM_ORDER_PARENT_BEFORE_DEV);
 	mutex_unlock(&sch->reg_mutex);
 	if (rc) {
 		CIO_MSG_EVENT(0, "Moving device 0.%x.%04x to subchannel "
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -400,6 +400,9 @@ extern void __suspend_report_result(cons
 
 #else /* !CONFIG_PM_SLEEP */
 
+#define device_pm_lock() do {} while (0)
+#define device_pm_unlock() do {} while (0)
+
 static inline int device_suspend(pm_message_t state)
 {
 	return 0;
@@ -409,6 +412,14 @@ static inline int device_suspend(pm_mess
 
 #endif /* !CONFIG_PM_SLEEP */
 
+/* How to reorder dpm_list after device_move() */
+enum dpm_order {
+	DPM_ORDER_NONE,
+	DPM_ORDER_DEV_AFTER_PARENT,
+	DPM_ORDER_PARENT_BEFORE_DEV,
+	DPM_ORDER_DEV_LAST,
+};
+
 /*
  * Global Power Management flags
  * Used to keep APM and ACPI from both being active
--- linux-2.6.orig/net/bluetooth/rfcomm/tty.c
+++ linux-2.6/net/bluetooth/rfcomm/tty.c
@@ -731,7 +731,8 @@ static int rfcomm_tty_open(struct tty_st
 	remove_wait_queue(&dev->wait, &wait);
 
 	if (err == 0)
-		device_move(dev->tty_dev, rfcomm_get_device(dev));
+		device_move(dev->tty_dev, rfcomm_get_device(dev),
+			    DPM_ORDER_DEV_AFTER_PARENT);
 
 	rfcomm_tty_copy_pending(dev);
 
@@ -751,7 +752,7 @@ static void rfcomm_tty_close(struct tty_
 
 	if (atomic_dec_and_test(&dev->opened)) {
 		if (dev->tty_dev->parent)
-			device_move(dev->tty_dev, NULL);
+			device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
 
 		/* Close DLC and dettach TTY */
 		rfcomm_dlc_close(dev->dlc, 0);
--- linux-2.6.orig/net/bluetooth/hci_sysfs.c
+++ linux-2.6/net/bluetooth/hci_sysfs.c
@@ -140,7 +140,7 @@ static void del_conn(struct work_struct 
 		dev = device_find_child(&conn->dev, NULL, __match_tty);
 		if (!dev)
 			break;
-		device_move(dev, NULL);
+		device_move(dev, NULL, DPM_ORDER_DEV_LAST);
 		put_device(dev);
 	}
 
--- linux-2.6.orig/include/linux/device.h
+++ linux-2.6/include/linux/device.h
@@ -483,7 +483,8 @@ extern int device_for_each_child(struct 
 extern struct device *device_find_child(struct device *dev, void *data,
 				int (*match)(struct device *dev, void *data));
 extern int device_rename(struct device *dev, char *new_name);
-extern int device_move(struct device *dev, struct device *new_parent);
+extern int device_move(struct device *dev, struct device *new_parent,
+		       enum dpm_order dpm_order);
 
 /*
  * Root device objects for grouping under /sys/devices
