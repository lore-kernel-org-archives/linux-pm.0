From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v6 2/5] driver core: Functional dependencies tracking support
Date: Sun, 30 Oct 2016 17:32:16 +0100
Message-ID: <25061053.41PWyJJkdO@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <11468990.WB1J8sxXpS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11468990.WB1J8sxXpS@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
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
information, flags, and an RCU head for synchronization.

Also add two new list heads, representing the lists of links to the
devices that depend on the given one (consumers) and to the devices
depended on by it (suppliers), and a "driver presence status" field
(needed for figuring out initial states of device links) to struct
device.

The entire data structure consisting of all of the lists of link
objects for all devices is protected by a mutex (for link object
addition/removal and for list walks during device driver probing
and removal) and by SRCU (for list walking in other case that will
be introduced by subsequent change sets).  If CONFIG_SRCU is not
selected, however, an rwsem is used for protecting the entire data
structure.

In addition, each link object has an internal status field whose
value reflects whether or not drivers are bound to the devices
pointed to by the link or probing/removal of their drivers is in
progress etc.  That field is only modified under the device links
mutex, but it may be read outside of it in some cases (introduced by
subsequent change sets), so modifications of it are annotated with
WRITE_ONCE().

New links are added by calling device_link_add() which takes three
arguments: pointers to the devices in question and flags.  In
particular, if DL_FLAG_STATELESS is set in the flags, the link status
is not to be taken into account for this link and the driver core
will not manage it.  In turn, if DL_FLAG_AUTOREMOVE is set in the
flags, the driver core will remove the link automatically when the
consumer device driver unbinds from it.

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

There are two types of link objects, persistent and non-persistent.
The persistent ones stay around until one of the target devices is
deleted, while the non-persistent ones are removed automatically when
the consumer driver unbinds from its device (ie. they are assumed to
be valid only as long as the consumer device has a driver bound to
it).  Persistent links are created by default and non-persistent
links are created when the DL_FLAG_AUTOREMOVE flag is passed
to device_link_add().

Both persistent and non-persistent device links can be deleted
with an explicit call to device_link_del().

Links created without the DL_FLAG_STATELESS flag set are managed
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

v5 -> v6:

- Fall back to using an rwsem for protecting the device links data structure
  if SRCU is not available (mutex+SRCU is used as before if CONFIG_SRCU is set,
  so the code should have not changed on systems with SRCU selected).

- Use BIT(x) in flag definitions.

v4 -> v5:

- Redefine device_link_add() to take three arguments, the supplier and consumer
  pointers and flags, and to figure out the initial link state automatically.

- Move the links-related fields in struct device to a separate sub-structure
  and add a "driver presence tracking" field to it (to help device_link_add()
  to do its job).

- Modify device_links_check_suppliers(), device_links_driver_bound(),
  device_links_no_driver(), device_links_driver_cleanup(), device_links_busy(),
  and device_links_unbind_consumers() to walk link lists under device_links_lock
  (to make the new "driver presence tracking" mechanism work reliably).

- Drop the (not necessary any more) spinlock from struct device_link.

- Rename symbols to better reflect their purpose (flags vs link states etc).

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
 drivers/base/base.h        |   13 +
 drivers/base/core.c        |  540 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/dd.c          |   41 +++
 drivers/base/power/main.c  |    2 
 drivers/base/power/power.h |   10 
 include/linux/device.h     |   80 ++++++
 include/linux/pm.h         |    1 
 7 files changed, 682 insertions(+), 5 deletions(-)

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
Index: linux-pm/include/linux/device.h
===================================================================
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -708,6 +708,81 @@ struct device_dma_parameters {
 };
 
 /**
+ * enum device_link_state - Device link states.
+ * @DL_STATE_NONE: The presence of the drivers is not being tracked.
+ * @DL_STATE_DORMANT: None of the supplier/consumer drivers is present.
+ * @DL_STATE_AVAILABLE: The supplier driver is present, but the consumer is not.
+ * @DL_STATE_CONSUMER_PROBE: The consumer is probing (supplier driver present).
+ * @DL_STATE_ACTIVE: Both the supplier and consumer drivers are present.
+ * @DL_STATE_SUPPLIER_UNBIND: The supplier driver is unbinding.
+ */
+enum device_link_state {
+	DL_STATE_NONE = -1,
+	DL_STATE_DORMANT = 0,
+	DL_STATE_AVAILABLE,
+	DL_STATE_CONSUMER_PROBE,
+	DL_STATE_ACTIVE,
+	DL_STATE_SUPPLIER_UNBIND,
+};
+
+/*
+ * Device link flags.
+ *
+ * STATELESS: The core won't track the presence of supplier/consumer drivers.
+ * AUTOREMOVE: Remove this link automatically on consumer driver unbind.
+ */
+#define DL_FLAG_STATELESS	BIT(0)
+#define DL_FLAG_AUTOREMOVE	BIT(1)
+
+/**
+ * struct device_link - Device link representation.
+ * @supplier: The device on the supplier end of the link.
+ * @s_node: Hook to the supplier device's list of links to consumers.
+ * @consumer: The device on the consumer end of the link.
+ * @c_node: Hook to the consumer device's list of links to suppliers.
+ * @status: The state of the link (with respect to the presence of drivers).
+ * @flags: Link flags.
+ * @rcu_head: An RCU head to use for deferred execution of SRCU callbacks.
+ */
+struct device_link {
+	struct device *supplier;
+	struct list_head s_node;
+	struct device *consumer;
+	struct list_head c_node;
+	enum device_link_state status;
+	u32 flags;
+#ifdef CONFIG_SRCU
+	struct rcu_head rcu_head;
+#endif
+};
+
+/**
+ * enum dl_dev_state - Device driver presence tracking information.
+ * @DL_DEV_NO_DRIVER: There is no driver attached to the device.
+ * @DL_DEV_PROBING: A driver is probing.
+ * @DL_DEV_DRIVER_BOUND: The driver has been bound to the device.
+ * @DL_DEV_UNBINDING: The driver is unbinding from the device.
+ */
+enum dl_dev_state {
+	DL_DEV_NO_DRIVER = 0,
+	DL_DEV_PROBING,
+	DL_DEV_DRIVER_BOUND,
+	DL_DEV_UNBINDING,
+};
+
+/**
+ * struct dev_links_info - Device data related to device links.
+ * @suppliers: List of links to supplier devices.
+ * @consumers: List of links to consumer devices.
+ * @status: Driver status information.
+ */
+struct dev_links_info {
+	struct list_head suppliers;
+	struct list_head consumers;
+	enum dl_dev_state status;
+};
+
+/**
  * struct device - The basic device structure
  * @parent:	The device's "parent" device, the device to which it is attached.
  * 		In most cases, a parent device is some sort of bus or host
@@ -799,6 +874,7 @@ struct device {
 					   core doesn't touch it */
 	void		*driver_data;	/* Driver data, set and get with
 					   dev_set/get_drvdata */
+	struct dev_links_info	links;
 	struct dev_pm_info	power;
 	struct dev_pm_domain	*pm_domain;
 
@@ -1116,6 +1192,10 @@ extern void device_shutdown(void);
 /* debugging and troubleshooting/diagnostic helpers. */
 extern const char *dev_driver_string(const struct device *dev);
 
+/* Device links interface. */
+struct device_link *device_link_add(struct device *consumer,
+				    struct device *supplier, u32 flags);
+void device_link_del(struct device_link *link);
 
 #ifdef CONFIG_PRINTK
 
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
@@ -152,3 +155,13 @@ extern int devtmpfs_init(void);
 #else
 static inline int devtmpfs_init(void) { return 0; }
 #endif
+
+/* Device links support */
+extern int device_links_read_lock(void);
+extern void device_links_read_unlock(int idx);
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
@@ -44,6 +44,541 @@ static int __init sysfs_deprecated_setup
 early_param("sysfs.deprecated", sysfs_deprecated_setup);
 #endif
 
+/* Device links support. */
+
+#ifdef CONFIG_SRCU
+static DEFINE_MUTEX(device_links_lock);
+DEFINE_STATIC_SRCU(device_links_srcu);
+
+static inline void device_links_write_lock(void)
+{
+	mutex_lock(&device_links_lock);
+}
+
+static inline void device_links_write_unlock(void)
+{
+	mutex_unlock(&device_links_lock);
+}
+
+int device_links_read_lock(void)
+{
+	return srcu_read_lock(&device_links_srcu);
+}
+
+void device_links_read_unlock(int idx)
+{
+	srcu_read_unlock(&device_links_srcu, idx);
+}
+#else /* !CONFIG_SRCU */
+static DECLARE_RWSEM(device_links_lock);
+
+static inline void device_links_write_lock(void)
+{
+	down_write(&device_links_lock);
+}
+
+static inline void device_links_write_unlock(void)
+{
+	up_write(&device_links_lock);
+}
+
+int device_links_read_lock(void)
+{
+	down_read(&device_links_lock);
+	return 0;
+}
+
+void device_links_read_unlock(int not_used)
+{
+	up_read(&device_links_lock);
+}
+#endif /* !CONFIG_SRCU */
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
+	list_for_each_entry(link, &dev->links.consumers, s_node) {
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
+	 * of the lists during the registration, so skip them here.
+	 */
+	if (device_is_registered(dev))
+		devices_kset_move_last(dev);
+
+	if (device_pm_initialized(dev))
+		device_pm_move_last(dev);
+
+	device_for_each_child(dev, NULL, device_reorder_to_tail);
+	list_for_each_entry(link, &dev->links.consumers, s_node)
+		device_reorder_to_tail(link->consumer, NULL);
+
+	return 0;
+}
+
+/**
+ * device_link_add - Create a link between two devices.
+ * @consumer: Consumer end of the link.
+ * @supplier: Supplier end of the link.
+ * @flags: Link flags.
+ *
+ * If the DL_FLAG_AUTOREMOVE is set, the link will be removed automatically
+ * when the consumer device driver unbinds from it.  The combination of both
+ * DL_FLAG_AUTOREMOVE and DL_FLAG_STATELESS set is invalid and will cause NULL
+ * to be returned.
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
+				    struct device *supplier, u32 flags)
+{
+	struct device_link *link;
+
+	if (!consumer || !supplier ||
+	    ((flags & DL_FLAG_STATELESS) && (flags & DL_FLAG_AUTOREMOVE)))
+		return NULL;
+
+	device_links_write_lock();
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
+	list_for_each_entry(link, &supplier->links.consumers, s_node)
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
+	link->flags = flags;
+
+	/* Deterine the initial link state. */
+	if (flags & DL_FLAG_STATELESS) {
+		link->status = DL_STATE_NONE;
+	} else {
+		switch (supplier->links.status) {
+		case DL_DEV_DRIVER_BOUND:
+			switch (consumer->links.status) {
+			case DL_DEV_PROBING:
+				link->status = DL_STATE_CONSUMER_PROBE;
+				break;
+			case DL_DEV_DRIVER_BOUND:
+				link->status = DL_STATE_ACTIVE;
+				break;
+			default:
+				link->status = DL_STATE_AVAILABLE;
+				break;
+			}
+			break;
+		case DL_DEV_UNBINDING:
+			link->status = DL_STATE_SUPPLIER_UNBIND;
+			break;
+		default:
+			link->status = DL_STATE_DORMANT;
+			break;
+		}
+	}
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
+	list_add_tail_rcu(&link->s_node, &supplier->links.consumers);
+	list_add_tail_rcu(&link->c_node, &consumer->links.suppliers);
+
+	dev_info(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
+
+ out:
+	device_pm_unlock();
+	device_links_write_unlock();
+	return link;
+}
+EXPORT_SYMBOL_GPL(device_link_add);
+
+static void device_link_free(struct device_link *link)
+{
+	put_device(link->consumer);
+	put_device(link->supplier);
+	kfree(link);
+}
+
+#ifdef CONFIG_SRCU
+static void __device_link_free_srcu(struct rcu_head *rhead)
+{
+	device_link_free(container_of(rhead, struct device_link, rcu_head));
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
+#else /* !CONFIG_SRCU */
+static void __device_link_del(struct device_link *link)
+{
+	dev_info(link->consumer, "Dropping the link to %s\n",
+		 dev_name(link->supplier));
+
+	list_del(&link->s_node);
+	list_del(&link->c_node);
+	device_link_free(link);
+}
+#endif /* !CONFIG_SRCU */
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
+	device_links_write_lock();
+	device_pm_lock();
+	__device_link_del(link);
+	device_pm_unlock();
+	device_links_write_unlock();
+}
+EXPORT_SYMBOL_GPL(device_link_del);
+
+static void device_links_missing_supplier(struct device *dev)
+{
+	struct device_link *link;
+
+	list_for_each_entry(link, &dev->links.suppliers, c_node)
+		if (link->status == DL_STATE_CONSUMER_PROBE)
+			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
+}
+
+/**
+ * device_links_check_suppliers - Check presence of supplier drivers.
+ * @dev: Consumer device.
+ *
+ * Check links from this device to any suppliers.  Walk the list of the device's
+ * links to suppliers and see if all of them are available.  If not, simply
+ * return -EPROBE_DEFER.
+ *
+ * We need to guarantee that the supplier will not go away after the check has
+ * been positive here.  It only can go away in __device_release_driver() and
+ * that function  checks the device's links to consumers.  This means we need to
+ * mark the link as "consumer probe in progress" to make the supplier removal
+ * wait for us to complete (or bad things may happen).
+ *
+ * Links with the DL_FLAG_STATELESS flag set are ignored.
+ */
+int device_links_check_suppliers(struct device *dev)
+{
+	struct device_link *link;
+	int ret = 0;
+
+	device_links_write_lock();
+
+	list_for_each_entry(link, &dev->links.suppliers, c_node) {
+		if (link->flags & DL_FLAG_STATELESS)
+			continue;
+
+		if (link->status != DL_STATE_AVAILABLE) {
+			device_links_missing_supplier(dev);
+			ret = -EPROBE_DEFER;
+			break;
+		}
+		WRITE_ONCE(link->status, DL_STATE_CONSUMER_PROBE);
+	}
+	dev->links.status = DL_DEV_PROBING;
+
+	device_links_write_unlock();
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
+ * Links with the DL_FLAG_STATELESS flag set are ignored.
+ */
+void device_links_driver_bound(struct device *dev)
+{
+	struct device_link *link;
+
+	device_links_write_lock();
+
+	list_for_each_entry(link, &dev->links.consumers, s_node) {
+		if (link->flags & DL_FLAG_STATELESS)
+			continue;
+
+		WARN_ON(link->status != DL_STATE_DORMANT);
+		WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
+	}
+
+	list_for_each_entry(link, &dev->links.suppliers, c_node) {
+		if (link->flags & DL_FLAG_STATELESS)
+			continue;
+
+		WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
+		WRITE_ONCE(link->status, DL_STATE_ACTIVE);
+	}
+
+	dev->links.status = DL_DEV_DRIVER_BOUND;
+
+	device_links_write_unlock();
+}
+
+/**
+ * __device_links_no_driver - Update links of a device without a driver.
+ * @dev: Device without a drvier.
+ *
+ * Delete all non-persistent links from this device to any suppliers.
+ *
+ * Persistent links stay around, but their status is changed to "available",
+ * unless they already are in the "supplier unbind in progress" state in which
+ * case they need not be updated.
+ *
+ * Links with the DL_FLAG_STATELESS flag set are ignored.
+ */
+static void __device_links_no_driver(struct device *dev)
+{
+	struct device_link *link, *ln;
+
+	list_for_each_entry_safe_reverse(link, ln, &dev->links.suppliers, c_node) {
+		if (link->flags & DL_FLAG_STATELESS)
+			continue;
+
+		if (link->flags & DL_FLAG_AUTOREMOVE)
+			__device_link_del(link);
+		else if (link->status != DL_STATE_SUPPLIER_UNBIND)
+			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
+	}
+
+	dev->links.status = DL_DEV_NO_DRIVER;
+}
+
+void device_links_no_driver(struct device *dev)
+{
+	device_links_write_lock();
+	__device_links_no_driver(dev);
+	device_links_write_unlock();
+}
+
+/**
+ * device_links_driver_cleanup - Update links after driver removal.
+ * @dev: Device whose driver has just gone away.
+ *
+ * Update links to consumers for @dev by changing their status to "dormant" and
+ * invoke %__device_links_no_driver() to update links to suppliers for it as
+ * appropriate.
+ *
+ * Links with the DL_FLAG_STATELESS flag set are ignored.
+ */
+void device_links_driver_cleanup(struct device *dev)
+{
+	struct device_link *link;
+
+	device_links_write_lock();
+
+	list_for_each_entry(link, &dev->links.consumers, s_node) {
+		if (link->flags & DL_FLAG_STATELESS)
+			continue;
+
+		WARN_ON(link->flags & DL_FLAG_AUTOREMOVE);
+		WARN_ON(link->status != DL_STATE_SUPPLIER_UNBIND);
+		WRITE_ONCE(link->status, DL_STATE_DORMANT);
+	}
+
+	__device_links_no_driver(dev);
+
+	device_links_write_unlock();
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
+ * Links with the DL_FLAG_STATELESS flag set are ignored.
+ */
+bool device_links_busy(struct device *dev)
+{
+	struct device_link *link;
+	bool ret = false;
+
+	device_links_write_lock();
+
+	list_for_each_entry(link, &dev->links.consumers, s_node) {
+		if (link->flags & DL_FLAG_STATELESS)
+			continue;
+
+		if (link->status == DL_STATE_CONSUMER_PROBE
+		    || link->status == DL_STATE_ACTIVE) {
+			ret = true;
+			break;
+		}
+		WRITE_ONCE(link->status, DL_STATE_SUPPLIER_UNBIND);
+	}
+
+	dev->links.status = DL_DEV_UNBINDING;
+
+	device_links_write_unlock();
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
+ * Links with the DL_FLAG_STATELESS flag set are ignored.
+ */
+void device_links_unbind_consumers(struct device *dev)
+{
+	struct device_link *link;
+
+ start:
+	device_links_write_lock();
+
+	list_for_each_entry(link, &dev->links.consumers, s_node) {
+		enum device_link_state status;
+
+		if (link->flags & DL_FLAG_STATELESS)
+			continue;
+
+		status = link->status;
+		if (status == DL_STATE_CONSUMER_PROBE) {
+			device_links_write_unlock();
+
+			wait_for_device_probe();
+			goto start;
+		}
+		WRITE_ONCE(link->status, DL_STATE_SUPPLIER_UNBIND);
+		if (status == DL_STATE_ACTIVE) {
+			struct device *consumer = link->consumer;
+
+			get_device(consumer);
+
+			device_links_write_unlock();
+
+			device_release_driver_internal(consumer, NULL,
+						       consumer->parent);
+			put_device(consumer);
+			goto start;
+		}
+	}
+
+	device_links_write_unlock();
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
+	device_links_write_lock();
+
+	list_for_each_entry_safe_reverse(link, ln, &dev->links.suppliers, c_node) {
+		WARN_ON(link->status == DL_STATE_ACTIVE);
+		__device_link_del(link);
+	}
+
+	list_for_each_entry_safe_reverse(link, ln, &dev->links.consumers, s_node) {
+		WARN_ON(link->status != DL_STATE_DORMANT &&
+			link->status != DL_STATE_NONE);
+		__device_link_del(link);
+	}
+
+	device_links_write_unlock();
+}
+
+/* Device links support end. */
+
 int (*platform_notify)(struct device *dev) = NULL;
 int (*platform_notify_remove)(struct device *dev) = NULL;
 static struct kobject *dev_kobj;
@@ -711,6 +1246,9 @@ void device_initialize(struct device *de
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	INIT_LIST_HEAD(&dev->msi_list);
 #endif
+	INIT_LIST_HEAD(&dev->links.consumers);
+	INIT_LIST_HEAD(&dev->links.suppliers);
+	dev->links.status = DL_DEV_NO_DRIVER;
 }
 EXPORT_SYMBOL_GPL(device_initialize);
 
@@ -1258,6 +1796,8 @@ void device_del(struct device *dev)
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
@@ -244,6 +244,7 @@ static void driver_bound(struct device *
 		 __func__, dev_name(dev));
 
 	klist_add_tail(&dev->p->knode_driver, &dev->driver->p->klist_devices);
+	device_links_driver_bound(dev);
 
 	device_pm_check_callbacks(dev);
 
@@ -337,6 +338,10 @@ static int really_probe(struct device *d
 		return ret;
 	}
 
+	ret = device_links_check_suppliers(dev);
+	if (ret)
+		return ret;
+
 	atomic_inc(&probe_count);
 	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
 		 drv->bus->name, __func__, drv->name, dev_name(dev));
@@ -415,6 +420,7 @@ probe_failed:
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
 pinctrl_bind_failed:
+	device_links_no_driver(dev);
 	devres_release_all(dev);
 	driver_sysfs_remove(dev);
 	dev->driver = NULL;
@@ -771,7 +777,7 @@ EXPORT_SYMBOL_GPL(driver_attach);
  * __device_release_driver() must be called with @dev lock held.
  * When called for a USB interface, @dev->parent lock must be held as well.
  */
-static void __device_release_driver(struct device *dev)
+static void __device_release_driver(struct device *dev, struct device *parent)
 {
 	struct device_driver *drv;
 
@@ -780,6 +786,25 @@ static void __device_release_driver(stru
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
@@ -795,6 +820,8 @@ static void __device_release_driver(stru
 			dev->bus->remove(dev);
 		else if (drv->remove)
 			drv->remove(dev);
+
+		device_links_driver_cleanup(dev);
 		devres_release_all(dev);
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
@@ -811,16 +838,16 @@ static void __device_release_driver(stru
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
@@ -833,6 +860,10 @@ static void device_release_driver_intern
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
