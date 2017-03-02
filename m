From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] cpufreq: schedutil: remove redundant code from sugov_next_freq_shared()
Date: Thu,  2 Mar 2017 14:03:22 +0530
Message-ID: <639aad743bac7f3292146738f44dbd1480169c8e.1488437503.git.viresh.kumar@linaro.org>
References: <cover.1488437503.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1488437503.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1488437503.git.viresh.kumar@linaro.org>
References: <cover.1488437503.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The same code is present both within and outside the loop and it doesn't
look like it provides any additional benefit. Remove the special
handling of sg_cpu and let it happen within the loop.

With this change we will do two extra comparisons for the sg_cpu in the
loop, but the loop will do one less comparison for every other CPU in
the policy.

While at it, also remove the excess parameters of sugov_next_freq_shared().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 570925ea7253..ec56537429a8 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -216,30 +216,20 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	sugov_update_commit(sg_policy, time, next_f);
 }
 
-static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
-					   unsigned long util, unsigned long max,
-					   unsigned int flags)
+static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu)
 {
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int max_f = policy->cpuinfo.max_freq;
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
@@ -288,7 +278,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
-		next_f = sugov_next_freq_shared(sg_cpu, util, max, flags);
+		next_f = sugov_next_freq_shared(sg_cpu);
 		sugov_update_commit(sg_policy, time, next_f);
 	}
 
-- 
2.7.1.410.g6faf27b
