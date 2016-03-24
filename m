From: Steve Muckle <steve.muckle@linaro.org>
Subject: [RFC PATCH] sched/fair: call cpufreq hook in additional paths
Date: Thu, 24 Mar 2016 15:26:07 -0700
Message-ID: <1458858367-2831-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32872 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbcCXW0L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 18:26:11 -0400
Received: by mail-pf0-f176.google.com with SMTP id 4so68489810pfd.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Mar 2016 15:26:11 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Byungchul Park <byungchul.park@lge.com>

The cpufreq hook should be called any time the root CFS rq utilization
changes. This can occur when a task is switched to or from the fair
class, or a task moves between groups or CPUs, but these paths
currently do not call the cpufreq hook.

Fix this by adding the hook to attach_entity_load_avg() and
detach_entity_load_avg().

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
Unfortunately this means that in the migration case,
enqueue_entity_load_avg() will end up calling the cpufreq hook twice -
once via update_cfs_rq_load_avg() and once via
attach_entity_load_avg(). This should ideally get filtered out before
the cpufreq driver is invoked but nevertheless is wasteful. Possible
alternatives to this are

 - moving the cpufreq hook from update_cfs_rq_load_avg() into                                                    
   its callers (there are three) and also putting the hook                                                       
   in attach_task_cfs_rq and detach_task_cfs_rq, resulting in                                                    
   five call sites of the hook in fair.c as opposed to three                                                               

 - passing an argument into attach_entity_load_avg() to indicate                                                 
   whether calling the cpufreq hook is necessary

Both of these are ugly in their own way but would avoid a runtime
cost. Opinions welcome.

Note that this patch depends on the 2 patches I sent several days ago:
http://thread.gmane.org/gmane.linux.kernel/2181498

 kernel/sched/fair.c | 62 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index af58e826cffe..73f18f2fc9f5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2821,13 +2821,40 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force) {}
 
 static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq);
 
+static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
+{
+	struct rq *rq = rq_of(cfs_rq);
+	int cpu = cpu_of(rq);
+
+	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
+		unsigned long max = rq->cpu_capacity_orig;
+
+		/*
+		 * There are a few boundary cases this might miss but it should
+		 * get called often enough that that should (hopefully) not be
+		 * a real problem -- added to that it only calls on the local
+		 * CPU, so if we enqueue remotely we'll miss an update, but
+		 * the next tick/schedule should update.
+		 *
+		 * It will not get called when we go idle, because the idle
+		 * thread is a different class (!fair), nor will the utilization
+		 * number include things like RT tasks.
+		 *
+		 * As is, the util number is not freq-invariant (we'd have to
+		 * implement arch_scale_freq_capacity() for that).
+		 *
+		 * See cpu_util().
+		 */
+		cpufreq_update_util(rq_clock(rq),
+				    min(cfs_rq->avg.util_avg, max), max);
+	}
+}
+
 /* Group cfs_rq's load_avg is used for task_h_load and update_cfs_share */
 static inline int update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 {
 	struct sched_avg *sa = &cfs_rq->avg;
-	struct rq *rq = rq_of(cfs_rq);
 	int decayed, removed_load = 0, removed_util = 0;
-	int cpu = cpu_of(rq);
 
 	if (atomic_long_read(&cfs_rq->removed_load_avg)) {
 		s64 r = atomic_long_xchg(&cfs_rq->removed_load_avg, 0);
@@ -2843,7 +2870,7 @@ static inline int update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		removed_util = 1;
 	}
 
-	decayed = __update_load_avg(now, cpu, sa,
+	decayed = __update_load_avg(now, cpu_of(rq_of(cfs_rq)), sa,
 		scale_load_down(cfs_rq->load.weight), cfs_rq->curr != NULL, cfs_rq);
 
 #ifndef CONFIG_64BIT
@@ -2851,29 +2878,8 @@ static inline int update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	cfs_rq->load_last_update_time_copy = sa->last_update_time;
 #endif
 
-	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq &&
-	    (decayed || removed_util)) {
-		unsigned long max = rq->cpu_capacity_orig;
-
-		/*
-		 * There are a few boundary cases this might miss but it should
-		 * get called often enough that that should (hopefully) not be
-		 * a real problem -- added to that it only calls on the local
-		 * CPU, so if we enqueue remotely we'll miss an update, but
-		 * the next tick/schedule should update.
-		 *
-		 * It will not get called when we go idle, because the idle
-		 * thread is a different class (!fair), nor will the utilization
-		 * number include things like RT tasks.
-		 *
-		 * As is, the util number is not freq-invariant (we'd have to
-		 * implement arch_scale_freq_capacity() for that).
-		 *
-		 * See cpu_util().
-		 */
-		cpufreq_update_util(rq_clock(rq),
-				    min(sa->util_avg, max), max);
-	}
+	if (decayed || removed_util)
+		cfs_rq_util_change(cfs_rq);
 
 	return decayed || removed_load;
 }
@@ -2923,6 +2929,8 @@ skip_aging:
 	cfs_rq->avg.load_sum += se->avg.load_sum;
 	cfs_rq->avg.util_avg += se->avg.util_avg;
 	cfs_rq->avg.util_sum += se->avg.util_sum;
+
+	cfs_rq_util_change(cfs_rq);
 }
 
 static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -2935,6 +2943,8 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	cfs_rq->avg.load_sum = max_t(s64,  cfs_rq->avg.load_sum - se->avg.load_sum, 0);
 	cfs_rq->avg.util_avg = max_t(long, cfs_rq->avg.util_avg - se->avg.util_avg, 0);
 	cfs_rq->avg.util_sum = max_t(s32,  cfs_rq->avg.util_sum - se->avg.util_sum, 0);
+
+	cfs_rq_util_change(cfs_rq);
 }
 
 /* Add the load generated by se into cfs_rq's load average */
-- 
2.4.10

