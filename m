From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC v3 1/5] sched/core: add capacity constraints to CPU controller
Date: Tue, 28 Feb 2017 14:38:38 +0000
Message-ID: <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

The CPU CGroup controller allows to assign a specified (maximum)
bandwidth to tasks within a group, however it does not enforce any
constraint on how such bandwidth can be consumed.
With the integration of schedutil, the scheduler has now the proper
information about a task to select  the most suitable frequency to
satisfy tasks needs.

This patch extends the CPU controller by adding a couple of new
attributes, capacity_min and capacity_max, which can be used to enforce
bandwidth boosting and capping. More specifically:

- capacity_min: defines the minimum capacity which should be granted
                (by schedutil) when a task in this group is running,
                i.e. the task will run at least at that capacity

- capacity_max: defines the maximum capacity which can be granted
                (by schedutil) when a task in this group is running,
                i.e. the task can run up to that capacity

These attributes:
a) are tunable at all hierarchy levels, i.e. root group too
b) allow to create subgroups of tasks which are not violating the
   capacity constraints defined by the parent group.
   Thus, tasks on a subgroup can only be more boosted and/or more
   capped, which is matching with the "limits" schema proposed by
   the "Resource Distribution Model (RDM)" suggested by the
   CGroups v2 documentation (Documentation/cgroup-v2.txt)

This patch provides the basic support to expose the two new attributes
and to validate their run-time update based on the "limits" schema of
the RDM.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 init/Kconfig         |  17 ++++++
 kernel/sched/core.c  | 145 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |   8 +++
 3 files changed, 170 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index e1a93734..71e46ce 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1044,6 +1044,23 @@ menuconfig CGROUP_SCHED
 	  bandwidth allocation to such task groups. It uses cgroups to group
 	  tasks.
 
+config CAPACITY_CLAMPING
+	bool "Capacity clamping per group of tasks"
+	depends on CPU_FREQ_GOV_SCHEDUTIL
+	depends on CGROUP_SCHED
+	default n
+	help
+	  This feature allows the scheduler to enforce maximum and minimum
+	  capacity on each CPU based on RUNNABLE tasks currently scheduled
+	  on that CPU.
+	  Minimum capacity can be used for example to "boost" the performance
+	  of important tasks by running them on an OPP which can be higher than
+	  the minimum one eventually selected by the schedutil governor.
+	  Maximum capacity can be used for example to "restrict" the maximum
+	  OPP which can be requested by background tasks.
+
+	  If in doubt, say N.
+
 if CGROUP_SCHED
 config FAIR_GROUP_SCHED
 	bool "Group scheduling for SCHED_OTHER"
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 34e2291..a171d49 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6015,6 +6015,11 @@ void __init sched_init(void)
 	autogroup_init(&init_task);
 #endif /* CONFIG_CGROUP_SCHED */
 
+#ifdef CONFIG_CAPACITY_CLAMPING
+	root_task_group.cap_clamp[CAP_CLAMP_MIN] = 0;
+	root_task_group.cap_clamp[CAP_CLAMP_MAX] = SCHED_CAPACITY_SCALE;
+#endif /* CONFIG_CAPACITY_CLAMPING */
+
 	for_each_possible_cpu(i) {
 		struct rq *rq;
 
@@ -6310,6 +6315,11 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+#ifdef CONFIG_CAPACITY_CLAMPING
+	tg->cap_clamp[CAP_CLAMP_MIN] = parent->cap_clamp[CAP_CLAMP_MIN];
+	tg->cap_clamp[CAP_CLAMP_MAX] = parent->cap_clamp[CAP_CLAMP_MAX];
+#endif
+
 	return tg;
 
 err:
@@ -6899,6 +6909,129 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 		sched_move_task(task);
 }
 
+#ifdef CONFIG_CAPACITY_CLAMPING
+
+static DEFINE_MUTEX(cap_clamp_mutex);
+
+static int cpu_capacity_min_write_u64(struct cgroup_subsys_state *css,
+				      struct cftype *cftype, u64 value)
+{
+	struct cgroup_subsys_state *pos;
+	unsigned int min_value;
+	struct task_group *tg;
+	int ret = -EINVAL;
+
+	min_value = min_t(unsigned int, value, SCHED_CAPACITY_SCALE);
+
+	mutex_lock(&cap_clamp_mutex);
+	rcu_read_lock();
+
+	tg = css_tg(css);
+
+	/* Already at the required value */
+	if (tg->cap_clamp[CAP_CLAMP_MIN] == min_value)
+		goto done;
+
+	/* Ensure to not exceed the maximum capacity */
+	if (tg->cap_clamp[CAP_CLAMP_MAX] < min_value)
+		goto out;
+
+	/* Ensure min cap fits within parent constraint */
+	if (tg->parent &&
+	    tg->parent->cap_clamp[CAP_CLAMP_MIN] > min_value)
+		goto out;
+
+	/* Each child must be a subset of us */
+	css_for_each_child(pos, css) {
+		if (css_tg(pos)->cap_clamp[CAP_CLAMP_MIN] < min_value)
+			goto out;
+	}
+
+	tg->cap_clamp[CAP_CLAMP_MIN] = min_value;
+
+done:
+	ret = 0;
+out:
+	rcu_read_unlock();
+	mutex_unlock(&cap_clamp_mutex);
+
+	return ret;
+}
+
+static int cpu_capacity_max_write_u64(struct cgroup_subsys_state *css,
+				      struct cftype *cftype, u64 value)
+{
+	struct cgroup_subsys_state *pos;
+	unsigned int max_value;
+	struct task_group *tg;
+	int ret = -EINVAL;
+
+	max_value = min_t(unsigned int, value, SCHED_CAPACITY_SCALE);
+
+	mutex_lock(&cap_clamp_mutex);
+	rcu_read_lock();
+
+	tg = css_tg(css);
+
+	/* Already at the required value */
+	if (tg->cap_clamp[CAP_CLAMP_MAX] == max_value)
+		goto done;
+
+	/* Ensure to not go below the minimum capacity */
+	if (tg->cap_clamp[CAP_CLAMP_MIN] > max_value)
+		goto out;
+
+	/* Ensure max cap fits within parent constraint */
+	if (tg->parent &&
+	    tg->parent->cap_clamp[CAP_CLAMP_MAX] < max_value)
+		goto out;
+
+	/* Each child must be a subset of us */
+	css_for_each_child(pos, css) {
+		if (css_tg(pos)->cap_clamp[CAP_CLAMP_MAX] > max_value)
+			goto out;
+	}
+
+	tg->cap_clamp[CAP_CLAMP_MAX] = max_value;
+
+done:
+	ret = 0;
+out:
+	rcu_read_unlock();
+	mutex_unlock(&cap_clamp_mutex);
+
+	return ret;
+}
+
+static u64 cpu_capacity_min_read_u64(struct cgroup_subsys_state *css,
+				     struct cftype *cft)
+{
+	struct task_group *tg;
+	u64 min_capacity;
+
+	rcu_read_lock();
+	tg = css_tg(css);
+	min_capacity = tg->cap_clamp[CAP_CLAMP_MIN];
+	rcu_read_unlock();
+
+	return min_capacity;
+}
+
+static u64 cpu_capacity_max_read_u64(struct cgroup_subsys_state *css,
+				     struct cftype *cft)
+{
+	struct task_group *tg;
+	u64 max_capacity;
+
+	rcu_read_lock();
+	tg = css_tg(css);
+	max_capacity = tg->cap_clamp[CAP_CLAMP_MAX];
+	rcu_read_unlock();
+
+	return max_capacity;
+}
+#endif /* CONFIG_CAPACITY_CLAMPING */
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cftype, u64 shareval)
@@ -7193,6 +7326,18 @@ static struct cftype cpu_files[] = {
 		.write_u64 = cpu_shares_write_u64,
 	},
 #endif
+#ifdef CONFIG_CAPACITY_CLAMPING
+	{
+		.name = "capacity_min",
+		.read_u64 = cpu_capacity_min_read_u64,
+		.write_u64 = cpu_capacity_min_write_u64,
+	},
+	{
+		.name = "capacity_max",
+		.read_u64 = cpu_capacity_max_read_u64,
+		.write_u64 = cpu_capacity_max_write_u64,
+	},
+#endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.name = "cfs_quota_us",
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 71b10a9..05dae4a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -273,6 +273,14 @@ struct task_group {
 #endif
 #endif
 
+#ifdef CONFIG_CAPACITY_CLAMPING
+#define CAP_CLAMP_MIN 0
+#define CAP_CLAMP_MAX 1
+
+	/* Min and Max capacity constraints for tasks in this group */
+	unsigned int cap_clamp[2];
+#endif
+
 #ifdef CONFIG_RT_GROUP_SCHED
 	struct sched_rt_entity **rt_se;
 	struct rt_rq **rt_rq;
-- 
2.7.4
