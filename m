From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Don't send callback pointer to cpufreq_add_update_util_hook()
Date: Thu, 17 Aug 2017 17:34:48 +0530
Message-ID: <fb914a5aef386f7c3ae6ea5ed53e1fc299f47869.1502971486.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The callers already have the structure (struct update_util_data) where
the function pointer is saved by cpufreq_add_update_util_hook(). And its
better if the callers fill it themselves, as they can do it from the
governor->init() callback then, which is called only once per policy
lifetime rather than doing it from governor->start which can get called
multiple times.

Note that the schedutil governor isn't updated (for now) to fill
update_util.func from the governor->init() callback as its
governor->start() callback is doing memset(sg_cpu, 0, ...) which will
overwrite the update_util.func.

Tested on ARM Hikey board with Ondemand and Schedutil governors.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c |  4 ++--
 drivers/cpufreq/intel_pstate.c     |  4 ++--
 include/linux/sched/cpufreq.h      |  4 +---
 kernel/sched/cpufreq.c             | 19 +++++++------------
 kernel/sched/cpufreq_schedutil.c   | 10 ++++++----
 5 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 58d4f4e1ad6a..4d48e20720fa 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -330,8 +330,7 @@ static void gov_set_update_util(struct policy_dbs_info *policy_dbs,
 	for_each_cpu(cpu, policy->cpus) {
 		struct cpu_dbs_info *cdbs = &per_cpu(cpu_dbs, cpu);
 
-		cpufreq_add_update_util_hook(cpu, &cdbs->update_util,
-					     dbs_update_util_handler);
+		cpufreq_add_update_util_hook(cpu, &cdbs->update_util);
 	}
 }
 
@@ -367,6 +366,7 @@ static struct policy_dbs_info *alloc_policy_dbs_info(struct cpufreq_policy *poli
 		struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
 
 		j_cdbs->policy_dbs = policy_dbs;
+		j_cdbs->update_util.func = dbs_update_util_handler;
 	}
 	return policy_dbs;
 }
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 79452ea83ea1..6b9cfc2d9a5e 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1696,8 +1696,8 @@ static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
 
 	/* Prevent intel_pstate_update_util() from using stale data. */
 	cpu->sample.time = 0;
-	cpufreq_add_update_util_hook(cpu_num, &cpu->update_util,
-				     intel_pstate_update_util);
+	cpu->update_util.func = intel_pstate_update_util;
+	cpufreq_add_update_util_hook(cpu_num, &cpu->update_util);
 	cpu->update_util_set = true;
 }
 
diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index d2be2ccbb372..4e9fa512ae95 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -18,9 +18,7 @@ struct update_util_data {
        void (*func)(struct update_util_data *data, u64 time, unsigned int flags);
 };
 
-void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
-                       void (*func)(struct update_util_data *data, u64 time,
-				    unsigned int flags));
+void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data);
 void cpufreq_remove_update_util_hook(int cpu);
 #endif /* CONFIG_CPU_FREQ */
 
diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index dbc51442ecbc..853987a5775b 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -17,31 +17,26 @@ DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
  * cpufreq_add_update_util_hook - Populate the CPU's update_util_data pointer.
  * @cpu: The CPU to set the pointer for.
  * @data: New pointer value.
- * @func: Callback function to set for the CPU.
  *
  * Set and publish the update_util_data pointer for the given CPU.
  *
- * The update_util_data pointer of @cpu is set to @data and the callback
- * function pointer in the target struct update_util_data is set to @func.
- * That function will be called by cpufreq_update_util() from RCU-sched
- * read-side critical sections, so it must not sleep.  @data will always be
- * passed to it as the first argument which allows the function to get to the
- * target update_util_data structure and its container.
+ * The update_util_data pointer of @cpu is set to @data.  The data->func
+ * function will be called by cpufreq_update_util() from RCU-sched read-side
+ * critical sections, so it must not sleep.  @data will always be passed to it
+ * as the first argument which allows the function to get to the target
+ * update_util_data structure and its container.
  *
  * The update_util_data pointer of @cpu must be NULL when this function is
  * called or it will WARN() and return with no effect.
  */
-void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
-			void (*func)(struct update_util_data *data, u64 time,
-				     unsigned int flags))
+void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data)
 {
-	if (WARN_ON(!data || !func))
+	if (WARN_ON(!data || !data->func))
 		return;
 
 	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
 		return;
 
-	data->func = func;
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
 }
 EXPORT_SYMBOL_GPL(cpufreq_add_update_util_hook);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 2e74c49776be..0baa7a787cd5 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -643,15 +643,17 @@ static int sugov_start(struct cpufreq_policy *policy)
 		sg_cpu->sg_policy = sg_policy;
 		sg_cpu->flags = SCHED_CPUFREQ_RT;
 		sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
+
+		if (policy_is_shared(policy))
+			sg_cpu->update_util.func = sugov_update_shared;
+		else
+			sg_cpu->update_util.func = sugov_update_single;
 	}
 
 	for_each_cpu(cpu, policy->cpus) {
 		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
 
-		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
-					     policy_is_shared(policy) ?
-							sugov_update_shared :
-							sugov_update_single);
+		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util);
 	}
 	return 0;
 }
-- 
2.14.1.202.g24db08a6e8fe
