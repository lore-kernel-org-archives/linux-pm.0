From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC 1/3] sched/fair: add util_est on top of PELT
Date: Fri, 25 Aug 2017 11:20:06 +0100
Message-ID: <20170825102008.4626-2-patrick.bellasi@arm.com>
References: <20170825102008.4626-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170825102008.4626-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The util_avg signal computed by PELT is too variable for some use-cases.
For example, a big task waking up after a long sleep period will have its
utilization almost completely decayed. This introduces some latency before
schedutil will be able to pick the best frequency to run a task.

The same issue can affect task placement. Indeed, since the task
utilization is already decayed at wakeup, when the task is enqueued in a
CPU, this can results in a CPU running a big task as being temporarily
represented as being almost empty. This leads to a race condition where
other tasks can be potentially allocated on a CPU which just started to run
a big task which slept for a relatively long period.

Moreover, the utilization of a task is, by PELT definition, a continuously
changing metrics. This contributes in making almost instantly outdated some
decisions based on the value of the PELT's utilization.

For all these reasons, a more stable signal could probably do a better job
of representing the expected/estimated utilization of a SE/RQ. Such a
signal can be easily created on top of PELT by still using it as an
estimator which produces values to be aggregated once meaningful events
happens.

This patch adds a simple implementation of util_est, a new signal built on
top of PELT's util_avg where:

    util_est(se) = max(se::util_avg, f(se::util_avg@dequeue_times))

This allows to remember how big a task has been reported to be by PELT in
its previous activations via the function: f(se::util_avg@dequeue_times).

If a task should change it's behavior and it runs even longer in a new
activation, after a certain time util_est will just track the original PELT
signal (i.e. se::util_avg).

For a (top-level) RQ, the estimated utilization is simply defined as:

    util_est(rq) = max(rq::util_est, rq::util_avg)

where:

    rq::util_est = sum(se::util_est), for each RUNNABLE SE on that CPU

It's worth to note that the estimated utilization is tracked only for
entities of interests, specifically:
 - SE which are Tasks
   since we want to better support tasks placement decisions
 - top-level CPU's RQs
   since we want to better support frequencies selection for a CPU

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
 include/linux/sched.h | 48 ++++++++++++++++++++++++++++++++++++
 kernel/sched/debug.c  |  8 ++++++
 kernel/sched/fair.c   | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c28b182c9833..8d7bc55f68d5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -26,6 +26,7 @@
 #include <linux/signal_types.h>
 #include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
+#include <linux/average.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -277,6 +278,16 @@ struct load_weight {
 	u32				inv_weight;
 };
 
+/**
+ * Utilizaton's Exponential Weighted Moving Average (EWMA)
+ *
+ * Support functions to track an EWMA for the utilization of SEs and RQs. New
+ * samples will be added to the moving average each time a task completes an
+ * activation. Thus the weight is chosen so that the EWMA wil be relatively
+ * insensitive to transient changes to the task's workload.
+ */
+DECLARE_EWMA(util, 0, 4);
+
 /*
  * The load_avg/util_avg accumulates an infinite geometric series
  * (see __update_load_avg() in kernel/sched/fair.c).
@@ -336,8 +347,45 @@ struct sched_avg {
 	u32				period_contrib;
 	unsigned long			load_avg;
 	unsigned long			util_avg;
+
+	/* Utilization estimation */
+	struct ewma_util		util_ewma;
+	struct util_est {
+		unsigned long ewma;
+		unsigned long last;
+	} util_est;
 };
 
+/* Utilization estimation policies */
+#define UTIL_EST_MAX_EWMA_LAST	0 /* max(sa->util_est.ema, sa->util_est.last) */
+#define UTIL_EST_EWMA		1 /* sa->util_est.ewma */
+#define UTIL_EST_LAST		2 /* sa->util_est.last */
+
+/* Default policy used by utilization estimation */
+#define UTIL_EST_POLICY	UTIL_EST_MAX_EWMA_LAST
+
+/**
+ * util_est: estimated utilization for a given entity (i.e. SE or RQ)
+ *
+ * Depending on the selected utlization estimation policy, the estimated
+ * utilization of a SE or RQ is returned by this function.
+ * Supported policies are:
+ * UTIL_EST_LAST: the value of the PELT signal the last time a SE has
+ *                completed an activation, i.e. it has been dequeued because
+ *                of a sleep
+ * UTIL_EST_EWMA: the exponential weighted moving average of all the past
+ *                UTIL_EST_LAST samples
+ * UTIL_EST_MAX_EWMA_LAST: the maximum among the previous two metrics
+ */
+static inline unsigned long util_est(struct sched_avg *sa, int policy)
+{
+	if (likely(policy == UTIL_EST_MAX_EWMA_LAST))
+		return max(sa->util_est.ewma, sa->util_est.last);
+	if (policy == UTIL_EST_EWMA)
+		return sa->util_est.ewma;
+	return sa->util_est.last;
+}
+
 struct sched_statistics {
 #ifdef CONFIG_SCHEDSTATS
 	u64				wait_start;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index cfd84f79e075..17e293adb7f0 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -399,6 +399,8 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 #ifdef CONFIG_SMP
 	P(se->avg.load_avg);
 	P(se->avg.util_avg);
+	P(se->avg.util_est.ewma);
+	P(se->avg.util_est.last);
 #endif
 
 #undef PN_SCHEDSTAT
@@ -521,6 +523,10 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->runnable_load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
 			cfs_rq->avg.util_avg);
+	SEQ_printf(m, "  .%-30s: %lu\n", "util_est.ewma",
+			cfs_rq->avg.util_est.ewma);
+	SEQ_printf(m, "  .%-30s: %lu\n", "util_est.last",
+			cfs_rq->avg.util_est.last);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed_load_avg",
 			atomic_long_read(&cfs_rq->removed_load_avg));
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed_util_avg",
@@ -966,6 +972,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.util_sum);
 	P(se.avg.load_avg);
 	P(se.avg.util_avg);
+	P(se.avg.util_est.ewma);
+	P(se.avg.util_est.last);
 	P(se.avg.last_update_time);
 #endif
 	P(policy);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8d5868771cb3..a4ec1b8c4755 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -751,6 +751,10 @@ void init_entity_runnable_average(struct sched_entity *se)
 	sa->util_avg = 0;
 	sa->util_sum = 0;
 	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
+
+	ewma_util_init(&sa->util_ewma);
+	sa->util_est.ewma = 0;
+	sa->util_est.last = 0;
 }
 
 static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq);
@@ -4880,6 +4884,21 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
+static inline int task_util(struct task_struct *p);
+static inline int task_util_est(struct task_struct *p);
+
+static inline void util_est_enqueue(struct task_struct *p)
+{
+	struct cfs_rq *cfs_rq = &task_rq(p)->cfs;
+
+	/*
+	 * Update (top level CFS) RQ estimated utilization.
+	 * NOTE: here we assumes that we never change the
+	 *       utilization estimation policy at run-time.
+	 */
+	cfs_rq->avg.util_est.last += task_util_est(p);
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -4932,9 +4951,49 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!se)
 		add_nr_running(rq, 1);
 
+	util_est_enqueue(p);
 	hrtick_update(rq);
 }
 
+static inline void util_est_dequeue(struct task_struct *p, int flags)
+{
+	struct cfs_rq *cfs_rq = &task_rq(p)->cfs;
+	int task_sleep = flags & DEQUEUE_SLEEP;
+	long util_est;
+
+	/*
+	 * Update (top level CFS) RQ estimated utilization
+	 *
+	 * When *p is the last FAIR task then the RQ's estimated utilization
+	 * is 0 by its definition.
+	 *
+	 * Otherwise, in removing *p's util_est from the current RQ's util_est
+	 * we should account for cases where this last activation of *p was
+	 * longher then the previous ones. In these cases as well we set to 0
+	 * the new estimated utilization for the CPU.
+	 */
+	util_est = (cfs_rq->nr_running > 1)
+		? cfs_rq->avg.util_est.last - task_util_est(p)
+		: 0;
+	if (util_est < 0)
+		util_est = 0;
+	cfs_rq->avg.util_est.last = util_est;
+
+	/*
+	 * Update Task's estimated utilization
+	 *
+	 * When *p completes an activation we can consolidate another sample
+	 * about the task size. This is done by storing the last PELT value
+	 * for this task and using this value to load another sample in the
+	 * EMWA for the task.
+	 */
+	if (task_sleep) {
+		p->se.avg.util_est.last = task_util(p);
+		ewma_util_add(&p->se.avg.util_ewma, task_util(p));
+		p->se.avg.util_est.ewma = ewma_util_read(&p->se.avg.util_ewma);
+	}
+}
+
 static void set_next_buddy(struct sched_entity *se);
 
 /*
@@ -4991,6 +5050,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!se)
 		sub_nr_running(rq, 1);
 
+	util_est_dequeue(p, flags);
 	hrtick_update(rq);
 }
 
@@ -5486,7 +5546,6 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	return affine;
 }
 
-static inline int task_util(struct task_struct *p);
 static int cpu_util_wake(int cpu, struct task_struct *p);
 
 static unsigned long capacity_spare_wake(int cpu, struct task_struct *p)
@@ -5931,6 +5990,13 @@ static inline int task_util(struct task_struct *p)
 	return p->se.avg.util_avg;
 }
 
+static inline int task_util_est(struct task_struct *p)
+{
+	struct sched_avg *sa = &p->se.avg;
+
+	return util_est(sa, UTIL_EST_POLICY);
+}
+
 /*
  * cpu_util_wake: Compute cpu utilization with any contributions from
  * the waking task p removed.
-- 
2.14.1
