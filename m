From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v4 2/5] driver core: Functional dependencies tracking support
Date: Thu, 29 Sep 2016 02:38:04 +0200
Message-ID: <1985903.oaAlgI6mU5@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <10860219.QqH5akBVoh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <10860219.QqH5akBVoh@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Currently, there is a problem with taking functional dependencies
between devices into account.

What I mean by a "functional dependency" is when the driver of device
B needs device A to be functional and (generally) its driver to be
present in order to work properly.  This has certain consequences
for power management (suspend/resume and runtime PM ordering) and
shutdown ordering of these devices.  In general, it also implies that
the driver of A needs to be working for B to be probed successfully
and it cannot be unbound from the device before the B's driver.

Support for representing those functional dependencies between
devices is added here to allow the driver core to track them and act
on them in certain cases where applicable.

The argument for doing that in the driver core is that there are
quite a few distinct use cases involving device dependencies, they
are relatively hard to get right in a driver (if one wants to
address all of them properly) and it only gets worse if multiplied
by the number of drivers potentially needing to do it.  Morever, at
least one case (asynchronous system suspend/resume) cannot be handled
in a single driver at all, because it requires the driver of A to
wait for B to suspend (during system suspend) and the driver of B to
wait for A to resume (during system resume).

For this reason, represent dependencies between devices as "links",
with the help of struct device_link objects each containing pointers
to the "linked" devices, a list node for each of them, status
information, flags, a lock and an RCU head for synchronization.

Also add two new list heads, links_to_consumers and links_to_suppliers,
to struct device to represent the lists of links to the devices that
depend on the given one (consumers) and to the devices depended on
by it (suppliers), respectively.

The entire data structure consisting of all of the lists of link
objects for all devices is protected by SRCU (for list walking)
and by a mutex (for link object addition/removal).  In addition
to that, each link object has an internal status field whose
value reflects whether or not drivers are bound to the devices
pointed to by the link or probing/removal of their drivers is in
progress etc.  That status field is protected by an internal
spinlock.

New links are added by calling device_link_add() which takes four
arguments: pointers to the devices in question, the initial status
of the link and flags.  In particular, if DEVICE_LINK_STATELESS is
set in the flags, the link status is not to be taken into account
for this link and the driver core will not manage it.  In turn, if
DEVICE_LINK_AUTOREMOVE is set in the flags, the driver core will
remove the link automatically when the consumer device driver
unbinds from it.

One of the actions carried out by device_link_add() is to reorder
the lists used for device shutdown and system suspend/resume to
put the consumer device along with all of its children and all of
its consumers (and so on, recursively) to the ends of those lists
in order to ensure the right ordering between all of the supplier
and consumer devices.

For this reason, it is not possible to create a link between two
devices if the would-be supplier device already depends on the
would-be consumer device as either a direct descendant of it or a
consumer of one of its direct descendants or one of its consumers
and so on.

It also is impossible to create a link between a parent and a child
device (in any direction).

There are two types of link objects, persistent and non-persistent.
The persistent ones stay around until one of the target devices is
deleted, while the non-persistent ones are removed automatically when
the consumer driver unbinds from its device (ie. they are assumed to
be valid only as long as the consumer device has a driver bound to
it).  Persistent links are created by default and non-persistent
links are created when the DEVICE_LINK_AUTOREMOVE flag is passed
to device_link_add().

Both persistent and non-persistent device links can be deleted
explicitly with the help of device_link_del().

Links created without the DEVICE_LINK_STATELESS flag set are managed
by the driver core using a simple state machine.  There are 5 states
each link can be in: DORMANT (unused), AVAILABLE (the supplier driver
is present and functional), CONSUMER_PROBE (the consumer driver is
probing), ACTIVE (both supplier and consumer drivers are present and
functional), and SUPPLIER_UNBIND (the supplier driver is unbinding).
The driver core updates the link state automatically depending on
what happens to the linked devices and for each link state specific
actions are taken in addition to that.

For example, if the supplier driver unbinds from its device, the
driver core will also unbind the drivers of all of its consumers
automatically under the assumption that they cannot function
properly without the supplier.  Analogously, the driver core will
only allow the consumer driver to bind to its device if the
supplier driver is present and functional (ie. the link is in
the AVAILABLE state).  If that's not the case, it will rely on
the existing deferred probing mechanism to wait for the supplier
driver to become available.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4:

- Add the in_dpm_list field to struct dev_pm_info and use it for checking
  if the device has been added to dpm_list already, which is needed for
  handling the "not registered consumer" case in device_link_add().

- Rework device_link_add() to handle consumer devices that have not been
  registered before calling it.

- Drop the parent check from device_link_add().

- Rename device_links_driver_gone() to device_links_driver_cleanup()

- Rearrange device_links_unbind_consumers() to avoid one spin_unlock()
  instance (which wasn't necessary).

- Introduce device_links_purge() to delete links from a device going away
  and make device_del() call it (instead of running links-related code
  directly).

- Move the invocation of device_links_ckeck_suppliers() to really_probe().

- Change the description of the DEVICE_LINK_STATELESS flag.

---
 drivers/base/base.h        |   11 +
 drivers/base/core.c        |  491 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/dd.c          |   42 +++
 drivers/base/power/main.c  |    2 
 drivers/base/power/power.h |   10 
 include/linux/device.h     |   38 +++
 include/linux/pm.h         |    1 
 7 files changed, 590 insertions(+), 5 deletions(-)

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
+/* Device links support */
+extern int device_links_check_suppliers(struct device *dev);
+extern void device_links_driver_bound(struct device *dev);
+extern void device_links_driver_cleanup(struct device *dev);
+extern void device_links_no_driver(struct device *dev);
+extern bool device_links_busy(struct device *dev);
+extern void device_links_unbind_consumers(struct device *dev);
Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -44,6 +44,493 @@ static int __init sysfs_deprecated_setup
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
+ * Check if @target depends on @dev or any device dependent on it (its child or
+ * its consumer etc).  Return 1 if that is the case or 0 otherwise.
+ */
+static int device_is_dependent(struct device *dev, void *target)
+{
+	struct device_link *link;
+	int ret;
+
+	if (WARN_ON(dev == target))
+		return 1;
+
+	ret = device_for_each_child(dev, target, device_is_dependent);
+	if (ret)
+		return ret;
+
+	list_for_each_entry(link, &dev->links_to_consumers, s_node) {
+		if (WARN_ON(link->consumer == target))
+			return 1;
+
+		ret = device_is_dependent(link->consumer, target);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+static int device_reorder_to_tail(struct device *dev, void *not_used)
+{
+	struct device_link *link;
+
+	/*
+	 * Devices that have not been registered yet will be put to the ends
+	 * of the lists during the registratio, so skip them here.
+	 */
+	if (device_is_registered(dev))
+		devices_kset_move_last(dev);
+
+	if (device_pm_initialized(dev))
+		device_pm_move_last(dev);
+
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
+ * @status: The initial status of the link.
+ * @flags: Link flags.
+ *
+ * If the DEVICE_LINK_STATELESS flag is set, @status is ignored.  Otherwise,
+ * the caller is responsible for ensuring that @status reflects the current
+ * status of both @consumer and @supplier.
+ *
+ * If the DEVICE_LINK_AUTOREMOVE is set, the link will be removed automatically
+ * when the consumer device driver unbinds from it.  The combination of both
+ * DEVICE_LINK_AUTOREMOVE and DEVICE_LINK_STATELESS set is invalid and will
+ * cause NULL to be returned.
+ *
+ * A side effect of the link creation is re-ordering of dpm_list and the
+ * devices_kset list by moving the consumer device and all devices depending
+ * on it to the ends of these lists (that does not happen to devices that have
+ * not been registered when this function is called).
+ *
+ * The supplier device is required to be registered when this function is called
+ * and NULL will be returned if that is not the case.  The consumer device need
+ * not be registerd, however.
+ */
+struct device_link *device_link_add(struct device *consumer,
+				    struct device *supplier,
+				    enum device_link_status status, u32 flags)
+{
+	struct device_link *link;
+
+	if (!consumer || !supplier ||
+	    ((flags & DEVICE_LINK_STATELESS) && (flags & DEVICE_LINK_AUTOREMOVE)))
+		return NULL;
+
+	mutex_lock(&device_links_lock);
+	device_pm_lock();
+
+	/*
+	 * If the supplier has not been fully registered yet or there is a
+	 * reverse dependency between the consumer and the supplier already in
+	 * the graph, return NULL.
+	 */
+	if (!device_pm_initialized(supplier)
+	    || device_is_dependent(consumer, supplier)) {
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
+	link->status = (flags & DEVICE_LINK_STATELESS) ?
+					DEVICE_LINK_NO_STATE : status;
+
+	/*
+	 * Move the consumer and all of the devices depending on it to the end
+	 * of dpm_list and the devices_kset list.
+	 *
+	 * It is necessary to hold dpm_list locked throughout all that or else
+	 * we may end up suspending with a wrong ordering of it.
+	 */
+	device_reorder_to_tail(consumer, NULL);
+
+	list_add_tail_rcu(&link->s_node, &supplier->links_to_consumers);
+	list_add_tail_rcu(&link->c_node, &consumer->links_to_suppliers);
+
+	dev_info(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
+
+ out:
+	device_pm_unlock();
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
+ * device_links_check_suppliers - Check presence of supplier drivers.
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
+ *
+ * Links with the DEVICE_LINK_STATELESS flag set are ignored.
+ */
+int device_links_check_suppliers(struct device *dev)
+{
+	struct device_link *link;
+	int idx, ret = 0;
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links_to_suppliers, c_node) {
+		if (link->flags & DEVICE_LINK_STATELESS)
+			continue;
+
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
+ *
+ * Links with the DEVICE_LINK_STATELESS flag set are ignored.
+ */
+void device_links_driver_bound(struct device *dev)
+{
+	struct device_link *link;
+	int idx;
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links_to_consumers, s_node) {
+		if (link->flags & DEVICE_LINK_STATELESS)
+			continue;
+
+		spin_lock(&link->lock);
+		WARN_ON(link->status != DEVICE_LINK_DORMANT);
+		link->status = DEVICE_LINK_AVAILABLE;
+		spin_unlock(&link->lock);
+	}
+
+	list_for_each_entry_rcu(link, &dev->links_to_suppliers, c_node) {
+		if (link->flags & DEVICE_LINK_STATELESS)
+			continue;
+
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
+ * device_links_driver_cleanup - Update links after driver removal.
+ * @dev: Device whose driver has just gone away.
+ *
+ * Update links to consumers for @dev by changing their status to "dormant".
+ *
+ * Links with the DEVICE_LINK_STATELESS flag set are ignored.
+ */
+void device_links_driver_cleanup(struct device *dev)
+{
+	struct device_link *link;
+	int idx;
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links_to_consumers, s_node) {
+		if (link->flags & DEVICE_LINK_STATELESS)
+			continue;
+
+		WARN_ON(link->flags & DEVICE_LINK_AUTOREMOVE);
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
+ *
+ * Persistent links stay around, but their status is changed to "available",
+ * unless they already are in the "supplier unbind in progress" state in which
+ * case they need not be updated.
+ *
+ * Links with the DEVICE_LINK_STATELESS flag set are ignored.
+ */
+void device_links_no_driver(struct device *dev)
+{
+	struct device_link *link, *ln;
+
+	mutex_lock(&device_links_lock);
+
+	list_for_each_entry_safe_reverse(link, ln, &dev->links_to_suppliers, c_node) {
+		if (link->flags & DEVICE_LINK_STATELESS)
+			continue;
+
+		if (link->flags & DEVICE_LINK_AUTOREMOVE) {
+			__device_link_del(link);
+		} else {
+			spin_lock(&link->lock);
+
+			if (link->status != DEVICE_LINK_SUPPLIER_UNBIND)
+				link->status = DEVICE_LINK_AVAILABLE;
+
+			spin_unlock(&link->lock);
+		}
+	}
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
+ *
+ * Links with the DEVICE_LINK_STATELESS flag set are ignored.
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
+		if (link->flags & DEVICE_LINK_STATELESS)
+			continue;
+
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
+ *
+ * Links with the DEVICE_LINK_STATELESS flag set are ignored.
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
+		if (link->flags & DEVICE_LINK_STATELESS)
+			continue;
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
+		spin_unlock(&link->lock);
+		if (status == DEVICE_LINK_ACTIVE) {
+			struct device *consumer = link->consumer;
+
+			get_device(consumer);
+
+			device_links_read_unlock(idx);
+
+			device_release_driver_internal(consumer, NULL,
+						       consumer->parent);
+			put_device(consumer);
+			goto start;
+		}
+	}
+
+	device_links_read_unlock(idx);
+}
+
+/**
+ * device_links_purge - Delete existing links to other devices.
+ * @dev: Target device.
+ */
+static void device_links_purge(struct device *dev)
+{
+	struct device_link *link, *ln;
+
+	/*
+	 * Delete all of the remaining links from this device to any other
+	 * devices (either consumers or suppliers).
+	 */
+	mutex_lock(&device_links_lock);
+
+	list_for_each_entry_safe_reverse(link, ln, &dev->links_to_suppliers, c_node) {
+		WARN_ON(link->status == DEVICE_LINK_ACTIVE);
+		__device_link_del(link);
+	}
+
+	list_for_each_entry_safe_reverse(link, ln, &dev->links_to_consumers, s_node) {
+		WARN_ON(link->status != DEVICE_LINK_DORMANT &&
+			link->status != DEVICE_LINK_NO_STATE);
+		__device_link_del(link);
+	}
+
+	mutex_unlock(&device_links_lock);
+}
+
+/* Device links support end. */
+
 int (*platform_notify)(struct device *dev) = NULL;
 int (*platform_notify_remove)(struct device *dev) = NULL;
 static struct kobject *dev_kobj;
@@ -711,6 +1198,8 @@ void device_initialize(struct device *de
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	INIT_LIST_HEAD(&dev->msi_list);
 #endif
+	INIT_LIST_HEAD(&dev->links_to_consumers);
+	INIT_LIST_HEAD(&dev->links_to_suppliers);
 }
 EXPORT_SYMBOL_GPL(device_initialize);
 
@@ -1240,6 +1729,8 @@ void device_del(struct device *dev)
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DEL_DEVICE, dev);
+
+	device_links_purge(dev);
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
 
@@ -341,6 +342,10 @@ static int really_probe(struct device *d
 		return ret;
 	}
 
+	ret = device_links_check_suppliers(dev);
+	if (ret)
+		return ret;
+
 	atomic_inc(&probe_count);
 	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
 		 drv->bus->name, __func__, drv->name, dev_name(dev));
@@ -399,6 +404,7 @@ probe_failed:
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
 pinctrl_bind_failed:
+	device_links_no_driver(dev);
 	devres_release_all(dev);
 	driver_sysfs_remove(dev);
 	dev->driver = NULL;
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
+		device_links_driver_cleanup(dev);
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
@@ -706,6 +706,35 @@ struct device_dma_parameters {
 	unsigned long segment_boundary_mask;
 };
 
+enum device_link_status {
+	DEVICE_LINK_NO_STATE = -1,
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
+ * STATELESS: The core won't track the presence of supplier/consumer drivers.
+ * AUTOREMOVE: Remove this link automatically on cunsumer driver unbind.
+ */
+#define DEVICE_LINK_STATELESS	(1 << 0)
+#define DEVICE_LINK_AUTOREMOVE	(1 << 1)
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
@@ -731,6 +760,8 @@ struct device_dma_parameters {
  * 		on.  This shrinks the "Board Support Packages" (BSPs) and
  * 		minimizes board-specific #ifdefs in drivers.
  * @driver_data: Private pointer for driver specific info.
+ * @links_to_consumers: Links to consumer devices.
+ * @links_to_suppliers: Links to supplier devices.
  * @power:	For device power management.
  * 		See Documentation/power/devices.txt for details.
  * @pm_domain:	Provide callbacks that are executed during system suspend,
@@ -797,6 +828,8 @@ struct device {
 					   core doesn't touch it */
 	void		*driver_data;	/* Driver data, set and get with
 					   dev_set/get_drvdata */
+	struct list_head	links_to_consumers;
+	struct list_head	links_to_suppliers;
 	struct dev_pm_info	power;
 	struct dev_pm_domain	*pm_domain;
 
@@ -1113,6 +1146,11 @@ extern void device_shutdown(void);
 /* debugging and troubleshooting/diagnostic helpers. */
 extern const char *dev_driver_string(const struct device *dev);
 
+/* Device links interface. */
+struct device_link *device_link_add(struct device *consumer,
+				    struct device *supplier,
+				    enum device_link_status status, u32 flags);
+void device_link_del(struct device_link *link);
 
 #ifdef CONFIG_PRINTK
 
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -131,6 +131,7 @@ void device_pm_add(struct device *dev)
 		dev_warn(dev, "parent %s should not be sleeping\n",
 			dev_name(dev->parent));
 	list_add_tail(&dev->power.entry, &dpm_list);
+	dev->power.in_dpm_list = true;
 	mutex_unlock(&dpm_list_mtx);
 }
 
@@ -145,6 +146,7 @@ void device_pm_remove(struct device *dev
 	complete_all(&dev->power.completion);
 	mutex_lock(&dpm_list_mtx);
 	list_del_init(&dev->power.entry);
+	dev->power.in_dpm_list = false;
 	mutex_unlock(&dpm_list_mtx);
 	device_wakeup_disable(dev);
 	pm_runtime_remove(dev);
Index: linux-pm/drivers/base/power/power.h
===================================================================
--- linux-pm.orig/drivers/base/power/power.h
+++ linux-pm/drivers/base/power/power.h
@@ -127,6 +127,11 @@ extern void device_pm_move_after(struct
 extern void device_pm_move_last(struct device *);
 extern void device_pm_check_callbacks(struct device *dev);
 
+static inline bool device_pm_initialized(struct device *dev)
+{
+	return dev->power.in_dpm_list;
+}
+
 #else /* !CONFIG_PM_SLEEP */
 
 static inline void device_pm_sleep_init(struct device *dev) {}
@@ -146,6 +151,11 @@ static inline void device_pm_move_last(s
 
 static inline void device_pm_check_callbacks(struct device *dev) {}
 
+static inline bool device_pm_initialized(struct device *dev)
+{
+	return device_is_registered(dev);
+}
+
 #endif /* !CONFIG_PM_SLEEP */
 
 static inline void device_pm_init(struct device *dev)
Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -559,6 +559,7 @@ struct dev_pm_info {
 	pm_message_t		power_state;
 	unsigned int		can_wakeup:1;
 	unsigned int		async_suspend:1;
+	bool			in_dpm_list:1;	/* Owned by the PM core */
 	bool			is_prepared:1;	/* Owned by the PM core */
 	bool			is_suspended:1;	/* Ditto */
 	bool			is_noirq_suspended:1;
