From: Alan Stern <stern@rowland.harvard.edu>
Subject: [RFC 4/7] PM: merge synchronous and async runtime
	routines
Date: Thu, 23 Sep 2010 17:23:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009231719190.1667-100000@iolanthe.rowland.org>
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

This patch (as1423) merges the asynchronous routines
__pm_request_idle(), __pm_request_suspend(), and __pm_request_resume()
with their synchronous counterparts.  The RPM_ASYNC bitflag argument
serves to indicate what sort of operation to perform.

In the course of performing this merger, it became apparent that the
various functions don't all behave consistenly with regard to error
reporting and cancellation of outstanding requests.  A new routine,
pm_runtime_check_suspend_allowed(), was written to centralize much of
the testing, and the other functions were revised to follow a simple
algorithm:

	If the operation is disallowed because of the device's
	settings or current state, return an error.

	Cancel pending or scheduled requests of lower priority.

	Schedule, queue, or perform the desired operation.

A few special cases and exceptions are noted in comments.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -2,6 +2,7 @@
  * drivers/base/power/runtime.c - Helper functions for device run-time PM
  *
  * Copyright (c) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
+ * Copyright (C) 2010 Alan Stern <stern@rowland.harvard.edu>
  *
  * This file is released under the GPLv2.
  */
@@ -11,8 +12,6 @@
 #include <linux/jiffies.h>
 
 static int __pm_runtime_resume(struct device *dev, int rpmflags);
-static int __pm_request_idle(struct device *dev);
-static int __pm_request_resume(struct device *dev);
 
 /**
  * update_pm_runtime_accounting - Update the time accounting of power states
@@ -79,40 +78,84 @@ static void pm_runtime_cancel_pending(st
 }
 
 /**
- * __pm_runtime_idle - Notify device bus type if the device can be suspended.
- * @dev: Device to notify the bus type about.
- *
- * This function must be called under dev->power.lock with interrupts disabled.
+ * pm_runtime_check_suspend_allowed - Test whether a device may be suspended.
+ * @dev: Device to test.
  */
-static int __pm_runtime_idle(struct device *dev)
-	__releases(&dev->power.lock) __acquires(&dev->power.lock)
+static int pm_runtime_check_suspend_allowed(struct device *dev)
 {
 	int retval = 0;
 
 	if (dev->power.runtime_error)
 		retval = -EINVAL;
-	else if (dev->power.idle_notification)
-		retval = -EINPROGRESS;
 	else if (atomic_read(&dev->power.usage_count) > 0
-	    || dev->power.disable_depth > 0
-	    || dev->power.runtime_status != RPM_ACTIVE)
+	    || dev->power.disable_depth > 0)
 		retval = -EAGAIN;
 	else if (!pm_children_suspended(dev))
 		retval = -EBUSY;
+
+	/* Pending resume requests take precedence over suspends. */
+	else if ((dev->power.deferred_resume
+			&& dev->power.status == RPM_SUSPENDING)
+	    || (dev->power.request_pending
+			&& dev->power.request == RPM_REQ_RESUME))
+		retval = -EAGAIN;
+	else if (dev->power.runtime_status == RPM_SUSPENDED)
+		retval = 1;
+
+	return retval;
+}
+
+
+/**
+ * __pm_runtime_idle - Notify device bus type if the device can be suspended.
+ * @dev: Device to notify the bus type about.
+ * @rpmflags: Flag bits.
+ *
+ * Check if the device's run-time PM status allows it to be suspended.  If
+ * another idle notification has been started earlier, return immediately.  If
+ * the RPM_ASYNC flag is set then queue an idle-notification request; otherwise
+ * run the ->runtime_idle() callback directly.
+ *
+ * This function must be called under dev->power.lock with interrupts disabled.
+ */
+static int __pm_runtime_idle(struct device *dev, int rpmflags)
+	__releases(&dev->power.lock) __acquires(&dev->power.lock)
+{
+	int retval;
+
+	retval = pm_runtime_check_suspend_allowed(dev);
+	if (retval < 0)
+		;	/* Conditions are wrong. */
+
+	/* Idle notifications are allowed only in the RPM_ACTIVE state. */
+	else if (dev->power.runtime_status != RPM_ACTIVE)
+		retval = -EAGAIN;
+
+	/*
+	 * Any pending request other than an idle notification takes
+	 * precedence over us, except that the timer may be running.
+	 */
+	else if (dev->power.request_pending &&
+	    dev->power.request > RPM_REQ_IDLE)
+		retval = -EAGAIN;
+
+	/* Act as though RPM_RETURN_IF_IN_PROGRESS is always set. */
+	else if (dev->power.idle_notification)
+		retval = -EINPROGRESS;
 	if (retval)
 		goto out;
 
-	if (dev->power.request_pending) {
-		/*
-		 * If an idle notification request is pending, cancel it.  Any
-		 * other pending request takes precedence over us.
-		 */
-		if (dev->power.request == RPM_REQ_IDLE) {
-			dev->power.request = RPM_REQ_NONE;
-		} else if (dev->power.request != RPM_REQ_NONE) {
-			retval = -EAGAIN;
-			goto out;
+	/* Pending requests need to be canceled. */
+	dev->power.request = RPM_REQ_NONE;
+
+	/* Carry out an asynchronous or a synchronous idle notification. */
+	if (rpmflags & RPM_ASYNC) {
+		dev->power.request = RPM_REQ_IDLE;
+		if (!dev->power.request_pending) {
+			dev->power.request_pending = true;
+			queue_work(pm_wq, &dev->power.work);
 		}
+		goto out;
 	}
 
 	dev->power.idle_notification = true;
@@ -154,7 +197,7 @@ int pm_runtime_idle(struct device *dev)
 	int retval;
 
 	spin_lock_irq(&dev->power.lock);
-	retval = __pm_runtime_idle(dev);
+	retval = __pm_runtime_idle(dev, 0);
 	spin_unlock_irq(&dev->power.lock);
 
 	return retval;
@@ -166,11 +209,14 @@ EXPORT_SYMBOL_GPL(pm_runtime_idle);
  * @dev: Device to suspend.
  * @rpmflags: Flag bits.
  *
- * Check if the device can be suspended and run the ->runtime_suspend() callback
- * provided by its bus type.  If another suspend has been started earlier,
- * either return immediately or wait for it to finish, depending on the
- * RPM_RETURN_IF_IN_PROGRESS flag.  If an idle notification or suspend request
- * is pending or scheduled, cancel it.
+ * Check if the device's run-time PM status allows it to be suspended.  If
+ * another suspend has been started earlier, either return immediately or wait
+ * for it to finish, depending on the RPM_RETURN_IF_IN_PROGRESS and RPM_ASYNC
+ * flags.  Cancel a pending idle notification.  If the RPM_ASYNC flag is set
+ * then queue a suspend request; otherwise run the ->runtime_suspend() callback
+ * directly.  If a deferred resume was requested while the callback was running
+ * then carry it out; otherwise send an idle notification for the device (if
+ * the suspend failed) or for its parent (if the suspend succeeded).
  *
  * This function must be called under dev->power.lock with interrupts disabled.
  */
@@ -179,41 +225,30 @@ static int __pm_runtime_suspend(struct d
 {
 	struct device *parent = NULL;
 	bool notify = false;
-	int retval = 0;
+	int retval;
 
 	dev_dbg(dev, "%s flags 0x%x\n", __func__, rpmflags);
 
  repeat:
-	if (dev->power.runtime_error) {
-		retval = -EINVAL;
-		goto out;
-	}
+	retval = pm_runtime_check_suspend_allowed(dev);
 
-	/* Pending resume requests take precedence over us. */
-	if (dev->power.request_pending
-	    && dev->power.request == RPM_REQ_RESUME) {
+	if (retval < 0)
+		;	/* Conditions are wrong. */
+
+	/* Synchronous suspends are not allowed in the RPM_RESUMING state. */
+	else if (dev->power.runtime_status == RPM_RESUMING &&
+	    !(rpmflags & RPM_ASYNC))
 		retval = -EAGAIN;
+	if (retval)
 		goto out;
-	}
 
 	/* Other scheduled or pending requests need to be canceled. */
 	pm_runtime_cancel_pending(dev);
 
-	if (dev->power.runtime_status == RPM_SUSPENDED)
-		retval = 1;
-	else if (dev->power.runtime_status == RPM_RESUMING
-	    || dev->power.disable_depth > 0
-	    || atomic_read(&dev->power.usage_count) > 0)
-		retval = -EAGAIN;
-	else if (!pm_children_suspended(dev))
-		retval = -EBUSY;
-	if (retval)
-		goto out;
-
 	if (dev->power.runtime_status == RPM_SUSPENDING) {
 		DEFINE_WAIT(wait);
 
-		if (rpmflags & RPM_RETURN_IF_IN_PROGRESS) {
+		if (rpmflags & (RPM_ASYNC | RPM_RETURN_IF_IN_PROGRESS)) {
 			retval = -EINPROGRESS;
 			goto out;
 		}
@@ -235,6 +270,16 @@ static int __pm_runtime_suspend(struct d
 		goto repeat;
 	}
 
+	/* Carry out an asynchronous or a synchronous suspend. */
+	if (rpmflags & RPM_ASYNC) {
+		dev->power.request = RPM_REQ_SUSPEND;
+		if (!dev->power.request_pending) {
+			dev->power.request_pending = true;
+			queue_work(pm_wq, &dev->power.work);
+		}
+		goto out;
+	}
+
 	__update_runtime_status(dev, RPM_SUSPENDING);
 	dev->power.deferred_resume = false;
 
@@ -267,6 +312,7 @@ static int __pm_runtime_suspend(struct d
 
 	if (retval) {
 		__update_runtime_status(dev, RPM_ACTIVE);
+		dev->power.deferred_resume = 0;
 		if (retval == -EAGAIN || retval == -EBUSY) {
 			if (dev->power.timer_expires == 0)
 				notify = true;
@@ -292,7 +338,7 @@ static int __pm_runtime_suspend(struct d
 	}
 
 	if (notify)
-		__pm_runtime_idle(dev);
+		__pm_runtime_idle(dev, 0);
 
 	if (parent && !parent->power.ignore_children) {
 		spin_unlock_irq(&dev->power.lock);
@@ -329,13 +375,15 @@ EXPORT_SYMBOL_GPL(pm_runtime_suspend);
  * @dev: Device to resume.
  * @rpmflags: Flag bits.
  *
- * Check if the device can be woken up and run the ->runtime_resume() callback
- * provided by its bus type.  If another resume has been started earlier,
- * either return imediately or wait for it to finish, depending on the
- * RPM_RETURN_IF_IN_PROGRESS flag.  If there's a suspend running in parallel
- * with this function, either tell the other process to resume after suspending
- * (deferred_resume) or wait for it to finish, depending on the
- * RPM_RETURN_IF_IN_PROGRESS flag.  Cancel any scheduled or pending requests.
+ * Check if the device's run-time PM status allows it to be resumed.  Cancel
+ * any scheduled or pending requests.  If another resume has been started
+ * earlier, either return imediately or wait for it to finish, depending on the
+ * RPM_RETURN_IF_IN_PROGRESS and RPM_ASYNC flags.  Similarly, if there's a
+ * suspend running in parallel with this function, either tell the other
+ * process to resume after suspending (deferred_resume) or wait for it to
+ * finish.  If the RPM_ASYNC flag is set then queue a resume request; otherwise
+ * run the ->runtime_resume() callback directly.  Queue an idle notification
+ * for the device if the resume succeeded.
  *
  * This function must be called under dev->power.lock with interrupts disabled.
  */
@@ -348,28 +396,30 @@ static int __pm_runtime_resume(struct de
 	dev_dbg(dev, "%s flags 0x%x\n", __func__, rpmflags);
 
  repeat:
-	if (dev->power.runtime_error) {
+	if (dev->power.runtime_error)
 		retval = -EINVAL;
+	else if (dev->power.disable_depth > 0)
+		retval = -EAGAIN;
+	if (retval)
 		goto out;
-	}
 
+	/* Other scheduled or pending requests need to be canceled. */
 	pm_runtime_cancel_pending(dev);
 
-	if (dev->power.runtime_status == RPM_ACTIVE)
+	if (dev->power.runtime_status == RPM_ACTIVE) {
 		retval = 1;
-	else if (dev->power.disable_depth > 0)
-		retval = -EAGAIN;
-	if (retval)
 		goto out;
+	}
 
 	if (dev->power.runtime_status == RPM_RESUMING
 	    || dev->power.runtime_status == RPM_SUSPENDING) {
 		DEFINE_WAIT(wait);
 
-		if (rpmflags & RPM_RETURN_IF_IN_PROGRESS) {
+		if (rpmflags & (RPM_ASYNC | RPM_RETURN_IF_IN_PROGRESS)) {
 			if (dev->power.runtime_status == RPM_SUSPENDING)
 				dev->power.deferred_resume = true;
-			retval = -EINPROGRESS;
+			else
+				retval = -EINPROGRESS;
 			goto out;
 		}
 
@@ -391,6 +441,17 @@ static int __pm_runtime_resume(struct de
 		goto repeat;
 	}
 
+	/* Carry out an asynchronous or a synchronous resume. */
+	if (rpmflags & RPM_ASYNC) {
+		dev->power.request = RPM_REQ_RESUME;
+		if (!dev->power.request_pending) {
+			dev->power.request_pending = true;
+			queue_work(pm_wq, &dev->power.work);
+		}
+		retval = 0;
+		goto out;
+	}
+
 	if (!parent && dev->parent) {
 		/*
 		 * Increment the parent's resume counter and resume it if
@@ -460,7 +521,7 @@ static int __pm_runtime_resume(struct de
 	wake_up_all(&dev->power.wait_queue);
 
 	if (!retval)
-		__pm_request_idle(dev);
+		__pm_runtime_idle(dev, RPM_ASYNC);
 
  out:
 	if (parent) {
@@ -517,7 +578,7 @@ static void pm_runtime_work(struct work_
 	case RPM_REQ_NONE:
 		break;
 	case RPM_REQ_IDLE:
-		__pm_runtime_idle(dev);
+		__pm_runtime_idle(dev, RPM_RETURN_IF_IN_PROGRESS);
 		break;
 	case RPM_REQ_SUSPEND:
 		__pm_runtime_suspend(dev, RPM_RETURN_IF_IN_PROGRESS);
@@ -532,47 +593,6 @@ static void pm_runtime_work(struct work_
 }
 
 /**
- * __pm_request_idle - Submit an idle notification request for given device.
- * @dev: Device to handle.
- *
- * Check if the device's run-time PM status is correct for suspending the device
- * and queue up a request to run __pm_runtime_idle() for it.
- *
- * This function must be called under dev->power.lock with interrupts disabled.
- */
-static int __pm_request_idle(struct device *dev)
-{
-	int retval = 0;
-
-	if (dev->power.runtime_error)
-		retval = -EINVAL;
-	else if (atomic_read(&dev->power.usage_count) > 0
-	    || dev->power.disable_depth > 0
-	    || dev->power.runtime_status == RPM_SUSPENDED
-	    || dev->power.runtime_status == RPM_SUSPENDING)
-		retval = -EAGAIN;
-	else if (!pm_children_suspended(dev))
-		retval = -EBUSY;
-	if (retval)
-		return retval;
-
-	if (dev->power.request_pending) {
-		/* Any requests other then RPM_REQ_IDLE take precedence. */
-		if (dev->power.request == RPM_REQ_NONE)
-			dev->power.request = RPM_REQ_IDLE;
-		else if (dev->power.request != RPM_REQ_IDLE)
-			retval = -EAGAIN;
-		return retval;
-	}
-
-	dev->power.request = RPM_REQ_IDLE;
-	dev->power.request_pending = true;
-	queue_work(pm_wq, &dev->power.work);
-
-	return retval;
-}
-
-/**
  * pm_request_idle - Submit an idle notification request for given device.
  * @dev: Device to handle.
  */
@@ -582,7 +602,7 @@ int pm_request_idle(struct device *dev)
 	int retval;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
-	retval = __pm_request_idle(dev);
+	retval = __pm_runtime_idle(dev, RPM_ASYNC);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	return retval;
@@ -590,59 +610,10 @@ int pm_request_idle(struct device *dev)
 EXPORT_SYMBOL_GPL(pm_request_idle);
 
 /**
- * __pm_request_suspend - Submit a suspend request for given device.
- * @dev: Device to suspend.
- *
- * This function must be called under dev->power.lock with interrupts disabled.
- */
-static int __pm_request_suspend(struct device *dev)
-{
-	int retval = 0;
-
-	if (dev->power.runtime_error)
-		return -EINVAL;
-
-	if (dev->power.runtime_status == RPM_SUSPENDED)
-		retval = 1;
-	else if (atomic_read(&dev->power.usage_count) > 0
-	    || dev->power.disable_depth > 0)
-		retval = -EAGAIN;
-	else if (dev->power.runtime_status == RPM_SUSPENDING)
-		retval = -EINPROGRESS;
-	else if (!pm_children_suspended(dev))
-		retval = -EBUSY;
-	if (retval < 0)
-		return retval;
-
-	pm_runtime_deactivate_timer(dev);
-
-	if (dev->power.request_pending) {
-		/*
-		 * Pending resume requests take precedence over us, but we can
-		 * overtake any other pending request.
-		 */
-		if (dev->power.request == RPM_REQ_RESUME)
-			retval = -EAGAIN;
-		else if (dev->power.request != RPM_REQ_SUSPEND)
-			dev->power.request = retval ?
-						RPM_REQ_NONE : RPM_REQ_SUSPEND;
-		return retval;
-	} else if (retval) {
-		return retval;
-	}
-
-	dev->power.request = RPM_REQ_SUSPEND;
-	dev->power.request_pending = true;
-	queue_work(pm_wq, &dev->power.work);
-
-	return 0;
-}
-
-/**
  * pm_suspend_timer_fn - Timer function for pm_schedule_suspend().
  * @data: Device pointer passed by pm_schedule_suspend().
  *
- * Check if the time is right and execute __pm_request_suspend() in that case.
+ * Check if the time is right and queue a suspend request.
  */
 static void pm_suspend_timer_fn(unsigned long data)
 {
@@ -656,7 +627,7 @@ static void pm_suspend_timer_fn(unsigned
 	/* If 'expire' is after 'jiffies' we've been called too early. */
 	if (expires > 0 && !time_after(expires, jiffies)) {
 		dev->power.timer_expires = 0;
-		__pm_request_suspend(dev);
+		__pm_runtime_suspend(dev, RPM_ASYNC);
 	}
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
@@ -670,47 +641,24 @@ static void pm_suspend_timer_fn(unsigned
 int pm_schedule_suspend(struct device *dev, unsigned int delay)
 {
 	unsigned long flags;
-	int retval = 0;
+	int retval;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
-	if (dev->power.runtime_error) {
-		retval = -EINVAL;
-		goto out;
-	}
-
 	if (!delay) {
-		retval = __pm_request_suspend(dev);
+		retval = __pm_runtime_suspend(dev, RPM_ASYNC);
 		goto out;
 	}
 
-	pm_runtime_deactivate_timer(dev);
-
-	if (dev->power.request_pending) {
-		/*
-		 * Pending resume requests take precedence over us, but any
-		 * other pending requests have to be canceled.
-		 */
-		if (dev->power.request == RPM_REQ_RESUME) {
-			retval = -EAGAIN;
-			goto out;
-		}
-		dev->power.request = RPM_REQ_NONE;
-	}
-
-	if (dev->power.runtime_status == RPM_SUSPENDED)
-		retval = 1;
-	else if (atomic_read(&dev->power.usage_count) > 0
-	    || dev->power.disable_depth > 0)
-		retval = -EAGAIN;
-	else if (!pm_children_suspended(dev))
-		retval = -EBUSY;
+	retval = pm_runtime_check_suspend_allowed(dev);
 	if (retval)
 		goto out;
 
+	/* Other scheduled or pending requests need to be canceled. */
+	pm_runtime_cancel_pending(dev);
+
 	dev->power.timer_expires = jiffies + msecs_to_jiffies(delay);
-	if (!dev->power.timer_expires)
-		dev->power.timer_expires = 1;
+	dev->power.timer_expires += !dev->power.timer_expires;
 	mod_timer(&dev->power.suspend_timer, dev->power.timer_expires);
 
  out:
@@ -723,49 +671,6 @@ EXPORT_SYMBOL_GPL(pm_schedule_suspend);
 /**
  * pm_request_resume - Submit a resume request for given device.
  * @dev: Device to resume.
- *
- * This function must be called under dev->power.lock with interrupts disabled.
- */
-static int __pm_request_resume(struct device *dev)
-{
-	int retval = 0;
-
-	if (dev->power.runtime_error)
-		return -EINVAL;
-
-	if (dev->power.runtime_status == RPM_ACTIVE)
-		retval = 1;
-	else if (dev->power.runtime_status == RPM_RESUMING)
-		retval = -EINPROGRESS;
-	else if (dev->power.disable_depth > 0)
-		retval = -EAGAIN;
-	if (retval < 0)
-		return retval;
-
-	pm_runtime_deactivate_timer(dev);
-
-	if (dev->power.runtime_status == RPM_SUSPENDING) {
-		dev->power.deferred_resume = true;
-		return retval;
-	}
-	if (dev->power.request_pending) {
-		/* If non-resume request is pending, we can overtake it. */
-		dev->power.request = retval ? RPM_REQ_NONE : RPM_REQ_RESUME;
-		return retval;
-	}
-	if (retval)
-		return retval;
-
-	dev->power.request = RPM_REQ_RESUME;
-	dev->power.request_pending = true;
-	queue_work(pm_wq, &dev->power.work);
-
-	return retval;
-}
-
-/**
- * pm_request_resume - Submit a resume request for given device.
- * @dev: Device to resume.
  */
 int pm_request_resume(struct device *dev)
 {
@@ -773,7 +678,7 @@ int pm_request_resume(struct device *dev
 	int retval;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
-	retval = __pm_request_resume(dev);
+	retval = __pm_runtime_resume(dev, RPM_ASYNC);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	return retval;
@@ -1088,7 +993,7 @@ void pm_runtime_allow(struct device *dev
 
 	dev->power.runtime_auto = true;
 	if (atomic_dec_and_test(&dev->power.usage_count))
-		__pm_runtime_idle(dev);
+		__pm_runtime_idle(dev, 0);
 
  out:
 	spin_unlock_irq(&dev->power.lock);
