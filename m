From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v3 5/6] cpufreq: schedutil: relax rate-limiting while running RT/DL tasks
Date: Thu, 30 Nov 2017 11:47:22 +0000
Message-ID: <20171130114723.29210-6-patrick.bellasi@arm.com>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171130114723.29210-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

The policy in use for RT/DL tasks sets the maximum frequency when a task
in these classes calls for a cpufreq_update_util().  However, the
current implementation is still enforcing a frequency switch rate
limiting when these tasks are running.
This is potentially working against the goal to switch to the maximum OPP
when RT tasks are running. In certain unfortunate cases it can also happen
that a RT task almost completes its activation at a lower OPP.

This patch overrides on purpose the rate limiting configuration
to better serve RT/DL tasks. As long as a frequency scaling operation
is not in progress, a frequency switch is always authorized when
running in "rt_mode", i.e. the current task in a CPU belongs to the
RT/DL class.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes from v2:
- rebased on v4.15-rc1

Change-Id: I733d47b9e265cebb2e3e5e71a3cd468e9be002d1
---
 kernel/sched/cpufreq_schedutil.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 40521d59630b..3eea8884e61b 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -74,7 +74,8 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
-static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
+static bool sugov_should_update_freq(struct sugov_policy *sg_policy,
+				     u64 time, bool rt_mode)
 {
 	s64 delta_ns;
 
@@ -111,6 +112,10 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 		return true;
 	}
 
+	/* Always update if a RT/DL task is running */
+	if (rt_mode)
+		return true;
+
 	delta_ns = time - sg_policy->last_freq_update_time;
 	return delta_ns >= sg_policy->freq_update_delay_ns;
 }
@@ -268,11 +273,6 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
-	if (!sugov_should_update_freq(sg_policy, time))
-		return;
-
-	busy = sugov_cpu_is_busy(sg_cpu);
-
 	/*
 	 * While RT/DL tasks are running we do not want FAIR tasks to
 	 * overvrite this CPU's flags, still we can update utilization and
@@ -281,6 +281,11 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	rt_mode = task_has_dl_policy(current) ||
 		  task_has_rt_policy(current) ||
 		  (flags & SCHED_CPUFREQ_RT_DL);
+	if (!sugov_should_update_freq(sg_policy, time, rt_mode))
+		return;
+
+	busy = sugov_cpu_is_busy(sg_cpu);
+
 	if (rt_mode) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
@@ -379,7 +384,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
-	if (sugov_should_update_freq(sg_policy, time)) {
+	if (sugov_should_update_freq(sg_policy, time, rt_mode)) {
 		next_f = rt_mode
 			? sg_policy->policy->cpuinfo.max_freq
 			: sugov_next_freq_shared(sg_cpu, time);
-- 
2.14.1
