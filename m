From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 7/7] Freezer: Use freezing timeout more
	efficiently
Date: Thu, 12 Jul 2007 00:17:22 +0200
Message-ID: <200707120017.23622.rjw@sisk.pl>
References: <200707120006.50095.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707120006.50095.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Oleg Nesterov <oleg@tv-sign.ru>, Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

There is the problem with try_to_freeze_tasks() that it always loops until the
timeout expires, even if it is certain to fail much earlier.  Namely, if there
are uninterruptible tasks waiting for some frozen tasks to let them continue,
try_to_freeze_tasks() will certainly fail and it shouldn't waste time in that
cases.

To detect such situations, we can check if the number of tasks that haven't
frozen yet changes between subsequent iterations of the main loop in
try_to_freeze_tasks().  If this number hasn't been changing for sufficiently
long time (say, 250 ms), then most probably some uninterruptible tasks are
blocked by some frozen tasks and we should break out of this stalemate.  Thus,
it seems reasonable to thaw the tasks that have already been frozen without
clearing the freeze requests of the tasks that are refusing to freeze.  This
way, if these tasks are really blocked by the frozen ones, they will get extra
chance to freeze themselves after we have thawed the other tasks and before we
request those tasks to freeze again.  Next, the freezing loop can be repeated
and so on, until all tasks are frozen or the timeout expires.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/process.c |   84 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 14 deletions(-)

Index: linux-2.6.22-rc6-mm1/kernel/power/process.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/kernel/power/process.c	2007-07-11 22:25:50.000000000 +0200
+++ linux-2.6.22-rc6-mm1/kernel/power/process.c	2007-07-11 23:26:00.000000000 +0200
@@ -14,10 +14,11 @@
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
 
-/* 
- * Timeout for stopping processes
- */
-#define TIMEOUT	(20 * HZ)
+/* Timeout for the freezing of tasks */
+#define TIMEOUT	(10 * HZ)
+
+/* Timeout for breaking the freezing loop if stalemate state is detected */
+#define BREAK_TIMEOUT	(HZ / 4)
 
 #define FREEZER_KERNEL_THREADS 0
 #define FREEZER_USER_SPACE 1
@@ -163,14 +164,31 @@ static void cancel_freezing(struct task_
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
-	unsigned long end_time;
-	unsigned int todo;
+	unsigned long end_time, break_time;
+	unsigned int todo, prev_todo;
+	unsigned int i = 0;
+	char *tick = "-\\|/";
+
+	printk(" ");
 
 	end_time = jiffies + TIMEOUT;
+ Repeat:
+	todo = 0;
+	break_time = 0;
 	do {
+		prev_todo = todo;
 		todo = 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
@@ -189,23 +207,61 @@ static int try_to_freeze_tasks(int freez
 				todo++;
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
+
 		yield();			/* Yield is okay here */
+
 		if (time_after(jiffies, end_time))
 			break;
+
+		/*
+		 * Check if we are making any progress.  If we aren't, it's
+		 * better to break out of this.
+		 */
+		if (todo == prev_todo) {
+			if (!break_time)
+				break_time = jiffies + BREAK_TIMEOUT;
+			else if (time_after(jiffies, break_time))
+				break;
+		} else {
+			break_time = 0;
+		}
 	} while (todo);
 
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
+
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
-				"(%d tasks refusing to freeze):\n",
-				freeze_user_space ? "user space " : "tasks ",
-				TIMEOUT / HZ, todo);
+		printk(KERN_ERR "Freezing of tasks has failed.\n");
 		show_state();
+		printk(KERN_ERR "Tasks that have not been frozen:\n");
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			task_lock(p);
