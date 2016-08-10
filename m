From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] cpufreq / sched: Pass flags to cpufreq_update_util()
Date: Wed, 10 Aug 2016 03:09:49 +0200
Message-ID: <14590530.PIp5juoJ7q@vostro.rjw.lan>
References: <4498725.ix9jPCHteg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4498725.ix9jPCHteg@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is useful to know the reason why cpufreq_update_util() has just
been called and that can be passed as flags to cpufreq_update_util()
and to the ->func() callback in struct update_util_data.  However,
doing that in addition to passing the util and max arguments they
already take would be clumsy, so avoid it.

Instead, use the observation that the schedutil governor is part
of the scheduler proper, so it can access scheduler data directly.
This allows the util and max arguments of cpufreq_update_util()
and the ->func() callback in struct update_util_data to be replaced
with a flags one, but schedutil has to be modified to follow.

Thus make the schedutil governor obtain the CFS utilization
information from the scheduler and use the "RT" and "DL" flags
instead of the special utilization value of ULONG_MAX to track
updates from the RT and DL sched classes.  Make it non-modular
too to avoid having to export scheduler variables to modules at
large.

Next, update all of the other users of cpufreq_update_util()
and the ->func() callback in struct update_util_data accordingly.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/Kconfig            |    5 ----
 drivers/cpufreq/cpufreq_governor.c |    2 -
 drivers/cpufreq/intel_pstate.c     |    2 -
 include/linux/sched.h              |   12 +++++++---
 kernel/sched/cpufreq.c             |    2 -
 kernel/sched/cpufreq_schedutil.c   |   41 +++++++++++++++++++++++++++----------
 kernel/sched/deadline.c            |    4 +--
 kernel/sched/fair.c                |   11 +++------
 kernel/sched/rt.c                  |    4 +--
 kernel/sched/sched.h               |   31 +++++++++------------------
 10 files changed, 61 insertions(+), 53 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -260,7 +260,7 @@ static void dbs_irq_work(struct irq_work
 }
 
 static void dbs_update_util_handler(struct update_util_data *data, u64 time,
-				    unsigned long util, unsigned long max)
+				    unsigned int flags)
 {
 	struct cpu_dbs_info *cdbs = container_of(data, struct cpu_dbs_info, update_util);
 	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1329,7 +1329,7 @@ static inline void intel_pstate_adjust_b
 }
 
 static void intel_pstate_update_util(struct update_util_data *data, u64 time,
-				     unsigned long util, unsigned long max)
+				     unsigned int flags)
 {
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
 	u64 delta_ns = time - cpu->sample.time;
Index: linux-pm/include/linux/sched.h
===================================================================
--- linux-pm.orig/include/linux/sched.h
+++ linux-pm/include/linux/sched.h
@@ -3469,15 +3469,19 @@ static inline unsigned long rlimit_max(u
 	return task_rlimit_max(current, limit);
 }
 
+#define SCHED_CPUFREQ_RT	(1U << 0)
+#define SCHED_CPUFREQ_DL	(1U << 1)
+
+#define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
+
 #ifdef CONFIG_CPU_FREQ
 struct update_util_data {
-	void (*func)(struct update_util_data *data,
-		     u64 time, unsigned long util, unsigned long max);
+       void (*func)(struct update_util_data *data, u64 time, unsigned int flags);
 };
 
 void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
-			void (*func)(struct update_util_data *data, u64 time,
-				     unsigned long util, unsigned long max));
+                       void (*func)(struct update_util_data *data, u64 time,
+				    unsigned int flags));
 void cpufreq_remove_update_util_hook(int cpu);
 #endif /* CONFIG_CPU_FREQ */
 
Index: linux-pm/kernel/sched/cpufreq.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq.c
+++ linux-pm/kernel/sched/cpufreq.c
@@ -33,7 +33,7 @@ DEFINE_PER_CPU(struct update_util_data *
  */
 void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
 			void (*func)(struct update_util_data *data, u64 time,
-				     unsigned long util, unsigned long max))
+				     unsigned int flags))
 {
 	if (WARN_ON(!data || !func))
 		return;
Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -53,6 +53,7 @@ struct sugov_cpu {
 	unsigned long util;
 	unsigned long max;
 	u64 last_update;
+	unsigned int flags;
 };
 
 static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
@@ -144,24 +145,39 @@ static unsigned int get_next_freq(struct
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
+static void sugov_get_util(unsigned long *util, unsigned long *max)
+{
+	struct rq *rq = this_rq();
+	unsigned long cfs_max = rq->cpu_capacity_orig;
+
+	*util = min(rq->cfs.avg.util_avg, cfs_max);
+	*max = cfs_max;
+}
+
 static void sugov_update_single(struct update_util_data *hook, u64 time,
-				unsigned long util, unsigned long max)
+				unsigned int flags)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
+	unsigned long util, max;
 	unsigned int next_f;
 
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
-	next_f = util == ULONG_MAX ? policy->cpuinfo.max_freq :
-			get_next_freq(sg_cpu, util, max);
+	if (flags & SCHED_CPUFREQ_RT_DL) {
+		next_f = policy->cpuinfo.max_freq;
+	} else {
+		sugov_get_util(&util, &max);
+		next_f = get_next_freq(sg_cpu, util, max);
+	}
 	sugov_update_commit(sg_policy, time, next_f);
 }
 
 static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
-					   unsigned long util, unsigned long max)
+					   unsigned long util, unsigned long max,
+					   unsigned int flags)
 {
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
@@ -169,7 +185,7 @@ static unsigned int sugov_next_freq_shar
 	u64 last_freq_update_time = sg_policy->last_freq_update_time;
 	unsigned int j;
 
-	if (util == ULONG_MAX)
+	if (flags & SCHED_CPUFREQ_RT_DL)
 		return max_f;
 
 	for_each_cpu(j, policy->cpus) {
@@ -192,10 +208,10 @@ static unsigned int sugov_next_freq_shar
 		if (delta_ns > TICK_NSEC)
 			continue;
 
-		j_util = j_sg_cpu->util;
-		if (j_util == ULONG_MAX)
+		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
 			return max_f;
 
+		j_util = j_sg_cpu->util;
 		j_max = j_sg_cpu->max;
 		if (j_util * max > j_max * util) {
 			util = j_util;
@@ -207,20 +223,24 @@ static unsigned int sugov_next_freq_shar
 }
 
 static void sugov_update_shared(struct update_util_data *hook, u64 time,
-				unsigned long util, unsigned long max)
+				unsigned int flags)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
+	unsigned long util, max;
 	unsigned int next_f;
 
+	sugov_get_util(&util, &max);
+
 	raw_spin_lock(&sg_policy->update_lock);
 
 	sg_cpu->util = util;
 	sg_cpu->max = max;
+	sg_cpu->flags = flags;
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
-		next_f = sugov_next_freq_shared(sg_cpu, util, max);
+		next_f = sugov_next_freq_shared(sg_cpu, util, max, flags);
 		sugov_update_commit(sg_policy, time, next_f);
 	}
 
@@ -444,8 +464,9 @@ static int sugov_start(struct cpufreq_po
 
 		sg_cpu->sg_policy = sg_policy;
 		if (policy_is_shared(policy)) {
-			sg_cpu->util = ULONG_MAX;
+			sg_cpu->util = 0;
 			sg_cpu->max = 0;
+			sg_cpu->flags = SCHED_CPUFREQ_RT;
 			sg_cpu->last_update = 0;
 			sg_cpu->cached_raw_freq = 0;
 			cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
Index: linux-pm/kernel/sched/fair.c
===================================================================
--- linux-pm.orig/kernel/sched/fair.c
+++ linux-pm/kernel/sched/fair.c
@@ -2875,11 +2875,8 @@ static inline void update_tg_load_avg(st
 
 static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 {
-	struct rq *rq = rq_of(cfs_rq);
-	int cpu = cpu_of(rq);
-
-	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
-		unsigned long max = rq->cpu_capacity_orig;
+	if (&this_rq()->cfs == cfs_rq) {
+		struct rq *rq = rq_of(cfs_rq);
 
 		/*
 		 * There are a few boundary cases this might miss but it should
@@ -2897,8 +2894,8 @@ static inline void cfs_rq_util_change(st
 		 *
 		 * See cpu_util().
 		 */
-		cpufreq_update_util(rq_clock(rq),
-				    min(cfs_rq->avg.util_avg, max), max);
+		if (cpu_of(rq) == smp_processor_id())
+			cpufreq_update_util(rq_clock(rq), 0);
 	}
 }
 
Index: linux-pm/kernel/sched/sched.h
===================================================================
--- linux-pm.orig/kernel/sched/sched.h
+++ linux-pm/kernel/sched/sched.h
@@ -1764,26 +1764,12 @@ DECLARE_PER_CPU(struct update_util_data
 /**
  * cpufreq_update_util - Take a note about CPU utilization changes.
  * @time: Current time.
- * @util: Current utilization.
- * @max: Utilization ceiling.
+ * @flags: Update reason flags.
  *
- * This function is called by the scheduler on every invocation of
- * update_load_avg() on the CPU whose utilization is being updated.
+ * This function is called by the scheduler on the CPU whose utilization is
+ * being updated.
  *
  * It can only be called from RCU-sched read-side critical sections.
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
- * cpufreq_trigger_update - Trigger CPU performance state evaluation if needed.
- * @time: Current time.
  *
  * The way cpufreq is currently arranged requires it to evaluate the CPU
  * performance state (frequency/voltage) on a regular basis to prevent it from
@@ -1797,13 +1783,16 @@ static inline void cpufreq_update_util(u
  * but that really is a band-aid.  Going forward it should be replaced with
  * solutions targeted more specifically at RT and DL tasks.
  */
-static inline void cpufreq_trigger_update(u64 time)
+static inline void cpufreq_update_util(u64 time, unsigned int flags)
 {
-	cpufreq_update_util(time, ULONG_MAX, 0);
+	struct update_util_data *data;
+
+	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
+	if (data)
+		data->func(data, time, flags);
 }
 #else
-static inline void cpufreq_update_util(u64 time, unsigned long util, unsigned long max) {}
-static inline void cpufreq_trigger_update(u64 time) {}
+static inline void cpufreq_update_util(u64 time, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef arch_scale_freq_capacity
Index: linux-pm/kernel/sched/deadline.c
===================================================================
--- linux-pm.orig/kernel/sched/deadline.c
+++ linux-pm/kernel/sched/deadline.c
@@ -732,9 +732,9 @@ static void update_curr_dl(struct rq *rq
 		return;
 	}
 
-	/* kick cpufreq (see the comment in linux/cpufreq.h). */
+	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
 	if (cpu_of(rq) == smp_processor_id())
-		cpufreq_trigger_update(rq_clock(rq));
+		cpufreq_update_util(rq_clock(rq), SCHED_CPUFREQ_DL);
 
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
Index: linux-pm/kernel/sched/rt.c
===================================================================
--- linux-pm.orig/kernel/sched/rt.c
+++ linux-pm/kernel/sched/rt.c
@@ -957,9 +957,9 @@ static void update_curr_rt(struct rq *rq
 	if (unlikely((s64)delta_exec <= 0))
 		return;
 
-	/* Kick cpufreq (see the comment in linux/cpufreq.h). */
+	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
 	if (cpu_of(rq) == smp_processor_id())
-		cpufreq_trigger_update(rq_clock(rq));
+		cpufreq_update_util(rq_clock(rq), SCHED_CPUFREQ_RT);
 
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
Index: linux-pm/drivers/cpufreq/Kconfig
===================================================================
--- linux-pm.orig/drivers/cpufreq/Kconfig
+++ linux-pm/drivers/cpufreq/Kconfig
@@ -194,7 +194,7 @@ config CPU_FREQ_GOV_CONSERVATIVE
 	  If in doubt, say N.
 
 config CPU_FREQ_GOV_SCHEDUTIL
-	tristate "'schedutil' cpufreq policy governor"
+	bool "'schedutil' cpufreq policy governor"
 	depends on CPU_FREQ && SMP
 	select CPU_FREQ_GOV_ATTR_SET
 	select IRQ_WORK
@@ -208,9 +208,6 @@ config CPU_FREQ_GOV_SCHEDUTIL
 	  frequency tipping point is at utilization/capacity equal to 80% in
 	  both cases.
 
-	  To compile this driver as a module, choose M here: the module will
-	  be called cpufreq_schedutil.
-
 	  If in doubt, say N.
 
 comment "CPU frequency scaling drivers"
