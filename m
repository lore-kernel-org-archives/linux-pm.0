From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC 2/3] sched/fair: use util_est in LB
Date: Fri, 25 Aug 2017 11:20:07 +0100
Message-ID: <20170825102008.4626-3-patrick.bellasi@arm.com>
References: <20170825102008.4626-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170825102008.4626-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

When the scheduler looks at the CPU utlization, the current PELT value
for a CPU is returned straight away. In certain scenarios this can have
undesired side effects on task placement.

For example, since the task utilization is decayed at wakeup time, when
a long sleeping big task is enqueued it does not add immediately a
significant contribution to the target CPU.
As a result we generate a race condition where other tasks can be placed
on the same CPU which is still considered relatively empty.

In order to reduce these kind of race conditions, this patch introduces the
required support to integrate the usage of the CPU's estimated utilization
in some load balancer path.

The estimated utilization of a CPU is defined to be the maximum between
its PELT's utilization and the sum of the estimated utilization of the
tasks currently RUNNABLE on that CPU.
This allows to properly represent the expected utilization of a CPU which,
for example it has just got a big task running since a long sleep
period.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Turner <pjt@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/fair.c     | 38 ++++++++++++++++++++++++++++++++++++--
 kernel/sched/features.h |  4 ++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a4ec1b8c4755..2593da1d1465 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5985,6 +5985,32 @@ static int cpu_util(int cpu)
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
+ * however it preserves the benefits of the "blocked load" in describing the
+ * potential for other tasks waking up on the same CPU.
+ *
+ * Return: the estimated utlization for the specified CPU
+ */
+static inline unsigned long cpu_util_est(int cpu)
+{
+	struct sched_avg *sa = &cpu_rq(cpu)->cfs.avg;
+	unsigned long util = cpu_util(cpu);
+
+	if (!sched_feat(UTIL_EST))
+		return util;
+
+	return max(util, util_est(sa, UTIL_EST_LAST));
+}
+
 static inline int task_util(struct task_struct *p)
 {
 	return p->se.avg.util_avg;
@@ -6007,11 +6033,19 @@ static int cpu_util_wake(int cpu, struct task_struct *p)
 
 	/* Task has no contribution or is new */
 	if (cpu != task_cpu(p) || !p->se.avg.last_update_time)
-		return cpu_util(cpu);
+		return cpu_util_est(cpu);
 
 	capacity = capacity_orig_of(cpu);
 	util = max_t(long, cpu_rq(cpu)->cfs.avg.util_avg - task_util(p), 0);
 
+	/*
+	 * Estimated utilization tracks only tasks already enqueued, but still
+	 * sometimes can return a bigger value than PELT, for example when the
+	 * blocked load is negligible wrt the estimated utilization of the
+	 * already enqueued tasks.
+	 */
+	util = max_t(long, util, cpu_util_est(cpu));
+
 	return (util >= capacity) ? capacity : util;
 }
 
@@ -7539,7 +7573,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			load = source_load(i, load_idx);
 
 		sgs->group_load += load;
-		sgs->group_util += cpu_util(i);
+		sgs->group_util += cpu_util_est(i);
 		sgs->sum_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index d3fb15555291..dadae44be2ab 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -81,3 +81,7 @@ SCHED_FEAT(RT_RUNTIME_SHARE, true)
 SCHED_FEAT(LB_MIN, false)
 SCHED_FEAT(ATTACH_AGE_LOAD, true)
 
+/*
+ * UtilEstimation. Use estimated CPU utiliation.
+ */
+SCHED_FEAT(UTIL_EST, false)
-- 
2.14.1
