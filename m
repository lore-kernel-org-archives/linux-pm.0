From: Steve Muckle <steve.muckle@linaro.org>
Subject: [RFC PATCH 3/4] intel_pstate: support scheduler cpufreq callbacks on remote CPUs
Date: Tue, 19 Apr 2016 19:39:28 -0700
Message-ID: <1461119969-10371-3-git-send-email-smuckle@linaro.org>
References: <1461119969-10371-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461119969-10371-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

In preparation for the scheduler cpufreq callback happening on remote
CPUs, add support for this in intel_pstate, which requires the
callback run on the local CPU to be able to change the CPU frequency.

Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 88 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6c7cff13f0ed..fa49d3944aa5 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -162,6 +162,9 @@ struct _pid {
  * struct cpudata -	Per CPU instance data storage
  * @cpu:		CPU number for this instance data
  * @update_util:	CPUFreq utility callback information
+ * @irq_work:		Data for passing remote callbacks to the target CPU
+ * @time:		Timestamp of CPUFreq callback
+ * @ipi_in_progress:	Whether a remote callback IPI is outstanding
  * @pstate:		Stores P state limits for this CPU
  * @vid:		Stores VID limits for this CPU
  * @pid:		Stores PID parameters for this CPU
@@ -179,6 +182,9 @@ struct cpudata {
 	int cpu;
 
 	struct update_util_data update_util;
+	struct irq_work irq_work;
+	u64	time;
+	bool	ipi_in_progress;
 
 	struct pstate_data pstate;
 	struct vid_data vid;
@@ -1173,20 +1179,88 @@ static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 		get_avg_frequency(cpu));
 }
 
+static void _intel_pstate_update_util(struct cpudata *cpu, u64 time)
+{
+	bool sample_taken = intel_pstate_sample(cpu, time);
+
+	if (sample_taken && !hwp_active)
+		intel_pstate_adjust_busy_pstate(cpu);
+}
+
+#ifdef CONFIG_SMP
+static void intel_pstate_update_util_remote(struct irq_work *irq_work)
+{
+	struct cpudata *cpu = container_of(irq_work, struct cpudata, irq_work);
+	s64 delta_ns = cpu->time - cpu->sample.time;
+
+	/*
+	 * A local update may have happened while the ipi
+	 * was in progress so re-check the time.
+	 */
+	if (delta_ns < pid_params.sample_rate_ns)
+		return;
+
+	_intel_pstate_update_util(cpu, cpu->time);
+
+	cpu->ipi_in_progress = false;
+}
+
 static void intel_pstate_update_util(struct update_util_data *data, u64 time,
 				     unsigned long util, unsigned long max)
 {
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
-	u64 delta_ns = time - cpu->sample.time;
+	s64 delta_ns = time - cpu->sample.time;
 
-	if ((s64)delta_ns >= pid_params.sample_rate_ns) {
-		bool sample_taken = intel_pstate_sample(cpu, time);
+	if (delta_ns < pid_params.sample_rate_ns)
+		return;
 
-		if (sample_taken && !hwp_active)
-			intel_pstate_adjust_busy_pstate(cpu);
+	if (cpu->cpu == smp_processor_id()) {
+		_intel_pstate_update_util(cpu, time);
+	} else {
+		/* The target CPU's rq lock is held. */
+		if (cpu->ipi_in_progress)
+			return;
+
+		/* Re-check sample_time which may have advanced. */
+		smp_rmb();
+		delta_ns = time - READ_ONCE(cpu->sample.time);
+		if (delta_ns < pid_params.sample_rate_ns)
+			return;
+
+		cpu->ipi_in_progress = true;
+		cpu->time = time;
+		irq_work_queue_on(&cpu->irq_work, cpu->cpu);
 	}
 }
 
+static inline void intel_pstate_irq_work_sync(unsigned int cpu)
+{
+	irq_work_sync(&all_cpu_data[cpu]->irq_work);
+}
+
+static inline void intel_pstate_init_irq_work(struct cpudata *cpu)
+{
+	init_irq_work(&cpu->irq_work, intel_pstate_update_util_remote);
+}
+#else /* !CONFIG_SMP */
+static inline void intel_pstate_irq_work_sync(unsigned int cpu) {}
+static inline void intel_pstate_init_irq_work(struct cpudata *cpu) {}
+
+static void intel_pstate_update_util(struct update_util_data *data, u64 time,
+				     unsigned long util, unsigned long max)
+{
+	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
+	s64 delta_ns = time - cpu->sample.time;
+
+	if (delta_ns < pid_params.sample_rate_ns)
+		return;
+
+	_intel_pstate_update_util(cpu, time);
+}
+#endif
+
+
+
 #define ICPU(model, policy) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF,\
 			(unsigned long)&policy }
@@ -1273,6 +1347,7 @@ static void intel_pstate_clear_update_util_hook(unsigned int cpu)
 {
 	cpufreq_remove_update_util_hook(cpu);
 	synchronize_sched();
+	intel_pstate_irq_work_sync(cpu);
 }
 
 static void intel_pstate_set_performance_limits(struct perf_limits *limits)
@@ -1379,6 +1454,9 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	cpu = all_cpu_data[policy->cpu];
 
+	intel_pstate_init_irq_work(cpu);
+
+
 	if (limits->min_perf_pct == 100 && limits->max_perf_pct == 100)
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
 	else
-- 
2.4.10
