From: Joe Perches <joe@perches.com>
Subject: [PATCH 2/6] power: process: Standardize "freezing process" messages
Date: Thu,  4 Jun 2015 11:36:45 -0700
Message-ID: <8d64d7556b2ad9f216c9c36afff46943d0c71138.1433442778.git.joe@perches.com>
References: <cover.1433442778.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1433442778.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Always emit the "freezing ... processes" on 2 separate lines so
that these messages can't be interleaved.

Start to standardize the printk "PM: doing something...done"
messages on two separate lines.

Miscellanea:

o Add an argument for the elapsed time to try_to_freeze_tasks.
o Remove some trailing whitespace

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/power/process.c | 53 +++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 564f786..f072ae6 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -1,5 +1,5 @@
 /*
- * drivers/power/process.c - Functions for starting/stopping processes on 
+ * drivers/power/process.c - Functions for starting/stopping processes on
  *                           suspend transitions.
  *
  * Originally from swsusp.
@@ -19,12 +19,12 @@
 #include <linux/kmod.h>
 #include <trace/events/power.h>
 
-/* 
+/*
  * Timeout for stopping processes
  */
 unsigned int __read_mostly freeze_timeout_msecs = 20 * MSEC_PER_SEC;
 
-static int try_to_freeze_tasks(bool user_only)
+static int try_to_freeze_tasks(bool user_only, unsigned int *elapsed_msecs)
 {
 	struct task_struct *g, *p;
 	unsigned long end_time;
@@ -32,7 +32,6 @@ static int try_to_freeze_tasks(bool user_only)
 	bool wq_busy = false;
 	struct timeval start, end;
 	u64 elapsed_msecs64;
-	unsigned int elapsed_msecs;
 	bool wakeup = false;
 	int sleep_usecs = USEC_PER_MSEC;
 
@@ -81,14 +80,12 @@ static int try_to_freeze_tasks(bool user_only)
 	do_gettimeofday(&end);
 	elapsed_msecs64 = timeval_to_ns(&end) - timeval_to_ns(&start);
 	do_div(elapsed_msecs64, NSEC_PER_MSEC);
-	elapsed_msecs = elapsed_msecs64;
+	*elapsed_msecs = elapsed_msecs64;
 
 	if (todo) {
-		pr_cont("\n");
-		pr_err("Freezing of tasks %s after %d.%03d seconds "
-		       "(%d tasks refusing to freeze, wq_busy=%d):\n",
+		pr_err("Freezing of tasks %s after %d.%03d seconds (%d tasks refusing to freeze, wq_busy=%d)\n",
 		       wakeup ? "aborted" : "failed",
-		       elapsed_msecs / 1000, elapsed_msecs % 1000,
+		       *elapsed_msecs / 1000, *elapsed_msecs % 1000,
 		       todo - wq_busy, wq_busy);
 
 		if (!wakeup) {
@@ -100,9 +97,6 @@ static int try_to_freeze_tasks(bool user_only)
 			}
 			read_unlock(&tasklist_lock);
 		}
-	} else {
-		pr_cont("(elapsed %d.%03d seconds) ", elapsed_msecs / 1000,
-			elapsed_msecs % 1000);
 	}
 
 	return todo ? -EBUSY : 0;
@@ -118,6 +112,7 @@ static int try_to_freeze_tasks(bool user_only)
 int freeze_processes(void)
 {
 	int error;
+	unsigned int msecs;
 
 	error = __usermodehelper_disable(UMH_FREEZING);
 	if (error)
@@ -130,18 +125,22 @@ int freeze_processes(void)
 		atomic_inc(&system_freezing_cnt);
 
 	pm_wakeup_clear();
-	pr_info("Freezing user space processes ... ");
+	pr_info("Freezing user space processes...\n");
 	pm_freezing = true;
-	error = try_to_freeze_tasks(true);
-	if (!error) {
+	error = try_to_freeze_tasks(true, &msecs);
+	if (error < 0) {
+		pr_info("Freezing user space processes: done (error: %d)\n",
+			error);
+	} else {
 		__usermodehelper_set_disable_depth(UMH_DISABLED);
-		pr_cont("done.");
+		pr_info("Freezing user space processes: done (elapsed %u.%03u seconds)\n",
+			msecs / 1000, msecs % 1000);
 	}
-	pr_cont("\n");
+
 	BUG_ON(in_atomic());
 
 	/*
-	 * Now that the whole userspace is frozen we need to disbale
+	 * Now that the whole userspace is frozen we need to disable
 	 * the OOM killer to disallow any further interference with
 	 * killable tasks.
 	 */
@@ -164,15 +163,15 @@ int freeze_processes(void)
 int freeze_kernel_threads(void)
 {
 	int error;
+	unsigned int msecs;
 
-	pr_info("Freezing remaining freezable tasks ... ");
+	pr_info("Freezing remaining freezable tasks...\n");
 
 	pm_nosig_freezing = true;
-	error = try_to_freeze_tasks(false);
-	if (!error)
-		pr_cont("done.");
+	error = try_to_freeze_tasks(false, &msecs);
+	if (error >= 0)
+		pr_info("Freezing remaining freezable tasks: done\n");
 
-	pr_cont("\n");
 	BUG_ON(in_atomic());
 
 	if (error)
@@ -193,7 +192,7 @@ void thaw_processes(void)
 
 	oom_killer_enable();
 
-	pr_info("Restarting tasks ... ");
+	pr_info("Restarting tasks...\n");
 
 	__usermodehelper_set_disable_depth(UMH_FREEZING);
 	thaw_workqueues();
@@ -212,7 +211,7 @@ void thaw_processes(void)
 	usermodehelper_enable();
 
 	schedule();
-	pr_cont("done.\n");
+	pr_info("Restarting tasks: done\n");
 	trace_suspend_resume(TPS("thaw_processes"), 0, false);
 }
 
@@ -221,7 +220,7 @@ void thaw_kernel_threads(void)
 	struct task_struct *g, *p;
 
 	pm_nosig_freezing = false;
-	pr_info("Restarting kernel threads ... ");
+	pr_info("Restarting kernel threads...\n");
 
 	thaw_workqueues();
 
@@ -233,5 +232,5 @@ void thaw_kernel_threads(void)
 	read_unlock(&tasklist_lock);
 
 	schedule();
-	pr_cont("done.\n");
+	pr_info("Restarting kernel threads: done\n");
 }
-- 
2.1.2
