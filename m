From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 5/7] cpufreq / sched: UUF_IO flag to indicate iowait condition
Date: Mon, 01 Aug 2016 01:37:23 +0200
Message-ID: <3009663.9YcxTKseiO@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59792 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751209AbcGaXke (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jul 2016 19:40:34 -0400
In-Reply-To: <3752826.3sXAQIvcIA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Testing indicates that it is possible to improve performace
significantly without increasing energy consumption too much by
teaching cpufreq governors to bump up the CPU performance level if
the in_iowait flag is set for the task in enqueue_task_fair().

For this purpose, define a new cpufreq_update_util() flag
UUF_IO and modify enqueue_task_fair() to pass that flag to
cpufreq_update_util() in the in_iowait case.  That generally
requires cpufreq_update_util() to be called directly from there,
because update_load_avg() is not likely to be invoked in that
case.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/sched.h |    1 +
 kernel/sched/fair.c   |    8 ++++++++
 2 files changed, 9 insertions(+)

Index: linux-pm/kernel/sched/fair.c
===================================================================
--- linux-pm.orig/kernel/sched/fair.c
+++ linux-pm/kernel/sched/fair.c
@@ -4459,6 +4459,14 @@ enqueue_task_fair(struct rq *rq, struct
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 
+	/*
+	 * If in_iowait is set, it is likely that the loops below will not
+	 * trigger any cpufreq utilization updates, so do it here explicitly
+	 * with the IO flag passed.
+	 */
+	if (p->in_iowait)
+		cpufreq_update_util(rq, UUF_IO);
+
 	for_each_sched_entity(se) {
 		if (se->on_rq)
 			break;
Index: linux-pm/include/linux/sched.h
===================================================================
--- linux-pm.orig/include/linux/sched.h
+++ linux-pm/include/linux/sched.h
@@ -3376,6 +3376,7 @@ static inline unsigned long rlimit_max(u
 }
 
 #define UUF_RT	0x01
+#define UUF_IO	0x02
 
 #ifdef CONFIG_CPU_FREQ
 struct update_util_data {

