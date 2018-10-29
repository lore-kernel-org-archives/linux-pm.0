From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v5 12/15] sched/core: uclamp: propagate parent clamps
Date: Mon, 29 Oct 2018 18:33:07 +0000
Message-ID: <20181029183311.29175-14-patrick.bellasi@arm.com>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181029183311.29175-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

In order to properly support hierarchical resources control, the cgroup
delegation model requires that attribute writes from a child group never
fail but still are (potentially) constrained based on parent's assigned
resources. This requires to properly propagate and aggregate parent
attributes down to its descendants.

Let's implement this mechanism by adding a new "effective" clamp value
for each task group. The effective clamp value is defined as the smaller
value between the clamp value of a group and the effective clamp value
of its parent. This represent also the clamp value which is actually
used to clamp tasks in each task group.

Since it can be interesting for tasks in a cgroup to know exactly what
is the currently propagated/enforced configuration, the effective clamp
values are exposed to user-space by means of a new pair of read-only
attributes: cpu.util.{min,max}.effective.

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
 Message-ID: <20180912125133.GE1413@e110439-lin>
 - make more clear the definition of cpu.util.min.effective
 - small typos fixed
 Others:
 - rebased on v4.19

Changes in v4:
 Message-ID: <20180816140731.GD2960@e110439-lin>
 - add ".effective" attributes to the default hierarchy
 Others:
 - small documentation fixes
 - rebased on v4.19-rc1
Changes in v3:
 Message-ID: <20180409222417.GK3126663@devbig577.frc2.facebook.com>
 - new patch in v3, to implement a suggestion from v1 review
---
 Documentation/admin-guide/cgroup-v2.rst |  25 +++++-
 include/linux/sched.h                   |  10 ++-
 kernel/sched/core.c                     | 113 +++++++++++++++++++++++-
 3 files changed, 141 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index a6907266e52f..56bc56513721 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -976,22 +976,43 @@ All time durations are in microseconds.
         A read-write single value file which exists on non-root cgroups.
         The default is "0", i.e. no bandwidth boosting.
 
-        The minimum utilization in the range [0, 1024].
+        The requested minimum utilization in the range [0, 1024].
 
         This interface allows reading and setting minimum utilization clamp
         values similar to the sched_setattr(2). This minimum utilization
         value is used to clamp the task specific minimum utilization clamp.
 
+  cpu.util.min.effective
+        A read-only single value file which exists on non-root cgroups and
+        reports minimum utilization clamp value currently enforced on a task
+        group.
+
+        The actual minimum utilization in the range [0, 1024].
+
+        This value can be lower then cpu.util.min in case a parent cgroup
+        allows only smaller minimum utilization values.
+
   cpu.util.max
         A read-write single value file which exists on non-root cgroups.
         The default is "1024". i.e. no bandwidth capping
 
-        The maximum utilization in the range [0, 1024].
+        The requested maximum utilization in the range [0, 1024].
 
         This interface allows reading and setting maximum utilization clamp
         values similar to the sched_setattr(2). This maximum utilization
         value is used to clamp the task specific maximum utilization clamp.
 
+  cpu.util.max.effective
+        A read-only single value file which exists on non-root cgroups and
+        reports maximum utilization clamp value currently enforced on a task
+        group.
+
+        The actual maximum utilization in the range [0, 1024].
+
+        This value can be lower then cpu.util.max in case a parent cgroup
+        is enforcing a more restrictive clamping on max utilization.
+
+
 Memory
 ------
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ec6783ea4e7d..d3f6bf62ab3f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -614,7 +614,15 @@ struct uclamp_se {
 	unsigned int group_id		: order_base_2(UCLAMP_GROUPS);
 	unsigned int mapped		: 1;
 	unsigned int active		: 1;
-	/* Clamp group and value actually used by a RUNNABLE task */
+	/*
+	 * Clamp group and value actually used by a scheduling entity,
+	 * i.e. a (RUNNABLE) task or a task group.
+	 * For task groups, this is the value (eventually) enforced by a
+	 * parent task group.
+	 * For a task, this is the value (eventually) enforced by the
+	 * task group the task is currently part of or by the system
+	 * default clamp values, whichever is the most restrictive.
+	 */
 	struct {
 		unsigned int value	: SCHED_CAPACITY_SHIFT + 1;
 		unsigned int group_id	: order_base_2(UCLAMP_GROUPS);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9b06e8f156f8..cb49bffb3da8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1398,6 +1398,7 @@ static void __init init_uclamp(void)
 		uc_se = &root_task_group.uclamp[clamp_id];
 		uc_se->value = uclamp_none(clamp_id);
 		uc_se->group_id = 0;
+		uc_se->effective.value = uclamp_none(clamp_id);
 #endif
 	}
 }
@@ -6992,6 +6993,8 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
 			parent->uclamp[clamp_id].value;
 		tg->uclamp[clamp_id].group_id =
 			parent->uclamp[clamp_id].group_id;
+		tg->uclamp[clamp_id].effective.value =
+			parent->uclamp[clamp_id].effective.value;
 	}
 
 	return 1;
@@ -7251,6 +7254,69 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 }
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
+/**
+ * cpu_util_update_hier: propagate effective clamp down the hierarchy
+ * @css: the task group to update
+ * @clamp_id: the clamp index to update
+ * @value: the new task group clamp value
+ *
+ * The effective clamp for a TG is expected to track the most restrictive
+ * value between the TG's clamp value and it's parent effective clamp value.
+ * This method achieve that:
+ * 1. updating the current TG effective value
+ * 2. walking all the descendant task group that needs an update
+ *
+ * A TG's effective clamp needs to be updated when its current value is not
+ * matching the TG's clamp value. In this case indeed either:
+ * a) the parent has got a more relaxed clamp value
+ *    thus potentially we can relax the effective value for this group
+ * b) the parent has got a more strict clamp value
+ *    thus potentially we have to restrict the effective value of this group
+ *
+ * Restriction and relaxation of current TG's effective clamp values needs to
+ * be propagated down to all the descendants. When a subgroup is found which
+ * has already its effective clamp value matching its clamp value, then we can
+ * safely skip all its descendants which are granted to be already in sync.
+ */
+static void cpu_util_update_hier(struct cgroup_subsys_state *css,
+				 int clamp_id, unsigned int value)
+{
+	struct cgroup_subsys_state *top_css = css;
+	struct uclamp_se *uc_se, *uc_parent;
+
+	css_for_each_descendant_pre(css, top_css) {
+		/*
+		 * The first visited task group is top_css, which clamp value
+		 * is the one passed as parameter. For descendent task
+		 * groups we consider their current value.
+		 */
+		uc_se = &css_tg(css)->uclamp[clamp_id];
+		if (css != top_css)
+			value = uc_se->value;
+
+		/*
+		 * Skip the whole subtrees if the current effective clamp is
+		 * already matching the TG's clamp value.
+		 * In this case, all the subtrees already have top_value, or a
+		 * more restrictive, as effective clamp.
+		 */
+		uc_parent = &css_tg(css)->parent->uclamp[clamp_id];
+		if (uc_se->effective.value == value &&
+		    uc_parent->effective.value >= value) {
+			css = css_rightmost_descendant(css);
+			continue;
+		}
+
+		/* Propagate the most restrictive effective value */
+		if (uc_parent->effective.value < value)
+			value = uc_parent->effective.value;
+		if (uc_se->effective.value == value)
+			continue;
+
+		uc_se->effective.value = value;
+	}
+}
+
 static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 				  struct cftype *cftype, u64 min_value)
 {
@@ -7270,6 +7336,9 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 		goto out;
 	}
 
+	/* Update effective clamps to track the most restrictive value */
+	cpu_util_update_hier(css, UCLAMP_MIN, min_value);
+
 out:
 	rcu_read_unlock();
 
@@ -7295,6 +7364,9 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 		goto out;
 	}
 
+	/* Update effective clamps to track the most restrictive value */
+	cpu_util_update_hier(css, UCLAMP_MAX, max_value);
+
 out:
 	rcu_read_unlock();
 
@@ -7302,14 +7374,17 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 }
 
 static inline u64 cpu_uclamp_read(struct cgroup_subsys_state *css,
-				  enum uclamp_id clamp_id)
+				  enum uclamp_id clamp_id,
+				  bool effective)
 {
 	struct task_group *tg;
 	u64 util_clamp;
 
 	rcu_read_lock();
 	tg = css_tg(css);
-	util_clamp = tg->uclamp[clamp_id].value;
+	util_clamp = effective
+		? tg->uclamp[clamp_id].effective.value
+		: tg->uclamp[clamp_id].value;
 	rcu_read_unlock();
 
 	return util_clamp;
@@ -7318,13 +7393,25 @@ static inline u64 cpu_uclamp_read(struct cgroup_subsys_state *css,
 static u64 cpu_util_min_read_u64(struct cgroup_subsys_state *css,
 				 struct cftype *cft)
 {
-	return cpu_uclamp_read(css, UCLAMP_MIN);
+	return cpu_uclamp_read(css, UCLAMP_MIN, false);
 }
 
 static u64 cpu_util_max_read_u64(struct cgroup_subsys_state *css,
 				 struct cftype *cft)
 {
-	return cpu_uclamp_read(css, UCLAMP_MAX);
+	return cpu_uclamp_read(css, UCLAMP_MAX, false);
+}
+
+static u64 cpu_util_min_effective_read_u64(struct cgroup_subsys_state *css,
+					   struct cftype *cft)
+{
+	return cpu_uclamp_read(css, UCLAMP_MIN, true);
+}
+
+static u64 cpu_util_max_effective_read_u64(struct cgroup_subsys_state *css,
+					   struct cftype *cft)
+{
+	return cpu_uclamp_read(css, UCLAMP_MAX, true);
 }
 #endif /* CONFIG_UCLAMP_TASK_GROUP */
 
@@ -7672,11 +7759,19 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_util_min_read_u64,
 		.write_u64 = cpu_util_min_write_u64,
 	},
+	{
+		.name = "util.min.effective",
+		.read_u64 = cpu_util_min_effective_read_u64,
+	},
 	{
 		.name = "util.max",
 		.read_u64 = cpu_util_max_read_u64,
 		.write_u64 = cpu_util_max_write_u64,
 	},
+	{
+		.name = "util.max.effective",
+		.read_u64 = cpu_util_max_effective_read_u64,
+	},
 #endif
 	{ }	/* Terminate */
 };
@@ -7852,12 +7947,22 @@ static struct cftype cpu_files[] = {
 		.read_u64 = cpu_util_min_read_u64,
 		.write_u64 = cpu_util_min_write_u64,
 	},
+	{
+		.name = "util.min.effective",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_util_min_effective_read_u64,
+	},
 	{
 		.name = "util.max",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = cpu_util_max_read_u64,
 		.write_u64 = cpu_util_max_write_u64,
 	},
+	{
+		.name = "util.max.effective",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_util_max_effective_read_u64,
+	},
 #endif
 	{ }	/* terminate */
 };
-- 
2.18.0
