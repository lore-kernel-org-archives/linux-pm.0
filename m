From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC 6/9] sched: cpufreq: detect, process remote callbacks
Date: Thu,  9 Mar 2017 17:15:16 +0530
Message-ID: <2e807adcbf0d5136876f9de48c62e9e2dd2a5b06.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Steve Muckle <smuckle.linux@gmail.com>

A callback is considered remote if the target CPU is not the current CPU
and if it is not managed by the policy managing the current CPU or the
current CPU can't do DVFS on its behalf.

Queue the irq work for remote callbacks on the destination CPU. The irq
work will carry out the fast or slow switch as appropriate.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
[ vk: commit log, code cleanups, introduce dvfs_possible_from_any_cpu
      and drop late callback support to avoid IPIs on remote CPUs. ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index b168c31f1c8f..9bad579b6b08 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -100,11 +100,11 @@ static void sugov_fast_switch(struct cpufreq_policy *policy,
 }
 
 static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
-				unsigned int next_freq)
+				int cpu, bool remote, unsigned int next_freq)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
 
-	if (policy->fast_switch_enabled) {
+	if (policy->fast_switch_enabled && !remote) {
 		if (sg_policy->next_freq == next_freq) {
 			trace_cpu_frequency(policy->cur, policy->cpu);
 			return;
@@ -116,7 +116,7 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 		sg_policy->next_freq = next_freq;
 		sg_policy->last_freq_update_time = time;
 		sg_policy->work_in_progress = true;
-		irq_work_queue(&sg_policy->irq_work);
+		irq_work_queue_on(&sg_policy->irq_work, cpu);
 	}
 }
 
@@ -206,6 +206,20 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned long util, max;
 	unsigned int next_f;
+	int cpu, this_cpu = smp_processor_id();
+	bool remote;
+
+	if (policy->dvfs_possible_from_any_cpu) {
+		/*
+		 * Avoid sending IPI to 'hook->cpu' if this CPU can change
+		 * frequency on its behalf.
+		 */
+		remote = false;
+		cpu = this_cpu;
+	} else {
+		cpu = hook->cpu;
+		remote = this_cpu != hook->cpu;
+	}
 
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
@@ -220,7 +234,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 		sugov_iowait_boost(sg_cpu, &util, &max);
 		next_f = get_next_freq(sg_policy, util, max);
 	}
-	sugov_update_commit(sg_policy, time, next_f);
+	sugov_update_commit(sg_policy, time, cpu, remote, next_f);
 }
 
 static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu)
@@ -269,8 +283,24 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
+	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned long util, max;
 	unsigned int next_f;
+	int cpu, this_cpu = smp_processor_id();
+	bool remote;
+
+	if (policy->dvfs_possible_from_any_cpu ||
+	    cpumask_test_cpu(this_cpu, policy->cpus)) {
+		/*
+		 * Avoid sending IPI to 'hook->cpu' if this CPU can change
+		 * frequency on its behalf.
+		 */
+		remote = false;
+		cpu = this_cpu;
+	} else {
+		cpu = hook->cpu;
+		remote = this_cpu != hook->cpu;
+	}
 
 	sugov_get_util(&util, &max, hook->cpu);
 
@@ -289,7 +319,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 		else
 			next_f = sugov_next_freq_shared(sg_cpu);
 
-		sugov_update_commit(sg_policy, time, next_f);
+		sugov_update_commit(sg_policy, time, cpu, remote, next_f);
 	}
 
 	raw_spin_unlock(&sg_policy->update_lock);
-- 
2.7.1.410.g6faf27b
