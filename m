From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH v1 2/8] sched/deadline: move cpu frequency selection triggering points
Date: Wed,  5 Jul 2017 09:58:59 +0100
Message-ID: <20170705085905.6558-3-juri.lelli@arm.com>
References: <20170705085905.6558-1-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170705085905.6558-1-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, juri.lelli@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

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
---
Changes from RFCv0:

 - modify comment regarding periodic RT updates (Claudio)
---
 kernel/sched/deadline.c |  7 ++++---
 kernel/sched/sched.h    | 12 ++++++------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a84299f44b5d..6912f7f35f9b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -85,6 +85,8 @@ void add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 	dl_rq->running_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
+	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
+	cpufreq_update_this_cpu(rq_of_dl_rq(dl_rq), SCHED_CPUFREQ_DL);
 }
 
 static inline
@@ -97,6 +99,8 @@ void sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
 	if (dl_rq->running_bw > old)
 		dl_rq->running_bw = 0;
+	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
+	cpufreq_update_this_cpu(rq_of_dl_rq(dl_rq), SCHED_CPUFREQ_DL);
 }
 
 static inline
@@ -1135,9 +1139,6 @@ static void update_curr_dl(struct rq *rq)
 		return;
 	}
 
-	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_DL);
-
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eeef1a3086d1..d8798bb54ace 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2057,14 +2057,14 @@ DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
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
2.11.0
