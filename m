From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v3 2/3] sched/fair: use util_est in LB and WU paths
Date: Tue, 23 Jan 2018 18:08:46 +0000
Message-ID: <20180123180847.4477-3-patrick.bellasi@arm.com>
References: <20180123180847.4477-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123180847.4477-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

When the scheduler looks at the CPU utilization, the current PELT value
for a CPU is returned straight away. In certain scenarios this can have
undesired side effects on task placement.

For example, since the task utilization is decayed at wakeup time, when
a long sleeping big task is enqueued it does not add immediately a
significant contribution to the target CPU.
As a result we generate a race condition where other tasks can be placed
on the same CPU while it is still considered relatively empty.

In order to reduce this kind of race conditions, this patch introduces the
required support to integrate the usage of the CPU's estimated utilization
in cpu_util_wake as well as in update_sg_lb_stats.

The estimated utilization of a CPU is defined to be the maximum between
its PELT's utilization and the sum of the estimated utilization of the
tasks currently RUNNABLE on that CPU.
This allows to properly represent the spare capacity of a CPU which, for
example, has just got a big task running since a long sleep period.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Paul Turner <pjt@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v3:
 - rebased on today's tip/sched/core (commit 07881166a892)

Changes in v2:
 - rebase on top of v4.15-rc2
 - tested that overhauled PELT code does not affect the util_est
---
 kernel/sched/fair.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0bfe94f3176e..6f2e614fd79f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6332,6 +6332,41 @@ static unsigned long cpu_util(int cpu)
 	return (util >= capacity) ? capacity : util;
 }
 
+/**
+ * cpu_util_est: estimated utilization for the specified CPU
+ * @cpu: the CPU to get the estimated utilization for
+ *
+ * The estimated utilization of a CPU is defined to be the maximum between its
+ * PELT's utilization and the sum of the estimated utilization of the tasks
+ * currently RUNNABLE on that CPU.
+ *
+ * This allows to properly represent the expected utilization of a CPU which
+ * has just got a big task running since a long sleep period. At the same time
+ * however it preserves the benefits of the "blocked utilization" in
+ * describing the potential for other tasks waking up on the same CPU.
+ *
+ * Return: the estimated utilization for the specified CPU
+ */
+static inline unsigned long cpu_util_est(int cpu)
+{
+	unsigned long util, util_est;
+	unsigned long capacity;
+	struct cfs_rq *cfs_rq;
+
+	if (!sched_feat(UTIL_EST))
+		return cpu_util(cpu);
+
+	cfs_rq = &cpu_rq(cpu)->cfs;
+	util = cfs_rq->avg.util_avg;
+	util_est = cfs_rq->util_est_runnable;
+	util_est = max(util, util_est);
+
+	capacity = capacity_orig_of(cpu);
+	util_est = min(util_est, capacity);
+
+	return util_est;
+}
+
 static inline unsigned long task_util(struct task_struct *p)
 {
 	return p->se.avg.util_avg;
@@ -6348,16 +6383,43 @@ static inline unsigned long task_util_est(struct task_struct *p)
  */
 static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
 {
-	unsigned long util, capacity;
+	long util, util_est;
 
 	/* Task has no contribution or is new */
 	if (cpu != task_cpu(p) || !p->se.avg.last_update_time)
-		return cpu_util(cpu);
+		return cpu_util_est(cpu);
 
-	capacity = capacity_orig_of(cpu);
-	util = max_t(long, cpu_rq(cpu)->cfs.avg.util_avg - task_util(p), 0);
+	/* Discount task's blocked util from CPU's util */
+	util = cpu_util(cpu) - task_util(p);
+	util = max(util, 0L);
 
-	return (util >= capacity) ? capacity : util;
+	if (!sched_feat(UTIL_EST))
+		return util;
+
+	/*
+	 * These are the main cases covered:
+	 * - if *p is the only task sleeping on this CPU, then:
+	 *      cpu_util (== task_util) > util_est (== 0)
+	 *   and thus we return:
+	 *      cpu_util_wake = (cpu_util - task_util) = 0
+	 *
+	 * - if other tasks are SLEEPING on the same CPU, which is just waking
+	 *   up, then:
+	 *      cpu_util >= task_util
+	 *      cpu_util > util_est (== 0)
+	 *   and thus we discount *p's blocked utilization to return:
+	 *      cpu_util_wake = (cpu_util - task_util) >= 0
+	 *
+	 * - if other tasks are RUNNABLE on that CPU and
+	 *      util_est > cpu_util
+	 *   then we use util_est since it returns a more restrictive
+	 *   estimation of the spare capacity on that CPU, by just considering
+	 *   the expected utilization of tasks already runnable on that CPU.
+	 */
+	util_est = cpu_rq(cpu)->cfs.util_est_runnable;
+	util = max(util, util_est);
+
+	return util;
 }
 
 /*
@@ -7882,7 +7944,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			load = source_load(i, load_idx);
 
 		sgs->group_load += load;
-		sgs->group_util += cpu_util(i);
+		sgs->group_util += cpu_util_est(i);
 		sgs->sum_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
-- 
2.15.1
