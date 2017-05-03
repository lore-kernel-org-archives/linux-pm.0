From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH] sched/cpufreq_schedutil: use now as reference when aggregating shared policy requests
Date: Wed,  3 May 2017 14:30:48 +0100
Message-ID: <20170503133048.8742-1-juri.lelli@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751991AbdECNay (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 May 2017 09:30:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, peterz@infradead.org, vincent.guittot@linaro.org, juri.lelli@arm.com, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

Currently, sugov_next_freq_shared() uses last_freq_update_time as a
reference to decide when to start considering CPU contributions as
stale.

However, since last_freq_update_time is set by the last CPU that issued
a frequency transition, this might cause problems in certain cases. In
practice, the detection of stale utilization values fails whenever the
CPU with such values was the last to update the policy. For example (and
please note again that the SCHED_CPUFREQ_RT flag is not the problem
here, but only the detection of after how much time that flag has to be
considered stale), suppose a policy with 2 CPUs:

               CPU0                |               CPU1
                                   |
                                   |     RT task scheduled
                                   |     SCHED_CPUFREQ_RT is set
                                   |     CPU1->last_update = now
                                   |     freq transition to max
                                   |     last_freq_update_time = now
                                   |

                        more than TICK_NSEC nsecs

                                   |
     a small CFS wakes up          |
     CPU0->last_update = now1      |
     delta_ns(CPU0) < TICK_NSEC*   |
     CPU0's util is considered     |
     delta_ns(CPU1) =              |
      last_freq_update_time -      |
      CPU1->last_update = 0        |
      < TICK_NSEC                  |
     CPU1 is still considered      |
     CPU1->SCHED_CPUFREQ_RT is set |
     we stay at max (until CPU1    |
     exits from idle)              |

* delta_ns is actually negative as now1 > last_freq_update_time

While last_freq_update_time is a sensible reference for rate limiting,
it doesn't seem to be useful for working around stale CPU states.

Fix the problem by always considering now (time) as the reference for
deciding when CPUs have stale contributions.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 76877a62b5fa..622eed1b7658 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -245,11 +245,10 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	sugov_update_commit(sg_policy, time, next_f);
 }
 
-static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu)
+static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 {
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
-	u64 last_freq_update_time = sg_policy->last_freq_update_time;
 	unsigned long util = 0, max = 1;
 	unsigned int j;
 
@@ -265,7 +264,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu)
 		 * enough, don't take the CPU into account as it probably is
 		 * idle now (and clear iowait_boost for it).
 		 */
-		delta_ns = last_freq_update_time - j_sg_cpu->last_update;
+		delta_ns = time - j_sg_cpu->last_update;
 		if (delta_ns > TICK_NSEC) {
 			j_sg_cpu->iowait_boost = 0;
 			continue;
@@ -309,7 +308,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 		if (flags & SCHED_CPUFREQ_RT_DL)
 			next_f = sg_policy->policy->cpuinfo.max_freq;
 		else
-			next_f = sugov_next_freq_shared(sg_cpu);
+			next_f = sugov_next_freq_shared(sg_cpu, time);
 
 		sugov_update_commit(sg_policy, time, next_f);
 	}
-- 
2.10.0
