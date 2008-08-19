From: Matt Helsley <matthltc@us.ibm.com>
Subject: [PATCH 2/6] Container Freezer: uninline thaw_process()
Date: Tue, 19 Aug 2008 16:22:34 -0700
Message-ID: <20080819232233.732140572__17014.3036092215$1219189021$gmane$org@us.ibm.com>
References: <20080819232232.432973784@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Containers <containers@lists.linux-foundation.org>, Li Zefan <lizf@cn.fujitsu.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Paul Menage <menage@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Now that the cgroup freezer system also calls thaw_process() inlining these
functions uses more space. Uninlining returns some space:

Before:
	text	data	bss	dec	hex	filename
	4260872	275532	290816	4827220 49a854	vmlinux
After:
	text	data	bss	dec	hex	filename
	4260852	275532	290816	4827200	49a840	vmlinux

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/freezer.h |	29 +++--------------------------
 kernel/freezer.c        |	31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 26 deletions(-)

Index: linux-2.6.27-rc1-mm1/include/linux/freezer.h
===================================================================
--- linux-2.6.27-rc1-mm1.orig/include/linux/freezer.h
+++ linux-2.6.27-rc1-mm1/include/linux/freezer.h
@@ -46,34 +46,11 @@ static inline bool should_send_signal(st
 
 /*
  * Wake up a frozen process
- *
- * task_lock() is needed to prevent the race with refrigerator() which may
- * occur if the freezing of tasks fails.  Namely, without the lock, if the
- * freezing of tasks failed, thaw_tasks() might have run before a task in
- * refrigerator() could call frozen_process(), in which case the task would be
- * frozen and no one would thaw it.
  */
-static inline int __thaw_process(struct task_struct *p)
-{
-	if (frozen(p)) {
-		p->flags &= ~PF_FROZEN;
-		return 1;
-	}
-	clear_freeze_flag(p);
-	return 0;
-}
+extern int __thaw_process(struct task_struct *p);
 
-static inline int thaw_process(struct task_struct *p)
-{
-	task_lock(p);
-	if (__thaw_process(p) == 1) {
-		task_unlock(p);
-		wake_up_process(p);
-		return 1;
-	}
-	task_unlock(p);
-	return 0;
-}
+/* Takes and releases task alloc lock using task_lock() */
+extern int thaw_process(struct task_struct *p);
 
 extern void refrigerator(void);
 extern int freeze_processes(void);
Index: linux-2.6.27-rc1-mm1/kernel/freezer.c
===================================================================
--- linux-2.6.27-rc1-mm1.orig/kernel/freezer.c
+++ linux-2.6.27-rc1-mm1/kernel/freezer.c
@@ -120,3 +120,34 @@ void cancel_freezing(struct task_struct 
 		spin_unlock_irqrestore(&p->sighand->siglock, flags);
 	}
 }
+
+/*
+ * Wake up a frozen process
+ *
+ * task_lock() is needed to prevent the race with refrigerator() which may
+ * occur if the freezing of tasks fails.  Namely, without the lock, if the
+ * freezing of tasks failed, thaw_tasks() might have run before a task in
+ * refrigerator() could call frozen_process(), in which case the task would be
+ * frozen and no one would thaw it.
+ */
+int __thaw_process(struct task_struct *p)
+{
+	if (frozen(p)) {
+		p->flags &= ~PF_FROZEN;
+		return 1;
+	}
+	clear_freeze_flag(p);
+	return 0;
+}
+
+int thaw_process(struct task_struct *p)
+{
+	task_lock(p);
+	if (__thaw_process(p) == 1) {
+		task_unlock(p);
+		wake_up_process(p);
+		return 1;
+	}
+	task_unlock(p);
+	return 0;
+}

-- 
