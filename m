From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 5/6] Freezer: Use freezing timeout more
	efficiently
Date: Mon, 9 Jul 2007 22:38:18 +0200
Message-ID: <200707092238.19267.rjw@sisk.pl>
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

The freezer fails if there are uninterruptible tasks waiting for some frozen
tasks to let them continue.  Moreover, in that case try_to_freeze_tasks() loops
uselessly until the timeout expires which is wasteful, so in principle we should
make the freezer fail as soon as all the tasks that refuse to freeze are
uninterruptible.  However, instead of failing the freezer we can try to use the
time left and thaw the tasks that have already been frozen without clearing the
freeze requests of the tasks that are refusing to freeze.  This way, if these
tasks are really blocked by the frozen ones, they will get extra chance to
freeze when the other tasks are thawed.  Next, we can repeat the freezing loop
and so on, until the timeout expires.

This patch implements the above idea.  It has been tested by trying to freeze
tasks on a 2.2 GHz dual-core machine running 'make -j50' kernel compilation
concurrently with try_to_freeze_tasks() with the freezer hooks removed from
do_fork() and it's been able to do the job 100% of the time.  It may help with
the "freezer tends to fail if FUSE is used" issue
(cf. http://lkml.org/lkml/2007/7/3/1) and I don't see any drawback of doing it
in general.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/process.c |   67 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 13 deletions(-)

Index: linux-2.6.22-rc6-mm1/kernel/power/process.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/kernel/power/process.c
+++ linux-2.6.22-rc6-mm1/kernel/power/process.c
@@ -14,10 +14,8 @@
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
 
-/* 
- * Timeout for stopping processes
- */
-#define TIMEOUT	(20 * HZ)
+/* Timeout for the freezing of tasks */
+#define TIMEOUT	(30 * HZ)
 
 #define FREEZER_KERNEL_THREADS 0
 #define FREEZER_USER_SPACE 1
@@ -172,15 +170,30 @@ static void cancel_freezing(struct task_
 	}
 }
 
+/**
+ *	try_to_freeze_tasks - send freeze requests to all tasks and wait for
+ *		for them to enter the refrigerator
+ *	@freeze_user_space - if set, only tasks that have mm of their own are
+ *		requested to freeze
+ *
+ *	If this function fails, thaw_tasks() must be called to do the cleanup.
+ */
+
 static int try_to_freeze_tasks(int freeze_user_space)
 {
 	struct task_struct *g, *p;
 	unsigned long end_time;
-	unsigned int todo;
+	unsigned int todo, blocking;
+	unsigned int i = 0;
+	char *tick = "-\\|/";
+
+	printk(" ");
 
 	end_time = jiffies + TIMEOUT;
+ Repeat:
 	do {
 		todo = 0;
+		blocking = 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			if (frozen(p) || !freezeable(p))
@@ -197,25 +210,53 @@ static int try_to_freeze_tasks(int freez
 			} else {
 				freeze_task(p);
 			}
-			if (!freezer_should_skip(p))
+			if (!freezer_should_skip(p)) {
 				todo++;
+				if (freeze_user_space &&
+				    (p->state == TASK_UNINTERRUPTIBLE))
+					blocking++;
+			}
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
 		yield();			/* Yield is okay here */
 		if (time_after(jiffies, end_time))
 			break;
-	} while (todo);
+	} while (todo != blocking);
+
+	if (todo && freeze_user_space && !time_after(jiffies, end_time)) {
+		/*
+		 * Some tasks have not been able to freeze.  They might be stuck
+		 * in TASK_UNINTERRUPTIBLE waiting for the frozen tasks.  Try to
+		 * thaw the tasks that have frozen without clearing the freeze
+		 * requests of the remaining tasks and repeat.
+		 */
+		read_lock(&tasklist_lock);
+		do_each_thread(g, p) {
+			if (frozen(p)) {
+				p->flags &= ~PF_FROZEN;
+				wake_up_process(p);
+			}
+		} while_each_thread(g, p);
+		read_unlock(&tasklist_lock);
+
+		yield();
+
+		printk("\b%c", tick[i++%4]);
+
+		goto Repeat;
+	}
+
+	printk("\b");
 
 	if (todo) {
-		/* This does not unfreeze processes that are already frozen
-		 * (we have slightly ugly calling convention in that respect,
-		 * and caller must call thaw_processes() if something fails),
-		 * but it cleans up leftover PF_FREEZE requests.
+		/*
+		 * The freezing of tasks has failed.  List the tasks that have
+		 * refused to freeze.  This also clears all pending freeze
+		 * requests.
 		 */
 		printk("\n");
-		printk(KERN_ERR "Freezing of %s timed out after %d seconds "
+		printk(KERN_ERR "Freezing of tasks timed out after %d seconds "
 				"(%d tasks refusing to freeze):\n",
-				freeze_user_space ? "user space " : "tasks ",
 				TIMEOUT / HZ, todo);
 		show_state();
 		read_lock(&tasklist_lock);
