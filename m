From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpufreq / sched: Check cpu_of(rq) in cpufreq_update_util()
Date: Wed, 10 Aug 2016 03:11:17 +0200
Message-ID: <2203967.KPfYM1XZ4Q@vostro.rjw.lan>
References: <4498725.ix9jPCHteg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41323 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932556AbcHJBGt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2016 21:06:49 -0400
In-Reply-To: <4498725.ix9jPCHteg@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

All of the callers of cpufreq_update_util() check whether or not
cpu_of(rq) is equal to smp_processor_id() before calling it and pass
rq_clock(rq) to it as the time argument, so rework it to take a
runqueue pointer as the argument and move the cpu_of(rq) check and
the rq_clock(rq) evaluation into it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/deadline.c |    3 +--
 kernel/sched/fair.c     |    5 +----
 kernel/sched/rt.c       |    3 +--
 kernel/sched/sched.h    |   15 +++++++++------
 4 files changed, 12 insertions(+), 14 deletions(-)

Index: linux-pm/kernel/sched/deadline.c
===================================================================
--- linux-pm.orig/kernel/sched/deadline.c
+++ linux-pm/kernel/sched/deadline.c
@@ -733,8 +733,7 @@ static void update_curr_dl(struct rq *rq
 	}
 
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
-	if (cpu_of(rq) == smp_processor_id())
-		cpufreq_update_util(rq_clock(rq), SCHED_CPUFREQ_DL);
+	cpufreq_update_util(rq, SCHED_CPUFREQ_DL);
 
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
Index: linux-pm/kernel/sched/fair.c
===================================================================
--- linux-pm.orig/kernel/sched/fair.c
+++ linux-pm/kernel/sched/fair.c
@@ -2876,8 +2876,6 @@ static inline void update_tg_load_avg(st
 static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 {
 	if (&this_rq()->cfs == cfs_rq) {
-		struct rq *rq = rq_of(cfs_rq);
-
 		/*
 		 * There are a few boundary cases this might miss but it should
 		 * get called often enough that that should (hopefully) not be
@@ -2894,8 +2892,7 @@ static inline void cfs_rq_util_change(st
 		 *
 		 * See cpu_util().
 		 */
-		if (cpu_of(rq) == smp_processor_id())
-			cpufreq_update_util(rq_clock(rq), 0);
+		cpufreq_update_util(rq_of(cfs_rq), 0);
 	}
 }
 
Index: linux-pm/kernel/sched/rt.c
===================================================================
--- linux-pm.orig/kernel/sched/rt.c
+++ linux-pm/kernel/sched/rt.c
@@ -958,8 +958,7 @@ static void update_curr_rt(struct rq *rq
 		return;
 
 	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	if (cpu_of(rq) == smp_processor_id())
-		cpufreq_update_util(rq_clock(rq), SCHED_CPUFREQ_RT);
+	cpufreq_update_util(rq, SCHED_CPUFREQ_RT);
 
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
Index: linux-pm/kernel/sched/sched.h
===================================================================
--- linux-pm.orig/kernel/sched/sched.h
+++ linux-pm/kernel/sched/sched.h
@@ -1763,11 +1763,11 @@ DECLARE_PER_CPU(struct update_util_data
 
 /**
  * cpufreq_update_util - Take a note about CPU utilization changes.
- * @time: Current time.
+ * @rq: Runqueue to carry out the update for.
  * @flags: Update reason flags.
  *
- * This function is called by the scheduler on the CPU whose utilization is
- * being updated.
+ * This function is called by the scheduler to invoke the CPU frequency
+ * governor.
  *
  * It can only be called from RCU-sched read-side critical sections.
  *
@@ -1783,16 +1783,19 @@ DECLARE_PER_CPU(struct update_util_data
  * but that really is a band-aid.  Going forward it should be replaced with
  * solutions targeted more specifically at RT and DL tasks.
  */
-static inline void cpufreq_update_util(u64 time, unsigned int flags)
+static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
 {
 	struct update_util_data *data;
 
+	if (cpu_of(rq) != smp_processor_id())
+		return;
+
 	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
 	if (data)
-		data->func(data, time, flags);
+		data->func(data, rq_clock(rq), flags);
 }
 #else
-static inline void cpufreq_update_util(u64 time, unsigned int flags) {}
+static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef arch_scale_freq_capacity

