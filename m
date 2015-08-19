From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC PATCH 12/14] sched/tune: add initial support for CGroups based boosting
Date: Wed, 19 Aug 2015 19:47:22 +0100
Message-ID: <1440010044-3402-13-git-send-email-patrick.bellasi@arm.com>
References: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
List-Id: linux-pm@vger.kernel.org

To support task performance boosting, the usage of a single knob has the
advantage to be a simple solution, both from the implementation and the
usability standpoint.  However, on a real system it can be difficult to
identify a single value for the knob which fits the needs of multiple
different tasks. For example, some kernel threads and/or user-space
background services should be better managed the "standard" way while we
still want to be able to boost the performance of specific workloads.

In order to improve the flexibility of the task boosting mechanism this
patch is the first of a small series which extends the previous
implementation to introduce a "per task group" support.
This first patch introduces just the basic CGroups support, a new
"schedtune" CGroups controller is added which allows to configure
different boost value for different groups of tasks.
To keep the implementation simple but still effective for a boosting
strategy, the new controller:
  1. allows only a two layer hierarchy
  2. supports only a limited number of boost groups

A two layer hierarchy allows to place each task either:
  a) in the root control group
     thus being subject to a system-wide boosting value
  b) in a child of the root group
     thus being subject to the specific boost value defined by that
     "boost group"

The limited number of "boost groups" supported is mainly motivated by
the observation that in a real system it could be useful to have only
few classes of tasks which deserve different treatment.
For example, background vs foreground or interactive vs low-priority.
As an additional benefit, a limited number of boost groups allows also
to have a simpler implementation especially for the code required to
compute the boost value for CPUs which have runnable tasks belonging to
different boost groups.

cc: Tejun Heo <tj@kernel.org>
cc: Li Zefan <lizefan@huawei.com>
cc: Johannes Weiner <hannes@cmpxchg.org>
cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
---
 include/linux/cgroup_subsys.h |   4 +
 init/Kconfig                  |  17 ++++
 kernel/sched/tune.c           | 200 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c               |   4 +
 4 files changed, 225 insertions(+)

diff --git a/include/linux/cgroup_subsys.h b/include/linux/cgroup_subsys.h
index e4a96fb..23befa0 100644
--- a/include/linux/cgroup_subsys.h
+++ b/include/linux/cgroup_subsys.h
@@ -15,6 +15,10 @@ SUBSYS(cpu)
 SUBSYS(cpuacct)
 #endif
 
+#if IS_ENABLED(CONFIG_CGROUP_SCHEDTUNE)
+SUBSYS(schedtune)
+#endif
+
 #if IS_ENABLED(CONFIG_BLK_CGROUP)
 SUBSYS(blkio)
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index 7fa3419..4555e97 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -982,6 +982,23 @@ config CGROUP_CPUACCT
 	  Provides a simple Resource Controller for monitoring the
 	  total CPU consumed by the tasks in a cgroup.
 
+config CGROUP_SCHEDTUNE
+	bool "CFS tasks boosting cgroup subsystem (EXPERIMENTAL)"
+	depends on SCHED_TUNE
+	help
+	  This option provides the "schedtune" controller which improves the
+	  flexibility of the task boosting mechanism by introducing the support
+	  to define "per task" boost values.
+
+	  This new controller:
+	  1. allows only a two layers hierarchy, where the root defines the
+	     system-wide boost value and its direct childrens define each one a
+	     different "class of tasks" to be boosted with a different value
+	  2. supports up to 16 different task classes, each one which could be
+	     configured with a different boost value
+
+	  Say N if unsure.
+
 config PAGE_COUNTER
        bool
 
diff --git a/kernel/sched/tune.c b/kernel/sched/tune.c
index 4c44b1a..a26295c 100644
--- a/kernel/sched/tune.c
+++ b/kernel/sched/tune.c
@@ -1,7 +1,207 @@
+#include <linux/cgroup.h>
+#include <linux/err.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+
 #include "sched.h"
 
 unsigned int sysctl_sched_cfs_boost __read_mostly;
 
+#ifdef CONFIG_CGROUP_SCHEDTUNE
+
+/*
+ * EAS scheduler tunables for task groups.
+ */
+
+/* SchdTune tunables for a group of tasks */
+struct schedtune {
+	/* SchedTune CGroup subsystem */
+	struct cgroup_subsys_state css;
+
+	/* Boost group allocated ID */
+	int idx;
+
+	/* Boost value for tasks on that SchedTune CGroup */
+	int boost;
+
+};
+
+static inline struct schedtune *css_st(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct schedtune, css) : NULL;
+}
+
+static inline struct schedtune *task_schedtune(struct task_struct *tsk)
+{
+	return css_st(task_css(tsk, schedtune_cgrp_id));
+}
+
+static inline struct schedtune *parent_st(struct schedtune *st)
+{
+	return css_st(st->css.parent);
+}
+
+/*
+ * SchedTune root control group
+ * The root control group is used to defined a system-wide boosting tuning,
+ * which is applied to all tasks in the system.
+ * Task specific boost tuning could be specified by creating and
+ * configuring a child control group under the root one.
+ * By default, system-wide boosting is disabled, i.e. no boosting is applied
+ * to tasks which are not into a child control group.
+ */
+static struct schedtune
+root_schedtune = {
+	.boost	= 0,
+};
+
+/*
+ * Maximum number of boost groups to support
+ * When per-task boosting is used we still allow only limited number of
+ * boost groups for two main reasons:
+ * 1. on a real system we usually have only few classes of workloads which
+ *    make sense to boost with different values (e.g. background vs foreground
+ *    tasks, interactive vs low-priority tasks)
+ * 2. a limited number allows for a simpler and more memory/time efficient
+ *    implementation especially for the computation of the per-CPU boost
+ *    value
+ */
+#define BOOSTGROUPS_COUNT 16
+
+/* Array of configured boostgroups */
+static struct schedtune *allocated_group[BOOSTGROUPS_COUNT] = {
+	&root_schedtune,
+	NULL,
+};
+
+static u64
+boost_read(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct schedtune *st = css_st(css);
+
+	return st->boost;
+}
+
+static int
+boost_write(struct cgroup_subsys_state *css, struct cftype *cft,
+	    u64 boost)
+{
+	struct schedtune *st = css_st(css);
+
+	if (boost < 0 || boost > 100)
+		return -EINVAL;
+
+	st->boost = boost;
+	if (css == &root_schedtune.css)
+		sysctl_sched_cfs_boost = boost;
+
+	return 0;
+}
+
+static struct cftype files[] = {
+	{
+		.name = "boost",
+		.read_u64 = boost_read,
+		.write_u64 = boost_write,
+	},
+	{ }	/* terminate */
+};
+
+static int
+schedtune_boostgroup_init(struct schedtune *st)
+{
+	/* Keep track of allocated boost groups */
+	allocated_group[st->idx] = st;
+
+	return 0;
+}
+
+static int
+schedtune_init(void)
+{
+	struct boost_groups *bg;
+	int cpu;
+
+	/* Initialize the per CPU boost groups */
+	for_each_possible_cpu(cpu) {
+		bg = &per_cpu(cpu_boost_groups, cpu);
+		memset(bg, 0, sizeof(struct boost_groups));
+	}
+
+	pr_info("  schedtune configured to support %d boost groups\n",
+		BOOSTGROUPS_COUNT);
+	return 0;
+}
+
+static struct cgroup_subsys_state *
+schedtune_css_alloc(struct cgroup_subsys_state *parent_css)
+{
+	struct schedtune *st;
+	int idx;
+
+	if (!parent_css) {
+		schedtune_init();
+		return &root_schedtune.css;
+	}
+
+	/* Allow only single level hierachies */
+	if (parent_css != &root_schedtune.css) {
+		pr_err("Nested SchedTune boosting groups not allowed\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Allow only a limited number of boosting groups */
+	for (idx = 1; idx < BOOSTGROUPS_COUNT; ++idx)
+		if (!allocated_group[idx])
+			break;
+	if (idx == BOOSTGROUPS_COUNT) {
+		pr_err("Trying to create more than %d SchedTune boosting groups\n",
+		       BOOSTGROUPS_COUNT);
+		return ERR_PTR(-ENOSPC);
+	}
+
+	st = kzalloc(sizeof(*st), GFP_KERNEL);
+	if (!st)
+		goto out;
+
+	/* Initialize per CPUs boost group support */
+	st->idx = idx;
+	if (schedtune_boostgroup_init(st))
+		goto release;
+
+	return &st->css;
+
+release:
+	kfree(st);
+out:
+	return ERR_PTR(-ENOMEM);
+}
+
+static void
+schedtune_boostgroup_release(struct schedtune *st)
+{
+	/* Keep track of allocated boost groups */
+	allocated_group[st->idx] = NULL;
+}
+
+static void
+schedtune_css_free(struct cgroup_subsys_state *css)
+{
+	struct schedtune *st = css_st(css);
+
+	schedtune_boostgroup_release(st);
+	kfree(st);
+}
+
+struct cgroup_subsys schedtune_cgrp_subsys = {
+	.css_alloc	= schedtune_css_alloc,
+	.css_free	= schedtune_css_free,
+	.legacy_cftypes	= files,
+	.early_init	= 1,
+};
+
+#endif /* CONFIG_CGROUP_SCHEDTUNE */
+
 int
 sysctl_sched_cfs_boost_handler(struct ctl_table *table, int write,
 			       void __user *buffer, size_t *lenp,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2b4673e..d42162c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -438,7 +438,11 @@ static struct ctl_table kern_table[] = {
 		.procname	= "sched_cfs_boost",
 		.data		= &sysctl_sched_cfs_boost,
 		.maxlen		= sizeof(sysctl_sched_cfs_boost),
+#ifdef CONFIG_CGROUP_SCHEDTUNE
+		.mode		= 0444,
+#else
 		.mode		= 0644,
+#endif
 		.proc_handler	= &sysctl_sched_cfs_boost_handler,
 		.extra1		= &zero,
 		.extra2		= &one_hundred,
-- 
2.5.0
