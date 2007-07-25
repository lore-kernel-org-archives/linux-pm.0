From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 2/2] Freezer: Use wait queue instead of
	busy looping
Date: Wed, 25 Jul 2007 14:09:39 +0200
Message-ID: <200707251409.40592.rjw@sisk.pl>
References: <200707251401.48340.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707251401.48340.rjw@sisk.pl>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Oleg Nesterov <oleg@tv-sign.ru>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Use the observation that try_to_freeze() need not loop while waiting for the
freezing tasks to enter the refrigerator and make it use a wait queue.

The idea is that after sending freeze requests to the tasks regarded as
freezable try_to_freeze() can go to sleep and wait until at least one task
enters the refrigerator.  The first task that does it wakes up try_to_freeze()
and the procedure is repeated.  If the refrigerator is not entered by any tasks
before TIMEOUT expires, try_to_freeze() increases the counter of expired
timeouts and sends freeze requests to the remaining tasks.  If the number of
expired timeouts becomes greater than MAX_WAITS, the freezing of tasks fails
(the counter of expired timeouts is reset whenever a task enters the
refrigerator).

This way, try_to_freeze() doesn't occupy the CPU unnecessarily when some
freezing tasks are waiting for I/O to complete and we have more fine grained
control over the freezing procedure.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Nigel Cunningham <nigel@nigel.suspend2.net>
---
 kernel/power/process.c |   70 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 11 deletions(-)

Index: linux-2.6.23-rc1/kernel/power/process.c
===================================================================
--- linux-2.6.23-rc1.orig/kernel/power/process.c
+++ linux-2.6.23-rc1/kernel/power/process.c
@@ -13,11 +13,22 @@
 #include <linux/module.h>
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
+#include <linux/time.h>
 
 /* 
- * Timeout for stopping processes
+ * Time to wait until one or more tasks enter the refrigerator after sending
+ * freeze requests to them.
  */
-#define TIMEOUT	(20 * HZ)
+#define TIMEOUT (HZ / 5)
+
+/*
+ * Each time after sending freeze requests to tasks the freezer will wait until
+ * some of them enter the refrigerater, but no longer than TIMEOUT.  If TIMEOUT
+ * has been exceeded, the freezer increases the number of waits by one and
+ * repeats.  If the number of waits becomes greater than MAX_WAITS, the
+ * freezing fails.
+ */
+#define MAX_WAITS 5
 
 #define FREEZER_KERNEL_THREADS 0
 #define FREEZER_USER_SPACE 1
@@ -43,6 +54,18 @@ static inline void frozen_process(void)
 	clear_freeze_flag(current);
 }
 
+/*
+ * Wait queue head used by try_to_freeze_tasks() to wait for tasks to enter the
+ * refrigerator.
+ */
+static DECLARE_WAIT_QUEUE_HEAD(refrigerator_waitq);
+
+/*
+ * Used to signal try_to_freeze_tasks() that the refrigerator has been entered
+ * by a task.
+ */
+static int refrigerator_called;
+
 /* Refrigerator is place where frozen processes are stored :-). */
 void refrigerator(void)
 {
@@ -50,6 +73,9 @@ void refrigerator(void)
 	   processes around? */
 	long save;
 
+	refrigerator_called = 1;
+	wake_up(&refrigerator_waitq);
+
 	task_lock(current);
 	if (freezing(current)) {
 		frozen_process();
@@ -166,10 +192,16 @@ static void cancel_freezing(struct task_
 static int try_to_freeze_tasks(int freeze_user_space)
 {
 	struct task_struct *g, *p;
-	unsigned long end_time;
-	unsigned int todo;
+	unsigned int todo, waits;
+	unsigned long ret;
+	struct timeval start, end;
+	s64 elapsed_csecs64;
+	unsigned int elapsed_csecs;
+
+	do_gettimeofday(&start);
 
-	end_time = jiffies + TIMEOUT;
+	refrigerator_called = 0;
+	waits = 0;
 	do {
 		todo = 0;
 		read_lock(&tasklist_lock);
@@ -189,11 +221,25 @@ static int try_to_freeze_tasks(int freez
 				todo++;
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
-		yield();			/* Yield is okay here */
-		if (time_after(jiffies, end_time))
-			break;
+
+		if (todo) {
+			ret = wait_event_timeout(refrigerator_waitq,
+						refrigerator_called, TIMEOUT);
+			if (!ret) {
+				if (++waits > MAX_WAITS)
+					break;
+			} else {
+				refrigerator_called = 0;
+				waits = 0;
+			}
+		}
 	} while (todo);
 
+	do_gettimeofday(&end);
+	elapsed_csecs64 = timeval_to_ns(&end) - timeval_to_ns(&start);
+	do_div(elapsed_csecs64, NSEC_PER_SEC / 100);
+	elapsed_csecs = elapsed_csecs64;
+
 	if (todo) {
 		/* This does not unfreeze processes that are already frozen
 		 * (we have slightly ugly calling convention in that respect,
@@ -201,10 +247,9 @@ static int try_to_freeze_tasks(int freez
 		 * but it cleans up leftover PF_FREEZE requests.
 		 */
 		printk("\n");
-		printk(KERN_ERR "Freezing of %s timed out after %d seconds "
+		printk(KERN_ERR "Freezing of tasks failed after %d.%d seconds "
 				"(%d tasks refusing to freeze):\n",
-				freeze_user_space ? "user space " : "tasks ",
-				TIMEOUT / HZ, todo);
+				elapsed_csecs / 100, elapsed_csecs % 100, todo);
 		show_state();
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
@@ -215,6 +260,9 @@ static int try_to_freeze_tasks(int freez
 			task_unlock(p);
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
+	} else {
+		printk("(elapsed %d.%d seconds) ", elapsed_csecs / 100,
+			elapsed_csecs % 100);
 	}
 
 	return todo ? -EBUSY : 0;
