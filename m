From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v3 2/6] cpufreq: schedutil: ensure max frequency while running RT/DL tasks
Date: Thu, 30 Nov 2017 11:47:19 +0000
Message-ID: <20171130114723.29210-3-patrick.bellasi@arm.com>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171130114723.29210-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

The policy in use for RT/DL tasks sets the maximum frequency when a task
in these classes calls for a cpufreq_update_util().  However, the
current implementation might cause a frequency drop while a RT/DL task
is still running, just because for example a FAIR task wakes up and it's
enqueued in the same CPU.

This issue is due to the sg_cpu's flags being overwritten at each call
of sugov_update_*. Thus, the wakeup of a FAIR task resets the flags and
can trigger a frequency update thus affecting the currently running
RT/DL task.

This can be fixed, in shared frequency domains, by ORing (instead of
overwriting) the new flag before triggering a frequency update.  This
grants to stay at least at the frequency requested by the RT/DL class,
which is the maximum one for the time being.

This patch does the flags aggregation in the schedutil governor, where
it's easy to verify if we currently have RT/DL workload on a CPU.
This approach is aligned with the current schedutil API design where the
core scheduler does not interact directly with schedutil, while instead
are the scheduling classes which call directly into the policy via
cpufreq_update_util. Thus, it makes more sense to have flags
aggregation in the schedutil code instead of the core scheduler.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steve Muckle <smuckle.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes from v2:
- rebased on v4.15-rc1

Changes from v1:
- use "current" to check for RT/DL tasks (PeterZ)

Change-Id: Ia4bd6ae09ae034a954d37cd38ffea86396ac1257
---
 kernel/sched/cpufreq_schedutil.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 67339ccb5595..448f49de5335 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -262,6 +262,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned long util, max;
 	unsigned int next_f;
+	bool rt_mode;
 	bool busy;
 
 	sugov_set_iowait_boost(sg_cpu, time, flags);
@@ -272,7 +273,15 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	busy = sugov_cpu_is_busy(sg_cpu);
 
-	if (flags & SCHED_CPUFREQ_RT_DL) {
+	/*
+	 * While RT/DL tasks are running we do not want FAIR tasks to
+	 * overvrite this CPU's flags, still we can update utilization and
+	 * frequency (if required/possible) to be fair with these tasks.
+	 */
+	rt_mode = task_has_dl_policy(current) ||
+		  task_has_rt_policy(current) ||
+		  (flags & SCHED_CPUFREQ_RT_DL);
+	if (rt_mode) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
 		sugov_get_util(&util, &max, sg_cpu->cpu);
@@ -340,6 +349,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long util, max;
 	unsigned int next_f;
+	bool rt_mode;
 
 	sugov_get_util(&util, &max, sg_cpu->cpu);
 
@@ -353,17 +363,27 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 		sg_cpu->flags = 0;
 		goto done;
 	}
-	sg_cpu->flags = flags;
+
+	/*
+	 * While RT/DL tasks are running we do not want FAIR tasks to
+	 * overwrite this CPU's flags, still we can update utilization and
+	 * frequency (if required/possible) to be fair with these tasks.
+	 */
+	rt_mode = task_has_dl_policy(current) ||
+		  task_has_rt_policy(current) ||
+		  (flags & SCHED_CPUFREQ_RT_DL);
+	if (rt_mode)
+		sg_cpu->flags |= flags;
+	else
+		sg_cpu->flags = flags;
 
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
-		if (flags & SCHED_CPUFREQ_RT_DL)
-			next_f = sg_policy->policy->cpuinfo.max_freq;
-		else
-			next_f = sugov_next_freq_shared(sg_cpu, time);
-
+		next_f = rt_mode
+			? sg_policy->policy->cpuinfo.max_freq
+			: sugov_next_freq_shared(sg_cpu, time);
 		sugov_update_commit(sg_policy, time, next_f);
 	}
 
-- 
2.14.1
