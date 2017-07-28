From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 1/2] sched: cpufreq: Allow remote cpufreq callbacks
Date: Fri, 28 Jul 2017 12:16:38 +0530
Message-ID: <bf99ffdd3a7e5edc2a5bca370801b06830c081a0.1501223897.git.viresh.kumar@linaro.org>
References: <cover.1501223897.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501223897.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1501223897.git.viresh.kumar@linaro.org>
References: <cover.1501223897.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, skannan@codeaurora.org, joelaf@google.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

With Android UI and benchmarks the latency of cpufreq response to
certain scheduling events can become very critical. Currently, callbacks
into cpufreq governors are only made from the scheduler if the target
CPU of the event is the same as the current CPU. This means there are
certain situations where a target CPU may not run the cpufreq governor
for some time.

One testcase to show this behavior is where a task starts running on
CPU0, then a new task is also spawned on CPU0 by a task on CPU1. If the
system is configured such that the new tasks should receive maximum
demand initially, this should result in CPU0 increasing frequency
immediately. But because of the above mentioned limitation though, this
does not occur.

This patch updates the scheduler core to call the cpufreq callbacks for
remote CPUs as well.

The schedutil, ondemand and conservative governors are updated to
process cpufreq utilization update hooks called for remote CPUs where
the remote CPU is managed by the cpufreq policy of the local CPU.

The intel_pstate driver is updated to always reject remote callbacks.

This is tested with couple of usecases (Android: hackbench, recentfling,
galleryfling, vellamo, Ubuntu: hackbench) on ARM hikey board (64 bit
octa-core, single policy). Only galleryfling showed minor improvements,
while others didn't had much deviation.

The reason being that this patch only targets a corner case, where
following are required to be true to improve performance and that
doesn't happen too often with these tests:

- Task is migrated to another CPU.
- The task has high demand, and should take the target CPU to higher
  OPPs.
- And the target CPU doesn't call into the cpufreq governor until the
  next tick.

Based on initial work from Steve Muckle.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c |  3 +++
 drivers/cpufreq/intel_pstate.c     |  8 ++++++++
 include/linux/cpufreq.h            |  9 +++++++++
 kernel/sched/cpufreq_schedutil.c   | 31 ++++++++++++++++++++++++++-----
 kernel/sched/deadline.c            |  2 +-
 kernel/sched/fair.c                |  8 +++++---
 kernel/sched/rt.c                  |  2 +-
 kernel/sched/sched.h               | 10 ++--------
 8 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index eed069ecfd5e..58d4f4e1ad6a 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -272,6 +272,9 @@ static void dbs_update_util_handler(struct update_util_data *data, u64 time,
 	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
 	u64 delta_ns, lst;
 
+	if (!cpufreq_can_do_remote_dvfs(policy_dbs->policy))
+		return;
+
 	/*
 	 * The work may not be allowed to be queued up right now.
 	 * Possible reasons:
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8bc252512dbe..d9de01399dbb 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1747,6 +1747,10 @@ static void intel_pstate_update_util_pid(struct update_util_data *data,
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
 	u64 delta_ns = time - cpu->sample.time;
 
+	/* Don't allow remote callbacks */
+	if (smp_processor_id() != cpu->cpu)
+		return;
+
 	if ((s64)delta_ns < pid_params.sample_rate_ns)
 		return;
 
@@ -1764,6 +1768,10 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
 	u64 delta_ns;
 
+	/* Don't allow remote callbacks */
+	if (smp_processor_id() != cpu->cpu)
+		return;
+
 	if (flags & SCHED_CPUFREQ_IOWAIT) {
 		cpu->iowait_boost = int_tofp(1);
 	} else if (cpu->iowait_boost) {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 5f40522ec98c..b3b6e8203e82 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -562,6 +562,15 @@ struct governor_attr {
 			 size_t count);
 };
 
+static inline bool cpufreq_can_do_remote_dvfs(struct cpufreq_policy *policy)
+{
+	/* Allow remote callbacks only on the CPUs sharing cpufreq policy */
+	if (cpumask_test_cpu(smp_processor_id(), policy->cpus))
+		return true;
+
+	return false;
+}
+
 /*********************************************************************
  *                     FREQUENCY TABLE HELPERS                       *
  *********************************************************************/
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 9deedd5f16a5..5465bf221e8f 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -52,6 +52,7 @@ struct sugov_policy {
 struct sugov_cpu {
 	struct update_util_data update_util;
 	struct sugov_policy *sg_policy;
+	unsigned int cpu;
 
 	bool iowait_boost_pending;
 	unsigned int iowait_boost;
@@ -77,6 +78,21 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 {
 	s64 delta_ns;
 
+	/*
+	 * Since cpufreq_update_util() is called with rq->lock held for
+	 * the @target_cpu, our per-cpu data is fully serialized.
+	 *
+	 * However, drivers cannot in general deal with cross-cpu
+	 * requests, so while get_next_freq() will work, our
+	 * sugov_update_commit() call may not.
+	 *
+	 * Hence stop here for remote requests if they aren't supported
+	 * by the hardware, as calculating the frequency is pointless if
+	 * we cannot in fact act on it.
+	 */
+	if (!cpufreq_can_do_remote_dvfs(sg_policy->policy))
+		return false;
+
 	if (sg_policy->work_in_progress)
 		return false;
 
@@ -155,12 +171,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
-static void sugov_get_util(unsigned long *util, unsigned long *max)
+static void sugov_get_util(unsigned long *util, unsigned long *max, int cpu)
 {
-	struct rq *rq = this_rq();
+	struct rq *rq = cpu_rq(cpu);
 	unsigned long cfs_max;
 
-	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
+	cfs_max = arch_scale_cpu_capacity(NULL, cpu);
 
 	*util = min(rq->cfs.avg.util_avg, cfs_max);
 	*max = cfs_max;
@@ -254,7 +270,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	if (flags & SCHED_CPUFREQ_RT_DL) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
-		sugov_get_util(&util, &max);
+		sugov_get_util(&util, &max, sg_cpu->cpu);
 		sugov_iowait_boost(sg_cpu, &util, &max);
 		next_f = get_next_freq(sg_policy, util, max);
 		/*
@@ -316,7 +332,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	unsigned long util, max;
 	unsigned int next_f;
 
-	sugov_get_util(&util, &max);
+	sugov_get_util(&util, &max, sg_cpu->cpu);
 
 	raw_spin_lock(&sg_policy->update_lock);
 
@@ -689,6 +705,11 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 
 static int __init sugov_register(void)
 {
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu(sugov_cpu, cpu).cpu = cpu;
+
 	return cpufreq_register_governor(&schedutil_gov);
 }
 fs_initcall(sugov_register);
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
