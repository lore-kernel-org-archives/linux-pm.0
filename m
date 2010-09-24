From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 3/7] PM: replace boolean arguments with bitflags
Date: Fri, 24 Sep 2010 16:39:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009241635420.1287-100000@iolanthe.rowland.org>
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

The "from_wq" argument in __pm_runtime_suspend() and
__pm_runtime_resume() supposedly indicates whether or not the function
was called by the PM workqueue thread, but in fact it isn't always
used this way.  It really indicates whether or not the function should
return early if the requested operation is already in progress.

Along with this badly-named boolean argument, later patches in this
series will add several other boolean arguments to these functions and
others.  Therefore this patch (as1422) begins the conversion process
by replacing from_wq with a bitflag argument.  The same bitflags are
also used in __pm_runtime_get() and __pm_runtime_put(), where they
indicate whether or not the operation should be asynchronous.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/include/linux/pm_runtime.h
===================================================================
--- usb-2.6.orig/include/linux/pm_runtime.h
+++ usb-2.6/include/linux/pm_runtime.h
@@ -12,6 +12,11 @@
 #include <linux/device.h>
 #include <linux/pm.h>
 
+/* Runtime PM flag argument bits */
+#define RPM_ASYNC		0x01	/* Request is asynchronous */
+#define RPM_NOWAIT		0x02	/* Don't wait for concurrent
+					    state change */
+
 #ifdef CONFIG_PM_RUNTIME
 
 extern struct workqueue_struct *pm_wq;
@@ -22,8 +27,8 @@ extern int pm_runtime_resume(struct devi
 extern int pm_request_idle(struct device *dev);
 extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
 extern int pm_request_resume(struct device *dev);
-extern int __pm_runtime_get(struct device *dev, bool sync);
-extern int __pm_runtime_put(struct device *dev, bool sync);
+extern int __pm_runtime_get(struct device *dev, int rpmflags);
+extern int __pm_runtime_put(struct device *dev, int rpmflags);
 extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
 extern int pm_runtime_barrier(struct device *dev);
 extern void pm_runtime_enable(struct device *dev);
@@ -81,8 +86,10 @@ static inline int pm_schedule_suspend(st
 	return -ENOSYS;
 }
 static inline int pm_request_resume(struct device *dev) { return 0; }
-static inline int __pm_runtime_get(struct device *dev, bool sync) { return 1; }
-static inline int __pm_runtime_put(struct device *dev, bool sync) { return 0; }
+static inline int __pm_runtime_get(struct device *dev, int rpmflags)
+					{ return 1; }
+static inline int __pm_runtime_put(struct device *dev, int rpmflags)
+					{ return 0; }
 static inline int __pm_runtime_set_status(struct device *dev,
 					    unsigned int status) { return 0; }
 static inline int pm_runtime_barrier(struct device *dev) { return 0; }
@@ -107,22 +114,22 @@ static inline int pm_generic_runtime_res
 
 static inline int pm_runtime_get(struct device *dev)
 {
-	return __pm_runtime_get(dev, false);
+	return __pm_runtime_get(dev, RPM_ASYNC);
 }
 
 static inline int pm_runtime_get_sync(struct device *dev)
 {
-	return __pm_runtime_get(dev, true);
+	return __pm_runtime_get(dev, 0);
 }
 
 static inline int pm_runtime_put(struct device *dev)
 {
-	return __pm_runtime_put(dev, false);
+	return __pm_runtime_put(dev, RPM_ASYNC);
 }
 
 static inline int pm_runtime_put_sync(struct device *dev)
 {
-	return __pm_runtime_put(dev, true);
+	return __pm_runtime_put(dev, 0);
 }
 
 static inline int pm_runtime_set_active(struct device *dev)
Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -10,7 +10,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/jiffies.h>
 
-static int __pm_runtime_resume(struct device *dev, bool from_wq);
+static int __pm_runtime_resume(struct device *dev, int rpmflags);
 static int __pm_request_idle(struct device *dev);
 static int __pm_request_resume(struct device *dev);
 
@@ -164,24 +164,24 @@ EXPORT_SYMBOL_GPL(pm_runtime_idle);
 /**
  * __pm_runtime_suspend - Carry out run-time suspend of given device.
  * @dev: Device to suspend.
- * @from_wq: If set, the function has been called via pm_wq.
+ * @rpmflags: Flag bits.
  *
  * Check if the device can be suspended and run the ->runtime_suspend() callback
- * provided by its bus type.  If another suspend has been started earlier, wait
- * for it to finish.  If an idle notification or suspend request is pending or
+ * provided by its bus type.  If another suspend has been started earlier,
+ * either return immediately or wait for it to finish, depending on the
+ * RPM_NOWAIT flag.  If an idle notification or suspend request is pending or
  * scheduled, cancel it.
  *
  * This function must be called under dev->power.lock with interrupts disabled.
  */
-int __pm_runtime_suspend(struct device *dev, bool from_wq)
+static int __pm_runtime_suspend(struct device *dev, int rpmflags)
 	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
 	struct device *parent = NULL;
 	bool notify = false;
 	int retval = 0;
 
-	dev_dbg(dev, "__pm_runtime_suspend()%s!\n",
-		from_wq ? " from workqueue" : "");
+	dev_dbg(dev, "%s flags 0x%x\n", __func__, rpmflags);
 
  repeat:
 	if (dev->power.runtime_error) {
@@ -213,7 +213,7 @@ int __pm_runtime_suspend(struct device *
 	if (dev->power.runtime_status == RPM_SUSPENDING) {
 		DEFINE_WAIT(wait);
 
-		if (from_wq) {
+		if (rpmflags & RPM_NOWAIT) {
 			retval = -EINPROGRESS;
 			goto out;
 		}
@@ -286,7 +286,7 @@ int __pm_runtime_suspend(struct device *
 	wake_up_all(&dev->power.wait_queue);
 
 	if (dev->power.deferred_resume) {
-		__pm_runtime_resume(dev, false);
+		__pm_runtime_resume(dev, 0);
 		retval = -EAGAIN;
 		goto out;
 	}
@@ -303,7 +303,7 @@ int __pm_runtime_suspend(struct device *
 	}
 
  out:
-	dev_dbg(dev, "__pm_runtime_suspend() returns %d!\n", retval);
+	dev_dbg(dev, "%s returns %d\n", __func__, retval);
 
 	return retval;
 }
@@ -317,7 +317,7 @@ int pm_runtime_suspend(struct device *de
 	int retval;
 
 	spin_lock_irq(&dev->power.lock);
-	retval = __pm_runtime_suspend(dev, false);
+	retval = __pm_runtime_suspend(dev, 0);
 	spin_unlock_irq(&dev->power.lock);
 
 	return retval;
@@ -327,24 +327,25 @@ EXPORT_SYMBOL_GPL(pm_runtime_suspend);
 /**
  * __pm_runtime_resume - Carry out run-time resume of given device.
  * @dev: Device to resume.
- * @from_wq: If set, the function has been called via pm_wq.
+ * @rpmflags: Flag bits.
  *
  * Check if the device can be woken up and run the ->runtime_resume() callback
- * provided by its bus type.  If another resume has been started earlier, wait
- * for it to finish.  If there's a suspend running in parallel with this
- * function, wait for it to finish and resume the device.  Cancel any scheduled
- * or pending requests.
+ * provided by its bus type.  If another resume has been started earlier,
+ * either return imediately or wait for it to finish, depending on the
+ * RPM_NOWAIT flag.  If there's a suspend running in parallel with this
+ * function, either tell the other process to resume after suspending
+ * (deferred_resume) or wait for it to finish, depending on the RPM_NOWAIT
+ * flag.  Cancel any scheduled or pending requests.
  *
  * This function must be called under dev->power.lock with interrupts disabled.
  */
-int __pm_runtime_resume(struct device *dev, bool from_wq)
+static int __pm_runtime_resume(struct device *dev, int rpmflags)
 	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
 	struct device *parent = NULL;
 	int retval = 0;
 
-	dev_dbg(dev, "__pm_runtime_resume()%s!\n",
-		from_wq ? " from workqueue" : "");
+	dev_dbg(dev, "%s flags 0x%x\n", __func__, rpmflags);
 
  repeat:
 	if (dev->power.runtime_error) {
@@ -365,7 +366,7 @@ int __pm_runtime_resume(struct device *d
 	    || dev->power.runtime_status == RPM_SUSPENDING) {
 		DEFINE_WAIT(wait);
 
-		if (from_wq) {
+		if (rpmflags & RPM_NOWAIT) {
 			if (dev->power.runtime_status == RPM_SUSPENDING)
 				dev->power.deferred_resume = true;
 			retval = -EINPROGRESS;
@@ -407,7 +408,7 @@ int __pm_runtime_resume(struct device *d
 		 */
 		if (!parent->power.disable_depth
 		    && !parent->power.ignore_children) {
-			__pm_runtime_resume(parent, false);
+			__pm_runtime_resume(parent, 0);
 			if (parent->power.runtime_status != RPM_ACTIVE)
 				retval = -EBUSY;
 		}
@@ -470,7 +471,7 @@ int __pm_runtime_resume(struct device *d
 		spin_lock_irq(&dev->power.lock);
 	}
 
-	dev_dbg(dev, "__pm_runtime_resume() returns %d!\n", retval);
+	dev_dbg(dev, "%s returns %d\n", __func__, retval);
 
 	return retval;
 }
@@ -484,7 +485,7 @@ int pm_runtime_resume(struct device *dev
 	int retval;
 
 	spin_lock_irq(&dev->power.lock);
-	retval = __pm_runtime_resume(dev, false);
+	retval = __pm_runtime_resume(dev, 0);
 	spin_unlock_irq(&dev->power.lock);
 
 	return retval;
@@ -519,10 +520,10 @@ static void pm_runtime_work(struct work_
 		__pm_runtime_idle(dev);
 		break;
 	case RPM_REQ_SUSPEND:
-		__pm_runtime_suspend(dev, true);
+		__pm_runtime_suspend(dev, RPM_NOWAIT);
 		break;
 	case RPM_REQ_RESUME:
-		__pm_runtime_resume(dev, true);
+		__pm_runtime_resume(dev, RPM_NOWAIT);
 		break;
 	}
 
@@ -782,17 +783,18 @@ EXPORT_SYMBOL_GPL(pm_request_resume);
 /**
  * __pm_runtime_get - Reference count a device and wake it up, if necessary.
  * @dev: Device to handle.
- * @sync: If set and the device is suspended, resume it synchronously.
+ * @rpmflags: Flag bits.
  *
  * Increment the usage count of the device and resume it or submit a resume
- * request for it, depending on the value of @sync.
+ * request for it, depending on the RPM_ASYNC flag bit.
  */
-int __pm_runtime_get(struct device *dev, bool sync)
+int __pm_runtime_get(struct device *dev, int rpmflags)
 {
 	int retval;
 
 	atomic_inc(&dev->power.usage_count);
-	retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);
+	retval = (rpmflags & RPM_ASYNC) ?
+	    pm_request_resume(dev) : pm_runtime_resume(dev);
 
 	return retval;
 }
@@ -801,18 +803,19 @@ EXPORT_SYMBOL_GPL(__pm_runtime_get);
 /**
  * __pm_runtime_put - Decrement the device's usage counter and notify its bus.
  * @dev: Device to handle.
- * @sync: If the device's bus type is to be notified, do that synchronously.
+ * @rpmflags: Flag bits.
  *
  * Decrement the usage count of the device and if it reaches zero, carry out a
  * synchronous idle notification or submit an idle notification request for it,
- * depending on the value of @sync.
+ * depending on the RPM_ASYNC flag bit.
  */
-int __pm_runtime_put(struct device *dev, bool sync)
+int __pm_runtime_put(struct device *dev, int rpmflags)
 {
 	int retval = 0;
 
 	if (atomic_dec_and_test(&dev->power.usage_count))
-		retval = sync ? pm_runtime_idle(dev) : pm_request_idle(dev);
+		retval = (rpmflags & RPM_ASYNC) ?
+		    pm_request_idle(dev) : pm_runtime_idle(dev);
 
 	return retval;
 }
@@ -967,7 +970,7 @@ int pm_runtime_barrier(struct device *de
 
 	if (dev->power.request_pending
 	    && dev->power.request == RPM_REQ_RESUME) {
-		__pm_runtime_resume(dev, false);
+		__pm_runtime_resume(dev, 0);
 		retval = 1;
 	}
 
@@ -1016,7 +1019,7 @@ void __pm_runtime_disable(struct device 
 		 */
 		pm_runtime_get_noresume(dev);
 
-		__pm_runtime_resume(dev, false);
+		__pm_runtime_resume(dev, 0);
 
 		pm_runtime_put_noidle(dev);
 	}
@@ -1064,7 +1067,7 @@ void pm_runtime_forbid(struct device *de
 
 	dev->power.runtime_auto = false;
 	atomic_inc(&dev->power.usage_count);
-	__pm_runtime_resume(dev, false);
+	__pm_runtime_resume(dev, 0);
 
  out:
 	spin_unlock_irq(&dev->power.lock);
