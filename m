From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v5 13/15] sched/core: uclamp: map TG's clamp values into CPU's clamp groups
Date: Mon, 29 Oct 2018 18:33:08 +0000
Message-ID: <20181029183311.29175-15-patrick.bellasi@arm.com>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181029183311.29175-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

Utilization clamping requires to map each different clamp value into one
of the available clamp groups used in the scheduler fast-path to account
for RUNNABLE tasks. Thus, each time a TG's clamp value sysfs attribute
is updated via:
   cpu_util_{min,max}_write_u64()
we need to update the task group reference to the new value's clamp
group and release the reference to the previous one.

Let's ensure that, whenever a task group is assigned a specific
clamp_value, this is properly translated into a unique clamp group to be
used in the fast-path (i.e. at enqueue/dequeue time).
We do that by slightly refactoring uclamp_group_get() to make the
*task_struct parameter optional. This allows to re-use the code already
available for the support of the per-task API.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v5:
 Others:
 - rebased on v4.19

Changes in v4:
 Others:
 - rebased on v4.19-rc1
Changes in v3:
 Message-ID: <CAJuCfpF6=L=0LrmNnJrTNPazT4dWKqNv+thhN0dwpKCgUzs9sg@mail.gmail.com>
 - add explicit calls to uclamp_group_find(), which is now not more
   part of uclamp_group_get()
 Others:
 - rebased on tip/sched/core
Changes in v2:
 - rebased on v4.18-rc4
 - this code has been split from a previous patch to simplify the review
---
 include/linux/sched.h |  7 +++--
 kernel/sched/core.c   | 64 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d3f6bf62ab3f..7698e7554892 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -601,9 +601,10 @@ struct sched_dl_entity {
  *   clamp group index (group_id), i.e.
  *   index of the per-cpu RUNNABLE tasks refcounting array
  *
- * The mapped bit is set whenever a task has been mapped on a clamp group for
- * the first time. When this bit is set, any clamp group get (for a new clamp
- * value) will be matches by a clamp group put (for the old clamp value).
+ * The mapped bit is set whenever a scheduling entity has been mapped on a
+ * clamp group for the first time. When this bit is set, any clamp group get
+ * (for a new clamp value) will be matches by a clamp group put (for the old
+ * clamp value).
  *
  * The active bit is set whenever a task has got an effective clamp group
  * and value assigned, which can be different from the user requested ones.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cb49bffb3da8..3dcd1c17a244 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1396,9 +1396,9 @@ static void __init init_uclamp(void)
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 		/* Init root TG's clamp group */
 		uc_se = &root_task_group.uclamp[clamp_id];
-		uc_se->value = uclamp_none(clamp_id);
-		uc_se->group_id = 0;
-		uc_se->effective.value = uclamp_none(clamp_id);
+		uclamp_group_get(NULL, uc_se, clamp_id, uclamp_none(UCLAMP_MAX));
+		uc_se->effective.group_id = uc_se->group_id;
+		uc_se->effective.value = uc_se->value;
 #endif
 	}
 }
@@ -6971,6 +6971,22 @@ void ia64_set_curr_task(int cpu, struct task_struct *p)
 static DEFINE_SPINLOCK(task_group_lock);
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
+/*
+ * free_uclamp_sched_group: release utilization clamp references of a TG
+ * @tg: the task group being removed
+ *
+ * An empty task group can be removed only when it has no more tasks or child
+ * groups. This means that we can also safely release all the reference
+ * counting to clamp groups.
+ */
+static inline void free_uclamp_sched_group(struct task_group *tg)
+{
+	int clamp_id;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
+		uclamp_group_put(clamp_id, tg->uclamp[clamp_id].group_id);
+}
+
 /**
  * alloc_uclamp_sched_group: initialize a new TG's for utilization clamping
  * @tg: the newly created task group
@@ -6989,17 +7005,18 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
 	int clamp_id;
 
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
-		tg->uclamp[clamp_id].value =
-			parent->uclamp[clamp_id].value;
-		tg->uclamp[clamp_id].group_id =
-			parent->uclamp[clamp_id].group_id;
+		uclamp_group_get(NULL, &tg->uclamp[clamp_id], clamp_id,
+				 parent->uclamp[clamp_id].value);
 		tg->uclamp[clamp_id].effective.value =
 			parent->uclamp[clamp_id].effective.value;
+		tg->uclamp[clamp_id].effective.group_id =
+			parent->uclamp[clamp_id].effective.group_id;
 	}
 
 	return 1;
 }
 #else
+static inline void free_uclamp_sched_group(struct task_group *tg) { }
 static inline int alloc_uclamp_sched_group(struct task_group *tg,
 					   struct task_group *parent)
 {
@@ -7009,6 +7026,7 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
 
 static void sched_free_group(struct task_group *tg)
 {
+	free_uclamp_sched_group(tg);
 	free_fair_sched_group(tg);
 	free_rt_sched_group(tg);
 	autogroup_free(tg);
@@ -7258,6 +7276,7 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
  * cpu_util_update_hier: propagate effective clamp down the hierarchy
  * @css: the task group to update
  * @clamp_id: the clamp index to update
+ * @group_id: the group index mapping the new task clamp value
  * @value: the new task group clamp value
  *
  * The effective clamp for a TG is expected to track the most restrictive
@@ -7277,9 +7296,13 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
  * be propagated down to all the descendants. When a subgroup is found which
  * has already its effective clamp value matching its clamp value, then we can
  * safely skip all its descendants which are granted to be already in sync.
+ *
+ * The TG's group_id is also updated to ensure it tracks the effective clamp
+ * value.
  */
 static void cpu_util_update_hier(struct cgroup_subsys_state *css,
-				 int clamp_id, unsigned int value)
+				 unsigned int clamp_id, unsigned int group_id,
+				 unsigned int value)
 {
 	struct cgroup_subsys_state *top_css = css;
 	struct uclamp_se *uc_se, *uc_parent;
@@ -7291,8 +7314,10 @@ static void cpu_util_update_hier(struct cgroup_subsys_state *css,
 		 * groups we consider their current value.
 		 */
 		uc_se = &css_tg(css)->uclamp[clamp_id];
-		if (css != top_css)
+		if (css != top_css) {
 			value = uc_se->value;
+			group_id = uc_se->effective.group_id;
+		}
 
 		/*
 		 * Skip the whole subtrees if the current effective clamp is
@@ -7308,12 +7333,15 @@ static void cpu_util_update_hier(struct cgroup_subsys_state *css,
 		}
 
 		/* Propagate the most restrictive effective value */
-		if (uc_parent->effective.value < value)
+		if (uc_parent->effective.value < value) {
 			value = uc_parent->effective.value;
+			group_id = uc_parent->effective.group_id;
+		}
 		if (uc_se->effective.value == value)
 			continue;
 
 		uc_se->effective.value = value;
+		uc_se->effective.group_id = group_id;
 	}
 }
 
@@ -7326,6 +7354,7 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 	if (min_value > SCHED_CAPACITY_SCALE)
 		return -ERANGE;
 
+	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
 
 	tg = css_tg(css);
@@ -7336,11 +7365,16 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 		goto out;
 	}
 
+	/* Update TG's reference count */
+	uclamp_group_get(NULL, &tg->uclamp[UCLAMP_MIN], UCLAMP_MIN, min_value);
+
 	/* Update effective clamps to track the most restrictive value */
-	cpu_util_update_hier(css, UCLAMP_MIN, min_value);
+	cpu_util_update_hier(css, UCLAMP_MIN, tg->uclamp[UCLAMP_MIN].group_id,
+			     min_value);
 
 out:
 	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
 
 	return ret;
 }
@@ -7354,6 +7388,7 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 	if (max_value > SCHED_CAPACITY_SCALE)
 		return -ERANGE;
 
+	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
 
 	tg = css_tg(css);
@@ -7364,11 +7399,16 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 		goto out;
 	}
 
+	/* Update TG's reference count */
+	uclamp_group_get(NULL, &tg->uclamp[UCLAMP_MAX], UCLAMP_MAX, max_value);
+
 	/* Update effective clamps to track the most restrictive value */
-	cpu_util_update_hier(css, UCLAMP_MAX, max_value);
+	cpu_util_update_hier(css, UCLAMP_MAX, tg->uclamp[UCLAMP_MAX].group_id,
+			     max_value);
 
 out:
 	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
 
 	return ret;
 }
-- 
2.18.0
