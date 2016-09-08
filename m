From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH v2 6/7] PM / runtime: Use device links
Date: Thu, 08 Sep 2016 23:30:26 +0200
Message-ID: <5200011.6uCldMmN4m@vostro.rjw.lan>
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
 drivers/base/core.c          |   15 ++++++
 drivers/base/dd.c            |    1 
 drivers/base/power/runtime.c |   93 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/device.h       |    5 ++
 include/linux/pm_runtime.h   |    2 
 5 files changed, 111 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -110,6 +110,11 @@ struct device_link *device_link_add(stru
 	if (!consumer || !supplier || status == DEVICE_LINK_SUPPLIER_UNBIND)
 		return NULL;
 
+	if ((flags & DEVICE_LINK_RPM_ACTIVE) &&
+	    (!(flags & DEVICE_LINK_PM_RUNTIME) ||
+	     status != DEVICE_LINK_CONSUMER_PROBE))
+		return NULL;
+
 	mutex_lock(&device_links_lock);
 
 	/*
@@ -129,6 +134,16 @@ struct device_link *device_link_add(stru
 	if (!link)
 		goto out;
 
+	if (flags & DEVICE_LINK_RPM_ACTIVE) {
+		if (pm_runtime_get_sync(supplier) < 0) {
+			pm_runtime_put_noidle(supplier);
+			kfree(link);
+			goto out;
+		}
+		link->rpm_active = true;
+	} else {
+		link->rpm_active = false;
+	}
 	get_device(supplier);
 	link->supplier = supplier;
 	INIT_LIST_HEAD(&link->s_node);
Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -791,6 +791,7 @@ static void __device_release_driver(stru
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
@@ -266,19 +268,69 @@ static int rpm_check_suspend_allowed(str
 static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
-	int retval;
+	struct device_link *link;
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
+			list_for_each_entry_rcu(link, &dev->links_to_suppliers, c_node)
+				if ((link->flags & DEVICE_LINK_PM_RUNTIME)
+				    && link->status != DEVICE_LINK_SUPPLIER_UNBIND
+				    && !link->rpm_active) {
+					retval = pm_runtime_get_sync(link->supplier);
+					if (retval < 0) {
+						pm_runtime_put_noidle(link->supplier);
+						goto fail;
+					}
+					link->rpm_active = true;
+				}
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
+			list_for_each_entry_rcu(link, &dev->links_to_suppliers, c_node)
+				if (link->status != DEVICE_LINK_SUPPLIER_UNBIND
+				    && link->rpm_active) {
+					pm_runtime_put(link->supplier);
+					link->rpm_active = false;
+				}
+
+			device_links_read_unlock(idx);
+		}
+
 		spin_lock_irq(&dev->power.lock);
+	}
 
 	return retval;
 }
@@ -1464,6 +1516,37 @@ void pm_runtime_remove(struct device *de
 }
 
 /**
+ * pm_runtime_clean_up_links - Prepare links to consumers for driver removal.
+ * @dev: Device whose driver is going to be removed.
+ *
+ * Check links from this device to any consumers and if any of them have active
+ * runtime PM references to the device, drop the usage counter of the device
+ * (once per link).
+ *
+ * Since the device is guaranteed to be runtime-active at the point this is
+ * called, nothing else needs to be done here.
+ *
+ * Moreover, this is called after device_links_busy() has returned 'false', so
+ * the status of each link is guaranteed to be DEVICE_LINK_SUPPLIER_UNBIND and
+ * therefore rpm_active can't be manipulated concurrently.
+ */
+void pm_runtime_clean_up_links(struct device *dev)
+{
+	struct device_link *link;
+	int idx;
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links_to_consumers, s_node)
+		if (link->rpm_active) {
+			pm_runtime_put_noidle(dev);
+			link->rpm_active = false;
+		}
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
@@ -718,8 +718,12 @@ enum device_link_status {
  * Device link flags.
  *
  * PERSISTENT: Do not delete the link on consumer device driver unbind.
+ * PM_RUNTIME: If set, the runtime PM framework will use this link.
+ * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
  */
 #define DEVICE_LINK_PERSISTENT	(1 << 0)
+#define DEVICE_LINK_PM_RUNTIME	(1 << 1)
+#define DEVICE_LINK_RPM_ACTIVE	(1 << 2)
 
 struct device_link {
 	struct device *supplier;
@@ -728,6 +732,7 @@ struct device_link {
 	struct list_head c_node;
 	enum device_link_status status;
 	u32 flags;
+	bool rpm_active;
 	spinlock_t lock;
 	struct rcu_head rcu_head;
 };
Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -61,6 +61,7 @@ extern unsigned long pm_runtime_autosusp
 extern void pm_runtime_update_max_time_suspended(struct device *dev,
 						 s64 delta_ns);
 extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
+extern void pm_runtime_clean_up_links(struct device *dev);
 
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
 {
@@ -192,6 +193,7 @@ static inline unsigned long pm_runtime_a
 				struct device *dev) { return 0; }
 static inline void pm_runtime_set_memalloc_noio(struct device *dev,
 						bool enable){}
+static inline void pm_runtime_clean_up_links(struct device *dev) {}
 
 #endif /* !CONFIG_PM */
 
