From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Resend][PATCH 1/3] cpufreq / sched: SCHED_CPUFREQ_IOWAIT flag to indicate iowait condition
Date: Fri, 09 Sep 2016 23:59:33 +0200
Message-ID: <3396916.fdtXW4Ee0Q@vostro.rjw.lan>
References: <21371892.ALJNnHKoBY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <21371892.ALJNnHKoBY@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steve Muckle <smuckle@linaro.org>, Doug Smythies <doug.smythies@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Testing indicates that it is possible to improve performace
significantly without increasing energy consumption too much by
teaching cpufreq governors to bump up the CPU performance level if
the in_iowait flag is set for the task in enqueue_task_fair().

For this purpose, define a new cpufreq_update_util() flag
SCHED_CPUFREQ_IOWAIT and modify enqueue_task_fair() to pass that
flag to cpufreq_update_util() in the in_iowait case.  That generally
requires cpufreq_update_util() to be called directly from there,
because update_load_avg() may not be invoked in that case.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Looks-good-to: Steve Muckle <smuckle@linaro.org>
---
 include/linux/sched.h |    1 +
 kernel/sched/fair.c   |    8 ++++++++
 2 files changed, 9 insertions(+)

Index: linux-pm/kernel/sched/fair.c
===================================================================
--- linux-pm.orig/kernel/sched/fair.c
+++ linux-pm/kernel/sched/fair.c
@@ -4500,6 +4500,14 @@ enqueue_task_fair(struct rq *rq, struct
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 
+	/*
+	 * If in_iowait is set, the code below may not trigger any cpufreq
+	 * utilization updates, so do it here explicitly with the IOWAIT flag
+	 * passed.
+	 */
+	if (p->in_iowait)
+		cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_IOWAIT);
+
 	for_each_sched_entity(se) {
 		if (se->on_rq)
 			break;
Index: linux-pm/include/linux/sched.h
===================================================================
--- linux-pm.orig/include/linux/sched.h
+++ linux-pm/include/linux/sched.h
@@ -3471,6 +3471,7 @@ static inline unsigned long rlimit_max(u
 
 #define SCHED_CPUFREQ_RT	(1U << 0)
 #define SCHED_CPUFREQ_DL	(1U << 1)
+#define SCHED_CPUFREQ_IOWAIT	(1U << 2)
 
 #define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
 
