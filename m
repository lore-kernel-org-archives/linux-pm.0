From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH 3/5] sched: cpufreq: call cpufreq hook from remote CPUs
Date: Mon,  9 May 2016 14:20:12 -0700
Message-ID: <1462828814-32530-4-git-send-email-smuckle@linaro.org>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33532 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbcEIVUX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2016 17:20:23 -0400
Received: by mail-pf0-f182.google.com with SMTP id 206so80640956pfu.0
        for <linux-pm@vger.kernel.org>; Mon, 09 May 2016 14:20:22 -0700 (PDT)
In-Reply-To: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

Without calling the cpufreq hook for a remote wakeup it is possible
for such a wakeup to go unnoticed by cpufreq on the target CPU for up
to a full tick. This can occur if the target CPU is running a
CPU-bound task and preemption does not occur. If preemption does occur
then the scheduler is expected to run soon on the target CPU anyway so
invoking the cpufreq hook on the remote wakeup is not required.

In order to avoid unnecessary interprocessor communication in the
governor for the preemption case, the existing hook (which happens
before preemption is decided) is only called when the target CPU
is within the current CPU's cpufreq policy. A new hook is added in
check_preempt_curr() to handle events outside the current CPU's
cpufreq policy where preemption does not happen.

Some governors may opt to not receive remote CPU callbacks. This
behavior is possible by providing NULL as the new policy_cpus
parameter to cpufreq_add_update_util_hook(). Callbacks will only be
issued in this case when the target CPU and the current CPU are the
same. Otherwise policy_cpus is used to determine what is a local
vs. remote callback.

Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c |   2 +-
 drivers/cpufreq/intel_pstate.c     |   2 +-
 include/linux/sched.h              |   4 +-
 kernel/sched/core.c                |   4 ++
 kernel/sched/cpufreq.c             |  13 ++++-
 kernel/sched/cpufreq_schedutil.c   |   6 ++-
 kernel/sched/fair.c                |  40 +++++++-------
 kernel/sched/sched.h               | 106 +++++++++++++++++++++++++++++--------
 8 files changed, 127 insertions(+), 50 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 20f0a4e114d1..e127a7a22177 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -311,7 +311,7 @@ static void gov_set_update_util(struct policy_dbs_info *policy_dbs,
 		struct cpu_dbs_info *cdbs = &per_cpu(cpu_dbs, cpu);
 
 		cpufreq_add_update_util_hook(cpu, &cdbs->update_util,
-					     dbs_update_util_handler);
+					     dbs_update_util_handler, NULL);
 	}
 }
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6c7cff13f0ed..9cf262ef23af 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1266,7 +1266,7 @@ static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
 	/* Prevent intel_pstate_update_util() from using stale data. */
 	cpu->sample.time = 0;
 	cpufreq_add_update_util_hook(cpu_num, &cpu->update_util,
-				     intel_pstate_update_util);
+				     intel_pstate_update_util, NULL);
 }
 
 static void intel_pstate_clear_update_util_hook(unsigned int cpu)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 81aba7dc5966..ce154518119a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -3239,11 +3239,13 @@ struct update_util_data {
 	void (*func)(struct update_util_data *data,
 		     u64 time, unsigned long util, unsigned long max);
 	int cpu;
+	cpumask_var_t *policy_cpus;
 };
 
 void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
 			void (*func)(struct update_util_data *data, u64 time,
-				     unsigned long util, unsigned long max));
+				     unsigned long util, unsigned long max),
+				  cpumask_var_t *policy_cpus);
 void cpufreq_remove_update_util_hook(int cpu);
 #endif /* CONFIG_CPU_FREQ */
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8b489fcac37b..fce6c0b43231 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -450,6 +450,8 @@ void resched_curr(struct rq *rq)
 
 	lockdep_assert_held(&rq->lock);
 
+	cpufreq_set_skip_cb(rq);
+
 	if (test_tsk_need_resched(curr))
 		return;
 
@@ -922,6 +924,8 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	if (task_on_rq_queued(rq->curr) && test_tsk_need_resched(rq->curr))
 		rq_clock_skip_update(rq, true);
+
+	cpufreq_update_remote(rq);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index d88a78ea805d..2946d2096bf2 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -18,6 +18,7 @@ DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
  * @cpu: The CPU to set the pointer for.
  * @data: New pointer value.
  * @func: Callback function to set for the CPU.
+ * @policy_cpus: Pointer to cpumask for CPUs which share the same policy.
  *
  * Set and publish the update_util_data pointer for the given CPU.
  *
@@ -28,12 +29,21 @@ DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
  * passed to it as the first argument which allows the function to get to the
  * target update_util_data structure and its container.
  *
+ * If the callback function is designed to be run from CPUs outside the policy
+ * as well as those inside then the policy_cpus pointer should be set. This will
+ * cause these remote callbacks to be run as long as the associated scheduler
+ * event does not trigger preemption. If preemption does occur then it is
+ * assumed that the callback will happen soon enough on the target CPU as a
+ * result of the preemption scheduler activity there. If policy_cpus is set to
+ * NULL, then callbacks will only occur if the target CPU is the current CPU.
+ *
  * The update_util_data pointer of @cpu must be NULL when this function is
  * called or it will WARN() and return with no effect.
  */
 void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
 			void (*func)(struct update_util_data *data, u64 time,
-				     unsigned long util, unsigned long max))
+				     unsigned long util, unsigned long max),
+				  cpumask_var_t *policy_cpus)
 {
 	if (WARN_ON(!data || !func))
 		return;
@@ -43,6 +53,7 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
 
 	data->func = func;
 	data->cpu = cpu;
+	data->policy_cpus = policy_cpus;
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
 }
 EXPORT_SYMBOL_GPL(cpufreq_add_update_util_hook);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index c81f9432f520..6cb2ecc204ec 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -477,10 +477,12 @@ static int sugov_start(struct cpufreq_policy *policy)
 			sg_cpu->max = 0;
 			sg_cpu->last_update = 0;
 			cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
-						     sugov_update_shared);
+						     sugov_update_shared,
+						     &policy->cpus);
 		} else {
 			cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
-						     sugov_update_single);
+						     sugov_update_single,
+						     &policy->cpus);
 		}
 	}
 	return 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2bcc54bd10a7..2b7179cc7063 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2824,30 +2824,26 @@ static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq);
 static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
-	int cpu = cpu_of(rq);
 
-	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
-		unsigned long max = rq->cpu_capacity_orig;
+	if (&rq->cfs != cfs_rq)
+		return;
 
-		/*
-		 * There are a few boundary cases this might miss but it should
-		 * get called often enough that that should (hopefully) not be
-		 * a real problem -- added to that it only calls on the local
-		 * CPU, so if we enqueue remotely we'll miss an update, but
-		 * the next tick/schedule should update.
-		 *
-		 * It will not get called when we go idle, because the idle
-		 * thread is a different class (!fair), nor will the utilization
-		 * number include things like RT tasks.
-		 *
-		 * As is, the util number is not freq-invariant (we'd have to
-		 * implement arch_scale_freq_capacity() for that).
-		 *
-		 * See cpu_util().
-		 */
-		cpufreq_update_util(rq_clock(rq),
-				    min(cfs_rq->avg.util_avg, max), max);
-	}
+	/*
+	 * There are a few boundary cases this might miss but it should
+	 * get called often enough that that should (hopefully) not be
+	 * a real problem. There is also a call to the hook after preemption
+	 * is checked.
+	 *
+	 * It will not get called when we go idle, because the idle
+	 * thread is a different class (!fair), nor will the utilization
+	 * number include things like RT tasks.
+	 *
+	 * As is, the util number is not freq-invariant (we'd have to
+	 * implement arch_scale_freq_capacity() for that).
+	 *
+	 * See cpu_util().
+	 */
+	cpufreq_update_util(rq);
 }
 
 /* Group cfs_rq's load_avg is used for task_h_load and update_cfs_share */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 921d6e5d33b7..0ee080e791b9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -702,6 +702,10 @@ struct rq {
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state *idle_state;
 #endif
+
+#if defined(CONFIG_SMP) && defined(CONFIG_CPU_FREQ)
+	bool cpufreq_skip_cb;
+#endif
 };
 
 static inline int cpu_of(struct rq *rq)
@@ -1798,26 +1802,6 @@ static inline u64 irq_time_read(int cpu)
 DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
 
 /**
- * cpufreq_update_util - Take a note about CPU utilization changes.
- * @time: Current time.
- * @util: Current utilization.
- * @max: Utilization ceiling.
- *
- * This function is called by the scheduler on every invocation of
- * update_load_avg() on the CPU whose utilization is being updated.
- *
- * It can only be called from RCU-sched read-side critical sections.
- */
-static inline void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
-{
-       struct update_util_data *data;
-
-       data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
-       if (data)
-               data->func(data, time, util, max);
-}
-
-/**
  * cpufreq_trigger_update - Trigger CPU performance state evaluation if needed.
  * @time: Current time.
  *
@@ -1835,13 +1819,91 @@ static inline void cpufreq_update_util(u64 time, unsigned long util, unsigned lo
  */
 static inline void cpufreq_trigger_update(u64 time)
 {
-	cpufreq_update_util(time, ULONG_MAX, 0);
+	struct update_util_data *data;
+
+	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
+	if (data)
+		data->func(data, time, ULONG_MAX, 0);
 }
+
 #else
-static inline void cpufreq_update_util(u64 time, unsigned long util, unsigned long max) {}
 static inline void cpufreq_trigger_update(u64 time) {}
 #endif /* CONFIG_CPU_FREQ */
 
+#if defined(CONFIG_CPU_FREQ) && defined(CONFIG_SMP)
+/**
+ * cpufreq_update_util - Take a note about CPU utilization changes.
+ * @rq: Runqueue of CPU to be updated.
+ *
+ * This function is called during scheduler events which cause a CPU's root
+ * cfs_rq utilization to be updated.
+*
+ * It can only be called from RCU-sched read-side critical sections.
+ */
+static inline void cpufreq_update_util(struct rq *rq)
+{
+	struct update_util_data *data;
+	unsigned long max;
+
+	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
+	if (!data)
+		return;
+
+	if (!data->policy_cpus && cpu_of(rq) != smp_processor_id())
+		return;
+
+	if (data->policy_cpus &&
+	    !cpumask_test_cpu(smp_processor_id(), *data->policy_cpus))
+		return;
+
+	max = rq->cpu_capacity_orig;
+	data->func(data, rq_clock(rq), min(rq->cfs.avg.util_avg, max), max);
+}
+
+/**
+ * cpufreq_update_remote - Process callbacks to CPUs in remote policies.
+ * @rq: Target runqueue.
+ *
+ * Remote cpufreq callbacks must be processed after preemption has been decided
+ * so that unnecessary IPIs may be avoided. Cpufreq callbacks to CPUs within the
+ * local policy are handled earlier.
+ */
+static inline void cpufreq_update_remote(struct rq *rq)
+{
+	struct update_util_data *data;
+	unsigned long max;
+	int cpu = smp_processor_id();
+	int target = cpu_of(rq);
+
+	if (rq->cpufreq_skip_cb) {
+		rq->cpufreq_skip_cb = false;
+		return;
+	}
+
+	if (target == cpu)
+		return;
+
+	data = rcu_dereference_sched(per_cpu(cpufreq_update_util_data, target));
+	if (!data || !data->policy_cpus)
+		return;
+
+	if (cpumask_test_cpu(cpu, *data->policy_cpus))
+		return;
+
+	max = rq->cpu_capacity_orig;
+	data->func(data, rq_clock(rq), min(rq->cfs.avg.util_avg, max), max);
+}
+
+static inline void cpufreq_set_skip_cb(struct rq *rq)
+{
+	rq->cpufreq_skip_cb = true;
+}
+#else
+static inline void cpufreq_update_util(struct rq *rq) {}
+static inline void cpufreq_update_remote(struct rq *rq) {}
+static inline void cpufreq_set_skip_cb(struct rq *rq) {}
+#endif /* CONFIG_SMP && CONFIG_CPU_FREQ */
+
 #ifdef arch_scale_freq_capacity
 #ifndef arch_scale_freq_invariant
 #define arch_scale_freq_invariant()	(true)
-- 
2.4.10

