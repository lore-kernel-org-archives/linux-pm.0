From: Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: [RFC/PATCH 2/2] kernel: don't update load average during
	snapshot/shutdown
Date: Fri, 27 Apr 2007 16:29:53 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: linux-pm@lists.osdl.org
Cc: nigel@nigel.suspend2.net, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

From: Nigel Cunningham <nigel@nigel.suspend2.net>

As explained by Nigel, Sendmail and some other programs look at the
load average and stop delivering when it gets too high.  The CPU
intensiveness of suspending to disk pushes the load average up quite
high but post-resume we shouldn't really take that into account.  Not
updating the load average therefore makes snapshot/shutdown invisible
to sendmail and so on.

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---
 include/linux/freezer.h |   13 +++++++++++++
 kernel/power/process.c  |    6 ++++++
 kernel/timer.c          |   16 +++++++++++++---
 3 files changed, 32 insertions(+), 3 deletions(-)

Index: 2.6/include/linux/freezer.h
===================================================================
--- 2.6.orig/include/linux/freezer.h	2007-04-27 16:26:12.000000000 +0300
+++ 2.6/include/linux/freezer.h	2007-04-27 16:26:14.000000000 +0300
@@ -76,6 +76,18 @@ 		return 0;
 
 extern void thaw_some_processes(int all);
 
+enum {
+	FREEZER_OFF	= 0,
+	FREEZER_ON	= 1,
+};
+
+extern int freezer_state;
+
+static inline int freezer_is_on(void)
+{
+	return freezer_state == FREEZER_ON;
+}
+
 #else
 static inline int frozen(struct task_struct *p) { return 0; }
 static inline int freezing(struct task_struct *p) { return 0; }
@@ -88,6 +100,7 @@ static inline int freeze_processes(void)
 static inline void thaw_processes(void) {}
 
 static inline int try_to_freeze(void) { return 0; }
+static inline int freezer_is_on(void) { return 0; }
 
 
 #endif
Index: 2.6/kernel/power/process.c
===================================================================
--- 2.6.orig/kernel/power/process.c	2007-04-27 16:24:45.000000000 +0300
+++ 2.6/kernel/power/process.c	2007-04-27 16:26:14.000000000 +0300
@@ -15,6 +15,8 @@
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
 
+int freezer_state;
+
 /* 
  * Timeout for stopping processes
  */
@@ -183,6 +185,8 @@ int freeze_processes(void)
 	if (nr_unfrozen)
 		return nr_unfrozen;
 
+	freezer_state = FREEZER_ON;
+
 	printk("done.\n");
 	BUG_ON(in_atomic());
 	return 0;
@@ -209,6 +213,8 @@ static void thaw_tasks(int thaw_user_spa
 
 void thaw_processes(void)
 {
+	freezer_state = FREEZER_OFF;
+
 	printk("Restarting tasks ... ");
 	thaw_tasks(FREEZER_KERNEL_THREADS);
 	thaw_tasks(FREEZER_USER_SPACE);
Index: 2.6/kernel/timer.c
===================================================================
--- 2.6.orig/kernel/timer.c	2007-04-27 16:24:45.000000000 +0300
+++ 2.6/kernel/timer.c	2007-04-27 16:27:00.000000000 +0300
@@ -36,6 +36,7 @@  *                              Copyrigh
 #include <linux/delay.h>
 #include <linux/tick.h>
 #include <linux/kallsyms.h>
+#include <linux/freezer.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -1253,9 +1254,18 @@ static inline void calc_load(unsigned lo
 	if (unlikely(count < 0)) {
 		active_tasks = count_active_tasks();
 		do {
-			CALC_LOAD(avenrun[0], EXP_1, active_tasks);
-			CALC_LOAD(avenrun[1], EXP_5, active_tasks);
-			CALC_LOAD(avenrun[2], EXP_15, active_tasks);
+			/*
+			 * If we let the load average be updated while
+			 * snapshot/shutdown, it will be very high
+			 * post resume. Processes such as some MTAs
+			 * that stop work while the average is high
+			 * will be unnecessarily disrupted.
+			 */
+			if (likely(!freezer_is_on())) {
+				CALC_LOAD(avenrun[0], EXP_1, active_tasks);
+				CALC_LOAD(avenrun[1], EXP_5, active_tasks);
+				CALC_LOAD(avenrun[2], EXP_15, active_tasks);
+			}
 			count += LOAD_FREQ;
 		} while (count < 0);
 	}
