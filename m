From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC PATCH 13/14] sched/tune: compute and keep track of per CPU boost value
Date: Wed, 19 Aug 2015 19:47:23 +0100
Message-ID: <1440010044-3402-14-git-send-email-patrick.bellasi@arm.com>
References: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53382 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448AbbHSSr7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 19 Aug 2015 14:47:59 -0400
In-Reply-To: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

When per task boosting is enabled, we could have multiple RUNNABLE tasks
which are concurrently scheduled on the same CPU but each one with a
different boost value.
For example, we could have a scenarios like this:

  Task   SchedTune CGroup   Boost Value
    T1               root            0
    T2       low-priority           10
    T3        interactive           90

In these conditions we expect a CPU to be configured according to a
proper "aggregation" of the required boost values for all the tasks
currently scheduled on this CPU.

A suitable aggregation function is the one which tracks the MAX boost
value for all the tasks RUNNABLE on a CPU. This approach allows to
always satisfy the most boost demanding task while at the same time:
 a) boosting all the concurrently scheduled tasks thus reducing
    potential co-scheduling side-effects on demanding tasks
 b) reduce the number of frequency switch requested towards SchedDVFS,
    thus being more friendly to architectures with slow frequency
    switching times

Every time a task enters/exits the RQ of a CPU the max boost value
should be updated considering all the boost groups currently "affecting"
that CPU, i.e. which have at least one RUNNABLE task currently allocated
on that CPU.

This patch introduces the required support to keep track of the boost
groups currently affecting CPUs. Thanks to the limited number of boost
groups, a small and memory efficient per-cpu array of boost groups
values (cpu_boost_groups) is used which is updated for each CPU entry by
schedtune_boostgroup_update() but only when a schedtune CGroup boost
value is updated. However, this is expected to be a rare operation,
perhaps done just one time at system boot time.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
---
 kernel/sched/tune.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/kernel/sched/tune.c b/kernel/sched/tune.c
index a26295c..3223ef3 100644
--- a/kernel/sched/tune.c
+++ b/kernel/sched/tune.c
@@ -1,5 +1,6 @@
 #include <linux/cgroup.h>
 #include <linux/err.h>
+#include <linux/percpu.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 
@@ -74,6 +75,89 @@ static struct schedtune *allocated_group[BOOSTGROUPS_COUNT] = {
 	NULL,
 };
 
+/* SchedTune boost groups
+ * Keep track of all the boost groups which impact on CPU, for example when a
+ * CPU has two RUNNABLE tasks belonging to two different boost groups and thus
+ * likely with different boost values.
+ * Since on each system we expect only a limited number of boost groups, here
+ * we use a simple array to keep track of the metrics required to compute the
+ * maximum per-CPU boosting value.
+ */
+struct boost_groups {
+	/* Maximum boost value for all RUNNABLE tasks on a CPU */
+	unsigned boost_max;
+	struct {
+		/* The boost for tasks on that boost group */
+		unsigned boost;
+		/* Count of RUNNABLE tasks on that boost group */
+		unsigned tasks;
+	} group[BOOSTGROUPS_COUNT];
+};
+
+/* Boost groups affecting each CPU in the system */
+DEFINE_PER_CPU(struct boost_groups, cpu_boost_groups);
+
+static void
+schedtune_cpu_update(int cpu)
+{
+	struct boost_groups *bg;
+	unsigned boost_max;
+	int idx;
+
+	bg = &per_cpu(cpu_boost_groups, cpu);
+
+	/* The root boost group is always active */
+	boost_max = bg->group[0].boost;
+	for (idx = 1; idx < BOOSTGROUPS_COUNT; ++idx) {
+		/*
+		 * A boost group affects a CPU only if it has
+		 * RUNNABLE tasks on that CPU
+		 */
+		if (bg->group[idx].tasks == 0)
+			continue;
+		boost_max = max(boost_max, bg->group[idx].boost);
+	}
+
+	bg->boost_max = boost_max;
+}
+
+static int
+schedtune_boostgroup_update(int idx, int boost)
+{
+	struct boost_groups *bg;
+	int cur_boost_max;
+	int old_boost;
+	int cpu;
+
+	/* Update per CPU boost groups */
+	for_each_possible_cpu(cpu) {
+		bg = &per_cpu(cpu_boost_groups, cpu);
+
+		/*
+		 * Keep track of current boost values to compute the per CPU
+		 * maximum only when it has been affected by the new value of
+		 * the updated boost group
+		 */
+		cur_boost_max = bg->boost_max;
+		old_boost = bg->group[idx].boost;
+
+		/* Update the boost value of this boost group */
+		bg->group[idx].boost = boost;
+
+		/* Check if this update increase current max */
+		if (boost > cur_boost_max && bg->group[idx].tasks) {
+			bg->boost_max = boost;
+			continue;
+		}
+
+		/* Check if this update has decreased current max */
+		if (cur_boost_max == old_boost && old_boost > boost)
+			schedtune_cpu_update(cpu);
+	}
+
+	return 0;
+}
+
 static u64
 boost_read(struct cgroup_subsys_state *css, struct cftype *cft)
 {
@@ -95,6 +179,9 @@ boost_write(struct cgroup_subsys_state *css, struct cftype *cft,
 	if (css == &root_schedtune.css)
 		sysctl_sched_cfs_boost = boost;
 
+	/* Update CPU boost */
+	schedtune_boostgroup_update(st->idx, st->boost);
+
 	return 0;
 }
 
@@ -110,9 +197,19 @@ static struct cftype files[] = {
 static int
 schedtune_boostgroup_init(struct schedtune *st)
 {
+	struct boost_groups *bg;
+	int cpu;
+
 	/* Keep track of allocated boost groups */
 	allocated_group[st->idx] = st;
 
+	/* Initialize the per CPU boost groups */
+	for_each_possible_cpu(cpu) {
+		bg = &per_cpu(cpu_boost_groups, cpu);
+		bg->group[st->idx].boost = 0;
+		bg->group[st->idx].tasks = 0;
+	}
+
 	return 0;
 }
 
@@ -180,6 +277,9 @@ out:
 static void
 schedtune_boostgroup_release(struct schedtune *st)
 {
+	/* Reset this boost group */
+	schedtune_boostgroup_update(st->idx, 0);
+
 	/* Keep track of allocated boost groups */
 	allocated_group[st->idx] = NULL;
 }
-- 
2.5.0

