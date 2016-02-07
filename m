From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3] cpufreq: governor: Rearrange governor data structures
Date: Sun, 07 Feb 2016 16:24:26 +0100
Message-ID: <2710262.Af7Ngczbqf@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <9008098.QDD8C89zDx@vostro.rjw.lan> <2998470.K7oslgfuja@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2998470.K7oslgfuja@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The struct policy_dbs_info objects representing per-policy governor
data are not accessible directly from the corresponding policy
objects.  To access them, one has to get a pointer to the
struct cpu_dbs_info of policy->cpu and use the policy_dbs field of
that which isn't really straightforward.

To address that rearrange the governor data structures so the
governor_data pointer in struct cpufreq_policy will point to
struct policy_dbs_info (instead of struct dbs_data) and that will
contain a pointer to struct dbs_data.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/amd_freq_sensitivity.c |    3 -
 drivers/cpufreq/cpufreq_conservative.c |    6 +-
 drivers/cpufreq/cpufreq_governor.c     |   74 ++++++++++++++++-----------------
 drivers/cpufreq/cpufreq_governor.h     |   27 ++++++------
 drivers/cpufreq/cpufreq_ondemand.c     |   18 ++++----
 5 files changed, 68 insertions(+), 60 deletions(-)

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
 
 static inline void gov_update_sample_delay(struct policy_dbs_info *policy_dbs,
@@ -204,7 +214,6 @@ struct cs_dbs_tuners {
 };
 
 /* Common Governor data across policies */
-struct dbs_data;
 struct dbs_governor {
 	struct cpufreq_governor gov;
 
@@ -236,13 +245,6 @@ static inline struct dbs_governor *dbs_g
 	return container_of(policy->governor, struct dbs_governor, gov);
 }
 
-/* Governor Per policy data */
-struct dbs_data {
-	unsigned int min_sampling_rate;
-	int usage_count;
-	void *tuners;
-};
-
 /* Governor specific ops, will be passed to dbs_data->gov_ops */
 struct od_ops {
 	void (*powersave_bias_init_cpu)(int cpu);
@@ -273,7 +275,8 @@ static ssize_t show_sampling_rate_min_go
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
@@ -35,8 +35,8 @@ void dbs_check_cpu(struct cpufreq_policy
 {
 	int cpu = policy->cpu;
 	struct dbs_governor *gov = dbs_governor_of(policy);
-	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int sampling_rate;
@@ -95,6 +95,7 @@ void dbs_check_cpu(struct cpufreq_policy
 		j_cdbs->prev_cpu_idle = cur_idle_time;
 
 		if (ignore_nice) {
+			struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
 			u64 cur_nice;
 			unsigned long cur_nice_jiffies;
 
@@ -291,8 +292,8 @@ static void set_sampling_rate(struct dbs
 	}
 }
 
-static int alloc_policy_dbs_info(struct cpufreq_policy *policy,
-				 struct dbs_governor *gov)
+static struct policy_dbs_info *alloc_policy_dbs_info(struct cpufreq_policy *policy,
+						     struct dbs_governor *gov)
 {
 	struct policy_dbs_info *policy_dbs;
 	int j;
@@ -300,7 +301,7 @@ static int alloc_policy_dbs_info(struct
 	/* Allocate memory for the common information for policy->cpus */
 	policy_dbs = kzalloc(sizeof(*policy_dbs), GFP_KERNEL);
 	if (!policy_dbs)
-		return -ENOMEM;
+		return NULL;
 
 	/* Set policy_dbs for all CPUs, online+offline */
 	for_each_cpu(j, policy->related_cpus)
@@ -310,7 +311,7 @@ static int alloc_policy_dbs_info(struct
 	atomic_set(&policy_dbs->skip_work, 0);
 	init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
 	INIT_WORK(&policy_dbs->work, dbs_work_handler);
-	return 0;
+	return policy_dbs;
 }
 
 static void free_policy_dbs_info(struct cpufreq_policy *policy,
@@ -332,6 +333,7 @@ static int cpufreq_governor_init(struct
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct dbs_data *dbs_data = gov->gdbs_data;
+	struct policy_dbs_info *policy_dbs;
 	unsigned int latency;
 	int ret;
 
@@ -339,26 +341,26 @@ static int cpufreq_governor_init(struct
 	if (policy->governor_data)
 		return -EBUSY;
 
-	if (dbs_data) {
-		if (WARN_ON(have_governor_per_policy()))
-			return -EINVAL;
-
-		ret = alloc_policy_dbs_info(policy, gov);
-		if (ret)
-			return ret;
+	policy_dbs = alloc_policy_dbs_info(policy, gov);
+	if (!policy_dbs)
+		return -ENOMEM;
 
+	if (dbs_data) {
+		if (WARN_ON(have_governor_per_policy())) {
+			ret = -EINVAL;
+			goto free_policy_dbs_info;
+		}
 		dbs_data->usage_count++;
-		policy->governor_data = dbs_data;
+		policy_dbs->dbs_data = dbs_data;
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
 
@@ -380,7 +382,8 @@ static int cpufreq_governor_init(struct
 	if (!have_governor_per_policy())
 		gov->gdbs_data = dbs_data;
 
-	policy->governor_data = dbs_data;
+	policy_dbs->dbs_data = dbs_data;
+	policy->governor_data = policy_dbs;
 
 	ret = sysfs_create_group(get_governor_parent_kobj(policy),
 				 get_sysfs_attr(gov));
@@ -395,21 +398,21 @@ reset_gdbs_data:
 	if (!have_governor_per_policy())
 		gov->gdbs_data = NULL;
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
-	if (!cdbs->policy_dbs || cdbs->policy_dbs->policy)
+	if (policy_dbs->policy)
 		return -EBUSY;
 
 	if (!--dbs_data->usage_count) {
@@ -434,17 +437,16 @@ static int cpufreq_governor_exit(struct
 static int cpufreq_governor_start(struct cpufreq_policy *policy)
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
-	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
-	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
 	int io_busy = 0;
 
 	if (!policy->cur)
 		return -EINVAL;
 
 	/* State should be equivalent to INIT */
-	if (!policy_dbs || policy_dbs->policy)
+	if (policy_dbs->policy)
 		return -EBUSY;
 
 	if (gov->governor == GOV_CONSERVATIVE) {
@@ -500,12 +502,10 @@ static int cpufreq_governor_start(struct
 
 static int cpufreq_governor_stop(struct cpufreq_policy *policy)
 {
-	struct dbs_governor *gov = dbs_governor_of(policy);
-	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
-	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
 
 	/* State should be equivalent to START */
-	if (!policy_dbs || !policy_dbs->policy)
+	if (!policy_dbs->policy)
 		return -EBUSY;
 
 	gov_cancel_work(policy_dbs);
@@ -516,12 +516,10 @@ static int cpufreq_governor_stop(struct
 
 static int cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
-	struct dbs_governor *gov = dbs_governor_of(policy);
-	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
-	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
 
 	/* State should be equivalent to START */
-	if (!policy_dbs || !policy_dbs->policy)
+	if (!policy_dbs->policy)
 		return -EBUSY;
 
 	mutex_lock(&policy_dbs->timer_mutex);
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -78,7 +78,8 @@ static unsigned int generic_powersave_bi
 	unsigned int jiffies_total, jiffies_hi, jiffies_lo;
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info,
 						   policy->cpu);
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 
 	if (!dbs_info->freq_table) {
@@ -130,7 +131,8 @@ static void ondemand_powersave_bias_init
 
 static void dbs_freq_increase(struct cpufreq_policy *policy, unsigned int freq)
 {
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 
 	if (od_tuners->powersave_bias)
@@ -151,8 +153,9 @@ static void dbs_freq_increase(struct cpu
 static void od_check_cpu(int cpu, unsigned int load)
 {
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
-	struct cpufreq_policy *policy = dbs_info->cdbs.policy_dbs->policy;
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct policy_dbs_info *policy_dbs = dbs_info->cdbs.policy_dbs;
+	struct cpufreq_policy *policy = policy_dbs->policy;
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 
 	dbs_info->freq_lo = 0;
@@ -189,7 +192,8 @@ static void od_check_cpu(int cpu, unsign
 
 static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
 {
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, policy->cpu);
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	int delay = 0, sample_type = dbs_info->sample_type;
@@ -277,7 +281,7 @@ static void update_sampling_rate(struct
 		 * policy will be governed by dbs_data, otherwise there can be
 		 * multiple policies that are governed by the same dbs_data.
 		 */
-		if (dbs_data == policy->governor_data) {
+		if (dbs_data == policy_dbs->dbs_data) {
 			mutex_lock(&policy_dbs->timer_mutex);
 			/*
 			 * On 32-bit architectures this may race with the
@@ -586,7 +590,7 @@ static void od_set_powersave_bias(unsign
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
 		dbs_governor_of(policy)->get_cpu_dbs_info_s(policy->cpu);
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -48,7 +48,8 @@ static void cs_check_cpu(int cpu, unsign
 {
 	struct cs_cpu_dbs_info_s *dbs_info = &per_cpu(cs_cpu_dbs_info, cpu);
 	struct cpufreq_policy *policy = dbs_info->cdbs.policy_dbs->policy;
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
 
 	dbs_check_cpu(policy);
