From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: schedutil: govern how frequently we change frequency with rate_limit
Date: Wed, 15 Feb 2017 22:45:47 +0530
Message-ID: <4c9afe0a2cda5016b342f777f244c89c03cdc524.1487178939.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33862 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdBORPz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Feb 2017 12:15:55 -0500
Received: by mail-pg0-f51.google.com with SMTP id z67so6505860pgb.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Feb 2017 09:15:55 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

For an ideal system (where frequency change doesn't incur any penalty)
we would like to change the frequency as soon as the load changes for a
CPU. But the systems we have to work with are far from ideal and it
takes time to change the frequency of a CPU. For many ARM platforms
specially, it is at least 1 ms. In order to not spend too much time
changing frequency, we have earlier introduced a sysfs controlled
tunable for the schedutil governor: rate_limit_us.

Currently, rate_limit_us controls how frequently we reevaluate frequency
for a set of CPUs controlled by a cpufreq policy. But that may not be
the ideal behavior we want.

Consider for example the following scenario. The rate_limit_us tunable
is set to 10 ms. The CPU has a constant load X and that requires the
frequency to be set to Y. The schedutil governor changes the frequency
to Y, updates last_freq_update_time and we wait for 10 ms to reevaluate
the frequency again. After 10 ms, the schedutil governor reevaluates the
load and finds it to be the same. And so it doesn't update the
frequency, but updates last_freq_update_time before returning. Right
after this point, the scheduler puts more load on the CPU and the CPU
needs to go to a higher frequency Z. Because last_freq_update_time was
updated just now, the schedutil governor waits for additional 10ms
before reevaluating the load again.

Normally, the time it takes to reevaluate the frequency is negligible
compared to the time it takes to change the frequency. And considering
that in the above scenario, as we haven't updated the frequency for over
10ms, we should have changed the frequency as soon as the load changed.

This patch changes the way rate_limit_us is used, i.e. It now governs
"How frequently we change the frequency" instead of "How frequently we
reevaluate the frequency".

One may think that this change may have increased the number of times we
reevaluate the frequency after a period of rate_limit_us has expired
since the last change, if the load isn't changing. But that is protected
by the scheduler as normally it doesn't call into the schedutil governor
before 1 ms (Hint: "decayed" in update_cfs_rq_load_avg()) since the
last call.

Tests were performed with this patch on a Dual cluster (same frequency
domain), octa-core ARM64 platform (Hikey). Hackbench (Debian) and
Vellamo/Galleryfling (Android) didn't had much difference in
performance w/ or w/o this patch.

Its difficult to create a test case (tried rt-app as well) where this
patch will show a lot of improvements as the target of this patch is a
real corner case. I.e. Current load is X (resulting in freq change),
load after rate_limit_us is also X, but right after that load becomes Y.
Undoubtedly this patch would improve the responsiveness in such cases.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
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
