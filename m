From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH 2/2] sched: cpufreq: use rt_avg as estimate of required RT CPU capacity
Date: Fri, 26 Aug 2016 11:40:48 -0700
Message-ID: <1472236848-17038-3-git-send-email-smuckle@linaro.org>
References: <1472236848-17038-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472236848-17038-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

A policy of going to fmax on any RT activity will be detrimental
for power on many platforms. Often RT accounts for only a small amount
of CPU activity so sending the CPU frequency to fmax is overkill. Worse
still, some platforms may not be able to even complete the CPU frequency
change before the RT activity has already completed.

Cpufreq governors have not treated RT activity this way in the past so
it is not part of the expected semantics of the RT scheduling class. The
DL class offers guarantees about task completion and could be used for
this purpose.

Modify the schedutil algorithm to instead use rt_avg as an estimate of
RT utilization of the CPU.

Based on previous work by Vincent Guittot <vincent.guittot@linaro.org>.

Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index cb8a77b1ef1b..89094a466250 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -146,13 +146,21 @@ static unsigned int get_next_freq(struct sugov_cpu *sg_cpu, unsigned long util,
 
 static void sugov_get_util(unsigned long *util, unsigned long *max)
 {
-	struct rq *rq = this_rq();
-	unsigned long cfs_max;
+	int cpu = smp_processor_id();
+	struct rq *rq = cpu_rq(cpu);
+	unsigned long max_cap, rt;
+	s64 delta;
 
-	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
+	max_cap = arch_scale_cpu_capacity(NULL, cpu);
 
-	*util = min(rq->cfs.avg.util_avg, cfs_max);
-	*max = cfs_max;
+	delta = rq_clock(rq) - rq->age_stamp;
+	if (unlikely(delta < 0))
+		delta = 0;
+	rt = div64_u64(rq->rt_avg, sched_avg_period() + delta);
+	rt = (rt * max_cap) >> SCHED_CAPACITY_SHIFT;
+
+	*util = min(rq->cfs.avg.util_avg + rt, max_cap);
+	*max = max_cap;
 }
 
 static void sugov_update_single(struct update_util_data *hook, u64 time,
@@ -167,7 +175,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
-	if (flags & SCHED_CPUFREQ_RT_DL) {
+	if (flags & SCHED_CPUFREQ_DL) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
 		sugov_get_util(&util, &max);
@@ -186,7 +194,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
 	u64 last_freq_update_time = sg_policy->last_freq_update_time;
 	unsigned int j;
 
-	if (flags & SCHED_CPUFREQ_RT_DL)
+	if (flags & SCHED_CPUFREQ_DL)
 		return max_f;
 
 	for_each_cpu(j, policy->cpus) {
@@ -209,7 +217,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
 		if (delta_ns > TICK_NSEC)
 			continue;
 
-		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
+		if (j_sg_cpu->flags & SCHED_CPUFREQ_DL)
 			return max_f;
 
 		j_util = j_sg_cpu->util;
@@ -467,7 +475,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 		if (policy_is_shared(policy)) {
 			sg_cpu->util = 0;
 			sg_cpu->max = 0;
-			sg_cpu->flags = SCHED_CPUFREQ_RT;
+			sg_cpu->flags = SCHED_CPUFREQ_DL;
 			sg_cpu->last_update = 0;
 			sg_cpu->cached_raw_freq = 0;
 			cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
-- 
2.7.3
