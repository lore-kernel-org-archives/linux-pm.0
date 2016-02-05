From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 5/10] cpufreq: governor: Rename some data types and variables
Date: Fri, 05 Feb 2016 03:17:28 +0100
Message-ID: <3702180.uHU6PQUSgm@vostro.rjw.lan>
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

The ondemand and conservative governors are represented by
struct common_dbs_data whose name doesn't reflect the purpose it
is used for, so rename it to struct dbs_governor and rename
variables of that type accordingly.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/amd_freq_sensitivity.c |    2 
 drivers/cpufreq/cpufreq_conservative.c |    8 +--
 drivers/cpufreq/cpufreq_governor.c     |   88 ++++++++++++++++-----------------
 drivers/cpufreq/cpufreq_governor.h     |   12 ++--
 drivers/cpufreq/cpufreq_ondemand.c     |    8 +--
 5 files changed, 59 insertions(+), 59 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -119,7 +119,7 @@ static struct notifier_block cs_cpufreq_
 };
 
 /************************** sysfs interface ************************/
-static struct common_dbs_data cs_dbs_cdata;
+static struct dbs_governor cs_dbs_gov;
 
 static ssize_t store_sampling_down_factor(struct dbs_data *dbs_data,
 		const char *buf, size_t count)
@@ -328,7 +328,7 @@ define_get_cpu_dbs_routines(cs_cpu_dbs_i
 static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
 				   unsigned int event);
 
-static struct common_dbs_data cs_dbs_cdata = {
+static struct dbs_governor cs_dbs_gov = {
 	.gov = {
 		.name = "conservative",
 		.governor = cs_cpufreq_governor_dbs,
@@ -346,12 +346,12 @@ static struct common_dbs_data cs_dbs_cda
 	.exit = cs_exit,
 };
 
-#define CPU_FREQ_GOV_CONSERVATIVE	(&cs_dbs_cdata.gov)
+#define CPU_FREQ_GOV_CONSERVATIVE	(&cs_dbs_gov.gov)
 
 static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
 				   unsigned int event)
 {
-	return cpufreq_governor_dbs(policy, &cs_dbs_cdata, event);
+	return cpufreq_governor_dbs(policy, &cs_dbs_gov, event);
 }
 
 static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -28,14 +28,14 @@ EXPORT_SYMBOL_GPL(dbs_data_mutex);
 static struct attribute_group *get_sysfs_attr(struct dbs_data *dbs_data)
 {
 	if (have_governor_per_policy())
-		return dbs_data->cdata->attr_group_gov_pol;
+		return dbs_data->gov->attr_group_gov_pol;
 	else
-		return dbs_data->cdata->attr_group_gov_sys;
+		return dbs_data->gov->attr_group_gov_sys;
 }
 
 void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 {
-	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
+	struct cpu_dbs_info *cdbs = dbs_data->gov->get_cpu_cdbs(cpu);
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	struct cpufreq_policy *policy = cdbs->shared->policy;
@@ -44,9 +44,9 @@ void dbs_check_cpu(struct dbs_data *dbs_
 	unsigned int ignore_nice;
 	unsigned int j;
 
-	if (dbs_data->cdata->governor == GOV_ONDEMAND) {
+	if (dbs_data->gov->governor == GOV_ONDEMAND) {
 		struct od_cpu_dbs_info_s *od_dbs_info =
-				dbs_data->cdata->get_cpu_dbs_info_s(cpu);
+				dbs_data->gov->get_cpu_dbs_info_s(cpu);
 
 		/*
 		 * Sometimes, the ondemand governor uses an additional
@@ -71,7 +71,7 @@ void dbs_check_cpu(struct dbs_data *dbs_
 		unsigned int load;
 		int io_busy = 0;
 
-		j_cdbs = dbs_data->cdata->get_cpu_cdbs(j);
+		j_cdbs = dbs_data->gov->get_cpu_cdbs(j);
 
 		/*
 		 * For the purpose of ondemand, waiting for disk IO is
@@ -79,7 +79,7 @@ void dbs_check_cpu(struct dbs_data *dbs_
 		 * not that the system is actually idle. So do not add
 		 * the iowait time to the cpu idle time.
 		 */
-		if (dbs_data->cdata->governor == GOV_ONDEMAND)
+		if (dbs_data->gov->governor == GOV_ONDEMAND)
 			io_busy = od_tuners->io_is_busy;
 		cur_idle_time = get_cpu_idle_time(j, &cur_wall_time, io_busy);
 
@@ -160,7 +160,7 @@ void dbs_check_cpu(struct dbs_data *dbs_
 			max_load = load;
 	}
 
-	dbs_data->cdata->gov_check_cpu(cpu, max_load);
+	dbs_data->gov->gov_check_cpu(cpu, max_load);
 }
 EXPORT_SYMBOL_GPL(dbs_check_cpu);
 
@@ -176,7 +176,7 @@ void gov_set_update_util(struct cpu_comm
 	shared->last_sample_time = 0;
 
 	for_each_cpu(cpu, policy->cpus) {
-		struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
+		struct cpu_dbs_info *cdbs = dbs_data->gov->get_cpu_cdbs(cpu);
 
 		cpufreq_set_update_util_data(cpu, &cdbs->update_util);
 	}
@@ -226,7 +226,7 @@ static void dbs_work_handler(struct work
 	 * parallel.
 	 */
 	mutex_lock(&shared->timer_mutex);
-	delay = dbs_data->cdata->gov_dbs_timer(policy);
+	delay = dbs_data->gov->gov_dbs_timer(policy);
 	shared->sample_delay_ns = jiffies_to_nsecs(delay);
 	shared->time_stamp = ktime_get();
 	mutex_unlock(&shared->timer_mutex);
@@ -279,7 +279,7 @@ static void dbs_update_util_handler(stru
 static void set_sampling_rate(struct dbs_data *dbs_data,
 		unsigned int sampling_rate)
 {
-	if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
+	if (dbs_data->gov->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 		cs_tuners->sampling_rate = sampling_rate;
 	} else {
@@ -289,7 +289,7 @@ static void set_sampling_rate(struct dbs
 }
 
 static int alloc_common_dbs_info(struct cpufreq_policy *policy,
-				 struct common_dbs_data *cdata)
+				 struct dbs_governor *gov)
 {
 	struct cpu_common_dbs_info *shared;
 	int j;
@@ -301,7 +301,7 @@ static int alloc_common_dbs_info(struct
 
 	/* Set shared for all CPUs, online+offline */
 	for_each_cpu(j, policy->related_cpus)
-		cdata->get_cpu_cdbs(j)->shared = shared;
+		gov->get_cpu_cdbs(j)->shared = shared;
 
 	mutex_init(&shared->timer_mutex);
 	atomic_set(&shared->skip_work, 0);
@@ -310,24 +310,24 @@ static int alloc_common_dbs_info(struct
 }
 
 static void free_common_dbs_info(struct cpufreq_policy *policy,
-				 struct common_dbs_data *cdata)
+				 struct dbs_governor *gov)
 {
-	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(policy->cpu);
+	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
 	struct cpu_common_dbs_info *shared = cdbs->shared;
 	int j;
 
 	mutex_destroy(&shared->timer_mutex);
 
 	for_each_cpu(j, policy->cpus)
-		cdata->get_cpu_cdbs(j)->shared = NULL;
+		gov->get_cpu_cdbs(j)->shared = NULL;
 
 	kfree(shared);
 }
 
 static int cpufreq_governor_init(struct cpufreq_policy *policy,
-				 struct common_dbs_data *cdata)
+				 struct dbs_governor *gov)
 {
-	struct dbs_data *dbs_data = cdata->gdbs_data;
+	struct dbs_data *dbs_data = gov->gdbs_data;
 	unsigned int latency;
 	int ret;
 
@@ -339,7 +339,7 @@ static int cpufreq_governor_init(struct
 		if (WARN_ON(have_governor_per_policy()))
 			return -EINVAL;
 
-		ret = alloc_common_dbs_info(policy, cdata);
+		ret = alloc_common_dbs_info(policy, gov);
 		if (ret)
 			return ret;
 
@@ -352,14 +352,14 @@ static int cpufreq_governor_init(struct
 	if (!dbs_data)
 		return -ENOMEM;
 
-	ret = alloc_common_dbs_info(policy, cdata);
+	ret = alloc_common_dbs_info(policy, gov);
 	if (ret)
 		goto free_dbs_data;
 
-	dbs_data->cdata = cdata;
+	dbs_data->gov = gov;
 	dbs_data->usage_count = 1;
 
-	ret = cdata->init(dbs_data, !policy->governor->initialized);
+	ret = gov->init(dbs_data, !policy->governor->initialized);
 	if (ret)
 		goto free_common_dbs_info;
 
@@ -375,7 +375,7 @@ static int cpufreq_governor_init(struct
 					latency * LATENCY_MULTIPLIER));
 
 	if (!have_governor_per_policy())
-		cdata->gdbs_data = dbs_data;
+		gov->gdbs_data = dbs_data;
 
 	policy->governor_data = dbs_data;
 
@@ -390,10 +390,10 @@ reset_gdbs_data:
 	policy->governor_data = NULL;
 
 	if (!have_governor_per_policy())
-		cdata->gdbs_data = NULL;
-	cdata->exit(dbs_data, !policy->governor->initialized);
+		gov->gdbs_data = NULL;
+	gov->exit(dbs_data, !policy->governor->initialized);
 free_common_dbs_info:
-	free_common_dbs_info(policy, cdata);
+	free_common_dbs_info(policy, gov);
 free_dbs_data:
 	kfree(dbs_data);
 	return ret;
@@ -402,8 +402,8 @@ free_dbs_data:
 static int cpufreq_governor_exit(struct cpufreq_policy *policy)
 {
 	struct dbs_data *dbs_data = policy->governor_data;
-	struct common_dbs_data *cdata = dbs_data->cdata;
-	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(policy->cpu);
+	struct dbs_governor *gov = dbs_data->gov;
+	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
 
 	/* State should be equivalent to INIT */
 	if (!cdbs->shared || cdbs->shared->policy)
@@ -416,24 +416,24 @@ static int cpufreq_governor_exit(struct
 		policy->governor_data = NULL;
 
 		if (!have_governor_per_policy())
-			cdata->gdbs_data = NULL;
+			gov->gdbs_data = NULL;
 
-		cdata->exit(dbs_data, policy->governor->initialized == 1);
+		gov->exit(dbs_data, policy->governor->initialized == 1);
 		kfree(dbs_data);
 	} else {
 		policy->governor_data = NULL;
 	}
 
-	free_common_dbs_info(policy, cdata);
+	free_common_dbs_info(policy, gov);
 	return 0;
 }
 
 static int cpufreq_governor_start(struct cpufreq_policy *policy)
 {
 	struct dbs_data *dbs_data = policy->governor_data;
-	struct common_dbs_data *cdata = dbs_data->cdata;
+	struct dbs_governor *gov = dbs_data->gov;
 	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
-	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
+	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
 	struct cpu_common_dbs_info *shared = cdbs->shared;
 	int io_busy = 0;
 
@@ -444,7 +444,7 @@ static int cpufreq_governor_start(struct
 	if (!shared || shared->policy)
 		return -EBUSY;
 
-	if (cdata->governor == GOV_CONSERVATIVE) {
+	if (gov->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
 		sampling_rate = cs_tuners->sampling_rate;
@@ -458,7 +458,7 @@ static int cpufreq_governor_start(struct
 	}
 
 	for_each_cpu(j, policy->cpus) {
-		struct cpu_dbs_info *j_cdbs = cdata->get_cpu_cdbs(j);
+		struct cpu_dbs_info *j_cdbs = gov->get_cpu_cdbs(j);
 		unsigned int prev_load;
 
 		j_cdbs->prev_cpu_idle =
@@ -478,15 +478,15 @@ static int cpufreq_governor_start(struct
 	init_irq_work(&shared->irq_work, dbs_irq_work);
 	init_completion(&shared->irq_work_done);
 
-	if (cdata->governor == GOV_CONSERVATIVE) {
+	if (gov->governor == GOV_CONSERVATIVE) {
 		struct cs_cpu_dbs_info_s *cs_dbs_info =
-			cdata->get_cpu_dbs_info_s(cpu);
+			gov->get_cpu_dbs_info_s(cpu);
 
 		cs_dbs_info->down_skip = 0;
 		cs_dbs_info->requested_freq = policy->cur;
 	} else {
-		struct od_ops *od_ops = cdata->gov_ops;
-		struct od_cpu_dbs_info_s *od_dbs_info = cdata->get_cpu_dbs_info_s(cpu);
+		struct od_ops *od_ops = gov->gov_ops;
+		struct od_cpu_dbs_info_s *od_dbs_info = gov->get_cpu_dbs_info_s(cpu);
 
 		od_dbs_info->rate_mult = 1;
 		od_dbs_info->sample_type = OD_NORMAL_SAMPLE;
@@ -500,7 +500,7 @@ static int cpufreq_governor_start(struct
 static int cpufreq_governor_stop(struct cpufreq_policy *policy)
 {
 	struct dbs_data *dbs_data = policy->governor_data;
-	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(policy->cpu);
+	struct cpu_dbs_info *cdbs = dbs_data->gov->get_cpu_cdbs(policy->cpu);
 	struct cpu_common_dbs_info *shared = cdbs->shared;
 
 	/* State should be equivalent to START */
@@ -516,9 +516,9 @@ static int cpufreq_governor_stop(struct
 static int cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
 	struct dbs_data *dbs_data = policy->governor_data;
-	struct common_dbs_data *cdata = dbs_data->cdata;
+	struct dbs_governor *gov = dbs_data->gov;
 	unsigned int cpu = policy->cpu;
-	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
+	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
 
 	/* State should be equivalent to START */
 	if (!cdbs->shared || !cdbs->shared->policy)
@@ -538,7 +538,7 @@ static int cpufreq_governor_limits(struc
 }
 
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
-			 struct common_dbs_data *cdata, unsigned int event)
+			 struct dbs_governor *gov, unsigned int event)
 {
 	int ret = -EINVAL;
 
@@ -546,7 +546,7 @@ int cpufreq_governor_dbs(struct cpufreq_
 	mutex_lock(&dbs_data_mutex);
 
 	if (event == CPUFREQ_GOV_POLICY_INIT) {
-		ret = cpufreq_governor_init(policy, cdata);
+		ret = cpufreq_governor_init(policy, gov);
 	} else if (policy->governor_data) {
 		switch (event) {
 		case CPUFREQ_GOV_POLICY_EXIT:
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -79,7 +79,7 @@ __ATTR(_name, 0644, show_##_name##_gov_p
 static ssize_t show_##file_name##_gov_sys				\
 (struct kobject *kobj, struct attribute *attr, char *buf)		\
 {									\
-	struct _gov##_dbs_tuners *tuners = _gov##_dbs_cdata.gdbs_data->tuners; \
+	struct _gov##_dbs_tuners *tuners = _gov##_dbs_gov.gdbs_data->tuners; \
 	return sprintf(buf, "%u\n", tuners->file_name);			\
 }									\
 									\
@@ -95,7 +95,7 @@ static ssize_t show_##file_name##_gov_po
 static ssize_t store_##file_name##_gov_sys				\
 (struct kobject *kobj, struct attribute *attr, const char *buf, size_t count) \
 {									\
-	struct dbs_data *dbs_data = _gov##_dbs_cdata.gdbs_data;		\
+	struct dbs_data *dbs_data = _gov##_dbs_gov.gdbs_data;		\
 	return store_##file_name(dbs_data, buf, count);			\
 }									\
 									\
@@ -202,7 +202,7 @@ struct cs_dbs_tuners {
 
 /* Common Governor data across policies */
 struct dbs_data;
-struct common_dbs_data {
+struct dbs_governor {
 	struct cpufreq_governor gov;
 
 	#define GOV_ONDEMAND		0
@@ -230,7 +230,7 @@ struct common_dbs_data {
 
 /* Governor Per policy data */
 struct dbs_data {
-	struct common_dbs_data *cdata;
+	struct dbs_governor *gov;
 	unsigned int min_sampling_rate;
 	int usage_count;
 	void *tuners;
@@ -259,7 +259,7 @@ static inline int delay_for_sampling_rat
 static ssize_t show_sampling_rate_min_gov_sys				\
 (struct kobject *kobj, struct attribute *attr, char *buf)		\
 {									\
-	struct dbs_data *dbs_data = _gov##_dbs_cdata.gdbs_data;		\
+	struct dbs_data *dbs_data = _gov##_dbs_gov.gdbs_data;		\
 	return sprintf(buf, "%u\n", dbs_data->min_sampling_rate);	\
 }									\
 									\
@@ -277,7 +277,7 @@ void gov_set_update_util(struct cpu_comm
 void gov_cancel_work(struct cpu_common_dbs_info *shared);
 void dbs_check_cpu(struct dbs_data *dbs_data, int cpu);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
-		struct common_dbs_data *cdata, unsigned int event);
+		struct dbs_governor *gov, unsigned int event);
 void od_register_powersave_bias_handler(unsigned int (*f)
 		(struct cpufreq_policy *, unsigned int, unsigned int),
 		unsigned int powersave_bias);
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -219,7 +219,7 @@ static unsigned int od_dbs_timer(struct
 }
 
 /************************** sysfs interface ************************/
-static struct common_dbs_data od_dbs_cdata;
+static struct dbs_governor od_dbs_gov;
 
 /**
  * update_sampling_rate - update sampling rate effective immediately if needed.
@@ -538,7 +538,7 @@ static struct od_ops od_ops = {
 static int od_cpufreq_governor_dbs(struct cpufreq_policy *policy,
 				   unsigned int event);
 
-static struct common_dbs_data od_dbs_cdata = {
+static struct dbs_governor od_dbs_gov = {
 	.gov = {
 		.name = "ondemand",
 		.governor = od_cpufreq_governor_dbs,
@@ -557,12 +557,12 @@ static struct common_dbs_data od_dbs_cda
 	.exit = od_exit,
 };
 
-#define CPU_FREQ_GOV_ONDEMAND	(&od_dbs_cdata.gov)
+#define CPU_FREQ_GOV_ONDEMAND	(&od_dbs_gov.gov)
 
 static int od_cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		unsigned int event)
 {
-	return cpufreq_governor_dbs(policy, &od_dbs_cdata, event);
+	return cpufreq_governor_dbs(policy, &od_dbs_gov, event);
 }
 
 static void od_set_powersave_bias(unsigned int powersave_bias)
Index: linux-pm/drivers/cpufreq/amd_freq_sensitivity.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/amd_freq_sensitivity.c
+++ linux-pm/drivers/cpufreq/amd_freq_sensitivity.c
@@ -48,7 +48,7 @@ static unsigned int amd_powersave_bias_t
 	struct dbs_data *od_data = policy->governor_data;
 	struct od_dbs_tuners *od_tuners = od_data->tuners;
 	struct od_cpu_dbs_info_s *od_info =
-		od_data->cdata->get_cpu_dbs_info_s(policy->cpu);
+		od_data->gov->get_cpu_dbs_info_s(policy->cpu);
 
 	if (!od_info->freq_table)
 		return freq_next;
