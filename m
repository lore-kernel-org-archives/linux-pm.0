From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v2 09/12] sched/core: uclamp: map TG's clamp values into CPU's clamp groups
Date: Mon, 16 Jul 2018 09:29:03 +0100
Message-ID: <20180716082906.6061-10-patrick.bellasi@arm.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716082906.6061-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

Utilization clamping requires to map each different clamp value
into one of the available clamp groups used by the scheduler's fast-path
to account for RUNNABLE tasks. Thus, each time a TG's clamp value is
updated we need to get a reference to the new value's clamp group and
release a reference to the previous one.

Let's ensure that, whenever a task group is assigned a specific
clamp_value, this is properly translated into a unique clamp group to be
used in the fast-path (i.e. at enqueue/dequeue time).
We do that by slightly refactoring uclamp_group_get() to make the
*task_struct parameter optional. This allows to re-use the code already
available to support the per-task API.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 include/linux/sched.h |  2 ++
 kernel/sched/core.c   | 46 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0635e8073cd3..260aa8d3fca9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -583,6 +583,8 @@ struct sched_dl_entity {
  *
  * A utilization clamp group maps a "clamp value" (value), i.e.
  * util_{min,max}, to a "clamp group index" (group_id).
+ * The same "group_id" can be used by multiple TG's to enforce the same
+ * clamp "value" for a given clamp index.
  */
 struct uclamp_se {
 	/* Utilization constraint for tasks in this group */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 30b1d894f978..04e758224e22 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1219,7 +1219,8 @@ static inline int uclamp_group_get(struct task_struct *p,
 	raw_spin_unlock_irqrestore(&uc_map[next_group_id].se_lock, flags);
 
 	/* Update CPU's clamp group refcounts of RUNNABLE task */
-	uclamp_task_update_active(p, clamp_id, next_group_id);
+	if (p)
+		uclamp_task_update_active(p, clamp_id, next_group_id);
 
 	/* Release the previous clamp group */
 	uclamp_group_put(clamp_id, prev_group_id);
@@ -1276,18 +1277,47 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
 {
 	struct uclamp_se *uc_se;
 	int clamp_id;
+	int ret = 1;
 
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
 		uc_se = &tg->uclamp[clamp_id];
 
 		uc_se->value = parent->uclamp[clamp_id].value;
 		uc_se->group_id = UCLAMP_NONE;
+
+		if (uclamp_group_get(NULL, clamp_id, uc_se,
+				     parent->uclamp[clamp_id].value)) {
+			ret = 0;
+			goto out;
+		}
 	}
 
-	return 1;
+out:
+	return ret;
+}
+
+/**
+ * release_uclamp_sched_group: release utilization clamp references of a TG
+ * @tg: the task group being removed
+ *
+ * An empty task group can be removed only when it has no more tasks or child
+ * groups. This means that we can also safely release all the reference
+ * counting to clamp groups.
+ */
+static inline void free_uclamp_sched_group(struct task_group *tg)
+{
+	struct uclamp_se *uc_se;
+	int clamp_id;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		uc_se = &tg->uclamp[clamp_id];
+		uclamp_group_put(clamp_id, uc_se->group_id);
+	}
 }
+
 #else /* CONFIG_UCLAMP_TASK_GROUP */
 static inline void init_uclamp_sched_group(void) { }
+static inline void free_uclamp_sched_group(struct task_group *tg) { }
 static inline int alloc_uclamp_sched_group(struct task_group *tg,
 					   struct task_group *parent)
 {
@@ -1364,6 +1394,7 @@ static void __init init_uclamp(void)
 #else /* CONFIG_UCLAMP_TASK */
 static inline void uclamp_cpu_get(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_cpu_put(struct rq *rq, struct task_struct *p) { }
+static inline void free_uclamp_sched_group(struct task_group *tg) { }
 static inline int alloc_uclamp_sched_group(struct task_group *tg,
 					   struct task_group *parent)
 {
@@ -6944,6 +6975,7 @@ static DEFINE_SPINLOCK(task_group_lock);
 
 static void sched_free_group(struct task_group *tg)
 {
+	free_uclamp_sched_group(tg);
 	free_fair_sched_group(tg);
 	free_rt_sched_group(tg);
 	autogroup_free(tg);
@@ -7192,6 +7224,7 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 				  struct cftype *cftype, u64 min_value)
 {
+	struct uclamp_se *uc_se;
 	struct task_group *tg;
 	int ret = -EINVAL;
 
@@ -7209,6 +7242,10 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 	if (tg->uclamp[UCLAMP_MAX].value < min_value)
 		goto out;
 
+	/* Update TG's reference count */
+	uc_se = &tg->uclamp[UCLAMP_MIN];
+	ret = uclamp_group_get(NULL, UCLAMP_MIN, uc_se, min_value);
+
 out:
 	rcu_read_unlock();
 	mutex_unlock(&uclamp_mutex);
@@ -7219,6 +7256,7 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 				  struct cftype *cftype, u64 max_value)
 {
+	struct uclamp_se *uc_se;
 	struct task_group *tg;
 	int ret = -EINVAL;
 
@@ -7236,6 +7274,10 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 	if (tg->uclamp[UCLAMP_MIN].value > max_value)
 		goto out;
 
+	/* Update TG's reference count */
+	uc_se = &tg->uclamp[UCLAMP_MAX];
+	ret = uclamp_group_get(NULL, UCLAMP_MAX, uc_se, max_value);
+
 out:
 	rcu_read_unlock();
 	mutex_unlock(&uclamp_mutex);
-- 
2.17.1
