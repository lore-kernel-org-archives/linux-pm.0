From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC PATCH 14/14] sched/{fair,tune}: track RUNNABLE tasks impact on per CPU boost value
Date: Wed, 19 Aug 2015 19:47:24 +0100
Message-ID: <1440010044-3402-15-git-send-email-patrick.bellasi@arm.com>
References: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When per-task boosting is enabled, every time a task enters/exits a CPU
its boost value could impact the currently selected OPP for that CPU.
Thus, the "aggregated" boost value for that CPU potentially needs to
be updated to match the current maximum boost value among all the tasks
currently RUNNABLE on that CPU.

This patch introduces the required support to keep track of which boost
groups are impacting a CPU. Each time a task is enqueued/dequeued to/from
a CPU its boost group is used to increment a per-cpu counter of RUNNABLE
tasks on that CPU.
Only when the number of runnable tasks for a specific boost group
becomes 1 or 0 the corresponding boost group changes its effects on
that CPU, specifically:
  a) boost_group::tasks == 1: this boost group starts to impact the CPU
  b) boost_group::tasks == 0: this boost group stops to impact the CPU
In each of these two conditions the aggregation function:
  sched_cpu_update(cpu)
could be required to run in order to identify the new maximum boost
value required for the CPU.

The proposed patch minimizes the number of times the aggregation
function is executed while still providing the required support to
always boost a CPU to the maximum boost value required by all its
currently RUNNABLE tasks.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
---
 kernel/sched/fair.c | 17 +++++++---
 kernel/sched/tune.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/tune.h | 23 +++++++++++++
 3 files changed, 130 insertions(+), 4 deletions(-)
 create mode 100644 kernel/sched/tune.h

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 633fcab4..98470c4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -34,6 +34,7 @@
 #include <trace/events/sched.h>
 
 #include "sched.h"
+#include "tune.h"
 
 /*
  * Targeted preemption latency for CPU-bound tasks:
@@ -4145,6 +4146,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!se) {
 		add_nr_running(rq, 1);
 
+		schedtune_enqueue_task(p, cpu_of(rq));
+
 		/*
 		 * We want to potentially trigger a freq switch request only for
                  * tasks that are waking up; this is because we get here also during
@@ -4213,6 +4216,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	if (!se) {
 		sub_nr_running(rq, 1);
+		schedtune_dequeue_task(p, cpu_of(rq));
 
 		/*
 		 * We want to potentially trigger a freq switch request only for
@@ -4769,10 +4773,15 @@ schedtune_margin(unsigned long signal, unsigned long boost)
 }
 
 static inline unsigned int
-schedtune_cpu_margin(unsigned long util)
+schedtune_cpu_margin(unsigned long util, int cpu)
 {
-	unsigned int boost = get_sysctl_sched_cfs_boost();
+	unsigned int boost;
 
+#ifdef CONFIG_CGROUP_SCHEDTUNE
+	boost = schedtune_cpu_boost(cpu);
+#else
+	boost = get_sysctl_sched_cfs_boost();
+#endif
 	if (boost == 0)
 		return 0;
 
@@ -4782,7 +4791,7 @@ schedtune_cpu_margin(unsigned long util)
 #else /* CONFIG_SCHED_TUNE */
 
 static inline unsigned int
-schedtune_cpu_margin(unsigned long util)
+schedtune_cpu_margin(unsigned long util, int cpu)
 {
 	return 0;
 }
@@ -4793,7 +4802,7 @@ static inline unsigned long
 boosted_cpu_util(int cpu)
 {
 	unsigned long util = cpu_util(cpu);
-	unsigned long margin = schedtune_cpu_margin(util);
+	unsigned long margin = schedtune_cpu_margin(util, cpu);
 
 	return util + margin;
 }
diff --git a/kernel/sched/tune.c b/kernel/sched/tune.c
index 3223ef3..3838106 100644
--- a/kernel/sched/tune.c
+++ b/kernel/sched/tune.c
@@ -2,6 +2,7 @@
 #include <linux/err.h>
 #include <linux/percpu.h>
 #include <linux/printk.h>
+#include <linux/rcupdate.h>
 #include <linux/slab.h>
 
 #include "sched.h"
@@ -158,6 +159,87 @@ schedtune_boostgroup_update(int idx, int boost)
 	return 0;
 }
 
+static inline void
+schedtune_tasks_update(struct task_struct *p, int cpu, int idx, int task_count)
+{
+	struct boost_groups *bg;
+	int tasks;
+
+	bg = &per_cpu(cpu_boost_groups, cpu);
+
+	/* Update boosted tasks count while avoiding to make it negative */
+	if (task_count < 0 && bg->group[idx].tasks <= -task_count)
+		bg->group[idx].tasks = 0;
+	else
+		bg->group[idx].tasks += task_count;
+
+	/* Boost group activation or deactivation on that RQ */
+	tasks = bg->group[idx].tasks;
+	if (tasks == 1 || tasks == 0)
+		schedtune_cpu_update(cpu);
+}
+
+/*
+ * NOTE: This function must be called while holding the lock on the CPU RQ
+ */
+void schedtune_enqueue_task(struct task_struct *p, int cpu)
+{
+	struct schedtune *st;
+	int idx;
+
+	/*
+	 * When a task is marked PF_EXITING by do_exit() it's going to be
+	 * dequeued and enqueued multiple times in the exit path.
+	 * Thus we avoid any further update, since we do not want to change
+	 * CPU boosting while the task is exiting.
+	 */
+	if (p->flags & PF_EXITING)
+		return;
+
+	/* Get task boost group */
+	rcu_read_lock();
+	st = task_schedtune(p);
+	idx = st->idx;
+	rcu_read_unlock();
+
+	schedtune_tasks_update(p, cpu, idx, 1);
+}
+
+/*
+ * NOTE: This function must be called while holding the lock on the CPU RQ
+ */
+void schedtune_dequeue_task(struct task_struct *p, int cpu)
+{
+	struct schedtune *st;
+	int idx;
+
+	/*
+	 * When a task is marked PF_EXITING by do_exit() it's going to be
+	 * dequeued and enqueued multiple times in the exit path.
+	 * Thus we avoid any further update, since we do not want to change
+	 * CPU boosting while the task is exiting.
+	 * The last dequeue will be done by cgroup exit() callback.
+	 */
+	if (p->flags & PF_EXITING)
+		return;
+
+	/* Get task boost group */
+	rcu_read_lock();
+	st = task_schedtune(p);
+	idx = st->idx;
+	rcu_read_unlock();
+
+	schedtune_tasks_update(p, cpu, idx, -1);
+}
+
+int schedtune_cpu_boost(int cpu)
+{
+	struct boost_groups *bg;
+
+	bg = &per_cpu(cpu_boost_groups, cpu);
+	return bg->boost_max;
+}
+
 static u64
 boost_read(struct cgroup_subsys_state *css, struct cftype *cft)
 {
@@ -293,9 +375,21 @@ schedtune_css_free(struct cgroup_subsys_state *css)
 	kfree(st);
 }
 
+static void
+schedtune_exit(struct cgroup_subsys_state *css,
+	       struct cgroup_subsys_state *old_css,
+	       struct task_struct *tsk)
+{
+	struct schedtune *old_st = css_st(old_css);
+	int cpu = task_cpu(tsk);
+
+	schedtune_tasks_update(tsk, cpu, old_st->idx, -1);
+}
+
 struct cgroup_subsys schedtune_cgrp_subsys = {
 	.css_alloc	= schedtune_css_alloc,
 	.css_free	= schedtune_css_free,
+	.exit		= schedtune_exit,
 	.legacy_cftypes	= files,
 	.early_init	= 1,
 };
diff --git a/kernel/sched/tune.h b/kernel/sched/tune.h
new file mode 100644
index 0000000..4519028
--- /dev/null
+++ b/kernel/sched/tune.h
@@ -0,0 +1,23 @@
+
+#ifdef CONFIG_SCHED_TUNE
+
+#ifdef CONFIG_CGROUP_SCHEDTUNE
+
+extern int schedtune_cpu_boost(int cpu);
+
+extern void schedtune_enqueue_task(struct task_struct *p, int cpu);
+extern void schedtune_dequeue_task(struct task_struct *p, int cpu);
+
+#else /* CONFIG_CGROUP_SCHEDTUNE */
+
+#define schedtune_enqueue_task(task, cpu) do { } while (0)
+#define schedtune_dequeue_task(task, cpu) do { } while (0)
+
+#endif /* CONFIG_CGROUP_SCHEDTUNE */
+
+#else /* CONFIG_SCHED_TUNE */
+
+#define schedtune_enqueue_task(task, cpu) do { } while (0)
+#define schedtune_dequeue_task(task, cpu) do { } while (0)
+
+#endif /* CONFIG_SCHED_TUNE */
-- 
2.5.0
