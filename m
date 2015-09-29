From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v6 1/2] PM / sleep: Go direct_complete if driver has no callbacks
Date: Tue, 29 Sep 2015 17:32:53 +0200
Message-ID: <1443540774-5286-2-git-send-email-tomeu.vizoso@collabora.com>
References: <1443540774-5286-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34095 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935128AbbI2Pd3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2015 11:33:29 -0400
In-Reply-To: <1443540774-5286-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>

If a suitable prepare callback cannot be found for a given device and
its driver has no PM callbacks at all, assume that it can go direct to
complete when the system goes to sleep.

The reason for this is that there's lots of devices in a system that do
no PM at all and there's no reason for them to prevent their ancestors
to do direct_complete if they can support it.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v6:
- Add stub for !CONFIG_PM.
- Move implementation of device_check_pm_callbacks to power/main.c as it
  doesn't belong to CONFIG_PM_SLEEP.
- Take dev->power.lock before modifying flag.

Changes in v5:
- Check for all dev_pm_ops instances associated to a device, updating a
  no_pm_callbacks flag at the times when that could change.

 drivers/base/dd.c           |  3 +++
 drivers/base/power/common.c | 27 +++++++++++++++++++++++++++
 drivers/base/power/domain.c |  5 +++++
 drivers/base/power/main.c   | 44 +++++++++++++++++++++++++-------------------
 drivers/base/power/power.h  |  6 ++++++
 include/linux/pm.h          |  1 +
 6 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index be0eb4639128..fe0e9cb684b8 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -205,6 +205,8 @@ static void driver_bound(struct device *dev)
 
 	klist_add_tail(&dev->p->knode_driver, &dev->driver->p->klist_devices);
 
+	device_check_pm_callbacks(dev);
+
 	/*
 	 * Make sure the device is no longer in one of the deferred lists and
 	 * kick off retrying all pending devices
@@ -695,6 +697,7 @@ static void __device_release_driver(struct device *dev)
 			dev->pm_domain->dismiss(dev);
 
 		klist_remove(&dev->p->knode_driver);
+		device_check_pm_callbacks(dev);
 		if (dev->bus)
 			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 						     BUS_NOTIFY_UNBOUND_DRIVER,
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index f32b802b98f4..1bba85f8bf8a 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -128,3 +128,30 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
 		dev->pm_domain->detach(dev, power_off);
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
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
+void device_check_pm_callbacks(struct device *dev)
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
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 16550c63d611..3cae1aa1885b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -20,6 +20,8 @@
 #include <linux/suspend.h>
 #include <linux/export.h>
 
+#include "power.h"
+
 #define GENPD_RETRY_MAX_MS	250		/* Approximate */
 
 #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
@@ -1305,6 +1307,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
+	device_check_pm_callbacks(dev);
  out:
 	mutex_unlock(&genpd->lock);
 
@@ -1369,6 +1372,8 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
 	genpd_free_dev_data(dev, gpd_data);
 
+	device_check_pm_callbacks(dev);
+
 	return 0;
 
  out:
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 1710c26ba097..8f9cdaf21ee4 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -131,6 +131,8 @@ void device_pm_add(struct device *dev)
 			dev_name(dev->parent));
 	list_add_tail(&dev->power.entry, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
+
+	device_check_pm_callbacks(dev);
 }
 
 /**
@@ -1569,27 +1571,31 @@ static int device_prepare(struct device *dev, pm_message_t state)
 
 	dev->power.wakeup_path = device_may_wakeup(dev);
 
-	if (dev->pm_domain) {
-		info = "preparing power domain ";
-		callback = dev->pm_domain->ops.prepare;
-	} else if (dev->type && dev->type->pm) {
-		info = "preparing type ";
-		callback = dev->type->pm->prepare;
-	} else if (dev->class && dev->class->pm) {
-		info = "preparing class ";
-		callback = dev->class->pm->prepare;
-	} else if (dev->bus && dev->bus->pm) {
-		info = "preparing bus ";
-		callback = dev->bus->pm->prepare;
-	}
+	if (dev->power.no_pm_callbacks)
+		ret = 1;	/* Let device go direct_complete */
+	else {
+		if (dev->pm_domain) {
+			info = "preparing power domain ";
+			callback = dev->pm_domain->ops.prepare;
+		} else if (dev->type && dev->type->pm) {
+			info = "preparing type ";
+			callback = dev->type->pm->prepare;
+		} else if (dev->class && dev->class->pm) {
+			info = "preparing class ";
+			callback = dev->class->pm->prepare;
+		} else if (dev->bus && dev->bus->pm) {
+			info = "preparing bus ";
+			callback = dev->bus->pm->prepare;
+		}
 
-	if (!callback && dev->driver && dev->driver->pm) {
-		info = "preparing driver ";
-		callback = dev->driver->pm->prepare;
-	}
+		if (!callback && dev->driver && dev->driver->pm) {
+			info = "preparing driver ";
+			callback = dev->driver->pm->prepare;
+		}
 
-	if (callback)
-		ret = callback(dev);
+		if (callback)
+			ret = callback(dev);
+	}
 
 	device_unlock(dev);
 
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 998fa6b23084..f665a7850016 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -29,6 +29,8 @@ struct wake_irq {
 extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
 extern void dev_pm_disarm_wake_irq(struct wake_irq *wirq);
 
+extern void device_check_pm_callbacks(struct device *dev);
+
 #ifdef CONFIG_PM_SLEEP
 
 extern int device_wakeup_attach_irq(struct device *dev,
@@ -102,6 +104,10 @@ static inline void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
 {
 }
 
+static inline void device_check_pm_callbacks(struct device *dev)
+{
+}
+
 #endif
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 35d599e7250d..e334b9b8cd46 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -566,6 +566,7 @@ struct dev_pm_info {
 	bool			ignore_children:1;
 	bool			early_init:1;	/* Owned by the PM core */
 	bool			direct_complete:1;	/* Owned by the PM core */
+	bool			no_pm_callbacks:1;	/* Owned by the PM core */
 	spinlock_t		lock;
 #ifdef CONFIG_PM_SLEEP
 	struct list_head	entry;
-- 
2.4.3

