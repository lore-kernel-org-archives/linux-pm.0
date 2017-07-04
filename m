From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v2 5/6] sched/rt: fast switch to maximum frequency when RT tasks are scheduled
Date: Tue,  4 Jul 2017 18:34:10 +0100
Message-ID: <1499189651-18797-6-git-send-email-patrick.bellasi@arm.com>
References: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

Currently schedutil updates are triggered for the RT class using a single
call place, which is part of the rt::update_curr_rt() used in:

- dequeue_task_rt:
  but it does not make sense to set the schedutil's SCHED_CPUFREQ_RT in
  case the next task should not be an RT one

- put_prev_task_rt:
  likewise, we set the SCHED_CPUFREQ_RT flag without knowing if required
  by the next task

- pick_next_task_rt:
  likewise, the schedutil's SCHED_CPUFREQ_RT is set in case the prev task
  was RT, while we don't yet know if the next will be RT

- task_tick_rt:
  that's the only really useful call, which can ramp up the frequency in
  case a RT task started its execution without a chance to order a
  frequency switch (e.g. because of the schedutil ratelimit)

Apart from the last call in task_tick_rt, the others are at least useless.
Thus, although being a simple solution, not all the call sites of that
update_curr_rt() are interesting to trigger a frequency switch as well as
some of the most interesting points are not covered by that call.
For example, a task set to RT has to wait the next tick to get the
frequency boost.

This patch fixes these issues by placing explicitly the schedutils
update calls in the only sensible places, which are:
- when an RT task wakeups and it's enqueued in a CPU
- when we actually pick a RT task for execution
- at each tick time
- when a task is set to be RT

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/rt.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 45caf93..8c25e95 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -969,9 +969,6 @@ static void update_curr_rt(struct rq *rq)
 	if (unlikely((s64)delta_exec <= 0))
 		return;
 
-	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
-
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
 
@@ -1337,6 +1334,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_task(rq, p);
+
+	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
+	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
 }
 
 static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
@@ -1574,6 +1574,9 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	p = _pick_next_task_rt(rq);
 
+	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
+	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
+
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
 
@@ -2367,6 +2370,9 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
 
+	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
+	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
+
 	update_curr_rt(rq);
 
 	watchdog(rq, p);
@@ -2402,6 +2408,9 @@ static void set_curr_task_rt(struct rq *rq)
 
 	p->se.exec_start = rq_clock_task(rq);
 
+	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
+	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
+
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
 }
-- 
2.7.4
