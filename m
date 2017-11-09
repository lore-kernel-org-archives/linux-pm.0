From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH 2/4] sched/fair: add util_est on top of PELT
Date: Thu,  9 Nov 2017 16:41:15 +0000
Message-ID: <20171109164117.19401-3-patrick.bellasi@arm.com>
References: <20171109164117.19401-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171109164117.19401-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, linux-pm@vger.kernel.org
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

Moreover, the PELT utilization of a task can be updated every [ms], thus
making it a continuously changing value for certain longer running
tasks.  This means that the instantaneous PELT utilization of a RUNNING
task is not really meaningful to properly support scheduler decisions.

For all these reasons, a more stable signal could probably do a better
job of representing the expected/estimated utilization of a task/cfs_rq.
Such a signal can be easily created on top of PELT by still using it as
an estimator which produces values to be aggregated on meaningful
events.

This patch adds a simple implementation of util_est, a new signal built on
top of PELT's util_avg where:

    util_est(task) = max(task::util_avg, f(task::util_avg@dequeue_times))

This allows to remember how big a task has been reported by PELT in its
previous activations via the function: f(task::util_avg@dequeue_times).

If a task should change its behavior and it runs even longer in a new
activation, after a certain time its util_est will just track the
original PELT signal (i.e. task::util_avg).

The estimated utilization of cfs_rq is defined only for root ones.
That's because the only sensible consumer of this signal are the
scheduler and schedutil when looking for the overall CPU utilization due
to FAIR tasks.
For this reason, the estimated utilization or a root cfs_rq is simply
defined as:

    util_est(cfs_rq) = max(cfs_rq::util_avg, cfs_rq::util_est_runnable)

where:

    cfs_rq::util_est_runnable = sum(util_est(task))
                                for each RUNNABLE task on that root cfs_rq

It's worth to note that the estimated utilization is tracked only for
entities of interests, specifically:
 - Tasks: to better support tasks placement decisions
 - root cfs_rqs: to better both tasks placement decisions as well as
                 to better support frequencies selection for a CPU

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Reviewed-by: Brendan Jackman <brendan.jackman@arm.com>
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
 include/linux/sched.h   |  21 ++++++++++
 kernel/sched/debug.c    |   4 ++
 kernel/sched/fair.c     | 102 +++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/features.h |   5 +++
 kernel/sched/sched.h    |   1 +
 5 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index fdf74f27acf1..bce77204c378 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -338,6 +338,21 @@ struct sched_avg {
 	unsigned long			util_avg;
 };
 
+/**
+ * Estimation Utilization for FAIR tasks.
+ *
+ * Support data structure to track an Exponential Weighted Moving Average
+ * (EWMA) of a FAIR task's utilization. New samples are added to the moving
+ * average each time a task completes an activation. Sample's weight is
+ * chosen so that the EWMA will be relatively insensitive to transient changes
+ * to the task's workload.
+ */
+struct util_est {
+	unsigned long			last;
+	unsigned long			ewma;
+#define UTIL_EST_WEIGHT_SHIFT		2
+};
+
 struct sched_statistics {
 #ifdef CONFIG_SCHEDSTATS
 	u64				wait_start;
@@ -561,6 +576,12 @@ struct task_struct {
 
 	const struct sched_class	*sched_class;
 	struct sched_entity		se;
+	/*
+	 * Since we use se.avg.util_avg to update util_est fields,
+	 * this last can benefit from being close to se which
+	 * also defines se.avg as cache aligned.
+	 */
+	struct util_est			util_est;
 	struct sched_rt_entity		rt;
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 2f93e4a2d9f6..a4af385329b2 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -564,6 +564,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->runnable_load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
 			cfs_rq->avg.util_avg);
+	SEQ_printf(m, "  .%-30s: %lu\n", "util_est_runnable",
+			cfs_rq->util_est_runnable);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed_load_avg",
 			atomic_long_read(&cfs_rq->removed_load_avg));
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed_util_avg",
@@ -1010,6 +1012,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.load_avg);
 	P(se.avg.util_avg);
 	P(se.avg.last_update_time);
+	P(util_est.ewma);
+	P(util_est.last);
 #endif
 	P(policy);
 	P(prio);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 83bc5d69fe3a..f14d199e81ed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -739,6 +739,12 @@ void init_entity_runnable_average(struct sched_entity *se)
 	sa->util_avg = 0;
 	sa->util_sum = 0;
 	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
+
+	/* Utilization estimation */
+	if (entity_is_task(se)) {
+		task_of(se)->util_est.ewma = 0;
+		task_of(se)->util_est.last = 0;
+	}
 }
 
 static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq);
@@ -4870,6 +4876,20 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
+static inline unsigned long task_util(struct task_struct *p);
+static inline unsigned long task_util_est(struct task_struct *p);
+
+static inline void util_est_enqueue(struct task_struct *p)
+{
+	struct cfs_rq *cfs_rq = &task_rq(p)->cfs;
+
+	if (!sched_feat(UTIL_EST))
+		return;
+
+	/* Update root cfs_rq's estimated utilization */
+	cfs_rq->util_est_runnable += task_util_est(p);
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -4922,9 +4942,84 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!se)
 		add_nr_running(rq, 1);
 
+	util_est_enqueue(p);
 	hrtick_update(rq);
 }
 
+static inline void util_est_dequeue(struct task_struct *p, int flags)
+{
+	struct cfs_rq *cfs_rq = &task_rq(p)->cfs;
+	unsigned long util_last = task_util(p);
+	bool sleep = flags & DEQUEUE_SLEEP;
+	unsigned long ewma;
+	long util_est;
+
+	if (!sched_feat(UTIL_EST))
+		return;
+
+	/*
+	 * Update root cfs_rq's estimated utilization
+	 *
+	 * If *p is the last task then the root cfs_rq's estimated utilization
+	 * of a CPU is 0 by definition.
+	 *
+	 * Otherwise, in removing *p's util_est from its cfs_rq's
+	 * util_est_runnable we should account for cases where this last
+	 * activation of *p was longer then the previous ones.
+	 * Also in these cases we need to set 0 the estimated utilization for
+	 * the CPU.
+	 */
+	if (cfs_rq->nr_running > 0) {
+		util_est  = cfs_rq->util_est_runnable;
+		util_est -= task_util_est(p);
+		if (util_est < 0)
+			util_est = 0;
+		cfs_rq->util_est_runnable = util_est;
+	} else {
+		cfs_rq->util_est_runnable = 0;
+	}
+
+	/*
+	 * Skip update of task's estimated utilization when the task has not
+	 * yet completed an activation, e.g. being migrated.
+	 */
+	if (!sleep)
+		return;
+
+	/*
+	 * Skip update of task's estimated utilization when its EWMA is already
+	 * ~1% close to its last activation value.
+	 */
+	util_est = p->util_est.ewma;
+	if (abs(util_est - util_last) <= (SCHED_CAPACITY_SCALE / 100))
+		return;
+
+	/*
+	 * Update Task's estimated utilization
+	 *
+	 * When *p completes an activation we can consolidate another sample
+	 * about the task size. This is done by storing the last PELT value
+	 * for this task and using this value to load another sample in the
+	 * exponential weighted moving average:
+	 *
+	 *      ewma(t) = w *  task_util(p) + (1 - w) ewma(t-1)
+	 *              = w *  task_util(p) + ewma(t-1) - w * ewma(t-1)
+	 *              = w * (task_util(p) + ewma(t-1) / w - ewma(t-1))
+	 *
+	 * Where 'w' is the weight of new samples, which is configured to be
+	 * 0.25, thus making w=1/4
+	 */
+	p->util_est.last = util_last;
+	ewma = p->util_est.ewma;
+	if (likely(ewma != 0)) {
+		ewma   = util_last + (ewma << UTIL_EST_WEIGHT_SHIFT) - ewma;
+		ewma >>= UTIL_EST_WEIGHT_SHIFT;
+	} else {
+		ewma = util_last;
+	}
+	p->util_est.ewma = ewma;
+}
+
 static void set_next_buddy(struct sched_entity *se);
 
 /*
@@ -4981,6 +5076,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!se)
 		sub_nr_running(rq, 1);
 
+	util_est_dequeue(p, flags);
 	hrtick_update(rq);
 }
 
@@ -5438,7 +5534,6 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	return affine;
 }
 
-static inline unsigned long task_util(struct task_struct *p);
 static unsigned long cpu_util_wake(int cpu, struct task_struct *p);
 
 static unsigned long capacity_spare_wake(int cpu, struct task_struct *p)
@@ -5883,6 +5978,11 @@ static inline unsigned long task_util(struct task_struct *p)
 	return p->se.avg.util_avg;
 }
 
+static inline unsigned long task_util_est(struct task_struct *p)
+{
+	return max(p->util_est.ewma, p->util_est.last);
+}
+
 /*
  * cpu_util_wake: Compute cpu utilization with any contributions from
  * the waking task p removed.
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 9552fd5854bf..e9f312acc0d3 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -85,3 +85,8 @@ SCHED_FEAT(ATTACH_AGE_LOAD, true)
 SCHED_FEAT(WA_IDLE, true)
 SCHED_FEAT(WA_WEIGHT, true)
 SCHED_FEAT(WA_BIAS, true)
+
+/*
+ * UtilEstimation. Use estimated CPU utiliation.
+ */
+SCHED_FEAT(UTIL_EST, false)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e1666b3e2fb2..3abd13e68655 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -444,6 +444,7 @@ struct cfs_rq {
 	 * CFS load tracking
 	 */
 	struct sched_avg avg;
+	unsigned long util_est_runnable;
 	u64 runnable_load_sum;
 	unsigned long runnable_load_avg;
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.14.1
