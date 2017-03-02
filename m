From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH 3/6] cpufreq: schedutil: ensure max frequency while running RT/DL tasks
Date: Thu,  2 Mar 2017 15:45:04 +0000
Message-ID: <1488469507-32463-4-git-send-email-patrick.bellasi@arm.com>
References: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752783AbdCBPqj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Mar 2017 10:46:39 -0500
In-Reply-To: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

The policy in use for RT/DL tasks sets the maximum frequency when a task
in these classes calls for a cpufreq_update_this_cpu().  However, the
current implementation might cause a frequency drop while a RT/DL task
is still running, just because for example a FAIR task wakes up and is
enqueued in the same CPU.

This issue is due to the sg_cpu's flags being overwritten at each call
of sugov_update_*. The wakeup of a FAIR task resets the flags and can
trigger a frequency update thus affecting the currently running RT/DL
task.

This can be fixed, in shared frequency domains, by adding (instead of
overwriting) the new flags before triggering a frequency update.  This
grants to stay at least at the frequency requested by the RT/DL class,
which is the maximum one for the time being, but can also be lower when
for example DL will be extended to provide a precise bandwidth
requirement.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/cpufreq_schedutil.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index a3fe5e4..b98a167 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -196,10 +196,21 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 				unsigned int flags)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
+	struct task_struct *curr = cpu_curr(smp_processor_id());
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned long util, max;
 	unsigned int next_f;
+	bool rt_mode;
+
+	/*
+	 * While RT/DL tasks are running we do not want FAIR tasks to
+	 * overvrite this CPU's flags, still we can update utilization and
+	 * frequency (if required/possible) to be fair with these tasks.
+	 */
+	rt_mode = task_has_dl_policy(curr) ||
+		  task_has_rt_policy(curr) ||
+		  (flags & SCHED_CPUFREQ_RT_DL);
 
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
@@ -207,7 +218,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
-	if (flags & SCHED_CPUFREQ_RT_DL) {
+	if (rt_mode) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
 		sugov_get_util(&util, &max);
@@ -278,6 +289,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	struct task_struct *curr = cpu_curr(cpu);
 	unsigned long util, max;
 	unsigned int next_f;
+	bool rt_mode;
 
 	sugov_get_util(&util, &max);
 
@@ -293,15 +305,29 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	if (curr == sg_policy->thread)
 		goto done;
 
+	/*
+	 * While RT/DL tasks are running we do not want FAIR tasks to
+	 * overwrite this CPU's flags, still we can update utilization and
+	 * frequency (if required/possible) to be fair with these tasks.
+	 */
+	rt_mode = task_has_dl_policy(curr) ||
+		  task_has_rt_policy(curr) ||
+		  (flags & SCHED_CPUFREQ_RT_DL);
+	if (rt_mode)
+		sg_cpu->flags |= flags;
+	else
+		sg_cpu->flags = flags;
+
 	sg_cpu->util = util;
 	sg_cpu->max = max;
-	sg_cpu->flags = flags;
 
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
-		next_f = sugov_next_freq_shared(sg_cpu, util, max, flags);
+		next_f = sg_policy->policy->cpuinfo.max_freq;
+		if (!rt_mode)
+			next_f = sugov_next_freq_shared(sg_cpu, util, max, flags);
 		sugov_update_commit(sg_policy, time, next_f);
 	}
 
-- 
2.7.4
