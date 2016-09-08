From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH v2 2/7] driver core: Functional dependencies tracking support
Date: Thu, 08 Sep 2016 23:27:45 +0200
Message-ID: <2169291.li0uc2Ryoq@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <27296716.H9VWo8ShOm@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.og>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Currently, there is a problem with handling cases where functional
dependencies between devices are involved.

What I mean by a "functional dependency" is when the driver of device
B needs both device A and its driver to be present and functional to
be able to work.  This implies that the driver of A needs to be
working for B to be probed successfully and it cannot be unbound from
the device before the B's driver.  This also has certain consequences
for power management of these devices (suspend/resume and runtime PM
ordering).

Add support for representing those functional dependencies between
devices to allow the driver core to track them and act on them in
certain cases where they matter.

The argument for doing that in the driver core is that there are
quite a few distinct use cases related to that, they are relatively
hard to get right in a driver (if one wants to address all of them
properly) and it only gets worse if multiplied by the number of
drivers potentially needing to do it.  Morever, at least one case
(asynchronous system suspend/resume) cannot be handled in a single
driver at all, because it requires the driver of A to wait for B to
suspend (during system suspend) and the driver of B to wait for
A to resume (during system resume).

To that end, represent links between devices (or more precisely
between device+driver combos) as a struct device_link object
containing pointers to the devices in question, a list node for
each of them, status information, flags, a lock and an RCU head
for synchronization.

Also add two new list heads, links_to_consumers and links_to_suppliers,
to struct device to represent the lists of links to the devices that
depend on the given one (consumers) and to the devices depended on
by it (suppliers), respectively.

The entire data structure consisting of all of the lists of link
objects for all devices is protected by SRCU (for list walking)
and a by mutex (for link object addition/removal).  In addition
to that, each link object has an internal status field whose
value reflects what's happening to the devices pointed to by
the link.  That status field is protected by an internal spinlock.

New links are added by calling device_link_add() which may happen
either before the consumer device is probed or when probing it, in
which case the caller must ensure that the driver of the supplier
device is present and functional and the DEVICE_LINK_SUPPLIER_READY
flag must be passed to device_link_add() to reflect that.

Link objects are deleted either explicitly, by calling
device_link_del() on the link object in question, or automatically,
when the consumer device is unbound from its driver or when one
of the target devices is deleted, depending on the link type.

There are two types of link objects, persistent and non-persistent.
The persistent ones stay around until one of the target devices is
deleted, while the non-persistent ones are deleted when the consumer
driver is unbound from its device (ie. they are assumed to be valid
only as long as the consumer device has a driver bound to it).  The
DEVICE_LINK_PERSISTENT flag is passed to device_link_add() to create
a persistent link and it cannot be used for links created at the
consumer probe time (that is, persistent links must be created before
probing the consumer devices).

One of the actions carried out by device_link_add() is to reorder
the lists used for device shutdown and system suspend/resume to
put the consumer device along with all of its children and all of
its consumers (and so on, recursively) to the ends of those list
in order to ensure the right ordering between the all of the supplier
and consumer devices.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/base.h    |   11 +
 drivers/base/core.c    |  421 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/dd.c      |   42 ++++
 include/linux/device.h |   35 ++++
 4 files changed, 504 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/base/base.h
===================================================================
--- linux-pm.orig/drivers/base/base.h
+++ linux-pm/drivers/base/base.h
@@ -107,6 +107,9 @@ extern void bus_remove_device(struct dev
 
 extern int bus_add_driver(struct device_driver *drv);
 extern void bus_remove_driver(struct device_driver *drv);
+extern void device_release_driver_internal(struct device *dev,
+					   struct device_driver *drv,
+					   struct device *parent);
 
 extern void driver_detach(struct device_driver *drv);
 extern int driver_probe_device(struct device_driver *drv, struct device *dev);
@@ -152,3 +155,11 @@ extern int devtmpfs_init(void);
 #else
 static inline int devtmpfs_init(void) { return 0; }
 #endif
+
+/* Device links */
+extern int device_links_check_suppliers(struct device *dev);
+extern void device_links_driver_bound(struct device *dev);
+extern void device_links_driver_gone(struct device *dev);
+extern void device_links_no_driver(struct device *dev);
+extern bool device_links_busy(struct device *dev);
+extern void device_links_unbind_consumers(struct device *dev);
Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -44,6 +44,402 @@ static int __init sysfs_deprecated_setup
 early_param("sysfs.deprecated", sysfs_deprecated_setup);
 #endif
 
+/* Device links support. */
+
+DEFINE_STATIC_SRCU(device_links_srcu);
+static DEFINE_MUTEX(device_links_lock);
+
+/**
+ * device_is_dependent - Check if one device depends on another one
+ * @dev: Device to check dependencies for.
+ * @target: Device to check against.
+ *
+ * Check if @dev or any device dependent on it (its child or its consumer etc)
+ * depends on @target.  Return 1 if that is the case or 0 otherwise.
+ */
+static int device_is_dependent(struct device *dev, void *target)
+{
+	struct device_link *link;
+	int ret;
+
+	ret = device_for_each_child(dev, target, device_is_dependent);
+	list_for_each_entry(link, &dev->links_to_consumers, s_node) {
+		if (WARN_ON(link->consumer == target))
+			return 1;
+
+		ret = ret || device_is_dependent(link->consumer, target);
+	}
+	return ret;
+}
+
+static int device_reorder_to_tail(struct device *dev, void *not_used)
+{
+	struct device_link *link;
+
+	devices_kset_move_last(dev);
+	device_pm_move_last(dev);
+	device_for_each_child(dev, NULL, device_reorder_to_tail);
+	list_for_each_entry(link, &dev->links_to_consumers, s_node)
+		device_reorder_to_tail(link->consumer, NULL);
+
+	return 0;
+}
+
+/**
+ * device_link_add - Create a link between two devices.
+ * @consumer: Consumer end of the link.
+ * @supplier: Supplier end of the link.
+ * @status: Initial status of the link.
+ * @flags: Link flags.
+ *
+ * The caller is responsible for ensuring that (a) @status reflects the current
+ * status of both @consumer and @supplier and (b) the creation of the new link
+ * is properly synchronized with runtime PM (especially if @status is
+ * DEVICE_LINK_ACTIVE).
+ *
+ * A side effect of the link creation is re-ordering of dpm_list and the
+ * devices_kset list by moving the consumer device and all devices depending
+ * on it to the ends of these lists.
+ */
+struct device_link *device_link_add(struct device *consumer,
+				    struct device *supplier,
+				    enum device_link_status status, u32 flags)
+{
+	struct device_link *link;
+
+	if (!consumer || !supplier || status == DEVICE_LINK_SUPPLIER_UNBIND)
+		return NULL;
+
+	mutex_lock(&device_links_lock);
+
+	/*
+	 * If there is a reverse dependency between the consumer and the
+	 * supplier already in the graph, return NULL.
+	 */
+	if (device_is_dependent(consumer, supplier)) {
+		link = NULL;
+		goto out;
+	}
+
+	list_for_each_entry(link, &supplier->links_to_consumers, s_node)
+		if (link->consumer == consumer)
+			goto out;
+
+	link = kmalloc(sizeof(*link), GFP_KERNEL);
+	if (!link)
+		goto out;
+
+	get_device(supplier);
+	link->supplier = supplier;
+	INIT_LIST_HEAD(&link->s_node);
+	get_device(consumer);
+	link->consumer = consumer;
+	INIT_LIST_HEAD(&link->c_node);
+	spin_lock_init(&link->lock);
+	link->flags = flags;
+	link->status = status;
+
+	/*
+	 * Move the consumer and all of the devices depending on it to the end
+	 * of dpm_list and the devices_kset list.
+	 *
+	 * It is necessary to hold dpm_list locked throughout all that or else
+	 * we may end up suspending with a wrong ordering of it.
+	 */
+	device_pm_lock();
+	device_reorder_to_tail(consumer, NULL);
+	device_pm_unlock();
+
+	list_add_tail_rcu(&link->s_node, &supplier->links_to_consumers);
+	list_add_tail_rcu(&link->c_node, &consumer->links_to_suppliers);
+
+	dev_info(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
+
+ out:
+	mutex_unlock(&device_links_lock);
+	return link;
+}
+EXPORT_SYMBOL_GPL(device_link_add);
+
+static void __device_link_free_srcu(struct rcu_head *rhead)
+{
+	struct device_link *link;
+
+	link = container_of(rhead, struct device_link, rcu_head);
+	put_device(link->consumer);
+	put_device(link->supplier);
+	kfree(link);
+}
+
+static void __device_link_del(struct device_link *link)
+{
+	dev_info(link->consumer, "Dropping the link to %s\n",
+		 dev_name(link->supplier));
+
+	list_del_rcu(&link->s_node);
+	list_del_rcu(&link->c_node);
+	call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
+}
+
+/**
+ * device_link_del - Delete a link between two devices.
+ * @link: Device link to delete.
+ *
+ * The caller must ensure proper synchronization of this function with runtime
+ * PM.
+ */
+void device_link_del(struct device_link *link)
+{
+	mutex_lock(&device_links_lock);
+	device_pm_lock();
+	__device_link_del(link);
+	device_pm_unlock();
+	mutex_unlock(&device_links_lock);
+}
+EXPORT_SYMBOL_GPL(device_link_del);
+
+static int device_links_read_lock(void)
+{
+	return srcu_read_lock(&device_links_srcu);
+}
+
+static void device_links_read_unlock(int idx)
+{
+	return srcu_read_unlock(&device_links_srcu, idx);
+}
+
+static void device_links_missing_supplier(struct device *dev)
+{
+	struct device_link *link;
+
+	list_for_each_entry_rcu(link, &dev->links_to_suppliers, c_node) {
+		spin_lock(&link->lock);
+
+		if (link->status == DEVICE_LINK_CONSUMER_PROBE)
+			link->status = DEVICE_LINK_AVAILABLE;
+
+		spin_unlock(&link->lock);
+	}
+}
+
+/**
+ * device_links_check_suppliers - Check supplier devices for this one.
+ * @dev: Consumer device.
+ *
+ * Check links from this device to any suppliers.  Walk the list of the device's
+ * consumer links and see if all of the suppliers are available.  If not, simply
+ * return -EPROBE_DEFER.
+ *
+ * Walk the list under SRCU and check each link's status field under its lock.
+ *
+ * We need to guarantee that the supplier will not go away after the check has
+ * been positive here.  It only can go away in __device_release_driver() and
+ * that function  checks the device's links to consumers.  This means we need to
+ * mark the link as "consumer probe in progress" to make the supplier removal
+ * wait for us to complete (or bad things may happen).
+ */
+int device_links_check_suppliers(struct device *dev)
+{
+	struct device_link *link;
+	int idx, ret = 0;
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links_to_suppliers, c_node) {
+		spin_lock(&link->lock);
+		if (link->status != DEVICE_LINK_AVAILABLE) {
+			spin_unlock(&link->lock);
+			device_links_missing_supplier(dev);
+			ret = -EPROBE_DEFER;
+			break;
+		}
+		link->status = DEVICE_LINK_CONSUMER_PROBE;
+		spin_unlock(&link->lock);
+	}
+
+	device_links_read_unlock(idx);
+	return ret;
+}
+
+/**
+ * device_links_driver_bound - Update device links after probing its driver.
+ * @dev: Device to update the links for.
+ *
+ * The probe has been successful, so update links from this device to any
+ * consumers by changing their status to "available".
+ *
+ * Also change the status of @dev's links to suppliers to "active".
+ */
+void device_links_driver_bound(struct device *dev)
+{
+	struct device_link *link;
+	int idx;
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links_to_consumers, s_node) {
+		spin_lock(&link->lock);
+		WARN_ON(link->status != DEVICE_LINK_DORMANT);
+		link->status = DEVICE_LINK_AVAILABLE;
+		spin_unlock(&link->lock);
+	}
+
+	list_for_each_entry_rcu(link, &dev->links_to_suppliers, c_node) {
+		spin_lock(&link->lock);
+		WARN_ON(link->status != DEVICE_LINK_CONSUMER_PROBE);
+		link->status = DEVICE_LINK_ACTIVE;
+		spin_unlock(&link->lock);
+	}
+
+	device_links_read_unlock(idx);
+}
+
+/**
+ * device_links_driver_gone - Update links after driver removal.
+ * @dev: Device whose driver has gone away.
+ *
+ * Update links to consumers for @dev by changing their status to "dormant".
+ */
+void device_links_driver_gone(struct device *dev)
+{
+	struct device_link *link;
+	int idx;
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links_to_consumers, s_node) {
+		WARN_ON(!(link->flags & DEVICE_LINK_PERSISTENT));
+		spin_lock(&link->lock);
+		WARN_ON(link->status != DEVICE_LINK_SUPPLIER_UNBIND);
+		link->status = DEVICE_LINK_DORMANT;
+		spin_unlock(&link->lock);
+	}
+
+	device_links_read_unlock(idx);
+}
+
+/**
+ * device_links_no_driver - Update links of a device without a driver.
+ * @dev: Device without a drvier.
+ *
+ * Delete all non-persistent links from this device to any suppliers.
+ * Persistent links stay around, but their status is changed to "available",
+ * unless they already are in the "supplier unbind in progress" state in which
+ * case they need not be updated.
+ */
+void device_links_no_driver(struct device *dev)
+{
+	struct device_link *link, *ln;
+
+	mutex_lock(&device_links_lock);
+
+	list_for_each_entry_safe_reverse(link, ln, &dev->links_to_suppliers, c_node)
+		if (link->flags & DEVICE_LINK_PERSISTENT) {
+			spin_lock(&link->lock);
+
+			if (link->status != DEVICE_LINK_SUPPLIER_UNBIND)
+				link->status = DEVICE_LINK_AVAILABLE;
+
+			spin_unlock(&link->lock);
+		} else {
+			__device_link_del(link);
+		}
+
+	mutex_unlock(&device_links_lock);
+}
+
+/**
+ * device_links_busy - Check if there are any busy links to consumers.
+ * @dev: Device to check.
+ *
+ * Check each consumer of the device and return 'true' if its link's status
+ * is one of "consumer probe" or "active" (meaning that the given consumer is
+ * probing right now or its driver is present).  Otherwise, change the link
+ * state to "supplier unbind" to prevent the consumer from being probed
+ * successfully going forward.
+ *
+ * Return 'false' if there are no probing or active consumers.
+ */
+bool device_links_busy(struct device *dev)
+{
+	struct device_link *link;
+	int idx;
+	bool ret = false;
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links_to_consumers, s_node) {
+		spin_lock(&link->lock);
+		if (link->status == DEVICE_LINK_CONSUMER_PROBE
+		    || link->status == DEVICE_LINK_ACTIVE) {
+			spin_unlock(&link->lock);
+			ret = true;
+			break;
+		}
+		link->status = DEVICE_LINK_SUPPLIER_UNBIND;
+		spin_unlock(&link->lock);
+	}
+
+	device_links_read_unlock(idx);
+	return ret;
+}
+
+/**
+ * device_links_unbind_consumers - Force unbind consumers of the given device.
+ * @dev: Device to unbind the consumers of.
+ *
+ * Walk the list of links to consumers for @dev and if any of them is in the
+ * "consumer probe" state, wait for all device probes in progress to complete
+ * and start over.
+ *
+ * If that's not the case, change the status of the link to "supplier unbind"
+ * and check if the link was in the "active" state.  If so, force the consumer
+ * driver to unbind and start over (the consumer will not re-probe as we have
+ * changed the state of the link already).
+ */
+void device_links_unbind_consumers(struct device *dev)
+{
+	struct device_link *link;
+	int idx;
+
+ start:
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links_to_consumers, s_node) {
+		enum device_link_status status;
+
+		spin_lock(&link->lock);
+		status = link->status;
+		if (status == DEVICE_LINK_CONSUMER_PROBE) {
+			spin_unlock(&link->lock);
+
+			device_links_read_unlock(idx);
+
+			wait_for_device_probe();
+			goto start;
+		}
+		link->status = DEVICE_LINK_SUPPLIER_UNBIND;
+		if (status == DEVICE_LINK_ACTIVE) {
+			struct device *consumer = link->consumer;
+
+			get_device(consumer);
+			spin_unlock(&link->lock);
+
+			device_links_read_unlock(idx);
+
+			device_release_driver_internal(consumer, NULL,
+						       consumer->parent);
+			put_device(consumer);
+			goto start;
+		}
+		spin_unlock(&link->lock);
+	}
+
+	device_links_read_unlock(idx);
+}
+
+/* Device links support end. */
+
 int (*platform_notify)(struct device *dev) = NULL;
 int (*platform_notify_remove)(struct device *dev) = NULL;
 static struct kobject *dev_kobj;
@@ -711,6 +1107,8 @@ void device_initialize(struct device *de
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	INIT_LIST_HEAD(&dev->msi_list);
 #endif
+	INIT_LIST_HEAD(&dev->links_to_consumers);
+	INIT_LIST_HEAD(&dev->links_to_suppliers);
 }
 EXPORT_SYMBOL_GPL(device_initialize);
 
@@ -1233,6 +1631,7 @@ void device_del(struct device *dev)
 {
 	struct device *parent = dev->parent;
 	struct class_interface *class_intf;
+	struct device_link *link, *ln;
 
 	/* Notify clients of device removal.  This call must come
 	 * before dpm_sysfs_remove().
@@ -1240,6 +1639,28 @@ void device_del(struct device *dev)
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DEL_DEVICE, dev);
+
+	/*
+	 * Delete all of the remaining links from this device to any other
+	 * devices (either consumers or suppliers).
+	 *
+	 * This requires that all links be dormant, so warn if that's no the
+	 * case.
+	 */
+	mutex_lock(&device_links_lock);
+
+	list_for_each_entry_safe_reverse(link, ln, &dev->links_to_suppliers, c_node) {
+		WARN_ON(link->status != DEVICE_LINK_DORMANT);
+		__device_link_del(link);
+	}
+
+	list_for_each_entry_safe_reverse(link, ln, &dev->links_to_consumers, s_node) {
+		WARN_ON(link->status != DEVICE_LINK_DORMANT);
+		__device_link_del(link);
+	}
+
+	mutex_unlock(&device_links_lock);
+
 	dpm_sysfs_remove(dev);
 	if (parent)
 		klist_del(&dev->p->knode_parent);
Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -249,6 +249,7 @@ static void driver_bound(struct device *
 		 __func__, dev_name(dev));
 
 	klist_add_tail(&dev->p->knode_driver, &dev->driver->p->klist_devices);
+	device_links_driver_bound(dev);
 
 	device_pm_check_callbacks(dev);
 
@@ -399,6 +400,7 @@ probe_failed:
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
 pinctrl_bind_failed:
+	device_links_no_driver(dev);
 	devres_release_all(dev);
 	driver_sysfs_remove(dev);
 	dev->driver = NULL;
@@ -489,6 +491,10 @@ int driver_probe_device(struct device_dr
 	if (!device_is_registered(dev))
 		return -ENODEV;
 
+	ret = device_links_check_suppliers(dev);
+	if (ret)
+		return ret;
+
 	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 
@@ -756,7 +762,7 @@ EXPORT_SYMBOL_GPL(driver_attach);
  * __device_release_driver() must be called with @dev lock held.
  * When called for a USB interface, @dev->parent lock must be held as well.
  */
-static void __device_release_driver(struct device *dev)
+static void __device_release_driver(struct device *dev, struct device *parent)
 {
 	struct device_driver *drv;
 
@@ -765,6 +771,25 @@ static void __device_release_driver(stru
 		if (driver_allows_async_probing(drv))
 			async_synchronize_full();
 
+		while (device_links_busy(dev)) {
+			device_unlock(dev);
+			if (parent)
+				device_unlock(parent);
+
+			device_links_unbind_consumers(dev);
+			if (parent)
+				device_lock(parent);
+
+			device_lock(dev);
+			/*
+			 * A concurrent invocation of the same function might
+			 * have released the driver successfully while this one
+			 * was waiting, so check for that.
+			 */
+			if (dev->driver != drv)
+				return;
+		}
+
 		pm_runtime_get_sync(dev);
 
 		driver_sysfs_remove(dev);
@@ -780,6 +805,9 @@ static void __device_release_driver(stru
 			dev->bus->remove(dev);
 		else if (drv->remove)
 			drv->remove(dev);
+
+		device_links_driver_gone(dev);
+		device_links_no_driver(dev);
 		devres_release_all(dev);
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
@@ -796,16 +824,16 @@ static void __device_release_driver(stru
 	}
 }
 
-static void device_release_driver_internal(struct device *dev,
-					   struct device_driver *drv,
-					   struct device *parent)
+void device_release_driver_internal(struct device *dev,
+				    struct device_driver *drv,
+				    struct device *parent)
 {
 	if (parent)
 		device_lock(parent);
 
 	device_lock(dev);
 	if (!drv || drv == dev->driver)
-		__device_release_driver(dev);
+		__device_release_driver(dev, parent);
 
 	device_unlock(dev);
 	if (parent)
@@ -818,6 +846,10 @@ static void device_release_driver_intern
  *
  * Manually detach device from driver.
  * When called for a USB interface, @dev->parent lock must be held.
+ *
+ * If this function is to be called with @dev->parent lock held, ensure that
+ * the device's consumers are unbound in advance or that their locks can be
+ * acquired under the @dev->parent lock.
  */
 void device_release_driver(struct device *dev)
 {
Index: linux-pm/include/linux/device.h
===================================================================
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -706,6 +706,32 @@ struct device_dma_parameters {
 	unsigned long segment_boundary_mask;
 };
 
+enum device_link_status {
+	DEVICE_LINK_DORMANT = 0,	/* Link not in use. */
+	DEVICE_LINK_AVAILABLE,		/* Supplier driver is present. */
+	DEVICE_LINK_ACTIVE,		/* Consumer driver is present too. */
+	DEVICE_LINK_CONSUMER_PROBE,	/* Consumer is probing. */
+	DEVICE_LINK_SUPPLIER_UNBIND,	/* Supplier is unbinding. */
+};
+
+/*
+ * Device link flags.
+ *
+ * PERSISTENT: Do not delete the link on consumer device driver unbind.
+ */
+#define DEVICE_LINK_PERSISTENT	(1 << 0)
+
+struct device_link {
+	struct device *supplier;
+	struct list_head s_node;
+	struct device *consumer;
+	struct list_head c_node;
+	enum device_link_status status;
+	u32 flags;
+	spinlock_t lock;
+	struct rcu_head rcu_head;
+};
+
 /**
  * struct device - The basic device structure
  * @parent:	The device's "parent" device, the device to which it is attached.
@@ -731,6 +757,8 @@ struct device_dma_parameters {
  * 		on.  This shrinks the "Board Support Packages" (BSPs) and
  * 		minimizes board-specific #ifdefs in drivers.
  * @driver_data: Private pointer for driver specific info.
+ * @links_to_consumers: Links to consumer devices.
+ * @links_to_suppliers: Links to supplier devices.
  * @power:	For device power management.
  * 		See Documentation/power/devices.txt for details.
  * @pm_domain:	Provide callbacks that are executed during system suspend,
@@ -797,6 +825,8 @@ struct device {
 					   core doesn't touch it */
 	void		*driver_data;	/* Driver data, set and get with
 					   dev_set/get_drvdata */
+	struct list_head	links_to_consumers;
+	struct list_head	links_to_suppliers;
 	struct dev_pm_info	power;
 	struct dev_pm_domain	*pm_domain;
 
@@ -1113,6 +1143,11 @@ extern void device_shutdown(void);
 /* debugging and troubleshooting/diagnostic helpers. */
 extern const char *dev_driver_string(const struct device *dev);
 
+/* Device links interface. */
+struct device_link *device_link_add(struct device *consumer,
+				    struct device *supplier,
+				    enum device_link_status status, u32 flags);
+void device_link_del(struct device_link *link);
 
 #ifdef CONFIG_PRINTK
 
