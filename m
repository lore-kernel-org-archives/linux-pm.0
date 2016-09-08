From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH v2 5/7] PM / runtime: Flag to indicate PM sleep transitions in progress
Date: Thu, 08 Sep 2016 23:29:48 +0200
Message-ID: <3677187.4hCpDgWMoX@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62048 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751529AbcIHVZv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2016 17:25:51 -0400
In-Reply-To: <27296716.H9VWo8ShOm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.og>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a new flag in struct dev_pm_info, pm_sleep_in_progress, to
indicate that runtime PM has been disabled because of a PM sleep
transition in progress.

Make __pm_runtime_disable() set that flag when invoked with
RPM_DISABLE_ENABLE_PM_SLEEP set in its second argument and make
the PM core call it that way during system sleep transitions.

Introduce __pm_runtime_enable() so that it can take a second flags
argument and make it clear power.pm_sleep_in_progress for the device
if invoked with RPM_DISABLE_ENABLE_PM_SLEEP set.  Also make the PM
core pass RPM_DISABLE_ENABLE_PM_SLEEP to it during transitions from
system sleep to the working state.

Modify rpm_idle(), rpm_resume, rpm_suspend() and pm_schedule_suspend()
to neglect error codes and return 0 (without doing anything else)
when power.pm_sleep_in_progress is set for the device.

That will allow helpers like pm_runtime_get_sync() to be called
during system sleep transitions without worrying about possible
error codes they may return because runtime PM is disabled at
that point.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/power/runtime_pm.txt |   15 ++++++++-------
 drivers/base/power/main.c          |   12 ++++++------
 drivers/base/power/runtime.c       |   29 +++++++++++++++++++++++------
 include/linux/pm.h                 |    1 +
 include/linux/pm_runtime.h         |   12 ++++++++++--
 5 files changed, 48 insertions(+), 21 deletions(-)

Index: linux-pm/Documentation/power/runtime_pm.txt
===================================================================
--- linux-pm.orig/Documentation/power/runtime_pm.txt
+++ linux-pm/Documentation/power/runtime_pm.txt
@@ -685,14 +685,15 @@ out the following operations:
     right before executing the subsystem-level .prepare() callback for it and
     pm_runtime_barrier() is called for every device right before executing the
     subsystem-level .suspend() callback for it.  In addition to that the PM core
-    calls  __pm_runtime_disable() with 0 as the second argument for every
-    device right before executing the subsystem-level .suspend_late() callback
-    for it.
+    calls  __pm_runtime_disable() with RPM_DISABLE_ENABLE_PM_SLEEP as the second
+    argument for every device right before executing the subsystem-level
+    .suspend_late() callback for it.
 
-  * During system resume pm_runtime_enable() and pm_runtime_put() are called for
-    every device right after executing the subsystem-level .resume_early()
-    callback and right after executing the subsystem-level .complete() callback
-    for it, respectively.
+  * During system resume __pm_runtime_enable() (with RPM_DISABLE_ENABLE_PM_SLEEP
+    as the second argument) and pm_runtime_put() are called for every device
+    right after executing the subsystem-level .resume_early() callback and right
+    after executing the subsystem-level .complete() callback for it,
+    respectively.
 
 7. Generic subsystem callbacks
 
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -701,7 +701,7 @@ static int device_resume_early(struct de
  Out:
 	TRACE_RESUME(error);
 
-	pm_runtime_enable(dev);
+	__pm_runtime_enable(dev, RPM_DISABLE_ENABLE_PM_SLEEP);
 	complete_all(&dev->power.completion);
 	return error;
 }
@@ -801,8 +801,8 @@ static int device_resume(struct device *
 		goto Complete;
 
 	if (dev->power.direct_complete) {
-		/* Match the pm_runtime_disable() in __device_suspend(). */
-		pm_runtime_enable(dev);
+		/* Match the __pm_runtime_disable() in __device_suspend(). */
+		__pm_runtime_enable(dev, RPM_DISABLE_ENABLE_PM_SLEEP);
 		goto Complete;
 	}
 
@@ -1228,7 +1228,7 @@ static int __device_suspend_late(struct
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
 
-	__pm_runtime_disable(dev, 0);
+	__pm_runtime_disable(dev, RPM_DISABLE_ENABLE_PM_SLEEP);
 
 	if (async_error)
 		goto Complete;
@@ -1438,11 +1438,11 @@ static int __device_suspend(struct devic
 
 	if (dev->power.direct_complete) {
 		if (pm_runtime_status_suspended(dev)) {
-			pm_runtime_disable(dev);
+			__pm_runtime_disable(dev, RPM_DISABLE_ALL);
 			if (pm_runtime_status_suspended(dev))
 				goto Complete;
 
-			pm_runtime_enable(dev);
+			__pm_runtime_enable(dev, RPM_DISABLE_ENABLE_PM_SLEEP);
 		}
 		dev->power.direct_complete = false;
 	}
Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -353,6 +353,9 @@ static int rpm_idle(struct device *dev,
 
  out:
 	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
+	if (retval && dev->power.pm_sleep_in_progress)
+		return 0;
+
 	return retval ? retval : rpm_suspend(dev, rpmflags | RPM_AUTO);
 }
 
@@ -550,6 +553,8 @@ static int rpm_suspend(struct device *de
 
  out:
 	trace_rpm_return_int(dev, _THIS_IP_, retval);
+	if (retval && dev->power.pm_sleep_in_progress)
+		return 0;
 
 	return retval;
 
@@ -765,6 +770,8 @@ static int rpm_resume(struct device *dev
 	}
 
 	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
+	if (retval && dev->power.pm_sleep_in_progress)
+		return 0;
 
 	return retval;
 }
@@ -867,6 +874,8 @@ int pm_schedule_suspend(struct device *d
 
  out:
 	spin_unlock_irqrestore(&dev->power.lock, flags);
+	if (retval && dev->power.pm_sleep_in_progress)
+		return 0;
 
 	return retval;
 }
@@ -1200,28 +1209,35 @@ void __pm_runtime_disable(struct device
 		__pm_runtime_barrier(dev);
 
  out:
+	if (flags & RPM_DISABLE_ENABLE_PM_SLEEP)
+		dev->power.pm_sleep_in_progress = true;
+
 	spin_unlock_irq(&dev->power.lock);
 }
 EXPORT_SYMBOL_GPL(__pm_runtime_disable);
 
 /**
- * pm_runtime_enable - Enable runtime PM of a device.
+ * __pm_runtime_enable - Enable runtime PM of a device.
  * @dev: Device to handle.
+ * @flags: Behavior modifiers.
  */
-void pm_runtime_enable(struct device *dev)
+void __pm_runtime_enable(struct device *dev, unsigned int flags)
 {
-	unsigned long flags;
+	unsigned long irqflags;
 
-	spin_lock_irqsave(&dev->power.lock, flags);
+	spin_lock_irqsave(&dev->power.lock, irqflags);
+
+	if (flags & RPM_DISABLE_ENABLE_PM_SLEEP)
+		dev->power.pm_sleep_in_progress = false;
 
 	if (dev->power.disable_depth > 0)
 		dev->power.disable_depth--;
 	else
 		dev_warn(dev, "Unbalanced %s!\n", __func__);
 
-	spin_unlock_irqrestore(&dev->power.lock, flags);
+	spin_unlock_irqrestore(&dev->power.lock, irqflags);
 }
-EXPORT_SYMBOL_GPL(pm_runtime_enable);
+EXPORT_SYMBOL_GPL(__pm_runtime_enable);
 
 /**
  * pm_runtime_forbid - Block runtime PM of a device.
@@ -1396,6 +1412,7 @@ void pm_runtime_init(struct device *dev)
 	dev->power.idle_notification = false;
 
 	dev->power.disable_depth = 1;
+	dev->power.pm_sleep_in_progress = false;
 	atomic_set(&dev->power.usage_count, 0);
 
 	dev->power.runtime_error = 0;
Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -585,6 +585,7 @@ struct dev_pm_info {
 	atomic_t		usage_count;
 	atomic_t		child_count;
 	unsigned int		disable_depth:3;
+	bool			pm_sleep_in_progress:1;
 	unsigned int		idle_notification:1;
 	unsigned int		request_pending:1;
 	unsigned int		deferred_resume:1;
Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -25,6 +25,9 @@
 
 /* Runtime PM disable/enable flags */
 #define RPM_DISABLE_CHECK_RESUME	(1 << 0)
+#define RPM_DISABLE_ENABLE_PM_SLEEP	(1 << 1)
+
+#define RPM_DISABLE_ALL	(RPM_DISABLE_CHECK_RESUME | RPM_DISABLE_ENABLE_PM_SLEEP)
 
 #ifdef CONFIG_PM
 extern struct workqueue_struct *pm_wq;
@@ -46,7 +49,7 @@ extern int pm_runtime_get_if_in_use(stru
 extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
 extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
 extern int pm_runtime_barrier(struct device *dev);
-extern void pm_runtime_enable(struct device *dev);
+extern void __pm_runtime_enable(struct device *dev, unsigned int flags);
 extern void __pm_runtime_disable(struct device *dev, unsigned int flags);
 extern void pm_runtime_allow(struct device *dev);
 extern void pm_runtime_forbid(struct device *dev);
@@ -159,7 +162,7 @@ static inline int pm_runtime_get_if_in_u
 static inline int __pm_runtime_set_status(struct device *dev,
 					    unsigned int status) { return 0; }
 static inline int pm_runtime_barrier(struct device *dev) { return 0; }
-static inline void pm_runtime_enable(struct device *dev) {}
+static inline void __pm_runtime_enable(struct device *dev, unsigned int flags) {}
 static inline void __pm_runtime_disable(struct device *dev, unsigned int flags) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
@@ -278,6 +281,11 @@ static inline void pm_runtime_disable(st
 	__pm_runtime_disable(dev, RPM_DISABLE_CHECK_RESUME);
 }
 
+static inline void pm_runtime_enable(struct device *dev)
+{
+	__pm_runtime_enable(dev, 0);
+}
+
 static inline void pm_runtime_use_autosuspend(struct device *dev)
 {
 	__pm_runtime_use_autosuspend(dev, true);

