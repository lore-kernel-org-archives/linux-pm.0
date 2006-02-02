From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFC][PATCH -mm][Experimental] swsusp: freeze
	userspace processes first
Date: Thu, 2 Feb 2006 19:32:21 +0100
Message-ID: <200602021932.21629.rjw@sisk.pl>
References: <200602010141.53974.rjw@sisk.pl> <200602021455.01745.rjw@sisk.pl>
	<20060202150830.GA8944@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060202150830.GA8944@ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thursday 02 February 2006 16:08, Pavel Machek wrote:
> > That requires a timeout in case we have a user mode helper in the D state.
> > The corrected patch is appended.
> > 
> > BTW, it contains a change that may help solve the unfreezeable gcc problem
> > that has appeared in your tests.  Could you please try it or tell me what I
> > should do to reproduce the problem?
> 
> I'm away from real macine just now... I could reproduce it with
> Nigel's "stress ..." command, then trying to build kernel.

OK, I did the following:
1) run "swapoff -a"
2) run kernel make on one vt,
3) run "stress -d 5 --hdd-bytes 100M -i 5 -c 5" on another vt,
4) run "for f in 1 2 3 4 5 6 7 8 9 10; do echo disk > /sys/power/state ; sleep 5; done" on the 3rd vt.

Appended is the version of the patch that has freezed processes in 10 attempts
out of 10 (please note the "if (!freezing(p))" in freeze_process() ;-)).

Still freezing the userspace processes may take more that 15 secs under such
a load on my box, so the timeout is set to 20 sec (probably overkill for any
sane real-life situation).

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 include/linux/suspend.h |    6 +++
 kernel/kmod.c           |   19 ++++++++++
 kernel/power/disk.c     |    1 
 kernel/power/process.c  |   85 +++++++++++++++++++++++++++++++++++++++---------
 kernel/power/user.c     |    1 
 5 files changed, 95 insertions(+), 17 deletions(-)

Index: linux-2.6.16-rc1-mm4/kernel/power/process.c
===================================================================
--- linux-2.6.16-rc1-mm4.orig/kernel/power/process.c
+++ linux-2.6.16-rc1-mm4/kernel/power/process.c
@@ -12,12 +12,20 @@
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/syscalls.h>
 
 /* 
  * Timeout for stopping processes
  */
-#define TIMEOUT	(6 * HZ)
+#define TIMEOUT	(20 * HZ)
 
+/* This is used to disable usermodehelper invocations while
+ * freeze_processes() is being executed
+ */
+DEFINE_MUTEX(freezer_lock);
+int freezing_processes;
+atomic_t usermodehelper_waiting = ATOMIC_INIT(0);
 
 static inline int freezeable(struct task_struct * p)
 {
@@ -54,48 +62,95 @@ void refrigerator(void)
 	current->state = save;
 }
 
+static inline void freeze_process(struct task_struct *p)
+{
+	unsigned long flags;
+
+	if (!freezing(p)) {
+		freeze(p);
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		signal_wake_up(p, 0);
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	}
+}
+
 /* 0 = success, else # of processes that we failed to stop */
 int freeze_processes(void)
 {
-	int todo;
+	int todo, nr_user, user_frozen;
 	unsigned long start_time;
 	struct task_struct *g, *p;
 	unsigned long flags;
 
+	start_time = jiffies;
+	mutex_lock(&freezer_lock);
+	freezing_processes = 1;
+	mutex_unlock(&freezer_lock);
+	while (atomic_read(&usermodehelper_waiting)) {
+		if (time_after(jiffies, start_time + TIMEOUT)) {
+			printk(KERN_ERR "Unable to freeze tasks because of "
+				"active user mode helpers\n");
+			return -EBUSY;
+		}
+		schedule();
+	}
+
 	printk( "Stopping tasks: " );
 	start_time = jiffies;
+	user_frozen = 0;
 	do {
-		todo = 0;
+		nr_user = todo = 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			if (!freezeable(p))
 				continue;
 			if (frozen(p))
 				continue;
-
-			freeze(p);
-			spin_lock_irqsave(&p->sighand->siglock, flags);
-			signal_wake_up(p, 0);
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			todo++;
+			if (p->mm && !(p->flags & PF_BORROWED_MM)) {
+				/* The task is a user-space one.
+				 * Freeze it unless there's a vfork completion
+				 * pending
+				 */
+				if (!p->vfork_done)
+					freeze_process(p);
+				nr_user++;
+			} else {
+				/* Freeze only if the user space is frozen */
+				if (user_frozen)
+					freeze_process(p);
+				todo++;
+			}
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
+		todo += nr_user;
+		if (!user_frozen && !nr_user) {
+			sys_sync();
+			start_time = jiffies;
+		}
+		user_frozen = !nr_user;
 		yield();			/* Yield is okay here */
-		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
-			printk( "\n" );
-			printk(KERN_ERR " stopping tasks timed out (%d tasks remaining)\n", todo );
+		if (todo && time_after(jiffies, start_time + TIMEOUT))
 			break;
-		}
 	} while(todo);
 
+	mutex_lock(&freezer_lock);
+	freezing_processes = 0;
+	mutex_unlock(&freezer_lock);
+
 	/* This does not unfreeze processes that are already frozen
 	 * (we have slightly ugly calling convention in that respect,
 	 * and caller must call thaw_processes() if something fails),
 	 * but it cleans up leftover PF_FREEZE requests.
 	 */
 	if (todo) {
+		printk( "\n" );
+		printk(KERN_ERR " stopping tasks timed out "
+			"after %d seconds (%d tasks remaining):\n",
+			TIMEOUT / HZ, todo);
 		read_lock(&tasklist_lock);
-		do_each_thread(g, p)
+		do_each_thread(g, p) {
+			if (freezeable(p) && !frozen(p))
+				printk(KERN_ERR "  %s\n", p->comm);
 			if (freezing(p)) {
 				pr_debug("  clean up: %s\n", p->comm);
 				p->flags &= ~PF_FREEZE;
@@ -103,7 +158,7 @@ int freeze_processes(void)
 				recalc_sigpending_tsk(p);
 				spin_unlock_irqrestore(&p->sighand->siglock, flags);
 			}
-		while_each_thread(g, p);
+		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
 		return todo;
 	}
Index: linux-2.6.16-rc1-mm4/kernel/kmod.c
===================================================================
--- linux-2.6.16-rc1-mm4.orig/kernel/kmod.c
+++ linux-2.6.16-rc1-mm4/kernel/kmod.c
@@ -36,6 +36,8 @@
 #include <linux/mount.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/suspend.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 
 extern int max_threads;
@@ -249,11 +251,28 @@ int call_usermodehelper_keys(char *path,
 	if (!khelper_wq)
 		return -EBUSY;
 
+#ifdef CONFIG_PM
+	mutex_lock(&freezer_lock);
+	if (freezing_processes) {
+		mutex_unlock(&freezer_lock);
+		return -EBUSY;
+	}
+	if (wait)
+		atomic_inc(&usermodehelper_waiting);
+	mutex_unlock(&freezer_lock);
+#endif
+
 	if (path[0] == '\0')
 		return 0;
 
 	queue_work(khelper_wq, &work);
 	wait_for_completion(&done);
+
+#ifdef CONFIG_PM
+	if (wait)
+		atomic_dec(&usermodehelper_waiting);
+#endif
+
 	return sub_info.retval;
 }
 EXPORT_SYMBOL(call_usermodehelper_keys);
Index: linux-2.6.16-rc1-mm4/include/linux/suspend.h
===================================================================
--- linux-2.6.16-rc1-mm4.orig/include/linux/suspend.h
+++ linux-2.6.16-rc1-mm4/include/linux/suspend.h
@@ -9,6 +9,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <asm/atomic.h>
 
 /* page backup entry */
 typedef struct pbe {
@@ -40,6 +41,11 @@ extern void drain_local_pages(void);
 extern void mark_free_pages(struct zone *zone);
 
 #ifdef CONFIG_PM
+struct mutex;
+extern struct mutex freezer_lock;
+extern int freezing_processes;
+extern atomic_t usermodehelper_waiting;
+
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);
 
Index: linux-2.6.16-rc1-mm4/kernel/power/disk.c
===================================================================
--- linux-2.6.16-rc1-mm4.orig/kernel/power/disk.c
+++ linux-2.6.16-rc1-mm4/kernel/power/disk.c
@@ -73,7 +73,6 @@ static int prepare_processes(void)
 	int error;
 
 	pm_prepare_console();
-	sys_sync();
 	disable_nonboot_cpus();
 
 	if (freeze_processes()) {
Index: linux-2.6.16-rc1-mm4/kernel/power/user.c
===================================================================
--- linux-2.6.16-rc1-mm4.orig/kernel/power/user.c
+++ linux-2.6.16-rc1-mm4/kernel/power/user.c
@@ -137,7 +137,6 @@ static int snapshot_ioctl(struct inode *
 	case SNAPSHOT_FREEZE:
 		if (data->frozen)
 			break;
-		sys_sync();
 		down(&pm_sem);
 		pm_prepare_console();
 		disable_nonboot_cpus();
