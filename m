From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFCv4 1/6] sched/core: add utilization clamping to CPU controller
Date: Thu, 24 Aug 2017 19:08:52 +0100
Message-ID: <20170824180857.32103-2-patrick.bellasi@arm.com>
References: <20170824180857.32103-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170824180857.32103-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The cgroup's CPU controller allows to assign a specified (maximum)
bandwidth to the tasks of a group. However this bandwidth is defined and
enforced only on a temporal base, without considering the actual
frequency a CPU is running on. Thus, the amount of computation completed
by a task within an allocated bandwidth can be very different depending
on the actual frequency the CPU is running that task.

With the availability of schedutil, the scheduler is now able
to drive frequency selections based on the actual tasks utilization.
Thus, it is now possible to extend the cpu controller to specify what
is the minimum (or maximum) utilization which a task is allowed to
generate.  By adding new constraints on minimum and maximum utilization
allowed for tasks in a cpu control group it will be possible to better
control the actual amount of CPU bandwidth consumed by these tasks.

The ultimate goal of this new pair of constraints is to enable:

- boosting: by selecting a higher execution frequency for small tasks
            which are affecting the user interactive experience

- capping: by enforcing lower execution frequency (which usually improves
	   energy efficiency) for big tasks which are mainly related to
	   background activities without a direct impact on the user
	   experience.

This patch extends the CPU controller by adding a couple of new attributes,
util_min and util_max, which can be used to enforce frequency boosting and
capping. Specifically:

- util_min: defines the minimum CPU utilization which should be considered,
	    e.g. when  schedutil selects the frequency for a CPU while a
	    task in this group is RUNNABLE.
	    i.e. the task will run at least at a minimum frequency which
	         corresponds to the min_util utilization

- util_max: defines the maximum CPU utilization which should be considered,
	    e.g. when schedutil selects the frequency for a CPU while a
	    task in this group is RUNNABLE.
	    i.e. the task will run up to a maximum frequency which
	         corresponds to the max_util utilization

These attributes:
a) are tunable at all hierarchy levels, i.e. at root group level too, thus
   allowing to defined minimum and maximum frequency constraints for all
   otherwise non-classified tasks (e.g. autogroups)
b) allow to create subgroups of tasks which are not violating the
   utilization constraints defined by the parent group.

Tasks on a subgroup can only be more boosted and/or capped, which is
matching with the "limits" schema proposed by the "Resource Distribution
Model (RDM)" suggested by the CGroups v2 documentation:
   Documentation/cgroup-v2.txt

This patch provides the basic support to expose the two new attributes and
to validate their run-time update based on the "limits" of the
aforementioned RDM schema.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 include/linux/sched.h |   7 ++
 init/Kconfig          |  17 +++++
 kernel/sched/core.c   | 180 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  |  22 ++++++
 4 files changed, 226 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c28b182c9833..265ac0898f9e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -241,6 +241,13 @@ struct vtime {
 	u64			gtime;
 };
 
+enum uclamp_id {
+	UCLAMP_MIN = 0, /* Minimum utilization */
+	UCLAMP_MAX,     /* Maximum utilization */
+	/* Utilization clamping constraints count */
+	UCLAMP_CNT
+};
+
 struct sched_info {
 #ifdef CONFIG_SCHED_INFO
 	/* Cumulative counters: */
diff --git a/init/Kconfig b/init/Kconfig
index 8514b25db21c..db736529f08b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -754,6 +754,23 @@ config RT_GROUP_SCHED
 
 endif #CGROUP_SCHED
 
+config UTIL_CLAMP
+	bool "Utilization clamping per group of tasks"
+	depends on CPU_FREQ_GOV_SCHEDUTIL
+	depends on CGROUP_SCHED
+	default n
+	help
+	  This feature enables the scheduler to track the clamped utilization
+	  of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
+
+	  When this option is enabled, the user can specify a min and max
+	  CPU bandwidth which is allowed for each single task in a group.
+	  The max bandwidth allows to clamp the maximum frequency a task
+	  can use, while the min bandwidth allows to define a minimum
+	  frequency a task will alwasy use.
+
+	  If in doubt, say N.
+
 config CGROUP_PIDS
 	bool "PIDs controller"
 	help
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f9f9948e2470..20b5a11d64ab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -751,6 +751,48 @@ static void set_load_weight(struct task_struct *p)
 	load->inv_weight = sched_prio_to_wmult[prio];
 }
 
+#ifdef CONFIG_UTIL_CLAMP
+/**
+ * uclamp_mutex: serialize updates of TG's utilization clamp values
+ */
+static DEFINE_MUTEX(uclamp_mutex);
+
+/**
+ * alloc_uclamp_sched_group: initialize a new TG's for utilization clamping
+ * @tg: the newly created task group
+ * @parent: its parent task group
+ *
+ * A newly created task group inherits its utilization clamp values, for all
+ * clamp indexes, from its parent task group.
+ */
+static inline void alloc_uclamp_sched_group(struct task_group *tg,
+					    struct task_group *parent)
+{
+	int clamp_id;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
+		tg->uclamp[clamp_id] = parent->uclamp[clamp_id];
+}
+
+/**
+ * init_uclamp: initialize data structures required for utilization clamping
+ */
+static inline void init_uclamp(void)
+{
+	int clamp_id;
+
+	mutex_init(&uclamp_mutex);
+
+	/* Initialize root TG's to default (none) clamp values */
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
+		root_task_group.uclamp[clamp_id] = uclamp_none(clamp_id);
+}
+#else
+static inline void alloc_uclamp_sched_group(struct task_group *tg,
+					    struct task_group *parent) { }
+static inline void init_uclamp(void) { }
+#endif /* CONFIG_UTIL_CLAMP */
+
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (!(flags & ENQUEUE_NOCLOCK))
@@ -5907,6 +5949,8 @@ void __init sched_init(void)
 
 	init_schedstats();
 
+	init_uclamp();
+
 	scheduler_running = 1;
 }
 
@@ -6099,6 +6143,8 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+	alloc_uclamp_sched_group(tg, parent);
+
 	return tg;
 
 err:
@@ -6319,6 +6365,128 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 		sched_move_task(task);
 }
 
+#ifdef CONFIG_UTIL_CLAMP
+static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
+				  struct cftype *cftype, u64 min_value)
+{
+	struct cgroup_subsys_state *pos;
+	struct task_group *tg;
+	int ret = -EINVAL;
+
+	if (min_value > SCHED_CAPACITY_SCALE)
+		return ret;
+
+	mutex_lock(&uclamp_mutex);
+	rcu_read_lock();
+
+	tg = css_tg(css);
+
+	/* Already at the required value */
+	if (tg->uclamp[UCLAMP_MIN] == min_value) {
+		ret = 0;
+		goto out;
+	}
+
+	/* Ensure to not exceed the maximum clamp value */
+	if (tg->uclamp[UCLAMP_MAX] < min_value)
+		goto out;
+
+	/* Ensure min clamp fits within parent's clamp value */
+	if (tg->parent &&
+	    tg->parent->uclamp[UCLAMP_MIN] > min_value)
+		goto out;
+
+	/* Ensure each child is a restriction of this TG */
+	css_for_each_child(pos, css) {
+		if (css_tg(pos)->uclamp[UCLAMP_MIN] < min_value)
+			goto out;
+	}
+
+	/* Update TG's utilization clamp */
+	tg->uclamp[UCLAMP_MIN] = min_value;
+	ret = 0;
+
+out:
+	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
+
+	return ret;
+}
+
+static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
+				  struct cftype *cftype, u64 max_value)
+{
+	struct cgroup_subsys_state *pos;
+	struct task_group *tg;
+	int ret = -EINVAL;
+
+	if (max_value > SCHED_CAPACITY_SCALE)
+		return ret;
+
+	mutex_lock(&uclamp_mutex);
+	rcu_read_lock();
+
+	tg = css_tg(css);
+
+	/* Already at the required value */
+	if (tg->uclamp[UCLAMP_MAX] == max_value) {
+		ret = 0;
+		goto out;
+	}
+
+	/* Ensure to not go below the minimum clamp value */
+	if (tg->uclamp[UCLAMP_MIN] > max_value)
+		goto out;
+
+	/* Ensure max clamp fits within parent's clamp value */
+	if (tg->parent &&
+	    tg->parent->uclamp[UCLAMP_MAX] < max_value)
+		goto out;
+
+	/* Ensure each child is a restriction of this TG */
+	css_for_each_child(pos, css) {
+		if (css_tg(pos)->uclamp[UCLAMP_MAX] > max_value)
+			goto out;
+	}
+
+	/* Update TG's utilization clamp */
+	tg->uclamp[UCLAMP_MAX] = max_value;
+	ret = 0;
+
+out:
+	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
+
+	return ret;
+}
+
+static inline u64 cpu_uclamp_read(struct cgroup_subsys_state *css,
+				  enum uclamp_id clamp_id)
+{
+	struct task_group *tg;
+	u64 util_clamp;
+
+	rcu_read_lock();
+	tg = css_tg(css);
+	util_clamp = tg->uclamp[clamp_id];
+	rcu_read_unlock();
+
+	return util_clamp;
+}
+
+static u64 cpu_util_min_read_u64(struct cgroup_subsys_state *css,
+				 struct cftype *cft)
+{
+	return cpu_uclamp_read(css, UCLAMP_MIN);
+}
+
+static u64 cpu_util_max_read_u64(struct cgroup_subsys_state *css,
+				 struct cftype *cft)
+{
+	return cpu_uclamp_read(css, UCLAMP_MAX);
+}
+#endif /* CONFIG_UTIL_CLAMP */
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cftype, u64 shareval)
@@ -6641,6 +6809,18 @@ static struct cftype cpu_files[] = {
 		.read_u64 = cpu_rt_period_read_uint,
 		.write_u64 = cpu_rt_period_write_uint,
 	},
+#endif
+#ifdef CONFIG_UTIL_CLAMP
+	{
+		.name = "util_min",
+		.read_u64 = cpu_util_min_read_u64,
+		.write_u64 = cpu_util_min_write_u64,
+	},
+	{
+		.name = "util_max",
+		.read_u64 = cpu_util_max_read_u64,
+		.write_u64 = cpu_util_max_write_u64,
+	},
 #endif
 	{ }	/* Terminate */
 };
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eeef1a3086d1..982340b8870b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -330,6 +330,10 @@ struct task_group {
 #endif
 
 	struct cfs_bandwidth cfs_bandwidth;
+
+#ifdef CONFIG_UTIL_CLAMP
+	unsigned int uclamp[UCLAMP_CNT];
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -365,6 +369,24 @@ static inline int walk_tg_tree(tg_visitor down, tg_visitor up, void *data)
 
 extern int tg_nop(struct task_group *tg, void *data);
 
+#ifdef CONFIG_UTIL_CLAMP
+/**
+ * uclamp_none: default value for a clamp
+ *
+ * This returns the default value for each clamp
+ * - 0 for a min utilization clamp
+ * - SCHED_CAPACITY_SCALE for a max utilization clamp
+ *
+ * Return: the default value for a given utilization clamp
+ */
+static inline unsigned int uclamp_none(int clamp_id)
+{
+	if (clamp_id == UCLAMP_MIN)
+		return 0;
+	return SCHED_CAPACITY_SCALE;
+}
+#endif /* CONFIG_UTIL_CLAMP */
+
 extern void free_fair_sched_group(struct task_group *tg);
 extern int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent);
 extern void online_fair_sched_group(struct task_group *tg);
-- 
2.14.1
