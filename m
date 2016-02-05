From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 8/10] cpufreq: governor: Rename cpu_common_dbs_info to policy_dbs_info
Date: Fri, 05 Feb 2016 03:20:37 +0100
Message-ID: <2973464.jyrWv0qA55@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <9008098.QDD8C89zDx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9008098.QDD8C89zDx@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The struct cpu_common_dbs_info structure represents the per-policy
part of the governor data (for the ondemand and conservative
governors), but its name doesn't reflect its purpose.

Rename it to struct policy_dbs_info and rename variables related to
it accordingly.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |  120 ++++++++++++++++++-------------------
 drivers/cpufreq/cpufreq_governor.h |    8 +-
 drivers/cpufreq/cpufreq_ondemand.c |   32 ++++-----
 3 files changed, 80 insertions(+), 80 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -132,7 +132,7 @@ static void *get_cpu_dbs_info_s(int cpu)
  */
 
 /* Common to all CPUs of a policy */
-struct cpu_common_dbs_info {
+struct policy_dbs_info {
 	struct cpufreq_policy *policy;
 	/*
 	 * Per policy mutex that serializes load evaluation from limit-change
@@ -162,7 +162,7 @@ struct cpu_dbs_info {
 	 */
 	unsigned int prev_load;
 	struct update_util_data update_util;
-	struct cpu_common_dbs_info *shared;
+	struct policy_dbs_info *shared;
 };
 
 struct od_cpu_dbs_info_s {
@@ -276,9 +276,9 @@ static ssize_t show_sampling_rate_min_go
 
 extern struct mutex dbs_data_mutex;
 extern struct mutex cpufreq_governor_lock;
-void gov_set_update_util(struct cpu_common_dbs_info *shared,
+void gov_set_update_util(struct policy_dbs_info *policy_dbs,
 			 unsigned int delay_us);
-void gov_cancel_work(struct cpu_common_dbs_info *shared);
+void gov_cancel_work(struct policy_dbs_info *policy_dbs);
 void dbs_check_cpu(struct cpufreq_policy *policy, int cpu);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy, unsigned int event);
 void od_register_powersave_bias_handler(unsigned int (*f)
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -163,16 +163,16 @@ void dbs_check_cpu(struct cpufreq_policy
 }
 EXPORT_SYMBOL_GPL(dbs_check_cpu);
 
-void gov_set_update_util(struct cpu_common_dbs_info *shared,
+void gov_set_update_util(struct policy_dbs_info *policy_dbs,
 			 unsigned int delay_us)
 {
-	struct cpufreq_policy *policy = shared->policy;
+	struct cpufreq_policy *policy = policy_dbs->policy;
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	int cpu;
 
-	shared->sample_delay_ns = delay_us * NSEC_PER_USEC;
-	shared->time_stamp = ktime_get();
-	shared->last_sample_time = 0;
+	policy_dbs->sample_delay_ns = delay_us * NSEC_PER_USEC;
+	policy_dbs->time_stamp = ktime_get();
+	policy_dbs->last_sample_time = 0;
 
 	for_each_cpu(cpu, policy->cpus) {
 		struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
@@ -192,31 +192,31 @@ static inline void gov_clear_update_util
 	synchronize_rcu();
 }
 
-void gov_cancel_work(struct cpu_common_dbs_info *shared)
+void gov_cancel_work(struct policy_dbs_info *policy_dbs)
 {
 	/* Tell dbs_update_util_handler() to skip queuing up work items. */
-	atomic_inc(&shared->skip_work);
+	atomic_inc(&policy_dbs->skip_work);
 	/*
 	 * If dbs_update_util_handler() is already running, it may not notice
 	 * the incremented skip_work, so wait for it to complete to prevent its
 	 * work item from being queued up after the cancel_work_sync() below.
 	 */
-	gov_clear_update_util(shared->policy);
-	wait_for_completion(&shared->irq_work_done);
-	cancel_work_sync(&shared->work);
-	atomic_set(&shared->skip_work, 0);
+	gov_clear_update_util(policy_dbs->policy);
+	wait_for_completion(&policy_dbs->irq_work_done);
+	cancel_work_sync(&policy_dbs->work);
+	atomic_set(&policy_dbs->skip_work, 0);
 }
 EXPORT_SYMBOL_GPL(gov_cancel_work);
 
 static void dbs_work_handler(struct work_struct *work)
 {
-	struct cpu_common_dbs_info *shared = container_of(work, struct
-					cpu_common_dbs_info, work);
+	struct policy_dbs_info *policy_dbs;
 	struct cpufreq_policy *policy;
 	struct dbs_governor *gov;
 	unsigned int delay;
 
-	policy = shared->policy;
+	policy_dbs = container_of(work, struct policy_dbs_info, work);
+	policy = policy_dbs->policy;
 	gov = dbs_governor_of(policy);
 
 	/*
@@ -224,11 +224,11 @@ static void dbs_work_handler(struct work
 	 * ondemand governor isn't reading the time stamp and sampling rate in
 	 * parallel.
 	 */
-	mutex_lock(&shared->timer_mutex);
+	mutex_lock(&policy_dbs->timer_mutex);
 	delay = gov->gov_dbs_timer(policy);
-	shared->sample_delay_ns = jiffies_to_nsecs(delay);
-	shared->time_stamp = ktime_get();
-	mutex_unlock(&shared->timer_mutex);
+	policy_dbs->sample_delay_ns = jiffies_to_nsecs(delay);
+	policy_dbs->time_stamp = ktime_get();
+	mutex_unlock(&policy_dbs->timer_mutex);
 
 	/*
 	 * If the atomic operation below is reordered with respect to the
@@ -236,23 +236,23 @@ static void dbs_work_handler(struct work
 	 * up using a stale sample delay value.
 	 */
 	smp_mb__before_atomic();
-	atomic_dec(&shared->skip_work);
+	atomic_dec(&policy_dbs->skip_work);
 }
 
 static void dbs_irq_work(struct irq_work *irq_work)
 {
-	struct cpu_common_dbs_info *shared;
+	struct policy_dbs_info *policy_dbs;
 
-	shared = container_of(irq_work, struct cpu_common_dbs_info, irq_work);
-	schedule_work(&shared->work);
-	complete(&shared->irq_work_done);
+	policy_dbs = container_of(irq_work, struct policy_dbs_info, irq_work);
+	schedule_work(&policy_dbs->work);
+	complete(&policy_dbs->irq_work_done);
 }
 
 static void dbs_update_util_handler(struct update_util_data *data, u64 time,
 				    unsigned long util, unsigned long max)
 {
 	struct cpu_dbs_info *cdbs = container_of(data, struct cpu_dbs_info, update_util);
-	struct cpu_common_dbs_info *shared = cdbs->shared;
+	struct policy_dbs_info *policy_dbs = cdbs->shared;
 
 	/*
 	 * The work may not be allowed to be queued up right now.
@@ -261,18 +261,18 @@ static void dbs_update_util_handler(stru
 	 * - The governor is being stopped.
 	 * - It is too early (too little time from the previous sample).
 	 */
-	if (atomic_inc_return(&shared->skip_work) == 1) {
+	if (atomic_inc_return(&policy_dbs->skip_work) == 1) {
 		u64 delta_ns;
 
-		delta_ns = time - shared->last_sample_time;
-		if ((s64)delta_ns >= shared->sample_delay_ns) {
-			shared->last_sample_time = time;
-			reinit_completion(&shared->irq_work_done);
-			irq_work_queue_on(&shared->irq_work, smp_processor_id());
+		delta_ns = time - policy_dbs->last_sample_time;
+		if ((s64)delta_ns >= policy_dbs->sample_delay_ns) {
+			policy_dbs->last_sample_time = time;
+			reinit_completion(&policy_dbs->irq_work_done);
+			irq_work_queue_on(&policy_dbs->irq_work, smp_processor_id());
 			return;
 		}
 	}
-	atomic_dec(&shared->skip_work);
+	atomic_dec(&policy_dbs->skip_work);
 }
 
 static void set_sampling_rate(struct dbs_data *dbs_data,
@@ -288,40 +288,40 @@ static void set_sampling_rate(struct dbs
 	}
 }
 
-static int alloc_common_dbs_info(struct cpufreq_policy *policy,
+static int alloc_policy_dbs_info(struct cpufreq_policy *policy,
 				 struct dbs_governor *gov)
 {
-	struct cpu_common_dbs_info *shared;
+	struct policy_dbs_info *policy_dbs;
 	int j;
 
 	/* Allocate memory for the common information for policy->cpus */
-	shared = kzalloc(sizeof(*shared), GFP_KERNEL);
-	if (!shared)
+	policy_dbs = kzalloc(sizeof(*policy_dbs), GFP_KERNEL);
+	if (!policy_dbs)
 		return -ENOMEM;
 
-	/* Set shared for all CPUs, online+offline */
+	/* Set policy_dbs for all CPUs, online+offline */
 	for_each_cpu(j, policy->related_cpus)
-		gov->get_cpu_cdbs(j)->shared = shared;
+		gov->get_cpu_cdbs(j)->shared = policy_dbs;
 
-	mutex_init(&shared->timer_mutex);
-	atomic_set(&shared->skip_work, 0);
-	INIT_WORK(&shared->work, dbs_work_handler);
+	mutex_init(&policy_dbs->timer_mutex);
+	atomic_set(&policy_dbs->skip_work, 0);
+	INIT_WORK(&policy_dbs->work, dbs_work_handler);
 	return 0;
 }
 
-static void free_common_dbs_info(struct cpufreq_policy *policy,
+static void free_policy_dbs_info(struct cpufreq_policy *policy,
 				 struct dbs_governor *gov)
 {
 	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
-	struct cpu_common_dbs_info *shared = cdbs->shared;
+	struct policy_dbs_info *policy_dbs = cdbs->shared;
 	int j;
 
-	mutex_destroy(&shared->timer_mutex);
+	mutex_destroy(&policy_dbs->timer_mutex);
 
 	for_each_cpu(j, policy->cpus)
 		gov->get_cpu_cdbs(j)->shared = NULL;
 
-	kfree(shared);
+	kfree(policy_dbs);
 }
 
 static int cpufreq_governor_init(struct cpufreq_policy *policy)
@@ -339,7 +339,7 @@ static int cpufreq_governor_init(struct
 		if (WARN_ON(have_governor_per_policy()))
 			return -EINVAL;
 
-		ret = alloc_common_dbs_info(policy, gov);
+		ret = alloc_policy_dbs_info(policy, gov);
 		if (ret)
 			return ret;
 
@@ -352,7 +352,7 @@ static int cpufreq_governor_init(struct
 	if (!dbs_data)
 		return -ENOMEM;
 
-	ret = alloc_common_dbs_info(policy, gov);
+	ret = alloc_policy_dbs_info(policy, gov);
 	if (ret)
 		goto free_dbs_data;
 
@@ -360,7 +360,7 @@ static int cpufreq_governor_init(struct
 
 	ret = gov->init(dbs_data, !policy->governor->initialized);
 	if (ret)
-		goto free_common_dbs_info;
+		goto free_policy_dbs_info;
 
 	/* policy latency is in ns. Convert it to us first */
 	latency = policy->cpuinfo.transition_latency / 1000;
@@ -391,8 +391,8 @@ reset_gdbs_data:
 	if (!have_governor_per_policy())
 		gov->gdbs_data = NULL;
 	gov->exit(dbs_data, !policy->governor->initialized);
-free_common_dbs_info:
-	free_common_dbs_info(policy, gov);
+free_policy_dbs_info:
+	free_policy_dbs_info(policy, gov);
 free_dbs_data:
 	kfree(dbs_data);
 	return ret;
@@ -423,7 +423,7 @@ static int cpufreq_governor_exit(struct
 		policy->governor_data = NULL;
 	}
 
-	free_common_dbs_info(policy, gov);
+	free_policy_dbs_info(policy, gov);
 	return 0;
 }
 
@@ -433,14 +433,14 @@ static int cpufreq_governor_start(struct
 	struct dbs_data *dbs_data = policy->governor_data;
 	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
-	struct cpu_common_dbs_info *shared = cdbs->shared;
+	struct policy_dbs_info *policy_dbs = cdbs->shared;
 	int io_busy = 0;
 
 	if (!policy->cur)
 		return -EINVAL;
 
 	/* State should be equivalent to INIT */
-	if (!shared || shared->policy)
+	if (!policy_dbs || policy_dbs->policy)
 		return -EBUSY;
 
 	if (gov->governor == GOV_CONSERVATIVE) {
@@ -473,9 +473,9 @@ static int cpufreq_governor_start(struct
 
 		j_cdbs->update_util.func = dbs_update_util_handler;
 	}
-	shared->policy = policy;
-	init_irq_work(&shared->irq_work, dbs_irq_work);
-	init_completion(&shared->irq_work_done);
+	policy_dbs->policy = policy;
+	init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
+	init_completion(&policy_dbs->irq_work_done);
 
 	if (gov->governor == GOV_CONSERVATIVE) {
 		struct cs_cpu_dbs_info_s *cs_dbs_info =
@@ -492,7 +492,7 @@ static int cpufreq_governor_start(struct
 		od_ops->powersave_bias_init_cpu(cpu);
 	}
 
-	gov_set_update_util(shared, sampling_rate);
+	gov_set_update_util(policy_dbs, sampling_rate);
 	return 0;
 }
 
@@ -500,14 +500,14 @@ static int cpufreq_governor_stop(struct
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
-	struct cpu_common_dbs_info *shared = cdbs->shared;
+	struct policy_dbs_info *policy_dbs = cdbs->shared;
 
 	/* State should be equivalent to START */
-	if (!shared || !shared->policy)
+	if (!policy_dbs || !policy_dbs->policy)
 		return -EBUSY;
 
-	gov_cancel_work(shared);
-	shared->policy = NULL;
+	gov_cancel_work(policy_dbs);
+	policy_dbs->policy = NULL;
 
 	return 0;
 }
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -255,21 +255,21 @@ static void update_sampling_rate(struct
 		struct cpufreq_policy *policy;
 		struct od_cpu_dbs_info_s *dbs_info;
 		struct cpu_dbs_info *cdbs;
-		struct cpu_common_dbs_info *shared;
+		struct policy_dbs_info *policy_dbs;
 		ktime_t next_sampling, appointed_at;
 
 		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
 		cdbs = &dbs_info->cdbs;
-		shared = cdbs->shared;
+		policy_dbs = cdbs->shared;
 
 		/*
-		 * A valid shared and shared->policy means governor hasn't
-		 * stopped or exited yet.
+		 * A valid policy_dbs and policy_dbs->policy means governor
+		 * hasn't stopped or exited yet.
 		 */
-		if (!shared || !shared->policy)
+		if (!policy_dbs || !policy_dbs->policy)
 			continue;
 
-		policy = shared->policy;
+		policy = policy_dbs->policy;
 
 		/* clear all CPUs of this policy */
 		cpumask_andnot(&cpumask, &cpumask, policy->cpus);
@@ -289,14 +289,14 @@ static void update_sampling_rate(struct
 		 */
 		next_sampling = ktime_add_us(ktime_get(), new_rate);
 
-		mutex_lock(&shared->timer_mutex);
-		appointed_at = ktime_add_ns(shared->time_stamp,
-					    shared->sample_delay_ns);
-		mutex_unlock(&shared->timer_mutex);
+		mutex_lock(&policy_dbs->timer_mutex);
+		appointed_at = ktime_add_ns(policy_dbs->time_stamp,
+					    policy_dbs->sample_delay_ns);
+		mutex_unlock(&policy_dbs->timer_mutex);
 
 		if (ktime_before(next_sampling, appointed_at)) {
-			gov_cancel_work(shared);
-			gov_set_update_util(shared, new_rate);
+			gov_cancel_work(policy_dbs);
+			gov_set_update_util(policy_dbs, new_rate);
 		}
 	}
 
@@ -569,16 +569,16 @@ static void od_set_powersave_bias(unsign
 
 	get_online_cpus();
 	for_each_online_cpu(cpu) {
-		struct cpu_common_dbs_info *shared;
+		struct policy_dbs_info *policy_dbs;
 
 		if (cpumask_test_cpu(cpu, &done))
 			continue;
 
-		shared = per_cpu(od_cpu_dbs_info, cpu).cdbs.shared;
-		if (!shared)
+		policy_dbs = per_cpu(od_cpu_dbs_info, cpu).cdbs.shared;
+		if (!policy_dbs)
 			continue;
 
-		policy = shared->policy;
+		policy = policy_dbs->policy;
 		cpumask_or(&done, &done, policy->cpus);
 
 		if (policy->governor != CPU_FREQ_GOV_ONDEMAND)
