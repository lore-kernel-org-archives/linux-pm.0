From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC v3 3/5] sched/core: sync capacity_{min,max} between slow and fast paths
Date: Tue, 28 Feb 2017 14:38:40 +0000
Message-ID: <1488292722-19410-4-git-send-email-patrick.bellasi@arm.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

At enqueue/dequeue time a task needs to be placed in the CPU's rb_tree,
depending on the current capacity_{min,max} value of the cgroup it
belongs to. Thus, we need to grant that these values cannot be changed
while the task is in these critical sections.

To this purpose, this patch uses the same locking schema already used by
the __set_cpus_allowed_ptr. We might uselessly lock the (previous) RQ of
a !RUNNABLE task, but that's the price to pay to safely serialize
capacity_{min,max} updates with enqueues, dequeues and migrations.

This patch adds the synchronization calls required to grant that each
RUNNABLE task is always in the correct relative position within the
RBTree. Specifically, when a group's capacity_{min,max} value is
updated, each task in that group is re-positioned within the rb_tree, if
currently RUNNABLE and its relative position has changed.
This operation is mutually exclusive with the task being {en,de}queued
or migrated via a task_rq_lock().

It's worth to notice that moving a task from a CGroup to another,
perhaps with different capacity_{min,max} values, is already covered by
the current locking schema. Indeed, this operation requires a dequeue
from the original cgroup's RQ followed by an enqueue in the new one.
The same argument is true for tasks migrations thus, tasks migrations
between CPUs and CGruoups are ultimately managed like tasks
wakeups/sleeps.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/core.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8f509be..d620bc4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -846,9 +846,68 @@ cap_clamp_remove_capacity(struct rq *rq, struct task_struct *p,
 	RB_CLEAR_NODE(node);
 }
 
+static void
+cap_clamp_update_capacity(struct task_struct *p, unsigned int cap_idx)
+{
+	struct task_group *tg = task_group(p);
+	unsigned int next_cap = SCHED_CAPACITY_SCALE;
+	unsigned int prev_cap = 0;
+	struct task_struct *entry;
+	struct rb_node *node;
+	struct rq_flags rf;
+	struct rq *rq;
+
+	/*
+	 * Lock the CPU's RBTree where the task is (eventually) queued.
+	 *
+	 * We might uselessly lock the (previous) RQ of a !RUNNABLE task, but
+	 * that's the price to pay to safely serializ capacity_{min,max}
+	 * updates with enqueues, dequeues and migration operations, which is
+	 * the same locking schema already in use by __set_cpus_allowed_ptr().
+	 */
+	rq = task_rq_lock(p, &rf);
+
+	/*
+	 * If the task has not a node in the rbtree, it's not yet RUNNABLE or
+	 * it's going to be enqueued with the proper value.
+	 * The setting of the cap_clamp_node is serialized by task_rq_lock().
+	 */
+	if (RB_EMPTY_NODE(&p->cap_clamp_node[cap_idx]))
+		goto done;
+
+	/* Check current position in the capacity rbtree */
+	node = rb_next(&p->cap_clamp_node[cap_idx]);
+	if (node) {
+		entry = rb_entry(node, struct task_struct,
+				 cap_clamp_node[cap_idx]);
+		next_cap = task_group(entry)->cap_clamp[cap_idx];
+	}
+	node = rb_prev(&p->cap_clamp_node[cap_idx]);
+	if (node) {
+		entry = rb_entry(node, struct task_struct,
+				 cap_clamp_node[cap_idx]);
+		prev_cap = task_group(entry)->cap_clamp[cap_idx];
+	}
+
+	/* If relative position has not changed: nothing to do */
+	if (prev_cap <= tg->cap_clamp[cap_idx] &&
+	    next_cap >= tg->cap_clamp[cap_idx])
+		goto done;
+
+	/* Reposition this node within the rbtree */
+	cap_clamp_remove_capacity(rq, p, cap_idx);
+	cap_clamp_insert_capacity(rq, p, cap_idx);
+
+done:
+	task_rq_unlock(rq, p, &rf);
+}
+
 static inline void
 cap_clamp_enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_held(&rq->lock);
+
 	/* Track task's min/max capacities */
 	cap_clamp_insert_capacity(rq, p, CAP_CLAMP_MIN);
 	cap_clamp_insert_capacity(rq, p, CAP_CLAMP_MAX);
@@ -857,6 +916,9 @@ cap_clamp_enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 static inline void
 cap_clamp_dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_held(&rq->lock);
+
 	/* Track task's min/max capacities */
 	cap_clamp_remove_capacity(rq, p, CAP_CLAMP_MIN);
 	cap_clamp_remove_capacity(rq, p, CAP_CLAMP_MAX);
@@ -7046,8 +7108,10 @@ static int cpu_capacity_min_write_u64(struct cgroup_subsys_state *css,
 				      struct cftype *cftype, u64 value)
 {
 	struct cgroup_subsys_state *pos;
+	struct css_task_iter it;
 	unsigned int min_value;
 	struct task_group *tg;
+	struct task_struct *p;
 	int ret = -EINVAL;
 
 	min_value = min_t(unsigned int, value, SCHED_CAPACITY_SCALE);
@@ -7078,6 +7142,12 @@ static int cpu_capacity_min_write_u64(struct cgroup_subsys_state *css,
 
 	tg->cap_clamp[CAP_CLAMP_MIN] = min_value;
 
+	/* Update the capacity_min of RUNNABLE tasks */
+	css_task_iter_start(css, &it);
+	while ((p = css_task_iter_next(&it)))
+		cap_clamp_update_capacity(p, CAP_CLAMP_MIN);
+	css_task_iter_end(&it);
+
 done:
 	ret = 0;
 out:
@@ -7091,8 +7161,10 @@ static int cpu_capacity_max_write_u64(struct cgroup_subsys_state *css,
 				      struct cftype *cftype, u64 value)
 {
 	struct cgroup_subsys_state *pos;
+	struct css_task_iter it;
 	unsigned int max_value;
 	struct task_group *tg;
+	struct task_struct *p;
 	int ret = -EINVAL;
 
 	max_value = min_t(unsigned int, value, SCHED_CAPACITY_SCALE);
@@ -7123,6 +7195,12 @@ static int cpu_capacity_max_write_u64(struct cgroup_subsys_state *css,
 
 	tg->cap_clamp[CAP_CLAMP_MAX] = max_value;
 
+	/* Update the capacity_max of RUNNABLE tasks */
+	css_task_iter_start(css, &it);
+	while ((p = css_task_iter_next(&it)))
+		cap_clamp_update_capacity(p, CAP_CLAMP_MAX);
+	css_task_iter_end(&it);
+
 done:
 	ret = 0;
 out:
-- 
2.7.4
