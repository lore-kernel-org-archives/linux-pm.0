From: Abel Vesa <abelvesa@gmail.com>
Subject: [PATCH] sched: Fix compiler errors for NO_SMP machines
Date: Fri, 22 May 2015 22:48:14 +0300
Message-ID: <1432324094-29573-1-git-send-email-abelvesa@gmail.com>
References: <1431459549-18343-26-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36014 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757125AbbEVTrz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2015 15:47:55 -0400
In-Reply-To: <1431459549-18343-26-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: morten.rasmussen@arm.com, peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar.Eggemann@arm.com, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri.Lelli@arm.com, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Abel Vesa <abelvesa@gmail.com>

Trivial fixes forh machines without SMP.

Signed-off-by: Abel Vesa <abelvesa@gmail.com>
---
 kernel/sched/fair.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e6d32e6..dae3db7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -672,6 +672,8 @@ static unsigned long task_h_load(struct task_struct *p);
 static inline void __update_task_entity_contrib(struct sched_entity *se);
 static inline void __update_task_entity_utilization(struct sched_entity *se);
 
+static bool cpu_overutilized(int cpu);
+
 /* Give new task start runnable values to heavy its load in infant time */
 void init_task_runnable_average(struct task_struct *p)
 {
@@ -4266,8 +4268,6 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
-static bool cpu_overutilized(int cpu);
-
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -4278,7 +4278,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
-	int task_new = !(flags & ENQUEUE_WAKEUP);
 
 	for_each_sched_entity(se) {
 		if (se->on_rq)
@@ -4313,10 +4312,13 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!se) {
 		update_rq_runnable_avg(rq, rq->nr_running);
 		add_nr_running(rq, 1);
-		if (!task_new && !rq->rd->overutilized &&
+#ifdef CONFIG_SMP
+		if ((flags & ENQUEUE_WAKEUP) && !rq->rd->overutilized &&
 		    cpu_overutilized(rq->cpu))
 			rq->rd->overutilized = true;
+#endif
 	}
+
 	hrtick_update(rq);
 }
 
@@ -8497,8 +8499,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_rq_runnable_avg(rq, 1);
 
+#ifdef CONFIG_SMP
 	if (!rq->rd->overutilized && cpu_overutilized(task_cpu(curr)))
 		rq->rd->overutilized = true;
+#endif
 }
 
 /*
-- 
1.9.1

