From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC 3/3] sched/cpufreq_schedutil: use util_est for OPP selection
Date: Fri, 25 Aug 2017 11:20:08 +0100
Message-ID: <20170825102008.4626-4-patrick.bellasi@arm.com>
References: <20170825102008.4626-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170825102008.4626-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

When the schedutil looks at the CPU utlization, the current PELT value for
that CPU is returned straight away. In certain scenarios this can have
undesired side effects and delays on frequency selection.

For example, since the task utilization is decayed at wakeup time, when
a long sleeping big task is enqueued it does not add immediately a
significant contribution to the target CPU. This introduces some latency
before schedutil will be able to detect the best frequency required by
that task.

Moreover, the PELT signal building up time is function of the current
frequency, becasue of the scale invariant load tracking support. Thus,
starting from a lower frequency, the utilization build-up time will
increase even more and further delays the selection of the actual
frequency which better serves the task requirements.

In order to reduce these kind of latencies, this patch integrates the usage
of the CPU's estimated utlization in the sugov_get_util function.

The estimated utilization of a CPU is defined to be the maximum between its
PELT's utilization and the sum of the estimated utilization of each task
currently RUNNABLE on that CPU.
This allows to properly represent the expected utilization of a CPU which,
for example, it has just got a big task running after a long sleep period,
and ultimately it allows to select the best frequency to run a task
right after it wakes up.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Turner <pjt@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/cpufreq_schedutil.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 910a915fef8b..aacba9f7202e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -161,7 +161,12 @@ static void sugov_get_util(unsigned long *util, unsigned long *max)
 
 	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
 
-	*util = min(rq->cfs.avg.util_avg, cfs_max);
+	*util = rq->cfs.avg.util_avg;
+	if (sched_feat(UTIL_EST))
+		*util = max(*util,
+			    util_est(&rq->cfs.avg, UTIL_EST_MAX_EWMA_LAST));
+	*util = min(*util, cfs_max);
+
 	*max = cfs_max;
 }
 
-- 
2.14.1
