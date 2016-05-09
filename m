From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH 2/5] cpufreq: schedutil: support scheduler cpufreq callbacks on remote CPUs
Date: Mon,  9 May 2016 14:20:11 -0700
Message-ID: <1462828814-32530-3-git-send-email-smuckle@linaro.org>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

In preparation for the scheduler cpufreq callback happening on remote
CPUs, add support for this in schedutil.

Schedutil currently requires the callback occur on the CPU being
updated in order to support fast frequency switches. Remove this
limitation by checking for the current CPU being outside the target
CPU's cpufreq policy and if this is the case, enqueuing an irq_work on
the target CPU. The irq_work for schedutil is modified to carry out a
fast frequency switch if that is enabled for the policy.

If the callback occurs on a CPU within the target CPU's policy, the
transition is carried out on the local CPU.

Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 86 ++++++++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 154ae3a51e86..c81f9432f520 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -76,27 +76,61 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	return delta_ns >= sg_policy->freq_update_delay_ns;
 }
 
-static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
+static void sugov_fast_switch(struct sugov_policy *sg_policy, int cpu,
+			      unsigned int next_freq)
+{
+	struct cpufreq_policy *policy = sg_policy->policy;
+
+	next_freq = cpufreq_driver_fast_switch(policy, next_freq);
+	if (next_freq == CPUFREQ_ENTRY_INVALID)
+		return;
+
+	policy->cur = next_freq;
+	trace_cpu_frequency(next_freq, cpu);
+}
+
+#ifdef CONFIG_SMP
+static inline bool sugov_queue_remote_callback(struct sugov_policy *sg_policy,
+					 int cpu)
+{
+	struct cpufreq_policy *policy = sg_policy->policy;
+
+	if (!cpumask_test_cpu(smp_processor_id(), policy->cpus)) {
+		sg_policy->work_in_progress = true;
+		irq_work_queue_on(&sg_policy->irq_work, cpu);
+		return true;
+	}
+
+	return false;
+}
+#else
+static inline bool sugov_queue_remote_callback(struct sugov_policy *sg_policy,
+					 int cpu)
+{
+	return false;
+}
+#endif
+
+static void sugov_update_commit(struct sugov_cpu *sg_cpu, int cpu, u64 time,
 				unsigned int next_freq)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
 
 	sg_policy->last_freq_update_time = time;
 
+	if (sg_policy->next_freq == next_freq) {
+		trace_cpu_frequency(policy->cur, cpu);
+		return;
+	}
+	sg_policy->next_freq = next_freq;
+
+	if (sugov_queue_remote_callback(sg_policy, cpu))
+		return;
+
 	if (policy->fast_switch_enabled) {
-		if (sg_policy->next_freq == next_freq) {
-			trace_cpu_frequency(policy->cur, smp_processor_id());
-			return;
-		}
-		sg_policy->next_freq = next_freq;
-		next_freq = cpufreq_driver_fast_switch(policy, next_freq);
-		if (next_freq == CPUFREQ_ENTRY_INVALID)
-			return;
-
-		policy->cur = next_freq;
-		trace_cpu_frequency(next_freq, smp_processor_id());
-	} else if (sg_policy->next_freq != next_freq) {
-		sg_policy->next_freq = next_freq;
+		sugov_fast_switch(sg_policy, cpu, next_freq);
+	} else {
 		sg_policy->work_in_progress = true;
 		irq_work_queue(&sg_policy->irq_work);
 	}
@@ -142,12 +176,13 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	next_f = util == ULONG_MAX ? policy->cpuinfo.max_freq :
 			get_next_freq(policy, util, max);
-	sugov_update_commit(sg_policy, time, next_f);
+	sugov_update_commit(sg_cpu, hook->cpu, time, next_f);
 }
 
-static unsigned int sugov_next_freq_shared(struct sugov_policy *sg_policy,
+static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
 					   unsigned long util, unsigned long max)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int max_f = policy->cpuinfo.max_freq;
 	u64 last_freq_update_time = sg_policy->last_freq_update_time;
@@ -161,10 +196,10 @@ static unsigned int sugov_next_freq_shared(struct sugov_policy *sg_policy,
 		unsigned long j_util, j_max;
 		s64 delta_ns;
 
-		if (j == smp_processor_id())
+		j_sg_cpu = &per_cpu(sugov_cpu, j);
+		if (j_sg_cpu == sg_cpu)
 			continue;
 
-		j_sg_cpu = &per_cpu(sugov_cpu, j);
 		/*
 		 * If the CPU utilization was last updated before the previous
 		 * frequency update and the time elapsed between the last update
@@ -204,8 +239,8 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
-		next_f = sugov_next_freq_shared(sg_policy, util, max);
-		sugov_update_commit(sg_policy, time, next_f);
+		next_f = sugov_next_freq_shared(sg_cpu, util, max);
+		sugov_update_commit(sg_cpu, hook->cpu, time, next_f);
 	}
 
 	raw_spin_unlock(&sg_policy->update_lock);
@@ -226,9 +261,18 @@ static void sugov_work(struct work_struct *work)
 static void sugov_irq_work(struct irq_work *irq_work)
 {
 	struct sugov_policy *sg_policy;
+	struct cpufreq_policy *policy;
 
 	sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
-	schedule_work_on(smp_processor_id(), &sg_policy->work);
+	policy = sg_policy->policy;
+
+	if (policy->fast_switch_enabled) {
+		sugov_fast_switch(sg_policy, smp_processor_id(),
+				  sg_policy->next_freq);
+		sg_policy->work_in_progress = false;
+	} else {
+		schedule_work_on(smp_processor_id(), &sg_policy->work);
+	}
 }
 
 /************************** sysfs interface ************************/
-- 
2.4.10
