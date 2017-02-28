From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC v3 2/5] sched/core: track CPU's capacity_{min,max}
Date: Tue, 28 Feb 2017 14:38:39 +0000
Message-ID: <1488292722-19410-3-git-send-email-patrick.bellasi@arm.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

When CAPACITY_CLAMPING is enabled, each task is subject to a capacity
constraint which is defined by the capacity_{min,max} attributes of the
task group it belongs to.
At run-time, the capacity constraints of RUNNABLE tasks must be
aggregated to figure out the actual capacity constraints to enforce on
each CPU.

This aggregation must meet two main goals:
  1) ensure the minimum capacity required by the most boosted
     RUNNABLE task on that CPU
  2) do not penalize the less capped RUNNABLE tasks on that CPU

Thus, the aggregation for both the capacity constraints turns out to be
a MAX function on the min/max capacities of RUNNABLE tasks:

  cpu_capacity_min := MAX(capacity_min_i), for each RUNNABLE task_i
  cpu_capacity_max := MAX(capacity_max_i), for each RUNNABLE task_i

The aggregation at CPU level is done by exploiting the task_struct.
Tasks are already enqueued, via fields embedded in their task_struct, in
many different lists and trees. This patch uses the same approach to
keep track of the capacity constraints enforced by every task on a CPU.
To this purpose:
  - each CPU's RQ has two RBTrees, which are used to track the minimum and
    maximum capacity constraints of all the tasks enqueue on that CPU
  - task_struct has two rb_node which allows to position that task in the
    minimum/maximum capacity tracking RBTree of the CPU in which the
    task is enqueued

This patch provides the RBTree support code while, for the sake of
clarity, the synchronization between the
   fast path: {enqueue,dequeue}_task
and the
   slow path: cpu_capacity_{min,max}_write_u64
is provided in a dedicated patch.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/sched.h |   3 ++
 kernel/sched/core.c   | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  |  23 +++++++++
 3 files changed, 155 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e2ed46d..5838570 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1531,6 +1531,9 @@ struct task_struct {
 	struct sched_rt_entity rt;
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group *sched_task_group;
+#ifdef CONFIG_CAPACITY_CLAMPING
+	struct rb_node cap_clamp_node[2];
+#endif
 #endif
 	struct sched_dl_entity dl;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a171d49..8f509be 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -752,11 +752,128 @@ static void set_load_weight(struct task_struct *p)
 	load->inv_weight = sched_prio_to_wmult[prio];
 }
 
+#ifdef CONFIG_CAPACITY_CLAMPING
+
+static inline void
+cap_clamp_insert_capacity(struct rq *rq, struct task_struct *p,
+			  unsigned int cap_idx)
+{
+	struct cap_clamp_cpu *cgc = &rq->cap_clamp_cpu[cap_idx];
+	struct task_group *tg = task_group(p);
+	struct rb_node *parent = NULL;
+	struct task_struct *entry;
+	struct rb_node **link;
+	struct rb_root *root;
+	struct rb_node *node;
+	int update_cache = 1;
+	u64 capacity_new;
+	u64 capacity_cur;
+
+	node = &p->cap_clamp_node[cap_idx];
+	if (!RB_EMPTY_NODE(node)) {
+		WARN(1, "cap_clamp_insert_capacity() on non empty node\n");
+		return;
+	}
+
+	/*
+	 * The capacity_{min,max} the task is subject to is defined by the
+	 * current TG the task belongs to. The TG's capacity constraints are
+	 * thus used to place the task within the rbtree used to track
+	 * the capacity_{min,max} for the CPU.
+	 */
+	capacity_new = tg->cap_clamp[cap_idx];
+	root = &cgc->tree;
+	link = &root->rb_node;
+	while (*link) {
+		parent = *link;
+		entry = rb_entry(parent, struct task_struct,
+				 cap_clamp_node[cap_idx]);
+		capacity_cur = task_group(entry)->cap_clamp[cap_idx];
+		if (capacity_new <= capacity_cur) {
+			link = &parent->rb_left;
+			update_cache = 0;
+		} else {
+			link = &parent->rb_right;
+		}
+	}
+
+	/* Add task's capacity_{min,max} and rebalance the rbtree */
+	rb_link_node(node, parent, link);
+	rb_insert_color(node, root);
+
+	if (!update_cache)
+		return;
+
+	/* Update CPU's capacity cache pointer */
+	cgc->value = capacity_new;
+	cgc->node = node;
+}
+
+static inline void
+cap_clamp_remove_capacity(struct rq *rq, struct task_struct *p,
+			  unsigned int cap_idx)
+{
+	struct cap_clamp_cpu *cgc = &rq->cap_clamp_cpu[cap_idx];
+	struct rb_node *node = &p->cap_clamp_node[cap_idx];
+	struct rb_root *root = &cgc->tree;
+
+	if (RB_EMPTY_NODE(node)) {
+		WARN(1, "cap_clamp_remove_capacity on empty node\n");
+		return;
+	}
+
+	/* Update CPU's capacity_{min,max} cache pointer */
+	if (node == cgc->node) {
+		struct rb_node *prev_node = rb_prev(node);
+
+		/* Reset value in case this was the last task */
+		cgc->value = (cap_idx == CAP_CLAMP_MIN)
+			? 0 : SCHED_CAPACITY_SCALE;
+
+		/* Update node and value, if there is another task */
+		cgc->node = prev_node;
+		if (cgc->node) {
+			struct task_struct *entry;
+
+			entry = rb_entry(cgc->node, struct task_struct,
+					 cap_clamp_node[cap_idx]);
+			cgc->value = task_group(entry)->cap_clamp[cap_idx];
+		}
+	}
+
+	/* Remove task's capacity_{min,max] */
+	rb_erase(node, root);
+	RB_CLEAR_NODE(node);
+}
+
+static inline void
+cap_clamp_enqueue_task(struct rq *rq, struct task_struct *p, int flags)
+{
+	/* Track task's min/max capacities */
+	cap_clamp_insert_capacity(rq, p, CAP_CLAMP_MIN);
+	cap_clamp_insert_capacity(rq, p, CAP_CLAMP_MAX);
+}
+
+static inline void
+cap_clamp_dequeue_task(struct rq *rq, struct task_struct *p, int flags)
+{
+	/* Track task's min/max capacities */
+	cap_clamp_remove_capacity(rq, p, CAP_CLAMP_MIN);
+	cap_clamp_remove_capacity(rq, p, CAP_CLAMP_MAX);
+}
+#else
+static inline void
+cap_clamp_enqueue_task(struct rq *rq, struct task_struct *p, int flags) { }
+static inline void
+cap_clamp_dequeue_task(struct rq *rq, struct task_struct *p, int flags) { }
+#endif /* CONFIG_CAPACITY_CLAMPING */
+
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	update_rq_clock(rq);
 	if (!(flags & ENQUEUE_RESTORE))
 		sched_info_queued(rq, p);
+	cap_clamp_enqueue_task(rq, p, flags);
 	p->sched_class->enqueue_task(rq, p, flags);
 }
 
@@ -765,6 +882,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	update_rq_clock(rq);
 	if (!(flags & DEQUEUE_SAVE))
 		sched_info_dequeued(rq, p);
+	cap_clamp_dequeue_task(rq, p, flags);
 	p->sched_class->dequeue_task(rq, p, flags);
 }
 
@@ -2412,6 +2530,10 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
 #endif
+#ifdef CONFIG_CAPACITY_CLAMPING
+	RB_CLEAR_NODE(&p->cap_clamp_node[CAP_CLAMP_MIN]);
+	RB_CLEAR_NODE(&p->cap_clamp_node[CAP_CLAMP_MAX]);
+#endif
 
 	put_cpu();
 	return 0;
@@ -6058,6 +6180,13 @@ void __init sched_init(void)
 		init_tg_cfs_entry(&root_task_group, &rq->cfs, NULL, i, NULL);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
+#ifdef CONFIG_CAPACITY_CLAMPING
+		rq->cap_clamp_cpu[CAP_CLAMP_MIN].tree = RB_ROOT;
+		rq->cap_clamp_cpu[CAP_CLAMP_MIN].node = NULL;
+		rq->cap_clamp_cpu[CAP_CLAMP_MAX].tree = RB_ROOT;
+		rq->cap_clamp_cpu[CAP_CLAMP_MAX].node = NULL;
+#endif
+
 		rq->rt.rt_runtime = def_rt_bandwidth.rt_runtime;
 #ifdef CONFIG_RT_GROUP_SCHED
 		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 05dae4a..4a7d224 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -461,6 +461,24 @@ struct cfs_rq {
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
 
+/* Capacity capping -related fields in a runqueue */
+struct cap_clamp_cpu {
+	/*
+	 * RBTree to keep sorted capacity constraints
+	 * of currently RUNNABLE tasks on a CPU.
+	 */
+	struct rb_root tree;
+
+	/*
+	 * Pointers to the RUNNABLE task defining the current
+	 * capacity constraint for a CPU.
+	 */
+	struct rb_node *node;
+
+	/* Current CPU's capacity constraint */
+	unsigned int value;
+};
+
 static inline int rt_bandwidth_enabled(void)
 {
 	return sysctl_sched_rt_runtime >= 0;
@@ -648,6 +666,11 @@ struct rq {
 	struct list_head *tmp_alone_branch;
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
+#ifdef CONFIG_CAPACITY_CLAMPING
+	/* Min and Max capacity constraints */
+	struct cap_clamp_cpu cap_clamp_cpu[2];
+#endif /* CONFIG_CAPACITY_CLAMPING */
+
 	/*
 	 * This is part of a global counter where only the total sum
 	 * over all CPUs matters. A task can increase this counter on
-- 
2.7.4
