From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH v3 4/5] PM / runtime: Use device links
Date: Fri, 16 Sep 2016 00:07:13 +0200
Message-ID: <3563608.NkAGWo0GDR@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <5257325.y9rG1UM74b@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57822 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1754605AbcIOWCK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2016 18:02:10 -0400
In-Reply-To: <5257325.y9rG1UM74b@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

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
 drivers/base/core.c          |   23 +++++++-
 drivers/base/dd.c            |    1 
 drivers/base/power/runtime.c |  121 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/device.h       |    5 +
 include/linux/pm_runtime.h   |    2 
 5 files changed, 144 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -101,8 +101,16 @@ static int device_reorder_to_tail(struct
  * @flags: Link flags.
  *
  * If the DEVICE_LINK_STATELESS flag is set, @status is ignored.  Otherwise,
- * the caller is responsible for ensuring that @status reflects the current
- * status of both @consumer and @supplier.
+ * the caller is responsible for ensuring that (a) @status reflects the current
+ * status of both @consumer and @supplier and (b) the creation of the link is
+ * properly synchronized with runtime PM.
+ *
+ * To that end, setting the DEVICE_LINK_PM_RUNTIME flag will cause the runtime
+ * PM framework to take the link into account.  Moreover, if the
+ * DEVICE_LINK_RPM_ACTIVE flag is set in addition to it, the supplier devices
+ * will be forced into the active metastate and reference-counted upon the
+ * creation of the link.  If DEVICE_LINK_PM_RUNTIME is not set,
+ * DEVICE_LINK_RPM_ACTIVE will be ignored.
  *
  * If the DEVICE_LINK_AUTOREMOVE is set, the link will be removed automatically
  * when the consumer device driver unbinds from it.  The combination of both
@@ -138,10 +146,19 @@ struct device_link *device_link_add(stru
 		if (link->consumer == consumer)
 			goto out;
 
-	link = kmalloc(sizeof(*link), GFP_KERNEL);
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
 		goto out;
 
+	if ((flags & DEVICE_LINK_PM_RUNTIME) && (flags & DEVICE_LINK_RPM_ACTIVE)) {
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
@@ -258,6 +260,42 @@ static int rpm_check_suspend_allowed(str
 	return retval;
 }
 
+static int rpm_get_suppliers(struct device *dev)
+{
+	struct device_link *link;
+
+	list_for_each_entry_rcu(link, &dev->links_to_suppliers, c_node) {
+		int retval;
+
+		if (!(link->flags & DEVICE_LINK_PM_RUNTIME))
+			continue;
+
+		if (link->status == DEVICE_LINK_SUPPLIER_UNBIND ||
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
+	list_for_each_entry_rcu(link, &dev->links_to_suppliers, c_node)
+		if (link->rpm_active &&
+		    link->status != DEVICE_LINK_SUPPLIER_UNBIND) {
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
@@ -1447,6 +1521,43 @@ void pm_runtime_remove(struct device *de
 }
 
 /**
+ * pm_runtime_clean_up_links - Prepare links to consumers for driver removal.
+ * @dev: Device whose driver is going to be removed.
+ *
+ * Check links from this device to any consumers and if any of them have active
+ * runtime PM references to the device, drop the usage counter of the device
+ * (once per link).
+ *
+ * Links with the DEVICE_LINK_STATELESS flag set are ignored.
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
+	list_for_each_entry_rcu(link, &dev->links_to_consumers, s_node) {
+		if (link->flags & DEVICE_LINK_STATELESS)
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
  * pm_runtime_force_suspend - Force a device into suspend state if needed.
  * @dev: Device to suspend.
  *
Index: linux-pm/include/linux/device.h
===================================================================
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -720,9 +720,13 @@ enum device_link_status {
  *
  * STATELESS: The state machine is not applicable to this link.
  * AUTOREMOVE: Remove this link automatically on cunsumer driver unbind.
+ * PM_RUNTIME: If set, the runtime PM framework will use this link.
+ * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
  */
 #define DEVICE_LINK_STATELESS	(1 << 0)
 #define DEVICE_LINK_AUTOREMOVE	(1 << 1)
+#define DEVICE_LINK_PM_RUNTIME	(1 << 2)
+#define DEVICE_LINK_RPM_ACTIVE	(1 << 3)
 
 struct device_link {
 	struct device *supplier;
@@ -731,6 +735,7 @@ struct device_link {
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
@@ -55,6 +55,7 @@ extern unsigned long pm_runtime_autosusp
 extern void pm_runtime_update_max_time_suspended(struct device *dev,
 						 s64 delta_ns);
 extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
+extern void pm_runtime_clean_up_links(struct device *dev);
 
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
 {
@@ -186,6 +187,7 @@ static inline unsigned long pm_runtime_a
 				struct device *dev) { return 0; }
 static inline void pm_runtime_set_memalloc_noio(struct device *dev,
 						bool enable){}
+static inline void pm_runtime_clean_up_links(struct device *dev) {}
 
 #endif /* !CONFIG_PM */
 

