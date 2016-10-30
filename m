From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v6 4/5] PM / runtime: Use device links
Date: Sun, 30 Oct 2016 17:32:31 +0100
Message-ID: <5653461.FkScaTIbLn@vostro.rjw.lan>
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

Modify the runtime PM framework to use device links to ensure that
supplier devices will not be suspended if any of their consumer
devices are active.

The idea is to reference count suppliers on the consumer's resume
and drop references to them on its suspend.  The information on
whether or not the supplier has been reference counted by the
consumer's (runtime) resume is stored in a new field (rpm_active)
in the link object for each link.

It may be necessary to clean up those references when the
supplier is unbinding and that's why the links whose status is
DEVICE_LINK_SUPPLIER_UNBIND are skipped by the runtime suspend
and resume code.

The above means that if the consumer device is probed in the
runtime-active state, the supplier has to be resumed and reference
counted by device_link_add() so the code works as expected on its
(runtime) suspend.  There is a new flag, DEVICE_LINK_RPM_ACTIVE,
to tell device_link_add() about that (in which case the caller
is responsible for making sure that the consumer really will
be runtime-active when runtime PM is enabled for it).

The other new link flag, DEVICE_LINK_PM_RUNTIME, tells the core
whether or not the link should be used for runtime PM at all.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v5 -> v6:

- Rebase.

- Use BIT(x) in flag definitions.

v4 -> v5:

- Rebase, change the symbol names in accordance with patch [2/5] etc.

- Use READ_ONCE() to annotate "unprotected" accesses to link status data.

v3 -> v4:

- Add pm_runtime_get/put_suppliers() and make the core call them
  around the probing of a consumer device (in analogy with what it
  does to the device's parent).

---
 drivers/base/core.c          |   27 +++++++
 drivers/base/dd.c            |    3 
 drivers/base/power/runtime.c |  157 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/device.h       |    6 +
 include/linux/pm_runtime.h   |    6 +
 5 files changed, 193 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -152,6 +152,14 @@ static int device_reorder_to_tail(struct
  * @supplier: Supplier end of the link.
  * @flags: Link flags.
  *
+ * The caller is responsible for the proper synchronization of the link creation
+ * with runtime PM.  First, setting the DL_FLAG_PM_RUNTIME flag will cause the
+ * runtime PM framework to take the link into account.  Second, if the
+ * DL_FLAG_RPM_ACTIVE flag is set in addition to it, the supplier devices will
+ * be forced into the active metastate and reference-counted upon the creation
+ * of the link.  If DL_FLAG_PM_RUNTIME is not set, DL_FLAG_RPM_ACTIVE will be
+ * ignored.
+ *
  * If the DL_FLAG_AUTOREMOVE is set, the link will be removed automatically
  * when the consumer device driver unbinds from it.  The combination of both
  * DL_FLAG_AUTOREMOVE and DL_FLAG_STATELESS set is invalid and will cause NULL
@@ -193,10 +201,19 @@ struct device_link *device_link_add(stru
 		if (link->consumer == consumer)
 			goto out;
 
-	link = kmalloc(sizeof(*link), GFP_KERNEL);
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
 		goto out;
 
+	if ((flags & DL_FLAG_PM_RUNTIME) && (flags & DL_FLAG_RPM_ACTIVE)) {
+		if (pm_runtime_get_sync(supplier) < 0) {
+			pm_runtime_put_noidle(supplier);
+			kfree(link);
+			link = NULL;
+			goto out;
+		}
+		link->rpm_active = true;
+	}
 	get_device(supplier);
 	link->supplier = supplier;
 	INIT_LIST_HEAD(&link->s_node);
@@ -213,6 +230,14 @@ struct device_link *device_link_add(stru
 		case DL_DEV_DRIVER_BOUND:
 			switch (consumer->links.status) {
 			case DL_DEV_PROBING:
+				/*
+				 * Balance the decrementation of the supplier's
+				 * runtime PM usage counter after consumer probe
+				 * in driver_probe_device().
+				 */
+				if (flags & DL_FLAG_PM_RUNTIME)
+					pm_runtime_get_sync(supplier);
+
 				link->status = DL_STATE_CONSUMER_PROBE;
 				break;
 			case DL_DEV_DRIVER_BOUND:
Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -513,6 +513,7 @@ int driver_probe_device(struct device_dr
 	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 
+	pm_runtime_get_suppliers(dev);
 	if (dev->parent)
 		pm_runtime_get_sync(dev->parent);
 
@@ -523,6 +524,7 @@ int driver_probe_device(struct device_dr
 	if (dev->parent)
 		pm_runtime_put(dev->parent);
 
+	pm_runtime_put_suppliers(dev);
 	return ret;
 }
 
@@ -806,6 +808,7 @@ static void __device_release_driver(stru
 		}
 
 		pm_runtime_get_sync(dev);
+		pm_runtime_clean_up_links(dev);
 
 		driver_sysfs_remove(dev);
 
Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -12,6 +12,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeirq.h>
 #include <trace/events/rpm.h>
+
+#include "../base.h"
 #include "power.h"
 
 typedef int (*pm_callback_t)(struct device *);
@@ -258,6 +260,42 @@ static int rpm_check_suspend_allowed(str
 	return retval;
 }
 
+static int rpm_get_suppliers(struct device *dev)
+{
+	struct device_link *link;
+
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
+		int retval;
+
+		if (!(link->flags & DL_FLAG_PM_RUNTIME))
+			continue;
+
+		if (READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND ||
+		    link->rpm_active)
+			continue;
+
+		retval = pm_runtime_get_sync(link->supplier);
+		if (retval < 0) {
+			pm_runtime_put_noidle(link->supplier);
+			return retval;
+		}
+		link->rpm_active = true;
+	}
+	return 0;
+}
+
+static void rpm_put_suppliers(struct device *dev)
+{
+	struct device_link *link;
+
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+		if (link->rpm_active &&
+		    READ_ONCE(link->status) != DL_STATE_SUPPLIER_UNBIND) {
+			pm_runtime_put(link->supplier);
+			link->rpm_active = false;
+		}
+}
+
 /**
  * __rpm_callback - Run a given runtime PM callback for a given device.
  * @cb: Runtime PM callback to run.
@@ -266,19 +304,55 @@ static int rpm_check_suspend_allowed(str
 static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
-	int retval;
+	int retval, idx;
 
-	if (dev->power.irq_safe)
+	if (dev->power.irq_safe) {
 		spin_unlock(&dev->power.lock);
-	else
+	} else {
 		spin_unlock_irq(&dev->power.lock);
 
+		/*
+		 * Resume suppliers if necessary.
+		 *
+		 * The device's runtime PM status cannot change until this
+		 * routine returns, so it is safe to read the status outside of
+		 * the lock.
+		 */
+		if (dev->power.runtime_status == RPM_RESUMING) {
+			idx = device_links_read_lock();
+
+			retval = rpm_get_suppliers(dev);
+			if (retval)
+				goto fail;
+
+			device_links_read_unlock(idx);
+		}
+	}
+
 	retval = cb(dev);
 
-	if (dev->power.irq_safe)
+	if (dev->power.irq_safe) {
 		spin_lock(&dev->power.lock);
-	else
+	} else {
+		/*
+		 * If the device is suspending and the callback has returned
+		 * success, drop the usage counters of the suppliers that have
+		 * been reference counted on its resume.
+		 *
+		 * Do that if resume fails too.
+		 */
+		if ((dev->power.runtime_status == RPM_SUSPENDING && !retval)
+		    || (dev->power.runtime_status == RPM_RESUMING && retval)) {
+			idx = device_links_read_lock();
+
+ fail:
+			rpm_put_suppliers(dev);
+
+			device_links_read_unlock(idx);
+		}
+
 		spin_lock_irq(&dev->power.lock);
+	}
 
 	return retval;
 }
@@ -1447,6 +1521,79 @@ void pm_runtime_remove(struct device *de
 }
 
 /**
+ * pm_runtime_clean_up_links - Prepare links to consumers for driver removal.
+ * @dev: Device whose driver is going to be removed.
+ *
+ * Check links from this device to any consumers and if any of them have active
+ * runtime PM references to the device, drop the usage counter of the device
+ * (once per link).
+ *
+ * Links with the DL_FLAG_STATELESS flag set are ignored.
+ *
+ * Since the device is guaranteed to be runtime-active at the point this is
+ * called, nothing else needs to be done here.
+ *
+ * Moreover, this is called after device_links_busy() has returned 'false', so
+ * the status of each link is guaranteed to be DL_STATE_SUPPLIER_UNBIND and
+ * therefore rpm_active can't be manipulated concurrently.
+ */
+void pm_runtime_clean_up_links(struct device *dev)
+{
+	struct device_link *link;
+	int idx;
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links.consumers, s_node) {
+		if (link->flags & DL_FLAG_STATELESS)
+			continue;
+
+		if (link->rpm_active) {
+			pm_runtime_put_noidle(dev);
+			link->rpm_active = false;
+		}
+	}
+
+	device_links_read_unlock(idx);
+}
+
+/**
+ * pm_runtime_get_suppliers - Resume and reference-count supplier devices.
+ * @dev: Consumer device.
+ */
+void pm_runtime_get_suppliers(struct device *dev)
+{
+	struct device_link *link;
+	int idx;
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+		if (link->flags & DL_FLAG_PM_RUNTIME)
+			pm_runtime_get_sync(link->supplier);
+
+	device_links_read_unlock(idx);
+}
+
+/**
+ * pm_runtime_put_suppliers - Drop references to supplier devices.
+ * @dev: Consumer device.
+ */
+void pm_runtime_put_suppliers(struct device *dev)
+{
+	struct device_link *link;
+	int idx;
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+		if (link->flags & DL_FLAG_PM_RUNTIME)
+			pm_runtime_put(link->supplier);
+
+	device_links_read_unlock(idx);
+}
+
+/**
  * pm_runtime_force_suspend - Force a device into suspend state if needed.
  * @dev: Device to suspend.
  *
Index: linux-pm/include/linux/device.h
===================================================================
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -730,9 +730,13 @@ enum device_link_state {
  *
  * STATELESS: The core won't track the presence of supplier/consumer drivers.
  * AUTOREMOVE: Remove this link automatically on consumer driver unbind.
+ * PM_RUNTIME: If set, the runtime PM framework will use this link.
+ * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
  */
 #define DL_FLAG_STATELESS	BIT(0)
 #define DL_FLAG_AUTOREMOVE	BIT(1)
+#define DL_FLAG_PM_RUNTIME	BIT(2)
+#define DL_FLAG_RPM_ACTIVE	BIT(3)
 
 /**
  * struct device_link - Device link representation.
@@ -742,6 +746,7 @@ enum device_link_state {
  * @c_node: Hook to the consumer device's list of links to suppliers.
  * @status: The state of the link (with respect to the presence of drivers).
  * @flags: Link flags.
+ * @rpm_active: Whether or not the consumer device is runtime-PM-active.
  * @rcu_head: An RCU head to use for deferred execution of SRCU callbacks.
  */
 struct device_link {
@@ -751,6 +756,7 @@ struct device_link {
 	struct list_head c_node;
 	enum device_link_state status;
 	u32 flags;
+	bool rpm_active;
 #ifdef CONFIG_SRCU
 	struct rcu_head rcu_head;
 #endif
Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -55,6 +55,9 @@ extern unsigned long pm_runtime_autosusp
 extern void pm_runtime_update_max_time_suspended(struct device *dev,
 						 s64 delta_ns);
 extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
+extern void pm_runtime_clean_up_links(struct device *dev);
+extern void pm_runtime_get_suppliers(struct device *dev);
+extern void pm_runtime_put_suppliers(struct device *dev);
 
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
 {
@@ -186,6 +189,9 @@ static inline unsigned long pm_runtime_a
 				struct device *dev) { return 0; }
 static inline void pm_runtime_set_memalloc_noio(struct device *dev,
 						bool enable){}
+static inline void pm_runtime_clean_up_links(struct device *dev) {}
+static inline void pm_runtime_get_suppliers(struct device *dev) {}
+static inline void pm_runtime_put_suppliers(struct device *dev) {}
 
 #endif /* !CONFIG_PM */
 
