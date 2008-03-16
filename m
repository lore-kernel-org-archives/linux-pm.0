From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] apm-emulation: notify about all suspend events,
	not just	apm invoked ones
Date: Sun, 16 Mar 2008 23:37:45 +0100
Message-ID: <1205707065.1614.5.camel@johannes.berg>
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
To: Len Brown <lenb@kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Stephen Rothwell <sfr@linuxcare.com>
List-Id: linux-pm@vger.kernel.org

This revamps the apm-emulation code to get suspend notifications
regardless of what way pm_suspend() was invoked, whether via the
apm ioctl or via /sys/power/state. Also do some code cleanup and
add comments while at it.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
Changelog:
v1: added notifiers to send out apm events for suspends triggered elsewhere
v2: rewritten apm-emulation.c to work regardless even when suspend was
    triggered within apm-emulation
v3: changed suspend state to an enum (suggested by David Brownell)
v4: make things static, remove superfluous local variable (thanks to sparse)
v5: no longer export pm_chain_head, rebased on a later tree

 drivers/char/apm-emulation.c |  346 +++++++++++++++++++++++++------------------
 1 file changed, 207 insertions(+), 139 deletions(-)

--- everything.orig/drivers/char/apm-emulation.c	2008-03-15 15:19:41.000000000 +0100
+++ everything/drivers/char/apm-emulation.c	2008-03-16 11:08:53.000000000 +0100
@@ -57,6 +57,55 @@ struct apm_queue {
 };
 
 /*
+ * thread states (for threads using a writable /dev/apm_bios fd):
+ *
+ * SUSPEND_NONE:	nothing happening
+ * SUSPEND_PENDING:	suspend event queued for thread and pending to be read
+ * SUSPEND_READ:	suspend event read, pending acknowledgement
+ * SUSPEND_ACKED:	acknowledgement received from thread (via ioctl),
+ *			waiting for resume
+ * SUSPEND_ACKTO:	acknowledgement timeout
+ * SUSPEND_DONE:	thread had acked suspend and is now notified of
+ *			resume
+ *
+ * SUSPEND_WAIT:	this thread invoked suspend and is waiting for resume
+ *
+ * A thread migrates in one of three paths:
+ * 	NONE -1-> PENDING -2-> READ -3-> ACKED -4-> DONE -5-> NONE
+ *	                            -6-> ACKTO -7-> NONE
+ *	NONE -8-> WAIT -9-> NONE
+ *
+ * While in PENDING or READ, the thread is accounted for in the
+ * suspend_acks_pending counter.
+ *
+ * The transitions are invoked as follows:
+ *	1: suspend event is signalled from the core PM code
+ *	2: the suspend event is read from the fd by the userspace thread
+ *	3: userspace thread issues the APM_IOC_SUSPEND ioctl (as ack)
+ *	4: core PM code signals that we have resumed
+ *	5: APM_IOC_SUSPEND ioctl returns
+ *
+ *	6: the notifier invoked from the core PM code timed out waiting
+ *	   for all relevant threds to enter ACKED state and puts those
+ *	   that haven't into ACKTO
+ *	7: those threads issue APM_IOC_SUSPEND ioctl too late,
+ *	   get an error
+ *
+ *	8: userspace thread issues the APM_IOC_SUSPEND ioctl (to suspend),
+ *	   ioctl code invokes pm_suspend()
+ *	9: pm_suspend() returns indicating resume
+ */
+enum apm_suspend_state {
+	SUSPEND_NONE,
+	SUSPEND_PENDING,
+	SUSPEND_READ,
+	SUSPEND_ACKED,
+	SUSPEND_ACKTO,
+	SUSPEND_WAIT,
+	SUSPEND_DONE,
+};
+
+/*
  * The per-file APM data
  */
 struct apm_user {
@@ -67,13 +116,7 @@ struct apm_user {
 	unsigned int		reader: 1;
 
 	int			suspend_result;
-	unsigned int		suspend_state;
-#define SUSPEND_NONE	0		/* no suspend pending */
-#define SUSPEND_PENDING	1		/* suspend pending read */
-#define SUSPEND_READ	2		/* suspend read, pending ack */
-#define SUSPEND_ACKED	3		/* suspend acked */
-#define SUSPEND_WAIT	4		/* waiting for suspend */
-#define SUSPEND_DONE	5		/* suspend completed */
+	enum apm_suspend_state	suspend_state;
 
 	struct apm_queue	queue;
 };
@@ -81,7 +124,8 @@ struct apm_user {
 /*
  * Local variables
  */
-static int suspends_pending;
+static atomic_t suspend_acks_pending = ATOMIC_INIT(0);
+static atomic_t userspace_notification_inhibit = ATOMIC_INIT(0);
 static int apm_disabled;
 static struct task_struct *kapmd_tsk;
 
@@ -164,78 +208,6 @@ static void queue_event(apm_event_t even
 	wake_up_interruptible(&apm_waitqueue);
 }
 
-/*
- * queue_suspend_event - queue an APM suspend event.
- *
- * Check that we're in a state where we can suspend.  If not,
- * return -EBUSY.  Otherwise, queue an event to all "writer"
- * users.  If there are no "writer" users, return '1' to
- * indicate that we can immediately suspend.
- */
-static int queue_suspend_event(apm_event_t event, struct apm_user *sender)
-{
-	struct apm_user *as;
-	int ret = 1;
-
-	mutex_lock(&state_lock);
-	down_read(&user_list_lock);
-
-	/*
-	 * If a thread is still processing, we can't suspend, so reject
-	 * the request.
-	 */
-	list_for_each_entry(as, &apm_user_list, list) {
-		if (as != sender && as->reader && as->writer && as->suser &&
-		    as->suspend_state != SUSPEND_NONE) {
-			ret = -EBUSY;
-			goto out;
-		}
-	}
-
-	list_for_each_entry(as, &apm_user_list, list) {
-		if (as != sender && as->reader && as->writer && as->suser) {
-			as->suspend_state = SUSPEND_PENDING;
-			suspends_pending++;
-			queue_add_event(&as->queue, event);
-			ret = 0;
-		}
-	}
- out:
-	up_read(&user_list_lock);
-	mutex_unlock(&state_lock);
-	wake_up_interruptible(&apm_waitqueue);
-	return ret;
-}
-
-static void apm_suspend(void)
-{
-	struct apm_user *as;
-	int err = pm_suspend(PM_SUSPEND_MEM);
-
-	/*
-	 * Anyone on the APM queues will think we're still suspended.
-	 * Send a message so everyone knows we're now awake again.
-	 */
-	queue_event(APM_NORMAL_RESUME);
-
-	/*
-	 * Finally, wake up anyone who is sleeping on the suspend.
-	 */
-	mutex_lock(&state_lock);
-	down_read(&user_list_lock);
-	list_for_each_entry(as, &apm_user_list, list) {
-		if (as->suspend_state == SUSPEND_WAIT ||
-		    as->suspend_state == SUSPEND_ACKED) {
-			as->suspend_result = err;
-			as->suspend_state = SUSPEND_DONE;
-		}
-	}
-	up_read(&user_list_lock);
-	mutex_unlock(&state_lock);
-
-	wake_up(&apm_suspend_waitqueue);
-}
-
 static ssize_t apm_read(struct file *fp, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct apm_user *as = fp->private_data;
@@ -306,25 +278,22 @@ apm_ioctl(struct inode * inode, struct f
 
 		as->suspend_result = -EINTR;
 
-		if (as->suspend_state == SUSPEND_READ) {
-			int pending;
-
+		switch (as->suspend_state) {
+		case SUSPEND_READ:
 			/*
 			 * If we read a suspend command from /dev/apm_bios,
 			 * then the corresponding APM_IOC_SUSPEND ioctl is
 			 * interpreted as an acknowledge.
 			 */
 			as->suspend_state = SUSPEND_ACKED;
-			suspends_pending--;
-			pending = suspends_pending == 0;
+			atomic_dec(&suspend_acks_pending);
 			mutex_unlock(&state_lock);
 
 			/*
-			 * If there are no further acknowledges required,
-			 * suspend the system.
+			 * suspend_acks_pending changed, the notifier needs to be
+			 * woken up for this
 			 */
-			if (pending)
-				apm_suspend();
+			wake_up(&apm_suspend_waitqueue);
 
 			/*
 			 * Wait for the suspend/resume to complete.  If there
@@ -340,35 +309,21 @@ apm_ioctl(struct inode * inode, struct f
 			 * try_to_freeze() in freezer_count() will not trigger
 			 */
 			freezer_count();
-		} else {
+			break;
+		case SUSPEND_ACKTO:
+			as->suspend_result = -ETIMEDOUT;
+			mutex_unlock(&state_lock);
+			break;
+		default:
 			as->suspend_state = SUSPEND_WAIT;
 			mutex_unlock(&state_lock);
 
 			/*
 			 * Otherwise it is a request to suspend the system.
-			 * Queue an event for all readers, and expect an
-			 * acknowledge from all writers who haven't already
-			 * acknowledged.
-			 */
-			err = queue_suspend_event(APM_USER_SUSPEND, as);
-			if (err < 0) {
-				/*
-				 * Avoid taking the lock here - this
-				 * should be fine.
-				 */
-				as->suspend_state = SUSPEND_NONE;
-				break;
-			}
-
-			if (err > 0)
-				apm_suspend();
-
-			/*
-			 * Wait for the suspend/resume to complete.  If there
-			 * are pending acknowledges, we wait here for them.
+			 * Just invoke pm_suspend(), we'll handle it from
+			 * there via the notifier.
 			 */
-			wait_event_freezable(apm_suspend_waitqueue,
-					 as->suspend_state == SUSPEND_DONE);
+			as->suspend_result = pm_suspend(PM_SUSPEND_MEM);
 		}
 
 		mutex_lock(&state_lock);
@@ -384,7 +339,6 @@ apm_ioctl(struct inode * inode, struct f
 static int apm_release(struct inode * inode, struct file * filp)
 {
 	struct apm_user *as = filp->private_data;
-	int pending = 0;
 
 	filp->private_data = NULL;
 
@@ -394,18 +348,15 @@ static int apm_release(struct inode * in
 
 	/*
 	 * We are now unhooked from the chain.  As far as new
-	 * events are concerned, we no longer exist.  However, we
-	 * need to balance suspends_pending, which means the
-	 * possibility of sleeping.
+	 * events are concerned, we no longer exist.
 	 */
 	mutex_lock(&state_lock);
-	if (as->suspend_state != SUSPEND_NONE) {
-		suspends_pending -= 1;
-		pending = suspends_pending == 0;
-	}
+	if (as->suspend_state == SUSPEND_PENDING ||
+	    as->suspend_state == SUSPEND_READ)
+		atomic_dec(&suspend_acks_pending);
 	mutex_unlock(&state_lock);
-	if (pending)
-		apm_suspend();
+
+	wake_up(&apm_suspend_waitqueue);
 
 	kfree(as);
 	return 0;
@@ -529,7 +480,6 @@ static int kapmd(void *arg)
 {
 	do {
 		apm_event_t event;
-		int ret;
 
 		wait_event_interruptible(kapmd_wait,
 				!queue_empty(&kapmd_queue) || kthread_should_stop());
@@ -554,20 +504,13 @@ static int kapmd(void *arg)
 
 		case APM_USER_SUSPEND:
 		case APM_SYS_SUSPEND:
-			ret = queue_suspend_event(event, NULL);
-			if (ret < 0) {
-				/*
-				 * We were busy.  Try again in 50ms.
-				 */
-				queue_add_event(&kapmd_queue, event);
-				msleep(50);
-			}
-			if (ret > 0)
-				apm_suspend();
+			pm_suspend(PM_SUSPEND_MEM);
 			break;
 
 		case APM_CRITICAL_SUSPEND:
-			apm_suspend();
+			atomic_inc(&userspace_notification_inhibit);
+			pm_suspend(PM_SUSPEND_MEM);
+			atomic_dec(&userspace_notification_inhibit);
 			break;
 		}
 	} while (1);
@@ -575,6 +518,120 @@ static int kapmd(void *arg)
 	return 0;
 }
 
+static int apm_suspend_notifier(struct notifier_block *nb,
+				unsigned long event,
+				void *dummy)
+{
+	struct apm_user *as;
+	int err;
+
+	/* short-cut emergency suspends */
+	if (atomic_read(&userspace_notification_inhibit))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case PM_SUSPEND_PREPARE:
+		/*
+		 * Queue an event to all "writer" users that we want
+		 * to suspend and need their ack.
+		 */
+		mutex_lock(&state_lock);
+		down_read(&user_list_lock);
+
+		list_for_each_entry(as, &apm_user_list, list) {
+			if (as->suspend_state != SUSPEND_WAIT && as->reader &&
+			    as->writer && as->suser) {
+				as->suspend_state = SUSPEND_PENDING;
+				atomic_inc(&suspend_acks_pending);
+				queue_add_event(&as->queue, APM_USER_SUSPEND);
+			}
+		}
+
+		up_read(&user_list_lock);
+		mutex_unlock(&state_lock);
+		wake_up_interruptible(&apm_waitqueue);
+
+		/*
+		 * Wait for the the suspend_acks_pending variable to drop to zero,
+		 * meaning everybody acked the suspend event (or the process
+		 * was killed.)
+		 *
+		 * If the app won't answer within a short while we assume it
+		 * locked up and ignore it.
+		 */
+		err = wait_event_interruptible_timeout(
+			apm_suspend_waitqueue,
+			atomic_read(&suspend_acks_pending) == 0,
+			5*HZ);
+
+		/* timed out */
+		if (err == 0) {
+			/*
+			 * Move anybody who timed out to "ack timeout" state.
+			 *
+			 * We could time out and the userspace does the ACK
+			 * right after we time out but before we enter the
+			 * locked section here, but that's fine.
+			 */
+			mutex_lock(&state_lock);
+			down_read(&user_list_lock);
+			list_for_each_entry(as, &apm_user_list, list) {
+				if (as->suspend_state == SUSPEND_PENDING ||
+				    as->suspend_state == SUSPEND_READ) {
+					as->suspend_state = SUSPEND_ACKTO;
+					atomic_dec(&suspend_acks_pending);
+				}
+			}
+			up_read(&user_list_lock);
+			mutex_unlock(&state_lock);
+		}
+
+		/* let suspend proceed */
+		if (err >= 0)
+			return NOTIFY_OK;
+
+		/* interrupted by signal */
+		return NOTIFY_BAD;
+
+	case PM_POST_SUSPEND:
+		/*
+		 * Anyone on the APM queues will think we're still suspended.
+		 * Send a message so everyone knows we're now awake again.
+		 */
+		queue_event(APM_NORMAL_RESUME);
+
+		/*
+		 * Finally, wake up anyone who is sleeping on the suspend.
+		 */
+		mutex_lock(&state_lock);
+		down_read(&user_list_lock);
+		list_for_each_entry(as, &apm_user_list, list) {
+			if (as->suspend_state == SUSPEND_ACKED) {
+				/*
+				 * TODO: maybe grab error code, needs core
+				 * changes to push the error to the notifier
+				 * chain (could use the second parameter if
+				 * implemented)
+				 */
+				as->suspend_result = 0;
+				as->suspend_state = SUSPEND_DONE;
+			}
+		}
+		up_read(&user_list_lock);
+		mutex_unlock(&state_lock);
+
+		wake_up(&apm_suspend_waitqueue);
+		return NOTIFY_OK;
+
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static struct notifier_block apm_notif_block = {
+	.notifier_call = apm_suspend_notifier,
+};
+
 static int __init apm_init(void)
 {
 	int ret;
@@ -588,7 +645,7 @@ static int __init apm_init(void)
 	if (IS_ERR(kapmd_tsk)) {
 		ret = PTR_ERR(kapmd_tsk);
 		kapmd_tsk = NULL;
-		return ret;
+		goto out;
 	}
 	wake_up_process(kapmd_tsk);
 
@@ -597,16 +654,27 @@ static int __init apm_init(void)
 #endif
 
 	ret = misc_register(&apm_device);
-	if (ret != 0) {
-		remove_proc_entry("apm", NULL);
-		kthread_stop(kapmd_tsk);
-	}
+	if (ret)
+		goto out_stop;
 
+	ret = register_pm_notifier(&apm_notif_block);
+	if (ret)
+		goto out_unregister;
+
+	return 0;
+
+ out_unregister:
+	misc_deregister(&apm_device);
+ out_stop:
+	remove_proc_entry("apm", NULL);
+	kthread_stop(kapmd_tsk);
+ out:
 	return ret;
 }
 
 static void __exit apm_exit(void)
 {
+	unregister_pm_notifier(&apm_notif_block);
 	misc_deregister(&apm_device);
 	remove_proc_entry("apm", NULL);
 
