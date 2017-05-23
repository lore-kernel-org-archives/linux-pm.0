From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH RFC 2/8] sched/deadline: move cpu frequency selection triggering points
Date: Tue, 23 May 2017 09:53:45 +0100
Message-ID: <20170523085351.18586-3-juri.lelli@arm.com>
References: <20170523085351.18586-1-juri.lelli@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936682AbdEWIyf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 May 2017 04:54:35 -0400
In-Reply-To: <20170523085351.18586-1-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, juri.lelli@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

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
 kernel/sched/deadline.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1da44b36fae0..fed54b078240 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -52,6 +52,8 @@ void add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 	dl_rq->running_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
+	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
+	cpufreq_update_this_cpu(rq_of_dl_rq(dl_rq), SCHED_CPUFREQ_DL);
 }
 
 static inline
@@ -64,6 +66,8 @@ void sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
 	if (dl_rq->running_bw > old)
 		dl_rq->running_bw = 0;
+	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
+	cpufreq_update_this_cpu(rq_of_dl_rq(dl_rq), SCHED_CPUFREQ_DL);
 }
 
 static inline
@@ -1021,9 +1025,6 @@ static void update_curr_dl(struct rq *rq)
 		return;
 	}
 
-	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_DL);
-
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
 
-- 
2.11.0
