From: Steve Muckle <steve.muckle@linaro.org>
Subject: [RFCv7 PATCH 04/10] sched/fair: add triggers for OPP change requests
Date: Mon, 22 Feb 2016 17:22:44 -0800
Message-ID: <1456190570-4475-5-git-send-email-smuckle@linaro.org>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Juri Lelli <juri.lelli@arm.com>

Each time a task is {en,de}queued we might need to adapt the current
frequency to the new usage. Add triggers on {en,de}queue_task_fair() for
this purpose.  Only trigger a freq request if we are effectively waking up
or going to sleep.  Filter out load balancing related calls to reduce the
number of triggers.

[smuckle@linaro.org: resolve merge conflicts, define task_new,
 use renamed static key sched_freq]

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/fair.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3437e01..f1f00a4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4283,6 +4283,21 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
+static unsigned long capacity_orig_of(int cpu);
+static int cpu_util(int cpu);
+
+static void update_capacity_of(int cpu)
+{
+	unsigned long req_cap;
+
+	if (!sched_freq())
+		return;
+
+	/* Convert scale-invariant capacity to cpu. */
+	req_cap = cpu_util(cpu) * SCHED_CAPACITY_SCALE / capacity_orig_of(cpu);
+	set_cfs_cpu_capacity(cpu, true, req_cap);
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -4293,6 +4308,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	int task_new = !(flags & ENQUEUE_WAKEUP);
 
 	for_each_sched_entity(se) {
 		if (se->on_rq)
@@ -4324,9 +4340,23 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_shares(cfs_rq);
 	}
 
-	if (!se)
+	if (!se) {
 		add_nr_running(rq, 1);
 
+		/*
+		 * We want to potentially trigger a freq switch
+		 * request only for tasks that are waking up; this is
+		 * because we get here also during load balancing, but
+		 * in these cases it seems wise to trigger as single
+		 * request after load balancing is done.
+		 *
+		 * XXX: how about fork()? Do we need a special
+		 *      flag/something to tell if we are here after a
+		 *      fork() (wakeup_task_new)?
+		 */
+		if (!task_new)
+			update_capacity_of(cpu_of(rq));
+	}
 	hrtick_update(rq);
 }
 
@@ -4384,9 +4414,24 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_shares(cfs_rq);
 	}
 
-	if (!se)
+	if (!se) {
 		sub_nr_running(rq, 1);
 
+		/*
+		 * We want to potentially trigger a freq switch
+		 * request only for tasks that are going to sleep;
+		 * this is because we get here also during load
+		 * balancing, but in these cases it seems wise to
+		 * trigger as single request after load balancing is
+		 * done.
+		 */
+		if (task_sleep) {
+			if (rq->cfs.nr_running)
+				update_capacity_of(cpu_of(rq));
+			else if (sched_freq())
+				set_cfs_cpu_capacity(cpu_of(rq), false, 0);
+		}
+	}
 	hrtick_update(rq);
 }
 
-- 
2.4.10
