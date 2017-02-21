From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] cpufreq: schedutil: Redefine the rate_limit_us tunable
Date: Tue, 21 Feb 2017 10:15:18 +0530
Message-ID: <250f484b4fec4922601f18e719f587aa40c8b220.1487651965.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, eas-dev@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The rate_limit_us tunable is intended to reduce the possible overhead
from running the schedutil governor.  However, that overhead can be
divided into two separate parts: the governor computations and the
invocation of the scaling driver to set the CPU frequency.  The latter
is where the real overhead comes from.  The former is much less
expensive in terms of execution time and running it every time the
governor callback is invoked by the scheduler, after rate_limit_us
interval has passed since the last frequency update, would not be a
problem.

For this reason, redefine the rate_limit_us tunable so that it means the
minimum time that has to pass between two consecutive invocations of the
scaling driver by the schedutil governor (to set the CPU frequency).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2: Update $subject and commit log (Rafael)

 kernel/sched/cpufreq_schedutil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index fd4659313640..306d97e7b57c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -92,14 +92,13 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
 
-	sg_policy->last_freq_update_time = time;
-
 	if (policy->fast_switch_enabled) {
 		if (sg_policy->next_freq == next_freq) {
 			trace_cpu_frequency(policy->cur, smp_processor_id());
 			return;
 		}
 		sg_policy->next_freq = next_freq;
+		sg_policy->last_freq_update_time = time;
 		next_freq = cpufreq_driver_fast_switch(policy, next_freq);
 		if (next_freq == CPUFREQ_ENTRY_INVALID)
 			return;
@@ -108,6 +107,7 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 		trace_cpu_frequency(next_freq, smp_processor_id());
 	} else if (sg_policy->next_freq != next_freq) {
 		sg_policy->next_freq = next_freq;
+		sg_policy->last_freq_update_time = time;
 		sg_policy->work_in_progress = true;
 		irq_work_queue(&sg_policy->irq_work);
 	}
-- 
2.7.1.410.g6faf27b
