From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] cpufreq: Add a mechanism for registering utilization update callbacks
Date: Fri, 29 Jan 2016 23:53:50 +0100
Message-ID: <1895005.WdX4A2LmI5@vostro.rjw.lan>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3071836.JbNxX8hU6x@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
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

The scheduler changes were suggested by Peter Zijlstra.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |    7 +++++++
 include/linux/sched.h     |    2 ++
 kernel/sched/fair.c       |   29 ++++++++++++++++++++++++++++-
 4 files changed, 81 insertions(+), 1 deletion(-)

Index: linux-pm/include/linux/sched.h
===================================================================
--- linux-pm.orig/include/linux/sched.h
+++ linux-pm/include/linux/sched.h
@@ -3207,4 +3207,6 @@ static inline unsigned long rlimit_max(u
 	return task_rlimit_max(current, limit);
 }
 
+void cpufreq_update_util(u64 time, unsigned long util, unsigned long max);
+
 #endif
Index: linux-pm/kernel/sched/fair.c
===================================================================
--- linux-pm.orig/kernel/sched/fair.c
+++ linux-pm/kernel/sched/fair.c
@@ -2803,12 +2803,17 @@ static inline int update_cfs_rq_load_avg
 	return decayed || removed;
 }
 
+__weak void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
+{
+}
+
 /* Update task and its cfs_rq load average */
 static inline void update_load_avg(struct sched_entity *se, int update_tg)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	u64 now = cfs_rq_clock_task(cfs_rq);
-	int cpu = cpu_of(rq_of(cfs_rq));
+	struct rq *rq = rq_of(cfs_rq);
+	int cpu = cpu_of(rq);
 
 	/*
 	 * Track task load average for carrying it to new CPU after migrated, and
@@ -2820,6 +2825,28 @@ static inline void update_load_avg(struc
 
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
+		 * CPU, so if we enqueue remotely we'll loose an update, but
+		 * the next tick/schedule should update.
+		 *
+		 * It will not get called when we go idle, because the idle
+		 * thread is a different class (!fair), nor will the utilization
+		 * number include things like RT tasks.
+		 *
+		 * As is, the util number is not freq invariant (we'd have to
+		 * implement arch_scale_freq_capacity() for that).
+		 *
+		 * See cpu_util().
+		 */
+		cpufreq_update_util(now, min(cfs_rq->avg.util_avg, max), max);
+	}
 }
 
 static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -102,6 +102,50 @@ static LIST_HEAD(cpufreq_governor_list);
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
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -322,6 +322,13 @@ int cpufreq_unregister_driver(struct cpu
 const char *cpufreq_get_current_driver(void);
 void *cpufreq_get_driver_data(void);
 
+struct update_util_data {
+	void (*func)(struct update_util_data *data,
+		     u64 time, unsigned long util, unsigned long max);
+};
+
+void cpufreq_set_update_util_data(int cpu, struct update_util_data *data);
+
 static inline void cpufreq_verify_within_limits(struct cpufreq_policy *policy,
 		unsigned int min, unsigned int max)
 {
