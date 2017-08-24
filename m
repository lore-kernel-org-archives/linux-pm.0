From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFCv4 5/6] cpufreq: schedutil: add util clamp for FAIR tasks
Date: Thu, 24 Aug 2017 19:08:56 +0100
Message-ID: <20170824180857.32103-6-patrick.bellasi@arm.com>
References: <20170824180857.32103-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170824180857.32103-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Each time a frequency update is required via schedutil, we must grant
the util_{min,max} constraints enforced in the current CPU by its set of
currently RUNNABLE tasks.

This patch adds the required support to clamp the utilization generated
by FAIR tasks within the boundaries defined by their aggregated
utilization clamp constraints.
The clamped utilization is then used to select the frequency thus
allowing, for example, to:
 - boost tasks which are directly affecting the user experience
   by running them at least at a minimum "required" frequency
 - cap low priority tasks not directly affecting the user experience
   by running them only up to a maximum "allowed" frequency

The default values for boosting and capping are defined to be:
 - util_min: 0
 - util_max: SCHED_CAPACITY_SCALE
which means that by default no boosting/capping is enforced.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/cpufreq_schedutil.c | 33 ++++++++++++++++++++++
 kernel/sched/sched.h             | 60 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 29a397067ffa..f67c26bbade4 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -231,6 +231,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	} else {
 		sugov_get_util(&util, &max);
 		sugov_iowait_boost(sg_cpu, &util, &max);
+		util = uclamp_util(smp_processor_id(), util);
 		next_f = get_next_freq(sg_policy, util, max);
 		/*
 		 * Do not reduce the frequency if the CPU has not been idle
@@ -246,9 +247,18 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 {
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
+	unsigned long max_util, min_util;
 	unsigned long util = 0, max = 1;
 	unsigned int j;
 
+	/* Initialize clamp values based on caller CPU constraints */
+	if (uclamp_enabled) {
+		int cpu = smp_processor_id();
+
+		max_util = uclamp_value(cpu, UCLAMP_MAX);
+		min_util = uclamp_value(cpu, UCLAMP_MIN);
+	}
+
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
 		unsigned long j_util, j_max;
@@ -277,8 +287,31 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 		}
 
 		sugov_iowait_boost(j_sg_cpu, &util, &max);
+
+		/*
+		 * Update clamping range based on j-CPUs constraints, but only
+		 * if active. Idle CPUs do not enforce constraints in a shared
+		 * frequency domain.
+		 */
+		if (uclamp_enabled && !idle_cpu(j)) {
+			unsigned long j_max_util, j_min_util;
+
+			j_max_util = uclamp_value(j, UCLAMP_MAX);
+			j_min_util = uclamp_value(j, UCLAMP_MIN);
+
+			/*
+			 * Clamp values are MAX aggregated among all the
+			 * different CPUs in the shared frequency domain.
+			 */
+			max_util = max(max_util, j_max_util);
+			min_util = max(min_util, j_min_util);
+		}
 	}
 
+	/* Clamp utilization based on aggregated uclamp constraints */
+	if (uclamp_enabled)
+		util = clamp(util, min_util, max_util);
+
 	return get_next_freq(sg_policy, util, max);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 164a8ac152b3..4a235c4a0762 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2224,6 +2224,66 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 static inline void cpufreq_update_this_cpu(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
+#ifdef CONFIG_UTIL_CLAMP
+/* Enable clamping code at compile time by constant propagation */
+#define uclamp_enabled true
+
+/**
+ * uclamp_value: get the current CPU's utilization clamp value
+ * @cpu: the CPU to consider
+ * @clamp_id: the utilization clamp index (i.e. min or max utilization)
+ *
+ * The utilization clamp value for a CPU depends on its set of currently
+ * active tasks and their specific util_{min,max} constraints.
+ * A max aggregated value is tracked for each CPU and returned by this
+ * function. An IDLE CPU never enforces a clamp value.
+ *
+ * Return: the current value for the specified CPU and clamp index
+ */
+static inline unsigned int uclamp_value(unsigned int cpu, int clamp_id)
+{
+	struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
+	int clamp_value = uclamp_none(clamp_id);
+
+	/* Update min utilization clamp */
+	if (uc_cpu->value != UCLAMP_NONE)
+		clamp_value = uc_cpu->value;
+
+	return clamp_value;
+}
+
+/**
+ * clamp_util: clamp a utilization value for a specified CPU
+ * @cpu: the CPU to get the clamp values from
+ * @util: the utilization signal to clamp
+ *
+ * Each CPU tracks util_{min,max} clamp values depending on the set of its
+ * currently active tasks. Given a utilization signal, i.e a signal in the
+ * [0..SCHED_CAPACITY_SCALE] range, this function returns a clamped
+ * utilization signal considering the current clamp values for the
+ * specified CPU.
+ *
+ * Return: a clamped utilization signal for a given CPU.
+ */
+static inline int uclamp_util(unsigned int cpu, unsigned int util)
+{
+	unsigned int min_util = uclamp_value(cpu, UCLAMP_MIN);
+	unsigned int max_util = uclamp_value(cpu, UCLAMP_MAX);
+
+	return clamp(util, min_util, max_util);
+}
+#else
+/* Disable clamping code at compile time by constant propagation */
+#define uclamp_enabled false
+#define uclamp_util(cpu, util) util
+static inline unsigned int uclamp_value(unsigned int cpu, int clamp_id)
+{
+	if (clamp_id == UCLAMP_MIN)
+		return 0;
+	return SCHED_CAPACITY_SCALE;
+}
+#endif /* CONFIG_UTIL_CLAMP */
+
 #ifdef arch_scale_freq_capacity
 #ifndef arch_scale_freq_invariant
 #define arch_scale_freq_invariant()	(true)
-- 
2.14.1
