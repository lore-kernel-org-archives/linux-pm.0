From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] sched/fair: call cpufreq hook in additional paths
Date: Thu, 31 Mar 2016 09:59:51 +0200
Message-ID: <20160331075951.GG3408@twins.programming.kicks-ass.net>
References: <1458858367-2831-1-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41181 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbcCaH74 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 03:59:56 -0400
Content-Disposition: inline
In-Reply-To: <1458858367-2831-1-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Byungchul Park <byungchul.park@lge.com>

On Thu, Mar 24, 2016 at 03:26:07PM -0700, Steve Muckle wrote:
> Note that this patch depends on the 2 patches I sent several days ago:
> http://thread.gmane.org/gmane.linux.kernel/2181498

Right; I had something similar for a little while..

> Unfortunately this means that in the migration case,
> enqueue_entity_load_avg() will end up calling the cpufreq hook twice -
> once via update_cfs_rq_load_avg() and once via
> attach_entity_load_avg(). 

Right; this is the point where I gave up when I looked at that.

> This should ideally get filtered out before
> the cpufreq driver is invoked but nevertheless is wasteful. Possible
> alternatives to this are
> 
>  - moving the cpufreq hook from update_cfs_rq_load_avg() into                                                    
>    its callers (there are three) and also putting the hook                                                       
>    in attach_task_cfs_rq and detach_task_cfs_rq, resulting in                                                    
>    five call sites of the hook in fair.c as opposed to three                                                               

Its worse; you get a whole nest of extra logic to determine when to call
what. See below (now arguably its still early so I might have made it
more complex than it needed to be..).

> 
>  - passing an argument into attach_entity_load_avg() to indicate                                                 
>    whether calling the cpufreq hook is necessary
> 
> Both of these are ugly in their own way but would avoid a runtime
> cost. Opinions welcome.

Lemme see what this would look like while I throw the below into the bit
bucket.



---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2854,23 +2854,23 @@ static inline void cfs_rq_util_change(st
 static inline int update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 {
 	struct sched_avg *sa = &cfs_rq->avg;
-	int decayed, removed_load = 0, removed_util = 0;
+	int ret = 0;
 
 	if (atomic_long_read(&cfs_rq->removed_load_avg)) {
 		s64 r = atomic_long_xchg(&cfs_rq->removed_load_avg, 0);
 		sa->load_avg = max_t(long, sa->load_avg - r, 0);
 		sa->load_sum = max_t(s64, sa->load_sum - r * LOAD_AVG_MAX, 0);
-		removed_load = 1;
+		ret |= 1 << 1;
 	}
 
 	if (atomic_long_read(&cfs_rq->removed_util_avg)) {
 		long r = atomic_long_xchg(&cfs_rq->removed_util_avg, 0);
 		sa->util_avg = max_t(long, sa->util_avg - r, 0);
 		sa->util_sum = max_t(s32, sa->util_sum - r * LOAD_AVG_MAX, 0);
-		removed_util = 1;
+		ret |= 1 << 2;
 	}
 
-	decayed = __update_load_avg(now, cpu_of(rq_of(cfs_rq)), sa,
+	decayed |= __update_load_avg(now, cpu_of(rq_of(cfs_rq)), sa,
 		scale_load_down(cfs_rq->load.weight), cfs_rq->curr != NULL, cfs_rq);
 
 #ifndef CONFIG_64BIT
@@ -2878,10 +2878,7 @@ static inline int update_cfs_rq_load_avg
 	cfs_rq->load_last_update_time_copy = sa->last_update_time;
 #endif
 
-	if (decayed || removed_util)
-		cfs_rq_util_change(cfs_rq);
-
-	return decayed || removed_load;
+	return ret;
 }
 
 /* Update task and its cfs_rq load average */
@@ -2891,6 +2888,7 @@ static inline void update_load_avg(struc
 	u64 now = cfs_rq_clock_task(cfs_rq);
 	struct rq *rq = rq_of(cfs_rq);
 	int cpu = cpu_of(rq);
+	int updated;
 
 	/*
 	 * Track task load average for carrying it to new CPU after migrated, and
@@ -2900,9 +2898,14 @@ static inline void update_load_avg(struc
 			  se->on_rq * scale_load_down(se->load.weight),
 			  cfs_rq->curr == se, NULL);
 
-	if (update_cfs_rq_load_avg(now, cfs_rq) && update_tg)
+	updated = update_cfs_rq_load_avg(now, cfs_rq);
+
+	if (updated & 5)
+		cfs_rq_util_change(cfs_rq);
+
+	if (update_tg && (updated & 3))
 		update_tg_load_avg(cfs_rq, 0);
-}
+
 
 static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
@@ -2953,7 +2956,7 @@ enqueue_entity_load_avg(struct cfs_rq *c
 {
 	struct sched_avg *sa = &se->avg;
 	u64 now = cfs_rq_clock_task(cfs_rq);
-	int migrated, decayed;
+	int migrated, updated;
 
 	migrated = !sa->last_update_time;
 	if (!migrated) {
@@ -2962,16 +2965,18 @@ enqueue_entity_load_avg(struct cfs_rq *c
 			cfs_rq->curr == se, NULL);
 	}
 
-	decayed = update_cfs_rq_load_avg(now, cfs_rq);
+	updated = update_cfs_rq_load_avg(now, cfs_rq);
 
 	cfs_rq->runnable_load_avg += sa->load_avg;
 	cfs_rq->runnable_load_sum += sa->load_sum;
 
-	if (migrated)
+	if (migrated) {
 		attach_entity_load_avg(cfs_rq, se);
-
-	if (decayed || migrated)
-		update_tg_load_avg(cfs_rq, 0);
+		if (updated & 3)
+			update_tg_load_avg(cfs_rq, 0);
+	} else if (updated & 5) {
+		cfs_rq_util_change(cfs_rq);
+	}
 }
 
 /* Remove the runnable load generated by se from cfs_rq's runnable load average */
@@ -6157,6 +6162,7 @@ static void update_blocked_averages(int
 	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq;
 	unsigned long flags;
+	int updated;
 
 	raw_spin_lock_irqsave(&rq->lock, flags);
 	update_rq_clock(rq);
@@ -6170,7 +6176,10 @@ static void update_blocked_averages(int
 		if (throttled_hierarchy(cfs_rq))
 			continue;
 
-		if (update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq))
+		updated = update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
+		if (updated & 5)
+			cfs_rq_util_change(cfs_rq);
+		if (updated & 3)
 			update_tg_load_avg(cfs_rq, 0);
 	}
 	raw_spin_unlock_irqrestore(&rq->lock, flags);
@@ -6228,10 +6237,13 @@ static inline void update_blocked_averag
 	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	unsigned long flags;
+	int updated;
 
 	raw_spin_lock_irqsave(&rq->lock, flags);
 	update_rq_clock(rq);
-	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
+	updated = update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
+	if (updated & 5)
+		cfs_rq_util_change(cfs_rq);
 	raw_spin_unlock_irqrestore(&rq->lock, flags);
 }
 
