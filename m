From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC PATCH 03/14] sched/{core,fair}: trigger OPP change request on fork()
Date: Wed, 19 Aug 2015 19:47:13 +0100
Message-ID: <1440010044-3402-4-git-send-email-patrick.bellasi@arm.com>
References: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Juri Lelli <juri.lelli@arm.com>

Patch "sched/fair: add triggers for OPP change requests" introduced OPP
change triggers for enqueue_task_fair(), but the trigger was operating only
for wakeups. Fact is that it makes sense to consider wakeup_new also (i.e.,
fork()), as we don't know anything about a newly created task and thus we
most certainly want to jump to max OPP to not harm performance too much.

However, it is not currently possible (or at least it wasn't evident to me
how to do so :/) to tell new wakeups from other (non wakeup) operations.

This patch introduces an additional flag in sched.h that is only set at
fork() time and it is then consumed in enqueue_task_fair() for our purpose.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/fair.c  | 9 +++------
 kernel/sched/sched.h | 1 +
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43952c7..e901340 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2360,7 +2360,7 @@ void wake_up_new_task(struct task_struct *p)
 #endif
 
 	rq = __task_rq_lock(p);
-	activate_task(rq, p, 0);
+	activate_task(rq, p, ENQUEUE_WAKEUP_NEW);
 	p->on_rq = TASK_ON_RQ_QUEUED;
 	trace_sched_wakeup_new(p);
 	check_preempt_curr(rq, p, WF_FORK);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ebf86b4..a75ea07 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4107,7 +4107,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
-	int task_new = !(flags & ENQUEUE_WAKEUP);
+	int task_new = flags & ENQUEUE_WAKEUP_NEW;
+	int task_wakeup = flags & ENQUEUE_WAKEUP;
 
 	for_each_sched_entity(se) {
 		if (se->on_rq)
@@ -4147,12 +4148,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
                  * tasks that are waking up; this is because we get here also during
 		 * load balancing, but in these cases it seems wise to trigger
 		 * as single request after load balancing is done.
-		 *
-		 * XXX: how about fork()? Do we need a special flag/something
-		 *      to tell if we are here after a fork() (wakeup_task_new)?
-		 *
 		 */
-		if (!task_new)
+		if (task_new || task_wakeup)
 			update_capacity_of(cpu_of(rq));
 	}
 	hrtick_update(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 07ab036..1f0b433 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1164,6 +1164,7 @@ static const u32 prio_to_wmult[40] = {
 #define ENQUEUE_WAKING		0
 #endif
 #define ENQUEUE_REPLENISH	8
+#define ENQUEUE_WAKEUP_NEW	16
 
 #define DEQUEUE_SLEEP		1
 
-- 
2.5.0
