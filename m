From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 1/5] PM/Freezer: Disable OOM killer when
	tasks are frozen
Date: Thu, 7 May 2009 00:41:04 +0200
Message-ID: <200905070041.04787.rjw__35356.6631828018$1241650558$gmane$org@sisk.pl>
References: <200905070040.08561.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905070040.08561.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The OOM killer is not really going to work while tasks are frozen, so
we can just give up calling it in that case.

This will allow us to safely use memory allocations for decreasing
the number of saveable pages in the hibernation core code instead of
using any artificial memory shriking mechanisms for this purpose.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/freezer.h |    2 ++
 kernel/power/process.c  |   12 ++++++++++++
 mm/page_alloc.c         |    5 +++++
 3 files changed, 19 insertions(+)

Index: linux-2.6/kernel/power/process.c
===================================================================
--- linux-2.6.orig/kernel/power/process.c
+++ linux-2.6/kernel/power/process.c
@@ -19,6 +19,8 @@
  */
 #define TIMEOUT	(20 * HZ)
 
+static bool tasks_frozen;
+
 static inline int freezeable(struct task_struct * p)
 {
 	if ((p == current) ||
@@ -120,6 +122,10 @@ int freeze_processes(void)
  Exit:
 	BUG_ON(in_atomic());
 	printk("\n");
+
+	if (!error)
+		tasks_frozen = true;
+
 	return error;
 }
 
@@ -145,6 +151,8 @@ static void thaw_tasks(bool nosig_only)
 
 void thaw_processes(void)
 {
+	tasks_frozen = false;
+
 	printk("Restarting tasks ... ");
 	thaw_tasks(true);
 	thaw_tasks(false);
@@ -152,3 +160,7 @@ void thaw_processes(void)
 	printk("done.\n");
 }
 
+bool processes_are_frozen(void)
+{
+	return tasks_frozen;
+}
Index: linux-2.6/include/linux/freezer.h
===================================================================
--- linux-2.6.orig/include/linux/freezer.h
+++ linux-2.6/include/linux/freezer.h
@@ -50,6 +50,7 @@ extern int thaw_process(struct task_stru
 extern void refrigerator(void);
 extern int freeze_processes(void);
 extern void thaw_processes(void);
+extern bool processes_are_frozen(void);
 
 static inline int try_to_freeze(void)
 {
@@ -170,6 +171,7 @@ static inline int thaw_process(struct ta
 static inline void refrigerator(void) {}
 static inline int freeze_processes(void) { BUG(); return 0; }
 static inline void thaw_processes(void) {}
+static inline bool processes_are_frozen(void) { return false; }
 
 static inline int try_to_freeze(void) { return 0; }
 
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -46,6 +46,7 @@
 #include <linux/page-isolation.h>
 #include <linux/page_cgroup.h>
 #include <linux/debugobjects.h>
+#include <linux/freezer.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -1600,6 +1601,10 @@ nofail_alloc:
 		if (page)
 			goto got_pg;
 	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
+		/* The OOM killer won't work if processes are frozen. */
+		if (processes_are_frozen())
+			goto nopage;
+
 		if (!try_set_zone_oom(zonelist, gfp_mask)) {
 			schedule_timeout_uninterruptible(1);
 			goto restart;
