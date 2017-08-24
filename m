From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFCv4 3/6] sched/core: reference count active tasks's clamp groups
Date: Thu, 24 Aug 2017 19:08:54 +0100
Message-ID: <20170824180857.32103-4-patrick.bellasi@arm.com>
References: <20170824180857.32103-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170824180857.32103-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

When tasks are enqueued/dequeued on/from a CPU, the set of clamp groups
active on that CPU can change. Indeed, the clamp value mapped by a clamp
group applies to a CPU only when there is at least one task active in
that clamp group.
Since each clamp group enforces a different utilization clamp value, once
the set of these groups changes it can be required to re-compute what is
the new "aggregated" clamp value to apply for that CPU.

Clamp values are always MAX aggregated for both util_min and util_max. This
is to ensure that no tasks can affect the performances of other
co-scheduled tasks which are either more boosted (i.e.  with higher
util_min clamp) or less capped (i.e. with higher util_max clamp).

This patch introduces the required support to properly reference count
clamp groups at each task enqueue/dequeue time. The MAX aggregation of the
currently active clamp groups is implemented to minimizes the number of
times we need to scan the complete (unordered) clamp group array to
figure out the new max value.
This operation happens only when we dequeue last task of the clamp group
defining the current max clamp, and thus the CPU is either entering IDLE
or going to schedule a less boosted or more clamped task.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 include/linux/sched.h |   5 ++
 kernel/sched/core.c   | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  |  77 ++++++++++++++++++++++++
 3 files changed, 242 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 265ac0898f9e..5cf0ee6a1aee 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -574,6 +574,11 @@ struct task_struct {
 #endif
 	struct sched_dl_entity		dl;
 
+#ifdef CONFIG_UTIL_CLAMP
+	/* Index of clamp group the task has been accounted into */
+	int				uclamp_group_id[UCLAMP_CNT];
+#endif
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	/* List of struct preempt_notifier: */
 	struct hlist_head		preempt_notifiers;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d39766f2b03..ba31bb4e14c7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -850,9 +850,19 @@ static inline void uclamp_group_init(int clamp_id, int group_id,
 				     unsigned int clamp_value)
 {
 	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+	struct uclamp_cpu *uc_cpu;
+	int cpu;
 
+	/* Set clamp group map */
 	uc_map[group_id].value = clamp_value;
 	uc_map[group_id].tg_count = 0;
+
+	/* Set clamp groups on all CPUs */
+	for_each_possible_cpu(cpu) {
+		uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
+		uc_cpu->group[group_id].value = clamp_value;
+		uc_cpu->group[group_id].tasks = 0;
+	}
 }
 
 /**
@@ -908,6 +918,110 @@ uclamp_group_find(int clamp_id, unsigned int clamp_value)
 	return group_id;
 }
 
+/**
+ * uclamp_cpu_update: update the utilization clamp of a CPU
+ * @cpu: the CPU which utilization clamp has to be updated
+ * @clamp_id: the clamp index to update
+ *
+ * When tasks are enqueued/dequeued on/from a CPU, the set of currently active
+ * clamp groups is subject to change. Since each clamp group enforces a
+ * different utilization clamp value, once the set of these groups change it
+ * can be required to re-compute what is the new clamp value to apply for that
+ * CPU.
+ *
+ * For the specified clamp index, this method computes the new CPU utilization
+ * clamp to use until the next change on the set of tasks active on that CPU.
+ */
+static inline void uclamp_cpu_update(int cpu, int clamp_id)
+{
+	struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
+	int max_value = UCLAMP_NONE;
+	unsigned int group_id;
+
+	for (group_id = 0; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
+
+		/* Ignore inactive clamp groups, i.e. no RUNNABLE tasks */
+		if (!uclamp_group_active(uc_cpu, group_id))
+			continue;
+
+		/* Both min and max clamp are MAX aggregated */
+		max_value = max(max_value, uc_cpu->group[group_id].value);
+
+		/* Stop if we reach the max possible clamp */
+		if (max_value >= SCHED_CAPACITY_SCALE)
+			break;
+	}
+	uc_cpu->value = max_value;
+}
+
+/**
+ * uclamp_cpu_get(): increase reference count for a clamp group on a CPU
+ * @p: the task being enqueued on a CPU
+ * @cpu: the CPU where the clamp group has to be reference counted
+ * @clamp_id: the utilization clamp (e.g. min or max utilization) to reference
+ *
+ * Once a task is enqueued on a CPU's RQ, the clamp group currently defined by
+ * the task's TG::uclamp.group_id is reference counted on that CPU.
+ * We keep track of the reference counted clamp group by storing its index
+ * (group_id) into the task's task_struct::uclamp_group_id, which will then be
+ * used at task's dequeue time to release the reference count.
+ */
+static inline void uclamp_cpu_get(struct task_struct *p, int cpu, int clamp_id)
+{
+	struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
+	int clamp_value = task_group(p)->uclamp[clamp_id].value;
+	int group_id;
+
+	/* Increment the current TG's group_id */
+	group_id = task_group(p)->uclamp[clamp_id].group_id;
+	uc_cpu->group[group_id].tasks += 1;
+
+	/* Mark task as enqueued for this clamp IDX */
+	p->uclamp_group_id[clamp_id] = group_id;
+
+	/*
+	 * If this is the new max utilization clamp value, then
+	 * we can update straight away the CPU clamp value.
+	 */
+	if (uc_cpu->value < clamp_value)
+		uc_cpu->value = clamp_value;
+}
+
+/**
+ * uclamp_cpu_put(): decrease reference count for a clamp groups on a CPU
+ * @p: the task being dequeued from a CPU
+ * @cpu: the CPU from where the clamp group has to be released
+ * @clamp_id: the utilization clamp (e.g. min or max utilization) to release
+ *
+ * When a task is dequeued from a CPU's RQ, the clamp group reference counted
+ * by the task's task_struct::uclamp_group_id is decrease for that CPU.
+ */
+static inline void uclamp_cpu_put(struct task_struct *p, int cpu, int clamp_id)
+{
+	struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
+	unsigned int clamp_value;
+	int group_id;
+
+	/* Decrement the task's reference counted group index */
+	group_id = p->uclamp_group_id[clamp_id];
+	uc_cpu->group[group_id].tasks -= 1;
+
+	/* Mark task as dequeued for this clamp IDX */
+	p->uclamp_group_id[clamp_id] = UCLAMP_NONE;
+
+	/* If this is not the last task, no updates are required */
+	if (uc_cpu->group[group_id].tasks > 0)
+		return;
+
+	/*
+	 * Update the CPU only if this was the last task of the group
+	 * defining the current clamp value.
+	 */
+	clamp_value = uc_cpu->group[group_id].value;
+	if (clamp_value >= uc_cpu->value)
+		uclamp_cpu_update(cpu, clamp_id);
+}
+
 /**
  * uclamp_group_put: decrease the reference count for a clamp group
  * @clamp_id: the clamp index which was affected by a task group
@@ -983,6 +1097,38 @@ static inline int uclamp_group_get(struct cgroup_subsys_state *css,
 	return 0;
 }
 
+/**
+ * uclamp_task_update: update clamp group referenced by a task
+ * @rq: the RQ the task is going to be enqueued/dequeued to/from
+ * @p: the task being enqueued/dequeued
+ *
+ * Utilization clamp constraints for a CPU depend on tasks which are active
+ * (i.e. RUNNABLE or RUNNING) on that CPU. To keep track of tasks
+ * requirements, each active task reference counts a clamp group in the CPU
+ * they are currently queued for execution.
+ *
+ * This method updates the utilization clamp constraints considering the
+ * requirements for the specified task. Thus, this update must be done before
+ * calling into the scheduling classes, which will eventually update schedutil
+ * considering the new task requirements.
+ */
+static inline void uclamp_task_update(struct rq *rq, struct task_struct *p)
+{
+	int cpu = cpu_of(rq);
+	int clamp_id;
+
+	/* The idle task is never clamped */
+	if (unlikely(p->sched_class == &idle_sched_class))
+		return;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		if (uclamp_task_affects(p, clamp_id))
+			uclamp_cpu_put(p, cpu, clamp_id);
+		else
+			uclamp_cpu_get(p, cpu, clamp_id);
+	}
+}
+
 /**
  * alloc_uclamp_sched_group: initialize a new TG's for utilization clamping
  * @tg: the newly created task group
@@ -1043,10 +1189,12 @@ static inline void free_uclamp_sched_group(struct task_group *tg)
  */
 static inline void init_uclamp(void)
 {
+	struct uclamp_cpu *uc_cpu;
 	struct uclamp_map *uc_map;
 	struct uclamp_tg *uc_tg;
 	int group_id;
 	int clamp_id;
+	int cpu;
 
 	mutex_init(&uclamp_mutex);
 
@@ -1058,6 +1206,11 @@ static inline void init_uclamp(void)
 			uc_map[group_id].value = UCLAMP_NONE;
 			raw_spin_lock_init(&uc_map[group_id].tg_lock);
 		}
+		/* Init CPU's clamp groups */
+		for_each_possible_cpu(cpu) {
+			uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
+			memset(uc_cpu, UCLAMP_NONE, sizeof(struct uclamp_cpu));
+		}
 	}
 
 	/* Root TG's are initialized to the first clamp group */
@@ -1080,6 +1233,7 @@ static inline void init_uclamp(void)
 	}
 }
 #else
+static inline void uclamp_task_update(struct rq *rq, struct task_struct *p) { }
 static inline int alloc_uclamp_sched_group(struct task_group *tg,
 					   struct task_group *parent)
 {
@@ -1097,6 +1251,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & ENQUEUE_RESTORE))
 		sched_info_queued(rq, p);
 
+	uclamp_task_update(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
 }
 
@@ -1108,6 +1263,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & DEQUEUE_SAVE))
 		sched_info_dequeued(rq, p);
 
+	uclamp_task_update(rq, p);
 	p->sched_class->dequeue_task(rq, p, flags);
 }
 
@@ -2499,6 +2655,10 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.cfs_rq			= NULL;
 #endif
 
+#ifdef CONFIG_UTIL_CLAMP
+	memset(&p->uclamp_group_id, UCLAMP_NONE, sizeof(p->uclamp_group_id));
+#endif
+
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
 	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 869344de0396..b0f17c19c0f6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -389,6 +389,42 @@ static inline int walk_tg_tree(tg_visitor down, tg_visitor up, void *data)
 extern int tg_nop(struct task_group *tg, void *data);
 
 #ifdef CONFIG_UTIL_CLAMP
+/**
+ * Utilization clamp Group
+ *
+ * Keep track of how many tasks are RUNNABLE for a given utilization
+ * clamp value.
+ */
+struct uclamp_group {
+	/* Utilization clamp value for tasks on this clamp group */
+	int value;
+	/* Number of RUNNABLE tasks on this clamp group */
+	int tasks;
+};
+
+/**
+ * CPU's utilization clamp
+ *
+ * Keep track of active tasks on a CPUs to aggregate their clamp values.  A
+ * clamp value is affecting a CPU where there is at least one task RUNNABLE
+ * (or actually running) with that value.
+ * All utilization clamping values are MAX aggregated, since:
+ * - for util_min: we wanna run the CPU at least at the max of the minimum
+ *   utilization required by its currently active tasks.
+ * - for util_max: we wanna allow the CPU to run up to the max of the
+ *   maximum utilization allowed by its currently active tasks.
+ *
+ * Since on each system we expect only a limited number of utilization clamp
+ * values, we can use a simple array to track the metrics required to compute
+ * all the per-CPU utilization clamp values.
+ */
+struct uclamp_cpu {
+	/* Utilization clamp value for a CPU */
+	int value;
+	/* Utilization clamp groups affecting this CPU */
+	struct uclamp_group group[CONFIG_UCLAMP_GROUPS_COUNT + 1];
+};
+
 /**
  * uclamp_none: default value for a clamp
  *
@@ -404,6 +440,44 @@ static inline unsigned int uclamp_none(int clamp_id)
 		return 0;
 	return SCHED_CAPACITY_SCALE;
 }
+
+/**
+ * uclamp_task_affects: check if a task affects a utilization clamp
+ * @p: the task to consider
+ * @clamp_id: the utilization clamp to check
+ *
+ * A task affects a clamp index if its task_struct::uclamp_group_id is a
+ * valid clamp group index for the specified clamp index.
+ * Once a task is dequeued from a CPU, its clamp group indexes are reset to
+ * UCLAMP_NONE. A valid clamp group index is assigned to a task only when it
+ * is RUNNABLE on a CPU and it represents the clamp group which is currently
+ * reference counted by that task.
+ *
+ * Return: true if p currently affects the specified clamp_id
+ */
+static inline bool uclamp_task_affects(struct task_struct *p, int clamp_id)
+{
+	int task_group_id = p->uclamp_group_id[clamp_id];
+
+	return (task_group_id != UCLAMP_NONE);
+}
+
+/**
+ * uclamp_group_active: check if a clamp group is active on a CPU
+ * @uc_cpu: the array of clamp groups for a CPU
+ * @group_id: the clamp group to check
+ *
+ * A clamp group affects a CPU if it as at least one "active" task.
+ *
+ * Return: true if the specified CPU has at least one active task for
+ *         the specified clamp group.
+ */
+static inline bool uclamp_group_active(struct uclamp_cpu *uc_cpu, int group_id)
+{
+	return uc_cpu->group[group_id].tasks > 0;
+}
+#else
+struct uclamp_cpu { };
 #endif /* CONFIG_UTIL_CLAMP */
 
 extern void free_fair_sched_group(struct task_group *tg);
@@ -771,6 +845,9 @@ struct rq {
 	unsigned long cpu_capacity;
 	unsigned long cpu_capacity_orig;
 
+	/* util_{min,max} clamp values based on CPU's active tasks */
+	struct uclamp_cpu uclamp[UCLAMP_CNT];
+
 	struct callback_head *balance_callback;
 
 	unsigned char idle_balance;
-- 
2.14.1
