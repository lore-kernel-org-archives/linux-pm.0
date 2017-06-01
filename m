From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC] sched: fair: Don't update CPU frequency too frequently
Date: Thu,  1 Jun 2017 17:04:27 +0530
Message-ID: <b3a96d619a4cad34f4243a173a42915c41059669.1496316723.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:35925 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbdFALee (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2017 07:34:34 -0400
Received: by mail-it0-f46.google.com with SMTP id m47so34870187iti.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Jun 2017 04:34:33 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, Juri Lelli <Juri.Lelli@arm.com>, Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com

update_load_avg() is the heaviest caller of the cpufreq utilization
callbacks right now and it runs too frequently from various parts of the
fair scheduler.

It may not be optimal to update the CPU frequency that frequently
though.

We are more concerned about the events when the CPU utilization changes
sharply and that mostly happens when a task gets attached/detached
to/from a runqueue.

Perhaps we aren't that concerned about the case when the utilization
changes gradually (small delta) due the time a task gets to run and
updating the CPU frequency at the tick rate should be good enough in
that case.

Sometimes update_load_avg() gets called right before migrating a task to
a new CPU and that can steal the chance of updating the frequency when
we actually needed it (i.e. after util_avg is updated with the
contributions of the migrated task). This can happen because the cpufreq
governors change the frequency only once in a fixed period of time (i.e.
rate_limit_us for the schedutil governor).

The fair scheduler already calls the utilization hooks from
attach/detach paths and that takes care of the most important case we
are concerned about.

This patch relocates the call to utilization hook from
update_cfs_rq_load_avg() to task_tick_fair().

Testing:

Platform: Skylake, Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz. Quad core (8
threads).

Distribution: Ubutnu 16.04 with cmdline intel_pstate=passive.
Based over 4.12-rc3.

All the below tests were run 3 times with and without this change over
4.12-rc3 and the average of all the runs is shown here (RESULT). The
number of times the schedutil hook is called during the tests is also
present in the table (UPDATE-COUNT).

Bench:

- pipe-test

  Command: perf bench sched pipe

  		4.12-rc3	4.12-rc3 + this patch	Change
  		--------	---------------------	----------

  RESULT	4.21		3.68			- 12.53 %

  UPDATE-COUNT	5405		886			- 83 %


- Hackbench

  Command: sync; sleep 1; for i in {1..20}; do sleep 2; \
  	   hackbench -P -g 1 | grep Time; done

  		4.12-rc3	4.12-rc3 + this patch	Change
  		--------	---------------------	----------

  RESULT	0.00925		0.00853			- 7.75 %

  UPDATE-COUNT	10342		1925			- 81 %


- ebizzy

  Command: ebizzy -t N -S 20

  		4.12-rc3	4.12-rc3 + this patch	Change
  		--------	---------------------	----------

  RESULT (N=8)	270221		247841			- 8 %
  RESULT (N=16)	252692		249839			- 1.1 %
  RESULT (N=24)	251151		254114			+ 1.1 %
  RESULT (N=32)	249274		250115			+ 0.3 %

  UPDATE-COUNT	41964		40279			- 4 %


- cyclictest (with latency)

  Command: cyclictest -q -t N -i 10000 --latency=1000000 -D 20

  		4.12-rc3	4.12-rc3 + this patch	Change
  		--------	---------------------	----------

  RESULT (N=8)	326		332			+ 1.75 %
  RESULT (N=16)	297		328			+ 10 %
  RESULT (N=24)	288		317			+ 9.9 %
  RESULT (N=32)	268		313			+ 17 %

  UPDATE-COUNT	28949		313			- 98.6 %

  Some more investigation (with ftrace) was done to check the cause of
  regression in this case (as the below test doesn't have the same
  results without latency).

  o The number of time we went into a cpuidle state and came out of it
    is almost same with both the images.
  o The average time between sched_waking and sched_switch traces for
    the cyclictest threads is 19.8 us with rc3 and 13.5 us with this
    patch. And so the response to the threads is actually better with
    this patch.
  o Need more suggestions to verify why the regression is there.


- cyclictest (without latency)

  Command: cyclictest -q -t N -i 10000 --latency=0 -D 20

  		4.12-rc3	4.12-rc3 + this patch	Change
  		--------	---------------------	----------

  RESULT (N=8)	16.34		8.87			- 45.78 %
  RESULT (N=16)	13.91		6.41			- 54 %
  RESULT (N=24)	12.42		9.1			- 26.77 %
  RESULT (N=32)	13		3.34			- 74 %

  UPDATE-COUNT	26000		350			- 98.6 %

  Note: Most of the MAX values with rc3 were between 10-30 and that with
  this patch were between 2-20. There were few random high values
  (100-400) though with both the images and are discarded to get the
  averages.

Summary:

o The number of times cpufreq utilization callbacks were called
  (UPDATE-COUNT) during the tests has come down heavily (81-96 %),
  except for ebizzy. And that's a lot of code removed from scheduler's
  hot path.

o pipe-test and hackbench have shown a clear improvement with the patch.

o ebizzy has shown a regression (specially at N=8). Though during some
  individual tests, rc3 also reported low numbers as compared to the
  kernel with this patch.

o cyclictest with 0 latency (i.e. no deeper idle states) shows clear
  improvement, while with latency=1000000 there is considerable
  regression.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
I have also created a callgraph of where exactly are cpufreq hooks
getting called from within the fair scheduler: https://yuml.me/dcc6d554.
---
 kernel/sched/fair.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 47a0c552c77b..62fe58b68e43 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3276,7 +3276,7 @@ static inline int
 update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq, bool update_freq)
 {
 	struct sched_avg *sa = &cfs_rq->avg;
-	int decayed, removed_load = 0, removed_util = 0;
+	int decayed, removed_load = 0;
 
 	if (atomic_long_read(&cfs_rq->removed_load_avg)) {
 		s64 r = atomic_long_xchg(&cfs_rq->removed_load_avg, 0);
@@ -3290,7 +3290,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq, bool update_freq)
 		long r = atomic_long_xchg(&cfs_rq->removed_util_avg, 0);
 		sub_positive(&sa->util_avg, r);
 		sub_positive(&sa->util_sum, r * LOAD_AVG_MAX);
-		removed_util = 1;
 		set_tg_cfs_propagate(cfs_rq);
 	}
 
@@ -3301,9 +3300,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq, bool update_freq)
 	cfs_rq->load_last_update_time_copy = sa->last_update_time;
 #endif
 
-	if (update_freq && (decayed || removed_util))
-		cfs_rq_util_change(cfs_rq);
-
 	return decayed || removed_load;
 }
 
@@ -3481,10 +3477,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq, bool update_freq)
 #define UPDATE_TG	0x0
 #define SKIP_AGE_LOAD	0x0
 
-static inline void update_load_avg(struct sched_entity *se, int not_used1)
-{
-	cpufreq_update_util(rq_of(cfs_rq_of(se)), 0);
-}
+static inline void update_load_avg(struct sched_entity *se, int not_used1) {}
 
 static inline void
 enqueue_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
@@ -9021,6 +9014,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
 
+	cpufreq_update_util(rq, 0);
+
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 }
-- 
2.13.0.70.g6367777092d9
