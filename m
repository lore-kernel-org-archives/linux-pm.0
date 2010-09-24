From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 7/7] PM: implement autosuspend
Date: Fri, 24 Sep 2010 16:39:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009241637130.1287-100000@iolanthe.rowland.org>
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

This patch (as1427) implements the "autosuspend" facility for runtime
PM.  A few new fields are added to the dev_pm_info structure and
several new PM helper functions are defined, for telling the PM core
whether or not a device uses autosuspend, for setting the autosuspend
delay, and for marking periods of device activity.

Drivers that do not want to use autosuspend can continue using the
same helper functions as before; their behavior will not change.  In
addition, drivers supporting autosuspend can also call the old helper
functions to get the old behavior.

The details are all explained in Documentation/power/runtime_pm.txt
and Documentation/ABI/testing/sysfs-devices-power.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/include/linux/pm.h
===================================================================
--- usb-2.6.orig/include/linux/pm.h
+++ usb-2.6/include/linux/pm.h
@@ -444,6 +444,9 @@ enum rpm_status {
  *
  * RPM_REQ_SUSPEND	Run the device bus type's ->runtime_suspend() callback
  *
+ * RPM_REQ_AUTOSUSPEND	Same as RPM_REQ_SUSPEND, but not until the device has
+ *			been inactive for as long as power.autosuspend_delay
+ *
  * RPM_REQ_RESUME	Run the device bus type's ->runtime_resume() callback
  */
 
@@ -451,6 +454,7 @@ enum rpm_request {
 	RPM_REQ_NONE = 0,
 	RPM_REQ_IDLE,
 	RPM_REQ_SUSPEND,
+	RPM_REQ_AUTOSUSPEND,
 	RPM_REQ_RESUME,
 };
 
@@ -481,9 +485,13 @@ struct dev_pm_info {
 	unsigned int		run_wake:1;
 	unsigned int		runtime_auto:1;
 	unsigned int		no_callbacks:1;
+	unsigned int		use_autosuspend:1;
+	unsigned int		timer_autosuspends:1;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
 	int			runtime_error;
+	int			autosuspend_delay;
+	unsigned long		last_busy;
 	unsigned long		active_jiffies;
 	unsigned long		suspended_jiffies;
 	unsigned long		accounting_timestamp;
Index: usb-2.6/include/linux/pm_runtime.h
===================================================================
--- usb-2.6.orig/include/linux/pm_runtime.h
+++ usb-2.6/include/linux/pm_runtime.h
@@ -12,12 +12,15 @@
 #include <linux/device.h>
 #include <linux/pm.h>
 
+#include <linux/jiffies.h>
+
 /* Runtime PM flag argument bits */
 #define RPM_ASYNC		0x01	/* Request is asynchronous */
 #define RPM_NOWAIT		0x02	/* Don't wait for concurrent
 					    state change */
 #define RPM_GET_PUT		0x04	/* Increment/decrement the
 					    usage_count */
+#define RPM_AUTO		0x08	/* Use autosuspend_delay */
 
 #ifdef CONFIG_PM_RUNTIME
 
@@ -37,6 +40,9 @@ extern int pm_generic_runtime_idle(struc
 extern int pm_generic_runtime_suspend(struct device *dev);
 extern int pm_generic_runtime_resume(struct device *dev);
 extern void pm_runtime_no_callbacks(struct device *dev);
+extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
+extern void pm_runtime_set_autosuspend_delay(struct device *dev, int delay);
+extern unsigned long pm_runtime_autosuspend_expiration(struct device *dev);
 
 static inline bool pm_children_suspended(struct device *dev)
 {
@@ -74,6 +80,11 @@ static inline bool pm_runtime_suspended(
 	return dev->power.runtime_status == RPM_SUSPENDED;
 }
 
+static inline void pm_runtime_mark_last_busy(struct device *dev)
+{
+	ACCESS_ONCE(dev->power.last_busy) = jiffies;
+}
+
 #else /* !CONFIG_PM_RUNTIME */
 
 static inline int __pm_runtime_idle(struct device *dev, int rpmflags)
@@ -113,6 +124,14 @@ static inline int pm_generic_runtime_sus
 static inline int pm_generic_runtime_resume(struct device *dev) { return 0; }
 static inline void pm_runtime_no_callbacks(struct device *dev) {}
 
+static inline void pm_runtime_mark_last_busy(struct device *dev) {}
+static inline void __pm_runtime_use_autosuspend(struct device *dev,
+						bool use) {}
+static inline void pm_runtime_set_autosuspend_delay(struct device *dev,
+						int delay) {}
+static inline unsigned long pm_runtime_autosuspend_expiration(
+				struct device *dev) { return 0; }
+
 #endif /* !CONFIG_PM_RUNTIME */
 
 static inline int pm_runtime_idle(struct device *dev)
@@ -125,6 +144,11 @@ static inline int pm_runtime_suspend(str
 	return __pm_runtime_suspend(dev, 0);
 }
 
+static inline int pm_runtime_autosuspend(struct device *dev)
+{
+	return __pm_runtime_suspend(dev, RPM_AUTO);
+}
+
 static inline int pm_runtime_resume(struct device *dev)
 {
 	return __pm_runtime_resume(dev, 0);
@@ -155,11 +179,22 @@ static inline int pm_runtime_put(struct 
 	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
 }
 
+static inline int pm_runtime_put_autosuspend(struct device *dev)
+{
+	return __pm_runtime_suspend(dev,
+	    RPM_GET_PUT | RPM_ASYNC | RPM_AUTO);
+}
+
 static inline int pm_runtime_put_sync(struct device *dev)
 {
 	return __pm_runtime_idle(dev, RPM_GET_PUT);
 }
 
+static inline int pm_runtime_put_sync_autosuspend(struct device *dev)
+{
+	return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_AUTO);
+}
+
 static inline int pm_runtime_set_active(struct device *dev)
 {
 	return __pm_runtime_set_status(dev, RPM_ACTIVE);
@@ -175,4 +210,14 @@ static inline void pm_runtime_disable(st
 	__pm_runtime_disable(dev, true);
 }
 
+static inline void pm_runtime_use_autosuspend(struct device *dev)
+{
+	__pm_runtime_use_autosuspend(dev, true);
+}
+
+static inline void pm_runtime_dont_use_autosuspend(struct device *dev)
+{
+	__pm_runtime_use_autosuspend(dev, false);
+}
+
 #endif
Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -9,7 +9,6 @@
 
 #include <linux/sched.h>
 #include <linux/pm_runtime.h>
-#include <linux/jiffies.h>
 #include "power.h"
 
 static int rpm_resume(struct device *dev, int rpmflags);
@@ -79,6 +78,53 @@ static void pm_runtime_cancel_pending(st
 	dev->power.request = RPM_REQ_NONE;
 }
 
+/*
+ * pm_runtime_autosuspend_expiration - Get a device's autosuspend-delay expiration time.
+ * @dev: Device to handle.
+ *
+ * Compute the autosuspend-delay expiration time based on the device's
+ * power.last_busy time.  If the delay has already expired or is disabled
+ * (negative) or the power.use_autosuspend flag isn't set, return 0.
+ * Otherwise return the expiration time in jiffies (adjusted to be nonzero).
+ *
+ * This function may be called either with or without dev->power.lock held.
+ * Either way it can be racy, since power.last_busy may be updated at any time.
+ */
+unsigned long pm_runtime_autosuspend_expiration(struct device *dev)
+{
+	int autosuspend_delay;
+	long elapsed;
+	unsigned long last_busy;
+	unsigned long expires = 0;
+
+	if (!dev->power.use_autosuspend)
+		goto out;
+
+	autosuspend_delay = ACCESS_ONCE(dev->power.autosuspend_delay);
+	if (autosuspend_delay < 0)
+		goto out;
+
+	last_busy = ACCESS_ONCE(dev->power.last_busy);
+	elapsed = jiffies - last_busy;
+	if (elapsed < 0)
+		goto out;	/* jiffies has wrapped around. */
+
+	/*
+	 * If the autosuspend_delay is >= 1 second, align the timer by rounding
+	 * up to the nearest second.
+	 */
+	expires = last_busy + msecs_to_jiffies(autosuspend_delay);
+	if (autosuspend_delay >= 1000)
+		expires = round_jiffies(expires);
+	expires += !expires;
+	if (elapsed >= expires - last_busy)
+		expires = 0;	/* Already expired. */
+
+ out:
+	return expires;
+}
+EXPORT_SYMBOL_GPL(pm_runtime_autosuspend_expiration);
+
 /**
  * rpm_check_suspend_allowed - Test whether a device may be suspended.
  * @dev: Device to test.
@@ -234,6 +280,32 @@ static int rpm_suspend(struct device *de
 	if (retval)
 		goto out;
 
+	/* If the autosuspend_delay time hasn't expired yet, reschedule. */
+	if ((rpmflags & RPM_AUTO)
+	    && dev->power.runtime_status != RPM_SUSPENDING) {
+		unsigned long expires = pm_runtime_autosuspend_expiration(dev);
+
+		if (expires != 0) {
+			/* Pending requests need to be canceled. */
+			dev->power.request = RPM_REQ_NONE;
+
+			/*
+			 * Optimization: If the timer is already running and is
+			 * set to expire at or before the autosuspend delay,
+			 * avoid the overhead of resetting it.  Just let it
+			 * expire; pm_suspend_timer_fn() will take care of the
+			 * rest.
+			 */
+			if (!(dev->power.timer_expires && time_before_eq(
+			    dev->power.timer_expires, expires))) {
+				dev->power.timer_expires = expires;
+				mod_timer(&dev->power.suspend_timer, expires);
+			}
+			dev->power.timer_autosuspends = 1;
+			goto out;
+		}
+	}
+
 	/* Other scheduled or pending requests need to be canceled. */
 	pm_runtime_cancel_pending(dev);
 
@@ -268,7 +340,8 @@ static int rpm_suspend(struct device *de
 
 	/* Carry out an asynchronous or a synchronous suspend. */
 	if (rpmflags & RPM_ASYNC) {
-		dev->power.request = RPM_REQ_SUSPEND;
+		dev->power.request = (rpmflags & RPM_AUTO) ?
+		    RPM_REQ_AUTOSUSPEND : RPM_REQ_SUSPEND;
 		if (!dev->power.request_pending) {
 			dev->power.request_pending = true;
 			queue_work(pm_wq, &dev->power.work);
@@ -383,8 +456,15 @@ static int rpm_resume(struct device *dev
 	if (retval)
 		goto out;
 
-	/* Other scheduled or pending requests need to be canceled. */
-	pm_runtime_cancel_pending(dev);
+	/*
+	 * Other scheduled or pending requests need to be canceled.  Small
+	 * optimization: If an autosuspend timer is running, leave it running
+	 * rather than cancelling it now only to restart it again in the near
+	 * future.
+	 */
+	dev->power.request = RPM_REQ_NONE;
+	if (!dev->power.timer_autosuspends)
+		pm_runtime_deactivate_timer(dev);
 
 	if (dev->power.runtime_status == RPM_ACTIVE) {
 		retval = 1;
@@ -568,6 +648,9 @@ static void pm_runtime_work(struct work_
 	case RPM_REQ_SUSPEND:
 		rpm_suspend(dev, RPM_NOWAIT);
 		break;
+	case RPM_REQ_AUTOSUSPEND:
+		rpm_suspend(dev, RPM_NOWAIT | RPM_AUTO);
+		break;
 	case RPM_REQ_RESUME:
 		rpm_resume(dev, RPM_NOWAIT);
 		break;
@@ -595,7 +678,8 @@ static void pm_suspend_timer_fn(unsigned
 	/* If 'expire' is after 'jiffies' we've been called too early. */
 	if (expires > 0 && !time_after(expires, jiffies)) {
 		dev->power.timer_expires = 0;
-		rpm_suspend(dev, RPM_ASYNC);
+		rpm_suspend(dev, dev->power.timer_autosuspends ?
+		    (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
 	}
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
@@ -627,6 +711,7 @@ int pm_schedule_suspend(struct device *d
 
 	dev->power.timer_expires = jiffies + msecs_to_jiffies(delay);
 	dev->power.timer_expires += !dev->power.timer_expires;
+	dev->power.timer_autosuspends = 0;
 	mod_timer(&dev->power.suspend_timer, dev->power.timer_expires);
 
  out:
@@ -670,7 +755,9 @@ EXPORT_SYMBOL_GPL(__pm_runtime_idle);
  * @dev: Device to suspend.
  * @rpmflags: Flag bits.
  *
- * Carry out a suspend, either synchronous or asynchronous.
+ * If the RPM_GET_PUT flag is set, decrement the device's usage count and
+ * return immediately if it is larger than zero.  Then carry out a suspend,
+ * either synchronous or asynchronous.
  *
  * This routine may be called in atomic context if the RPM_ASYNC flag is set.
  */
@@ -679,6 +766,11 @@ int __pm_runtime_suspend(struct device *
 	unsigned long flags;
 	int retval;
 
+	if (rpmflags & RPM_GET_PUT) {
+		if (!atomic_dec_and_test(&dev->power.usage_count))
+			return 0;
+	}
+
 	spin_lock_irqsave(&dev->power.lock, flags);
 	retval = rpm_suspend(dev, rpmflags);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
@@ -980,7 +1072,7 @@ void pm_runtime_allow(struct device *dev
 
 	dev->power.runtime_auto = true;
 	if (atomic_dec_and_test(&dev->power.usage_count))
-		rpm_idle(dev, 0);
+		rpm_idle(dev, RPM_AUTO);
 
  out:
 	spin_unlock_irq(&dev->power.lock);
@@ -1007,6 +1099,86 @@ void pm_runtime_no_callbacks(struct devi
 EXPORT_SYMBOL_GPL(pm_runtime_no_callbacks);
 
 /**
+ * update_autosuspend - Handle a change to a device's autosuspend settings.
+ * @dev: Device to handle.
+ * @old_delay: The former autosuspend_delay value.
+ * @old_use: The former use_autosuspend value.
+ *
+ * Prevent runtime suspend if the new delay is negative and use_autosuspend is
+ * set; otherwise allow it.  Send an idle notification if suspends are allowed.
+ *
+ * This function must be called under dev->power.lock with interrupts disabled.
+ */
+static void update_autosuspend(struct device *dev, int old_delay, int old_use)
+{
+	int delay = dev->power.autosuspend_delay;
+
+	/* Should runtime suspend be prevented now? */
+	if (dev->power.use_autosuspend && delay < 0) {
+
+		/* If it used to be allowed then prevent it. */
+		if (!old_use || old_delay >= 0) {
+			atomic_inc(&dev->power.usage_count);
+			rpm_resume(dev, 0);
+		}
+	}
+
+	/* Runtime suspend should be allowed now. */
+	else {
+
+		/* If it used to be prevented then allow it. */
+		if (old_use && old_delay < 0)
+			atomic_dec(&dev->power.usage_count);
+
+		/* Maybe we can autosuspend now. */
+		rpm_idle(dev, RPM_AUTO);
+	}
+}
+
+/**
+ * pm_runtime_set_autosuspend_delay - Set a device's autosuspend_delay value.
+ * @dev: Device to handle.
+ * @delay: Value of the new delay in milliseconds.
+ *
+ * Set the device's power.autosuspend_delay value.  If it changes to negative
+ * and the power.use_autosuspend flag is set, prevent run-time suspends.  If it
+ * changes the other way, allow run-time suspends.
+ */
+void pm_runtime_set_autosuspend_delay(struct device *dev, int delay)
+{
+	int old_delay, old_use;
+
+	spin_lock_irq(&dev->power.lock);
+	old_delay = dev->power.autosuspend_delay;
+	old_use = dev->power.use_autosuspend;
+	dev->power.autosuspend_delay = delay;
+	update_autosuspend(dev, old_delay, old_use);
+	spin_unlock_irq(&dev->power.lock);
+}
+EXPORT_SYMBOL_GPL(pm_runtime_set_autosuspend_delay);
+
+/**
+ * __pm_runtime_use_autosuspend - Set a device's use_autosuspend flag.
+ * @dev: Device to handle.
+ * @use: New value for use_autosuspend.
+ *
+ * Set the device's power.use_autosuspend flag, and allow or prevent run-time
+ * suspends as needed.
+ */
+void __pm_runtime_use_autosuspend(struct device *dev, bool use)
+{
+	int old_delay, old_use;
+
+	spin_lock_irq(&dev->power.lock);
+	old_delay = dev->power.autosuspend_delay;
+	old_use = dev->power.use_autosuspend;
+	dev->power.use_autosuspend = use;
+	update_autosuspend(dev, old_delay, old_use);
+	spin_unlock_irq(&dev->power.lock);
+}
+EXPORT_SYMBOL_GPL(__pm_runtime_use_autosuspend);
+
+/**
  * pm_runtime_init - Initialize run-time PM fields in given device object.
  * @dev: Device object to initialize.
  */
Index: usb-2.6/drivers/base/power/sysfs.c
===================================================================
--- usb-2.6.orig/drivers/base/power/sysfs.c
+++ usb-2.6/drivers/base/power/sysfs.c
@@ -75,6 +75,18 @@
  *	attribute is set to "enabled" by bus type code or device drivers and in
  *	that cases it should be safe to leave the default value.
  *
+ *	autosuspend_delay_ms - Report/change a device's autosuspend_delay value
+ *
+ *	Some drivers don't want to carry out a runtime suspend as soon as a
+ *	device becomes idle; they want it always to remain idle for some period
+ *	of time before suspending it.  This period is the autosuspend_delay
+ *	value (expressed in milliseconds) and it can be controlled by the user.
+ *	If the value is negative then the device will never be runtime
+ *	suspended.
+ *
+ *	NOTE: The autosuspend_delay_ms attribute and the autosuspend_delay
+ *	value are used only if the driver calls pm_runtime_use_autosuspend().
+ *
  *	wakeup_count - Report the number of wakeup events related to the device
  */
 
@@ -173,6 +185,33 @@ static ssize_t rtpm_status_show(struct d
 }
 
 static DEVICE_ATTR(runtime_status, 0444, rtpm_status_show, NULL);
+
+static ssize_t autosuspend_delay_ms_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	if (!dev->power.use_autosuspend)
+		return -EIO;
+	return sprintf(buf, "%d\n", dev->power.autosuspend_delay);
+}
+
+static ssize_t autosuspend_delay_ms_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t n)
+{
+	long delay;
+
+	if (!dev->power.use_autosuspend)
+		return -EIO;
+
+	if (strict_strtol(buf, 10, &delay) != 0 || delay != (int) delay)
+		return -EINVAL;
+
+	pm_runtime_set_autosuspend_delay(dev, delay);
+	return n;
+}
+
+static DEVICE_ATTR(autosuspend_delay_ms, 0644, autosuspend_delay_ms_show,
+		autosuspend_delay_ms_store);
+
 #endif
 
 static ssize_t
@@ -311,6 +350,7 @@ static struct attribute *runtime_attrs[]
 	&dev_attr_control.attr,
 	&dev_attr_runtime_suspended_time.attr,
 	&dev_attr_runtime_active_time.attr,
+	&dev_attr_autosuspend_delay_ms.attr,
 	NULL,
 };
 static struct attribute_group pm_runtime_attr_group = {
Index: usb-2.6/Documentation/ABI/testing/sysfs-devices-power
===================================================================
--- usb-2.6.orig/Documentation/ABI/testing/sysfs-devices-power
+++ usb-2.6/Documentation/ABI/testing/sysfs-devices-power
@@ -77,3 +77,21 @@ Description:
 		devices this attribute is set to "enabled" by bus type code or
 		device drivers and in that cases it should be safe to leave the
 		default value.
+
+What:		/sys/devices/.../power/autosuspend_delay_ms
+Date:		September 2010
+Contact:	Alan Stern <stern@rowland.harvard.edu>
+Description:
+		The /sys/devices/.../power/autosuspend_delay_ms attribute
+		contains the autosuspend delay value (in milliseconds).  Some
+		drivers do not want their device to suspend as soon as it
+		becomes idle at run time; they want the device to remain
+		inactive for a certain minimum period of time first.  That
+		period is called the autosuspend delay.  Negative values will
+		prevent the device from being suspended at run time (similar
+		to writing "on" to the power/control attribute).  Values >=
+		1000 will cause the autosuspend timer expiration to be rounded
+		up to the nearest second.
+
+		Not all drivers support this attribute.  If it isn't supported,
+		attempts to read or write it will yield I/O errors.
Index: usb-2.6/Documentation/power/runtime_pm.txt
===================================================================
--- usb-2.6.orig/Documentation/power/runtime_pm.txt
+++ usb-2.6/Documentation/power/runtime_pm.txt
@@ -158,7 +158,8 @@ rules:
     to execute it, the other callbacks will not be executed for the same device.
 
   * A request to execute ->runtime_resume() will cancel any pending or
-    scheduled requests to execute the other callbacks for the same device.
+    scheduled requests to execute the other callbacks for the same device,
+    except for scheduled autosuspends.
 
 3. Run-time PM Device Fields
 
@@ -166,7 +167,7 @@ The following device run-time PM fields 
 defined in include/linux/pm.h:
 
   struct timer_list suspend_timer;
-    - timer used for scheduling (delayed) suspend request
+    - timer used for scheduling (delayed) suspend and autosuspend requests
 
   unsigned long timer_expires;
     - timer expiration time, in jiffies (if this is different from zero, the
@@ -236,6 +237,23 @@ defined in include/linux/pm.h:
       Section 8); it may be modified only by the pm_runtime_no_callbacks()
       helper function
 
+  unsigned int use_autosuspend;
+    - indicates that the device's driver supports delayed autosuspend (see
+      Section 9); it may be modified only by the
+      pm_runtime{_dont}_use_autosuspend() helper functions
+
+  unsigned int timer_autosuspends;
+    - indicates that the PM core should attempt to carry out an autosuspend
+      when the timer expires rather than a normal suspend
+
+  int autosuspend_delay;
+    - the delay time (in milliseconds) to be used for autosuspend
+
+  unsigned long last_busy;
+    - the time (in jiffies) when the pm_runtime_mark_last_busy() helper
+      function was last called for this device; used in calculating inactivity
+      periods for autosuspend
+
 All of the above fields are members of the 'power' member of 'struct device'.
 
 4. Run-time PM Device Helper Functions
@@ -261,6 +279,12 @@ drivers/base/power/runtime.c and include
       error code on failure, where -EAGAIN or -EBUSY means it is safe to attempt
       to suspend the device again in future
 
+  int pm_runtime_autosuspend(struct device *dev);
+    - same as pm_runtime_suspend() except that the autosuspend delay is taken
+      into account; if pm_runtime_autosuspend_expiration() says the delay has
+      not yet expired then an autosuspend is scheduled for the appropriate time
+      and 0 is returned
+
   int pm_runtime_resume(struct device *dev);
     - execute the subsystem-level resume callback for the device; returns 0 on
       success, 1 if the device's run-time PM status was already 'active' or
@@ -273,6 +297,11 @@ drivers/base/power/runtime.c and include
       device (the request is represented by a work item in pm_wq); returns 0 on
       success or error code if the request has not been queued up
 
+  int pm_request_autosuspend(struct device *dev);
+    - schedule the execution of the subsystem-level suspend callback for the
+      device when the autosuspend delay has expired; if the delay has already
+      expired then the work item is queued up immediately
+
   int pm_schedule_suspend(struct device *dev, unsigned int delay);
     - schedule the execution of the subsystem-level suspend callback for the
       device in future, where 'delay' is the time to wait before queuing up a
@@ -304,12 +333,20 @@ drivers/base/power/runtime.c and include
     - decrement the device's usage counter
 
   int pm_runtime_put(struct device *dev);
-    - decrement the device's usage counter, run pm_request_idle(dev) and return
-      its result
+    - decrement the device's usage counter; if the result is 0 then run
+      pm_request_idle(dev) and return its result
+
+  int pm_runtime_put_autosuspend(struct device *dev);
+    - decrement the device's usage counter; if the result is 0 then run
+      pm_request_autosuspend(dev) and return its result
 
   int pm_runtime_put_sync(struct device *dev);
-    - decrement the device's usage counter, run pm_runtime_idle(dev) and return
-      its result
+    - decrement the device's usage counter; if the result is 0 then run
+      pm_runtime_idle(dev) and return its result
+
+  int pm_runtime_put_sync_autosuspend(struct device *dev);
+    - decrement the device's usage counter; if the result is 0 then run
+      pm_runtime_autosuspend(dev) and return its result
 
   void pm_runtime_enable(struct device *dev);
     - enable the run-time PM helper functions to run the device bus type's
@@ -360,19 +397,46 @@ drivers/base/power/runtime.c and include
       PM attributes from /sys/devices/.../power (or prevent them from being
       added when the device is registered)
 
+  void pm_runtime_mark_last_busy(struct device *dev);
+    - set the power.last_busy field to the current time
+
+  void pm_runtime_use_autosuspend(struct device *dev);
+    - set the power.use_autosuspend flag, enabling autosuspend delays
+
+  void pm_runtime_dont_use_autosuspend(struct device *dev);
+    - clear the power.use_autosuspend flag, disabling autosuspend delays
+
+  void pm_runtime_set_autosuspend_delay(struct device *dev, int delay);
+    - set the power.autosuspend_delay value to 'delay' (expressed in
+      milliseconds); if 'delay' is negative then run-time suspends are
+      prevented
+
+  unsigned long pm_runtime_autosuspend_expiration(struct device *dev);
+    - calculate the time when the current autosuspend delay period will expire,
+      based on power.last_busy and power.autosuspend_delay; if the delay time
+      is 1000 ms or larger then the expiration time is rounded up to the
+      nearest second; returns 0 if the delay period has already expired or
+      power.use_autosuspend isn't set, otherwise returns the expiration time
+      in jiffies
+
 It is safe to execute the following helper functions from interrupt context:
 
 pm_request_idle()
+pm_request_autosuspend()
 pm_schedule_suspend()
 pm_request_resume()
 pm_runtime_get_noresume()
 pm_runtime_get()
 pm_runtime_put_noidle()
 pm_runtime_put()
+pm_runtime_put_autosuspend()
+pm_runtime_enable()
 pm_suspend_ignore_children()
 pm_runtime_set_active()
 pm_runtime_set_suspended()
-pm_runtime_enable()
+pm_runtime_suspended()
+pm_runtime_mark_last_busy()
+pm_runtime_autosuspend_expiration()
 
 5. Run-time PM Initialization, Device Probing and Removal
 
@@ -561,3 +625,115 @@ As a consequence, the PM core will never
 or driver about run-time power changes.  Instead, the driver for the device's
 parent must take responsibility for telling the device's driver when the
 parent's power state changes.
+
+9. Autosuspend, or automatically-delayed suspends
+
+Changing a device's power state isn't free; it requires both time and energy.
+A device should be put in a low-power state only when there's some reason to
+think it will remain in that state for a substantial time.  A common heuristic
+says that a device which hasn't been used for a while is liable to remain
+unused; following this advice, drivers should not allow devices to be suspended
+at run-time until they have been inactive for some minimum period.  Even when
+the heuristic ends up being non-optimal, it will still prevent devices from
+"bouncing" too rapidly between low-power and full-power states.
+
+The term "autosuspend" is an historical remnant.  It doesn't mean that the
+device is automatically suspended (the subsystem or driver still has to call
+the appropriate PM routines); rather it means that run-time suspends will
+automatically be delayed until the desired period of inactivity has elapsed.
+
+Inactivity is determined based on the power.last_busy field.  Drivers should
+call pm_runtime_mark_last_busy() to update this field after carrying out I/O,
+typically just before calling pm_runtime_put_autosuspend().  The desired length
+of the inactivity period is a matter of policy.  Subsystems can set this length
+initially by calling pm_runtime_set_autosuspend_delay(), but after device
+registration the length should be controlled by user space, using the
+/sys/devices/.../power/autosuspend_delay_ms attribute.
+
+In order to use autosuspend, subsystems or drivers must call
+pm_runtime_use_autosuspend() (preferably before registering the device), and
+thereafter they should use the various *_autosuspend() helper functions instead
+of the non-autosuspend counterparts:
+
+	Instead of: pm_runtime_suspend    use: pm_runtime_autosuspend;
+	Instead of: pm_schedule_suspend   use: pm_request_autosuspend;
+	Instead of: pm_runtime_put        use: pm_runtime_put_autosuspend;
+	Instead of: pm_runtime_put_sync   use: pm_runtime_put_sync_autosuspend.
+
+Drivers may also continue to use the non-autosuspend helper functions; they
+will behave normally, not taking the autosuspend delay into account.
+Similarly, if the power.use_autosuspend field isn't set then the autosuspend
+helper functions will behave just like the non-autosuspend counterparts.
+
+The implementation is well suited for asynchronous use in interrupt contexts.
+However such use inevitably involves races, because the PM core can't
+synchronize ->runtime_suspend() callbacks with the arrival of I/O requests.
+This synchronization must be handled by the driver, using its private lock.
+Here is a schematic pseudo-code example:
+
+	foo_read_or_write(struct foo_priv *foo, void *data)
+	{
+		lock(&foo->private_lock);
+		add_request_to_io_queue(foo, data);
+		if (foo->num_pending_requests++ == 0)
+			pm_runtime_get(&foo->dev);
+		if (!foo->is_suspended)
+			foo_process_next_request(foo);
+		unlock(&foo->private_lock);
+	}
+
+	foo_io_completion(struct foo_priv *foo, void *req)
+	{
+		lock(&foo->private_lock);
+		if (--foo->num_pending_requests == 0) {
+			pm_runtime_mark_last_busy(&foo->dev);
+			pm_runtime_put_autosuspend(&foo->dev);
+		} else {
+			foo_process_next_request(foo);
+		}
+		unlock(&foo->private_lock);
+		/* Send req result back to the user ... */
+	}
+
+	int foo_runtime_suspend(struct device *dev)
+	{
+		struct foo_priv foo = container_of(dev, ...);
+		int ret = 0;
+
+		lock(&foo->private_lock);
+		if (foo->num_pending_requests > 0) {
+			ret = -EBUSY;
+		} else {
+			/* ... suspend the device ... */
+			foo->is_suspended = 1;
+		}
+		unlock(&foo->private_lock);
+		return ret;
+	}
+
+	int foo_runtime_resume(struct device *dev)
+	{
+		struct foo_priv foo = container_of(dev, ...);
+
+		lock(&foo->private_lock);
+		/* ... resume the device ... */
+		foo->is_suspended = 0;
+		pm_runtime_mark_last_busy(&foo->dev);
+		if (foo->num_pending_requests > 0)
+			foo_process_requests(foo);
+		unlock(&foo->private_lock);
+		return 0;
+	}
+
+The important point is that after foo_io_completion() asks for an autosuspend,
+the foo_runtime_suspend() callback may race with foo_read_or_write().
+Therefore foo_runtime_suspend() has to check whether there are any pending I/O
+requests (while holding the private lock) before allowing the suspend to
+proceed.
+
+In addition, the power.autosuspend_delay field can be changed by user space at
+any time.  If a driver cares about this, it can call
+pm_runtime_autosuspend_expiration() from within the ->runtime_suspend()
+callback while holding its private lock.  If the function returns a nonzero
+value then the delay has not yet expired and the callback should return
+-EAGAIN.
