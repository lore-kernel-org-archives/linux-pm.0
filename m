From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v6 1/3] cpufreq: Add mechanism for registering utilization update callbacks
Date: Wed, 10 Feb 2016 16:21:26 +0100
Message-ID: <37328841.RPntzkbDJG@vostro.rjw.lan>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <2111826.yKEUOzphHC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2111826.yKEUOzphHC@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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

Hi Ingo,

This has been based on Peter's advice, but he's not been well for the last
several days, so can you plase have a look at this and let me know whether
or not it is acceptable and how it can be improved possibly?

The ACK from Viresh applies to the cpufreq core changes that are the same
as in the previous version(s) of this patch.

Thanks,
Rafael

---
 drivers/cpufreq/cpufreq.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |   17 +++++++++++++++++
 kernel/sched/deadline.c   |    3 +++
 kernel/sched/fair.c       |   26 +++++++++++++++++++++++++-
 kernel/sched/rt.c         |    3 +++
 kernel/sched/sched.h      |    1 +
 6 files changed, 94 insertions(+), 1 deletion(-)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -151,6 +151,19 @@ static inline bool policy_is_shared(stru
 extern struct kobject *cpufreq_global_kobject;
 
 #ifdef CONFIG_CPU_FREQ
+void cpufreq_update_util(u64 time, unsigned long util, unsigned long max);
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
@@ -162,6 +175,10 @@ int cpufreq_update_policy(unsigned int c
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
+		cpufreq_update_util(rq_clock_task(rq),
+				    min(cfs_rq->avg.util_avg, max), max);
+	}
 }
 
 static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
Index: linux-pm/kernel/sched/deadline.c
===================================================================
--- linux-pm.orig/kernel/sched/deadline.c
+++ linux-pm/kernel/sched/deadline.c
@@ -726,6 +726,9 @@ static void update_curr_dl(struct rq *rq
 	if (!dl_task(curr) || !on_dl_rq(dl_se))
 		return;
 
+	/* Kick a cpufreq update to prevent it from stalling. */
+	cpufreq_trigger_update(rq_clock_task(rq));
+
 	/*
 	 * Consumed budget is computed considering the time as
 	 * observed by schedulable tasks (excluding time spent
Index: linux-pm/kernel/sched/rt.c
===================================================================
--- linux-pm.orig/kernel/sched/rt.c
+++ linux-pm/kernel/sched/rt.c
@@ -949,6 +949,9 @@ static void update_curr_rt(struct rq *rq
 	if (unlikely((s64)delta_exec <= 0))
 		return;
 
+	/* Kick a cpufreq update to prevent it from stalling. */
+	cpufreq_trigger_update(rq_clock_task(rq));
+
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
 
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
