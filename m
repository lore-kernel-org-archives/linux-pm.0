From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3 v4] cpufreq: governor: Replace timers with utilization update callbacks
Date: Sat, 06 Feb 2016 04:40:46 +0100
Message-ID: <2848076.UWJmIl2O1K@vostro.rjw.lan>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <2546395.Be1INkvQBN@vostro.rjw.lan> <1486401.1RcnnVKZNP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57827 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750754AbcBFDjl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2016 22:39:41 -0500
In-Reply-To: <1486401.1RcnnVKZNP@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of using a per-CPU deferrable timer for queuing up governor
work items, register a utilization update callback that will be
invoked from the scheduler on utilization changes.

The sampling rate is still the same as what was used for the
deferrable timers and the added irq_work overhead should be offset by
the eliminated timers overhead, so in theory the functional impact of
this patch should not be significant.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Updated after the recent discussion with Viresh.

Changes from v3:
- The completion used for irq_work synchronization replaced with irq_work_sync()
  in gov_cancel_work().
- update_sampling_rate() now modifies shared->sample_delay_ns for all CPUs
  where it matters directly with a big fat comment explaining why this is
  actually OK.
- The above means the time_stamp field in struct cpu_common_dbs_info is not
  necessary any more, so it is dropped.
- A build error for !CONFIG_SMP is addressed (hopefully effectively).

This version was lightly tested on an x86 laptop.

Thanks!

---
 drivers/cpufreq/cpufreq_conservative.c |    6 -
 drivers/cpufreq/cpufreq_governor.c     |  164 +++++++++++++++------------------
 drivers/cpufreq/cpufreq_governor.h     |   19 ++-
 drivers/cpufreq/cpufreq_ondemand.c     |   43 ++++----
 4 files changed, 112 insertions(+), 120 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -18,6 +18,7 @@
 #define _CPUFREQ_GOVERNOR_H
 
 #include <linux/atomic.h>
+#include <linux/irq_work.h>
 #include <linux/cpufreq.h>
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
@@ -138,11 +139,19 @@ struct cpu_common_dbs_info {
 	 */
 	struct mutex timer_mutex;
 
-	ktime_t time_stamp;
+	u64 last_sample_time;
+	s64 sample_delay_ns;
 	atomic_t skip_work;
+	struct irq_work irq_work;
 	struct work_struct work;
 };
 
+static inline void gov_update_sample_delay(struct cpu_common_dbs_info *shared,
+					   unsigned int delay_us)
+{
+	shared->sample_delay_ns = delay_us * NSEC_PER_USEC;
+}
+
 /* Per cpu structures */
 struct cpu_dbs_info {
 	u64 prev_cpu_idle;
@@ -155,7 +164,7 @@ struct cpu_dbs_info {
 	 * wake-up from idle.
 	 */
 	unsigned int prev_load;
-	struct timer_list timer;
+	struct update_util_data update_util;
 	struct cpu_common_dbs_info *shared;
 };
 
@@ -212,8 +221,7 @@ struct common_dbs_data {
 
 	struct cpu_dbs_info *(*get_cpu_cdbs)(int cpu);
 	void *(*get_cpu_dbs_info_s)(int cpu);
-	unsigned int (*gov_dbs_timer)(struct cpufreq_policy *policy,
-				      bool modify_all);
+	unsigned int (*gov_dbs_timer)(struct cpufreq_policy *policy);
 	void (*gov_check_cpu)(int cpu, unsigned int load);
 	int (*init)(struct dbs_data *dbs_data, bool notify);
 	void (*exit)(struct dbs_data *dbs_data, bool notify);
@@ -270,9 +278,6 @@ static ssize_t show_sampling_rate_min_go
 }
 
 extern struct mutex cpufreq_governor_lock;
-
-void gov_add_timers(struct cpufreq_policy *policy, unsigned int delay);
-void gov_cancel_work(struct cpu_common_dbs_info *shared);
 void dbs_check_cpu(struct dbs_data *dbs_data, int cpu);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		struct common_dbs_data *cdata, unsigned int event);
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -128,10 +128,10 @@ void dbs_check_cpu(struct dbs_data *dbs_
 		 * dropped down. So we perform the copy only once, upon the
 		 * first wake-up from idle.)
 		 *
-		 * Detecting this situation is easy: the governor's deferrable
-		 * timer would not have fired during CPU-idle periods. Hence
-		 * an unusually large 'wall_time' (as compared to the sampling
-		 * rate) indicates this scenario.
+		 * Detecting this situation is easy: the governor's utilization
+		 * update handler would not have run during CPU-idle periods.
+		 * Hence, an unusually large 'wall_time' (as compared to the
+		 * sampling rate) indicates this scenario.
 		 *
 		 * prev_load can be zero in two cases and we must recalculate it
 		 * for both cases:
@@ -161,72 +161,48 @@ void dbs_check_cpu(struct dbs_data *dbs_
 }
 EXPORT_SYMBOL_GPL(dbs_check_cpu);
 
-void gov_add_timers(struct cpufreq_policy *policy, unsigned int delay)
+void gov_set_update_util(struct cpu_common_dbs_info *shared,
+			 unsigned int delay_us)
 {
+	struct cpufreq_policy *policy = shared->policy;
 	struct dbs_data *dbs_data = policy->governor_data;
-	struct cpu_dbs_info *cdbs;
 	int cpu;
 
+	gov_update_sample_delay(shared, delay_us);
+	shared->last_sample_time = 0;
+
 	for_each_cpu(cpu, policy->cpus) {
-		cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
-		cdbs->timer.expires = jiffies + delay;
-		add_timer_on(&cdbs->timer, cpu);
+		struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
+
+		cpufreq_set_update_util_data(cpu, &cdbs->update_util);
 	}
 }
-EXPORT_SYMBOL_GPL(gov_add_timers);
+EXPORT_SYMBOL_GPL(gov_set_update_util);
 
-static inline void gov_cancel_timers(struct cpufreq_policy *policy)
+static inline void gov_clear_update_util(struct cpufreq_policy *policy)
 {
-	struct dbs_data *dbs_data = policy->governor_data;
-	struct cpu_dbs_info *cdbs;
 	int i;
 
-	for_each_cpu(i, policy->cpus) {
-		cdbs = dbs_data->cdata->get_cpu_cdbs(i);
-		del_timer_sync(&cdbs->timer);
-	}
+	for_each_cpu(i, policy->cpus)
+		cpufreq_set_update_util_data(i, NULL);
+
+	synchronize_rcu();
 }
 
-void gov_cancel_work(struct cpu_common_dbs_info *shared)
+static void gov_cancel_work(struct cpu_common_dbs_info *shared)
 {
-	/* Tell dbs_timer_handler() to skip queuing up work items. */
+	/* Tell dbs_update_util_handler() to skip queuing up work items. */
 	atomic_inc(&shared->skip_work);
 	/*
-	 * If dbs_timer_handler() is already running, it may not notice the
-	 * incremented skip_work, so wait for it to complete to prevent its work
-	 * item from being queued up after the cancel_work_sync() below.
-	 */
-	gov_cancel_timers(shared->policy);
-	/*
-	 * In case dbs_timer_handler() managed to run and spawn a work item
-	 * before the timers have been canceled, wait for that work item to
-	 * complete and then cancel all of the timers set up by it.  If
-	 * dbs_timer_handler() runs again at that point, it will see the
-	 * positive value of skip_work and won't spawn any more work items.
+	 * If dbs_update_util_handler() is already running, it may not notice
+	 * the incremented skip_work, so wait for it to complete to prevent its
+	 * work item from being queued up after the cancel_work_sync() below.
 	 */
+	gov_clear_update_util(shared->policy);
+	irq_work_sync(&shared->irq_work);
 	cancel_work_sync(&shared->work);
-	gov_cancel_timers(shared->policy);
 	atomic_set(&shared->skip_work, 0);
 }
-EXPORT_SYMBOL_GPL(gov_cancel_work);
-
-/* Will return if we need to evaluate cpu load again or not */
-static bool need_load_eval(struct cpu_common_dbs_info *shared,
-			   unsigned int sampling_rate)
-{
-	if (policy_is_shared(shared->policy)) {
-		ktime_t time_now = ktime_get();
-		s64 delta_us = ktime_us_delta(time_now, shared->time_stamp);
-
-		/* Do nothing if we recently have sampled */
-		if (delta_us < (s64)(sampling_rate / 2))
-			return false;
-		else
-			shared->time_stamp = time_now;
-	}
-
-	return true;
-}
 
 static void dbs_work_handler(struct work_struct *work)
 {
@@ -234,56 +210,69 @@ static void dbs_work_handler(struct work
 					cpu_common_dbs_info, work);
 	struct cpufreq_policy *policy;
 	struct dbs_data *dbs_data;
-	unsigned int sampling_rate, delay;
-	bool eval_load;
+	unsigned int delay;
 
 	policy = shared->policy;
 	dbs_data = policy->governor_data;
 
-	/* Kill all timers */
-	gov_cancel_timers(policy);
-
-	if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
-		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
-
-		sampling_rate = cs_tuners->sampling_rate;
-	} else {
-		struct od_dbs_tuners *od_tuners = dbs_data->tuners;
-
-		sampling_rate = od_tuners->sampling_rate;
-	}
-
-	eval_load = need_load_eval(shared, sampling_rate);
-
 	/*
-	 * Make sure cpufreq_governor_limits() isn't evaluating load in
-	 * parallel.
+	 * Make sure cpufreq_governor_limits() isn't evaluating load or the
+	 * ondemand governor isn't updating the sampling rate in parallel.
 	 */
 	mutex_lock(&shared->timer_mutex);
-	delay = dbs_data->cdata->gov_dbs_timer(policy, eval_load);
+	delay = dbs_data->cdata->gov_dbs_timer(policy);
+	shared->sample_delay_ns = jiffies_to_nsecs(delay);
 	mutex_unlock(&shared->timer_mutex);
 
+	/*
+	 * If the atomic operation below is reordered with respect to the
+	 * sample delay modification, the utilization update handler may end
+	 * up using a stale sample delay value.
+	 */
+	smp_mb__before_atomic();
 	atomic_dec(&shared->skip_work);
+}
+
+static void dbs_irq_work(struct irq_work *irq_work)
+{
+	struct cpu_common_dbs_info *shared;
+
+	shared = container_of(irq_work, struct cpu_common_dbs_info, irq_work);
+	schedule_work(&shared->work);
+}
 
-	gov_add_timers(policy, delay);
+static inline void gov_queue_irq_work(struct cpu_common_dbs_info *shared)
+{
+	if (IS_ENABLED(CONFIG_SMP))
+		irq_work_queue_on(&shared->irq_work, smp_processor_id());
+	else
+		irq_work_queue(&shared->irq_work);
 }
 
-static void dbs_timer_handler(unsigned long data)
+static void dbs_update_util_handler(struct update_util_data *data, u64 time,
+				    unsigned long util, unsigned long max)
 {
-	struct cpu_dbs_info *cdbs = (struct cpu_dbs_info *)data;
+	struct cpu_dbs_info *cdbs = container_of(data, struct cpu_dbs_info, update_util);
 	struct cpu_common_dbs_info *shared = cdbs->shared;
 
 	/*
-	 * Timer handler may not be allowed to queue the work at the moment,
-	 * because:
-	 * - Another timer handler has done that
-	 * - We are stopping the governor
-	 * - Or we are updating the sampling rate of the ondemand governor
+	 * The work may not be allowed to be queued up right now.
+	 * Possible reasons:
+	 * - Work has already been queued up or is in progress.
+	 * - The governor is being stopped.
+	 * - It is too early (too little time from the previous sample).
 	 */
-	if (atomic_inc_return(&shared->skip_work) > 1)
-		atomic_dec(&shared->skip_work);
-	else
-		queue_work(system_wq, &shared->work);
+	if (atomic_inc_return(&shared->skip_work) == 1) {
+		u64 delta_ns;
+
+		delta_ns = time - shared->last_sample_time;
+		if ((s64)delta_ns >= shared->sample_delay_ns) {
+			shared->last_sample_time = time;
+			gov_queue_irq_work(shared);
+			return;
+		}
+	}
+	atomic_dec(&shared->skip_work);
 }
 
 static void set_sampling_rate(struct dbs_data *dbs_data,
@@ -467,9 +456,6 @@ static int cpufreq_governor_start(struct
 		io_busy = od_tuners->io_is_busy;
 	}
 
-	shared->policy = policy;
-	shared->time_stamp = ktime_get();
-
 	for_each_cpu(j, policy->cpus) {
 		struct cpu_dbs_info *j_cdbs = cdata->get_cpu_cdbs(j);
 		unsigned int prev_load;
@@ -485,10 +471,10 @@ static int cpufreq_governor_start(struct
 		if (ignore_nice)
 			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 
-		__setup_timer(&j_cdbs->timer, dbs_timer_handler,
-			      (unsigned long)j_cdbs,
-			      TIMER_DEFERRABLE | TIMER_IRQSAFE);
+		j_cdbs->update_util.func = dbs_update_util_handler;
 	}
+	shared->policy = policy;
+	init_irq_work(&shared->irq_work, dbs_irq_work);
 
 	if (cdata->governor == GOV_CONSERVATIVE) {
 		struct cs_cpu_dbs_info_s *cs_dbs_info =
@@ -505,7 +491,7 @@ static int cpufreq_governor_start(struct
 		od_ops->powersave_bias_init_cpu(cpu);
 	}
 
-	gov_add_timers(policy, delay_for_sampling_rate(sampling_rate));
+	gov_set_update_util(shared, sampling_rate);
 	return 0;
 }
 
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -191,7 +191,7 @@ static void od_check_cpu(int cpu, unsign
 	}
 }
 
-static unsigned int od_dbs_timer(struct cpufreq_policy *policy, bool modify_all)
+static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
 {
 	struct dbs_data *dbs_data = policy->governor_data;
 	unsigned int cpu = policy->cpu;
@@ -200,9 +200,6 @@ static unsigned int od_dbs_timer(struct
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	int delay = 0, sample_type = dbs_info->sample_type;
 
-	if (!modify_all)
-		goto max_delay;
-
 	/* Common NORMAL_SAMPLE setup */
 	dbs_info->sample_type = OD_NORMAL_SAMPLE;
 	if (sample_type == OD_SUB_SAMPLE) {
@@ -218,7 +215,6 @@ static unsigned int od_dbs_timer(struct
 		}
 	}
 
-max_delay:
 	if (!delay)
 		delay = delay_for_sampling_rate(od_tuners->sampling_rate
 				* dbs_info->rate_mult);
@@ -264,7 +260,6 @@ static void update_sampling_rate(struct
 		struct od_cpu_dbs_info_s *dbs_info;
 		struct cpu_dbs_info *cdbs;
 		struct cpu_common_dbs_info *shared;
-		unsigned long next_sampling, appointed_at;
 
 		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
 		cdbs = &dbs_info->cdbs;
@@ -288,20 +283,28 @@ static void update_sampling_rate(struct
 		 * policy will be governed by dbs_data, otherwise there can be
 		 * multiple policies that are governed by the same dbs_data.
 		 */
-		if (dbs_data != policy->governor_data)
-			continue;
-
-		/*
-		 * Checking this for any CPU should be fine, timers for all of
-		 * them are scheduled together.
-		 */
-		next_sampling = jiffies + usecs_to_jiffies(new_rate);
-		appointed_at = dbs_info->cdbs.timer.expires;
-
-		if (time_before(next_sampling, appointed_at)) {
-			gov_cancel_work(shared);
-			gov_add_timers(policy, usecs_to_jiffies(new_rate));
-
+		if (dbs_data == policy->governor_data) {
+			mutex_lock(&shared->timer_mutex);
+			/*
+			 * On 32-bit architectures this may race with the
+			 * sample_delay_ns read in dbs_update_util_handler(),
+			 * but that really doesn't matter.  If the read returns
+			 * a value that's too big, the sample will be skipped,
+			 * but the next invocation of dbs_update_util_handler()
+			 * (when the update has been completed) will take a
+			 * sample.  If the returned value is too small, the
+			 * sample will be taken immediately, but that isn't a
+			 * problem, as we want the new rate to take effect
+			 * immediately anyway.
+			 *
+			 * If this runs in parallel with dbs_work_handler(), we
+			 * may end up overwriting the sample_delay_ns value that
+			 * it has just written, but the difference should not be
+			 * too big and it will be corrected next time a sample
+			 * is taken, so it shouldn't be significant.
+			 */
+			gov_update_sample_delay(shared, new_rate);
+			mutex_unlock(&shared->timer_mutex);
 		}
 	}
 
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -115,14 +115,12 @@ static void cs_check_cpu(int cpu, unsign
 	}
 }
 
-static unsigned int cs_dbs_timer(struct cpufreq_policy *policy, bool modify_all)
+static unsigned int cs_dbs_timer(struct cpufreq_policy *policy)
 {
 	struct dbs_data *dbs_data = policy->governor_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
-	if (modify_all)
-		dbs_check_cpu(dbs_data, policy->cpu);
-
+	dbs_check_cpu(dbs_data, policy->cpu);
 	return delay_for_sampling_rate(cs_tuners->sampling_rate);
 }
 

