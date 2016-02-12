From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v9 1/3] cpufreq: Add mechanism for registering utilization update callbacks
Date: Fri, 12 Feb 2016 14:16:16 +0100
Message-ID: <3499355.2JlaSruvOa@vostro.rjw.lan>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <4060202.Yh71UT17sA@vostro.rjw.lan> <2044559.7ypXocW9OZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54386 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752424AbcBLNPB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 08:15:01 -0500
In-Reply-To: <2044559.7ypXocW9OZ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: Add mechanism for registering utilization update callbacks

Introduce a mechanism by which parts of the cpufreq subsystem
("setpolicy" drivers or the core) can register callbacks to be
executed from cpufreq_update_util() which is invoked by the
scheduler's update_load_avg() on CPU utilization changes.

This allows the "setpolicy" drivers to dispense with their timers
and do all of the computations they need and frequency/voltage
adjustments in the update_load_avg() code path, among other things.

The update_load_avg() changes were suggested by Peter Zijlstra.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---

Peter,

If the enqueue hooks aren't tolerable and I should drop them, please let me
know.

Changes from v8:
- Peter thinks that cpufreq hooks in update_curr_rt/dl() are overkill so
  move them to task_tick_rt/dl() and enqueue_task_rt/dl() (in case RT/DL
  tasks are only active between ticks), update the cpufreq_trigger_update()
  kerneldoc.

Changes from v7
- cpufreq_trigger_update() has a kerneldoc describing it as a band-aid to
  be replaced in the future and the comments next to its call sites ask
  the reader to see that comment.

  No functional changes. 

Changes from v6:
- Steve suggested to use rq_clock() instead of rq_clock_task() as the time
  argument for cpufreq_update_util() as that seems to be more suitable for
  this purpose.

Thanks,
Rafael

---
 drivers/cpufreq/cpufreq.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |   37 +++++++++++++++++++++++++++++++++++++
 kernel/sched/deadline.c   |    6 ++++++
 kernel/sched/fair.c       |   26 +++++++++++++++++++++++++-
 kernel/sched/rt.c         |    6 ++++++
 kernel/sched/sched.h      |    1 +
 6 files changed, 120 insertions(+), 1 deletion(-)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -151,6 +151,39 @@ static inline bool policy_is_shared(stru
 extern struct kobject *cpufreq_global_kobject;
 
 #ifdef CONFIG_CPU_FREQ
+void cpufreq_update_util(u64 time, unsigned long util, unsigned long max);
+
+/**
+ * cpufreq_trigger_update - Trigger CPU performance state evaluation if needed.
+ * @time: Current time.
+ *
+ * The way cpufreq is currently arranged requires it to evaluate the CPU
+ * performance state (frequency/voltage) on a regular basis to prevent it from
+ * being stuck in a completely inadequate performance level for too long.
+ * That is not guaranteed to happen if the updates are only triggered from CFS,
+ * though, because they may not be coming in if RT or deadline tasks are active
+ * all the time (or there are RT and DL tasks only).
+ *
+ * As a workaround for that issue, this function is called by the RT and DL
+ * sched classes to trigger extra cpufreq updates to prevent it from stalling,
+ * but that really is a band-aid.  Going forward it should be replaced with
+ * solutions targeted more specifically at RT and DL tasks.
+ *
+ * The extra updates are triggered from the tick and enqueue (in case RT/DL
+ * tasks are only active between ticks).
+ */
+static inline void cpufreq_trigger_update(u64 time)
+{
+	cpufreq_update_util(time, ULONG_MAX, 0);
+}
+
+struct update_util_data {
+	void (*func)(struct update_util_data *data,
+		     u64 time, unsigned long util, unsigned long max);
+};
+
+void cpufreq_set_update_util_data(int cpu, struct update_util_data *data);
+
 unsigned int cpufreq_get(unsigned int cpu);
 unsigned int cpufreq_quick_get(unsigned int cpu);
 unsigned int cpufreq_quick_get_max(unsigned int cpu);
@@ -162,6 +195,10 @@ int cpufreq_update_policy(unsigned int c
 bool have_governor_per_policy(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 #else
+static inline void cpufreq_update_util(u64 time, unsigned long util,
+				       unsigned long max) {}
+static inline void cpufreq_trigger_update(u64 time) {}
+
 static inline unsigned int cpufreq_get(unsigned int cpu)
 {
 	return 0;
Index: linux-pm/kernel/sched/sched.h
===================================================================
--- linux-pm.orig/kernel/sched/sched.h
+++ linux-pm/kernel/sched/sched.h
@@ -9,6 +9,7 @@
 #include <linux/irq_work.h>
 #include <linux/tick.h>
 #include <linux/slab.h>
+#include <linux/cpufreq.h>
 
 #include "cpupri.h"
 #include "cpudeadline.h"
Index: linux-pm/kernel/sched/fair.c
===================================================================
--- linux-pm.orig/kernel/sched/fair.c
+++ linux-pm/kernel/sched/fair.c
@@ -2824,7 +2824,8 @@ static inline void update_load_avg(struc
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	u64 now = cfs_rq_clock_task(cfs_rq);
-	int cpu = cpu_of(rq_of(cfs_rq));
+	struct rq *rq = rq_of(cfs_rq);
+	int cpu = cpu_of(rq);
 
 	/*
 	 * Track task load average for carrying it to new CPU after migrated, and
@@ -2836,6 +2837,29 @@ static inline void update_load_avg(struc
 
 	if (update_cfs_rq_load_avg(now, cfs_rq) && update_tg)
 		update_tg_load_avg(cfs_rq, 0);
+
+	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
+		unsigned long max = rq->cpu_capacity_orig;
+
+		/*
+		 * There are a few boundary cases this might miss but it should
+		 * get called often enough that that should (hopefully) not be
+		 * a real problem -- added to that it only calls on the local
+		 * CPU, so if we enqueue remotely we'll miss an update, but
+		 * the next tick/schedule should update.
+		 *
+		 * It will not get called when we go idle, because the idle
+		 * thread is a different class (!fair), nor will the utilization
+		 * number include things like RT tasks.
+		 *
+		 * As is, the util number is not freq-invariant (we'd have to
+		 * implement arch_scale_freq_capacity() for that).
+		 *
+		 * See cpu_util().
+		 */
+		cpufreq_update_util(rq_clock(rq),
+				    min(cfs_rq->avg.util_avg, max), max);
+	}
 }
 
 static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
Index: linux-pm/kernel/sched/deadline.c
===================================================================
--- linux-pm.orig/kernel/sched/deadline.c
+++ linux-pm/kernel/sched/deadline.c
@@ -935,6 +935,9 @@ static void enqueue_task_dl(struct rq *r
 	struct task_struct *pi_task = rt_mutex_get_top_task(p);
 	struct sched_dl_entity *pi_se = &p->dl;
 
+	/* Kick cpufreq (see the comment in linux/cpufreq.h). */
+	cpufreq_trigger_update(rq_clock(rq));
+
 	/*
 	 * Use the scheduling parameters of the top pi-waiter
 	 * task if we have one and its (absolute) deadline is
@@ -1205,6 +1208,9 @@ static void task_tick_dl(struct rq *rq,
 	if (hrtick_enabled(rq) && queued && p->dl.runtime > 0 &&
 	    is_leftmost(p, &rq->dl))
 		start_hrtick_dl(rq, p);
+
+	/* Kick cpufreq (see the comment in linux/cpufreq.h). */
+	cpufreq_trigger_update(rq_clock(rq));
 }
 
 static void task_fork_dl(struct task_struct *p)
Index: linux-pm/kernel/sched/rt.c
===================================================================
--- linux-pm.orig/kernel/sched/rt.c
+++ linux-pm/kernel/sched/rt.c
@@ -1257,6 +1257,9 @@ enqueue_task_rt(struct rq *rq, struct ta
 {
 	struct sched_rt_entity *rt_se = &p->rt;
 
+	/* Kick cpufreq (see the comment in linux/cpufreq.h). */
+	cpufreq_trigger_update(rq_clock(rq));
+
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout = 0;
 
@@ -2214,6 +2217,9 @@ static void task_tick_rt(struct rq *rq,
 
 	watchdog(rq, p);
 
+	/* Kick cpufreq (see the comment in linux/cpufreq.h). */
+	cpufreq_trigger_update(rq_clock(rq));
+
 	/*
 	 * RR tasks need a special form of timeslice management.
 	 * FIFO tasks have no timeslices.
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -102,6 +102,51 @@ static LIST_HEAD(cpufreq_governor_list);
 static struct cpufreq_driver *cpufreq_driver;
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
+
+static DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+
+/**
+ * cpufreq_set_update_util_data - Populate the CPU's update_util_data pointer.
+ * @cpu: The CPU to set the pointer for.
+ * @data: New pointer value.
+ *
+ * Set and publish the update_util_data pointer for the given CPU.  That pointer
+ * points to a struct update_util_data object containing a callback function
+ * to call from cpufreq_update_util().  That function will be called from an RCU
+ * read-side critical section, so it must not sleep.
+ *
+ * Callers must use RCU callbacks to free any memory that might be accessed
+ * via the old update_util_data pointer or invoke synchronize_rcu() right after
+ * this function to avoid use-after-free.
+ */
+void cpufreq_set_update_util_data(int cpu, struct update_util_data *data)
+{
+	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
+}
+EXPORT_SYMBOL_GPL(cpufreq_set_update_util_data);
+
+/**
+ * cpufreq_update_util - Take a note about CPU utilization changes.
+ * @time: Current time.
+ * @util: Current utilization.
+ * @max: Utilization ceiling.
+ *
+ * This function is called by the scheduler on every invocation of
+ * update_load_avg() on the CPU whose utilization is being updated.
+ */
+void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
+{
+	struct update_util_data *data;
+
+	rcu_read_lock();
+
+	data = rcu_dereference(*this_cpu_ptr(&cpufreq_update_util_data));
+	if (data && data->func)
+		data->func(data, time, util, max);
+
+	rcu_read_unlock();
+}
+
 DEFINE_MUTEX(cpufreq_governor_lock);
 
 /* Flag to suspend/resume CPUFreq governors */

