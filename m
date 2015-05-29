From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH] PM: check for complete cb before device lock in dpm_complete
Date: Fri, 29 May 2015 12:34:16 -0700
Message-ID: <1432928056-25622-1-git-send-email-todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59782 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756694AbbE2TeT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 29 May 2015 15:34:19 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com
Cc: rjw@rjwysocki.net, todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com

In theory, if a device has no pm_ops complete callback it shouldn't have
to be locked in order to skip it in the dpm_complete call. This causes
problems when a device without a complete callback has already begun
operation after its resume cb is called. It can end up holding up the
system resume as the pm subsystem tries to get a device lock just to
check for a callback that isn't there.

This fixes an issue discovered on an Ivy Bridge laptop which has an
AlpsPS/2 GlidePoint touchpad connected to an i8042 serio bus. The resume
path ends up wasting a full second waiting for a device_lock on the psmouse
driver, only to then discover that it has no device_complete callback. The
alpa driver has already begun sending and receiving data after its resume
call was finished, which prevents the pm subsystem from getting the device
lock.

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 drivers/base/power/main.c | 15 +++++++++++++++
 include/linux/pm.h        |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3d874ec..30eb16b 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -94,6 +94,7 @@ void device_pm_sleep_init(struct device *dev)
 	dev->power.is_suspended = false;
 	dev->power.is_noirq_suspended = false;
 	dev->power.is_late_suspended = false;
+	dev->power.no_complete = false;
 	init_completion(&dev->power.completion);
 	complete_all(&dev->power.completion);
 	dev->power.wakeup = NULL;
@@ -897,6 +898,9 @@ static void device_complete(struct device *dev, pm_message_t state)
 	if (dev->power.syscore)
 		return;
 
+	if (dev->power.no_complete)
+		goto Complete;
+
 	device_lock(dev);
 
 	if (dev->pm_domain) {
@@ -927,6 +931,7 @@ static void device_complete(struct device *dev, pm_message_t state)
 
 	device_unlock(dev);
 
+Complete:
 	pm_runtime_put(dev);
 }
 
@@ -1591,6 +1596,16 @@ static int device_prepare(struct device *dev, pm_message_t state)
 		trace_device_pm_callback_end(dev, ret);
 	}
 
+	/* check for the existence of a complete callback while its locked */
+	if ((dev->pm_domain && dev->pm_domain->ops.complete) ||
+		(dev->type && dev->type->pm && dev->type->pm->complete) ||
+		(dev->class && dev->class->pm && dev->class->pm->complete) ||
+		(dev->bus && dev->bus->pm && dev->bus->pm->complete) ||
+		(dev->driver && dev->driver->pm && dev->driver->pm->complete))
+		dev->power.no_complete = false;
+	else
+		dev->power.no_complete = true;
+
 	device_unlock(dev);
 
 	if (ret < 0) {
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 2d29c64..1e334cd 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -553,6 +553,7 @@ struct dev_pm_info {
 	bool			ignore_children:1;
 	bool			early_init:1;	/* Owned by the PM core */
 	bool			direct_complete:1;	/* Owned by the PM core */
+	bool			no_complete:1;	/* Owned by the PM core */
 	spinlock_t		lock;
 #ifdef CONFIG_PM_SLEEP
 	struct list_head	entry;
-- 
2.1.0

