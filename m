From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 2/3] cpufreq: schedutil: Process remote callback for shared policies
Date: Wed, 26 Jul 2017 14:52:33 +0530
Message-ID: <d3e7bcbd5c87690b8d7607f92763081a4416af9c.1501060871.git.viresh.kumar@linaro.org>
References: <cover.1501060871.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501060871.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1501060871.git.viresh.kumar@linaro.org>
References: <cover.1501060871.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch updates the schedutil governor to process cpufreq utilization
update hooks called for remote CPUs where the remote CPU is managed by
the cpufreq policy of the local CPU.

Based on initial work from Steve Muckle.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index bb834747e49b..c3baf70d360c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -72,13 +72,12 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
-static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time,
-				     int target_cpu)
+static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 {
 	s64 delta_ns;
 
-	/* Don't allow remote callbacks */
-	if (smp_processor_id() != target_cpu)
+	/* Allow remote callbacks only on the CPUs sharing cpufreq policy */
+	if (!cpumask_test_cpu(smp_processor_id(), sg_policy->policy->cpus))
 		return false;
 
 	if (sg_policy->work_in_progress)
@@ -159,12 +158,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
-static void sugov_get_util(unsigned long *util, unsigned long *max)
+static void sugov_get_util(unsigned long *util, unsigned long *max, int cpu)
 {
-	struct rq *rq = this_rq();
+	struct rq *rq = cpu_rq(cpu);
 	unsigned long cfs_max;
 
-	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
+	cfs_max = arch_scale_cpu_capacity(NULL, cpu);
 
 	*util = min(rq->cfs.avg.util_avg, cfs_max);
 	*max = cfs_max;
@@ -226,7 +225,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
-	if (!sugov_should_update_freq(sg_policy, time, hook->cpu))
+	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
 	busy = sugov_cpu_is_busy(sg_cpu);
@@ -234,7 +233,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	if (flags & SCHED_CPUFREQ_RT_DL) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
-		sugov_get_util(&util, &max);
+		sugov_get_util(&util, &max, hook->cpu);
 		sugov_iowait_boost(sg_cpu, &util, &max);
 		next_f = get_next_freq(sg_policy, util, max);
 		/*
@@ -295,7 +294,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	unsigned long util, max;
 	unsigned int next_f;
 
-	sugov_get_util(&util, &max);
+	sugov_get_util(&util, &max, hook->cpu);
 
 	raw_spin_lock(&sg_policy->update_lock);
 
@@ -306,7 +305,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
-	if (sugov_should_update_freq(sg_policy, time, hook->cpu)) {
+	if (sugov_should_update_freq(sg_policy, time)) {
 		if (flags & SCHED_CPUFREQ_RT_DL)
 			next_f = sg_policy->policy->cpuinfo.max_freq;
 		else
-- 
2.13.0.71.gd7076ec9c9cb
