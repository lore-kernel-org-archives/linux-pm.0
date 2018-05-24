From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v3 2/2] sched/fair: util_est: update before schedutil
Date: Thu, 24 May 2018 15:10:23 +0100
Message-ID: <20180524141023.13765-3-patrick.bellasi@arm.com>
References: <20180524141023.13765-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524141023.13765-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

When a task is enqueue the estimated utilization of a CPU is updated
to better support the selection of the required frequency.
However, schedutil is (implicitly) updated by update_load_avg() which
always happens before util_est_{en,de}queue(), thus potentially
introducing a latency between estimated utilization updates and
frequency selections.

Let's update util_est at the beginning of enqueue_task_fair(),
which will ensure that all schedutil updates will see the most
updated estimated utilization value for a CPU.

Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Fixes: 7f65ea42eb00 ("sched/fair: Add util_est on top of PELT")

---
Changes in v3:
 - add "Acked-by" Vincent tags

Changes in v2:
 - improve comment in enqueue_task_fair() (Peter)
 - add "Fixes" tag
 - add "Acked-by" Viresh tag
---
 kernel/sched/fair.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 748cb054fefd..e497c05aab7f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5385,6 +5385,14 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 
+	/*
+	 * The code below (indirectly) updates schedutil which looks at
+	 * the cfs_rq utilization to select a frequency.
+	 * Let's add the task's estimated utilization to the cfs_rq's
+	 * estimated utilization, before we update schedutil.
+	 */
+	util_est_enqueue(&rq->cfs, p);
+
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
 	 * utilization updates, so do it here explicitly with the IOWAIT flag
@@ -5426,7 +5434,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!se)
 		add_nr_running(rq, 1);
 
-	util_est_enqueue(&rq->cfs, p);
 	hrtick_update(rq);
 }
 
-- 
2.15.1
