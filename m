From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFCv4 2/6] sched/core: map cpu's task groups to clamp groups
Date: Thu, 24 Aug 2017 19:08:53 +0100
Message-ID: <20170824180857.32103-3-patrick.bellasi@arm.com>
References: <20170824180857.32103-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170824180857.32103-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

To properly support per-task utilization clamping, each CPU needs to know
which clamp values are required by tasks currently RUNNABLE on that CPU.
However, multiple task groups can define the same clamp value for a given
clamp index (i.e. util_{min,max}).
Thus, a mechanism is required to map clamp values to a properly defined
data structure which is suitable for fast and efficient aggregation of
clamp values coming from tasks belonging to different task_groups.

Such a data structure can be an array of reference counters, where each
slot is used to account how many tasks requiring a certain clamp value
are currently enqueued. Thus each clamp value can be mapped into a
"clamp index" which identifies the position within the reference
counters array.

                                 :
                                 :
             SLOW PATH           :             FAST PATH
         task_group::write       :     sched/core::enqueue/dequeue
                                 :         cpufreq_schedutil
                                 :
  +----------------+    +--------------------+     +-------------------+
  |   TASK GROUP   |    |     CLAMP GROUP    |     |    CPU CLAMPS     |
  +----------------+    +--------------------+     +-------------------+
  |                |    |   clamp_{min,max}  |     |  clamp_{min,max}  |
  | util_{min,max} |    |      tg_count      |     |    tasks count    |
  +----------------+    +--------------------+     +-------------------+
                                 :
           +------------------>  :  +------------------->
  map(clamp_value, clamp_group)  :  ref_count(clamp_group)
                                 :
                                 :
                                 :

This patch introduces the support to map task groups on "clamp groups".
Specifically it introduces the required functions to translate a clamp
value into a clamp group index.

Only a limited number of (different) clamp values are supported since:
1. there are usually only few classes of workloads for which it makes
   sense to boost/cap to different frequencies
   e.g. background vs foreground, interactive vs low-priority
2. it allows a simpler and more memory/time efficient tracking of
   the per-CPU clamp values in the fast path

The number of possible different clamp values is currently defined at
compile time. It's worth to notice that this does not impose a limitation
on the number of task groups that can be generated. Indeed, each new task
group always maps to the clamp groups of its parent.
Instead, changing the clamp value for a TG can result into a -ENOSPC error
in case this will exceed the number of maximum different clamp values
supported.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 init/Kconfig         |  19 +++
 kernel/sched/core.c  | 348 +++++++++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h |  21 +++-
 3 files changed, 363 insertions(+), 25 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index db736529f08b..5f0c246f2a3a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -771,6 +771,25 @@ config UTIL_CLAMP
 
 	  If in doubt, say N.
 
+config UCLAMP_GROUPS_COUNT
+	int "Number of utilization clamp values supported"
+	range 1 127
+	depends on UTIL_CLAMP
+	default 3
+	help
+	  This defines the maximum number of different utilization clamp
+	  values which can be concurrently enforced for each utilization
+	  clamp index (i.e. minimum and maximum).
+
+	  Only a limited number of clamp values are supported because:
+	    1. there are usually only few classes of workloads for which is
+	       makese sense to boost/cap for different frequencies
+	       e.g. background vs foreground, interactive vs low-priority
+	    2. it allows a simpler and more memory/time efficient tracking of
+	       the per-CPU clamp values.
+
+	  If in doubt, use the default value.
+
 config CGROUP_PIDS
 	bool "PIDs controller"
 	help
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 20b5a11d64ab..0d39766f2b03 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -757,6 +757,232 @@ static void set_load_weight(struct task_struct *p)
  */
 static DEFINE_MUTEX(uclamp_mutex);
 
+/**
+ * uclamp_map: a clamp group representing a clamp value
+ *
+ * Since only a limited number of different clamp values are supported, this
+ * map allows to track how many TG's use the same clamp value and it defines
+ * the clamp group index used by the per-CPU accounting in the fast-path
+ * (i.e. tasks enqueuing/dequeuing)
+ *
+ * Since we support both max and min utilization clamp value, a matrix is used
+ * to map clamp values to group indexes:
+ * - rows map the different clamp indexes
+ *   i.e. minimum or maximum utilization
+ * - columns map the different clamp groups
+ *   i.e. TG's with similar clamp value for a given clamp index
+ *
+ * NOTE: clamp group 0 is reserved for the tracking of non clamped tasks.
+ * Thus we allocate one more slot than the value of
+ * CONFIG_UCLAMP_GROUPS_COUNT.
+ */
+struct uclamp_map {
+	int value;
+	int tg_count;
+	raw_spinlock_t tg_lock;
+};
+
+/**
+ * uclamp_maps: map TGs into per-CPU utilization clamp values
+ *
+ * This is a matrix where:
+ * - rows are indexed by clamp_id, and collects the clamp group for a given
+ *   clamp index (i.e. minimum or maximum utilization)
+ * - cols are indexed by group_id, and represents an actual clamp group (i.e.
+ *   a uclamp_map instance)
+ *
+ * Here is the map layout and, right below, how entries are accessed by the
+ * following code.
+ *
+ *                          uclamp_maps is a matrix of
+ *          +------- UCLAMP_CNT by CONFIG_UCLAMP_GROUPS_COUNT+1 entries
+ *          |                                |
+ *          |                /---------------+---------------\
+ *          |               +------------+       +------------+
+ *          |  / UCLAMP_MIN | value      |       | value      |
+ *          |  |            | tg_count   |...... | tg_count   |
+ *          |  |            +------------+       +------------+
+ *          +--+            +------------+       +------------+
+ *             |            | value      |       | value      |
+ *             \ UCLAMP_MAX | tg_count   |...... | tg_count   |
+ *                          +-----^------+       +----^-------+
+ *                                |                   |
+ *                      uc_map =  +                   |
+ *                     &uclamp_maps[clamp_id][0]      +
+ *                                                clamp_value =
+ *                                       uc_map[group_id].value
+ */
+static struct uclamp_map uclamp_maps[UCLAMP_CNT][CONFIG_UCLAMP_GROUPS_COUNT + 1];
+
+/**
+ * uclamp_group_available: check if a clamp group is available
+ * @clamp_id: the utilization clamp index (i.e. min or max clamp)
+ * @group_id: the group index in the given clamp_id
+ *
+ * A clamp group is not free if there is at least one TG's using a clamp value
+ * mapped on the specified clamp_id. These TG's are reference counted by the
+ * tg_count of a uclamp_map entry.
+ *
+ * Return: true if there are no TG's mapped on the specified clamp
+ *         index and group
+ */
+static inline bool uclamp_group_available(int clamp_id, int group_id)
+{
+	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+
+	return (uc_map[group_id].value == UCLAMP_NONE);
+}
+
+/**
+ * uclamp_group_init: map a clamp value on a specified clamp group
+ * @clamp_id: the utilization clamp index (i.e. min or max clamp)
+ * @group_id: the group index to map a given clamp_value
+ * @clamp_value: the utilization clamp value to map
+ *
+ * Each different clamp value, for a given clamp index (i.e. min/max
+ * utilization clamp), is mapped by a clamp group which index is use by the
+ * fast-path code to keep track of active tasks requiring a certain clamp
+ * value.
+ *
+ * This function initializes a clamp group to track tasks from the fast-path.
+ */
+static inline void uclamp_group_init(int clamp_id, int group_id,
+				     unsigned int clamp_value)
+{
+	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+
+	uc_map[group_id].value = clamp_value;
+	uc_map[group_id].tg_count = 0;
+}
+
+/**
+ * uclamp_group_reset: reset a specified clamp group
+ * @clamp_id: the utilization clamp index (i.e. min or max clamping)
+ * @group_id: the group index to release
+ *
+ * A clamp group can be reset every time there are no more TGs using the
+ * clamp value it maps for a given clamp index.
+ */
+static inline void uclamp_group_reset(int clamp_id, int group_id)
+{
+	uclamp_group_init(clamp_id, group_id, UCLAMP_NONE);
+}
+
+/**
+ * uclamp_group_find: find the group index of a utilization clamp group
+ * @clamp_id: the utilization clamp index (i.e. min or max clamping)
+ * @clamp_value: the utilization clamping value lookup for
+ *
+ * Verify if a group has been assigned to a certain clamp value and return
+ * its index to be used for accounting.
+ *
+ * Since only a limited number of utilization clamp groups are allowed, if no
+ * groups have been assigned for the specified value, a new group is assigned
+ * if possible. Otherwise an error is returned, meaning that a different clamp
+ * value is not (currently) supported.
+ */
+static int
+uclamp_group_find(int clamp_id, unsigned int clamp_value)
+{
+	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+	int free_group_id = UCLAMP_NONE;
+	unsigned int group_id = 0;
+
+	for ( ; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
+		/* Keep track of first free clamp group */
+		if (uclamp_group_available(clamp_id, group_id)) {
+			if (free_group_id == UCLAMP_NONE)
+				free_group_id = group_id;
+			continue;
+		}
+		/* Return index of first group with same clamp value */
+		if (uc_map[group_id].value == clamp_value)
+			return group_id;
+	}
+	/* Default to first free clamp group */
+	if (group_id > CONFIG_UCLAMP_GROUPS_COUNT)
+		group_id = free_group_id;
+	/* All clamp group already tracking different clamp values */
+	if (group_id == UCLAMP_NONE)
+		return -ENOSPC;
+	return group_id;
+}
+
+/**
+ * uclamp_group_put: decrease the reference count for a clamp group
+ * @clamp_id: the clamp index which was affected by a task group
+ * @uc_tg: the utilization clamp data for that task group
+ *
+ * When the clamp value for a task group is changed we decrease the reference
+ * count for the clamp group mapping its current clamp value. A clamp group is
+ * released when there are no more task groups referencing its clamp value.
+ */
+static inline void uclamp_group_put(int clamp_id, int group_id)
+{
+	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+	unsigned long flags;
+
+	/* Ignore TG's not yet attached */
+	if (group_id == UCLAMP_NONE)
+		return;
+
+	/* Remove TG from this clamp group */
+	raw_spin_lock_irqsave(&uc_map[group_id].tg_lock, flags);
+	uc_map[group_id].tg_count -= 1;
+	if (uc_map[group_id].tg_count == 0)
+		uclamp_group_reset(clamp_id, group_id);
+	raw_spin_unlock_irqrestore(&uc_map[group_id].tg_lock, flags);
+}
+
+/**
+ * uclamp_group_get: increase the reference count for a clamp group
+ * @css: reference to the task group to account
+ * @clamp_id: the clamp index affected by the task group
+ * @uc_tg: the utilization clamp data for the task group
+ * @clamp_value: the new clamp value for the task group
+ *
+ * Each time a task group changes the utilization clamp value, for a specified
+ * clamp index, we need to find an available clamp group which can be used
+ * to track its new clamp value. The corresponding clamp group index will be
+ * used by tasks in this task group to reference count the clamp value on CPUs
+ * where they are enqueued.
+ *
+ * Return: -ENOSPC if there are not available clamp groups, 0 on success.
+ */
+static inline int uclamp_group_get(struct cgroup_subsys_state *css,
+				   int clamp_id, struct uclamp_tg *uc_tg,
+				   unsigned int clamp_value)
+{
+	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+	int prev_group_id = uc_tg->group_id;
+	int next_group_id = UCLAMP_NONE;
+	unsigned long flags;
+
+	/* Lookup for a usable utilization clamp group */
+	next_group_id = uclamp_group_find(clamp_id, clamp_value);
+	if (next_group_id < 0) {
+		pr_err("Cannot allocate more than %d utilization clamp groups\n",
+		       CONFIG_UCLAMP_GROUPS_COUNT);
+		return -ENOSPC;
+	}
+
+	/* Allocate new clamp group for this clamp value */
+	if (uclamp_group_available(clamp_id, next_group_id))
+		uclamp_group_init(clamp_id, next_group_id, clamp_value);
+
+	/* Update TG's clamp values and attach it to new clamp group */
+	raw_spin_lock_irqsave(&uc_map[next_group_id].tg_lock, flags);
+	uc_tg->value = clamp_value;
+	uc_tg->group_id = next_group_id;
+	uc_map[next_group_id].tg_count += 1;
+	raw_spin_unlock_irqrestore(&uc_map[next_group_id].tg_lock, flags);
+
+	/* Release the previous clamp group */
+	uclamp_group_put(clamp_id, prev_group_id);
+
+	return 0;
+}
+
 /**
  * alloc_uclamp_sched_group: initialize a new TG's for utilization clamping
  * @tg: the newly created task group
@@ -764,14 +990,52 @@ static DEFINE_MUTEX(uclamp_mutex);
  *
  * A newly created task group inherits its utilization clamp values, for all
  * clamp indexes, from its parent task group.
+ * This ensures that its values are properly initialized and that the task
+ * group is accounted in the same parent's group index.
+ *
+ * Return: !0 on error
+ */
+static inline int alloc_uclamp_sched_group(struct task_group *tg,
+					   struct task_group *parent)
+{
+	struct uclamp_tg *uc_tg;
+	int clamp_id;
+	int ret = 1;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		uc_tg = &tg->uclamp[clamp_id];
+
+		uc_tg->value = parent->uclamp[clamp_id].value;
+		uc_tg->group_id = UCLAMP_NONE;
+
+		if (uclamp_group_get(NULL, clamp_id, uc_tg,
+				     parent->uclamp[clamp_id].value)) {
+			ret = 0;
+			goto out;
+		}
+	}
+
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
  */
-static inline void alloc_uclamp_sched_group(struct task_group *tg,
-					    struct task_group *parent)
+static inline void free_uclamp_sched_group(struct task_group *tg)
 {
+	struct uclamp_tg *uc_tg;
 	int clamp_id;
 
-	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
-		tg->uclamp[clamp_id] = parent->uclamp[clamp_id];
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		uc_tg = &tg->uclamp[clamp_id];
+		uclamp_group_put(clamp_id, uc_tg->group_id);
+	}
 }
 
 /**
@@ -779,17 +1043,49 @@ static inline void alloc_uclamp_sched_group(struct task_group *tg,
  */
 static inline void init_uclamp(void)
 {
+	struct uclamp_map *uc_map;
+	struct uclamp_tg *uc_tg;
+	int group_id;
 	int clamp_id;
 
 	mutex_init(&uclamp_mutex);
 
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		uc_map = &uclamp_maps[clamp_id][0];
+		/* Init TG's clamp map */
+		group_id = 0;
+		for ( ; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
+			uc_map[group_id].value = UCLAMP_NONE;
+			raw_spin_lock_init(&uc_map[group_id].tg_lock);
+		}
+	}
+
+	/* Root TG's are initialized to the first clamp group */
+	group_id = 0;
+
 	/* Initialize root TG's to default (none) clamp values */
-	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
-		root_task_group.uclamp[clamp_id] = uclamp_none(clamp_id);
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		uc_map = &uclamp_maps[clamp_id][0];
+
+		/* Map root TG's clamp value */
+		uclamp_group_init(clamp_id, group_id, uclamp_none(clamp_id));
+
+		/* Init root TG's clamp group */
+		uc_tg = &root_task_group.uclamp[clamp_id];
+		uc_tg->value = uclamp_none(clamp_id);
+		uc_tg->group_id = group_id;
+
+		/* Attach root TG's clamp group */
+		uc_map[group_id].tg_count = 1;
+	}
 }
 #else
-static inline void alloc_uclamp_sched_group(struct task_group *tg,
-					    struct task_group *parent) { }
+static inline int alloc_uclamp_sched_group(struct task_group *tg,
+					   struct task_group *parent)
+{
+	return 1;
+}
+static inline void free_uclamp_sched_group(struct task_group *tg) { }
 static inline void init_uclamp(void) { }
 #endif /* CONFIG_UTIL_CLAMP */
 
@@ -6122,6 +6418,7 @@ static DEFINE_SPINLOCK(task_group_lock);
 
 static void sched_free_group(struct task_group *tg)
 {
+	free_uclamp_sched_group(tg);
 	free_fair_sched_group(tg);
 	free_rt_sched_group(tg);
 	autogroup_free(tg);
@@ -6143,7 +6440,8 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
-	alloc_uclamp_sched_group(tg, parent);
+	if (!alloc_uclamp_sched_group(tg, parent))
+		goto err;
 
 	return tg;
 
@@ -6370,6 +6668,7 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 				  struct cftype *cftype, u64 min_value)
 {
 	struct cgroup_subsys_state *pos;
+	struct uclamp_tg *uc_tg;
 	struct task_group *tg;
 	int ret = -EINVAL;
 
@@ -6382,29 +6681,29 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 	tg = css_tg(css);
 
 	/* Already at the required value */
-	if (tg->uclamp[UCLAMP_MIN] == min_value) {
+	if (tg->uclamp[UCLAMP_MIN].value == min_value) {
 		ret = 0;
 		goto out;
 	}
 
 	/* Ensure to not exceed the maximum clamp value */
-	if (tg->uclamp[UCLAMP_MAX] < min_value)
+	if (tg->uclamp[UCLAMP_MAX].value < min_value)
 		goto out;
 
 	/* Ensure min clamp fits within parent's clamp value */
 	if (tg->parent &&
-	    tg->parent->uclamp[UCLAMP_MIN] > min_value)
+	    tg->parent->uclamp[UCLAMP_MIN].value > min_value)
 		goto out;
 
 	/* Ensure each child is a restriction of this TG */
 	css_for_each_child(pos, css) {
-		if (css_tg(pos)->uclamp[UCLAMP_MIN] < min_value)
+		if (css_tg(pos)->uclamp[UCLAMP_MIN].value < min_value)
 			goto out;
 	}
 
-	/* Update TG's utilization clamp */
-	tg->uclamp[UCLAMP_MIN] = min_value;
-	ret = 0;
+	/* Update TG's reference count */
+	uc_tg = &tg->uclamp[UCLAMP_MIN];
+	ret = uclamp_group_get(css, UCLAMP_MIN, uc_tg, min_value);
 
 out:
 	rcu_read_unlock();
@@ -6417,6 +6716,7 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 				  struct cftype *cftype, u64 max_value)
 {
 	struct cgroup_subsys_state *pos;
+	struct uclamp_tg *uc_tg;
 	struct task_group *tg;
 	int ret = -EINVAL;
 
@@ -6429,29 +6729,29 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 	tg = css_tg(css);
 
 	/* Already at the required value */
-	if (tg->uclamp[UCLAMP_MAX] == max_value) {
+	if (tg->uclamp[UCLAMP_MAX].value == max_value) {
 		ret = 0;
 		goto out;
 	}
 
 	/* Ensure to not go below the minimum clamp value */
-	if (tg->uclamp[UCLAMP_MIN] > max_value)
+	if (tg->uclamp[UCLAMP_MIN].value > max_value)
 		goto out;
 
 	/* Ensure max clamp fits within parent's clamp value */
 	if (tg->parent &&
-	    tg->parent->uclamp[UCLAMP_MAX] < max_value)
+	    tg->parent->uclamp[UCLAMP_MAX].value < max_value)
 		goto out;
 
 	/* Ensure each child is a restriction of this TG */
 	css_for_each_child(pos, css) {
-		if (css_tg(pos)->uclamp[UCLAMP_MAX] > max_value)
+		if (css_tg(pos)->uclamp[UCLAMP_MAX].value > max_value)
 			goto out;
 	}
 
-	/* Update TG's utilization clamp */
-	tg->uclamp[UCLAMP_MAX] = max_value;
-	ret = 0;
+	/* Update TG's reference count */
+	uc_tg = &tg->uclamp[UCLAMP_MAX];
+	ret = uclamp_group_get(css, UCLAMP_MAX, uc_tg, max_value);
 
 out:
 	rcu_read_unlock();
@@ -6468,7 +6768,7 @@ static inline u64 cpu_uclamp_read(struct cgroup_subsys_state *css,
 
 	rcu_read_lock();
 	tg = css_tg(css);
-	util_clamp = tg->uclamp[clamp_id];
+	util_clamp = tg->uclamp[clamp_id].value;
 	rcu_read_unlock();
 
 	return util_clamp;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 982340b8870b..869344de0396 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -290,6 +290,24 @@ struct cfs_bandwidth {
 #endif
 };
 
+/**
+ * Utilization's clamp group
+ *
+ * A utilization clamp group maps a "clamp value" (value), i.e.
+ * util_{min,max}, to a "clamp group index" (group_id).
+ *
+ * Thus, the same "group_id" is used by all the TG's which enforce the same
+ * clamp "value" for a given clamp index.
+ */
+struct uclamp_tg {
+	/* Utilization constraint for tasks in this group */
+	unsigned int value;
+	/* Utilization clamp group for this constraint */
+	unsigned int group_id;
+	/* No utilization clamp group assigned */
+#define UCLAMP_NONE	-1
+};
+
 /* task group related information */
 struct task_group {
 	struct cgroup_subsys_state css;
@@ -332,8 +350,9 @@ struct task_group {
 	struct cfs_bandwidth cfs_bandwidth;
 
 #ifdef CONFIG_UTIL_CLAMP
-	unsigned int uclamp[UCLAMP_CNT];
+	struct uclamp_tg uclamp[UCLAMP_CNT];
 #endif
+
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.14.1
