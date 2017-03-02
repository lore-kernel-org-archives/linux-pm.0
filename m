From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH 4/6] cpufreq: schedutil: relax rate-limiting while running RT/DL tasks
Date: Thu,  2 Mar 2017 15:45:05 +0000
Message-ID: <1488469507-32463-5-git-send-email-patrick.bellasi@arm.com>
References: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

The policy in use for RT/DL tasks sets the maximum frequency when a task
in these classes calls for a cpufreq_update_this_cpu().  However, the
current implementation is still enforcing a frequency switch rate
limiting when these tasks are running.
This is potentially working against the goal to switch to the maximum OPP
when RT tasks are running. In certain unfortunate cases it can also happen
that a RT task almost complete its activation at a lower OPP.

This patch overrides on purpose the rate limiting configuration
to better serve RT/DL tasks. As long as a frequency scaling operation
is not in progress, a frequency switch is always authorized when
running in "rt_mode", i.e. the current task in a CPU belongs to the
RT/DL class.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/cpufreq_schedutil.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index b98a167..44bff37 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -66,7 +66,8 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
-static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
+static bool sugov_should_update_freq(struct sugov_policy *sg_policy,
+				     u64 time, bool rt_mode)
 {
 	s64 delta_ns;
 
@@ -83,6 +84,10 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 		return true;
 	}
 
+	/* Always update if a RT/DL task is running */
+	if (rt_mode)
+		return true;
+
 	delta_ns = time - sg_policy->last_freq_update_time;
 	return delta_ns >= sg_policy->freq_update_delay_ns;
 }
@@ -215,7 +220,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
-	if (!sugov_should_update_freq(sg_policy, time))
+	if (!sugov_should_update_freq(sg_policy, time, rt_mode))
 		return;
 
 	if (rt_mode) {
@@ -324,7 +329,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
-	if (sugov_should_update_freq(sg_policy, time)) {
+	if (sugov_should_update_freq(sg_policy, time, rt_mode)) {
 		next_f = sg_policy->policy->cpuinfo.max_freq;
 		if (!rt_mode)
 			next_f = sugov_next_freq_shared(sg_cpu, util, max, flags);
-- 
2.7.4
