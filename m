From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH v2 4/7] PM / runtime: Pass flags argument to __pm_runtime_disable()
Date: Thu, 08 Sep 2016 23:29:12 +0200
Message-ID: <6474237.XEkJ3i5Vs8@vostro.rjw.lan>
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

Modify __pm_runtime_disable() to take a flags argument instead of
the bool one it takes currently which will allow its behavior to
be modified in more than one way.  Introduce a flag
RPM_DISABLE_CHECK_RESUME to address the case currenty addressed by
passing 'true' to __pm_runtime_disable() as the second argument.

A subsequent change will add one more flag to use with
__pm_runtime_disable().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/power/runtime_pm.txt |    2 +-
 drivers/base/power/main.c          |    2 +-
 drivers/base/power/runtime.c       |   10 +++++-----
 include/linux/pm_runtime.h         |    9 ++++++---
 4 files changed, 13 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1158,18 +1158,18 @@ EXPORT_SYMBOL_GPL(pm_runtime_barrier);
 /**
  * __pm_runtime_disable - Disable runtime PM of a device.
  * @dev: Device to handle.
- * @check_resume: If set, check if there's a resume request for the device.
+ * @flags: Behavior modifiers.
  *
  * Increment power.disable_depth for the device and if it was zero previously,
  * cancel all pending runtime PM requests for the device and wait for all
  * operations in progress to complete.  The device can be either active or
  * suspended after its runtime PM has been disabled.
  *
- * If @check_resume is set and there's a resume request pending when
+ * If the CHECK_RESUME flag is set and there's a resume request pending when
  * __pm_runtime_disable() is called and power.disable_depth is zero, the
  * function will wake up the device before disabling its runtime PM.
  */
-void __pm_runtime_disable(struct device *dev, bool check_resume)
+void __pm_runtime_disable(struct device *dev, unsigned int flags)
 {
 	spin_lock_irq(&dev->power.lock);
 
@@ -1183,7 +1183,7 @@ void __pm_runtime_disable(struct device
 	 * means there probably is some I/O to process and disabling runtime PM
 	 * shouldn't prevent the device from processing the I/O.
 	 */
-	if (check_resume && dev->power.request_pending
+	if ((flags & RPM_DISABLE_CHECK_RESUME) && dev->power.request_pending
 	    && dev->power.request == RPM_REQ_RESUME) {
 		/*
 		 * Prevent suspends and idle notifications from being carried
@@ -1442,7 +1442,7 @@ void pm_runtime_reinit(struct device *de
  */
 void pm_runtime_remove(struct device *dev)
 {
-	__pm_runtime_disable(dev, false);
+	__pm_runtime_disable(dev, 0);
 	pm_runtime_reinit(dev);
 }
 
Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -23,6 +23,9 @@
 					    usage_count */
 #define RPM_AUTO		0x08	/* Use autosuspend_delay */
 
+/* Runtime PM disable/enable flags */
+#define RPM_DISABLE_CHECK_RESUME	(1 << 0)
+
 #ifdef CONFIG_PM
 extern struct workqueue_struct *pm_wq;
 
@@ -44,7 +47,7 @@ extern int pm_schedule_suspend(struct de
 extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
 extern int pm_runtime_barrier(struct device *dev);
 extern void pm_runtime_enable(struct device *dev);
-extern void __pm_runtime_disable(struct device *dev, bool check_resume);
+extern void __pm_runtime_disable(struct device *dev, unsigned int flags);
 extern void pm_runtime_allow(struct device *dev);
 extern void pm_runtime_forbid(struct device *dev);
 extern void pm_runtime_no_callbacks(struct device *dev);
@@ -157,7 +160,7 @@ static inline int __pm_runtime_set_statu
 					    unsigned int status) { return 0; }
 static inline int pm_runtime_barrier(struct device *dev) { return 0; }
 static inline void pm_runtime_enable(struct device *dev) {}
-static inline void __pm_runtime_disable(struct device *dev, bool c) {}
+static inline void __pm_runtime_disable(struct device *dev, unsigned int flags) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 
@@ -272,7 +275,7 @@ static inline void pm_runtime_set_suspen
 
 static inline void pm_runtime_disable(struct device *dev)
 {
-	__pm_runtime_disable(dev, true);
+	__pm_runtime_disable(dev, RPM_DISABLE_CHECK_RESUME);
 }
 
 static inline void pm_runtime_use_autosuspend(struct device *dev)
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1228,7 +1228,7 @@ static int __device_suspend_late(struct
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
 
-	__pm_runtime_disable(dev, false);
+	__pm_runtime_disable(dev, 0);
 
 	if (async_error)
 		goto Complete;
Index: linux-pm/Documentation/power/runtime_pm.txt
===================================================================
--- linux-pm.orig/Documentation/power/runtime_pm.txt
+++ linux-pm/Documentation/power/runtime_pm.txt
@@ -685,7 +685,7 @@ out the following operations:
     right before executing the subsystem-level .prepare() callback for it and
     pm_runtime_barrier() is called for every device right before executing the
     subsystem-level .suspend() callback for it.  In addition to that the PM core
-    calls  __pm_runtime_disable() with 'false' as the second argument for every
+    calls  __pm_runtime_disable() with 0 as the second argument for every
     device right before executing the subsystem-level .suspend_late() callback
     for it.
 
