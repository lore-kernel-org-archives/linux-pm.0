From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v2 04/12] sched/core: uclamp: update CPU's refcount on clamp changes
Date: Mon, 16 Jul 2018 09:28:58 +0100
Message-ID: <20180716082906.6061-5-patrick.bellasi@arm.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716082906.6061-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

Utilization clamp values enforced on a CPU by a task can be updated at
run-time, for example via a sched_setattr syscall, while a task is
currently RUNNABLE on that CPU. In these cases, the task can be already
refcounting a clamp group for its CPU and thus we need to update this
reference to ensure the new constraints are immediately enforced.

Since a clamp value change always implies a clamp group refcount update,
this patch hooks into the clamp group refcount getter to trigger a CPU
refcount syncup. Such a syncup is required only by currently RUNNABLE
tasks which are also referencing at least one valid clamp group.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Turner <pjt@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/core.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h | 45 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d1969931fea6..b2424eea7990 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1082,6 +1082,52 @@ static inline void uclamp_cpu_put(struct rq *rq, struct task_struct *p)
 		uclamp_cpu_put_id(p, rq, clamp_id);
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
+	 * index, then that task is not yet RUNNABLE and it's going to be
+	 * enqueued with the proper clamp group value.
+	 */
+	if (!uclamp_task_active(p))
+		goto done;
+
+	/* Release p's currently referenced clamp group */
+	uclamp_cpu_put_id(p, rq, clamp_id);
+
+	/* Get p's new clamp group */
+	uclamp_cpu_get_id(p, rq, clamp_id);
+
+done:
+	task_rq_unlock(rq, p, &rf);
+}
+
 /**
  * uclamp_group_put: decrease the reference count for a clamp group
  * @clamp_id: the clamp index which was affected by a task group
@@ -1150,6 +1196,9 @@ static inline int uclamp_group_get(struct task_struct *p,
 	uc_map[next_group_id].se_count += 1;
 	raw_spin_unlock_irqrestore(&uc_map[next_group_id].se_lock, flags);
 
+	/* Update CPU's clamp group refcounts of RUNNABLE task */
+	uclamp_task_update_active(p, clamp_id, next_group_id);
+
 	/* Release the previous clamp group */
 	uclamp_group_put(clamp_id, prev_group_id);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 65bf9ebacd83..b471d2222410 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2199,6 +2199,51 @@ static inline bool uclamp_group_active(struct uclamp_group *uc_grp,
 {
 	return uc_grp[group_id].tasks > 0;
 }
+
+/**
+ * uclamp_task_affects: check if a task affects a utilization clamp
+ * @p: the task to consider
+ * @clamp_id: the utilization clamp to check
+ *
+ * A task affects a clamp index if:
+ * - it's currently enqueued on a CPU
+ * - it references a valid clamp group index for the specified clamp index
+ *
+ * Return: true if p currently affects the specified clamp_id
+ */
+static inline bool uclamp_task_affects(struct task_struct *p, int clamp_id)
+{
+	return (p->uclamp[clamp_id].group_id != UCLAMP_NONE);
+}
+
+/**
+ * uclamp_task_active: check if a task is currently clamping a CPU
+ * @p: the task to check
+ *
+ * A task actively affects the utilization clamp of a CPU if:
+ * - it's currently enqueued or running on that CPU
+ * - it's refcounted in at least one clamp group of that CPU
+ *
+ * Return: true if p is currently clamping the utilization of its CPU.
+ */
+static inline bool uclamp_task_active(struct task_struct *p)
+{
+	struct rq *rq = task_rq(p);
+	int clamp_id;
+
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_held(&rq->lock);
+
+	if (!task_on_rq_queued(p) && !p->on_cpu)
+		return false;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		if (uclamp_task_affects(p, clamp_id))
+			return true;
+	}
+
+	return false;
+}
 #endif /* CONFIG_UCLAMP_TASK */
 
 #ifdef CONFIG_CPU_FREQ
-- 
2.17.1
