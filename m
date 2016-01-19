From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: [RFC PATCH v1] refining the rpm_suspend function
Date: Tue, 19 Jan 2016 17:14:18 +0800
Message-ID: <1453194858-17416-1-git-send-email-zhaoyang.huang@spreadtrum.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zhaoyang.huang@spreadtrum.com, rjw@rjwysocki.net, pavel@ucw.cz, linux-kernel@vger.kernel.org, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There are too many branch path within he original rpm_suspend funciton,which make
the code a little bit hard for understanding and debugging.Just try to split the
function into some small one to eliminate the goto and make one optimization for
avoiding transfering from wait to auto when irq_safe flag set

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
---
 drivers/base/power/runtime.c |  314 ++++++++++++++++++++++++++----------------
 1 file changed, 199 insertions(+), 115 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index e1a10a0..b0034da 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -11,10 +11,18 @@
 #include <linux/export.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeirq.h>
+#include <linux/decompress/mm.h>
 #include <trace/events/rpm.h>
 #include "power.h"
 
+struct rpm_suspend_retval;
 typedef int (*pm_callback_t)(struct device *);
+typedef void (*_rpm_suspend_func)(struct device *, int, \
+		struct rpm_suspend_retval *);
+typedef struct rpm_suspend_retval{
+	int retval;
+	void (*pfun)(struct device *, int, struct rpm_suspend_retval *);
+} rpm_susp_rv;
 
 static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
 {
@@ -49,6 +57,19 @@ static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
 static int rpm_resume(struct device *dev, int rpmflags);
 static int rpm_suspend(struct device *dev, int rpmflags);
 
+static void _rpm_suspend_auto(struct device *dev, int rpmflags, \
+		struct rpm_suspend_retval *prv);
+static void _rpm_suspend_wait(struct device *dev, int rpmflags, \
+		struct rpm_suspend_retval *prv);
+static void _rpm_suspend_async(struct device *dev, int rpmflags, \
+		struct rpm_suspend_retval *prv);
+static void _rpm_suspend_callback(struct device *dev, int rpmflags, \
+		struct rpm_suspend_retval *prv);
+static void _rpm_suspend_nocallback(struct device *dev, int rpmflags, \
+		struct rpm_suspend_retval *prv);
+static void _rpm_suspend_fail(struct device *dev, int rpmflags, \
+		struct rpm_suspend_retval *prv);
+
 /**
  * update_pm_runtime_accounting - Update the time accounting of power states
  * @dev: Device to update the accounting for
@@ -391,52 +412,12 @@ static int rpm_callback(int (*cb)(struct device *), struct device *dev)
 	return retval != -EACCES ? retval : -EIO;
 }
 
-/**
- * rpm_suspend - Carry out runtime suspend of given device.
- * @dev: Device to suspend.
- * @rpmflags: Flag bits.
- *
- * Check if the device's runtime PM status allows it to be suspended.
- * Cancel a pending idle notification, autosuspend or suspend. If
- * another suspend has been started earlier, either return immediately
- * or wait for it to finish, depending on the RPM_NOWAIT and RPM_ASYNC
- * flags. If the RPM_ASYNC flag is set then queue a suspend request;
- * otherwise run the ->runtime_suspend() callback directly. When
- * ->runtime_suspend succeeded, if a deferred resume was requested while
- * the callback was running then carry it out, otherwise send an idle
- * notification for its parent (if the suspend succeeded and both
- * ignore_children of parent->power and irq_safe of dev->power are not set).
- * If ->runtime_suspend failed with -EAGAIN or -EBUSY, and if the RPM_AUTO
- * flag is set and the next autosuspend-delay expiration time is in the
- * future, schedule another autosuspend attempt.
- *
- * This function must be called under dev->power.lock with interrupts disabled.
- */
-static int rpm_suspend(struct device *dev, int rpmflags)
-	__releases(&dev->power.lock) __acquires(&dev->power.lock)
+static void _rpm_suspend_auto(struct device *dev, int rpmflags,
+	struct rpm_suspend_retval *prv)
 {
-	int (*callback)(struct device *);
-	struct device *parent = NULL;
-	int retval;
-
-	trace_rpm_suspend(dev, rpmflags);
-
- repeat:
-	retval = rpm_check_suspend_allowed(dev);
-
-	if (retval < 0)
-		;	/* Conditions are wrong. */
-
-	/* Synchronous suspends are not allowed in the RPM_RESUMING state. */
-	else if (dev->power.runtime_status == RPM_RESUMING &&
-	    !(rpmflags & RPM_ASYNC))
-		retval = -EAGAIN;
-	if (retval)
-		goto out;
-
 	/* If the autosuspend_delay time hasn't expired yet, reschedule. */
 	if ((rpmflags & RPM_AUTO)
-	    && dev->power.runtime_status != RPM_SUSPENDING) {
+		&& dev->power.runtime_status != RPM_SUSPENDING) {
 		unsigned long expires = pm_runtime_autosuspend_expiration(dev);
 
 		if (expires != 0) {
@@ -444,21 +425,30 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 			dev->power.request = RPM_REQ_NONE;
 
 			/*
-			 * Optimization: If the timer is already running and is
-			 * set to expire at or before the autosuspend delay,
-			 * avoid the overhead of resetting it.  Just let it
-			 * expire; pm_suspend_timer_fn() will take care of the
-			 * rest.
-			 */
+			* Optimization: If the timer is already running and is
+			* set to expire at or before the autosuspend delay,
+			* avoid the overhead of resetting it.  Just let it
+			* expire; pm_suspend_timer_fn() will take care of the
+			* rest.
+			*/
 			if (!(dev->power.timer_expires && time_before_eq(
-			    dev->power.timer_expires, expires))) {
+				dev->power.timer_expires, expires))) {
 				dev->power.timer_expires = expires;
 				mod_timer(&dev->power.suspend_timer, expires);
 			}
 			dev->power.timer_autosuspends = 1;
-			goto out;
-		}
-	}
+			prv->pfun = NULL;
+		} else
+			prv->pfun = _rpm_suspend_wait;
+
+	} else
+		prv->pfun = _rpm_suspend_wait;
+}
+
+static void _rpm_suspend_wait(struct device *dev, int rpmflags,
+       struct rpm_suspend_retval *prv)
+{
+	unsigned long expires = 0;
 
 	/* Other scheduled or pending requests need to be canceled. */
 	pm_runtime_cancel_pending(dev);
@@ -467,60 +457,95 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 		DEFINE_WAIT(wait);
 
 		if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
-			retval = -EINPROGRESS;
-			goto out;
+			prv->retval = -EINPROGRESS;
+			prv->pfun = NULL;
 		}
-
-		if (dev->power.irq_safe) {
-			spin_unlock(&dev->power.lock);
-
-			cpu_relax();
-
-			spin_lock(&dev->power.lock);
-			goto repeat;
-		}
-
-		/* Wait for the other suspend running in parallel with us. */
-		for (;;) {
-			prepare_to_wait(&dev->power.wait_queue, &wait,
-					TASK_UNINTERRUPTIBLE);
-			if (dev->power.runtime_status != RPM_SUSPENDING)
+		else{
+			while (dev->power.runtime_status ==
+				RPM_SUSPENDING) {
+				if (dev->power.irq_safe) {
+					spin_unlock(&dev->power.lock);
+
+					cpu_relax();
+
+					spin_lock(&dev->power.lock);
+					continue;
+				}
+
+				/* Wait for the other suspend
+				running in parallel with us. */
+				for (;;) {
+					prepare_to_wait(&dev->power.wait_queue,
+					&wait,	TASK_UNINTERRUPTIBLE);
+					if (dev->power.runtime_status
+						!= RPM_SUSPENDING)
+						break;
+
+					spin_unlock_irq(&dev->power.lock);
+
+					schedule();
+
+					spin_lock_irq(&dev->power.lock);
+				}
+				finish_wait(&dev->power.wait_queue, &wait);
 				break;
-
-			spin_unlock_irq(&dev->power.lock);
-
-			schedule();
-
-			spin_lock_irq(&dev->power.lock);
+			}
+			/*check expires firstly for auto suspend mode,
+			if not, just go ahead to the async*/
+			expires = pm_runtime_autosuspend_expiration(dev);
+			if (expires != 0)
+				prv->pfun = _rpm_suspend_auto;
+			else
+				prv->pfun = _rpm_suspend_async;
 		}
-		finish_wait(&dev->power.wait_queue, &wait);
-		goto repeat;
-	}
+	} else
+		prv->pfun = _rpm_suspend_async;
+}
 
+static void _rpm_suspend_async(struct device *dev, int rpmflags,
+	struct rpm_suspend_retval *prv)
+{
+	/*if there is no callbacks, no meaning to place a work into workqueue,
+	go ahead to check the deferd resume and if the parent can suspend*/
 	if (dev->power.no_callbacks)
-		goto no_callback;	/* Assume success. */
-
-	/* Carry out an asynchronous or a synchronous suspend. */
-	if (rpmflags & RPM_ASYNC) {
-		dev->power.request = (rpmflags & RPM_AUTO) ?
-		    RPM_REQ_AUTOSUSPEND : RPM_REQ_SUSPEND;
-		if (!dev->power.request_pending) {
-			dev->power.request_pending = true;
-			queue_work(pm_wq, &dev->power.work);
+		prv->pfun = _rpm_suspend_nocallback;
+	else{
+		/* Carry out an asynchronous or a synchronous suspend. */
+		if (rpmflags & RPM_ASYNC) {
+			dev->power.request = (rpmflags & RPM_AUTO) ?
+			RPM_REQ_AUTOSUSPEND : RPM_REQ_SUSPEND;
+			if (!dev->power.request_pending) {
+				dev->power.request_pending = true;
+				queue_work(pm_wq, &dev->power.work);
+			}
+			prv->pfun = NULL;
 		}
-		goto out;
+		prv->pfun = _rpm_suspend_callback;
 	}
+}
 
-	__update_runtime_status(dev, RPM_SUSPENDING);
+static void _rpm_suspend_callback(struct device *dev, int rpmflags,
+	struct rpm_suspend_retval *prv)
+{
+	pm_callback_t callback = RPM_GET_CALLBACK(dev, runtime_suspend);
 
-	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
+	__update_runtime_status(dev, RPM_SUSPENDING);
 
 	dev_pm_enable_wake_irq(dev);
-	retval = rpm_callback(callback, dev);
-	if (retval)
-		goto fail;
+	prv->retval = rpm_callback(callback, dev);
+	if (prv->retval) {
+		__update_runtime_status(dev, RPM_ACTIVE);
+		prv->pfun = _rpm_suspend_fail;
+	} else{
+		prv->pfun = _rpm_suspend_nocallback;
+	}
+}
+
+static void _rpm_suspend_nocallback(struct device *dev, int rpmflags,
+	struct rpm_suspend_retval *prv)
+{
+	struct device *parent;
 
- no_callback:
 	__update_runtime_status(dev, RPM_SUSPENDED);
 	pm_runtime_deactivate_timer(dev);
 
@@ -533,8 +558,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	if (dev->power.deferred_resume) {
 		dev->power.deferred_resume = false;
 		rpm_resume(dev, 0);
-		retval = -EAGAIN;
-		goto out;
+		prv->retval = -EAGAIN;
 	}
 
 	/* Maybe the parent is now able to suspend. */
@@ -547,34 +571,94 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
 		spin_lock(&dev->power.lock);
 	}
+	prv->pfun = NULL;
+}
 
- out:
-	trace_rpm_return_int(dev, _THIS_IP_, retval);
-
-	return retval;
-
- fail:
+static void _rpm_suspend_fail(struct device *dev, int rpmflags,
+	struct rpm_suspend_retval *prv)
+{
 	dev_pm_disable_wake_irq(dev);
 	__update_runtime_status(dev, RPM_ACTIVE);
 	dev->power.deferred_resume = false;
 	wake_up_all(&dev->power.wait_queue);
 
-	if (retval == -EAGAIN || retval == -EBUSY) {
+	if (prv->retval == -EAGAIN || prv->retval == -EBUSY) {
 		dev->power.runtime_error = 0;
 
 		/*
-		 * If the callback routine failed an autosuspend, and
-		 * if the last_busy time has been updated so that there
-		 * is a new autosuspend expiration time, automatically
-		 * reschedule another autosuspend.
-		 */
+		* If the callback routine failed an autosuspend, and
+		* if the last_busy time has been updated so that there
+		* is a new autosuspend expiration time, automatically
+		* reschedule another autosuspend.
+		*/
 		if ((rpmflags & RPM_AUTO) &&
-		    pm_runtime_autosuspend_expiration(dev) != 0)
-			goto repeat;
+			pm_runtime_autosuspend_expiration(dev) != 0)
+			prv->pfun = _rpm_suspend_auto;
 	} else {
 		pm_runtime_cancel_pending(dev);
+		prv->pfun = NULL;
+	}
+}
+
+/**
+ * rpm_suspend - Carry out runtime suspend of given device.
+ * @dev: Device to suspend.
+ * @rpmflags: Flag bits.
+ *
+ * Check if the device's runtime PM status allows it to be suspended.
+ * Cancel a pending idle notification, autosuspend or suspend. If
+ * another suspend has been started earlier, either return immediately
+ * or wait for it to finish, depending on the RPM_NOWAIT and RPM_ASYNC
+ * flags. If the RPM_ASYNC flag is set then queue a suspend request;
+ * otherwise run the ->runtime_suspend() callback directly. When
+ * ->runtime_suspend succeeded, if a deferred resume was requested while
+ * the callback was running then carry it out, otherwise send an idle
+ * notification for its parent (if the suspend succeeded and both
+ * ignore_children of parent->power and irq_safe of dev->power are not set).
+ * If ->runtime_suspend failed with -EAGAIN or -EBUSY, and if the RPM_AUTO
+ * flag is set and the next autosuspend-delay expiration time is in the
+ * future, schedule another autosuspend attempt.
+ *
+ * This function must be called under dev->power.lock with interrupts disabled.
+ */
+static int rpm_suspend(struct device *dev, int rpmflags)
+	__releases(&dev->power.lock) __acquires(&dev->power.lock)
+{
+	rpm_susp_rv *prv = (rpm_susp_rv *)malloc(sizeof(struct rpm_suspend_retval));
+	_rpm_suspend_func pfun;
+	int retval;
+
+	if (NULL == prv)
+		return -ENOMEM;
+
+	trace_rpm_suspend(dev, rpmflags);
+
+	retval = rpm_check_suspend_allowed(dev);
+
+	if (retval < 0)
+		;	/* Conditions are wrong. */
+
+	/* Synchronous suspends are not allowed in the RPM_RESUMING state. */
+	else if (dev->power.runtime_status == RPM_RESUMING &&
+		!(rpmflags & RPM_ASYNC))
+		retval = -EAGAIN;
+
+	if (retval)
+		;
+	else{
+		prv->retval = 0;
+		/*start the process from auto*/
+		pfun = _rpm_suspend_auto;
+		while (pfun) {
+			pfun(dev, rpmflags, prv);
+			pfun = prv->pfun;
+		}
+		retval = prv->retval;
 	}
-	goto out;
+	trace_rpm_return_int(dev, _THIS_IP_, retval);
+
+	free(prv);
+	return retval;
 }
 
 /**
@@ -889,7 +973,7 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
 	unsigned long flags;
 	int retval;
 
-	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
+	might_sleep_if (!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
 
 	if (rpmflags & RPM_GET_PUT) {
 		if (!atomic_dec_and_test(&dev->power.usage_count))
@@ -921,7 +1005,7 @@ int __pm_runtime_suspend(struct device *dev, int rpmflags)
 	unsigned long flags;
 	int retval;
 
-	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
+	might_sleep_if (!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
 
 	if (rpmflags & RPM_GET_PUT) {
 		if (!atomic_dec_and_test(&dev->power.usage_count))
@@ -952,7 +1036,7 @@ int __pm_runtime_resume(struct device *dev, int rpmflags)
 	unsigned long flags;
 	int retval;
 
-	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
+	might_sleep_if (!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
 
 	if (rpmflags & RPM_GET_PUT)
 		atomic_inc(&dev->power.usage_count);
-- 
1.7.9.5
