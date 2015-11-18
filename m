From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2] Driver core: Re-init runtime PM states at probe error and driver unbind
Date: Wed, 18 Nov 2015 11:48:39 +0100
Message-ID: <1447843719-9501-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34553 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbbKRKs6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 05:48:58 -0500
Received: by lffu14 with SMTP id u14so23620789lff.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2015 02:48:56 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Eduardo Valentin <edubezval@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

There are two common expectations among several subsystems/drivers that
deploys runtime PM support, but which isn't met by the driver core.

Expectation 1)
At ->probe() the subsystem/driver expects the runtime PM status of the
device to be RPM_SUSPENDED, which is the initial status being assigned at
device registration.

This expectation is especially common among some of those subsystems/
drivers that manages devices with an attached PM domain, as those requires
the ->runtime_resume() callback at the PM domain level to be invoked
during ->probe().

Moreover these subsystems/drivers entirely relies on runtime PM resources
being managed at the PM domain level, thus don't implement their own set
of runtime PM callbacks.

These are two scenarios that suffers from this unmet expectation.

i) A failed ->probe() sequence requests probe deferral:

->probe()
  ...
  pm_runtime_enable()
  pm_runtime_get_sync()
  ...

err:
  pm_runtime_put()
  pm_runtime_disable()
  ...

As there are no guarantees that such sequence turns the runtime PM status
of the device into RPM_SUSPENDED, the re-trying ->probe() may start with
the status in RPM_ACTIVE.

In such case the runtime PM core won't invoke the ->runtime_resume()
callback because of a pm_runtime_get_sync(), as it considers the device to
be already runtime resumed.

ii) A driver re-bind sequence:

At driver unbind, the subsystem/driver's >remove() callback invokes a
sequence of runtime PM APIs, to undo actions during ->probe() and to put
the device into low power state.

->remove()
  ...
  pm_runtime_put()
  pm_runtime_disable()
  ...

Similar as in the failing ->probe() case, this sequence don't guarantee
the runtime PM status of the device to turn into RPM_SUSPENDED.

Trying to re-bind the driver thus causes the same issue as when re-trying
->probe(), in the probe deferral scenario.

Expectation 2)
Drivers that invokes the pm_runtime_irq_safe() API during ->probe(),
triggers the runtime PM core to increase the usage count for the device's
parent and permanently make it runtime resumed.

The usage count is only dropped at device removal, which also allows it to
be runtime suspended again.

A re-trying ->probe() repeats the call to pm_runtime_irq_safe() and thus
once more triggers the usage count of the device's parent to be increased.

This leads to not only an imbalance issue of the usage count of the
device's parent, but also to keep it runtime resumed permanently even if
->probe() fails.

To address these issues, let's change the policy of the driver core to
meet these expectations. More precisely, at ->probe() failures and driver
unbind, restore the initial states of runtime PM.

Although to still allow subsystem's to control PM for devices that doesn't
->probe() successfully, don't restore the initial states unless runtime PM
is disabled.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Folded patches into one patch, according to Rafael's request.
	- Add pm_runtime_reinit() and updated code from review by Alan.
	- Updated commit message header.

---
 drivers/base/dd.c            |  2 ++
 drivers/base/power/power.h   |  2 ++
 drivers/base/power/runtime.c | 26 ++++++++++++++++++++------
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a641cf3..cd2d79b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -340,6 +340,7 @@ probe_failed:
 	dev_set_drvdata(dev, NULL);
 	if (dev->pm_domain && dev->pm_domain->dismiss)
 		dev->pm_domain->dismiss(dev);
+	pm_runtime_reinit(dev);
 
 	switch (ret) {
 	case -EPROBE_DEFER:
@@ -695,6 +696,7 @@ static void __device_release_driver(struct device *dev)
 		dev_set_drvdata(dev, NULL);
 		if (dev->pm_domain && dev->pm_domain->dismiss)
 			dev->pm_domain->dismiss(dev);
+		pm_runtime_reinit(dev);
 
 		klist_remove(&dev->p->knode_driver);
 		if (dev->bus)
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 998fa6b..8b06193 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -18,6 +18,7 @@ static inline void pm_runtime_early_init(struct device *dev)
 }
 
 extern void pm_runtime_init(struct device *dev);
+extern void pm_runtime_reinit(struct device *dev);
 extern void pm_runtime_remove(struct device *dev);
 
 struct wake_irq {
@@ -84,6 +85,7 @@ static inline void pm_runtime_early_init(struct device *dev)
 }
 
 static inline void pm_runtime_init(struct device *dev) {}
+static inline void pm_runtime_reinit(struct device *dev) {}
 static inline void pm_runtime_remove(struct device *dev) {}
 
 static inline int dpm_sysfs_add(struct device *dev) { return 0; }
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index e1a10a0..ab3fcd9 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1390,18 +1390,32 @@ void pm_runtime_init(struct device *dev)
 }
 
 /**
+ * pm_runtime_reinit - Re-initialize runtime PM fields in given device object.
+ * @dev: Device object to re-initialize.
+ */
+void pm_runtime_reinit(struct device *dev)
+{
+	if (!pm_runtime_enabled(dev)) {
+		if (dev->power.runtime_status == RPM_ACTIVE)
+			pm_runtime_set_suspended(dev);
+		if (dev->power.irq_safe) {
+			spin_lock_irq(&dev->power.lock);
+			dev->power.irq_safe = 0;
+			spin_unlock_irq(&dev->power.lock);
+			if (dev->parent)
+				pm_runtime_put(dev->parent);
+		}
+	}
+}
+
+/**
  * pm_runtime_remove - Prepare for removing a device from device hierarchy.
  * @dev: Device object being removed from device hierarchy.
  */
 void pm_runtime_remove(struct device *dev)
 {
 	__pm_runtime_disable(dev, false);
-
-	/* Change the status back to 'suspended' to match the initial status. */
-	if (dev->power.runtime_status == RPM_ACTIVE)
-		pm_runtime_set_suspended(dev);
-	if (dev->power.irq_safe && dev->parent)
-		pm_runtime_put(dev->parent);
+	pm_runtime_reinit(dev);
 }
 
 /**
-- 
1.9.1

