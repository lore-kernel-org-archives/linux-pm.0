From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 10/11] cpufreq: governor: Rearrange governor data structures
Date: Thu, 04 Feb 2016 00:37:05 +0100
Message-ID: <1554644.vv46j7J68E@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3705929.bslqXH980s@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The struct policy_dbs_info objects representing per-policy governor
data are not accessible directly from the corresponding policy
objects.  To access them, one has to get a pointer to the
struct cpu_dbs_info of policy->cpu and use the "shared" field of
that which isn't really straightforward.

To address that rearrange the governor data structures so the
governor_data pointer in struct cpufreq_policy will point to
struct policy_dbs_info and that will contain a pointer to
struct dbs_data.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/amd_freq_sensitivity.c |    3 
 drivers/cpufreq/cpufreq_conservative.c |    6 +
 drivers/cpufreq/cpufreq_governor.c     |  116 ++++++++++++++-------------------
 drivers/cpufreq/cpufreq_governor.h     |   27 ++++---
 drivers/cpufreq/cpufreq_ondemand.c     |   18 +++--
 5 files changed, 83 insertions(+), 87 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -85,7 +85,8 @@ static ssize_t show_##file_name##_gov_sy
 static ssize_t show_##file_name##_gov_pol				\
 (struct cpufreq_policy *policy, char *buf)				\
 {									\
-	struct dbs_data *dbs_data = policy->governor_data;		\
+	struct policy_dbs_info *policy_dbs = policy->governor_data;	\
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;		\
 	struct _gov##_dbs_tuners *tuners = dbs_data->tuners;		\
 	return sprintf(buf, "%u\n", tuners->file_name);			\
 }
@@ -101,8 +102,8 @@ static ssize_t store_##file_name##_gov_s
 static ssize_t store_##file_name##_gov_pol				\
 (struct cpufreq_policy *policy, const char *buf, size_t count)		\
 {									\
-	struct dbs_data *dbs_data = policy->governor_data;		\
-	return store_##file_name(dbs_data, buf, count);			\
+	struct policy_dbs_info *policy_dbs = policy->governor_data;	\
+	return store_##file_name(policy_dbs->dbs_data, buf, count);			\
 }
 
 #define show_store_one(_gov, file_name)					\
@@ -130,6 +131,13 @@ static void *get_cpu_dbs_info_s(int cpu)
  * cs_*: Conservative governor
  */
 
+/* Governor demand based switching data (per-policy or global). */
+struct dbs_data {
+	unsigned int min_sampling_rate;
+	int usage_count;
+	void *tuners;
+};
+
 /* Common to all CPUs of a policy */
 struct policy_dbs_info {
 	struct cpufreq_policy *policy;
@@ -144,6 +152,8 @@ struct policy_dbs_info {
 	atomic_t skip_work;
 	struct irq_work irq_work;
 	struct work_struct work;
+	/* dbs_data may be shared between multiple policy objects */
+	struct dbs_data *dbs_data;
 };
 
 /* Per cpu structures */
@@ -199,7 +209,6 @@ struct cs_dbs_tuners {
 };
 
 /* Common Governor data across policies */
-struct dbs_data;
 struct dbs_governor {
 	struct cpufreq_governor gov;
 
@@ -225,13 +234,6 @@ static inline struct dbs_governor *dbs_g
 	return container_of(policy->governor, struct dbs_governor, gov);
 }
 
-/* Governor Per policy data */
-struct dbs_data {
-	unsigned int min_sampling_rate;
-	int usage_count;
-	void *tuners;
-};
-
 /*
  * Common governor data for platforms without CPUFREQ_HAVE_GOVERNOR_PER_POLICY.
  */
@@ -267,7 +269,8 @@ static ssize_t show_sampling_rate_min_go
 static ssize_t show_sampling_rate_min_gov_pol				\
 (struct cpufreq_policy *policy, char *buf)				\
 {									\
-	struct dbs_data *dbs_data = policy->governor_data;		\
+	struct policy_dbs_info *policy_dbs = policy->governor_data;	\
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;		\
 	return sprintf(buf, "%u\n", dbs_data->min_sampling_rate);	\
 }
 
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -37,8 +37,8 @@ static struct attribute_group *get_sysfs
 void dbs_check_cpu(struct cpufreq_policy *policy, int cpu)
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
-	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int sampling_rate;
@@ -97,6 +97,7 @@ void dbs_check_cpu(struct cpufreq_policy
 		j_cdbs->prev_cpu_idle = cur_idle_time;
 
 		if (ignore_nice) {
+			struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
 			u64 cur_nice;
 			unsigned long cur_nice_jiffies;
 
@@ -220,8 +221,8 @@ static void dbs_work_handler(struct work
 
 	policy_dbs = container_of(work, struct policy_dbs_info, work);
 	policy = policy_dbs->policy;
-	dbs_data = policy->governor_data;
 	gov = dbs_governor_of(policy);
+	dbs_data = policy_dbs->dbs_data;
 
 	if (gov->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
@@ -295,8 +296,8 @@ static void set_sampling_rate(struct dbs
 	}
 }
 
-static int alloc_policy_dbs_info(struct cpufreq_policy *policy,
-				 struct dbs_governor *gov)
+static struct policy_dbs_info *alloc_policy_dbs_info(struct cpufreq_policy *policy,
+						     struct dbs_governor *gov)
 {
 	struct policy_dbs_info *policy_dbs;
 	int j;
@@ -304,16 +305,21 @@ static int alloc_policy_dbs_info(struct
 	/* Allocate memory for the common information for policy->cpus */
 	policy_dbs = kzalloc(sizeof(*policy_dbs), GFP_KERNEL);
 	if (!policy_dbs)
-		return -ENOMEM;
+		return NULL;
 
 	/* Set policy_dbs for all CPUs, online+offline */
-	for_each_cpu(j, policy->related_cpus)
-		gov->get_cpu_cdbs(j)->shared = policy_dbs;
+	for_each_cpu(j, policy->related_cpus) {
+		struct cpu_dbs_info *j_cdbs = gov->get_cpu_cdbs(j);
 
+		j_cdbs->shared = policy_dbs;
+		j_cdbs->update_util.func = dbs_update_util_handler;
+	}
+	policy_dbs->policy = policy;
 	mutex_init(&policy_dbs->timer_mutex);
 	atomic_set(&policy_dbs->skip_work, 0);
+	init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
 	INIT_WORK(&policy_dbs->work, dbs_work_handler);
-	return 0;
+	return policy_dbs;
 }
 
 static void free_policy_dbs_info(struct cpufreq_policy *policy,
@@ -334,6 +340,7 @@ static void free_policy_dbs_info(struct
 static int cpufreq_governor_init(struct cpufreq_policy *policy)
 {
 	struct dbs_governor *gov;
+	struct policy_dbs_info *policy_dbs;
 	struct dbs_data *dbs_data;
 	unsigned int latency;
 	int ret;
@@ -343,26 +350,26 @@ static int cpufreq_governor_init(struct
 		return -EBUSY;
 
 	gov = dbs_governor_of(policy);
-	if (global_dbs_data) {
-		if (WARN_ON(have_governor_per_policy()))
-			return -EINVAL;
-
-		ret = alloc_policy_dbs_info(policy, gov);
-		if (ret)
-			return ret;
+	policy_dbs = alloc_policy_dbs_info(policy, gov);
+	if (!policy_dbs)
+		return -ENOMEM;
 
+	if (global_dbs_data) {
+		if (WARN_ON(have_governor_per_policy())) {
+			ret = -EINVAL;
+			goto free_policy_dbs_info;
+		}
 		global_dbs_data->usage_count++;
-		policy->governor_data = global_dbs_data;
+		policy_dbs->dbs_data = global_dbs_data;
+		policy->governor_data = policy_dbs;
 		return 0;
 	}
 
 	dbs_data = kzalloc(sizeof(*dbs_data), GFP_KERNEL);
-	if (!dbs_data)
-		return -ENOMEM;
-
-	ret = alloc_policy_dbs_info(policy, gov);
-	if (ret)
-		goto free_dbs_data;
+	if (!dbs_data) {
+		ret = -ENOMEM;
+		goto free_policy_dbs_info;
+	}
 
 	dbs_data->usage_count = 1;
 
@@ -384,7 +391,8 @@ static int cpufreq_governor_init(struct
 	if (!have_governor_per_policy())
 		global_dbs_data = dbs_data;
 
-	policy->governor_data = dbs_data;
+	policy_dbs->dbs_data = dbs_data;
+	policy->governor_data = policy_dbs;
 
 	ret = sysfs_create_group(get_governor_parent_kobj(policy),
 				 get_sysfs_attr(gov));
@@ -396,38 +404,35 @@ static int cpufreq_governor_init(struct
 		global_dbs_data = NULL;
 
 	gov->exit(dbs_data, !policy->governor->initialized);
+	kfree(dbs_data);
+
 free_policy_dbs_info:
 	free_policy_dbs_info(policy, gov);
-free_dbs_data:
-	kfree(dbs_data);
 	return ret;
 }
 
 static int cpufreq_governor_exit(struct cpufreq_policy *policy)
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
-	struct dbs_data *dbs_data = policy->governor_data;
-	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 
 	/* State should be equivalent to INIT */
-	if (!cdbs->shared || cdbs->shared->policy)
+	if (!dbs_data)
 		return -EBUSY;
 
 	if (!--dbs_data->usage_count) {
 		sysfs_remove_group(get_governor_parent_kobj(policy),
 				   get_sysfs_attr(gov));
 
-		policy->governor_data = NULL;
-
 		if (!have_governor_per_policy())
 			global_dbs_data = NULL;
 
 		gov->exit(dbs_data, policy->governor->initialized == 1);
 		kfree(dbs_data);
-	} else {
-		policy->governor_data = NULL;
 	}
 
+	policy->governor_data = NULL;
 	free_policy_dbs_info(policy, gov);
 	return 0;
 }
@@ -435,17 +440,16 @@ static int cpufreq_governor_exit(struct
 static int cpufreq_governor_start(struct cpufreq_policy *policy)
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
-	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
-	struct policy_dbs_info *policy_dbs = cdbs->shared;
 	int io_busy = 0;
 
 	if (!policy->cur)
 		return -EINVAL;
 
 	/* State should be equivalent to INIT */
-	if (!policy_dbs || policy_dbs->policy)
+	if (!dbs_data)
 		return -EBUSY;
 
 	if (gov->governor == GOV_CONSERVATIVE) {
@@ -475,11 +479,7 @@ static int cpufreq_governor_start(struct
 
 		if (ignore_nice)
 			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
-
-		j_cdbs->update_util.func = dbs_update_util_handler;
 	}
-	policy_dbs->policy = policy;
-	init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
 
 	if (gov->governor == GOV_CONSERVATIVE) {
 		struct cs_cpu_dbs_info_s *cs_dbs_info =
@@ -502,39 +502,25 @@ static int cpufreq_governor_start(struct
 
 static int cpufreq_governor_stop(struct cpufreq_policy *policy)
 {
-	struct dbs_governor *gov = dbs_governor_of(policy);
-	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
-	struct policy_dbs_info *policy_dbs = cdbs->shared;
-
-	/* State should be equivalent to START */
-	if (!policy_dbs || !policy_dbs->policy)
-		return -EBUSY;
-
-	gov_cancel_work(policy_dbs);
-	policy_dbs->policy = NULL;
-
+	gov_cancel_work(policy->governor_data);
 	return 0;
 }
 
 static int cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
-	struct dbs_governor *gov = dbs_governor_of(policy);
-	unsigned int cpu = policy->cpu;
-	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
 
 	/* State should be equivalent to START */
-	if (!cdbs->shared || !cdbs->shared->policy)
+	if (!policy_dbs->dbs_data)
 		return -EBUSY;
 
-	mutex_lock(&cdbs->shared->timer_mutex);
-	if (policy->max < cdbs->shared->policy->cur)
-		__cpufreq_driver_target(cdbs->shared->policy, policy->max,
-					CPUFREQ_RELATION_H);
-	else if (policy->min > cdbs->shared->policy->cur)
-		__cpufreq_driver_target(cdbs->shared->policy, policy->min,
-					CPUFREQ_RELATION_L);
-	dbs_check_cpu(policy, cpu);
-	mutex_unlock(&cdbs->shared->timer_mutex);
+	mutex_lock(&policy_dbs->timer_mutex);
+	if (policy->max < policy->cur)
+		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
+	else if (policy->min > policy->cur)
+		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
+	dbs_check_cpu(policy, policy->cpu);
+	mutex_unlock(&policy_dbs->timer_mutex);
 
 	return 0;
 }
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -82,7 +82,8 @@ static unsigned int generic_powersave_bi
 	unsigned int jiffies_total, jiffies_hi, jiffies_lo;
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info,
 						   policy->cpu);
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 
 	if (!dbs_info->freq_table) {
@@ -134,7 +135,8 @@ static void ondemand_powersave_bias_init
 
 static void dbs_freq_increase(struct cpufreq_policy *policy, unsigned int freq)
 {
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 
 	if (od_tuners->powersave_bias)
@@ -155,8 +157,9 @@ static void dbs_freq_increase(struct cpu
 static void od_check_cpu(int cpu, unsigned int load)
 {
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
-	struct cpufreq_policy *policy = dbs_info->cdbs.shared->policy;
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct policy_dbs_info *policy_dbs = dbs_info->cdbs.shared;
+	struct cpufreq_policy *policy = policy_dbs->policy;
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 
 	dbs_info->freq_lo = 0;
@@ -193,7 +196,8 @@ static void od_check_cpu(int cpu, unsign
 
 static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
 {
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	unsigned int cpu = policy->cpu;
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info,
 			cpu);
@@ -284,7 +288,7 @@ static void update_sampling_rate(struct
 		 * policy will be governed by dbs_data, otherwise there can be
 		 * multiple policies that are governed by the same dbs_data.
 		 */
-		if (dbs_data != policy->governor_data)
+		if (dbs_data != policy_dbs->dbs_data)
 			continue;
 
 		/*
@@ -588,7 +592,7 @@ static void od_set_powersave_bias(unsign
 		if (policy->governor != CPU_FREQ_GOV_ONDEMAND)
 			continue;
 
-		dbs_data = policy->governor_data;
+		dbs_data = policy_dbs->dbs_data;
 		od_tuners = dbs_data->tuners;
 		od_tuners->powersave_bias = default_powersave_bias;
 	}
Index: linux-pm/drivers/cpufreq/amd_freq_sensitivity.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/amd_freq_sensitivity.c
+++ linux-pm/drivers/cpufreq/amd_freq_sensitivity.c
@@ -45,7 +45,8 @@ static unsigned int amd_powersave_bias_t
 	long d_actual, d_reference;
 	struct msr actual, reference;
 	struct cpu_data_t *data = &per_cpu(cpu_data, policy->cpu);
-	struct dbs_data *od_data = policy->governor_data;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct dbs_data *od_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = od_data->tuners;
 	struct od_cpu_dbs_info_s *od_info =
 		od_data->gov->get_cpu_dbs_info_s(policy->cpu);
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -48,7 +48,8 @@ static void cs_check_cpu(int cpu, unsign
 {
 	struct cs_cpu_dbs_info_s *dbs_info = &per_cpu(cs_cpu_dbs_info, cpu);
 	struct cpufreq_policy *policy = dbs_info->cdbs.shared->policy;
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
 	/*
@@ -104,7 +105,8 @@ static void cs_check_cpu(int cpu, unsign
 
 static unsigned int cs_dbs_timer(struct cpufreq_policy *policy)
 {
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
 	dbs_check_cpu(policy, policy->cpu);
