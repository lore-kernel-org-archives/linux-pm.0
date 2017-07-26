From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 1/3] sched: cpufreq: Allow remote cpufreq callbacks
Date: Wed, 26 Jul 2017 14:52:32 +0530
Message-ID: <8797d4993baa6580e3af741d081be492032ce9dd.1501060871.git.viresh.kumar@linaro.org>
References: <cover.1501060871.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501060871.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1501060871.git.viresh.kumar@linaro.org>
References: <cover.1501060871.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We do not call cpufreq callbacks from scheduler core for remote
(non-local) CPUs currently. But there are cases where such remote
callbacks are useful, specially in the case of shared cpufreq policies.

This patch updates the scheduler core to call the cpufreq callbacks for
remote CPUs as well.

For now, all the registered utilization update callbacks are updated to
return early if remote callback is detected. That is, this patch just
moves the decision making down in the hierarchy.

Later patches would enable remote callbacks for shared policies.

Based on initial work from Steve Muckle.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c |  4 ++++
 drivers/cpufreq/intel_pstate.c     |  8 ++++++++
 include/linux/sched/cpufreq.h      |  1 +
 kernel/sched/cpufreq.c             |  1 +
 kernel/sched/cpufreq_schedutil.c   | 11 ++++++++---
 kernel/sched/deadline.c            |  2 +-
 kernel/sched/fair.c                |  8 +++++---
 kernel/sched/rt.c                  |  2 +-
 kernel/sched/sched.h               | 10 ++--------
 9 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index eed069ecfd5e..5499796cf9a8 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -272,6 +272,10 @@ static void dbs_update_util_handler(struct update_util_data *data, u64 time,
 	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
 	u64 delta_ns, lst;
 
+	/* Don't allow remote callbacks */
+	if (smp_processor_id() != data->cpu)
+		return;
+
 	/*
 	 * The work may not be allowed to be queued up right now.
 	 * Possible reasons:
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 89bbc0c11b22..0dd14c8edd2d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1747,6 +1747,10 @@ static void intel_pstate_update_util_pid(struct update_util_data *data,
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
 	u64 delta_ns = time - cpu->sample.time;
 
+	/* Don't allow remote callbacks */
+	if (smp_processor_id() != data->cpu)
+		return;
+
 	if ((s64)delta_ns < pid_params.sample_rate_ns)
 		return;
 
@@ -1764,6 +1768,10 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
 	u64 delta_ns;
 
+	/* Don't allow remote callbacks */
+	if (smp_processor_id() != data->cpu)
+		return;
+
 	if (flags & SCHED_CPUFREQ_IOWAIT) {
 		cpu->iowait_boost = int_tofp(1);
 	} else if (cpu->iowait_boost) {
diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index d2be2ccbb372..8256a8f35f22 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -16,6 +16,7 @@
 #ifdef CONFIG_CPU_FREQ
 struct update_util_data {
        void (*func)(struct update_util_data *data, u64 time, unsigned int flags);
+       unsigned int cpu;
 };
 
 void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index dbc51442ecbc..ee4c596b71b4 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -42,6 +42,7 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
 		return;
 
 	data->func = func;
+	data->cpu = cpu;
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
 }
 EXPORT_SYMBOL_GPL(cpufreq_add_update_util_hook);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 45fcf21ad685..bb834747e49b 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -72,10 +72,15 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
-static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
+static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time,
+				     int target_cpu)
 {
 	s64 delta_ns;
 
+	/* Don't allow remote callbacks */
+	if (smp_processor_id() != target_cpu)
+		return false;
+
 	if (sg_policy->work_in_progress)
 		return false;
 
@@ -221,7 +226,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
-	if (!sugov_should_update_freq(sg_policy, time))
+	if (!sugov_should_update_freq(sg_policy, time, hook->cpu))
 		return;
 
 	busy = sugov_cpu_is_busy(sg_cpu);
@@ -301,7 +306,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
-	if (sugov_should_update_freq(sg_policy, time)) {
+	if (sugov_should_update_freq(sg_policy, time, hook->cpu)) {
 		if (flags & SCHED_CPUFREQ_RT_DL)
 			next_f = sg_policy->policy->cpuinfo.max_freq;
 		else
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 755bd3f1a1a9..5c3bf4bd0327 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1136,7 +1136,7 @@ static void update_curr_dl(struct rq *rq)
 	}
 
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_DL);
+	cpufreq_update_util(rq, SCHED_CPUFREQ_DL);
 
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c95880e216f6..d378d02fdfcb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3278,7 +3278,9 @@ static inline void set_tg_cfs_propagate(struct cfs_rq *cfs_rq) {}
 
 static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 {
-	if (&this_rq()->cfs == cfs_rq) {
+	struct rq *rq = rq_of(cfs_rq);
+
+	if (&rq->cfs == cfs_rq) {
 		/*
 		 * There are a few boundary cases this might miss but it should
 		 * get called often enough that that should (hopefully) not be
@@ -3295,7 +3297,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 		 *
 		 * See cpu_util().
 		 */
-		cpufreq_update_util(rq_of(cfs_rq), 0);
+		cpufreq_update_util(rq, 0);
 	}
 }
 
@@ -4875,7 +4877,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * passed.
 	 */
 	if (p->in_iowait)
-		cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_IOWAIT);
+		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
 	for_each_sched_entity(se) {
 		if (se->on_rq)
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 45caf937ef90..0af5ca9e3e3f 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -970,7 +970,7 @@ static void update_curr_rt(struct rq *rq)
 		return;
 
 	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
+	cpufreq_update_util(rq, SCHED_CPUFREQ_RT);
 
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eeef1a3086d1..aa9d5b87b4f8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2070,19 +2070,13 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
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
