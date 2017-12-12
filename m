From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Tue, 12 Dec 2017 17:07:27 +0530
Message-ID: <20171212113727.GO25177@vireshk-i7>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-2-patrick.bellasi@arm.com>
 <20171207050135.vvhqttazumjg7n7n@vireshk-mac-ubuntu>
 <20171207124510.GP31247@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36286 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdLLLhd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Dec 2017 06:37:33 -0500
Received: by mail-pg0-f66.google.com with SMTP id k134so13235659pga.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2017 03:37:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171207124510.GP31247@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 07-12-17, 12:45, Patrick Bellasi wrote:
> On 07-Dec 10:31, Viresh Kumar wrote:
> > We posted some comments on V2 for this particular patch suggesting
> > some improvements. The patch hasn't changed at all and you haven't
> > replied to few of those suggestions as well. Any particular reason for
> > that?
> 
> You right, since the previous posting has been a long time ago, with
> this one I mainly wanted to refresh the discussion.

But posting again without making proposed changes or finishing earlier
discussion is normally not appreciated, specially by the very busy maintainers
(I am not one of those though :)). For example, I had to go look at previous
discussions now to see what all comments I gave and what has changed in respect
to them. That wasted lots of time as nothing really changed.

If you want to refresh the discussion, then its probably better to finish
discussions on the earlier threads only and then only send a new version.

> > For example:
> > - I suggested to get rid of the conditional expression in
> >   cpufreq_schedutil.c file that you have added.
> 
> We can probably set flags to SCHED_CPUFREQ_IDLE (instead of resetting
> them), however I think we still need an if condition somewhere.

Yeah, my point was to have similar behavior in single and shared policy cases.

> > - And Joel suggested to clear the RT/DL flags from dequeue path to
> >   avoid adding SCHED_CPUFREQ_IDLE flag.
> 
> I had a thought about Joel's proposal:
> 
> >> wouldn't another way be to just clear the flag from the RT scheduling
> >> class with an extra call to cpufreq_update_util with flags = 0 during
> >> dequeue_rt_entity?
> 
> The main concern for me was that the current API is completely
> transparent about which scheduling class is calling schedutil for
> updates.

I think its important to fix the basic mechanism of util update than fixing
corner cases with workarounds. I attempted a simpler approach (at least
according to me :)). Please share your feedback on it. You can include that as
part of your series, or I can send it separately if everyone finds it okay.

-- 
viresh

-------------------------8<-------------------------
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 12 Dec 2017 15:43:26 +0530
Subject: [PATCH] sched: Keep track of cpufreq utilization update flags

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
task types that are currently enqueued to the CPUs rq. There are two
flags for every scheduling class now, one to set the flag and other one
to clear it. The flag is set by the scheduling classes from the existing
set of calls to cpufreq_update_util(), and the flag is cleared when the
last task of the scheduling class is dequeued. For now, the util update
handlers return immediately if they were called to clear the flag.

We can add more optimizations over this patch separately.

The last parameter of sugov_set_iowait_boost() is also dropped as the
function can get it from sg_cpu anyway.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/sched/cpufreq.h    |  7 ++++++-
 kernel/sched/cpufreq_schedutil.c | 32 +++++++++++++++++++++++---------
 kernel/sched/deadline.c          |  4 ++++
 kernel/sched/fair.c              |  8 ++++++--
 kernel/sched/rt.c                |  4 ++++
 5 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index d1ad3d825561..dc2470affea4 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -8,9 +8,14 @@
  * Interface between cpufreq drivers and the scheduler:
  */
 
+#define SCHED_CPUFREQ_CLEAR	(1U << 31)
 #define SCHED_CPUFREQ_RT	(1U << 0)
+#define SCHED_CPUFREQ_RT_CLEAR	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_CLEAR)
 #define SCHED_CPUFREQ_DL	(1U << 1)
-#define SCHED_CPUFREQ_IOWAIT	(1U << 2)
+#define SCHED_CPUFREQ_DL_CLEAR	(SCHED_CPUFREQ_DL | SCHED_CPUFREQ_CLEAR)
+#define SCHED_CPUFREQ_CFS	(1U << 2)
+#define SCHED_CPUFREQ_CFS_CLEAR	(SCHED_CPUFREQ_CFS | SCHED_CPUFREQ_CLEAR)
+#define SCHED_CPUFREQ_IOWAIT	(1U << 3)
 
 #define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 2f52ec0f1539..7edfdc59ee8f 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -187,10 +187,11 @@ static void sugov_get_util(unsigned long *util, unsigned long *max, int cpu)
 	*max = cfs_max;
 }
 
-static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
-				   unsigned int flags)
+static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time)
 {
-	if (flags & SCHED_CPUFREQ_IOWAIT) {
+	if (sg_cpu->flags & SCHED_CPUFREQ_IOWAIT) {
+		sg_cpu->flags &= ~SCHED_CPUFREQ_IOWAIT;
+
 		if (sg_cpu->iowait_boost_pending)
 			return;
 
@@ -264,7 +265,14 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	unsigned int next_f;
 	bool busy;
 
-	sugov_set_iowait_boost(sg_cpu, time, flags);
+	if (unlikely(flags & SCHED_CPUFREQ_CLEAR)) {
+		sg_cpu->flags &= ~flags;
+		return;
+	}
+
+	sg_cpu->flags |= flags;
+
+	sugov_set_iowait_boost(sg_cpu, time);
 	sg_cpu->last_update = time;
 
 	if (!sugov_should_update_freq(sg_policy, time))
@@ -272,7 +280,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	busy = sugov_cpu_is_busy(sg_cpu);
 
-	if (flags & SCHED_CPUFREQ_RT_DL) {
+	if (sg_cpu->flags & SCHED_CPUFREQ_RT_DL) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
 		sugov_get_util(&util, &max, sg_cpu->cpu);
@@ -345,15 +353,20 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 
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
 
-	sugov_set_iowait_boost(sg_cpu, time, flags);
+	sugov_set_iowait_boost(sg_cpu, time);
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
-		if (flags & SCHED_CPUFREQ_RT_DL)
+		if (sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
 			next_f = sg_policy->policy->cpuinfo.max_freq;
 		else
 			next_f = sugov_next_freq_shared(sg_cpu, time);
@@ -361,6 +374,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 		sugov_update_commit(sg_policy, time, next_f);
 	}
 
+unlock:
 	raw_spin_unlock(&sg_policy->update_lock);
 }
 
@@ -655,7 +669,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->cpu = cpu;
 		sg_cpu->sg_policy = sg_policy;
-		sg_cpu->flags = SCHED_CPUFREQ_RT;
+		sg_cpu->flags = 0;
 		sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
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
index 4056c19ca3f0..73131abd9df6 100644
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
