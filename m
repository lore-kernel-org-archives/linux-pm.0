From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH 5/5] cpufreq: schedutil: do not update rate limit ts when freq is unchanged
Date: Mon,  9 May 2016 14:20:14 -0700
Message-ID: <1462828814-32530-6-git-send-email-smuckle@linaro.org>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

The rate limit timestamp (last_freq_update_time) is currently advanced
anytime schedutil re-evaluates the policy regardless of whether the CPU
frequency is changed or not. This means that utilization updates which
have no effect can cause much more significant utilization updates
(which require a large increase or decrease in CPU frequency) to be
delayed due to rate limiting.

Instead only update the rate limiting timstamp when the requested
target-supported frequency changes. The rate limit will now apply to
the rate of CPU frequency changes rather than the rate of
re-evaluations of the policy frequency.

Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e185075fcb5c..4d2907c8a142 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -117,12 +117,11 @@ static void sugov_update_commit(struct sugov_cpu *sg_cpu, int cpu, u64 time,
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
 
-	sg_policy->last_freq_update_time = time;
-
 	if (sg_policy->next_freq == next_freq) {
 		trace_cpu_frequency(policy->cur, cpu);
 		return;
 	}
+	sg_policy->last_freq_update_time = time;
 	sg_policy->next_freq = next_freq;
 
 	if (sugov_queue_remote_callback(sg_policy, cpu))
-- 
2.4.10
