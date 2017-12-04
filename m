From: Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH v2 2/8] sched/deadline: move cpu frequency selection triggering points
Date: Mon,  4 Dec 2017 11:23:19 +0100
Message-ID: <20171204102325.5110-3-juri.lelli@redhat.com>
References: <20171204102325.5110-1-juri.lelli@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171204102325.5110-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, alessio.balsini@arm.com, juri.lelli@redhat.com, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Juri Lelli <juri.lelli@arm.com>

Since SCHED_DEADLINE doesn't track utilization signal (but reserves a
fraction of CPU bandwidth to tasks admitted to the system), there is no
point in evaluating frequency changes during each tick event.

Move frequency selection triggering points to where running_bw changes.

Co-authored-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/deadline.c |  7 ++++---
 kernel/sched/sched.h    | 12 ++++++------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2473736c7616..7e4038bf9954 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -86,6 +86,8 @@ void add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 	dl_rq->running_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
+	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
+	cpufreq_update_util(rq_of_dl_rq(dl_rq), SCHED_CPUFREQ_DL);
 }
 
 static inline
@@ -98,6 +100,8 @@ void sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
 	if (dl_rq->running_bw > old)
 		dl_rq->running_bw = 0;
+	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
+	cpufreq_update_util(rq_of_dl_rq(dl_rq), SCHED_CPUFREQ_DL);
 }
 
 static inline
@@ -1134,9 +1138,6 @@ static void update_curr_dl(struct rq *rq)
 		return;
 	}
 
-	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq, SCHED_CPUFREQ_DL);
-
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b19552a212de..a1730e39cbc6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2096,14 +2096,14 @@ DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
  * The way cpufreq is currently arranged requires it to evaluate the CPU
  * performance state (frequency/voltage) on a regular basis to prevent it from
  * being stuck in a completely inadequate performance level for too long.
- * That is not guaranteed to happen if the updates are only triggered from CFS,
- * though, because they may not be coming in if RT or deadline tasks are active
- * all the time (or there are RT and DL tasks only).
+ * That is not guaranteed to happen if the updates are only triggered from CFS
+ * and DL, though, because they may not be coming in if only RT tasks are
+ * active all the time (or there are RT tasks only).
  *
- * As a workaround for that issue, this function is called by the RT and DL
- * sched classes to trigger extra cpufreq updates to prevent it from stalling,
+ * As a workaround for that issue, this function is called periodically by the
+ * RT sched class to trigger extra cpufreq updates to prevent it from stalling,
  * but that really is a band-aid.  Going forward it should be replaced with
- * solutions targeted more specifically at RT and DL tasks.
+ * solutions targeted more specifically at RT tasks.
  */
 static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
 {
-- 
2.14.3
