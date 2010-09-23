From: Alan Stern <stern@rowland.harvard.edu>
Subject: [RFC 5/7] PM: combine runtime PM entry points
Date: Thu, 23 Sep 2010 17:23:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009231719570.1667-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1424) combines the various public entry points for the
runtime PM routines into three simple functions: one for idle, one for
suspend, and one for resume.  A new bitflag specifies whether or not
to increment or decrement the usage_count field.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/include/linux/pm_runtime.h
===================================================================
--- usb-2.6.orig/include/linux/pm_runtime.h
+++ usb-2.6/include/linux/pm_runtime.h
@@ -16,19 +16,17 @@
 #define RPM_ASYNC			0x01	/* Request is asynchronous */
 #define RPM_RETURN_IF_IN_PROGRESS	0x02	/* Don't wait for concurrent
 						    state change */
+#define RPM_GET_PUT			0x04	/* Increment/decrement the
+						    usage_count */
 
 #ifdef CONFIG_PM_RUNTIME
 
 extern struct workqueue_struct *pm_wq;
 
-extern int pm_runtime_idle(struct device *dev);
-extern int pm_runtime_suspend(struct device *dev);
-extern int pm_runtime_resume(struct device *dev);
-extern int pm_request_idle(struct device *dev);
+extern int pm_runtime_idle_entry(struct device *dev, int rpmflags);
+extern int pm_runtime_suspend_entry(struct device *dev, int rpmflags);
+extern int pm_runtime_resume_entry(struct device *dev, int rpmflags);
 extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
-extern int pm_request_resume(struct device *dev);
-extern int __pm_runtime_get(struct device *dev, int rpmflags);
-extern int __pm_runtime_put(struct device *dev, int rpmflags);
 extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
 extern int pm_runtime_barrier(struct device *dev);
 extern void pm_runtime_enable(struct device *dev);
@@ -77,19 +75,22 @@ static inline bool pm_runtime_suspended(
 
 #else /* !CONFIG_PM_RUNTIME */
 
-static inline int pm_runtime_idle(struct device *dev) { return -ENOSYS; }
-static inline int pm_runtime_suspend(struct device *dev) { return -ENOSYS; }
-static inline int pm_runtime_resume(struct device *dev) { return 0; }
-static inline int pm_request_idle(struct device *dev) { return -ENOSYS; }
+static inline int pm_runtime_idle_entry(struct device *dev, int rpmflags)
+{
+	return -ENOSYS;
+}
+static inline int pm_runtime_suspend_entry(struct device *dev, int rpmflags)
+{
+	return -ENOSYS;
+}
+static inline int pm_runtime_resume_entry(struct device *dev, int rpmflags)
+{
+	return 1;
+}
 static inline int pm_schedule_suspend(struct device *dev, unsigned int delay)
 {
 	return -ENOSYS;
 }
-static inline int pm_request_resume(struct device *dev) { return 0; }
-static inline int __pm_runtime_get(struct device *dev, int rpmflags)
-					{ return 1; }
-static inline int __pm_runtime_put(struct device *dev, int rpmflags)
-					{ return 0; }
 static inline int __pm_runtime_set_status(struct device *dev,
 					    unsigned int status) { return 0; }
 static inline int pm_runtime_barrier(struct device *dev) { return 0; }
@@ -112,24 +113,49 @@ static inline int pm_generic_runtime_res
 
 #endif /* !CONFIG_PM_RUNTIME */
 
+static inline int pm_runtime_idle(struct device *dev)
+{
+	return pm_runtime_idle_entry(dev, 0);
+}
+
+static inline int pm_runtime_suspend(struct device *dev)
+{
+	return pm_runtime_suspend_entry(dev, 0);
+}
+
+static inline int pm_runtime_resume(struct device *dev)
+{
+	return pm_runtime_resume_entry(dev, 0);
+}
+
+static inline int pm_request_idle(struct device *dev)
+{
+	return pm_runtime_idle_entry(dev, RPM_ASYNC);
+}
+
+static inline int pm_request_resume(struct device *dev)
+{
+	return pm_runtime_resume_entry(dev, RPM_ASYNC);
+}
+
 static inline int pm_runtime_get(struct device *dev)
 {
-	return __pm_runtime_get(dev, RPM_ASYNC);
+	return pm_runtime_resume_entry(dev, RPM_GET_PUT | RPM_ASYNC);
 }
 
 static inline int pm_runtime_get_sync(struct device *dev)
 {
-	return __pm_runtime_get(dev, 0);
+	return pm_runtime_resume_entry(dev, RPM_GET_PUT);
 }
 
 static inline int pm_runtime_put(struct device *dev)
 {
-	return __pm_runtime_put(dev, RPM_ASYNC);
+	return pm_runtime_idle_entry(dev, RPM_GET_PUT | RPM_ASYNC);
 }
 
 static inline int pm_runtime_put_sync(struct device *dev)
 {
-	return __pm_runtime_put(dev, 0);
+	return pm_runtime_idle_entry(dev, RPM_GET_PUT);
 }
 
 static inline int pm_runtime_set_active(struct device *dev)
Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -189,22 +189,6 @@ static int __pm_runtime_idle(struct devi
 }
 
 /**
- * pm_runtime_idle - Notify device bus type if the device can be suspended.
- * @dev: Device to notify the bus type about.
- */
-int pm_runtime_idle(struct device *dev)
-{
-	int retval;
-
-	spin_lock_irq(&dev->power.lock);
-	retval = __pm_runtime_idle(dev, 0);
-	spin_unlock_irq(&dev->power.lock);
-
-	return retval;
-}
-EXPORT_SYMBOL_GPL(pm_runtime_idle);
-
-/**
  * __pm_runtime_suspend - Carry out run-time suspend of given device.
  * @dev: Device to suspend.
  * @rpmflags: Flag bits.
@@ -355,22 +339,6 @@ static int __pm_runtime_suspend(struct d
 }
 
 /**
- * pm_runtime_suspend - Carry out run-time suspend of given device.
- * @dev: Device to suspend.
- */
-int pm_runtime_suspend(struct device *dev)
-{
-	int retval;
-
-	spin_lock_irq(&dev->power.lock);
-	retval = __pm_runtime_suspend(dev, 0);
-	spin_unlock_irq(&dev->power.lock);
-
-	return retval;
-}
-EXPORT_SYMBOL_GPL(pm_runtime_suspend);
-
-/**
  * __pm_runtime_resume - Carry out run-time resume of given device.
  * @dev: Device to resume.
  * @rpmflags: Flag bits.
@@ -538,22 +506,6 @@ static int __pm_runtime_resume(struct de
 }
 
 /**
- * pm_runtime_resume - Carry out run-time resume of given device.
- * @dev: Device to suspend.
- */
-int pm_runtime_resume(struct device *dev)
-{
-	int retval;
-
-	spin_lock_irq(&dev->power.lock);
-	retval = __pm_runtime_resume(dev, 0);
-	spin_unlock_irq(&dev->power.lock);
-
-	return retval;
-}
-EXPORT_SYMBOL_GPL(pm_runtime_resume);
-
-/**
  * pm_runtime_work - Universal run-time PM work function.
  * @work: Work structure used for scheduling the execution of this function.
  *
@@ -593,23 +545,6 @@ static void pm_runtime_work(struct work_
 }
 
 /**
- * pm_request_idle - Submit an idle notification request for given device.
- * @dev: Device to handle.
- */
-int pm_request_idle(struct device *dev)
-{
-	unsigned long flags;
-	int retval;
-
-	spin_lock_irqsave(&dev->power.lock, flags);
-	retval = __pm_runtime_idle(dev, RPM_ASYNC);
-	spin_unlock_irqrestore(&dev->power.lock, flags);
-
-	return retval;
-}
-EXPORT_SYMBOL_GPL(pm_request_idle);
-
-/**
  * pm_suspend_timer_fn - Timer function for pm_schedule_suspend().
  * @data: Device pointer passed by pm_schedule_suspend().
  *
@@ -669,62 +604,81 @@ int pm_schedule_suspend(struct device *d
 EXPORT_SYMBOL_GPL(pm_schedule_suspend);
 
 /**
- * pm_request_resume - Submit a resume request for given device.
- * @dev: Device to resume.
+ * pm_runtime_idle_entry - Entry point for run-time idle operations.
+ * @dev: Device to send idle notification for.
+ * @rpmflags: Flag bits.
+ *
+ * If the RPM_GET_PUT flag is set, decrement the device's usage count and
+ * return immediately if it is larger than zero.  Then carry out an idle
+ * notification, either synchronous or asynchronous.
+ *
+ * This routine may be called in atomic context if the RPM_ASYNC flag is set.
  */
-int pm_request_resume(struct device *dev)
+int pm_runtime_idle_entry(struct device *dev, int rpmflags)
 {
 	unsigned long flags;
 	int retval;
 
+	if (rpmflags & RPM_GET_PUT) {
+		if (!atomic_dec_and_test(&dev->power.usage_count))
+			return 0;
+	}
+
 	spin_lock_irqsave(&dev->power.lock, flags);
-	retval = __pm_runtime_resume(dev, RPM_ASYNC);
+	retval = __pm_runtime_idle(dev, rpmflags);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	return retval;
 }
-EXPORT_SYMBOL_GPL(pm_request_resume);
+EXPORT_SYMBOL_GPL(pm_runtime_idle_entry);
 
 /**
- * __pm_runtime_get - Reference count a device and wake it up, if necessary.
- * @dev: Device to handle.
+ * pm_runtime_suspend_entry - Entry point for run-time put/suspend operations.
+ * @dev: Device to suspend.
  * @rpmflags: Flag bits.
  *
- * Increment the usage count of the device and resume it or submit a resume
- * request for it, depending on the RPM_ASYNC flag bit.
+ * Carry out a suspend, either synchronous or asynchronous.
+ *
+ * This routine may be called in atomic context if the RPM_ASYNC flag is set.
  */
-int __pm_runtime_get(struct device *dev, int rpmflags)
+int pm_runtime_suspend_entry(struct device *dev, int rpmflags)
 {
+	unsigned long flags;
 	int retval;
 
-	atomic_inc(&dev->power.usage_count);
-	retval = (rpmflags & RPM_ASYNC ? pm_runtime_resume(dev)
-	    : pm_request_resume(dev));
+	spin_lock_irqsave(&dev->power.lock, flags);
+	retval = __pm_runtime_suspend(dev, rpmflags);
+	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	return retval;
 }
-EXPORT_SYMBOL_GPL(__pm_runtime_get);
+EXPORT_SYMBOL_GPL(pm_runtime_suspend_entry);
 
 /**
- * __pm_runtime_put - Decrement the device's usage counter and notify its bus.
- * @dev: Device to handle.
+ * pm_runtime_resume_entry - Entry point for run-time resume operations.
+ * @dev: Device to resume.
  * @rpmflags: Flag bits.
  *
- * Decrement the usage count of the device and if it reaches zero, carry out a
- * synchronous idle notification or submit an idle notification request for it,
- * depending on the RPM_ASYNC flag bit.
+ * If the RPM_GET_PUT flag is set, increment the device's usage count.  Then
+ * carry out a resume, either synchronous or asynchronous.
+ *
+ * This routine may be called in atomic context if the RPM_ASYNC flag is set.
  */
-int __pm_runtime_put(struct device *dev, int rpmflags)
+int pm_runtime_resume_entry(struct device *dev, int rpmflags)
 {
-	int retval = 0;
+	unsigned long flags;
+	int retval;
 
-	if (atomic_dec_and_test(&dev->power.usage_count))
-		retval = (rpmflags & RPM_ASYNC ? pm_runtime_idle(dev)
-		    : pm_request_idle(dev));
+	if (rpmflags & RPM_GET_PUT)
+		atomic_inc(&dev->power.usage_count);
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+	retval = __pm_runtime_resume(dev, rpmflags);
+	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	return retval;
 }
-EXPORT_SYMBOL_GPL(__pm_runtime_put);
+EXPORT_SYMBOL_GPL(pm_runtime_resume_entry);
 
 /**
  * __pm_runtime_set_status - Set run-time PM status of a device.
