From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFCv4 4/6] sched/core: sync task_group's with CPU's clamp groups
Date: Thu, 24 Aug 2017 19:08:55 +0100
Message-ID: <20170824180857.32103-5-patrick.bellasi@arm.com>
References: <20170824180857.32103-1-patrick.bellasi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753555AbdHXSJg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Aug 2017 14:09:36 -0400
In-Reply-To: <20170824180857.32103-1-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>

The util_{min,max} clamp values for a task group are usually updated from
a user-space process (slow-path) but they require a synchronization
with the scheduler's (fast-path) maintained clamp group reference couters.

Indeed, each time the clamp value of a task group is changed, the old
and new clamp groups have to be updated for each CPU containing a
RUNNABLE task belonging to this tasks group. Non RUNNABLE tasks are not
updated since they will be enqueued with the proper clamp group index at
their next activation.

To properly update clamp group's reference counter of runnable tasks we
use the same locking schema use by __set_cpus_allowed_ptr().  This might
lock the (previous) RQ of a !RUNNABLE task, but that's the price to pay
to safely serialize util_{min,max} updates with RQ's enqueues, dequeues
and migration operations.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/core.c  | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h | 21 +++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ba31bb4e14c7..e4ce25dbad6f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -754,6 +754,12 @@ static void set_load_weight(struct task_struct *p)
 #ifdef CONFIG_UTIL_CLAMP
 /**
  * uclamp_mutex: serialize updates of TG's utilization clamp values
+ *
+ * A task groups's utilization clamp value update is usually triggered from a
+ * user-space process (slow-path) but it requires a synchronization with the
+ * scheduler's (fast-path) enqueue/dequeue operations.
+ * While the fast-path synchronization is protected by RQs spinlock, this
+ * mutex ensure that we sequentially serve user-space requests.
  */
 static DEFINE_MUTEX(uclamp_mutex);
 
@@ -1022,6 +1028,52 @@ static inline void uclamp_cpu_put(struct task_struct *p, int cpu, int clamp_id)
 		uclamp_cpu_update(cpu, clamp_id);
 }
 
+/**
+ * uclamp_task_update_active: update the clamp group of a RUNNABLE task
+ * @p: the task which clamp groups must be updated
+ * @clamp_id: the clamp index to consider
+ * @group_id: the clamp group to update
+ *
+ * Each time the clamp value of a task group is changed, the old and new clamp
+ * groups have to be updated for each CPU containing a RUNNABLE task belonging
+ * to this tasks group. Sleeping tasks are not updated since they will be
+ * enqueued with the proper clamp group index at their next activation.
+ */
+static inline void
+uclamp_task_update_active(struct task_struct *p, int clamp_id, int group_id)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	/*
+	 * Lock the task and the CPU where the task is (or was) queued.
+	 *
+	 * We might lock the (previous) RQ of a !RUNNABLE task, but that's the
+	 * price to pay to safely serialize util_{min,max} updates with
+	 * enqueues, dequeues and migration operations.
+	 * This is the same locking schema used by __set_cpus_allowed_ptr().
+	 */
+	rq = task_rq_lock(p, &rf);
+
+	/*
+	 * The setting of the clamp group is serialized by task_rq_lock().
+	 * Thus, if the task's task_struct is not referencing a valid group
+	 * index, then that task is not yet RUNNABLE or it's going to be
+	 * enqueued with the proper clamp group value.
+	 */
+	if (!uclamp_task_active(p))
+		goto done;
+
+	/* Release p's currently referenced clamp group */
+	uclamp_cpu_put(p, task_cpu(p), clamp_id);
+
+	/* Get p's new clamp group */
+	uclamp_cpu_get(p, task_cpu(p), clamp_id);
+
+done:
+	task_rq_unlock(rq, p, &rf);
+}
+
 /**
  * uclamp_group_put: decrease the reference count for a clamp group
  * @clamp_id: the clamp index which was affected by a task group
@@ -1070,6 +1122,8 @@ static inline int uclamp_group_get(struct cgroup_subsys_state *css,
 	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
 	int prev_group_id = uc_tg->group_id;
 	int next_group_id = UCLAMP_NONE;
+	struct css_task_iter it;
+	struct task_struct *p;
 	unsigned long flags;
 
 	/* Lookup for a usable utilization clamp group */
@@ -1091,6 +1145,18 @@ static inline int uclamp_group_get(struct cgroup_subsys_state *css,
 	uc_map[next_group_id].tg_count += 1;
 	raw_spin_unlock_irqrestore(&uc_map[next_group_id].tg_lock, flags);
 
+	/* Newly created TG don't have tasks assigned */
+	if (!css)
+		goto release;
+
+	/* Update clamp groups for RUNNABLE tasks in this TG */
+	css_task_iter_start(css, &it);
+	while ((p = css_task_iter_next(&it)))
+		uclamp_task_update_active(p, clamp_id, next_group_id);
+	css_task_iter_end(&it);
+
+release:
+
 	/* Release the previous clamp group */
 	uclamp_group_put(clamp_id, prev_group_id);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b0f17c19c0f6..164a8ac152b3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -462,6 +462,27 @@ static inline bool uclamp_task_affects(struct task_struct *p, int clamp_id)
 	return (task_group_id != UCLAMP_NONE);
 }
 
+/**
+ * uclamp_task_active: check if a task is currently clamping a CPU
+ * @p: the task to check
+ *
+ * A task affects the utilization clamp of a CPU if it references a valid
+ * clamp group index for at least one clamp index.
+ *
+ * Return: true if p is currently clamping the utilization of its CPU.
+ */
+static inline bool uclamp_task_active(struct task_struct *p)
+{
+	int clamp_id;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		if (uclamp_task_affects(p, clamp_id))
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * uclamp_group_active: check if a clamp group is active on a CPU
  * @uc_cpu: the array of clamp groups for a CPU
-- 
2.14.1
