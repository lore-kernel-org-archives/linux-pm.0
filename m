From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Update][PATCH v7 7/7] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Thu, 31 Mar 2016 14:12:45 +0200
Message-ID: <20160331121245.GI3408@twins.programming.kicks-ass.net>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <6666532.7ULg06hQ7e@vostro.rjw.lan>
 <145931680.Kk1xSBT0Ro@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <145931680.Kk1xSBT0Ro@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org


Ingo reminded me that the schedutil governor is part of the scheduler
proper and can access scheduler data because of that.

This allows us to remove the util and max arguments since only the
schedutil governor will use those, which leads to some further text
reduction:

  43595    1226      24   44845    af2d defconfig-build/kernel/sched/fair.o.pre
  42907    1226      24   44157    ac7d defconfig-build/kernel/sched/fair.o.post

Of course, we get more text in schedutil in return, but the below also
shows how we can benefit from not being tied to those two parameters by
doing a very coarse deadline reservation.

---
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -248,8 +248,7 @@ static void dbs_irq_work(struct irq_work
 	schedule_work_on(smp_processor_id(), &policy_dbs->work);
 }
 
-static void dbs_update_util_handler(struct update_util_data *data, u64 time,
-				    unsigned long util, unsigned long max)
+static void dbs_update_util_handler(struct update_util_data *data, u64 time)
 {
 	struct cpu_dbs_info *cdbs = container_of(data, struct cpu_dbs_info, update_util);
 	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1032,8 +1032,7 @@ static inline void intel_pstate_adjust_b
 		get_avg_frequency(cpu));
 }
 
-static void intel_pstate_update_util(struct update_util_data *data, u64 time,
-				     unsigned long util, unsigned long max)
+static void intel_pstate_update_util(struct update_util_data *data, u64 time)
 {
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
 	u64 delta_ns = time - cpu->sample.time;
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -3236,13 +3236,11 @@ static inline unsigned long rlimit_max(u
 
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
 
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
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
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -129,19 +129,55 @@ static unsigned int get_next_freq(struct
 	return (freq + (freq >> 2)) * util / max;
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
+		/*
+		 * Punt for now; maybe do something based on sysctl_sched_rt_*.
+		 */
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
 
-	next_f = util == ULONG_MAX ? policy->cpuinfo.max_freq :
-			get_next_freq(policy, util, max);
+	sugov_get_util(&util, &max);
+
+	if (util == ULONG_MAX)
+		next_f = policy->cpuinfo.max_freq;
+	else
+		next_f = get_next_freq(policy, util, max);
+
 	sugov_update_commit(sg_policy, time, next_f);
 }
 
@@ -190,13 +226,15 @@ static unsigned int sugov_next_freq_shar
 	return get_next_freq(policy, util, max);
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
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2823,12 +2823,8 @@ static inline u64 cfs_rq_clock_task(stru
 
 static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 {
-	struct rq *rq = rq_of(cfs_rq);
-	int cpu = cpu_of(rq);
-
-	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
-		unsigned long max = rq->cpu_capacity_orig;
-
+	if (&this_rq()->cfs == cfs_rq) {
+		struct rq *rq = rq_of(cfs_rq);
 		/*
 		 * There are a few boundary cases this might miss but it should
 		 * get called often enough that that should (hopefully) not be
@@ -2845,8 +2841,7 @@ static inline void cfs_rq_util_change(st
 		 *
 		 * See cpu_util().
 		 */
-		cpufreq_update_util(rq_clock(rq),
-				    min(cfs_rq->avg.util_avg, max), max);
+		cpufreq_update_util(rq_clock(rq));
 	}
 }
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -183,6 +183,7 @@ static inline int dl_bandwidth_enabled(v
 }
 
 extern struct dl_bw *dl_bw_of(int i);
+extern int dl_bw_cpus(int i);
 
 struct dl_bw {
 	raw_spinlock_t lock;
@@ -1808,13 +1809,13 @@ DECLARE_PER_CPU(struct update_util_data
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
@@ -1835,10 +1836,10 @@ static inline void cpufreq_update_util(u
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
 
