From: Yuyang Du <yuyang.du@intel.com>
Subject: [RFC PATCH 04/12 v1] CPU ConCurrency collecting in:
Date: Mon,  5 May 2014 08:02:44 +0800
Message-ID: <1399248172-13871-5-git-send-email-yuyang.du@intel.com>
References: <1399248172-13871-1-git-send-email-yuyang.du@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46110 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755233AbaEEIIp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 5 May 2014 04:08:45 -0400
In-Reply-To: <1399248172-13871-1-git-send-email-yuyang.du@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: arjan.van.de.ven@intel.com, len.brown@intel.com, alan.cox@intel.com, mark.gross@intel.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org, rajeev.d.muralidhar@intel.com, vishwesh.m.rudramuni@intel.com, nicole.chalhoub@intel.com, ajaya.durg@intel.com, harinarayanan.seshadri@intel.com, yuyang.du@intel.com

1. dequeue
2. enqueue
3. scheduler tick
4. idle enter and exit

Signed-off-by: Yuyang Du <yuyang.du@intel.com>
---
 kernel/sched/core.c |    3 +++
 kernel/sched/fair.c |    2 ++
 2 files changed, 5 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ff990f9..aee8660 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -767,6 +767,7 @@ static void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	update_rq_clock(rq);
 	sched_info_queued(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
+	update_cpu_concurrency(rq);
 }
 
 static void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
@@ -774,6 +775,7 @@ static void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	update_rq_clock(rq);
 	sched_info_dequeued(rq, p);
 	p->sched_class->dequeue_task(rq, p, flags);
+	update_cpu_concurrency(rq);
 }
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
@@ -2428,6 +2430,7 @@ void scheduler_tick(void)
 	update_rq_clock(rq);
 	curr->sched_class->task_tick(rq, curr, 0);
 	update_cpu_load_active(rq);
+	update_cpu_concurrency(rq);
 	raw_spin_unlock(&rq->lock);
 
 	perf_event_task_tick();
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7570dd9..e7153ff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2563,6 +2563,7 @@ static inline void dequeue_entity_load_avg(struct cfs_rq *cfs_rq,
 void idle_enter_fair(struct rq *this_rq)
 {
 	update_rq_runnable_avg(this_rq, 1);
+	update_cpu_concurrency(this_rq);
 }
 
 /*
@@ -2573,6 +2574,7 @@ void idle_enter_fair(struct rq *this_rq)
 void idle_exit_fair(struct rq *this_rq)
 {
 	update_rq_runnable_avg(this_rq, 0);
+	update_cpu_concurrency(this_rq);
 }
 
 static int idle_balance(struct rq *this_rq);
-- 
1.7.9.5

