From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH 2/2] cpufreq: schedutil: Utilization aggregation
Date: Mon, 10 Apr 2017 02:11:46 +0200
Message-ID: <2242635.g1ACnTm5vK@aspire.rjw.lan>
References: <3498238.liCqOyIkGA@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56900 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752722AbdDJASB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Apr 2017 20:18:01 -0400
In-Reply-To: <3498238.liCqOyIkGA@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Due to the limitation of the rate of frequency changes the schedutil
governor only estimates the CPU utilization entirely when it is about
to update the frequency for the corresponding cpufreq policy.  As a
result, the intermediate utilization values are discarded by it,
but that is not appropriate in general (like, for example, when
tasks migrate from one CPU to another or exit, in which cases the
utilization measured by PELT may change abruptly between frequency
updates).

For this reason, modify schedutil to estimate CPU utilization
completely whenever it is invoked for the given CPU and store the
maximum encountered value of it as input for subsequent new frequency
computations.  This way the new frequency is always based on the
maximum utilization value seen by the governor after the previous
frequency update which effectively prevents intermittent utilization
variations from causing it to be reduced unnecessarily.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/cpufreq_schedutil.c |   90 +++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 40 deletions(-)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -57,7 +57,6 @@ struct sugov_cpu {
 	unsigned long iowait_boost_max;
 	u64 last_update;
 
-	/* The fields below are only needed when sharing a policy. */
 	unsigned long util;
 	unsigned long max;
 	unsigned int flags;
@@ -154,22 +153,30 @@ static unsigned int get_next_freq(struct
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
-static void sugov_get_util(unsigned long *util, unsigned long *max)
+static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned int flags)
 {
+	unsigned long cfs_util, cfs_max;
 	struct rq *rq = this_rq();
-	unsigned long cfs_max;
 
-	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
+	sg_cpu->flags |= flags & SCHED_CPUFREQ_RT_DL;
+	if (sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
+		return;
 
-	*util = min(rq->cfs.avg.util_avg, cfs_max);
-	*max = cfs_max;
+	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
+	cfs_util = min(rq->cfs.avg.util_avg, cfs_max);
+	if (sg_cpu->util * cfs_max < sg_cpu->max * cfs_util) {
+		sg_cpu->util = cfs_util;
+		sg_cpu->max = cfs_max;
+	}
 }
 
-static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
-				   unsigned int flags)
+static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
+			       unsigned int flags)
 {
+	unsigned long boost_util, boost_max = sg_cpu->iowait_boost_max;
+
 	if (flags & SCHED_CPUFREQ_IOWAIT) {
-		sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
+		sg_cpu->iowait_boost = boost_max;
 	} else if (sg_cpu->iowait_boost) {
 		s64 delta_ns = time - sg_cpu->last_update;
 
@@ -177,22 +184,15 @@ static void sugov_set_iowait_boost(struc
 		if (delta_ns > TICK_NSEC)
 			sg_cpu->iowait_boost = 0;
 	}
-}
 
-static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, unsigned long *util,
-			       unsigned long *max)
-{
-	unsigned long boost_util = sg_cpu->iowait_boost;
-	unsigned long boost_max = sg_cpu->iowait_boost_max;
-
-	if (!boost_util)
+	boost_util = sg_cpu->iowait_boost;
+	if (!boost_util || sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
 		return;
 
-	if (*util * boost_max < *max * boost_util) {
-		*util = boost_util;
-		*max = boost_max;
+	if (sg_cpu->util * boost_max < sg_cpu->max * boost_util) {
+		sg_cpu->util = boost_util;
+		sg_cpu->max = boost_max;
 	}
-	sg_cpu->iowait_boost >>= 1;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -208,30 +208,42 @@ static bool sugov_cpu_is_busy(struct sug
 static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
 #endif /* CONFIG_NO_HZ_COMMON */
 
+static void sugov_cpu_update(struct sugov_cpu *sg_cpu, u64 time,
+			     unsigned int flags)
+{
+	sugov_get_util(sg_cpu, flags);
+	sugov_iowait_boost(sg_cpu, time, flags);
+	sg_cpu->last_update = time;
+}
+
+static void sugov_reset_util(struct sugov_cpu *sg_cpu)
+{
+	sg_cpu->util = 0;
+	sg_cpu->max = 1;
+	sg_cpu->flags = 0;
+	sg_cpu->iowait_boost >>= 1;
+}
+
 static void sugov_update_single(struct update_util_data *hook, u64 time,
 				unsigned int flags)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned long util, max;
 	unsigned int next_f;
 	bool busy;
 
-	sugov_set_iowait_boost(sg_cpu, time, flags);
-	sg_cpu->last_update = time;
+	sugov_cpu_update(sg_cpu, time, flags);
 
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
 	busy = sugov_cpu_is_busy(sg_cpu);
 
-	if (flags & SCHED_CPUFREQ_RT_DL) {
+	if (sg_cpu->flags & SCHED_CPUFREQ_RT_DL) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
-		sugov_get_util(&util, &max);
-		sugov_iowait_boost(sg_cpu, &util, &max);
-		next_f = get_next_freq(sg_policy, util, max);
+		next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
 		/*
 		 * Do not reduce the frequency if the CPU has not been idle
 		 * recently, as the reduction is likely to be premature then.
@@ -240,6 +252,7 @@ static void sugov_update_single(struct u
 			next_f = sg_policy->next_freq;
 	}
 	sugov_update_commit(sg_policy, time, next_f);
+	sugov_reset_util(sg_cpu);
 }
 
 static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu)
@@ -276,8 +289,6 @@ static unsigned int sugov_next_freq_shar
 			util = j_util;
 			max = j_max;
 		}
-
-		sugov_iowait_boost(j_sg_cpu, &util, &max);
 	}
 
 	return get_next_freq(sg_policy, util, max);
@@ -288,27 +299,25 @@ static void sugov_update_shared(struct u
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
-	unsigned long util, max;
-	unsigned int next_f;
-
-	sugov_get_util(&util, &max);
 
 	raw_spin_lock(&sg_policy->update_lock);
 
-	sg_cpu->util = util;
-	sg_cpu->max = max;
-	sg_cpu->flags = flags;
-
-	sugov_set_iowait_boost(sg_cpu, time, flags);
-	sg_cpu->last_update = time;
+	sugov_cpu_update(sg_cpu, time, flags);
 
 	if (sugov_should_update_freq(sg_policy, time)) {
+		struct cpufreq_policy *policy = sg_policy->policy;
+		unsigned int next_f;
+		unsigned int j;
+
 		if (flags & SCHED_CPUFREQ_RT_DL)
 			next_f = sg_policy->policy->cpuinfo.max_freq;
 		else
 			next_f = sugov_next_freq_shared(sg_cpu);
 
 		sugov_update_commit(sg_policy, time, next_f);
+
+		for_each_cpu(j, policy->cpus)
+			sugov_reset_util(&per_cpu(sugov_cpu, j));
 	}
 
 	raw_spin_unlock(&sg_policy->update_lock);
@@ -606,6 +615,7 @@ static int sugov_start(struct cpufreq_po
 		sg_cpu->sg_policy = sg_policy;
 		sg_cpu->flags = SCHED_CPUFREQ_RT;
 		sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
+		sugov_reset_util(sg_cpu);
 		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
 					     policy_is_shared(policy) ?
 							sugov_update_shared :
