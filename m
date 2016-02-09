From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Tue, 09 Feb 2016 21:05:05 +0100
Message-ID: <5387313.xAhVpzgZCg@vostro.rjw.lan>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <56B93548.9090006@linaro.org> <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55708 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753623AbcBIUDy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 15:03:54 -0500
In-Reply-To: <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Tuesday, February 09, 2016 02:01:39 AM Rafael J. Wysocki wrote:
> On Tue, Feb 9, 2016 at 1:39 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> > Hi Rafael,
> >
> > On 02/08/2016 03:06 PM, Rafael J. Wysocki wrote:
> >> Now that all review comments have been addressed in patch [3/3], I'm going to
> >> put this series into linux-next.
> >>
> >> There already is 20+ patches on top of it in the queue including fixes for
> >> bugs that have haunted us for quite some time (and that functionally depend on
> >> this set) and I'd really like all that to get enough linux-next coverage, so
> >> there really isn't more time to wait.
> >
> > Sorry for the late reply. As Juri mentioned I was OOO last week and
> > really just got to look at this today.
> >
> > One concern I had was, given that the lone scheduler update hook is in
> > CFS, is it possible for governor updates to be stalled due to RT or DL
> > task activity?
> 
> I don't think they may be completely stalled, but I'd prefer Peter to
> answer that as he suggested to do it this way.

In any case, if that concern turns out to be significant in practice, it may
be addressed like in the appended modification of patch [1/3] from the $subject
series.

With that things look like before from the cpufreq side, but the other sched
classes also get a chance to trigger a cpufreq update.  The drawback is the
cpu_clock() call instead of passing the time value from update_load_avg(), but
I guess we can live with that if necessary.

FWIW, this modification doesn't seem to break things on my test machine.

Thanks,
Rafael


Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |    7 +++++++
 include/linux/sched.h     |    7 +++++++
 kernel/sched/deadline.c   |    3 +++
 kernel/sched/fair.c       |   29 ++++++++++++++++++++++++++++-
 kernel/sched/rt.c         |    3 +++
 6 files changed, 92 insertions(+), 1 deletion(-)

Index: linux-pm/include/linux/sched.h
===================================================================
--- linux-pm.orig/include/linux/sched.h
+++ linux-pm/include/linux/sched.h
@@ -3207,4 +3207,11 @@ static inline unsigned long rlimit_max(u
 	return task_rlimit_max(current, limit);
 }
 
+void cpufreq_update_util(unsigned long util, unsigned long max);
+
+static inline void cpufreq_kick(void)
+{
+	cpufreq_update_util(ULONG_MAX, ULONG_MAX);
+}
+
 #endif
Index: linux-pm/kernel/sched/fair.c
===================================================================
--- linux-pm.orig/kernel/sched/fair.c
+++ linux-pm/kernel/sched/fair.c
@@ -2819,12 +2819,17 @@ static inline int update_cfs_rq_load_avg
 	return decayed || removed;
 }
 
+__weak void cpufreq_update_util(unsigned long util, unsigned long max)
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
@@ -2836,6 +2841,28 @@ static inline void update_load_avg(struc
 
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
+		cpufreq_update_util(min(cfs_rq->avg.util_avg, max), max);
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
+void cpufreq_update_util(unsigned long util, unsigned long max)
+{
+	struct update_util_data *data;
+
+	rcu_read_lock();
+
+	data = rcu_dereference(*this_cpu_ptr(&cpufreq_update_util_data));
+	if (data && data->func)
+		data->func(data, cpu_clock(smp_processor_id()), util, max);
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
Index: linux-pm/kernel/sched/rt.c
===================================================================
--- linux-pm.orig/kernel/sched/rt.c
+++ linux-pm/kernel/sched/rt.c
@@ -2212,6 +2212,9 @@ static void task_tick_rt(struct rq *rq,
 
 	update_curr_rt(rq);
 
+	/* Kick cpufreq to prevent it from stalling. */
+	cpufreq_kick();
+
 	watchdog(rq, p);
 
 	/*
Index: linux-pm/kernel/sched/deadline.c
===================================================================
--- linux-pm.orig/kernel/sched/deadline.c
+++ linux-pm/kernel/sched/deadline.c
@@ -1197,6 +1197,9 @@ static void task_tick_dl(struct rq *rq,
 {
 	update_curr_dl(rq);
 
+	/* Kick cpufreq to prevent it from stalling. */
+	cpufreq_kick();
+
 	/*
 	 * Even when we have runtime, update_curr_dl() might have resulted in us
 	 * not being the leftmost task anymore. In that case NEED_RESCHED will

