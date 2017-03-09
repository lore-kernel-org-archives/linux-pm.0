From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC 5/9] sched: cpufreq: remove smp_processor_id() in remote paths
Date: Thu,  9 Mar 2017 17:15:15 +0530
Message-ID: <834d098efe029ee687bac7690bb482e9263a766b.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36390 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932217AbdCILp4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2017 06:45:56 -0500
Received: by mail-pg0-f51.google.com with SMTP id g2so8331730pge.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Mar 2017 03:45:55 -0800 (PST)
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

From: Steve Muckle <smuckle.linux@gmail.com>

Upcoming support for remote callbacks from the scheduler into schedutil
requires that the CPU identified in the hook structure be used to
indicate the CPU being operated on, rather than relying on
smp_processor_id().

Note that policy->cpu is passed to trace_cpu_frequency() in fast switch
path, as it is safe to use any CPU which is managed by the current
policy.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
[ vk: updated commit log, minor code cleanups and use policy->cpu for
      traces ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index a418544c51b1..b168c31f1c8f 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -96,7 +96,7 @@ static void sugov_fast_switch(struct cpufreq_policy *policy,
 		return;
 
 	policy->cur = next_freq;
-	trace_cpu_frequency(next_freq, smp_processor_id());
+	trace_cpu_frequency(next_freq, policy->cpu);
 }
 
 static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
@@ -106,7 +106,7 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 
 	if (policy->fast_switch_enabled) {
 		if (sg_policy->next_freq == next_freq) {
-			trace_cpu_frequency(policy->cur, smp_processor_id());
+			trace_cpu_frequency(policy->cur, policy->cpu);
 			return;
 		}
 		sg_policy->next_freq = next_freq;
@@ -157,12 +157,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
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
@@ -216,7 +216,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	if (flags & SCHED_CPUFREQ_RT_DL) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
-		sugov_get_util(&util, &max);
+		sugov_get_util(&util, &max, hook->cpu);
 		sugov_iowait_boost(sg_cpu, &util, &max);
 		next_f = get_next_freq(sg_policy, util, max);
 	}
@@ -272,7 +272,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	unsigned long util, max;
 	unsigned int next_f;
 
-	sugov_get_util(&util, &max);
+	sugov_get_util(&util, &max, hook->cpu);
 
 	raw_spin_lock(&sg_policy->update_lock);
 
-- 
2.7.1.410.g6faf27b
