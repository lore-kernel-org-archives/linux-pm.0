From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 1/7] cpufreq / sched: Make schedutil access utilization data directly
Date: Mon, 01 Aug 2016 01:34:36 +0200
Message-ID: <9887668.FEg7fVruKQ@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58697 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751558AbcGaXkg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jul 2016 19:40:36 -0400
In-Reply-To: <3752826.3sXAQIvcIA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

From: Peter Zijlstra <peterz@infradead.org>

Since the schedutil governor is part of the scheduler proper, it can
access scheduler data directly.

This allows us to remove the util and max arguments of
cpufreq_update_util(), since only the schedutil governor will use
those, which leads to some text reduction:

  43595    1226      24   44845    af2d defconfig-build/kernel/sched/fair.o.pre
  42907    1226      24   44157    ac7d defconfig-build/kernel/sched/fair.o.post

Of course, we get more text in schedutil in return, but we can
benefit from not being tied to those two parameters by doing a very
coarse deadline reservation.

[ rjw: Subject/changelog + rebase, minor updates ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |    3 --
 drivers/cpufreq/intel_pstate.c     |    3 --
 include/linux/sched.h              |    6 +----
 kernel/sched/core.c                |    4 +--
 kernel/sched/cpufreq.c             |    3 --
 kernel/sched/cpufreq_schedutil.c   |   40 +++++++++++++++++++++++++++++++++----
 kernel/sched/fair.c                |   11 +++-------
 kernel/sched/sched.h               |   17 +++++++--------
 8 files changed, 55 insertions(+), 32 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -259,8 +259,7 @@ static void dbs_irq_work(struct irq_work
 	schedule_work_on(smp_processor_id(), &policy_dbs->work);
 }
 
-static void dbs_update_util_handler(struct update_util_data *data, u64 time,
-				    unsigned long util, unsigned long max)
+static void dbs_update_util_handler(struct update_util_data *data, u64 time)
 {
 	struct cpu_dbs_info *cdbs = container_of(data, struct cpu_dbs_info, update_util);
 	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1328,8 +1328,7 @@ static inline void intel_pstate_adjust_b
 		get_avg_frequency(cpu));
 }
 
-static void intel_pstate_update_util(struct update_util_data *data, u64 time,
-				     unsigned long util, unsigned long max)
+static void intel_pstate_update_util(struct update_util_data *data, u64 time)
 {
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
 	u64 delta_ns = time - cpu->sample.time;
Index: linux-pm/include/linux/sched.h
===================================================================
--- linux-pm.orig/include/linux/sched.h
+++ linux-pm/include/linux/sched.h
@@ -3377,13 +3377,11 @@ static inline unsigned long rlimit_max(u
 
 #ifdef CONFIG_CPU_FREQ
 struct update_util_data {
-	void (*func)(struct update_util_data *data,
-		     u64 time, unsigned long util, unsigned long max);
+       void (*func)(struct update_util_data *data, u64 time);
 };
 
 void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
-			void (*func)(struct update_util_data *data, u64 time,
-				     unsigned long util, unsigned long max));
+                       void (*func)(struct update_util_data *data, u64 time));
 void cpufreq_remove_update_util_hook(int cpu);
 #endif /* CONFIG_CPU_FREQ */
 
Index: linux-pm/kernel/sched/cpufreq.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq.c
+++ linux-pm/kernel/sched/cpufreq.c
@@ -32,8 +32,7 @@ DEFINE_PER_CPU(struct update_util_data *
  * called or it will WARN() and return with no effect.
  */
 void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
-			void (*func)(struct update_util_data *data, u64 time,
-				     unsigned long util, unsigned long max))
+			void (*func)(struct update_util_data *data, u64 time))
 {
 	if (WARN_ON(!data || !func))
 		return;
Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -144,17 +144,47 @@ static unsigned int get_next_freq(struct
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
-static void sugov_update_single(struct update_util_data *hook, u64 time,
-				unsigned long util, unsigned long max)
+static void sugov_get_util(unsigned long *util, unsigned long *max)
+{
+	unsigned long dl_util, dl_max;
+	unsigned long cfs_util, cfs_max;
+	int cpu = smp_processor_id();
+	struct dl_bw *dl_bw = dl_bw_of(cpu);
+	struct rq *rq = this_rq();
+
+	if (rt_prio(current->prio)) {
+		*util = ULONG_MAX;
+		return;
+	}
+
+	dl_max = dl_bw_cpus(cpu) << 20;
+	dl_util = dl_bw->total_bw;
+
+	cfs_max = rq->cpu_capacity_orig;
+	cfs_util = min(rq->cfs.avg.util_avg, cfs_max);
+
+	if (cfs_util * dl_max > dl_util * cfs_max) {
+		*util = cfs_util;
+		*max  = cfs_max;
+	} else {
+		*util = dl_util;
+		*max  = dl_max;
+	}
+}
+
+static void sugov_update_single(struct update_util_data *hook, u64 time)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
+	unsigned long util, max;
 	unsigned int next_f;
 
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
+	sugov_get_util(&util, &max);
+
 	next_f = util == ULONG_MAX ? policy->cpuinfo.max_freq :
 			get_next_freq(sg_cpu, util, max);
 	sugov_update_commit(sg_policy, time, next_f);
@@ -206,13 +236,15 @@ static unsigned int sugov_next_freq_shar
 	return get_next_freq(sg_cpu, util, max);
 }
 
-static void sugov_update_shared(struct update_util_data *hook, u64 time,
-				unsigned long util, unsigned long max)
+static void sugov_update_shared(struct update_util_data *hook, u64 time)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
+	unsigned long util, max;
 	unsigned int next_f;
 
+	sugov_get_util(&util, &max);
+
 	raw_spin_lock(&sg_policy->update_lock);
 
 	sg_cpu->util = util;
Index: linux-pm/kernel/sched/fair.c
===================================================================
--- linux-pm.orig/kernel/sched/fair.c
+++ linux-pm/kernel/sched/fair.c
@@ -2870,11 +2870,8 @@ static inline u64 cfs_rq_clock_task(stru
 
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
@@ -2892,8 +2889,8 @@ static inline void cfs_rq_util_change(st
 		 *
 		 * See cpu_util().
 		 */
-		cpufreq_update_util(rq_clock(rq),
-				    min(cfs_rq->avg.util_avg, max), max);
+		if (cpu_of(rq) == smp_processor_id())
+			cpufreq_update_util(rq_clock(rq));
 	}
 }
 
Index: linux-pm/kernel/sched/sched.h
===================================================================
--- linux-pm.orig/kernel/sched/sched.h
+++ linux-pm/kernel/sched/sched.h
@@ -190,6 +190,7 @@ static inline int dl_bandwidth_enabled(v
 }
 
 extern struct dl_bw *dl_bw_of(int i);
+extern int dl_bw_cpus(int i);
 
 struct dl_bw {
 	raw_spinlock_t lock;
@@ -1760,21 +1761,19 @@ DECLARE_PER_CPU(struct update_util_data
 /**
  * cpufreq_update_util - Take a note about CPU utilization changes.
  * @time: Current time.
- * @util: Current utilization.
- * @max: Utilization ceiling.
  *
  * This function is called by the scheduler on every invocation of
  * update_load_avg() on the CPU whose utilization is being updated.
  *
  * It can only be called from RCU-sched read-side critical sections.
  */
-static inline void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
+static inline void cpufreq_update_util(u64 time)
 {
-       struct update_util_data *data;
+	struct update_util_data *data;
 
-       data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
-       if (data)
-               data->func(data, time, util, max);
+	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
+	if (data)
+		data->func(data, time);
 }
 
 /**
@@ -1795,10 +1794,10 @@ static inline void cpufreq_update_util(u
  */
 static inline void cpufreq_trigger_update(u64 time)
 {
-	cpufreq_update_util(time, ULONG_MAX, 0);
+	cpufreq_update_util(time);
 }
 #else
-static inline void cpufreq_update_util(u64 time, unsigned long util, unsigned long max) {}
+static inline void cpufreq_update_util(u64 time) {}
 static inline void cpufreq_trigger_update(u64 time) {}
 #endif /* CONFIG_CPU_FREQ */
 
Index: linux-pm/kernel/sched/core.c
===================================================================
--- linux-pm.orig/kernel/sched/core.c
+++ linux-pm/kernel/sched/core.c
@@ -2438,7 +2438,7 @@ inline struct dl_bw *dl_bw_of(int i)
 	return &cpu_rq(i)->rd->dl_bw;
 }
 
-static inline int dl_bw_cpus(int i)
+int dl_bw_cpus(int i)
 {
 	struct root_domain *rd = cpu_rq(i)->rd;
 	int cpus = 0;
@@ -2456,7 +2456,7 @@ inline struct dl_bw *dl_bw_of(int i)
 	return &cpu_rq(i)->dl.dl_bw;
 }
 
-static inline int dl_bw_cpus(int i)
+int dl_bw_cpus(int i)
 {
 	return 1;
 }

