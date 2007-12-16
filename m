From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC] apm-emulation: implement notify/ack for
	/sys/power/state events
Date: Sun, 16 Dec 2007 18:58:26 +0100
Message-ID: <1197827906.6769.7.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Jamey Hicks <jamey@crl.dec.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-pm@vger.kernel.org

Currently, apm-emulation only implements notify/ack for events that are
initiated by the apm-emulation code itself. That doesn't work out quite
so well when X relies on the apm-emulation and you use scripts to
suspend that simply use /sys/power/state. Ultimately, those scripts
ought to notify userspace themselves, but currently X relies on apm
notifications.

This patch implements the required notification.

Rafael already told me that the EXPORT_SYMBOL_GPL() this patch adds will
no longer be required. If this patch is merged before the suspend tree
(though it probably should go through the suspend tree), that is
required, otherwise it should be removed.

I have *NOT* tested this patch with X, only with a simple dummy program
that does the apm emulation code, available here:
http://johannes.sipsolutions.net/files/test-apm-emu.c.txt

Not-yet-signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 drivers/char/apm-emulation.c |  108 ++++++++++++++++++++++++++++++++++++++++---
 kernel/power/main.c          |    1 
 2 files changed, 102 insertions(+), 7 deletions(-)

--- everything.orig/drivers/char/apm-emulation.c	2007-12-16 15:22:49.889513942 +0100
+++ everything/drivers/char/apm-emulation.c	2007-12-16 18:57:54.555874295 +0100
@@ -171,6 +171,8 @@ static void queue_event(apm_event_t even
  * return -EBUSY.  Otherwise, queue an event to all "writer"
  * users.  If there are no "writer" users, return '1' to
  * indicate that we can immediately suspend.
+ *
+ * @sender can be NULL when the event is queued from /sys/power/state
  */
 static int queue_suspend_event(apm_event_t event, struct apm_user *sender)
 {
@@ -207,10 +209,9 @@ static int queue_suspend_event(apm_event
 	return ret;
 }
 
-static void apm_suspend(void)
+static void apm_after_resume(int err)
 {
 	struct apm_user *as;
-	int err = pm_suspend(PM_SUSPEND_MEM);
 
 	/*
 	 * Anyone on the APM queues will think we're still suspended.
@@ -236,6 +237,13 @@ static void apm_suspend(void)
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
@@ -320,6 +328,12 @@ apm_ioctl(struct inode * inode, struct f
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
@@ -404,6 +418,8 @@ static int apm_release(struct inode * in
 		pending = suspends_pending == 0;
 	}
 	mutex_unlock(&state_lock);
+	wake_up(&apm_suspend_waitqueue);
+
 	if (pending)
 		apm_suspend();
 
@@ -575,6 +591,73 @@ static int kapmd(void *arg)
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
+		mutex_lock(&state_lock);
+		suspends_pending++;
+		mutex_unlock(&state_lock);
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
+		 * Unfortunately we cannot do a timeout because then we'd
+		 * suspend again right away if the process that had apm_bios
+		 * open and that we timed out waiting for "acknowledges" the
+		 * event after we have resumed. If suspend doesn't work because
+		 * of a rogue process, just kill that process.
+		 *
+		 * FIXME: is the suspends_pending == 1 test racy?
+		 */
+		err = wait_event_interruptible(apm_suspend_waitqueue,
+					       suspends_pending == 1);
+
+		mutex_lock(&state_lock);
+		suspends_pending--;
+		mutex_unlock(&state_lock);
+
+		if (!err)
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
@@ -588,7 +671,7 @@ static int __init apm_init(void)
 	if (IS_ERR(kapmd_tsk)) {
 		ret = PTR_ERR(kapmd_tsk);
 		kapmd_tsk = NULL;
-		return ret;
+		goto out;
 	}
 	wake_up_process(kapmd_tsk);
 
@@ -597,16 +680,27 @@ static int __init apm_init(void)
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
 
