From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/8] PM: Introduce generic "noirq" callback
	routines for subsystems
Date: Sat, 11 Jun 2011 22:36:50 +0200
Message-ID: <201106112236.50368.rjw__29204.0324690335$1307825003$gmane$org@sisk.pl>
References: <201106112223.04972.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106112223.04972.rjw@sisk.pl>
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
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce generic "noirq" power management callback routines for
subsystems in addition to the "regular" generic PM callback routines.

The new routines will be used, among other things, for implementing
system-wide PM transitions support for generic PM domains.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/generic_ops.c |   90 ++++++++++++++++++++++++++++++++-------
 include/linux/pm.h               |    6 ++
 2 files changed, 82 insertions(+), 14 deletions(-)

Index: linux-2.6/drivers/base/power/generic_ops.c
===================================================================
--- linux-2.6.orig/drivers/base/power/generic_ops.c
+++ linux-2.6/drivers/base/power/generic_ops.c
@@ -94,12 +94,13 @@ int pm_generic_prepare(struct device *de
  * __pm_generic_call - Generic suspend/freeze/poweroff/thaw subsystem callback.
  * @dev: Device to handle.
  * @event: PM transition of the system under way.
+ * @bool: Whether or not this is the "noirq" stage.
  *
  * If the device has not been suspended at run time, execute the
  * suspend/freeze/poweroff/thaw callback provided by its driver, if defined, and
  * return its error code.  Otherwise, return zero.
  */
-static int __pm_generic_call(struct device *dev, int event)
+static int __pm_generic_call(struct device *dev, int event, bool noirq)
 {
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int (*callback)(struct device *);
@@ -109,16 +110,16 @@ static int __pm_generic_call(struct devi
 
 	switch (event) {
 	case PM_EVENT_SUSPEND:
-		callback = pm->suspend;
+		callback = noirq ? pm->suspend_noirq : pm->suspend;
 		break;
 	case PM_EVENT_FREEZE:
-		callback = pm->freeze;
+		callback = noirq ? pm->freeze_noirq : pm->freeze;
 		break;
 	case PM_EVENT_HIBERNATE:
-		callback = pm->poweroff;
+		callback = noirq ? pm->poweroff_noirq : pm->poweroff;
 		break;
 	case PM_EVENT_THAW:
-		callback = pm->thaw;
+		callback = noirq ? pm->thaw_noirq : pm->thaw;
 		break;
 	default:
 		callback = NULL;
@@ -129,42 +130,82 @@ static int __pm_generic_call(struct devi
 }
 
 /**
+ * pm_generic_suspend_noirq - Generic suspend_noirq callback for subsystems.
+ * @dev: Device to suspend.
+ */
+int pm_generic_suspend_noirq(struct device *dev)
+{
+	return __pm_generic_call(dev, PM_EVENT_SUSPEND, true);
+}
+EXPORT_SYMBOL_GPL(pm_generic_suspend_noirq);
+
+/**
  * pm_generic_suspend - Generic suspend callback for subsystems.
  * @dev: Device to suspend.
  */
 int pm_generic_suspend(struct device *dev)
 {
-	return __pm_generic_call(dev, PM_EVENT_SUSPEND);
+	return __pm_generic_call(dev, PM_EVENT_SUSPEND, false);
 }
 EXPORT_SYMBOL_GPL(pm_generic_suspend);
 
 /**
+ * pm_generic_freeze_noirq - Generic freeze_noirq callback for subsystems.
+ * @dev: Device to freeze.
+ */
+int pm_generic_freeze_noirq(struct device *dev)
+{
+	return __pm_generic_call(dev, PM_EVENT_FREEZE, true);
+}
+EXPORT_SYMBOL_GPL(pm_generic_freeze_noirq);
+
+/**
  * pm_generic_freeze - Generic freeze callback for subsystems.
  * @dev: Device to freeze.
  */
 int pm_generic_freeze(struct device *dev)
 {
-	return __pm_generic_call(dev, PM_EVENT_FREEZE);
+	return __pm_generic_call(dev, PM_EVENT_FREEZE, false);
 }
 EXPORT_SYMBOL_GPL(pm_generic_freeze);
 
 /**
+ * pm_generic_poweroff_noirq - Generic poweroff_noirq callback for subsystems.
+ * @dev: Device to handle.
+ */
+int pm_generic_poweroff_noirq(struct device *dev)
+{
+	return __pm_generic_call(dev, PM_EVENT_HIBERNATE, true);
+}
+EXPORT_SYMBOL_GPL(pm_generic_poweroff_noirq);
+
+/**
  * pm_generic_poweroff - Generic poweroff callback for subsystems.
  * @dev: Device to handle.
  */
 int pm_generic_poweroff(struct device *dev)
 {
-	return __pm_generic_call(dev, PM_EVENT_HIBERNATE);
+	return __pm_generic_call(dev, PM_EVENT_HIBERNATE, false);
 }
 EXPORT_SYMBOL_GPL(pm_generic_poweroff);
 
 /**
+ * pm_generic_thaw_noirq - Generic thaw_noirq callback for subsystems.
+ * @dev: Device to thaw.
+ */
+int pm_generic_thaw_noirq(struct device *dev)
+{
+	return __pm_generic_call(dev, PM_EVENT_THAW, true);
+}
+EXPORT_SYMBOL_GPL(pm_generic_thaw_noirq);
+
+/**
  * pm_generic_thaw - Generic thaw callback for subsystems.
  * @dev: Device to thaw.
  */
 int pm_generic_thaw(struct device *dev)
 {
-	return __pm_generic_call(dev, PM_EVENT_THAW);
+	return __pm_generic_call(dev, PM_EVENT_THAW, false);
 }
 EXPORT_SYMBOL_GPL(pm_generic_thaw);
 
@@ -172,12 +213,13 @@ EXPORT_SYMBOL_GPL(pm_generic_thaw);
  * __pm_generic_resume - Generic resume/restore callback for subsystems.
  * @dev: Device to handle.
  * @event: PM transition of the system under way.
+ * @bool: Whether or not this is the "noirq" stage.
  *
  * Execute the resume/resotre callback provided by the @dev's driver, if
  * defined.  If it returns 0, change the device's runtime PM status to 'active'.
  * Return the callback's error code.
  */
-static int __pm_generic_resume(struct device *dev, int event)
+static int __pm_generic_resume(struct device *dev, int event, bool noirq)
 {
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int (*callback)(struct device *);
@@ -188,10 +230,10 @@ static int __pm_generic_resume(struct de
 
 	switch (event) {
 	case PM_EVENT_RESUME:
-		callback = pm->resume;
+		callback = noirq ? pm->resume_noirq : pm->resume;
 		break;
 	case PM_EVENT_RESTORE:
-		callback = pm->restore;
+		callback = noirq ? pm->restore_noirq : pm->restore;
 		break;
 	default:
 		callback = NULL;
@@ -212,22 +254,42 @@ static int __pm_generic_resume(struct de
 }
 
 /**
+ * pm_generic_resume_noirq - Generic resume_noirq callback for subsystems.
+ * @dev: Device to resume.
+ */
+int pm_generic_resume_noirq(struct device *dev)
+{
+	return __pm_generic_resume(dev, PM_EVENT_RESUME, true);
+}
+EXPORT_SYMBOL_GPL(pm_generic_resume_noirq);
+
+/**
  * pm_generic_resume - Generic resume callback for subsystems.
  * @dev: Device to resume.
  */
 int pm_generic_resume(struct device *dev)
 {
-	return __pm_generic_resume(dev, PM_EVENT_RESUME);
+	return __pm_generic_resume(dev, PM_EVENT_RESUME, false);
 }
 EXPORT_SYMBOL_GPL(pm_generic_resume);
 
 /**
+ * pm_generic_restore_noirq - Generic restore_noirq callback for subsystems.
+ * @dev: Device to restore.
+ */
+int pm_generic_restore_noirq(struct device *dev)
+{
+	return __pm_generic_resume(dev, PM_EVENT_RESTORE, true);
+}
+EXPORT_SYMBOL_GPL(pm_generic_restore_noirq);
+
+/**
  * pm_generic_restore - Generic restore callback for subsystems.
  * @dev: Device to restore.
  */
 int pm_generic_restore(struct device *dev)
 {
-	return __pm_generic_resume(dev, PM_EVENT_RESTORE);
+	return __pm_generic_resume(dev, PM_EVENT_RESTORE, false);
 }
 EXPORT_SYMBOL_GPL(pm_generic_restore);
 
Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -553,11 +553,17 @@ extern void __suspend_report_result(cons
 extern int device_pm_wait_for_dev(struct device *sub, struct device *dev);
 
 extern int pm_generic_prepare(struct device *dev);
+extern int pm_generic_suspend_noirq(struct device *dev);
 extern int pm_generic_suspend(struct device *dev);
+extern int pm_generic_resume_noirq(struct device *dev);
 extern int pm_generic_resume(struct device *dev);
+extern int pm_generic_freeze_noirq(struct device *dev);
 extern int pm_generic_freeze(struct device *dev);
+extern int pm_generic_thaw_noirq(struct device *dev);
 extern int pm_generic_thaw(struct device *dev);
+extern int pm_generic_restore_noirq(struct device *dev);
 extern int pm_generic_restore(struct device *dev);
+extern int pm_generic_poweroff_noirq(struct device *dev);
 extern int pm_generic_poweroff(struct device *dev);
 extern void pm_generic_complete(struct device *dev);
 
