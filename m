From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/3] cpufreq: schedutil: Pass sg_policy to get_next_freq()
Date: Thu,  2 Mar 2017 14:03:21 +0530
Message-ID: <7558e39af874a470fcfc3e64d0d1d93ec1ce009e.1488437503.git.viresh.kumar@linaro.org>
References: <cover.1488437503.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1488437503.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1488437503.git.viresh.kumar@linaro.org>
References: <cover.1488437503.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

get_next_freq() uses sg_cpu only to get sg_policy, which the callers of
get_next_freq() already have. Pass sg_policy instead of sg_cpu to
get_next_freq(), to make it more efficient.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 721f4e011366..570925ea7253 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -115,7 +115,7 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 
 /**
  * get_next_freq - Compute a new frequency for a given cpufreq policy.
- * @sg_cpu: schedutil cpu object to compute the new frequency for.
+ * @sg_policy: schedutil policy object to compute the new frequency for.
  * @util: Current CPU utilization.
  * @max: CPU capacity.
  *
@@ -135,10 +135,9 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
  * next_freq (as calculated above) is returned, subject to policy min/max and
  * cpufreq driver limitations.
  */
-static unsigned int get_next_freq(struct sugov_cpu *sg_cpu, unsigned long util,
-				  unsigned long max)
+static unsigned int get_next_freq(struct sugov_policy *sg_policy,
+				  unsigned long util, unsigned long max)
 {
-	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int freq = arch_scale_freq_invariant() ?
 				policy->cpuinfo.max_freq : policy->cur;
@@ -212,7 +211,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	} else {
 		sugov_get_util(&util, &max);
 		sugov_iowait_boost(sg_cpu, &util, &max);
-		next_f = get_next_freq(sg_cpu, util, max);
+		next_f = get_next_freq(sg_policy, util, max);
 	}
 	sugov_update_commit(sg_policy, time, next_f);
 }
@@ -266,7 +265,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
 		sugov_iowait_boost(j_sg_cpu, &util, &max);
 	}
 
-	return get_next_freq(sg_cpu, util, max);
+	return get_next_freq(sg_policy, util, max);
 }
 
 static void sugov_update_shared(struct update_util_data *hook, u64 time,
-- 
2.7.1.410.g6faf27b
