From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] cpufreq: schedutil: refactor sugov_next_freq_shared()
Date: Thu,  9 Mar 2017 09:34:54 +0530
Message-ID: <8ae8af9aea79c8ee58c1dffd90881b3a7039c179.1489032147.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The loop in sugov_next_freq_shared() contains an if block to skip the
loop for the current CPU. This turns out to be an unnecessary
conditional in the scheduler's hot-path for every CPU in the policy.

It would be better to drop the conditional and make the loop treat all
the CPUs in the same way. That would eliminate the need of calling
sugov_iowait_boost() at the top of the routine.

To keep the code optimized to return early if the current CPU has RT/DL
flags set, move the flags check to sugov_update_shared() instead in
order to avoid the function call entirely.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- Keep the flags check separately for the current CPU, but move it to
  the parent routine.
- Improved commit log.

 kernel/sched/cpufreq_schedutil.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 78468aa051ab..f5ffe241812e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -217,30 +217,19 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	sugov_update_commit(sg_policy, time, next_f);
 }
 
-static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
-					   unsigned long util, unsigned long max,
-					   unsigned int flags)
+static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu)
 {
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned int max_f = policy->cpuinfo.max_freq;
 	u64 last_freq_update_time = sg_policy->last_freq_update_time;
+	unsigned long util = 0, max = 1;
 	unsigned int j;
 
-	if (flags & SCHED_CPUFREQ_RT_DL)
-		return max_f;
-
-	sugov_iowait_boost(sg_cpu, &util, &max);
-
 	for_each_cpu(j, policy->cpus) {
-		struct sugov_cpu *j_sg_cpu;
+		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
 		unsigned long j_util, j_max;
 		s64 delta_ns;
 
-		if (j == smp_processor_id())
-			continue;
-
-		j_sg_cpu = &per_cpu(sugov_cpu, j);
 		/*
 		 * If the CPU utilization was last updated before the previous
 		 * frequency update and the time elapsed between the last update
@@ -254,7 +243,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
 			continue;
 		}
 		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
-			return max_f;
+			return policy->cpuinfo.max_freq;
 
 		j_util = j_sg_cpu->util;
 		j_max = j_sg_cpu->max;
@@ -289,7 +278,11 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
-		next_f = sugov_next_freq_shared(sg_cpu, util, max, flags);
+		if (flags & SCHED_CPUFREQ_RT_DL)
+			next_f = sg_policy->policy->cpuinfo.max_freq;
+		else
+			next_f = sugov_next_freq_shared(sg_cpu);
+
 		sugov_update_commit(sg_policy, time, next_f);
 	}
 
-- 
2.7.1.410.g6faf27b
