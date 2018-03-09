From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v6 3/4] sched/cpufreq_schedutil: use util_est for OPP selection
Date: Fri,  9 Mar 2018 09:52:44 +0000
Message-ID: <20180309095245.11071-4-patrick.bellasi@arm.com>
References: <20180309095245.11071-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309095245.11071-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

When schedutil looks at the CPU utilization, the current PELT value for
that CPU is returned straight away. In certain scenarios this can have
undesired side effects and delays on frequency selection.

For example, since the task utilization is decayed at wakeup time, a
long sleeping big task newly enqueued does not add immediately a
significant contribution to the target CPU. This introduces some latency
before schedutil will be able to detect the best frequency required by
that task.

Moreover, the PELT signal build-up time is a function of the current
frequency, because of the scale invariant load tracking support. Thus,
starting from a lower frequency, the utilization build-up time will
increase even more and further delays the selection of the actual
frequency which better serves the task requirements.

In order to reduce this kind of latencies, we integrate the usage
of the CPU's estimated utilization in the sugov_get_util function.
This allows to properly consider the expected utilization of a CPU which,
for example, has just got a big task running after a long sleep period.
Ultimately this allows to select the best frequency to run a task
right after its wake-up.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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
Changes in v6:
 - small code cleanup suggested by Peter
 - add acked-by Viresh tag

Changes in v5:
 - add missing READ_ONCE() barrieres
 - add acked-by Rafael tag

Changes in v4:
 - rebased on today's tip/sched/core (commit 460e8c3340a2)
 - use util_est.enqueued for cfs_rq's util_est (Joel)
 - simplify cpu_util_cfs() integration (Dietmar)

Changes in v3:
 - rebase on today's tip/sched/core (commit 07881166a892)
 - moved into Juri's cpu_util_cfs(), which should also
   address Rafael's suggestion to use a local variable.

Changes in v2:
 - rebase on top of v4.15-rc2
 - tested that overhauled PELT code does not affect the util_est
---
 kernel/sched/sched.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index dc6c8b5a24ad..5c459479593b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2122,7 +2122,14 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
 
 static inline unsigned long cpu_util_cfs(struct rq *rq)
 {
-	return rq->cfs.avg.util_avg;
+	unsigned long util = READ_ONCE(rq->cfs.avg.util_avg);
+
+	if (sched_feat(UTIL_EST)) {
+		util = max_t(unsigned long, util,
+			     READ_ONCE(rq->cfs.avg.util_est.enqueued));
+	}
+
+	return util;
 }
 
 #endif
-- 
2.15.1
