From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/4] sched: cpufreq: Enable remote sched cpufreq callbacks
Date: Thu, 29 Jun 2017 10:56:33 +0530
Message-ID: <e7fc1a75b2ac4f7d8a06a2f05dfc3c348e48badb.1498712046.git.viresh.kumar@linaro.org>
References: <cover.1498712046.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1498712046.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1498712046.git.viresh.kumar@linaro.org>
References: <cover.1498712046.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

Now that all clients properly support (or ignore) remote scheduler
cpufreq callbacks, remove the restriction that such callbacks only be
made on the local CPU.

Also remove cpufreq_update_this_cpu() as all its users are migrated to
use cpufreq_update_util() instead.

Based on initial work from Steve Muckle.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/deadline.c |  2 +-
 kernel/sched/fair.c     |  8 +++++---
 kernel/sched/rt.c       |  2 +-
 kernel/sched/sched.h    | 10 ++--------
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a2ce59015642..512d51226998 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -763,7 +763,7 @@ static void update_curr_dl(struct rq *rq)
 	}
 
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_DL);
+	cpufreq_update_util(rq, SCHED_CPUFREQ_DL);
 
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c77e4b1d51c0..77ef663e1380 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3215,7 +3215,9 @@ static inline void set_tg_cfs_propagate(struct cfs_rq *cfs_rq) {}
 
 static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 {
-	if (&this_rq()->cfs == cfs_rq) {
+	struct rq *rq = rq_of(cfs_rq);
+
+	if (&rq->cfs == cfs_rq) {
 		/*
 		 * There are a few boundary cases this might miss but it should
 		 * get called often enough that that should (hopefully) not be
@@ -3232,7 +3234,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 		 *
 		 * See cpu_util().
 		 */
-		cpufreq_update_util(rq_of(cfs_rq), 0);
+		cpufreq_update_util(rq, 0);
 	}
 }
 
@@ -4792,7 +4794,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * passed.
 	 */
 	if (p->in_iowait)
-		cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_IOWAIT);
+		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
 	for_each_sched_entity(se) {
 		if (se->on_rq)
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 979b7341008a..1e626e49f7fc 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -959,7 +959,7 @@ static void update_curr_rt(struct rq *rq)
 		return;
 
 	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
+	cpufreq_update_util(rq, SCHED_CPUFREQ_RT);
 
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6dda2aab731e..cce497b5837c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1987,19 +1987,13 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
 {
 	struct update_util_data *data;
 
-	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
+	data = rcu_dereference_sched(*per_cpu_ptr(&cpufreq_update_util_data,
+						  cpu_of(rq)));
 	if (data)
 		data->func(data, rq_clock(rq), flags);
 }
-
-static inline void cpufreq_update_this_cpu(struct rq *rq, unsigned int flags)
-{
-	if (cpu_of(rq) == smp_processor_id())
-		cpufreq_update_util(rq, flags);
-}
 #else
 static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
-static inline void cpufreq_update_this_cpu(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef arch_scale_freq_capacity
-- 
2.13.0.71.gd7076ec9c9cb
