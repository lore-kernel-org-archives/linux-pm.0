From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC PATCH 02/14] sched/fair: add triggers for OPP change requests
Date: Wed, 19 Aug 2015 19:47:12 +0100
Message-ID: <1440010044-3402-3-git-send-email-patrick.bellasi@arm.com>
References: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Juri Lelli <juri.lelli@arm.com>

Each time a task is {en,de}queued we might need to adapt the current
frequency to the new usage. Add triggers on {en,de}queue_task_fair() for
this purpose.  Only trigger a freq request if we are effectively waking up
or going to sleep.  Filter out load balancing related calls to reduce the
number of triggers.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 kernel/sched/fair.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b35d90b..ebf86b4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4075,6 +4075,26 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
+/*
+ * ~20% capacity margin that we add to every capacity change
+ * request to provide some head room if task utilization further
+ * increases.
+ */
+static unsigned int capacity_margin = 1280;
+static unsigned long capacity_orig_of(int cpu);
+static int cpu_util(int cpu);
+
+static void update_capacity_of(int cpu)
+{
+	unsigned long req_cap;
+
+	if (!sched_energy_freq())
+		return;
+
+	req_cap = cpu_util(cpu) * capacity_margin / capacity_orig_of(cpu);
+	cpufreq_sched_set_cap(cpu, req_cap);
+}
+
 struct static_key __sched_energy_freq __read_mostly = STATIC_KEY_INIT_FALSE;
 
 /*
@@ -4087,6 +4107,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	int task_new = !(flags & ENQUEUE_WAKEUP);
 
 	for_each_sched_entity(se) {
 		if (se->on_rq)
@@ -4118,9 +4139,22 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_shares(cfs_rq);
 	}
 
-	if (!se)
+	if (!se) {
 		add_nr_running(rq, 1);
 
+		/*
+		 * We want to potentially trigger a freq switch request only for
+                 * tasks that are waking up; this is because we get here also during
+		 * load balancing, but in these cases it seems wise to trigger
+		 * as single request after load balancing is done.
+		 *
+		 * XXX: how about fork()? Do we need a special flag/something
+		 *      to tell if we are here after a fork() (wakeup_task_new)?
+		 *
+		 */
+		if (!task_new)
+			update_capacity_of(cpu_of(rq));
+	}
 	hrtick_update(rq);
 }
 
@@ -4178,9 +4212,18 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_shares(cfs_rq);
 	}
 
-	if (!se)
+	if (!se) {
 		sub_nr_running(rq, 1);
 
+		/*
+		 * We want to potentially trigger a freq switch request only for
+		 * tasks that are going to sleep; this is because we get here also
+		 * during load balancing, but in these cases it seems wise to trigger
+		 * as single request after load balancing is done.
+		 */
+		if (task_sleep)
+			update_capacity_of(cpu_of(rq));
+	}
 	hrtick_update(rq);
 }
 
-- 
2.5.0
