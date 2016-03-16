From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v4 1/7] cpufreq: sched: Helpers to add and remove update_util hooks
Date: Wed, 16 Mar 2016 15:43:27 +0100
Message-ID: <32416894.5bqRvzUIYW@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <4088601.C2vItRYpQn@vostro.rjw.lan> <1711281.bPmSjlBT7c@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43354 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S966521AbcCPO74 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 10:59:56 -0400
In-Reply-To: <1711281.bPmSjlBT7c@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the single helper for adding and removing cpufreq utilization
update hooks, cpufreq_set_update_util_data(), with a pair of helpers,
cpufreq_add_update_util_hook() and cpufreq_remove_update_util_hook(),
and modify the users of cpufreq_set_update_util_data() accordingly.

With the new helpers, the code using them doesn't need to worry
about the internals of struct update_util_data and in particular
it doesn't need to worry about populating the func field in it
properly upfront.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch.

---
 drivers/cpufreq/cpufreq_governor.c |   76 ++++++++++++++++++-------------------
 drivers/cpufreq/intel_pstate.c     |    8 +--
 include/linux/sched.h              |    5 +-
 kernel/sched/cpufreq.c             |   48 ++++++++++++++++++-----
 4 files changed, 83 insertions(+), 54 deletions(-)

Index: linux-pm/include/linux/sched.h
===================================================================
--- linux-pm.orig/include/linux/sched.h
+++ linux-pm/include/linux/sched.h
@@ -3213,7 +3213,10 @@ struct update_util_data {
 		     u64 time, unsigned long util, unsigned long max);
 };
 
-void cpufreq_set_update_util_data(int cpu, struct update_util_data *data);
+void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
+			void (*func)(struct update_util_data *data, u64 time,
+				     unsigned long util, unsigned long max));
+void cpufreq_remove_update_util_hook(int cpu);
 #endif /* CONFIG_CPU_FREQ */
 
 #endif
Index: linux-pm/kernel/sched/cpufreq.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq.c
+++ linux-pm/kernel/sched/cpufreq.c
@@ -14,24 +14,50 @@
 DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
 
 /**
- * cpufreq_set_update_util_data - Populate the CPU's update_util_data pointer.
+ * cpufreq_add_update_util_hook - Populate the CPU's update_util_data pointer.
  * @cpu: The CPU to set the pointer for.
  * @data: New pointer value.
+ * @func: Callback function to set for the CPU.
  *
- * Set and publish the update_util_data pointer for the given CPU.  That pointer
- * points to a struct update_util_data object containing a callback function
- * to call from cpufreq_update_util().  That function will be called from an RCU
- * read-side critical section, so it must not sleep.
+ * Set and publish the update_util_data pointer for the given CPU.
  *
- * Callers must use RCU-sched callbacks to free any memory that might be
- * accessed via the old update_util_data pointer or invoke synchronize_sched()
- * right after this function to avoid use-after-free.
+ * The update_util_data pointer of @cpu is set to @data and the callback
+ * function pointer in the target struct update_util_data is set to @func.
+ * That function will be called by cpufreq_update_util() from RCU-sched
+ * read-side critical sections, so it must not sleep.  @data will always be
+ * passed to it as the first argument which allows the function to get to the
+ * target update_util_data structure and its container.
+ *
+ * The update_util_data pointer of @cpu must be NULL when this function is
+ * called or it will WARN() and return with no effect.
  */
-void cpufreq_set_update_util_data(int cpu, struct update_util_data *data)
+void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
+			void (*func)(struct update_util_data *data, u64 time,
+				     unsigned long util, unsigned long max))
 {
-	if (WARN_ON(data && !data->func))
+	if (WARN_ON(!data || !func))
 		return;
 
+	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
+		return;
+
+	data->func = func;
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
 }
-EXPORT_SYMBOL_GPL(cpufreq_set_update_util_data);
+EXPORT_SYMBOL_GPL(cpufreq_add_update_util_hook);
+
+/**
+ * cpufreq_remove_update_util_hook - Clear the CPU's update_util_data pointer.
+ * @cpu: The CPU to clear the pointer for.
+ *
+ * Clear the update_util_data pointer for the given CPU.
+ *
+ * Callers must use RCU-sched callbacks to free any memory that might be
+ * accessed via the old update_util_data pointer or invoke synchronize_sched()
+ * right after this function to avoid use-after-free.
+ */
+void cpufreq_remove_update_util_hook(int cpu)
+{
+	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), NULL);
+}
+EXPORT_SYMBOL_GPL(cpufreq_remove_update_util_hook);
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -258,43 +258,6 @@ unsigned int dbs_update(struct cpufreq_p
 }
 EXPORT_SYMBOL_GPL(dbs_update);
 
-static void gov_set_update_util(struct policy_dbs_info *policy_dbs,
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
-		cpufreq_set_update_util_data(cpu, &cdbs->update_util);
-	}
-}
-
-static inline void gov_clear_update_util(struct cpufreq_policy *policy)
-{
-	int i;
-
-	for_each_cpu(i, policy->cpus)
-		cpufreq_set_update_util_data(i, NULL);
-
-	synchronize_sched();
-}
-
-static void gov_cancel_work(struct cpufreq_policy *policy)
-{
-	struct policy_dbs_info *policy_dbs = policy->governor_data;
-
-	gov_clear_update_util(policy_dbs->policy);
-	irq_work_sync(&policy_dbs->irq_work);
-	cancel_work_sync(&policy_dbs->work);
-	atomic_set(&policy_dbs->work_count, 0);
-	policy_dbs->work_in_progress = false;
-}
-
 static void dbs_work_handler(struct work_struct *work)
 {
 	struct policy_dbs_info *policy_dbs;
@@ -382,6 +345,44 @@ static void dbs_update_util_handler(stru
 	irq_work_queue(&policy_dbs->irq_work);
 }
 
+static void gov_set_update_util(struct policy_dbs_info *policy_dbs,
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
+		cpufreq_add_update_util_hook(cpu, &cdbs->update_util,
+					     dbs_update_util_handler);
+	}
+}
+
+static inline void gov_clear_update_util(struct cpufreq_policy *policy)
+{
+	int i;
+
+	for_each_cpu(i, policy->cpus)
+		cpufreq_remove_update_util_hook(i);
+
+	synchronize_sched();
+}
+
+static void gov_cancel_work(struct cpufreq_policy *policy)
+{
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+
+	gov_clear_update_util(policy_dbs->policy);
+	irq_work_sync(&policy_dbs->irq_work);
+	cancel_work_sync(&policy_dbs->work);
+	atomic_set(&policy_dbs->work_count, 0);
+	policy_dbs->work_in_progress = false;
+}
+
 static struct policy_dbs_info *alloc_policy_dbs_info(struct cpufreq_policy *policy,
 						     struct dbs_governor *gov)
 {
@@ -404,7 +405,6 @@ static struct policy_dbs_info *alloc_pol
 		struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
 
 		j_cdbs->policy_dbs = policy_dbs;
-		j_cdbs->update_util.func = dbs_update_util_handler;
 	}
 	return policy_dbs;
 }
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1089,8 +1089,8 @@ static int intel_pstate_init_cpu(unsigne
 	intel_pstate_busy_pid_reset(cpu);
 	intel_pstate_sample(cpu, 0);
 
-	cpu->update_util.func = intel_pstate_update_util;
-	cpufreq_set_update_util_data(cpunum, &cpu->update_util);
+	cpufreq_add_update_util_hook(cpunum, &cpu->update_util,
+				     intel_pstate_update_util);
 
 	pr_debug("intel_pstate: controlling: cpu %d\n", cpunum);
 
@@ -1174,7 +1174,7 @@ static void intel_pstate_stop_cpu(struct
 
 	pr_debug("intel_pstate: CPU %d exiting\n", cpu_num);
 
-	cpufreq_set_update_util_data(cpu_num, NULL);
+	cpufreq_remove_update_util_hook(cpu_num);
 	synchronize_sched();
 
 	if (hwp_active)
@@ -1442,7 +1442,7 @@ out:
 	get_online_cpus();
 	for_each_online_cpu(cpu) {
 		if (all_cpu_data[cpu]) {
-			cpufreq_set_update_util_data(cpu, NULL);
+			cpufreq_remove_update_util_hook(cpu);
 			synchronize_sched();
 			kfree(all_cpu_data[cpu]);
 		}

