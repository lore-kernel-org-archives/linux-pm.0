From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH RFC 8/8] sched/deadline: make bandwidth enforcement scale-invariant
Date: Tue, 23 May 2017 09:53:51 +0100
Message-ID: <20170523085351.18586-9-juri.lelli@arm.com>
References: <20170523085351.18586-1-juri.lelli@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936737AbdEWIzD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 May 2017 04:55:03 -0400
In-Reply-To: <20170523085351.18586-1-juri.lelli@arm.com>
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
Changes from RFD
 - either apply grub_reclaim or perform freq/cpu scaling;
   what's the correct thing to do it's actually very much up
   for discussion
---
 kernel/sched/deadline.c | 26 ++++++++++++++++++++++----
 kernel/sched/fair.c     |  2 --
 kernel/sched/sched.h    |  2 ++
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5ee4fd9b1c7f..b6c3886478c3 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1008,7 +1008,8 @@ static void update_curr_dl(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_dl_entity *dl_se = &curr->dl;
-	u64 delta_exec;
+	u64 delta_exec, scaled_delta_exec;
+	int cpu = cpu_of(rq);
 
 	if (!dl_task(curr) || !on_dl_rq(dl_se))
 		return;
@@ -1042,9 +1043,26 @@ static void update_curr_dl(struct rq *rq)
 	if (unlikely(dl_entity_is_special(dl_se)))
 		return;
 
-	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM))
-		delta_exec = grub_reclaim(delta_exec, rq, &curr->dl);
-	dl_se->runtime -= delta_exec;
+	/*
+	 * For tasks that participate in GRUB, we implement GRUB-PA: the
+	 * spare reclaimed bandwidth is used to clock down frequency.
+	 *
+	 * For the others, we still need to scale reservation parameters
+	 * according to current frequency and CPU maximum capacity.
+	 */
+	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM)) {
+		scaled_delta_exec = grub_reclaim(delta_exec,
+						 rq,
+						 &curr->dl);
+	} else {
+		unsigned long scale_freq = arch_scale_freq_capacity(cpu);
+		unsigned long scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
+
+		scaled_delta_exec = cap_scale(delta_exec, scale_freq);
+		scaled_delta_exec = cap_scale(scaled_delta_exec, scale_cpu);
+	}
+
+	dl_se->runtime -= scaled_delta_exec;
 
 throttle:
 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b0f31064bbbd..39224813e038 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2781,8 +2781,6 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
 	return c1 + c2 + c3;
 }
 
-#define cap_scale(v, s) ((v)*(s) >> SCHED_CAPACITY_SHIFT)
-
 /*
  * Accumulate the three separate parts of the sum; d1 the remainder
  * of the last (incomplete) period, d2 the span of full periods and d3
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cc474c62cd18..019c46768ecb 100644
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
2.11.0
