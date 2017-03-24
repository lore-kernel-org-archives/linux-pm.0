From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFD PATCH 5/5] sched/deadline: make bandwidth enforcement scale-invariant
Date: Fri, 24 Mar 2017 14:09:00 +0000
Message-ID: <20170324140900.7334-6-juri.lelli@arm.com>
References: <20170324140900.7334-1-juri.lelli@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935823AbdCXOJr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Mar 2017 10:09:47 -0400
In-Reply-To: <20170324140900.7334-1-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, juri.lelli@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

Apply frequency and cpu scale-invariance correction factor to bandwidth
enforcement (similar to what we already do to fair utilization tracking).

Each delta_exec gets scaled considering current frequency and maximum
cpu capacity; which means that the reservation runtime parameter (that
need to be specified profiling the task execution at max frequency on
biggest capacity core) gets thus scaled accordingly.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Claudio Scordino <claudio@evidence.eu.com>
---
 kernel/sched/deadline.c | 27 +++++++++++++++++++++++----
 kernel/sched/fair.c     |  2 --
 kernel/sched/sched.h    |  2 ++
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 853de524c6c6..7141d6f51ee0 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -940,7 +940,9 @@ static void update_curr_dl(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_dl_entity *dl_se = &curr->dl;
-	u64 delta_exec;
+	u64 delta_exec, scaled_delta_exec;
+	unsigned long scale_freq, scale_cpu;
+	int cpu = cpu_of(rq);
 
 	if (!dl_task(curr) || !on_dl_rq(dl_se))
 		return;
@@ -974,9 +976,26 @@ static void update_curr_dl(struct rq *rq)
 	if (unlikely(dl_entity_is_special(dl_se)))
 		return;
 
-	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM))
-		delta_exec = grub_reclaim(delta_exec, rq, curr->dl.dl_bw);
-	dl_se->runtime -= delta_exec;
+	/*
+	 * XXX When clock frequency is controlled by the scheduler (via
+	 * schedutil governor) we implement GRUB-PA: the spare reclaimed
+	 * bandwidth is used to clock down frequency.
+	 *
+	 * However, what below seems to assume scheduler to always be in
+	 * control of clock frequency; when running at a fixed frequency
+	 * (e.g., performance or userspace governor), shouldn't we instead
+	 * use the grub_reclaim mechanism below?
+	 *
+	 * if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM))
+	 *	delta_exec = grub_reclaim(delta_exec, rq, curr->dl.dl_bw);
+	 * dl_se->runtime -= delta_exec;
+	 */
+	scale_freq = arch_scale_freq_capacity(NULL, cpu);
+	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
+
+	scaled_delta_exec = cap_scale(delta_exec, scale_freq);
+	scaled_delta_exec = cap_scale(scaled_delta_exec, scale_cpu);
+	dl_se->runtime -= scaled_delta_exec;
 
 throttle:
 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2805bd7c8994..37f12d0a3bc4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2818,8 +2818,6 @@ static u32 __compute_runnable_contrib(u64 n)
 	return contrib + runnable_avg_yN_sum[n];
 }
 
-#define cap_scale(v, s) ((v)*(s) >> SCHED_CAPACITY_SHIFT)
-
 /*
  * We can represent the historical contribution to runnable average as the
  * coefficients of a geometric series.  To do this we sub-divide our runnable
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7b5e81120813..81bd048ed181 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -155,6 +155,8 @@ static inline int task_has_dl_policy(struct task_struct *p)
 	return dl_policy(p->policy);
 }
 
+#define cap_scale(v, s) ((v)*(s) >> SCHED_CAPACITY_SHIFT)
+
 static inline int dl_entity_is_special(struct sched_dl_entity *dl_se)
 {
 	return dl_se->flags & SCHED_FLAG_SPECIAL;
-- 
2.10.0
