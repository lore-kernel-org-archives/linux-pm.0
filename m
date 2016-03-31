From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] sched/fair: call cpufreq hook in additional paths
Date: Thu, 31 Mar 2016 11:14:26 +0200
Message-ID: <20160331091426.GE11035@twins.programming.kicks-ass.net>
References: <1458858367-2831-1-git-send-email-smuckle@linaro.org>
 <20160331075951.GG3408@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160331075951.GG3408@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Byungchul Park <byungchul.park@lge.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 31, 2016 at 09:59:51AM +0200, Peter Zijlstra wrote:
> >  - passing an argument into attach_entity_load_avg() to indicate                                                 
> >    whether calling the cpufreq hook is necessary
> > 
> > Both of these are ugly in their own way but would avoid a runtime
> > cost. Opinions welcome.
> 
> Lemme see what this would look like while I throw the below into the bit
> bucket.

OK, so the below looks a lot more sane; and has the surprising benefit
of actually shrinking the text size..

  43675    1226      24   44925    af7d defconfig-build/kernel/sched/fair.o.base
  43723    1226      24   44973    afad defconfig-build/kernel/sched/fair.o.patch
  43595    1226      24   44845    af2d defconfig-build/kernel/sched/fair.o.patch+

---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2851,7 +2851,8 @@ static inline void cfs_rq_util_change(st
 }
 
 /* Group cfs_rq's load_avg is used for task_h_load and update_cfs_share */
-static inline int update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
+static inline int
+update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq, bool update_freq)
 {
 	struct sched_avg *sa = &cfs_rq->avg;
 	int decayed, removed_load = 0, removed_util = 0;
@@ -2878,7 +2879,7 @@ static inline int update_cfs_rq_load_avg
 	cfs_rq->load_last_update_time_copy = sa->last_update_time;
 #endif
 
-	if (decayed || removed_util)
+	if (update_freq && (decayed || removed_util))
 		cfs_rq_util_change(cfs_rq);
 
 	return decayed || removed_load;
@@ -2900,7 +2901,7 @@ static inline void update_load_avg(struc
 			  se->on_rq * scale_load_down(se->load.weight),
 			  cfs_rq->curr == se, NULL);
 
-	if (update_cfs_rq_load_avg(now, cfs_rq) && update_tg)
+	if (update_cfs_rq_load_avg(now, cfs_rq, true) && update_tg)
 		update_tg_load_avg(cfs_rq, 0);
 }
 
@@ -2962,7 +2963,7 @@ enqueue_entity_load_avg(struct cfs_rq *c
 			cfs_rq->curr == se, NULL);
 	}
 
-	decayed = update_cfs_rq_load_avg(now, cfs_rq);
+	decayed = update_cfs_rq_load_avg(now, cfs_rq, !migrated);
 
 	cfs_rq->runnable_load_avg += sa->load_avg;
 	cfs_rq->runnable_load_sum += sa->load_sum;
@@ -6170,7 +6171,7 @@ static void update_blocked_averages(int
 		if (throttled_hierarchy(cfs_rq))
 			continue;
 
-		if (update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq))
+		if (update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq, true))
 			update_tg_load_avg(cfs_rq, 0);
 	}
 	raw_spin_unlock_irqrestore(&rq->lock, flags);
@@ -6231,7 +6232,7 @@ static inline void update_blocked_averag
 
 	raw_spin_lock_irqsave(&rq->lock, flags);
 	update_rq_clock(rq);
-	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
+	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq, true);
 	raw_spin_unlock_irqrestore(&rq->lock, flags);
 }
 
