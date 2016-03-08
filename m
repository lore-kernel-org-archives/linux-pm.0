From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 1/7][Resend] cpufreq: Rework the scheduler hooks for triggering updates
Date: Tue, 08 Mar 2016 03:25:16 +0100
Message-ID: <7541372.ciUW4go8Ux@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <2409306.qzzMXcm4dm@vostro.rjw.lan> <4088601.C2vItRYpQn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43083 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753721AbcCHCxA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2016 21:53:00 -0500
In-Reply-To: <4088601.C2vItRYpQn@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit fe7034338ba0 (cpufreq: Add mechanism for registering
utilization update callbacks) added cpufreq_update_util() to be
called by the scheduler (from the CFS part) on utilization updates.
The goal was to allow CFS to pass utilization information to cpufreq
and to trigger it to evaluate the frequency/voltage configuration
(P-state) of every CPU on a regular basis.

However, the last two arguments of that function are never used by
the current code, so CFS might simply call cpufreq_trigger_update()
instead of it (like the RT and DL sched classes).

For this reason, drop the last two arguments of cpufreq_update_util(),
rename it to cpufreq_trigger_update() and modify CFS to call it.

Moreover, since the utilization is not involved in that now, rename
data types, functions and variables related to cpufreq_trigger_update()
to reflect that (eg. struct update_util_data becomes struct
freq_update_hook and so on).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

No changes from v2.

---
 drivers/cpufreq/cpufreq.c          |   52 +++++++++++++++++++++----------------
 drivers/cpufreq/cpufreq_governor.c |   25 ++++++++---------
 drivers/cpufreq/cpufreq_governor.h |    2 -
 drivers/cpufreq/intel_pstate.c     |   15 ++++------
 include/linux/cpufreq.h            |   32 ++--------------------
 kernel/sched/deadline.c            |    2 -
 kernel/sched/fair.c                |   13 +--------
 kernel/sched/rt.c                  |    2 -
 8 files changed, 58 insertions(+), 85 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -65,57 +65,65 @@ static struct cpufreq_driver *cpufreq_dr
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 
-static DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+static DEFINE_PER_CPU(struct freq_update_hook *, cpufreq_freq_update_hook);
 
 /**
- * cpufreq_set_update_util_data - Populate the CPU's update_util_data pointer.
+ * cpufreq_set_freq_update_hook - Populate the CPU's freq_update_hook pointer.
  * @cpu: The CPU to set the pointer for.
- * @data: New pointer value.
+ * @hook: New pointer value.
  *
- * Set and publish the update_util_data pointer for the given CPU.  That pointer
- * points to a struct update_util_data object containing a callback function
- * to call from cpufreq_update_util().  That function will be called from an RCU
- * read-side critical section, so it must not sleep.
+ * Set and publish the freq_update_hook pointer for the given CPU.  That pointer
+ * points to a struct freq_update_hook object containing a callback function
+ * to call from cpufreq_trigger_update().  That function will be called from
+ * an RCU read-side critical section, so it must not sleep.
  *
  * Callers must use RCU-sched callbacks to free any memory that might be
  * accessed via the old update_util_data pointer or invoke synchronize_sched()
  * right after this function to avoid use-after-free.
  */
-void cpufreq_set_update_util_data(int cpu, struct update_util_data *data)
+void cpufreq_set_freq_update_hook(int cpu, struct freq_update_hook *hook)
 {
-	if (WARN_ON(data && !data->func))
+	if (WARN_ON(hook && !hook->func))
 		return;
 
-	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
+	rcu_assign_pointer(per_cpu(cpufreq_freq_update_hook, cpu), hook);
 }
-EXPORT_SYMBOL_GPL(cpufreq_set_update_util_data);
+EXPORT_SYMBOL_GPL(cpufreq_set_freq_update_hook);
 
 /**
- * cpufreq_update_util - Take a note about CPU utilization changes.
+ * cpufreq_trigger_update - Trigger CPU performance state evaluation if needed.
  * @time: Current time.
- * @util: Current utilization.
- * @max: Utilization ceiling.
  *
- * This function is called by the scheduler on every invocation of
- * update_load_avg() on the CPU whose utilization is being updated.
+ * The way cpufreq is currently arranged requires it to evaluate the CPU
+ * performance state (frequency/voltage) on a regular basis.  To facilitate
+ * that, this function is called by update_load_avg() in CFS when executed for
+ * the current CPU's runqueue.
  *
- * It can only be called from RCU-sched read-side critical sections.
+ * However, this isn't sufficient to prevent the CPU from being stuck in a
+ * completely inadequate performance level for too long, because the calls
+ * from CFS will not be made if RT or deadline tasks are active all the time
+ * (or there are RT and DL tasks only).
+ *
+ * As a workaround for that issue, this function is called by the RT and DL
+ * sched classes to trigger extra cpufreq updates to prevent it from stalling,
+ * but that really is a band-aid.  Going forward it should be replaced with
+ * solutions targeted more specifically at RT and DL tasks.
  */
-void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
+void cpufreq_trigger_update(u64 time)
 {
-	struct update_util_data *data;
+	struct freq_update_hook *hook;
 
 #ifdef CONFIG_LOCKDEP
 	WARN_ON(debug_locks && !rcu_read_lock_sched_held());
 #endif
 
-	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
+	hook = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_freq_update_hook));
 	/*
 	 * If this isn't inside of an RCU-sched read-side critical section, data
 	 * may become NULL after the check below.
 	 */
-	if (data)
-		data->func(data, time, util, max);
+	if (hook)
+		hook->func(hook, time);
 }
 
 /* Flag to suspend/resume CPUFreq governors */
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -146,35 +146,13 @@ static inline bool policy_is_shared(stru
 extern struct kobject *cpufreq_global_kobject;
 
 #ifdef CONFIG_CPU_FREQ
-void cpufreq_update_util(u64 time, unsigned long util, unsigned long max);
+void cpufreq_trigger_update(u64 time);
 
-/**
- * cpufreq_trigger_update - Trigger CPU performance state evaluation if needed.
- * @time: Current time.
- *
- * The way cpufreq is currently arranged requires it to evaluate the CPU
- * performance state (frequency/voltage) on a regular basis to prevent it from
- * being stuck in a completely inadequate performance level for too long.
- * That is not guaranteed to happen if the updates are only triggered from CFS,
- * though, because they may not be coming in if RT or deadline tasks are active
- * all the time (or there are RT and DL tasks only).
- *
- * As a workaround for that issue, this function is called by the RT and DL
- * sched classes to trigger extra cpufreq updates to prevent it from stalling,
- * but that really is a band-aid.  Going forward it should be replaced with
- * solutions targeted more specifically at RT and DL tasks.
- */
-static inline void cpufreq_trigger_update(u64 time)
-{
-	cpufreq_update_util(time, ULONG_MAX, 0);
-}
-
-struct update_util_data {
-	void (*func)(struct update_util_data *data,
-		     u64 time, unsigned long util, unsigned long max);
+struct freq_update_hook {
+	void (*func)(struct freq_update_hook *hook, u64 time);
 };
 
-void cpufreq_set_update_util_data(int cpu, struct update_util_data *data);
+void cpufreq_set_freq_update_hook(int cpu, struct freq_update_hook *hook);
 
 unsigned int cpufreq_get(unsigned int cpu);
 unsigned int cpufreq_quick_get(unsigned int cpu);
@@ -187,8 +165,6 @@ int cpufreq_update_policy(unsigned int c
 bool have_governor_per_policy(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 #else
-static inline void cpufreq_update_util(u64 time, unsigned long util,
-				       unsigned long max) {}
 static inline void cpufreq_trigger_update(u64 time) {}
 
 static inline unsigned int cpufreq_get(unsigned int cpu)
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -62,10 +62,10 @@ ssize_t store_sampling_rate(struct dbs_d
 		mutex_lock(&policy_dbs->timer_mutex);
 		/*
 		 * On 32-bit architectures this may race with the
-		 * sample_delay_ns read in dbs_update_util_handler(), but that
+		 * sample_delay_ns read in dbs_freq_update_handler(), but that
 		 * really doesn't matter.  If the read returns a value that's
 		 * too big, the sample will be skipped, but the next invocation
-		 * of dbs_update_util_handler() (when the update has been
+		 * of dbs_freq_update_handler() (when the update has been
 		 * completed) will take a sample.
 		 *
 		 * If this runs in parallel with dbs_work_handler(), we may end
@@ -257,7 +257,7 @@ unsigned int dbs_update(struct cpufreq_p
 }
 EXPORT_SYMBOL_GPL(dbs_update);
 
-static void gov_set_update_util(struct policy_dbs_info *policy_dbs,
+static void gov_set_freq_update_hooks(struct policy_dbs_info *policy_dbs,
 				unsigned int delay_us)
 {
 	struct cpufreq_policy *policy = policy_dbs->policy;
@@ -269,16 +269,16 @@ static void gov_set_update_util(struct p
 	for_each_cpu(cpu, policy->cpus) {
 		struct cpu_dbs_info *cdbs = &per_cpu(cpu_dbs, cpu);
 
-		cpufreq_set_update_util_data(cpu, &cdbs->update_util);
+		cpufreq_set_freq_update_hook(cpu, &cdbs->update_hook);
 	}
 }
 
-static inline void gov_clear_update_util(struct cpufreq_policy *policy)
+static inline void gov_clear_freq_update_hooks(struct cpufreq_policy *policy)
 {
 	int i;
 
 	for_each_cpu(i, policy->cpus)
-		cpufreq_set_update_util_data(i, NULL);
+		cpufreq_set_freq_update_hook(i, NULL);
 
 	synchronize_sched();
 }
@@ -287,7 +287,7 @@ static void gov_cancel_work(struct cpufr
 {
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 
-	gov_clear_update_util(policy_dbs->policy);
+	gov_clear_freq_update_hooks(policy_dbs->policy);
 	irq_work_sync(&policy_dbs->irq_work);
 	cancel_work_sync(&policy_dbs->work);
 	atomic_set(&policy_dbs->work_count, 0);
@@ -331,10 +331,9 @@ static void dbs_irq_work(struct irq_work
 	schedule_work(&policy_dbs->work);
 }
 
-static void dbs_update_util_handler(struct update_util_data *data, u64 time,
-				    unsigned long util, unsigned long max)
+static void dbs_freq_update_handler(struct freq_update_hook *hook, u64 time)
 {
-	struct cpu_dbs_info *cdbs = container_of(data, struct cpu_dbs_info, update_util);
+	struct cpu_dbs_info *cdbs = container_of(hook, struct cpu_dbs_info, update_hook);
 	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
 	u64 delta_ns, lst;
 
@@ -403,7 +402,7 @@ static struct policy_dbs_info *alloc_pol
 		struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
 
 		j_cdbs->policy_dbs = policy_dbs;
-		j_cdbs->update_util.func = dbs_update_util_handler;
+		j_cdbs->update_hook.func = dbs_freq_update_handler;
 	}
 	return policy_dbs;
 }
@@ -419,7 +418,7 @@ static void free_policy_dbs_info(struct
 		struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
 
 		j_cdbs->policy_dbs = NULL;
-		j_cdbs->update_util.func = NULL;
+		j_cdbs->update_hook.func = NULL;
 	}
 	gov->free(policy_dbs);
 }
@@ -586,7 +585,7 @@ static int cpufreq_governor_start(struct
 
 	gov->start(policy);
 
-	gov_set_update_util(policy_dbs, sampling_rate);
+	gov_set_freq_update_hooks(policy_dbs, sampling_rate);
 	return 0;
 }
 
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -144,7 +144,7 @@ struct cpu_dbs_info {
 	 * wake-up from idle.
 	 */
 	unsigned int prev_load;
-	struct update_util_data update_util;
+	struct freq_update_hook update_hook;
 	struct policy_dbs_info *policy_dbs;
 };
 
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -103,7 +103,7 @@ struct _pid {
 struct cpudata {
 	int cpu;
 
-	struct update_util_data update_util;
+	struct freq_update_hook update_hook;
 
 	struct pstate_data pstate;
 	struct vid_data vid;
@@ -1019,10 +1019,9 @@ static inline void intel_pstate_adjust_b
 		sample->freq);
 }
 
-static void intel_pstate_update_util(struct update_util_data *data, u64 time,
-				     unsigned long util, unsigned long max)
+static void intel_pstate_freq_update(struct freq_update_hook *hook, u64 time)
 {
-	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
+	struct cpudata *cpu = container_of(hook, struct cpudata, update_hook);
 	u64 delta_ns = time - cpu->sample.time;
 
 	if ((s64)delta_ns >= pid_params.sample_rate_ns) {
@@ -1088,8 +1087,8 @@ static int intel_pstate_init_cpu(unsigne
 	intel_pstate_busy_pid_reset(cpu);
 	intel_pstate_sample(cpu, 0);
 
-	cpu->update_util.func = intel_pstate_update_util;
-	cpufreq_set_update_util_data(cpunum, &cpu->update_util);
+	cpu->update_hook.func = intel_pstate_freq_update;
+	cpufreq_set_freq_update_hook(cpunum, &cpu->update_hook);
 
 	pr_debug("intel_pstate: controlling: cpu %d\n", cpunum);
 
@@ -1173,7 +1172,7 @@ static void intel_pstate_stop_cpu(struct
 
 	pr_debug("intel_pstate: CPU %d exiting\n", cpu_num);
 
-	cpufreq_set_update_util_data(cpu_num, NULL);
+	cpufreq_set_freq_update_hook(cpu_num, NULL);
 	synchronize_sched();
 
 	if (hwp_active)
@@ -1441,7 +1440,7 @@ out:
 	get_online_cpus();
 	for_each_online_cpu(cpu) {
 		if (all_cpu_data[cpu]) {
-			cpufreq_set_update_util_data(cpu, NULL);
+			cpufreq_set_freq_update_hook(cpu, NULL);
 			synchronize_sched();
 			kfree(all_cpu_data[cpu]);
 		}
Index: linux-pm/kernel/sched/fair.c
===================================================================
--- linux-pm.orig/kernel/sched/fair.c
+++ linux-pm/kernel/sched/fair.c
@@ -2839,8 +2839,6 @@ static inline void update_load_avg(struc
 		update_tg_load_avg(cfs_rq, 0);
 
 	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
-		unsigned long max = rq->cpu_capacity_orig;
-
 		/*
 		 * There are a few boundary cases this might miss but it should
 		 * get called often enough that that should (hopefully) not be
@@ -2849,16 +2847,9 @@ static inline void update_load_avg(struc
 		 * the next tick/schedule should update.
 		 *
 		 * It will not get called when we go idle, because the idle
-		 * thread is a different class (!fair), nor will the utilization
-		 * number include things like RT tasks.
-		 *
-		 * As is, the util number is not freq-invariant (we'd have to
-		 * implement arch_scale_freq_capacity() for that).
-		 *
-		 * See cpu_util().
+		 * thread is a different class (!fair).
 		 */
-		cpufreq_update_util(rq_clock(rq),
-				    min(cfs_rq->avg.util_avg, max), max);
+		cpufreq_trigger_update(rq_clock(rq));
 	}
 }
 
Index: linux-pm/kernel/sched/deadline.c
===================================================================
--- linux-pm.orig/kernel/sched/deadline.c
+++ linux-pm/kernel/sched/deadline.c
@@ -726,7 +726,7 @@ static void update_curr_dl(struct rq *rq
 	if (!dl_task(curr) || !on_dl_rq(dl_se))
 		return;
 
-	/* Kick cpufreq (see the comment in linux/cpufreq.h). */
+	/* Kick cpufreq (see the comment in drivers/cpufreq/cpufreq.c). */
 	if (cpu_of(rq) == smp_processor_id())
 		cpufreq_trigger_update(rq_clock(rq));
 
Index: linux-pm/kernel/sched/rt.c
===================================================================
--- linux-pm.orig/kernel/sched/rt.c
+++ linux-pm/kernel/sched/rt.c
@@ -945,7 +945,7 @@ static void update_curr_rt(struct rq *rq
 	if (curr->sched_class != &rt_sched_class)
 		return;
 
-	/* Kick cpufreq (see the comment in linux/cpufreq.h). */
+	/* Kick cpufreq (see the comment in drivers/cpufreq/cpufreq.c). */
 	if (cpu_of(rq) == smp_processor_id())
 		cpufreq_trigger_update(rq_clock(rq));
 

