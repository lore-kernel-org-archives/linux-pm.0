From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 2/6] Freezer: Do not send signals to
	kernel threads
Date: Mon, 9 Jul 2007 22:32:00 +0200
Message-ID: <200707092232.01603.rjw@sisk.pl>
References: <200707092229.08898.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707092229.08898.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Commit b74d0deb968e1f85942f17080eace015ce3c332c has changed
recalc_sigpending_tsk() so that it doesn't clear TIF_SIGPENDING.  For this
reason, the freezer should not send fake signals to kernel threads any more,
since otherwise some of them may run with TIF_SIGPENDING set forever if the
freezing of kernel threads fails.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/power/freezing-of-tasks.txt |   31 +++++----
 drivers/input/gameport/gameport.c         |    3 
 drivers/input/serio/serio.c               |    3 
 drivers/input/touchscreen/ucb1400_ts.c    |    3 
 drivers/media/dvb/dvb-core/dvb_frontend.c |    3 
 drivers/usb/core/hub.c                    |    3 
 drivers/usb/storage/usb.c                 |    5 -
 include/linux/freezer.h                   |   38 +++++++++++
 kernel/power/process.c                    |   97 +++++++++++++++++++++++-------
 kernel/signal.c                           |    1 
 10 files changed, 137 insertions(+), 50 deletions(-)

Index: linux-2.6.22-rc6-mm1/kernel/power/process.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/kernel/power/process.c
+++ linux-2.6.22-rc6-mm1/kernel/power/process.c
@@ -75,21 +75,88 @@ void refrigerator(void)
 	__set_current_state(save);
 }
 
-static void freeze_task(struct task_struct *p)
+static void fake_signal_wake_up(struct task_struct *p, int resume)
 {
 	unsigned long flags;
 
-	if (!freezing(p)) {
+	spin_lock_irqsave(&p->sighand->siglock, flags);
+	signal_wake_up(p, resume);
+	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+}
+
+static void send_fake_signal(struct task_struct *p)
+{
+	if (p->state == TASK_STOPPED)
+		force_sig_specific(SIGSTOP, p);
+	fake_signal_wake_up(p, p->state == TASK_STOPPED);
+}
+
+static int has_mm(struct task_struct *p)
+{
+	return (p->mm && !(p->flags & PF_BORROWED_MM));
+}
+
+/**
+ *	freeze_user_process - set TIF_FREEZE for user space process @p and
+ *			      send fake signal to it
+ *
+ *	Kernel threads should not have TIF_FREEZE set at this point, so we must
+ *	ensure that either p->mm is not NULL *and* PF_BORROWED_MM is unset, or
+ *	TIF_FRREZE is left unset.  The task_lock() is necessary to prevent races
+ *	with exit_mm() or use_mm()/unuse_mm() from occuring.
+ */
+static int freeze_user_process(struct task_struct *p)
+{
+	int ret = 1;
+
+	task_lock(p);
+	if (has_mm(p)) {
+		if (freezing(p)) {
+			if (!signal_pending(p))
+				fake_signal_wake_up(p, 0);
+			else
+				wake_up_state(p, TASK_INTERRUPTIBLE);
+		} else {
+			rmb();
+			if (!frozen(p)) {
+				set_freeze_flag(p);
+				send_fake_signal(p);
+			}
+		}
+	} else {
+		ret = 0;
+	}
+	task_unlock(p);
+	return ret;
+}
+
+/**
+ *	freeze_task - set TIF_FREEZE for task @p and either wake it up or send
+ *		      fake signal to it depending on whether or not it is a
+ *		      kernel thread
+ *
+ *	The task_lock() is necessary to prevent races with exit_mm() or
+ *	use_mm()/unuse_mm() from occuring.
+ */
+static void freeze_task(struct task_struct *p)
+{
+	task_lock(p);
+	if (freezing(p)) {
+		if (has_mm(p) && !signal_pending(p))
+			fake_signal_wake_up(p, 0);
+		else
+			wake_up_state(p, TASK_INTERRUPTIBLE);
+	} else {
 		rmb();
 		if (!frozen(p)) {
 			set_freeze_flag(p);
-			if (p->state == TASK_STOPPED)
-				force_sig_specific(SIGSTOP, p);
-			spin_lock_irqsave(&p->sighand->siglock, flags);
-			signal_wake_up(p, p->state == TASK_STOPPED);
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
+			if (has_mm(p))
+				send_fake_signal(p);
+			else
+				wake_up_state(p, TASK_INTERRUPTIBLE);
 		}
 	}
+	task_unlock(p);
 }
 
 static void cancel_freezing(struct task_struct *p)
@@ -125,22 +192,8 @@ static int try_to_freeze_tasks(int freez
 					cancel_freezing(p);
 					continue;
 				}
-				/*
-				 * Kernel threads should not have TIF_FREEZE set
-				 * at this point, so we must ensure that either
-				 * p->mm is not NULL *and* PF_BORROWED_MM is
-				 * unset, or TIF_FRREZE is left unset.
-				 * The task_lock() is necessary to prevent races
-				 * with exit_mm() or use_mm()/unuse_mm() from
-				 * occuring.
-				 */
-				task_lock(p);
-				if (!p->mm || (p->flags & PF_BORROWED_MM)) {
-					task_unlock(p);
+				if (!freeze_user_process(p))
 					continue;
-				}
-				freeze_task(p);
-				task_unlock(p);
 			} else {
 				freeze_task(p);
 			}
Index: linux-2.6.22-rc6-mm1/kernel/signal.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/kernel/signal.c
+++ linux-2.6.22-rc6-mm1/kernel/signal.c
@@ -99,7 +99,6 @@ static inline int has_pending_signals(si
 static int recalc_sigpending_tsk(struct task_struct *t)
 {
 	if (t->signal->group_stop_count > 0 ||
-	    (freezing(t)) ||
 	    PENDING(&t->pending, &t->blocked) ||
 	    PENDING(&t->signal->shared_pending, &t->blocked)) {
 		set_tsk_thread_flag(t, TIF_SIGPENDING);
Index: linux-2.6.22-rc6-mm1/include/linux/freezer.h
===================================================================
--- linux-2.6.22-rc6-mm1.orig/include/linux/freezer.h
+++ linux-2.6.22-rc6-mm1/include/linux/freezer.h
@@ -4,6 +4,7 @@
 #define FREEZER_H_INCLUDED
 
 #include <linux/sched.h>
+#include <linux/wait.h>
 
 #ifdef CONFIG_PM
 /*
@@ -126,7 +127,33 @@ static inline void set_freezable(void)
 	current->flags &= ~PF_NOFREEZE;
 }
 
-#else
+/*
+ * Freezer-friendly wrappers around wait_event_interruptible() and
+ * wait_event_interruptible_timeout(), originally defined in <linux/wait.h>
+ */
+
+#define wait_event_freezable(wq, condition)				\
+({									\
+	int __ret;							\
+	do {								\
+		__ret = wait_event_interruptible(wq, 			\
+				(condition) || freezing(current));	\
+	} while (try_to_freeze());					\
+	__ret;								\
+})
+
+
+#define wait_event_freezable_timeout(wq, condition, timeout)		\
+({									\
+	long __ret = timeout;						\
+	do {								\
+		__ret = wait_event_interruptible_timeout(wq,		\
+				(condition) || freezing(current),	\
+				__ret); 				\
+	} while (try_to_freeze());					\
+	__ret;								\
+})
+#else /* CONFIG_PM */
 static inline int frozen(struct task_struct *p) { return 0; }
 static inline int freezing(struct task_struct *p) { return 0; }
 static inline void set_freeze_flag(struct task_struct *p) {}
@@ -143,6 +170,13 @@ static inline void freezer_do_not_count(
 static inline void freezer_count(void) {}
 static inline int freezer_should_skip(struct task_struct *p) { return 0; }
 static inline void set_freezable(void) {}
-#endif
+
+#define wait_event_freezable(wq, condition)				\
+		wait_event_interruptible(wq, condition)
+
+#define wait_event_freezable_timeout(wq, condition, timeout)		\
+		wait_event_interruptible_timeout(wq, condition, timeout)
+
+#endif /* CONFIG_PM */
 
 #endif	/* FREEZER_H_INCLUDED */
Index: linux-2.6.22-rc6-mm1/drivers/input/gameport/gameport.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/drivers/input/gameport/gameport.c
+++ linux-2.6.22-rc6-mm1/drivers/input/gameport/gameport.c
@@ -448,9 +448,8 @@ static int gameport_thread(void *nothing
 	set_freezable();
 	do {
 		gameport_handle_event();
-		wait_event_interruptible(gameport_wait,
+		wait_event_freezable(gameport_wait,
 			kthread_should_stop() || !list_empty(&gameport_event_list));
-		try_to_freeze();
 	} while (!kthread_should_stop());
 
 	printk(KERN_DEBUG "gameport: kgameportd exiting\n");
Index: linux-2.6.22-rc6-mm1/drivers/input/serio/serio.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/drivers/input/serio/serio.c
+++ linux-2.6.22-rc6-mm1/drivers/input/serio/serio.c
@@ -387,9 +387,8 @@ static int serio_thread(void *nothing)
 	set_freezable();
 	do {
 		serio_handle_event();
-		wait_event_interruptible(serio_wait,
+		wait_event_freezable(serio_wait,
 			kthread_should_stop() || !list_empty(&serio_event_list));
-		try_to_freeze();
 	} while (!kthread_should_stop());
 
 	printk(KERN_DEBUG "serio: kseriod exiting\n");
Index: linux-2.6.22-rc6-mm1/drivers/input/touchscreen/ucb1400_ts.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/drivers/input/touchscreen/ucb1400_ts.c
+++ linux-2.6.22-rc6-mm1/drivers/input/touchscreen/ucb1400_ts.c
@@ -334,10 +334,9 @@ static int ucb1400_ts_thread(void *_ucb)
 			timeout = msecs_to_jiffies(10);
 		}
 
-		wait_event_interruptible_timeout(ucb->ts_wait,
+		wait_event_freezable_timeout(ucb->ts_wait,
 			ucb->irq_pending || ucb->ts_restart || kthread_should_stop(),
 			timeout);
-		try_to_freeze();
 	}
 
 	/* Send the "pen off" if we are stopping with the pen still active */
Index: linux-2.6.22-rc6-mm1/drivers/media/dvb/dvb-core/dvb_frontend.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/drivers/media/dvb/dvb-core/dvb_frontend.c
+++ linux-2.6.22-rc6-mm1/drivers/media/dvb/dvb-core/dvb_frontend.c
@@ -528,7 +528,8 @@ static int dvb_frontend_thread(void *dat
 		up(&fepriv->sem);	    /* is locked when we enter the thread... */
 restart:
 		timeout = wait_event_interruptible_timeout(fepriv->wait_queue,
-			dvb_frontend_should_wakeup(fe) || kthread_should_stop(),
+			dvb_frontend_should_wakeup(fe) || kthread_should_stop()
+				|| freezing(current),
 			fepriv->delay);
 
 		if (kthread_should_stop() || dvb_frontend_is_exiting(fe)) {
Index: linux-2.6.22-rc6-mm1/drivers/usb/core/hub.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/drivers/usb/core/hub.c
+++ linux-2.6.22-rc6-mm1/drivers/usb/core/hub.c
@@ -2729,10 +2729,9 @@ static int hub_thread(void *__unused)
 	set_freezable();
 	do {
 		hub_events();
-		wait_event_interruptible(khubd_wait,
+		wait_event_freezable(khubd_wait,
 				!list_empty(&hub_event_list) ||
 				kthread_should_stop());
-		try_to_freeze();
 	} while (!kthread_should_stop() || !list_empty(&hub_event_list));
 
 	pr_debug("%s: khubd exiting\n", usbcore_name);
Index: linux-2.6.22-rc6-mm1/drivers/usb/storage/usb.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/drivers/usb/storage/usb.c
+++ linux-2.6.22-rc6-mm1/drivers/usb/storage/usb.c
@@ -913,12 +913,9 @@ static int usb_stor_scan_thread(void * _
 	if (delay_use > 0) {
 		printk(KERN_DEBUG "usb-storage: waiting for device "
 				"to settle before scanning\n");
-retry:
-		wait_event_interruptible_timeout(us->delay_wait,
+		wait_event_freezable_timeout(us->delay_wait,
 				test_bit(US_FLIDX_DISCONNECTING, &us->flags),
 				delay_use * HZ);
-		if (try_to_freeze())
-			goto retry;
 	}
 
 	/* If the device is still connected, perform the scanning */
Index: linux-2.6.22-rc6-mm1/Documentation/power/freezing-of-tasks.txt
===================================================================
--- linux-2.6.22-rc6-mm1.orig/Documentation/power/freezing-of-tasks.txt
+++ linux-2.6.22-rc6-mm1/Documentation/power/freezing-of-tasks.txt
@@ -19,12 +19,13 @@ we only consider hibernation, but the de
 Namely, as the first step of the hibernation procedure the function
 freeze_processes() (defined in kernel/power/process.c) is called.  It executes
 try_to_freeze_tasks() that sets TIF_FREEZE for all of the freezable tasks and
-sends a fake signal to each of them.  A task that receives such a signal and has
-TIF_FREEZE set, should react to it by calling the refrigerator() function
-(defined in kernel/power/process.c), which sets the task's PF_FROZEN flag,
-changes its state to TASK_UNINTERRUPTIBLE and makes it loop until PF_FROZEN is
-cleared for it.  Then, we say that the task is 'frozen' and therefore the set of
-functions handling this mechanism is called 'the freezer' (these functions are
+either wakes them up, if they are kernel threads, or sends fake signals to them,
+if they are user space processes.  A task that has TIF_FREEZE set, should react
+to it by calling the function called refrigerator() (defined in
+kernel/power/process.c), which sets the task's PF_FROZEN flag, changes its state
+to TASK_UNINTERRUPTIBLE and makes it loop until PF_FROZEN is cleared for it.
+Then, we say that the task is 'frozen' and therefore the set of functions
+handling this mechanism is referred to as 'the freezer' (these functions are
 defined in kernel/power/process.c and include/linux/freezer.h).  User space
 processes are generally frozen before kernel threads.
 
@@ -35,21 +36,27 @@ task enter refrigerator() if the flag is
 
 For user space processes try_to_freeze() is called automatically from the
 signal-handling code, but the freezable kernel threads need to call it
-explicitly in suitable places.  The code to do this may look like the following:
+explicitly in suitable places or use the wait_event_freezable() or
+wait_event_freezable_timeout() macros (defined in include/linux/freezer.h)
+that combine interruptible sleep with checking if TIF_FREEZE is set and calling
+try_to_freeze().  The main loop of a freezable kernel thread may look like the
+following one:
 
+	set_freezable();
 	do {
 		hub_events();
-		wait_event_interruptible(khubd_wait,
-					!list_empty(&hub_event_list));
-		try_to_freeze();
-	} while (!signal_pending(current));
+		wait_event_freezable(khubd_wait,
+				!list_empty(&hub_event_list) ||
+				kthread_should_stop());
+	} while (!kthread_should_stop() || !list_empty(&hub_event_list));
 
 (from drivers/usb/core/hub.c::hub_thread()).
 
 If a freezable kernel thread fails to call try_to_freeze() after the freezer has
 set TIF_FREEZE for it, the freezing of tasks will fail and the entire
 hibernation operation will be cancelled.  For this reason, freezable kernel
-threads must call try_to_freeze() somewhere.
+threads must call try_to_freeze() somewhere or use one of the
+wait_event_freezable() and wait_event_freezable_timeout() macros.
 
 After the system memory state has been restored from a hibernation image and
 devices have been reinitialized, the function thaw_processes() is called in
