From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 5/6] cpufreq: governor: replace per-cpu delayed work with timers
Date: Thu,  3 Dec 2015 09:37:53 +0530
Message-ID: <691a3524afaa8d08d61987b1c2913948b4e59f01.1449115453.git.viresh.kumar@linaro.org>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1449115453.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1449115453.git.viresh.kumar@linaro.org>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

cpufreq governors evaluate load at sampling rate and based on that they
update frequency for a group of CPUs belonging to the same cpufreq
policy.

This is required to be done in a single thread for all policy->cpus, but
because we don't want to wakeup idle CPUs to do just that, we use
deferrable work for this. If we would have used a single delayed
deferrable work for the entire policy, there were chances that the CPU
required to run the handler can be in idle and we might end up not
changing the frequency for the entire group with load variations.

And so we were forced to keep per-cpu works, and only the one that
expires first need to do the real work and others are rescheduled for
next sampling time.

We have been using the more complex solution until now, where we used a
delayed deferrable work for this, which is a combination of a timer and
a work.

This could be made lightweight by keeping per-cpu deferred timers with a
single work item, which is scheduled by the first timer that expires.

This patch does just that and here are important changes:
- The timer handler will run in irq context and so we need to use a
  spin_lock instead of the timer_mutex. And so a separate timer_lock is
  created. This also makes the use of the mutex and lock quite clear, as
  we know what exactly they are protecting.
- A new field 'skip_work' is added to track when the timer handlers can
  queue a work. More comments present in code.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 139 +++++++++++++++++++++----------------
 drivers/cpufreq/cpufreq_governor.h |  20 ++++--
 drivers/cpufreq/cpufreq_ondemand.c |   8 +--
 3 files changed, 98 insertions(+), 69 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 999e1f6addf9..a3f9bc9b98e9 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -158,47 +158,52 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 }
 EXPORT_SYMBOL_GPL(dbs_check_cpu);
 
-static inline void __gov_queue_work(int cpu, struct dbs_data *dbs_data,
-		unsigned int delay)
+void gov_add_timers(struct cpufreq_policy *policy, unsigned int delay)
 {
-	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
-
-	mod_delayed_work_on(cpu, system_wq, &cdbs->dwork, delay);
-}
-
-void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
-		unsigned int delay, bool all_cpus)
-{
-	int i;
+	struct dbs_data *dbs_data = policy->governor_data;
+	struct cpu_dbs_info *cdbs;
+	int cpu;
 
-	if (!all_cpus) {
-		/*
-		 * Use raw_smp_processor_id() to avoid preemptible warnings.
-		 * We know that this is only called with all_cpus == false from
-		 * works that have been queued with *_work_on() functions and
-		 * those works are canceled during CPU_DOWN_PREPARE so they
-		 * can't possibly run on any other CPU.
-		 */
-		__gov_queue_work(raw_smp_processor_id(), dbs_data, delay);
-	} else {
-		for_each_cpu(i, policy->cpus)
-			__gov_queue_work(i, dbs_data, delay);
+	for_each_cpu(cpu, policy->cpus) {
+		cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
+		cdbs->timer.expires = jiffies + delay;
+		add_timer_on(&cdbs->timer, cpu);
 	}
 }
-EXPORT_SYMBOL_GPL(gov_queue_work);
+EXPORT_SYMBOL_GPL(gov_add_timers);
 
-static inline void gov_cancel_work(struct dbs_data *dbs_data,
-		struct cpufreq_policy *policy)
+static inline void gov_cancel_timers(struct cpufreq_policy *policy)
 {
+	struct dbs_data *dbs_data = policy->governor_data;
 	struct cpu_dbs_info *cdbs;
 	int i;
 
 	for_each_cpu(i, policy->cpus) {
 		cdbs = dbs_data->cdata->get_cpu_cdbs(i);
-		cancel_delayed_work_sync(&cdbs->dwork);
+		del_timer_sync(&cdbs->timer);
 	}
 }
 
+void gov_cancel_work(struct cpu_common_dbs_info *shared)
+{
+	unsigned long flags;
+
+	/*
+	 * No work will be queued from timer handlers after skip_work is
+	 * updated. And so we can safely cancel the work first and then the
+	 * timers.
+	 */
+	spin_lock_irqsave(&shared->timer_lock, flags);
+	shared->skip_work++;
+	spin_unlock_irqrestore(&shared->timer_lock, flags);
+
+	cancel_work_sync(&shared->work);
+
+	gov_cancel_timers(shared->policy);
+
+	shared->skip_work = 0;
+}
+
 /* Will return if we need to evaluate cpu load again or not */
 static bool need_load_eval(struct cpu_common_dbs_info *shared,
 			   unsigned int sampling_rate)
@@ -217,29 +222,21 @@ static bool need_load_eval(struct cpu_common_dbs_info *shared,
 	return true;
 }
 
-static void dbs_timer(struct work_struct *work)
+static void dbs_work_handler(struct work_struct *work)
 {
-	struct cpu_dbs_info *cdbs = container_of(work, struct cpu_dbs_info,
-						 dwork.work);
-	struct cpu_common_dbs_info *shared = cdbs->shared;
+	struct cpu_common_dbs_info *shared = container_of(work, struct
+					cpu_common_dbs_info, work);
 	struct cpufreq_policy *policy;
 	struct dbs_data *dbs_data;
 	unsigned int sampling_rate, delay;
-	bool modify_all = true;
-
-	mutex_lock(&shared->timer_mutex);
+	bool eval_load;
 
 	policy = shared->policy;
-
-	/*
-	 * Governor might already be disabled and there is no point continuing
-	 * with the work-handler.
-	 */
-	if (!policy)
-		goto unlock;
-
 	dbs_data = policy->governor_data;
 
+	/* Kill all timers */
+	gov_cancel_timers(policy);
+
 	if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
@@ -250,14 +247,44 @@ static void dbs_timer(struct work_struct *work)
 		sampling_rate = od_tuners->sampling_rate;
 	}
 
-	if (!need_load_eval(cdbs->shared, sampling_rate))
-		modify_all = false;
+	eval_load = need_load_eval(shared, sampling_rate);
 
-	delay = dbs_data->cdata->gov_dbs_timer(policy, modify_all);
-	gov_queue_work(dbs_data, policy, delay, modify_all);
+	/*
+	 * Make sure cpufreq_governor_limits() isn't evaluating load in
+	 * parallel.
+	 */
+	mutex_lock(&shared->timer_mutex);
+	delay = dbs_data->cdata->gov_dbs_timer(policy, eval_load);
+	mutex_unlock(&shared->timer_mutex);
+
+	shared->skip_work--;
+	gov_add_timers(policy, delay);
+}
+
+static void dbs_timer_handler(unsigned long data)
+{
+	struct cpu_dbs_info *cdbs = (struct cpu_dbs_info *)data;
+	struct cpu_common_dbs_info *shared = cdbs->shared;
+	struct cpufreq_policy *policy;
+	unsigned long flags;
+
+	spin_lock_irqsave(&shared->timer_lock, flags);
+	policy = shared->policy;
+
+	/*
+	 * Timer handler isn't allowed to queue work at the moment, because:
+	 * - Another timer handler has done that
+	 * - We are stopping the governor
+	 * - Or we are updating the sampling rate of ondemand governor
+	 */
+	if (shared->skip_work)
+		goto unlock;
+
+	shared->skip_work++;
+	queue_work(system_wq, &shared->work);
 
 unlock:
-	mutex_unlock(&shared->timer_mutex);
+	spin_unlock_irqrestore(&shared->timer_lock, flags);
 }
 
 static void set_sampling_rate(struct dbs_data *dbs_data,
@@ -288,6 +315,8 @@ static int alloc_common_dbs_info(struct cpufreq_policy *policy,
 		cdata->get_cpu_cdbs(j)->shared = shared;
 
 	mutex_init(&shared->timer_mutex);
+	spin_lock_init(&shared->timer_lock);
+	INIT_WORK(&shared->work, dbs_work_handler);
 	return 0;
 }
 
@@ -452,7 +481,9 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 		if (ignore_nice)
 			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 
-		INIT_DEFERRABLE_WORK(&j_cdbs->dwork, dbs_timer);
+		__setup_timer(&j_cdbs->timer, dbs_timer_handler,
+			      (unsigned long)j_cdbs,
+			      TIMER_DEFERRABLE | TIMER_IRQSAFE);
 	}
 
 	if (cdata->governor == GOV_CONSERVATIVE) {
@@ -470,8 +501,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 		od_ops->powersave_bias_init_cpu(cpu);
 	}
 
-	gov_queue_work(dbs_data, policy, delay_for_sampling_rate(sampling_rate),
-		       true);
+	gov_add_timers(policy, delay_for_sampling_rate(sampling_rate));
 	return 0;
 }
 
@@ -485,16 +515,9 @@ static int cpufreq_governor_stop(struct cpufreq_policy *policy,
 	if (!shared || !shared->policy)
 		return -EBUSY;
 
-	/*
-	 * Work-handler must see this updated, as it should not proceed any
-	 * further after governor is disabled. And so timer_mutex is taken while
-	 * updating this value.
-	 */
-	mutex_lock(&shared->timer_mutex);
+	gov_cancel_work(shared);
 	shared->policy = NULL;
-	mutex_unlock(&shared->timer_mutex);
 
-	gov_cancel_work(dbs_data, policy);
 	return 0;
 }
 
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 0c7589016b6c..76742902491e 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -132,12 +132,20 @@ static void *get_cpu_dbs_info_s(int cpu)				\
 struct cpu_common_dbs_info {
 	struct cpufreq_policy *policy;
 	/*
-	 * percpu mutex that serializes governor limit change with dbs_timer
-	 * invocation. We do not want dbs_timer to run when user is changing
-	 * the governor or limits.
+	 * Per policy mutex that serializes load evaluation from limit-change
+	 * and work-handler.
 	 */
 	struct mutex timer_mutex;
+
+	/*
+	 * Per policy lock that serializes access to queuing work from timer
+	 * handlers.
+	 */
+	spinlock_t timer_lock;
+
 	ktime_t time_stamp;
+	unsigned int skip_work;
+	struct work_struct work;
 };
 
 /* Per cpu structures */
@@ -152,7 +160,7 @@ struct cpu_dbs_info {
 	 * wake-up from idle.
 	 */
 	unsigned int prev_load;
-	struct delayed_work dwork;
+	struct timer_list timer;
 	struct cpu_common_dbs_info *shared;
 };
 
@@ -268,11 +276,11 @@ static ssize_t show_sampling_rate_min_gov_pol				\
 
 extern struct mutex cpufreq_governor_lock;
 
+void gov_add_timers(struct cpufreq_policy *policy, unsigned int delay);
+void gov_cancel_work(struct cpu_common_dbs_info *shared);
 void dbs_check_cpu(struct dbs_data *dbs_data, int cpu);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		struct common_dbs_data *cdata, unsigned int event);
-void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
-		unsigned int delay, bool all_cpus);
 void od_register_powersave_bias_handler(unsigned int (*f)
 		(struct cpufreq_policy *, unsigned int, unsigned int),
 		unsigned int powersave_bias);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index fc0384b4d02d..f879012cf849 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -286,13 +286,11 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 			continue;
 
 		next_sampling = jiffies + usecs_to_jiffies(new_rate);
-		appointed_at = dbs_info->cdbs.dwork.timer.expires;
+		appointed_at = dbs_info->cdbs.timer.expires;
 
 		if (time_before(next_sampling, appointed_at)) {
-			cancel_delayed_work_sync(&dbs_info->cdbs.dwork);
-
-			gov_queue_work(dbs_data, policy,
-				       usecs_to_jiffies(new_rate), true);
+			gov_cancel_work(shared);
+			gov_add_timers(policy, usecs_to_jiffies(new_rate));
 
 		}
 	}
-- 
2.6.2.198.g614a2ac
