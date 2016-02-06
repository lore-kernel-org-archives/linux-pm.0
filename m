From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 8/10] cpufreq: governor: Rename cpu_common_dbs_info to policy_dbs_info
Date: Sat, 06 Feb 2016 13:48:19 +0100
Message-ID: <20213140.Qi3up6pdV4@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <9008098.QDD8C89zDx@vostro.rjw.lan> <2973464.jyrWv0qA55@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61624 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752055AbcBFMrN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 6 Feb 2016 07:47:13 -0500
In-Reply-To: <2973464.jyrWv0qA55@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: governor: Rename cpu_common_dbs_info to policy_dbs_info

The struct cpu_common_dbs_info structure represents the per-policy
part of the governor data (for the ondemand and conservative
governors), but its name doesn't reflect its purpose.

Rename it to struct policy_dbs_info and rename variables related to
it accordingly.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes from v2:
- Rebase on top of https://patchwork.kernel.org/patch/8241231/
- Change all struct cpu_common_dbs_info pointers to be called policy_dbs.

---
 drivers/cpufreq/cpufreq_conservative.c |    2 
 drivers/cpufreq/cpufreq_governor.c     |  134 ++++++++++++++++-----------------
 drivers/cpufreq/cpufreq_governor.h     |    8 -
 drivers/cpufreq/cpufreq_ondemand.c     |   28 +++---
 4 files changed, 86 insertions(+), 86 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -131,7 +131,7 @@ static void *get_cpu_dbs_info_s(int cpu)
  */
 
 /* Common to all CPUs of a policy */
-struct cpu_common_dbs_info {
+struct policy_dbs_info {
 	struct cpufreq_policy *policy;
 	/*
 	 * Per policy mutex that serializes load evaluation from limit-change
@@ -146,10 +146,10 @@ struct cpu_common_dbs_info {
 	struct work_struct work;
 };
 
-static inline void gov_update_sample_delay(struct cpu_common_dbs_info *shared,
+static inline void gov_update_sample_delay(struct policy_dbs_info *policy_dbs,
 					   unsigned int delay_us)
 {
-	shared->sample_delay_ns = delay_us * NSEC_PER_USEC;
+	policy_dbs->sample_delay_ns = delay_us * NSEC_PER_USEC;
 }
 
 /* Per cpu structures */
@@ -165,7 +165,7 @@ struct cpu_dbs_info {
 	 */
 	unsigned int prev_load;
 	struct update_util_data update_util;
-	struct cpu_common_dbs_info *shared;
+	struct policy_dbs_info *policy_dbs;
 };
 
 struct od_cpu_dbs_info_s {
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -163,15 +163,15 @@ void dbs_check_cpu(struct cpufreq_policy
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
 
-	gov_update_sample_delay(shared, delay_us);
-	shared->last_sample_time = 0;
+	gov_update_sample_delay(policy_dbs, delay_us);
+	policy_dbs->last_sample_time = 0;
 
 	for_each_cpu(cpu, policy->cpus) {
 		struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
@@ -191,40 +191,40 @@ static inline void gov_clear_update_util
 	synchronize_rcu();
 }
 
-static void gov_cancel_work(struct cpu_common_dbs_info *shared)
+static void gov_cancel_work(struct policy_dbs_info *policy_dbs)
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
-	irq_work_sync(&shared->irq_work);
-	cancel_work_sync(&shared->work);
-	atomic_set(&shared->skip_work, 0);
+	gov_clear_update_util(policy_dbs->policy);
+	irq_work_sync(&policy_dbs->irq_work);
+	cancel_work_sync(&policy_dbs->work);
+	atomic_set(&policy_dbs->skip_work, 0);
 }
 
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
 	 * Make sure cpufreq_governor_limits() isn't evaluating load or the
 	 * ondemand governor isn't updating the sampling rate in parallel.
 	 */
-	mutex_lock(&shared->timer_mutex);
+	mutex_lock(&policy_dbs->timer_mutex);
 	delay = gov->gov_dbs_timer(policy);
-	shared->sample_delay_ns = jiffies_to_nsecs(delay);
-	mutex_unlock(&shared->timer_mutex);
+	policy_dbs->sample_delay_ns = jiffies_to_nsecs(delay);
+	mutex_unlock(&policy_dbs->timer_mutex);
 
 	/*
 	 * If the atomic operation below is reordered with respect to the
@@ -232,30 +232,30 @@ static void dbs_work_handler(struct work
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
+	policy_dbs = container_of(irq_work, struct policy_dbs_info, irq_work);
+	schedule_work(&policy_dbs->work);
 }
 
-static inline void gov_queue_irq_work(struct cpu_common_dbs_info *shared)
+static inline void gov_queue_irq_work(struct policy_dbs_info *policy_dbs)
 {
 	if (IS_ENABLED(CONFIG_SMP))
-		irq_work_queue_on(&shared->irq_work, smp_processor_id());
+		irq_work_queue_on(&policy_dbs->irq_work, smp_processor_id());
 	else
-		irq_work_queue(&shared->irq_work);
+		irq_work_queue(&policy_dbs->irq_work);
 }
 
 static void dbs_update_util_handler(struct update_util_data *data, u64 time,
 				    unsigned long util, unsigned long max)
 {
 	struct cpu_dbs_info *cdbs = container_of(data, struct cpu_dbs_info, update_util);
-	struct cpu_common_dbs_info *shared = cdbs->shared;
+	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
 
 	/*
 	 * The work may not be allowed to be queued up right now.
@@ -264,17 +264,17 @@ static void dbs_update_util_handler(stru
 	 * - The governor is being stopped.
 	 * - It is too early (too little time from the previous sample).
 	 */
-	if (atomic_inc_return(&shared->skip_work) == 1) {
+	if (atomic_inc_return(&policy_dbs->skip_work) == 1) {
 		u64 delta_ns;
 
-		delta_ns = time - shared->last_sample_time;
-		if ((s64)delta_ns >= shared->sample_delay_ns) {
-			shared->last_sample_time = time;
-			gov_queue_irq_work(shared);
+		delta_ns = time - policy_dbs->last_sample_time;
+		if ((s64)delta_ns >= policy_dbs->sample_delay_ns) {
+			policy_dbs->last_sample_time = time;
+			gov_queue_irq_work(policy_dbs);
 			return;
 		}
 	}
-	atomic_dec(&shared->skip_work);
+	atomic_dec(&policy_dbs->skip_work);
 }
 
 static void set_sampling_rate(struct dbs_data *dbs_data,
@@ -290,40 +290,40 @@ static void set_sampling_rate(struct dbs
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
+		gov->get_cpu_cdbs(j)->policy_dbs = policy_dbs;
 
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
+	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
 	int j;
 
-	mutex_destroy(&shared->timer_mutex);
+	mutex_destroy(&policy_dbs->timer_mutex);
 
 	for_each_cpu(j, policy->cpus)
-		gov->get_cpu_cdbs(j)->shared = NULL;
+		gov->get_cpu_cdbs(j)->policy_dbs = NULL;
 
-	kfree(shared);
+	kfree(policy_dbs);
 }
 
 static int cpufreq_governor_init(struct cpufreq_policy *policy)
@@ -341,7 +341,7 @@ static int cpufreq_governor_init(struct
 		if (WARN_ON(have_governor_per_policy()))
 			return -EINVAL;
 
-		ret = alloc_common_dbs_info(policy, gov);
+		ret = alloc_policy_dbs_info(policy, gov);
 		if (ret)
 			return ret;
 
@@ -354,7 +354,7 @@ static int cpufreq_governor_init(struct
 	if (!dbs_data)
 		return -ENOMEM;
 
-	ret = alloc_common_dbs_info(policy, gov);
+	ret = alloc_policy_dbs_info(policy, gov);
 	if (ret)
 		goto free_dbs_data;
 
@@ -362,7 +362,7 @@ static int cpufreq_governor_init(struct
 
 	ret = gov->init(dbs_data, !policy->governor->initialized);
 	if (ret)
-		goto free_common_dbs_info;
+		goto free_policy_dbs_info;
 
 	/* policy latency is in ns. Convert it to us first */
 	latency = policy->cpuinfo.transition_latency / 1000;
@@ -393,8 +393,8 @@ reset_gdbs_data:
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
@@ -407,7 +407,7 @@ static int cpufreq_governor_exit(struct
 	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
 
 	/* State should be equivalent to INIT */
-	if (!cdbs->shared || cdbs->shared->policy)
+	if (!cdbs->policy_dbs || cdbs->policy_dbs->policy)
 		return -EBUSY;
 
 	if (!--dbs_data->usage_count) {
@@ -425,7 +425,7 @@ static int cpufreq_governor_exit(struct
 		policy->governor_data = NULL;
 	}
 
-	free_common_dbs_info(policy, gov);
+	free_policy_dbs_info(policy, gov);
 	return 0;
 }
 
@@ -435,14 +435,14 @@ static int cpufreq_governor_start(struct
 	struct dbs_data *dbs_data = policy->governor_data;
 	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
-	struct cpu_common_dbs_info *shared = cdbs->shared;
+	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
 	int io_busy = 0;
 
 	if (!policy->cur)
 		return -EINVAL;
 
 	/* State should be equivalent to INIT */
-	if (!shared || shared->policy)
+	if (!policy_dbs || policy_dbs->policy)
 		return -EBUSY;
 
 	if (gov->governor == GOV_CONSERVATIVE) {
@@ -475,8 +475,8 @@ static int cpufreq_governor_start(struct
 
 		j_cdbs->update_util.func = dbs_update_util_handler;
 	}
-	shared->policy = policy;
-	init_irq_work(&shared->irq_work, dbs_irq_work);
+	policy_dbs->policy = policy;
+	init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
 
 	if (gov->governor == GOV_CONSERVATIVE) {
 		struct cs_cpu_dbs_info_s *cs_dbs_info =
@@ -493,7 +493,7 @@ static int cpufreq_governor_start(struct
 		od_ops->powersave_bias_init_cpu(cpu);
 	}
 
-	gov_set_update_util(shared, sampling_rate);
+	gov_set_update_util(policy_dbs, sampling_rate);
 	return 0;
 }
 
@@ -501,14 +501,14 @@ static int cpufreq_governor_stop(struct
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
-	struct cpu_common_dbs_info *shared = cdbs->shared;
+	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
 
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
@@ -520,18 +520,18 @@ static int cpufreq_governor_limits(struc
 	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
 
 	/* State should be equivalent to START */
-	if (!cdbs->shared || !cdbs->shared->policy)
+	if (!cdbs->policy_dbs || !cdbs->policy_dbs->policy)
 		return -EBUSY;
 
-	mutex_lock(&cdbs->shared->timer_mutex);
-	if (policy->max < cdbs->shared->policy->cur)
-		__cpufreq_driver_target(cdbs->shared->policy, policy->max,
+	mutex_lock(&cdbs->policy_dbs->timer_mutex);
+	if (policy->max < cdbs->policy_dbs->policy->cur)
+		__cpufreq_driver_target(cdbs->policy_dbs->policy, policy->max,
 					CPUFREQ_RELATION_H);
-	else if (policy->min > cdbs->shared->policy->cur)
-		__cpufreq_driver_target(cdbs->shared->policy, policy->min,
+	else if (policy->min > cdbs->policy_dbs->policy->cur)
+		__cpufreq_driver_target(cdbs->policy_dbs->policy, policy->min,
 					CPUFREQ_RELATION_L);
 	dbs_check_cpu(policy, cpu);
-	mutex_unlock(&cdbs->shared->timer_mutex);
+	mutex_unlock(&cdbs->policy_dbs->timer_mutex);
 
 	return 0;
 }
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -151,7 +151,7 @@ static void dbs_freq_increase(struct cpu
 static void od_check_cpu(int cpu, unsigned int load)
 {
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
-	struct cpufreq_policy *policy = dbs_info->cdbs.shared->policy;
+	struct cpufreq_policy *policy = dbs_info->cdbs.policy_dbs->policy;
 	struct dbs_data *dbs_data = policy->governor_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 
@@ -255,20 +255,20 @@ static void update_sampling_rate(struct
 		struct cpufreq_policy *policy;
 		struct od_cpu_dbs_info_s *dbs_info;
 		struct cpu_dbs_info *cdbs;
-		struct cpu_common_dbs_info *shared;
+		struct policy_dbs_info *policy_dbs;
 
 		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
 		cdbs = &dbs_info->cdbs;
-		shared = cdbs->shared;
+		policy_dbs = cdbs->policy_dbs;
 
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
@@ -280,7 +280,7 @@ static void update_sampling_rate(struct
 		 * multiple policies that are governed by the same dbs_data.
 		 */
 		if (dbs_data == policy->governor_data) {
-			mutex_lock(&shared->timer_mutex);
+			mutex_lock(&policy_dbs->timer_mutex);
 			/*
 			 * On 32-bit architectures this may race with the
 			 * sample_delay_ns read in dbs_update_util_handler(),
@@ -299,8 +299,8 @@ static void update_sampling_rate(struct
 			 * too big and it will be corrected next time a sample
 			 * is taken, so it shouldn't be significant.
 			 */
-			gov_update_sample_delay(shared, new_rate);
-			mutex_unlock(&shared->timer_mutex);
+			gov_update_sample_delay(policy_dbs, new_rate);
+			mutex_unlock(&policy_dbs->timer_mutex);
 		}
 	}
 
@@ -573,16 +573,16 @@ static void od_set_powersave_bias(unsign
 
 	get_online_cpus();
 	for_each_online_cpu(cpu) {
-		struct cpu_common_dbs_info *shared;
+		struct policy_dbs_info *policy_dbs;
 
 		if (cpumask_test_cpu(cpu, &done))
 			continue;
 
-		shared = per_cpu(od_cpu_dbs_info, cpu).cdbs.shared;
-		if (!shared)
+		policy_dbs = per_cpu(od_cpu_dbs_info, cpu).cdbs.policy_dbs;
+		if (!policy_dbs)
 			continue;
 
-		policy = shared->policy;
+		policy = policy_dbs->policy;
 		cpumask_or(&done, &done, policy->cpus);
 
 		if (policy->governor != CPU_FREQ_GOV_ONDEMAND)
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -47,7 +47,7 @@ static inline unsigned int get_freq_targ
 static void cs_check_cpu(int cpu, unsigned int load)
 {
 	struct cs_cpu_dbs_info_s *dbs_info = &per_cpu(cs_cpu_dbs_info, cpu);
-	struct cpufreq_policy *policy = dbs_info->cdbs.shared->policy;
+	struct cpufreq_policy *policy = dbs_info->cdbs.policy_dbs->policy;
 	struct dbs_data *dbs_data = policy->governor_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 

