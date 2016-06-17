From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 04/10] PM core: Make runtime PM of devices use device links
Date: Fri, 17 Jun 2016 08:26:54 +0200
Message-ID: <1466144820-6286-5-git-send-email-m.szyprowski@samsung.com>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1466144820-6286-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

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

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/base/core.c          | 15 +++++++
 drivers/base/dd.c            |  1 +
 drivers/base/power/runtime.c | 93 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/device.h       |  5 +++
 include/linux/pm_runtime.h   |  2 +
 5 files changed, 111 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 51a479ed68b5..1fe7cf232e1e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -88,6 +88,11 @@ struct devlink *device_link_add(struct device *consumer,
 	if (!consumer || !supplier || !flags)
 		return NULL;
 
+#define RPM_ACTIVE_FLAGS (DEVICE_LINK_PM_RUNTIME | DEVICE_LINK_PROBE_TIME)
+	if ((flags & DEVICE_LINK_RPM_ACTIVE)
+	    && (flags & RPM_ACTIVE_FLAGS) != RPM_ACTIVE_FLAGS)
+		return NULL;
+
 	mutex_lock(&device_links_lock);
 
 	list_for_each_entry(link, &supplier->supplier_links, s_node)
@@ -98,6 +103,16 @@ struct devlink *device_link_add(struct device *consumer,
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
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 7c0abeba89e9..2efec98ddb12 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -791,6 +791,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		}
 
 		pm_runtime_get_sync(dev);
+		pm_runtime_clean_up_links(dev);
 
 		driver_sysfs_remove(dev);
 
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index b74690418504..ba21c123b16e 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -12,6 +12,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeirq.h>
 #include <trace/events/rpm.h>
+
+#include "../base.h"
 #include "power.h"
 
 typedef int (*pm_callback_t)(struct device *);
@@ -266,19 +268,69 @@ static int rpm_check_suspend_allowed(struct device *dev)
 static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
-	int retval;
+	struct devlink *link;
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
+			list_for_each_entry_rcu(link, &dev->consumer_links, c_node)
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
+			list_for_each_entry_rcu(link, &dev->consumer_links, c_node)
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
@@ -1443,6 +1495,37 @@ void pm_runtime_remove(struct device *dev)
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
+	struct devlink *link;
+	int idx;
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->supplier_links, s_node)
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
diff --git a/include/linux/device.h b/include/linux/device.h
index 647204bd74a0..536ce4058e50 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -719,9 +719,13 @@ enum devlink_status {
  *
  * PERSISTENT: Do not delete the link on consumer device driver unbind.
  * PROBE_TIME: Assume supplier device functional when creating the link.
+ * PM_RUNTIME: If set, the runtime PM framework will use this link.
+ * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
  */
 #define DEVICE_LINK_PERSISTENT	(1 << 0)
 #define DEVICE_LINK_PROBE_TIME	(1 << 1)
+#define DEVICE_LINK_PM_RUNTIME	(1 << 2)
+#define DEVICE_LINK_RPM_ACTIVE	(1 << 3)
 
 struct devlink {
 	struct device *supplier;
@@ -730,6 +734,7 @@ struct devlink {
 	struct list_head c_node;
 	enum devlink_status status;
 	u32 flags;
+	bool rpm_active;
 	spinlock_t lock;
 	struct rcu_head rcu_head;
 };
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 2e14d2667b6c..c21a21c064e3 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -55,6 +55,7 @@ extern unsigned long pm_runtime_autosuspend_expiration(struct device *dev);
 extern void pm_runtime_update_max_time_suspended(struct device *dev,
 						 s64 delta_ns);
 extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
+extern void pm_runtime_clean_up_links(struct device *dev);
 
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
 {
@@ -186,6 +187,7 @@ static inline unsigned long pm_runtime_autosuspend_expiration(
 				struct device *dev) { return 0; }
 static inline void pm_runtime_set_memalloc_noio(struct device *dev,
 						bool enable){}
+static inline void pm_runtime_clean_up_links(struct device *dev) {}
 
 #endif /* !CONFIG_PM */
 
-- 
1.9.1
