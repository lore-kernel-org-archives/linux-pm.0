From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [RFC] apm-emulation: implement notify/ack for
	/sys/power/state events
Date: Sun, 16 Dec 2007 21:49:22 +0100
Message-ID: <1197838162.6769.33.camel@johannes.berg>
References: <1197827906.6769.7.camel@johannes.berg>
	<1197831551.6769.13.camel@johannes.berg>
	<1197833664.6769.17.camel@johannes.berg>
	<200712162156.08920.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712162156.08920.rjw@sisk.pl>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Jamey Hicks <jamey@crl.dec.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-pm@vger.kernel.org

[reordering]

> > +              *
> > +              * FIXME: is the suspends_pending == 1 test racy?
> 
> Remove the FIXME comment?

Yes, doh, thanks!

> Hm, will suspends_pending drop if it gets killed?

Yes.

> With the timeout, we can either suspend even if there's a rogue process, or
> fail the suspend altogether.

I think it should suspend anyway.

> Failing should be safe even if the process acks
> the suspend afterwards.

Yes, it'd suspend then.

>   Suspending without an ack would be harder, but
> seems doable if we set (suspends_pending = 0) unconditionally below and use
> atomic_add_unless() instead of atomic_dec() in the other places (checking
> that for the result).

No, that'd be racy. We have to go through the list and dec
suspends_pending for everybody still in READ state, then what I do is
send them to ACKTO (ack timeout) state and return -ETIMEDOUT for their
ack ioctl if they're in ACKTO state.

Patch below, tested with my test program with an additional sleep(10) in
it.

johannes

---
 drivers/char/apm-emulation.c |  156 +++++++++++++++++++++++++++++++++++++------
 kernel/power/main.c          |    1 
 2 files changed, 138 insertions(+), 19 deletions(-)

--- everything.orig/drivers/char/apm-emulation.c	2007-12-16 15:22:49.889513942 +0100
+++ everything/drivers/char/apm-emulation.c	2007-12-16 21:42:43.749024090 +0100
@@ -74,6 +74,7 @@ struct apm_user {
 #define SUSPEND_ACKED	3		/* suspend acked */
 #define SUSPEND_WAIT	4		/* waiting for suspend */
 #define SUSPEND_DONE	5		/* suspend completed */
+#define SUSPEND_ACKTO	6		/* suspend ack timeout */
 
 	struct apm_queue	queue;
 };
@@ -81,7 +82,7 @@ struct apm_user {
 /*
  * Local variables
  */
-static int suspends_pending;
+static atomic_t suspends_pending;
 static int apm_disabled;
 static struct task_struct *kapmd_tsk;
 
@@ -171,6 +172,8 @@ static void queue_event(apm_event_t even
  * return -EBUSY.  Otherwise, queue an event to all "writer"
  * users.  If there are no "writer" users, return '1' to
  * indicate that we can immediately suspend.
+ *
+ * @sender can be NULL when the event is queued from /sys/power/state
  */
 static int queue_suspend_event(apm_event_t event, struct apm_user *sender)
 {
@@ -195,7 +198,7 @@ static int queue_suspend_event(apm_event
 	list_for_each_entry(as, &apm_user_list, list) {
 		if (as != sender && as->reader && as->writer && as->suser) {
 			as->suspend_state = SUSPEND_PENDING;
-			suspends_pending++;
+			atomic_inc(&suspends_pending);
 			queue_add_event(&as->queue, event);
 			ret = 0;
 		}
@@ -207,10 +210,9 @@ static int queue_suspend_event(apm_event
 	return ret;
 }
 
-static void apm_suspend(void)
+static void apm_after_resume(int err)
 {
 	struct apm_user *as;
-	int err = pm_suspend(PM_SUSPEND_MEM);
 
 	/*
 	 * Anyone on the APM queues will think we're still suspended.
@@ -236,6 +238,13 @@ static void apm_suspend(void)
 	wake_up(&apm_suspend_waitqueue);
 }
 
+static void apm_suspend(void)
+{
+	int err = pm_suspend(PM_SUSPEND_MEM);
+
+	apm_after_resume(err);
+}
+
 static ssize_t apm_read(struct file *fp, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct apm_user *as = fp->private_data;
@@ -296,6 +305,7 @@ apm_ioctl(struct inode * inode, struct f
 {
 	struct apm_user *as = filp->private_data;
 	int err = -EINVAL;
+	int pending;
 
 	if (!as->suser || !as->writer)
 		return -EPERM;
@@ -306,20 +316,24 @@ apm_ioctl(struct inode * inode, struct f
 
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
+			pending = atomic_dec_and_test(&suspends_pending);
 			mutex_unlock(&state_lock);
 
 			/*
+			 * suspends_pending changed, the notifier needs to be
+			 * woken up for this
+			 */
+			wake_up(&apm_suspend_waitqueue);
+
+			/*
 			 * If there are no further acknowledges required,
 			 * suspend the system.
 			 */
@@ -340,7 +354,13 @@ apm_ioctl(struct inode * inode, struct f
 			 * try_to_freeze() in freezer_count() will not trigger
 			 */
 			freezer_count();
-		} else {
+			break;
+		case SUSPEND_ACKTO:
+			as->suspend_state = SUSPEND_NONE;
+			as->suspend_result = -ETIMEDOUT;
+			mutex_unlock(&state_lock);
+			break;
+		default:
 			as->suspend_state = SUSPEND_WAIT;
 			mutex_unlock(&state_lock);
 
@@ -399,11 +419,12 @@ static int apm_release(struct inode * in
 	 * possibility of sleeping.
 	 */
 	mutex_lock(&state_lock);
-	if (as->suspend_state != SUSPEND_NONE) {
-		suspends_pending -= 1;
-		pending = suspends_pending == 0;
-	}
+	if (as->suspend_state != SUSPEND_NONE)
+		pending = atomic_dec_and_test(&suspends_pending);
 	mutex_unlock(&state_lock);
+
+	wake_up(&apm_suspend_waitqueue);
+
 	if (pending)
 		apm_suspend();
 
@@ -575,6 +596,92 @@ static int kapmd(void *arg)
 	return 0;
 }
 
+int apm_suspend_notifier(struct notifier_block *nb,
+			 unsigned long event,
+			 void *dummy)
+{
+	int err;
+
+	switch (event) {
+	case PM_SUSPEND_PREPARE:
+		/*
+		 * This is a bit of a hack. We tell the rest of the code that we
+		 * still have a suspend pending and then go suspend ourselves.
+		 * We have to do it this way because otherwise we'll call
+		 * pm_sleep() when suspend_pending drops to zero which would
+		 * return -EBUSY and confuse everything.
+		 */
+		atomic_inc(&suspends_pending);
+
+		err = queue_suspend_event(APM_SYS_SUSPEND, NULL);
+		if (err < 0)
+			return NOTIFY_BAD;
+
+		/* all's well, nobody to wait for */
+		if (err > 0)
+			return NOTIFY_OK;
+
+		/*
+		 * Wait for the the suspends_pending variable to drop to 1,
+		 * meaning everybody else acked the suspend event (or the
+		 * process was killed.)
+		 *
+		 * If the app won't answer within a short while we assume
+		 * it locked itself up and ignore it, the count will be
+		 * fixed up later.
+		 */
+		err = wait_event_interruptible_timeout(
+			apm_suspend_waitqueue,
+			atomic_read(&suspends_pending) == 1,
+			5*HZ);
+
+		/* timed out */
+		if (err == 0) {
+			struct apm_user *as;
+
+			/*
+			 * Move anybody who timed out to ack timeout state.
+			 *
+			 * We could time out and the userspace does the ACK
+			 * right after we time out but before we enter the
+			 * locked section here, but that's fine.
+			 */
+			mutex_lock(&state_lock);
+			down_read(&user_list_lock);
+			list_for_each_entry(as, &apm_user_list, list) {
+				if (as->suspend_state == SUSPEND_READ) {
+					printk(KERN_DEBUG "apm-emu: got timeout\n");
+					as->suspend_state = SUSPEND_ACKTO;
+					atomic_dec(&suspends_pending);
+				}
+			}
+			up_read(&user_list_lock);
+			mutex_unlock(&state_lock);
+		}
+
+		atomic_dec(&suspends_pending);
+
+		/* let suspend proceed */
+		if (err >= 0)
+			return NOTIFY_OK;
+
+		/* interrupted by signal */
+		return NOTIFY_BAD;
+
+	case PM_POST_SUSPEND:
+		/* TODO: maybe grab error code, needs core changes */
+		apm_after_resume(0);
+		return NOTIFY_OK;
+
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+struct notifier_block apm_notif_block = {
+	.notifier_call = apm_suspend_notifier,
+};
+
 static int __init apm_init(void)
 {
 	int ret;
@@ -588,7 +695,7 @@ static int __init apm_init(void)
 	if (IS_ERR(kapmd_tsk)) {
 		ret = PTR_ERR(kapmd_tsk);
 		kapmd_tsk = NULL;
-		return ret;
+		goto out;
 	}
 	wake_up_process(kapmd_tsk);
 
@@ -597,16 +704,27 @@ static int __init apm_init(void)
 #endif
 
 	ret = misc_register(&apm_device);
-	if (ret != 0) {
-		remove_proc_entry("apm", NULL);
-		kthread_stop(kapmd_tsk);
-	}
+	if (ret)
+		goto out_stop;
+
+	ret = register_pm_notifier(&apm_notif_block);
+	if (ret)
+		goto out_unregister;
 
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
 
--- everything.orig/kernel/power/main.c	2007-12-16 15:23:18.689514811 +0100
+++ everything/kernel/power/main.c	2007-12-16 15:31:06.179512207 +0100
@@ -25,6 +25,7 @@
 #include "power.h"
 
 BLOCKING_NOTIFIER_HEAD(pm_chain_head);
+EXPORT_SYMBOL_GPL(pm_chain_head);
 
 DEFINE_MUTEX(pm_mutex);
 
