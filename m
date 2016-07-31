From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 2/7] cpufreq / sched: Drop cpufreq_trigger_update()
Date: Mon, 01 Aug 2016 01:35:20 +0200
Message-ID: <3176365.d5aR3vuCWZ@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60340 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751643AbcGaXkg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jul 2016 19:40:36 -0400
In-Reply-To: <3752826.3sXAQIvcIA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After dropping the util and max arguments of cpufreq_update_util(),
the cpufreq_trigger_update() wrapper around it is pointless, so drop
it and call cpufreq_update_util() directly instead.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/deadline.c |    4 ++--
 kernel/sched/rt.c       |    4 ++--
 kernel/sched/sched.h    |   22 ++++++----------------
 3 files changed, 10 insertions(+), 20 deletions(-)

Index: linux-pm/kernel/sched/deadline.c
===================================================================
--- linux-pm.orig/kernel/sched/deadline.c
+++ linux-pm/kernel/sched/deadline.c
@@ -732,9 +732,9 @@ static void update_curr_dl(struct rq *rq
 		return;
 	}
 
-	/* kick cpufreq (see the comment in linux/cpufreq.h). */
+	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
 	if (cpu_of(rq) == smp_processor_id())
-		cpufreq_trigger_update(rq_clock(rq));
+		cpufreq_update_util(rq_clock(rq));
 
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
Index: linux-pm/kernel/sched/rt.c
===================================================================
--- linux-pm.orig/kernel/sched/rt.c
+++ linux-pm/kernel/sched/rt.c
@@ -957,9 +957,9 @@ static void update_curr_rt(struct rq *rq
 	if (unlikely((s64)delta_exec <= 0))
 		return;
 
-	/* Kick cpufreq (see the comment in linux/cpufreq.h). */
+	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
 	if (cpu_of(rq) == smp_processor_id())
-		cpufreq_trigger_update(rq_clock(rq));
+		cpufreq_update_util(rq_clock(rq));
 
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
Index: linux-pm/kernel/sched/sched.h
===================================================================
--- linux-pm.orig/kernel/sched/sched.h
+++ linux-pm/kernel/sched/sched.h
@@ -1766,19 +1766,6 @@ DECLARE_PER_CPU(struct update_util_data
  * update_load_avg() on the CPU whose utilization is being updated.
  *
  * It can only be called from RCU-sched read-side critical sections.
- */
-static inline void cpufreq_update_util(u64 time)
-{
-	struct update_util_data *data;
-
-	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
-	if (data)
-		data->func(data, time);
-}
-
-/**
- * cpufreq_trigger_update - Trigger CPU performance state evaluation if needed.
- * @time: Current time.
  *
  * The way cpufreq is currently arranged requires it to evaluate the CPU
  * performance state (frequency/voltage) on a regular basis to prevent it from
@@ -1792,13 +1779,16 @@ static inline void cpufreq_update_util(u
  * but that really is a band-aid.  Going forward it should be replaced with
  * solutions targeted more specifically at RT and DL tasks.
  */
-static inline void cpufreq_trigger_update(u64 time)
+static inline void cpufreq_update_util(u64 time)
 {
-	cpufreq_update_util(time);
+	struct update_util_data *data;
+
+	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
+	if (data)
+		data->func(data, time);
 }
 #else
 static inline void cpufreq_update_util(u64 time) {}
-static inline void cpufreq_trigger_update(u64 time) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef arch_scale_freq_capacity

