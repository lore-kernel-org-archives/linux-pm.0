From: Steve Muckle <steve.muckle@linaro.org>
Subject: [RFC PATCH 2/4] cpufreq: schedutil: support scheduler cpufreq callbacks on remote CPUs
Date: Tue, 19 Apr 2016 19:39:27 -0700
Message-ID: <1461119969-10371-2-git-send-email-smuckle@linaro.org>
References: <1461119969-10371-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461119969-10371-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

In preparation for the scheduler cpufreq callback happening on remote
CPUs, add support for this in schedutil. Schedutil requires the
callback occur on the CPU being updated in order to support fast
frequency switches.

Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 90 ++++++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 154ae3a51e86..6e7cf90d4ea7 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -49,6 +49,8 @@ struct sugov_cpu {
 	unsigned long util;
 	unsigned long max;
 	u64 last_update;
+
+	int cpu;
 };
 
 static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
@@ -76,27 +78,59 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	return delta_ns >= sg_policy->freq_update_delay_ns;
 }
 
-static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
+static void sugov_fast_switch(struct sugov_policy *sg_policy,
+			      unsigned int next_freq)
+{
+	struct cpufreq_policy *policy = sg_policy->policy;
+
+	next_freq = cpufreq_driver_fast_switch(policy, next_freq);
+	if (next_freq == CPUFREQ_ENTRY_INVALID)
+		return;
+
+	policy->cur = next_freq;
+	trace_cpu_frequency(next_freq, smp_processor_id());
+}
+
+#ifdef CONFIG_SMP
+static inline bool sugov_queue_remote_callback(struct sugov_policy *sg_policy,
+					 int cpu)
+{
+	if (cpu != smp_processor_id()) {
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
+static void sugov_update_commit(struct sugov_cpu *sg_cpu, u64 time,
 				unsigned int next_freq)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
 
 	sg_policy->last_freq_update_time = time;
 
+	if (sg_policy->next_freq == next_freq) {
+		trace_cpu_frequency(policy->cur, sg_cpu->cpu);
+		return;
+	}
+	sg_policy->next_freq = next_freq;
+
+	if (sugov_queue_remote_callback(sg_policy, sg_cpu->cpu))
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
+		sugov_fast_switch(sg_policy, next_freq);
+	} else {
 		sg_policy->work_in_progress = true;
 		irq_work_queue(&sg_policy->irq_work);
 	}
@@ -142,12 +176,13 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	next_f = util == ULONG_MAX ? policy->cpuinfo.max_freq :
 			get_next_freq(policy, util, max);
-	sugov_update_commit(sg_policy, time, next_f);
+	sugov_update_commit(sg_cpu, time, next_f);
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
+		sugov_update_commit(sg_cpu, time, next_f);
 	}
 
 	raw_spin_unlock(&sg_policy->update_lock);
@@ -226,9 +261,17 @@ static void sugov_work(struct work_struct *work)
 static void sugov_irq_work(struct irq_work *irq_work)
 {
 	struct sugov_policy *sg_policy;
+	struct cpufreq_policy *policy;
 
 	sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
-	schedule_work_on(smp_processor_id(), &sg_policy->work);
+	policy = sg_policy->policy;
+
+	if (policy->fast_switch_enabled) {
+		sugov_fast_switch(sg_policy, sg_policy->next_freq);
+		sg_policy->work_in_progress = false;
+	} else {
+		schedule_work_on(smp_processor_id(), &sg_policy->work);
+	}
 }
 
 /************************** sysfs interface ************************/
@@ -330,7 +373,7 @@ static int sugov_init(struct cpufreq_policy *policy)
 	struct sugov_policy *sg_policy;
 	struct sugov_tunables *tunables;
 	unsigned int lat;
-	int ret = 0;
+	int cpu, ret = 0;
 
 	/* State should be equivalent to EXIT */
 	if (policy->governor_data)
@@ -340,6 +383,9 @@ static int sugov_init(struct cpufreq_policy *policy)
 	if (!sg_policy)
 		return -ENOMEM;
 
+	for_each_cpu(cpu, policy->cpus)
+		per_cpu(sugov_cpu, cpu).cpu = cpu;
+
 	mutex_lock(&global_tunables_lock);
 
 	if (global_tunables) {
-- 
2.4.10
