From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 9/10] cpufreq: sched: Re-introduce cpufreq_update_util()
Date: Fri, 04 Mar 2016 14:30:43 +0100
Message-ID: <2165535.KMoOuEkF5Y@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <2409306.qzzMXcm4dm@vostro.rjw.lan> <3276406.TfbasUEj6b@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3276406.TfbasUEj6b@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

A subsequent change set will introduce a new cpufreq governor using
CPU utilization information from the scheduler, so introduce
cpufreq_update_util() (again) to allow that information to be passed to
the new governor and make cpufreq_trigger_update() call it internally.

To that end, add a new ->update_util callback pointer to struct
freq_update_hook to be set by entities that want to use the util
and max arguments and make cpufreq_update_util() use that callback
if available or the ->func callback that only takes the time argument
otherwise.

In addition to that, arrange helpers to set/clear the utilization
update hooks in such a way that the full ->update_util callbacks
can only be set by code inside the kernel/sched/ directory.

Update the current users of cpufreq_set_freq_update_hook() to use
the new helpers.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes from v2:
- Use rcu_dereference_sched() in cpufreq_update_util().

---
 drivers/cpufreq/cpufreq_governor.c |   76 +++++++++++++--------------
 drivers/cpufreq/intel_pstate.c     |    8 +-
 include/linux/sched.h              |   10 +--
 kernel/sched/cpufreq.c             |  101 +++++++++++++++++++++++++++++--------
 kernel/sched/fair.c                |    8 ++
 kernel/sched/sched.h               |   16 +++++
 6 files changed, 150 insertions(+), 69 deletions(-)

Index: linux-pm/include/linux/sched.h
===================================================================
--- linux-pm.orig/include/linux/sched.h
+++ linux-pm/include/linux/sched.h
@@ -2363,15 +2363,15 @@ static inline bool sched_can_stop_tick(v
 #endif
 
 #ifdef CONFIG_CPU_FREQ
-void cpufreq_trigger_update(u64 time);
-
 struct freq_update_hook {
 	void (*func)(struct freq_update_hook *hook, u64 time);
+	void (*update_util)(struct freq_update_hook *hook, u64 time,
+			    unsigned long util, unsigned long max);
 };
 
-void cpufreq_set_freq_update_hook(int cpu, struct freq_update_hook *hook);
-#else
-static inline void cpufreq_trigger_update(u64 time) {}
+void cpufreq_set_freq_update_hook(int cpu, struct freq_update_hook *hook,
+			void (*func)(struct freq_update_hook *hook, u64 time));
+void cpufreq_clear_freq_update_hook(int cpu);
 #endif
 
 #ifdef CONFIG_SCHED_AUTOGROUP
Index: linux-pm/kernel/sched/cpufreq.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq.c
+++ linux-pm/kernel/sched/cpufreq.c
@@ -9,12 +9,12 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/sched.h>
+#include "sched.h"
 
 static DEFINE_PER_CPU(struct freq_update_hook *, cpufreq_freq_update_hook);
 
 /**
- * cpufreq_set_freq_update_hook - Populate the CPU's freq_update_hook pointer.
+ * set_freq_update_hook - Populate the CPU's freq_update_hook pointer.
  * @cpu: The CPU to set the pointer for.
  * @hook: New pointer value.
  *
@@ -27,23 +27,96 @@ static DEFINE_PER_CPU(struct freq_update
  * accessed via the old update_util_data pointer or invoke synchronize_sched()
  * right after this function to avoid use-after-free.
  */
-void cpufreq_set_freq_update_hook(int cpu, struct freq_update_hook *hook)
+static void set_freq_update_hook(int cpu, struct freq_update_hook *hook)
 {
-	if (WARN_ON(hook && !hook->func))
+	rcu_assign_pointer(per_cpu(cpufreq_freq_update_hook, cpu), hook);
+}
+
+/**
+ * cpufreq_set_freq_update_hook - Set the CPU's frequency update callback.
+ * @cpu: The CPU to set the callback for.
+ * @hook: New freq_update_hook pointer value.
+ * @func: Callback function to use with the new hook.
+ */
+void cpufreq_set_freq_update_hook(int cpu, struct freq_update_hook *hook,
+			void (*func)(struct freq_update_hook *hook, u64 time))
+{
+	if (WARN_ON(!hook || !func))
 		return;
 
-	rcu_assign_pointer(per_cpu(cpufreq_freq_update_hook, cpu), hook);
+	hook->func = func;
+	set_freq_update_hook(cpu, hook);
 }
 EXPORT_SYMBOL_GPL(cpufreq_set_freq_update_hook);
 
 /**
+ * cpufreq_set_update_util_hook - Set the CPU's utilization update callback.
+ * @cpu: The CPU to set the callback for.
+ * @hook: New freq_update_hook pointer value.
+ * @update_util: Callback function to use with the new hook.
+ */
+void cpufreq_set_update_util_hook(int cpu, struct freq_update_hook *hook,
+		void (*update_util)(struct freq_update_hook *hook, u64 time,
+				    unsigned long util, unsigned long max))
+{
+	if (WARN_ON(!hook || !update_util))
+		return;
+
+	hook->update_util = update_util;
+	set_freq_update_hook(cpu, hook);
+}
+EXPORT_SYMBOL_GPL(cpufreq_set_update_util_hook);
+
+/**
+ * cpufreq_set_update_util_hook - Clear the CPU's freq_update_hook pointer.
+ * @cpu: The CPU to clear the pointer for.
+ */
+void cpufreq_clear_freq_update_hook(int cpu)
+{
+	set_freq_update_hook(cpu, NULL);
+}
+EXPORT_SYMBOL_GPL(cpufreq_clear_freq_update_hook);
+
+/**
+ * cpufreq_update_util - Take a note about CPU utilization changes.
+ * @time: Current time.
+ * @util: CPU utilization.
+ * @max: CPU capacity.
+ *
+ * This function is called on every invocation of update_load_avg() on the CPU
+ * whose utilization is being updated.
+ *
+ * It can only be called from RCU-sched read-side critical sections.
+ */
+void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
+{
+	struct freq_update_hook *hook;
+
+#ifdef CONFIG_LOCKDEP
+	WARN_ON(debug_locks && !rcu_read_lock_sched_held());
+#endif
+
+	hook = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_freq_update_hook));
+	/*
+	 * If this isn't inside of an RCU-sched read-side critical section, hook
+	 * may become NULL after the check below.
+	 */
+	if (hook) {
+		if (hook->update_util)
+			hook->update_util(hook, time, util, max);
+		else
+			hook->func(hook, time);
+	}
+}
+
+/**
  * cpufreq_trigger_update - Trigger CPU performance state evaluation if needed.
  * @time: Current time.
  *
  * The way cpufreq is currently arranged requires it to evaluate the CPU
  * performance state (frequency/voltage) on a regular basis.  To facilitate
- * that, this function is called by update_load_avg() in CFS when executed for
- * the current CPU's runqueue.
+ * that, cpufreq_update_util() is called by update_load_avg() in CFS when
+ * executed for the current CPU's runqueue.
  *
  * However, this isn't sufficient to prevent the CPU from being stuck in a
  * completely inadequate performance level for too long, because the calls
@@ -57,17 +130,5 @@ EXPORT_SYMBOL_GPL(cpufreq_set_freq_updat
  */
 void cpufreq_trigger_update(u64 time)
 {
-	struct freq_update_hook *hook;
-
-#ifdef CONFIG_LOCKDEP
-	WARN_ON(debug_locks && !rcu_read_lock_sched_held());
-#endif
-
-	hook = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_freq_update_hook));
-	/*
-	 * If this isn't inside of an RCU-sched read-side critical section, hook
-	 * may become NULL after the check below.
-	 */
-	if (hook)
-		hook->func(hook, time);
+	cpufreq_update_util(time, ULONG_MAX, 0);
 }
Index: linux-pm/kernel/sched/fair.c
===================================================================
--- linux-pm.orig/kernel/sched/fair.c
+++ linux-pm/kernel/sched/fair.c
@@ -2839,6 +2839,8 @@ static inline void update_load_avg(struc
 		update_tg_load_avg(cfs_rq, 0);
 
 	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
+		unsigned long max = rq->cpu_capacity_orig;
+
 		/*
 		 * There are a few boundary cases this might miss but it should
 		 * get called often enough that that should (hopefully) not be
@@ -2847,9 +2849,11 @@ static inline void update_load_avg(struc
 		 * the next tick/schedule should update.
 		 *
 		 * It will not get called when we go idle, because the idle
-		 * thread is a different class (!fair).
+		 * thread is a different class (!fair), nor will the utilization
+-		 * number include things like RT tasks.
 		 */
-		cpufreq_trigger_update(rq_clock(rq));
+		cpufreq_update_util(rq_clock(rq),
+				    min(cfs_rq->avg.util_avg, max), max);
 	}
 }
 
Index: linux-pm/kernel/sched/sched.h
===================================================================
--- linux-pm.orig/kernel/sched/sched.h
+++ linux-pm/kernel/sched/sched.h
@@ -1739,3 +1739,19 @@ static inline u64 irq_time_read(int cpu)
 }
 #endif /* CONFIG_64BIT */
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
+
+#ifdef CONFIG_CPU_FREQ
+void cpufreq_update_util(u64 time, unsigned long util, unsigned long max);
+void cpufreq_trigger_update(u64 time);
+void cpufreq_set_update_util_hook(int cpu, struct freq_update_hook *hook,
+		void (*update_util)(struct freq_update_hook *hook, u64 time,
+				    unsigned long util, unsigned long max));
+static inline void cpufreq_clear_update_util_hook(int cpu)
+{
+	cpufreq_clear_freq_update_hook(cpu);
+}
+#else
+static inline void cpufreq_update_util(u64 time, unsigned long util,
+				       unsigned long max) {}
+static inline void cpufreq_trigger_update(u64 time) {}
+#endif /* CONFIG_CPU_FREQ */
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1088,8 +1088,8 @@ static int intel_pstate_init_cpu(unsigne
 	intel_pstate_busy_pid_reset(cpu);
 	intel_pstate_sample(cpu, 0);
 
-	cpu->update_hook.func = intel_pstate_freq_update;
-	cpufreq_set_freq_update_hook(cpunum, &cpu->update_hook);
+	cpufreq_set_freq_update_hook(cpunum, &cpu->update_hook,
+				     intel_pstate_freq_update );
 
 	pr_debug("intel_pstate: controlling: cpu %d\n", cpunum);
 
@@ -1173,7 +1173,7 @@ static void intel_pstate_stop_cpu(struct
 
 	pr_debug("intel_pstate: CPU %d exiting\n", cpu_num);
 
-	cpufreq_set_freq_update_hook(cpu_num, NULL);
+	cpufreq_clear_freq_update_hook(cpu_num);
 	synchronize_sched();
 
 	if (hwp_active)
@@ -1441,7 +1441,7 @@ out:
 	get_online_cpus();
 	for_each_online_cpu(cpu) {
 		if (all_cpu_data[cpu]) {
-			cpufreq_set_freq_update_hook(cpu, NULL);
+			cpufreq_clear_freq_update_hook(cpu);
 			synchronize_sched();
 			kfree(all_cpu_data[cpu]);
 		}
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -211,43 +211,6 @@ unsigned int dbs_update(struct cpufreq_p
 }
 EXPORT_SYMBOL_GPL(dbs_update);
 
-static void gov_set_freq_update_hooks(struct policy_dbs_info *policy_dbs,
-				unsigned int delay_us)
-{
-	struct cpufreq_policy *policy = policy_dbs->policy;
-	int cpu;
-
-	gov_update_sample_delay(policy_dbs, delay_us);
-	policy_dbs->last_sample_time = 0;
-
-	for_each_cpu(cpu, policy->cpus) {
-		struct cpu_dbs_info *cdbs = &per_cpu(cpu_dbs, cpu);
-
-		cpufreq_set_freq_update_hook(cpu, &cdbs->update_hook);
-	}
-}
-
-static inline void gov_clear_freq_update_hooks(struct cpufreq_policy *policy)
-{
-	int i;
-
-	for_each_cpu(i, policy->cpus)
-		cpufreq_set_freq_update_hook(i, NULL);
-
-	synchronize_sched();
-}
-
-static void gov_cancel_work(struct cpufreq_policy *policy)
-{
-	struct policy_dbs_info *policy_dbs = policy->governor_data;
-
-	gov_clear_freq_update_hooks(policy_dbs->policy);
-	irq_work_sync(&policy_dbs->irq_work);
-	cancel_work_sync(&policy_dbs->work);
-	atomic_set(&policy_dbs->work_count, 0);
-	policy_dbs->work_in_progress = false;
-}
-
 static void dbs_work_handler(struct work_struct *work)
 {
 	struct policy_dbs_info *policy_dbs;
@@ -334,6 +297,44 @@ static void dbs_freq_update_handler(stru
 	irq_work_queue(&policy_dbs->irq_work);
 }
 
+static void gov_set_freq_update_hooks(struct policy_dbs_info *policy_dbs,
+				unsigned int delay_us)
+{
+	struct cpufreq_policy *policy = policy_dbs->policy;
+	int cpu;
+
+	gov_update_sample_delay(policy_dbs, delay_us);
+	policy_dbs->last_sample_time = 0;
+
+	for_each_cpu(cpu, policy->cpus) {
+		struct cpu_dbs_info *cdbs = &per_cpu(cpu_dbs, cpu);
+
+		cpufreq_set_freq_update_hook(cpu, &cdbs->update_hook,
+					     dbs_freq_update_handler);
+	}
+}
+
+static inline void gov_clear_freq_update_hooks(struct cpufreq_policy *policy)
+{
+	int i;
+
+	for_each_cpu(i, policy->cpus)
+		cpufreq_clear_freq_update_hook(i);
+
+	synchronize_sched();
+}
+
+static void gov_cancel_work(struct cpufreq_policy *policy)
+{
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+
+	gov_clear_freq_update_hooks(policy_dbs->policy);
+	irq_work_sync(&policy_dbs->irq_work);
+	cancel_work_sync(&policy_dbs->work);
+	atomic_set(&policy_dbs->work_count, 0);
+	policy_dbs->work_in_progress = false;
+}
+
 static struct policy_dbs_info *alloc_policy_dbs_info(struct cpufreq_policy *policy,
 						     struct dbs_governor *gov)
 {
@@ -356,7 +357,6 @@ static struct policy_dbs_info *alloc_pol
 		struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
 
 		j_cdbs->policy_dbs = policy_dbs;
-		j_cdbs->update_hook.func = dbs_freq_update_handler;
 	}
 	return policy_dbs;
 }

