From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/5] PM: Introduce generic prepare and complete
	callbacks for subsystems
Date: Sun, 8 May 2011 23:23:34 +0200
Message-ID: <201105082323.35035.rjw__238.16767284206$1304890467$gmane$org@sisk.pl>
References: <201104290154.12966.rjw@sisk.pl> <201105082320.57185.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105082320.57185.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce generic ->prepare() and ->complete() power management
callbacks that can be used by subsystems and power domains, export
them and make the generic_subsys_pm_ops object point to them.
Additionally, provide NULL definitions of all the generic system
sleep callbacks for CONFIG_PM_SLEEP unset.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/generic_ops.c |   39 +++++++++++++++++++++++++++++++++++++++
 include/linux/pm.h               |   26 +++++++++++++++++++-------
 2 files changed, 58 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/base/power/generic_ops.c
===================================================================
--- linux-2.6.orig/drivers/base/power/generic_ops.c
+++ linux-2.6/drivers/base/power/generic_ops.c
@@ -74,6 +74,23 @@ EXPORT_SYMBOL_GPL(pm_generic_runtime_res
 
 #ifdef CONFIG_PM_SLEEP
 /**
+ * pm_generic_prepare - Generic routine preparing a device for power transition.
+ * @dev: Device to prepare.
+ *
+ * Prepare a device for a system-wide power transition.
+ */
+int pm_generic_prepare(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (drv && drv->pm && drv->pm->prepare)
+		ret = drv->pm->prepare(dev);
+
+	return ret;
+}
+
+/**
  * __pm_generic_call - Generic suspend/freeze/poweroff/thaw subsystem callback.
  * @dev: Device to handle.
  * @event: PM transition of the system under way.
@@ -213,16 +230,38 @@ int pm_generic_restore(struct device *de
 	return __pm_generic_resume(dev, PM_EVENT_RESTORE);
 }
 EXPORT_SYMBOL_GPL(pm_generic_restore);
+
+/**
+ * pm_generic_complete - Generic routine competing a device power transition.
+ * @dev: Device to handle.
+ *
+ * Complete a device power transition during a system-wide power transition.
+ */
+void pm_generic_complete(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+
+	if (drv && drv->pm && drv->pm->complete)
+		drv->pm->complete(dev);
+
+	/*
+	 * Let runtime PM try to suspend devices that haven't been in use before
+	 * going into the system-wide sleep state we're resuming from.
+	 */
+	pm_runtime_idle(dev);
+}
 #endif /* CONFIG_PM_SLEEP */
 
 struct dev_pm_ops generic_subsys_pm_ops = {
 #ifdef CONFIG_PM_SLEEP
+	.prepare = pm_generic_prepare,
 	.suspend = pm_generic_suspend,
 	.resume = pm_generic_resume,
 	.freeze = pm_generic_freeze,
 	.thaw = pm_generic_thaw,
 	.poweroff = pm_generic_poweroff,
 	.restore = pm_generic_restore,
+	.complete = pm_generic_complete,
 #endif
 #ifdef CONFIG_PM_RUNTIME
 	.runtime_suspend = pm_generic_runtime_suspend,
Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -547,6 +547,16 @@ extern void __suspend_report_result(cons
 	} while (0)
 
 extern int device_pm_wait_for_dev(struct device *sub, struct device *dev);
+
+extern int pm_generic_prepare(struct device *dev);
+extern int pm_generic_suspend(struct device *dev);
+extern int pm_generic_resume(struct device *dev);
+extern int pm_generic_freeze(struct device *dev);
+extern int pm_generic_thaw(struct device *dev);
+extern int pm_generic_restore(struct device *dev);
+extern int pm_generic_poweroff(struct device *dev);
+extern void pm_generic_complete(struct device *dev);
+
 #else /* !CONFIG_PM_SLEEP */
 
 #define device_pm_lock() do {} while (0)
@@ -563,6 +573,15 @@ static inline int device_pm_wait_for_dev
 {
 	return 0;
 }
+
+#define pm_generic_prepare	NULL
+#define pm_generic_suspend	NULL
+#define pm_generic_resume	NULL
+#define pm_generic_freeze	NULL
+#define pm_generic_thaw		NULL
+#define pm_generic_restore	NULL
+#define pm_generic_poweroff	NULL
+#define pm_generic_complete	NULL
 #endif /* !CONFIG_PM_SLEEP */
 
 /* How to reorder dpm_list after device_move() */
@@ -573,11 +592,4 @@ enum dpm_order {
 	DPM_ORDER_DEV_LAST,
 };
 
-extern int pm_generic_suspend(struct device *dev);
-extern int pm_generic_resume(struct device *dev);
-extern int pm_generic_freeze(struct device *dev);
-extern int pm_generic_thaw(struct device *dev);
-extern int pm_generic_restore(struct device *dev);
-extern int pm_generic_poweroff(struct device *dev);
-
 #endif /* _LINUX_PM_H */
