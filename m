From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization update flags
Date: Wed, 13 Dec 2017 15:23:21 +0530
Message-ID: <17ff0b5d83a1275a98f0d1b87daf275f3e964af3.1513158452.git.viresh.kumar@linaro.org>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40364 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbdLMJxf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 04:53:35 -0500
Received: by mail-pg0-f66.google.com with SMTP id k15so1035678pgr.7
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2017 01:53:34 -0800 (PST)
In-Reply-To: <cover.1513158452.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1513158452.git.viresh.kumar@linaro.org>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, juri.lelli@redhat.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org

Currently the schedutil governor overwrites the sg_cpu->flags field on
every call to the utilization handler. It was pretty good as the initial
implementation of utilization handlers, there are several drawbacks
though.

The biggest drawback is that the sg_cpu->flags field doesn't always
represent the correct type of tasks that are enqueued on a CPU's rq. For
example, if a fair task is enqueued while a RT or DL task is running, we
will overwrite the flags with value 0 and that may take the CPU to lower
OPPs unintentionally. There can be other corner cases as well which we
aren't aware of currently.

This patch changes the current implementation to keep track of all the
task types that are currently enqueued to the CPUs rq. A new flag: CLEAR
is introduced and is set by the scheduling classes when their last task
is dequeued. When the CLEAR flag bit is set, the schedutil governor resets
all the other flag bits that are present in the flags parameter. For
now, the util update handlers return immediately if they were called to
clear the flag.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/sched/cpufreq.h    |  7 ++++++-
 kernel/sched/cpufreq_schedutil.c | 21 ++++++++++++++++++---
 kernel/sched/deadline.c          |  4 ++++
 kernel/sched/fair.c              |  8 ++++++--
 kernel/sched/rt.c                |  4 ++++
 5 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index d1ad3d825561..6f6641e61236 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -8,10 +8,15 @@
  * Interface between cpufreq drivers and the scheduler:
  */
 
+#define SCHED_CPUFREQ_CLEAR	(1U << 31)
 #define SCHED_CPUFREQ_RT	(1U << 0)
 #define SCHED_CPUFREQ_DL	(1U << 1)
-#define SCHED_CPUFREQ_IOWAIT	(1U << 2)
+#define SCHED_CPUFREQ_CFS	(1U << 2)
+#define SCHED_CPUFREQ_IOWAIT	(1U << 3)
 
+#define SCHED_CPUFREQ_RT_CLEAR	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_CLEAR)
+#define SCHED_CPUFREQ_DL_CLEAR	(SCHED_CPUFREQ_DL | SCHED_CPUFREQ_CLEAR)
+#define SCHED_CPUFREQ_CFS_CLEAR	(SCHED_CPUFREQ_CFS | SCHED_CPUFREQ_CLEAR)
 #define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
 
 #ifdef CONFIG_CPU_FREQ
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e8ccfa30f01a..60a2dea4c8cc 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -191,6 +191,8 @@ static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 				   unsigned int flags)
 {
 	if (flags & SCHED_CPUFREQ_IOWAIT) {
+		sg_cpu->flags &= ~SCHED_CPUFREQ_IOWAIT;
+
 		if (sg_cpu->iowait_boost_pending)
 			return;
 
@@ -264,6 +266,13 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	unsigned int next_f;
 	bool busy;
 
+	if (unlikely(flags & SCHED_CPUFREQ_CLEAR)) {
+		sg_cpu->flags &= ~flags;
+		return;
+	}
+
+	sg_cpu->flags |= flags;
+
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
@@ -272,7 +281,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	busy = sugov_cpu_is_busy(sg_cpu);
 
-	if (flags & SCHED_CPUFREQ_RT_DL) {
+	if (sg_cpu->flags & SCHED_CPUFREQ_RT_DL) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
 		sugov_get_util(&util, &max, sg_cpu->cpu);
@@ -345,15 +354,20 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 
 	raw_spin_lock(&sg_policy->update_lock);
 
+	if (unlikely(flags & SCHED_CPUFREQ_CLEAR)) {
+		sg_cpu->flags &= ~flags;
+		goto unlock;
+	}
+
 	sg_cpu->util = util;
 	sg_cpu->max = max;
-	sg_cpu->flags = flags;
+	sg_cpu->flags |= flags;
 
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
-		if (flags & SCHED_CPUFREQ_RT_DL)
+		if (sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
 			next_f = sg_policy->policy->cpuinfo.max_freq;
 		else
 			next_f = sugov_next_freq_shared(sg_cpu, time);
@@ -361,6 +375,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 		sugov_update_commit(sg_policy, time, next_f);
 	}
 
+unlock:
 	raw_spin_unlock(&sg_policy->update_lock);
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2473736c7616..d9c7c6887493 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1472,6 +1472,10 @@ static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	if (flags & DEQUEUE_SLEEP)
 		task_non_contending(p);
+
+	/* Clear cpufreq flags after last deadline task is dequeued */
+	if (!rq->dl.dl_nr_running)
+		cpufreq_update_util(rq, SCHED_CPUFREQ_DL_CLEAR);
 }
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2915c0d95107..492188c3ee2d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3033,7 +3033,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 		 *
 		 * See cpu_util().
 		 */
-		cpufreq_update_util(rq, 0);
+		cpufreq_update_util(rq, SCHED_CPUFREQ_CFS);
 	}
 }
 
@@ -5214,7 +5214,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * passed.
 	 */
 	if (p->in_iowait)
-		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
+		cpufreq_update_util(rq, SCHED_CPUFREQ_CFS | SCHED_CPUFREQ_IOWAIT);
 
 	for_each_sched_entity(se) {
 		if (se->on_rq)
@@ -5309,6 +5309,10 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		sub_nr_running(rq, 1);
 
 	hrtick_update(rq);
+
+	/* Clear cpufreq flags after last CFS task is dequeued */
+	if (!rq->cfs.nr_running)
+		cpufreq_update_util(rq, SCHED_CPUFREQ_CFS_CLEAR);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 862a513adca3..c9e8a8e5641b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1337,6 +1337,10 @@ static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	dequeue_rt_entity(rt_se, flags);
 
 	dequeue_pushable_task(rq, p);
+
+	/* Clear cpufreq flags after last rt task is dequeued */
+	if (!rq->rt.rt_nr_running)
+		cpufreq_update_util(rq, SCHED_CPUFREQ_RT_CLEAR);
 }
 
 /*
-- 
2.15.0.194.g9af6a3dea062
