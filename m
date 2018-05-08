From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] sched/schedutil: Don't set next_freq to UINT_MAX
Date: Tue,  8 May 2018 12:12:42 +0530
Message-ID: <872c3f8690d9362820639d91a807e535f10a9a36.1525761635.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, claudio@evidence.eu.com, patrick.bellasi@arm.com, juri.lelli@redhat.com, joelaf@google.com, "4 . 12+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The schedutil driver sets sg_policy->next_freq to UINT_MAX on certain
occasions:
- In sugov_start(), when the schedutil governor is started for a group
  of CPUs.
- And whenever we need to force a freq update before rate-limit
  duration, which happens when:
  - there is an update in cpufreq policy limits.
  - Or when the utilization of DL scheduling class increases.

In return, get_next_freq() doesn't return a cached next_freq value but
instead recalculates the next frequency. This has some side effects
though and may significantly delay a required increase in frequency.

In sugov_update_single() we try to avoid decreasing frequency if the CPU
has not been idle recently. Consider this scenario, the available range
of frequencies for a CPU are from 800 MHz to 2.5 GHz and current
frequency is 800 MHz. From one of the call paths
sg_policy->need_freq_update is set to true and hence
sg_policy->next_freq is set to UINT_MAX. Now if the CPU had been busy,
next_f will always be less than UINT_MAX, whatever the value of next_f
is. And so even when we wanted to increase the frequency, we will
overwrite next_f with UINT_MAX and will not change the frequency
eventually. This will continue until the time CPU stays busy. This isn't
cross checked with any specific test cases, but rather based on general
code review.

Fix that by not resetting the sg_policy->need_freq_update flag from
sugov_should_update_freq() but get_next_freq() and we wouldn't need to
overwrite sg_policy->next_freq anymore.

Cc: 4.12+ <stable@vger.kernel.org> # 4.12+
Fixes: b7eaf1aab9f8 ("cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index d2c6083304b4..daaca23697dc 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -95,15 +95,8 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	if (sg_policy->work_in_progress)
 		return false;
 
-	if (unlikely(sg_policy->need_freq_update)) {
-		sg_policy->need_freq_update = false;
-		/*
-		 * This happens when limits change, so forget the previous
-		 * next_freq value and force an update.
-		 */
-		sg_policy->next_freq = UINT_MAX;
+	if (unlikely(sg_policy->need_freq_update))
 		return true;
-	}
 
 	delta_ns = time - sg_policy->last_freq_update_time;
 
@@ -165,8 +158,10 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 
 	freq = (freq + (freq >> 2)) * util / max;
 
-	if (freq == sg_policy->cached_raw_freq && sg_policy->next_freq != UINT_MAX)
+	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
+
+	sg_policy->need_freq_update = false;
 	sg_policy->cached_raw_freq = freq;
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
@@ -670,7 +665,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 
 	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
 	sg_policy->last_freq_update_time	= 0;
-	sg_policy->next_freq			= UINT_MAX;
+	sg_policy->next_freq			= 0;
 	sg_policy->work_in_progress		= false;
 	sg_policy->need_freq_update		= false;
 	sg_policy->cached_raw_freq		= 0;
-- 
2.15.0.194.g9af6a3dea062
