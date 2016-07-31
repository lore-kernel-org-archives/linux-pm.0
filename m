From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 4/7] cpufreq / sched: Add flags argument to cpufreq_update_util()
Date: Mon, 01 Aug 2016 01:36:46 +0200
Message-ID: <1797214.I7CKAT8Nb2@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52833 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751199AbcGaXke (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jul 2016 19:40:34 -0400
In-Reply-To: <3752826.3sXAQIvcIA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is useful to know the reason why cpufreq_update_util() has just
been called, so add a flags argument to it and to the ->func()
callback in struct update_util_data.

Update all of the users of them accordingly and use the flags
argument for marking updates coming from the RT sched class.

With that, modify the schedutil governor to use the "RT" flag
instead of the special utilization value of ULONG_MAX to track
updates from the RT sched class.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |    3 ++-
 drivers/cpufreq/intel_pstate.c     |    3 ++-
 include/linux/sched.h              |    7 +++++--
 kernel/sched/cpufreq.c             |    3 ++-
 kernel/sched/cpufreq_schedutil.c   |   37 +++++++++++++++++++++----------------
 kernel/sched/deadline.c            |    2 +-
 kernel/sched/fair.c                |    2 +-
 kernel/sched/rt.c                  |    2 +-
 kernel/sched/sched.h               |    7 ++++---
 9 files changed, 39 insertions(+), 27 deletions(-)

Index: linux-pm/include/linux/sched.h
===================================================================
--- linux-pm.orig/include/linux/sched.h
+++ linux-pm/include/linux/sched.h
@@ -3375,13 +3375,16 @@ static inline unsigned long rlimit_max(u
 	return task_rlimit_max(current, limit);
 }
 
+#define UUF_RT	0x01
+
 #ifdef CONFIG_CPU_FREQ
 struct update_util_data {
-       void (*func)(struct update_util_data *data, u64 time);
+       void (*func)(struct update_util_data *data, u64 time, unsigned int flags);
 };
 
 void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
-                       void (*func)(struct update_util_data *data, u64 time));
+                       void (*func)(struct update_util_data *data, u64 time,
+				    unsigned int flags));
 void cpufreq_remove_update_util_hook(int cpu);
 #endif /* CONFIG_CPU_FREQ */
 
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1328,7 +1328,8 @@ static inline void intel_pstate_adjust_b
 		get_avg_frequency(cpu));
 }
 
-static void intel_pstate_update_util(struct update_util_data *data, u64 time)
+static void intel_pstate_update_util(struct update_util_data *data, u64 time,
+				     unsigned int flags)
 {
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
 	u64 delta_ns = time - cpu->sample.time;
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -259,7 +259,8 @@ static void dbs_irq_work(struct irq_work
 	schedule_work_on(smp_processor_id(), &policy_dbs->work);
 }
 
-static void dbs_update_util_handler(struct update_util_data *data, u64 time)
+static void dbs_update_util_handler(struct update_util_data *data, u64 time,
+				    unsigned int flags)
 {
 	struct cpu_dbs_info *cdbs = container_of(data, struct cpu_dbs_info, update_util);
 	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
Index: linux-pm/kernel/sched/cpufreq.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq.c
+++ linux-pm/kernel/sched/cpufreq.c
@@ -32,7 +32,8 @@ DEFINE_PER_CPU(struct update_util_data *
  * called or it will WARN() and return with no effect.
  */
 void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
-			void (*func)(struct update_util_data *data, u64 time))
+			void (*func)(struct update_util_data *data, u64 time,
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
@@ -144,7 +145,8 @@ static unsigned int get_next_freq(struct
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
-static void sugov_get_util(unsigned long *util, unsigned long *max)
+static void sugov_get_util(unsigned long *util, unsigned long *max,
+			   unsigned int flags)
 {
 	unsigned long dl_util, dl_max;
 	unsigned long cfs_util, cfs_max;
@@ -152,10 +154,8 @@ static void sugov_get_util(unsigned long
 	struct dl_bw *dl_bw = dl_bw_of(cpu);
 	struct rq *rq = this_rq();
 
-	if (rt_prio(current->prio)) {
-		*util = ULONG_MAX;
+	if (flags & UUF_RT)
 		return;
-	}
 
 	dl_max = dl_bw_cpus(cpu) << 20;
 	dl_util = dl_bw->total_bw;
@@ -172,7 +172,8 @@ static void sugov_get_util(unsigned long
 	}
 }
 
-static void sugov_update_single(struct update_util_data *hook, u64 time)
+static void sugov_update_single(struct update_util_data *hook, u64 time,
+				unsigned int flags)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
@@ -183,15 +184,16 @@ static void sugov_update_single(struct u
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
-	sugov_get_util(&util, &max);
+	sugov_get_util(&util, &max, flags);
 
-	next_f = util == ULONG_MAX ? policy->cpuinfo.max_freq :
-			get_next_freq(sg_cpu, util, max);
+	next_f = flags & UUF_RT ? policy->cpuinfo.max_freq :
+				  get_next_freq(sg_cpu, util, max);
 	sugov_update_commit(sg_policy, time, next_f);
 }
 
 static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
-					   unsigned long util, unsigned long max)
+					   unsigned long util, unsigned long max,
+					   unsigned int flags)
 {
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
@@ -199,7 +201,7 @@ static unsigned int sugov_next_freq_shar
 	u64 last_freq_update_time = sg_policy->last_freq_update_time;
 	unsigned int j;
 
-	if (util == ULONG_MAX)
+	if (flags & UUF_RT)
 		return max_f;
 
 	for_each_cpu(j, policy->cpus) {
@@ -222,10 +224,10 @@ static unsigned int sugov_next_freq_shar
 		if (delta_ns > TICK_NSEC)
 			continue;
 
-		j_util = j_sg_cpu->util;
-		if (j_util == ULONG_MAX)
+		if (j_sg_cpu->flags & UUF_RT)
 			return max_f;
 
+		j_util = j_sg_cpu->util;
 		j_max = j_sg_cpu->max;
 		if (j_util * max > j_max * util) {
 			util = j_util;
@@ -236,23 +238,25 @@ static unsigned int sugov_next_freq_shar
 	return get_next_freq(sg_cpu, util, max);
 }
 
-static void sugov_update_shared(struct update_util_data *hook, u64 time)
+static void sugov_update_shared(struct update_util_data *hook, u64 time,
+				unsigned int flags)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long util, max;
 	unsigned int next_f;
 
-	sugov_get_util(&util, &max);
+	sugov_get_util(&util, &max, flags);
 
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
 
@@ -476,8 +480,9 @@ static int sugov_start(struct cpufreq_po
 
 		sg_cpu->sg_policy = sg_policy;
 		if (policy_is_shared(policy)) {
-			sg_cpu->util = ULONG_MAX;
+			sg_cpu->util = 0;
 			sg_cpu->max = 0;
+			sg_cpu->flags = UUF_RT;
 			sg_cpu->last_update = 0;
 			sg_cpu->cached_raw_freq = 0;
 			cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
Index: linux-pm/kernel/sched/sched.h
===================================================================
--- linux-pm.orig/kernel/sched/sched.h
+++ linux-pm/kernel/sched/sched.h
@@ -1761,6 +1761,7 @@ DECLARE_PER_CPU(struct update_util_data
 /**
  * cpufreq_update_util - Take a note about CPU utilization changes.
  * @rq: Runqueue to carry out the update for.
+ * @flags: Update reason flags.
  *
  * This function is called by the scheduler on every invocation of
  * update_load_avg() on the CPU whose utilization is being updated.
@@ -1779,7 +1780,7 @@ DECLARE_PER_CPU(struct update_util_data
  * but that really is a band-aid.  Going forward it should be replaced with
  * solutions targeted more specifically at RT and DL tasks.
  */
-static inline void cpufreq_update_util(struct rq *rq)
+static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
 {
 	struct update_util_data *data;
 
@@ -1788,10 +1789,10 @@ static inline void cpufreq_update_util(s
 
 	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
 	if (data)
-		data->func(data, rq_clock(rq));
+		data->func(data, rq_clock(rq), flags);
 }
 #else
-static inline void cpufreq_update_util(struct rq *rq) {}
+static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef arch_scale_freq_capacity
Index: linux-pm/kernel/sched/deadline.c
===================================================================
--- linux-pm.orig/kernel/sched/deadline.c
+++ linux-pm/kernel/sched/deadline.c
@@ -733,7 +733,7 @@ static void update_curr_dl(struct rq *rq
 	}
 
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq);
+	cpufreq_update_util(rq, 0);
 
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
Index: linux-pm/kernel/sched/fair.c
===================================================================
--- linux-pm.orig/kernel/sched/fair.c
+++ linux-pm/kernel/sched/fair.c
@@ -2887,7 +2887,7 @@ static inline void cfs_rq_util_change(st
 		 *
 		 * See cpu_util().
 		 */
-		cpufreq_update_util(rq_of(cfs_rq));
+		cpufreq_update_util(rq_of(cfs_rq), 0);
 	}
 }
 
Index: linux-pm/kernel/sched/rt.c
===================================================================
--- linux-pm.orig/kernel/sched/rt.c
+++ linux-pm/kernel/sched/rt.c
@@ -958,7 +958,7 @@ static void update_curr_rt(struct rq *rq
 		return;
 
 	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq);
+	cpufreq_update_util(rq, UUF_RT);
 
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));

