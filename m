From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v9 3/4] PM / sleep: Go direct_complete if driver has no callbacks
Date: Mon,  5 Oct 2015 16:45:31 +0200
Message-ID: <1444056332-30246-4-git-send-email-tomeu.vizoso@collabora.com>
References: <1444056332-30246-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444056332-30246-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

If a suitable prepare callback cannot be found for a given device and
its driver has no PM callbacks at all, assume that it can go direct to
complete when the system goes to sleep.

The reason for this is that there's lots of devices in a system that do
no PM at all and there's no reason for them to prevent their ancestors
to do direct_complete if they can support it.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v9:
- Move to CONFIG_PM_SLEEP as suggested by Rafael and Ulf.
- Rename from device_check_pm_callbacks to device_pm_check_callbacks to
  follow with the naming convention of existing API.
- Re-add calling to device_pm_check_callbacks from device registration
  and when updating the PM domain of a device.

Changes in v8:
- Move no_pm_callbacks field into CONFIG_PM_SLEEP
- Call device_check_pm_callbacks only after a device is bound or unbound

Changes in v7:
- Reduce indentation by adding a label in device_prepare()

Changes in v6:
- Add stub for !CONFIG_PM.
- Move implementation of device_check_pm_callbacks to power/main.c as it
  doesn't belong to CONFIG_PM_SLEEP.
- Take dev->power.lock before modifying flag.

Changes in v5:
- Check for all dev_pm_ops instances associated to a device, updating a
  no_pm_callbacks flag at the times when that could change.

 drivers/base/dd.c           |  3 +++
 drivers/base/power/common.c |  3 +++
 drivers/base/power/domain.c |  2 ++
 drivers/base/power/main.c   | 35 +++++++++++++++++++++++++++++++++++
 drivers/base/power/power.h  |  3 +++
 include/linux/pm.h          |  1 +
 6 files changed, 47 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index d662ed5d08f4..15aae412f95b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -219,6 +219,8 @@ static void driver_bound(struct device *dev)
 
 	klist_add_tail(&dev->p->knode_driver, &dev->driver->p->klist_devices);
 
+	device_pm_check_callbacks(dev);
+
 	/*
 	 * Make sure the device is no longer in one of the deferred lists and
 	 * kick off retrying all pending devices
@@ -709,6 +711,7 @@ static void __device_release_driver(struct device *dev)
 			dev->pm_domain->dismiss(dev);
 
 		klist_remove(&dev->p->knode_driver);
+		device_pm_check_callbacks(dev);
 		if (dev->bus)
 			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 						     BUS_NOTIFY_UNBOUND_DRIVER,
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index a70f8a5cdfd7..763eee24cb95 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -14,6 +14,8 @@
 #include <linux/acpi.h>
 #include <linux/pm_domain.h>
 
+#include "power.h"
+
 /**
  * dev_pm_get_subsys_data - Create or refcount power.subsys_data for device.
  * @dev: Device to handle.
@@ -147,5 +149,6 @@ void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
 	WARN(device_is_bound(dev),
 	     "PM domains can only be changed for unbound devices\n");
 	dev->pm_domain = pd;
+	device_pm_check_callbacks(dev);
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_set);
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b75d02aa8d93..9dc1ce9c573b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -20,6 +20,8 @@
 #include <linux/suspend.h>
 #include <linux/export.h>
 
+#include "power.h"
+
 #define GENPD_RETRY_MAX_MS	250		/* Approximate */
 
 #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 1710c26ba097..d0faac7ab26b 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -125,6 +125,7 @@ void device_pm_add(struct device *dev)
 {
 	pr_debug("PM: Adding info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
+	device_pm_check_callbacks(dev);
 	mutex_lock(&dpm_list_mtx);
 	if (dev->parent && dev->parent->power.is_prepared)
 		dev_warn(dev, "parent %s should not be sleeping\n",
@@ -147,6 +148,7 @@ void device_pm_remove(struct device *dev)
 	mutex_unlock(&dpm_list_mtx);
 	device_wakeup_disable(dev);
 	pm_runtime_remove(dev);
+	device_pm_check_callbacks(dev);
 }
 
 /**
@@ -1569,6 +1571,11 @@ static int device_prepare(struct device *dev, pm_message_t state)
 
 	dev->power.wakeup_path = device_may_wakeup(dev);
 
+	if (dev->power.no_pm_callbacks) {
+		ret = 1;	/* Let device go direct_complete */
+		goto unlock;
+	}
+
 	if (dev->pm_domain) {
 		info = "preparing power domain ";
 		callback = dev->pm_domain->ops.prepare;
@@ -1591,6 +1598,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	if (callback)
 		ret = callback(dev);
 
+unlock:
 	device_unlock(dev);
 
 	if (ret < 0) {
@@ -1719,3 +1727,30 @@ void dpm_for_each_dev(void *data, void (*fn)(struct device *, void *))
 	device_pm_unlock();
 }
 EXPORT_SYMBOL_GPL(dpm_for_each_dev);
+
+static bool pm_ops_is_empty(const struct dev_pm_ops *ops)
+{
+	if (!ops)
+		return true;
+
+	return !ops->prepare &&
+	       !ops->suspend &&
+	       !ops->suspend_late &&
+	       !ops->suspend_noirq &&
+	       !ops->resume_noirq &&
+	       !ops->resume_early &&
+	       !ops->resume &&
+	       !ops->complete;
+}
+
+void device_pm_check_callbacks(struct device *dev)
+{
+	spin_lock_irq(&dev->power.lock);
+	dev->power.no_pm_callbacks =
+		(!dev->bus || pm_ops_is_empty(dev->bus->pm)) &&
+		(!dev->class || pm_ops_is_empty(dev->class->pm)) &&
+		(!dev->type || pm_ops_is_empty(dev->type->pm)) &&
+		(!dev->pm_domain || pm_ops_is_empty(&dev->pm_domain->ops)) &&
+		(!dev->driver || pm_ops_is_empty(dev->driver->pm));
+	spin_unlock_irq(&dev->power.lock);
+}
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 998fa6b23084..297beae64314 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -123,6 +123,7 @@ extern void device_pm_remove(struct device *);
 extern void device_pm_move_before(struct device *, struct device *);
 extern void device_pm_move_after(struct device *, struct device *);
 extern void device_pm_move_last(struct device *);
+extern void device_pm_check_callbacks(struct device *dev);
 
 #else /* !CONFIG_PM_SLEEP */
 
@@ -141,6 +142,8 @@ static inline void device_pm_move_after(struct device *deva,
 					struct device *devb) {}
 static inline void device_pm_move_last(struct device *dev) {}
 
+static inline void device_pm_check_callbacks(struct device *dev) {}
+
 #endif /* !CONFIG_PM_SLEEP */
 
 static inline void device_pm_init(struct device *dev)
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 35d599e7250d..7943acb74ae4 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -573,6 +573,7 @@ struct dev_pm_info {
 	struct wakeup_source	*wakeup;
 	bool			wakeup_path:1;
 	bool			syscore:1;
+	bool			no_pm_callbacks:1;	/* Owned by the PM core */
 #else
 	unsigned int		should_wakeup:1;
 #endif
-- 
2.4.3
