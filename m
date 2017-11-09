From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH 4/4] sched/cpufreq_schedutil: use util_est for OPP selection
Date: Thu,  9 Nov 2017 16:41:17 +0000
Message-ID: <20171109164117.19401-5-patrick.bellasi@arm.com>
References: <20171109164117.19401-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171109164117.19401-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When schedutil looks at the CPU utilization, the current PELT value for
that CPU is returned straight away. In certain scenarios this can have
undesired side effects and delays on frequency selection.

For example, since the task utilization is decayed at wakeup time, a
long sleeping big task newly enqueued it does not add immediately a
significant contribution to the target CPU. This introduces some latency
before schedutil will be able to detect the best frequency required by
that task.

Moreover, the PELT signal building up time is function of the current
frequency, because of the scale invariant load tracking support. Thus,
starting from a lower frequency, the utilization build-up time will
increase even more and further delays the selection of the actual
frequency which better serves the task requirements.

In order to reduce these kind of latencies, this patch integrates the
usage of the CPU's estimated utilization in the sugov_get_util function.

The estimated utilization of a CPU is defined to be the maximum between
its PELT's utilization and the sum of the estimated utilization of each
currently RUNNABLE task on that CPU.
This allows to properly represent the expected utilization of a CPU which,
for example, it has just got a big task running after a long sleep period,
and ultimately it allows to select the best frequency to run a task
right after its wakes up.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Reviewed-by: Brendan Jackman <brendan.jackman@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Paul Turner <pjt@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/cpufreq_schedutil.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 137733db6727..d72231e30d44 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -183,7 +183,11 @@ static void sugov_get_util(unsigned long *util, unsigned long *max, int cpu)
 
 	cfs_max = arch_scale_cpu_capacity(NULL, cpu);
 
-	*util = min(rq->cfs.avg.util_avg, cfs_max);
+	*util = rq->cfs.avg.util_avg;
+	if (sched_feat(UTIL_EST))
+		*util = max(*util, rq->cfs.util_est_runnable);
+	*util = min(*util, cfs_max);
+
 	*max = cfs_max;
 }
 
-- 
2.14.1
