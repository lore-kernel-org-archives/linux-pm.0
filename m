From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Wed, 20 Dec 2017 16:30:29 +0100
Message-ID: <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:46970 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754664AbdLTPao (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 10:30:44 -0500
Content-Disposition: inline
In-Reply-To: <20171130114723.29210-1-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>


So I ended up with the below (on top of Juri's cpufreq-dl patches).

It compiles, but that's about all the testing it had.

--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -8,9 +8,7 @@
  * Interface between cpufreq drivers and the scheduler:
  */
 
-#define SCHED_CPUFREQ_RT	(1U << 0)
-#define SCHED_CPUFREQ_DL	(1U << 1)
-#define SCHED_CPUFREQ_IOWAIT	(1U << 2)
+#define SCHED_CPUFREQ_IOWAIT	(1U << 0)
 
 #ifdef CONFIG_CPU_FREQ
 struct update_util_data {
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -63,7 +63,6 @@ struct sugov_cpu {
 	unsigned long util_cfs;
 	unsigned long util_dl;
 	unsigned long max;
-	unsigned int flags;
 
 	/* The field below is for single-CPU policies only. */
 #ifdef CONFIG_NO_HZ_COMMON
@@ -188,17 +187,23 @@ static void sugov_get_util(struct sugov_
 
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
+	unsigned long util = sg_cpu->util_cfs + sg_cpu->util_dl;
+	struct rq *rq = cpu_rq(sg_cpu->cpu);
+
+	if (rq->rt.rt_nr_running)
+		util = sg_cpu->max;
+
 	/*
 	 * Ideally we would like to set util_dl as min/guaranteed freq and
 	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
 	 * ready for such an interface. So, we only do the latter for now.
 	 */
-	return min(sg_cpu->util_cfs + sg_cpu->util_dl, sg_cpu->max);
+	return min(util, sg_cpu->max);
 }
 
-static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time)
+static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
 {
-	if (sg_cpu->flags & SCHED_CPUFREQ_IOWAIT) {
+	if (flags & SCHED_CPUFREQ_IOWAIT) {
 		if (sg_cpu->iowait_boost_pending)
 			return;
 
@@ -267,12 +272,11 @@ static void sugov_update_single(struct u
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
-	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned long util, max;
 	unsigned int next_f;
 	bool busy;
 
-	sugov_set_iowait_boost(sg_cpu, time);
+	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
 	if (!sugov_should_update_freq(sg_policy, time))
@@ -280,25 +284,22 @@ static void sugov_update_single(struct u
 
 	busy = sugov_cpu_is_busy(sg_cpu);
 
-	if (flags & SCHED_CPUFREQ_RT) {
-		next_f = policy->cpuinfo.max_freq;
-	} else {
-		sugov_get_util(sg_cpu);
-		max = sg_cpu->max;
-		util = sugov_aggregate_util(sg_cpu);
-		sugov_iowait_boost(sg_cpu, &util, &max);
-		next_f = get_next_freq(sg_policy, util, max);
-		/*
-		 * Do not reduce the frequency if the CPU has not been idle
-		 * recently, as the reduction is likely to be premature then.
-		 */
-		if (busy && next_f < sg_policy->next_freq) {
-			next_f = sg_policy->next_freq;
+	sugov_get_util(sg_cpu);
+	max = sg_cpu->max;
+	util = sugov_aggregate_util(sg_cpu);
+	sugov_iowait_boost(sg_cpu, &util, &max);
+	next_f = get_next_freq(sg_policy, util, max);
+	/*
+	 * Do not reduce the frequency if the CPU has not been idle
+	 * recently, as the reduction is likely to be premature then.
+	 */
+	if (busy && next_f < sg_policy->next_freq) {
+		next_f = sg_policy->next_freq;
 
-			/* Reset cached freq as next_freq has changed */
-			sg_policy->cached_raw_freq = 0;
-		}
+		/* Reset cached freq as next_freq has changed */
+		sg_policy->cached_raw_freq = 0;
 	}
+
 	sugov_update_commit(sg_policy, time, next_f);
 }
 
@@ -314,6 +315,9 @@ static unsigned int sugov_next_freq_shar
 		unsigned long j_util, j_max;
 		s64 delta_ns;
 
+		if (j_sg_cpu != sg_cpu)
+			sugov_get_util(j_sg_cpu);
+
 		/*
 		 * If the CFS CPU utilization was last updated before the
 		 * previous frequency update and the time elapsed between the
@@ -327,12 +331,7 @@ static unsigned int sugov_next_freq_shar
 		if (delta_ns > TICK_NSEC) {
 			j_sg_cpu->iowait_boost = 0;
 			j_sg_cpu->iowait_boost_pending = false;
-			j_sg_cpu->util_cfs = 0;
-			if (j_sg_cpu->util_dl == 0)
-				continue;
 		}
-		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT)
-			return policy->cpuinfo.max_freq;
 
 		j_max = j_sg_cpu->max;
 		j_util = sugov_aggregate_util(j_sg_cpu);
@@ -357,17 +356,11 @@ static void sugov_update_shared(struct u
 	raw_spin_lock(&sg_policy->update_lock);
 
 	sugov_get_util(sg_cpu);
-	sg_cpu->flags = flags;
-
-	sugov_set_iowait_boost(sg_cpu, time);
+	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
-		if (flags & SCHED_CPUFREQ_RT)
-			next_f = sg_policy->policy->cpuinfo.max_freq;
-		else
-			next_f = sugov_next_freq_shared(sg_cpu, time);
-
+		next_f = sugov_next_freq_shared(sg_cpu, time);
 		sugov_update_commit(sg_policy, time, next_f);
 	}
 
@@ -678,7 +671,6 @@ static int sugov_start(struct cpufreq_po
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->cpu = cpu;
 		sg_cpu->sg_policy = sg_policy;
-		sg_cpu->flags = 0;
 		sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
 	}
 
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -87,7 +87,7 @@ void __add_running_bw(u64 dl_bw, struct
 	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq_of_dl_rq(dl_rq), SCHED_CPUFREQ_DL);
+	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
 }
 
 static inline
@@ -101,7 +101,7 @@ void __sub_running_bw(u64 dl_bw, struct
 	if (dl_rq->running_bw > old)
 		dl_rq->running_bw = 0;
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq_of_dl_rq(dl_rq), SCHED_CPUFREQ_DL);
+	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
 }
 
 static inline
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -959,9 +959,6 @@ static void update_curr_rt(struct rq *rq
 	if (unlikely((s64)delta_exec <= 0))
 		return;
 
-	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq, SCHED_CPUFREQ_RT);
-
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
 
@@ -1003,6 +1000,9 @@ dequeue_top_rt_rq(struct rt_rq *rt_rq)
 
 	sub_nr_running(rq, rt_rq->rt_nr_running);
 	rt_rq->rt_queued = 0;
+
+	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
+	cpufreq_update_util(rq, 0);
 }
 
 static void
@@ -1019,6 +1019,9 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
 
 	add_nr_running(rq, rt_rq->rt_nr_running);
 	rt_rq->rt_queued = 1;
+
+	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
+	cpufreq_update_util(rq, 0);
 }
 
 #if defined CONFIG_SMP
