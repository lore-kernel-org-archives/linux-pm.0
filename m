From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 2/3] cpufreq: schedutil: Process remote callback for shared policies
Date: Thu, 13 Jul 2017 12:14:38 +0530
Message-ID: <3fbaa9aaba19bfff5ff25d2c4141e88fb83f1ea9.1499927699.git.viresh.kumar@linaro.org>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1499927699.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1499927699.git.viresh.kumar@linaro.org>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch updates the schedutil governor to process cpufreq utilization
update hooks called for remote CPUs.

The schedutil governor already has proper locking in place for shared
policy update hooks and nothing extra is required to be done.

Based on initial work from Steve Muckle.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index ed9c589e5386..2599e7e7a82c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -154,12 +154,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
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
@@ -233,7 +233,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	if (flags & SCHED_CPUFREQ_RT_DL) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
-		sugov_get_util(&util, &max);
+		sugov_get_util(&util, &max, hook->cpu);
 		sugov_iowait_boost(sg_cpu, &util, &max);
 		next_f = get_next_freq(sg_policy, util, max);
 		/*
@@ -291,14 +291,15 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
+	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned long util, max;
 	unsigned int next_f;
 
-	/* Don't allow remote callbacks */
-	if (smp_processor_id() != hook->cpu)
+	/* Allow remote callbacks only on the CPUs sharing cpufreq policy */
+	if (!cpumask_test_cpu(smp_processor_id(), policy->cpus))
 		return;
 
-	sugov_get_util(&util, &max);
+	sugov_get_util(&util, &max, hook->cpu);
 
 	raw_spin_lock(&sg_policy->update_lock);
 
-- 
2.13.0.71.gd7076ec9c9cb
