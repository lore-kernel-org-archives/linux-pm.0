From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: [RFC PATCH v3] POWER/runtime: refining the rpm_suspend function
Date: Thu, 21 Jan 2016 11:08:51 +0800
Message-ID: <1453345731-5192-1-git-send-email-zhaoyang.huang@spreadtrum.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34961 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbcAUDJE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 22:09:04 -0500
Received: by mail-pa0-f50.google.com with SMTP id ho8so15121428pac.2
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2016 19:09:04 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: zhaoyang.huang@spreadtrum.com, rjw@rjwysocki.net, pavel@ucw.cz, linux-kernel@vger.kernel.org, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org
Cc: serge.broslavsky@linaro.org, alex.wang@spreadtrum.com, geng.ren@spreadtrum.com

There are 11 'goto' and 4 'label' within he original rpm_suspend funciton,
which make the code a little bit hard for understanding and debugging.Just
try to remove all 'goto' and 'label', and split the function into 6 small ones
which take one phase of the process each(_rpm_suspend_xxx).
By removing the 'goto' and 'label', rpm_suspend changes to quite simple, where
there is just one function call inside a while loop like bellowing. The pfun
here works as a current pointer which point to the on duty function of active
phase so far.

...
		while (pfun) {
			pfun(dev, rpmflags, prv);
			pfun = prv->pfun;
		}
...

The original rpm_suspend function is divied into bellowing functions, which will
transfer to corresponding ones like a state machine.
_rpm_suspend_auto
_rpm_suspend_wait
_rpm_suspend_call
_rpm_suspend_success
_rpm_suspend_fail

The switching path of the state machine like process is as bellowing,

_rpm_suspend_auto <-- <-------
       |             |       |
       |             |       |
       V             |       |
_rpm_suspend_wait-----       |
       |                     |
       |                     |
       V                     |
_rpm_suspend_call---->_rpm_suspend_fail
       |                     |
       |                     |
       V                     V
_rpm_suspend_success------->END

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
---
 drivers/base/power/runtime.c |  201 +++++++++++++++++++++++++++++-------------
 1 file changed, 140 insertions(+), 61 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index e1a10a0..fb4860e 100644
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
@@ -49,6 +57,17 @@ static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
 static int rpm_resume(struct device *dev, int rpmflags);
 static int rpm_suspend(struct device *dev, int rpmflags);
 
+static void _rpm_suspend_auto(struct device *dev, int rpmflags, \
+		struct rpm_suspend_retval *prv);
+static void _rpm_suspend_wait(struct device *dev, int rpmflags, \
+		struct rpm_suspend_retval *prv);
+static void _rpm_suspend_call(struct device *dev, int rpmflags, \
+		struct rpm_suspend_retval *prv);
+static void _rpm_suspend_success(struct device *dev, int rpmflags, \
+		struct rpm_suspend_retval *prv);
+static void _rpm_suspend_fail(struct device *dev, int rpmflags, \
+		struct rpm_suspend_retval *prv);
+
 /**
  * update_pm_runtime_accounting - Update the time accounting of power states
  * @dev: Device to update the accounting for
@@ -415,13 +434,15 @@ static int rpm_callback(int (*cb)(struct device *), struct device *dev)
 static int rpm_suspend(struct device *dev, int rpmflags)
 	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
-	int (*callback)(struct device *);
-	struct device *parent = NULL;
+	rpm_susp_rv *prv = (rpm_susp_rv *)malloc(sizeof(struct rpm_suspend_retval));
+	_rpm_suspend_func pfun;
 	int retval;
 
+	if (NULL == prv)
+		return -ENOMEM;
+
 	trace_rpm_suspend(dev, rpmflags);
 
- repeat:
 	retval = rpm_check_suspend_allowed(dev);
 
 	if (retval < 0)
@@ -429,14 +450,35 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
 	/* Synchronous suspends are not allowed in the RPM_RESUMING state. */
 	else if (dev->power.runtime_status == RPM_RESUMING &&
-	    !(rpmflags & RPM_ASYNC))
+		!(rpmflags & RPM_ASYNC))
 		retval = -EAGAIN;
+
 	if (retval)
-		goto out;
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
+	}
+	trace_rpm_return_int(dev, _THIS_IP_, retval);
+
+	free(prv);
+	return retval;
+}
+
+static void _rpm_suspend_auto(struct device *dev, int rpmflags,
+	struct rpm_suspend_retval *prv)
+{
+	prv->pfun = _rpm_suspend_wait;
 
 	/* If the autosuspend_delay time hasn't expired yet, reschedule. */
 	if ((rpmflags & RPM_AUTO)
-	    && dev->power.runtime_status != RPM_SUSPENDING) {
+		&& dev->power.runtime_status != RPM_SUSPENDING) {
 		unsigned long expires = pm_runtime_autosuspend_expiration(dev);
 
 		if (expires != 0) {
@@ -444,21 +486,29 @@ static int rpm_suspend(struct device *dev, int rpmflags)
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
+			prv->pfun = NULL;
 		}
 	}
+}
+
+static void _rpm_suspend_wait(struct device *dev, int rpmflags,
+	struct rpm_suspend_retval *prv)
+{
+	unsigned long expires = 0;
+
+	prv->pfun = _rpm_suspend_call;
 
 	/* Other scheduled or pending requests need to be canceled. */
 	pm_runtime_cancel_pending(dev);
@@ -467,24 +517,31 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 		DEFINE_WAIT(wait);
 
 		if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
-			retval = -EINPROGRESS;
-			goto out;
+			prv->retval = -EINPROGRESS;
+			prv->pfun = NULL;
+			return;
 		}
 
 		if (dev->power.irq_safe) {
-			spin_unlock(&dev->power.lock);
+			while (dev->power.runtime_status ==
+				RPM_SUSPENDING) {
+				spin_unlock(&dev->power.lock);
 
-			cpu_relax();
+				cpu_relax();
 
-			spin_lock(&dev->power.lock);
-			goto repeat;
+				spin_lock(&dev->power.lock);
+				continue;
+			}
 		}
 
-		/* Wait for the other suspend running in parallel with us. */
+		/*Wait for the other suspend
+		*running in parallel with us
+		*/
 		for (;;) {
-			prepare_to_wait(&dev->power.wait_queue, &wait,
-					TASK_UNINTERRUPTIBLE);
-			if (dev->power.runtime_status != RPM_SUSPENDING)
+			prepare_to_wait(&dev->power.wait_queue,
+				&wait,	TASK_UNINTERRUPTIBLE);
+			if (dev->power.runtime_status
+					!= RPM_SUSPENDING)
 				break;
 
 			spin_unlock_irq(&dev->power.lock);
@@ -494,35 +551,60 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 			spin_lock_irq(&dev->power.lock);
 		}
 		finish_wait(&dev->power.wait_queue, &wait);
-		goto repeat;
+
+		/*check expires firstly for auto suspend mode,
+		*if not, just go ahead to the async
+		*/
+		expires = pm_runtime_autosuspend_expiration(dev);
+		if (expires != 0)
+			prv->pfun = _rpm_suspend_auto;
 	}
+}
 
-	if (dev->power.no_callbacks)
-		goto no_callback;	/* Assume success. */
+/*call the function async or sync by the callback*/
+static void _rpm_suspend_call(struct device *dev, int rpmflags,
+	struct rpm_suspend_retval *prv)
+{
+	pm_callback_t callback;
+
+	prv->pfun = _rpm_suspend_success;
+
+	/*if there is no callbacks, no meaning to place a work into workqueue,
+	*go ahead to check the deferd resume and if the parent can suspend
+	*/
+	if (!dev->power.no_callbacks) {
+		/* Carry out an asynchronous or a synchronous suspend. */
+		if (rpmflags & RPM_ASYNC) {
+			dev->power.request = (rpmflags & RPM_AUTO) ?
+			RPM_REQ_AUTOSUSPEND : RPM_REQ_SUSPEND;
+			if (!dev->power.request_pending) {
+				dev->power.request_pending = true;
+				queue_work(pm_wq, &dev->power.work);
+			}
+			prv->pfun = NULL;
+		} else {
+			callback = RPM_GET_CALLBACK(dev, runtime_suspend);
 
-	/* Carry out an asynchronous or a synchronous suspend. */
-	if (rpmflags & RPM_ASYNC) {
-		dev->power.request = (rpmflags & RPM_AUTO) ?
-		    RPM_REQ_AUTOSUSPEND : RPM_REQ_SUSPEND;
-		if (!dev->power.request_pending) {
-			dev->power.request_pending = true;
-			queue_work(pm_wq, &dev->power.work);
-		}
-		goto out;
-	}
+			__update_runtime_status(dev, RPM_SUSPENDING);
 
-	__update_runtime_status(dev, RPM_SUSPENDING);
+			dev_pm_enable_wake_irq(dev);
 
-	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
+			prv->retval = rpm_callback(callback, dev);
 
-	dev_pm_enable_wake_irq(dev);
-	retval = rpm_callback(callback, dev);
-	if (retval)
-		goto fail;
+			if (prv->retval)
+				prv->pfun = _rpm_suspend_fail;
+		}
+	}
+}
+
+static void _rpm_suspend_success(struct device *dev, int rpmflags,
+	struct rpm_suspend_retval *prv)
+{
+	struct device *parent;
 
- no_callback:
 	__update_runtime_status(dev, RPM_SUSPENDED);
 	pm_runtime_deactivate_timer(dev);
+	prv->pfun = NULL;
 
 	if (dev->parent) {
 		parent = dev->parent;
@@ -533,8 +615,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	if (dev->power.deferred_resume) {
 		dev->power.deferred_resume = false;
 		rpm_resume(dev, 0);
-		retval = -EAGAIN;
-		goto out;
+		prv->retval = -EAGAIN;
 	}
 
 	/* Maybe the parent is now able to suspend. */
@@ -547,34 +628,32 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
 		spin_lock(&dev->power.lock);
 	}
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
 	}
-	goto out;
 }
 
 /**
-- 
1.7.9.5

