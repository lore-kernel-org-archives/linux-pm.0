From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 6/11] cpufreq: governor: Rename some data types and variables
Date: Thu, 04 Feb 2016 00:32:15 +0100
Message-ID: <2110408.OUxsfpXISz@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51541 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757337AbcBCXjo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 18:39:44 -0500
In-Reply-To: <3705929.bslqXH980s@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

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
 drivers/cpufreq/cpufreq_governor.c     |   82 ++++++++++++++++-----------------
 drivers/cpufreq/cpufreq_governor.h     |    6 +-
 drivers/cpufreq/cpufreq_ondemand.c     |    8 +--
 5 files changed, 53 insertions(+), 53 deletions(-)

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
@@ -31,14 +31,14 @@ EXPORT_SYMBOL_GPL(dbs_data_mutex);
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
@@ -47,9 +47,9 @@ void dbs_check_cpu(struct dbs_data *dbs_
 	unsigned int ignore_nice;
 	unsigned int j;
 
-	if (dbs_data->cdata->governor == GOV_ONDEMAND) {
+	if (dbs_data->gov->governor == GOV_ONDEMAND) {
 		struct od_cpu_dbs_info_s *od_dbs_info =
-				dbs_data->cdata->get_cpu_dbs_info_s(cpu);
+				dbs_data->gov->get_cpu_dbs_info_s(cpu);
 
 		/*
 		 * Sometimes, the ondemand governor uses an additional
@@ -74,7 +74,7 @@ void dbs_check_cpu(struct dbs_data *dbs_
 		unsigned int load;
 		int io_busy = 0;
 
-		j_cdbs = dbs_data->cdata->get_cpu_cdbs(j);
+		j_cdbs = dbs_data->gov->get_cpu_cdbs(j);
 
 		/*
 		 * For the purpose of ondemand, waiting for disk IO is
@@ -82,7 +82,7 @@ void dbs_check_cpu(struct dbs_data *dbs_
 		 * not that the system is actually idle. So do not add
 		 * the iowait time to the cpu idle time.
 		 */
-		if (dbs_data->cdata->governor == GOV_ONDEMAND)
+		if (dbs_data->gov->governor == GOV_ONDEMAND)
 			io_busy = od_tuners->io_is_busy;
 		cur_idle_time = get_cpu_idle_time(j, &cur_wall_time, io_busy);
 
@@ -163,7 +163,7 @@ void dbs_check_cpu(struct dbs_data *dbs_
 			max_load = load;
 	}
 
-	dbs_data->cdata->gov_check_cpu(cpu, max_load);
+	dbs_data->gov->gov_check_cpu(cpu, max_load);
 }
 EXPORT_SYMBOL_GPL(dbs_check_cpu);
 
@@ -178,7 +178,7 @@ void gov_set_update_util(struct cpu_comm
 	shared->time_stamp = ktime_get();
 
 	for_each_cpu(cpu, policy->cpus) {
-		struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
+		struct cpu_dbs_info *cdbs = dbs_data->gov->get_cpu_cdbs(cpu);
 
 		cdbs->last_sample_time = 0;
 		cpufreq_set_update_util_data(cpu, &cdbs->update_util);
@@ -222,7 +222,7 @@ static void dbs_work_handler(struct work
 	policy = shared->policy;
 	dbs_data = policy->governor_data;
 
-	if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
+	if (dbs_data->gov->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
 		sampling_rate = cs_tuners->sampling_rate;
@@ -238,7 +238,7 @@ static void dbs_work_handler(struct work
 	 * parallel.
 	 */
 	mutex_lock(&shared->timer_mutex);
-	delay = dbs_data->cdata->gov_dbs_timer(policy);
+	delay = dbs_data->gov->gov_dbs_timer(policy);
 	shared->sample_delay_ns = jiffies_to_nsecs(delay);
 	shared->time_stamp = ktime_get();
 	mutex_unlock(&shared->timer_mutex);
@@ -284,7 +284,7 @@ static void dbs_update_util_handler(stru
 static void set_sampling_rate(struct dbs_data *dbs_data,
 		unsigned int sampling_rate)
 {
-	if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
+	if (dbs_data->gov->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 		cs_tuners->sampling_rate = sampling_rate;
 	} else {
@@ -294,7 +294,7 @@ static void set_sampling_rate(struct dbs
 }
 
 static int alloc_common_dbs_info(struct cpufreq_policy *policy,
-				 struct common_dbs_data *cdata)
+				 struct dbs_governor *gov)
 {
 	struct cpu_common_dbs_info *shared;
 	int j;
@@ -306,7 +306,7 @@ static int alloc_common_dbs_info(struct
 
 	/* Set shared for all CPUs, online+offline */
 	for_each_cpu(j, policy->related_cpus)
-		cdata->get_cpu_cdbs(j)->shared = shared;
+		gov->get_cpu_cdbs(j)->shared = shared;
 
 	mutex_init(&shared->timer_mutex);
 	atomic_set(&shared->skip_work, 0);
@@ -315,22 +315,22 @@ static int alloc_common_dbs_info(struct
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
 	struct dbs_data *dbs_data;
 	unsigned int latency;
@@ -344,7 +344,7 @@ static int cpufreq_governor_init(struct
 		if (WARN_ON(have_governor_per_policy()))
 			return -EINVAL;
 
-		ret = alloc_common_dbs_info(policy, cdata);
+		ret = alloc_common_dbs_info(policy, gov);
 		if (ret)
 			return ret;
 
@@ -357,14 +357,14 @@ static int cpufreq_governor_init(struct
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
 
@@ -393,9 +393,9 @@ static int cpufreq_governor_init(struct
 	if (!have_governor_per_policy())
 		global_dbs_data = NULL;
 
-	cdata->exit(dbs_data, !policy->governor->initialized);
+	gov->exit(dbs_data, !policy->governor->initialized);
 free_common_dbs_info:
-	free_common_dbs_info(policy, cdata);
+	free_common_dbs_info(policy, gov);
 free_dbs_data:
 	kfree(dbs_data);
 	return ret;
@@ -404,8 +404,8 @@ free_dbs_data:
 static int cpufreq_governor_exit(struct cpufreq_policy *policy)
 {
 	struct dbs_data *dbs_data = policy->governor_data;
-	struct common_dbs_data *cdata = dbs_data->cdata;
-	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(policy->cpu);
+	struct dbs_governor *gov = dbs_data->gov;
+	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
 
 	/* State should be equivalent to INIT */
 	if (!cdbs->shared || cdbs->shared->policy)
@@ -420,22 +420,22 @@ static int cpufreq_governor_exit(struct
 		if (!have_governor_per_policy())
 			global_dbs_data = NULL;
 
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
 
@@ -446,7 +446,7 @@ static int cpufreq_governor_start(struct
 	if (!shared || shared->policy)
 		return -EBUSY;
 
-	if (cdata->governor == GOV_CONSERVATIVE) {
+	if (gov->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
 		sampling_rate = cs_tuners->sampling_rate;
@@ -460,7 +460,7 @@ static int cpufreq_governor_start(struct
 	}
 
 	for_each_cpu(j, policy->cpus) {
-		struct cpu_dbs_info *j_cdbs = cdata->get_cpu_cdbs(j);
+		struct cpu_dbs_info *j_cdbs = gov->get_cpu_cdbs(j);
 		unsigned int prev_load;
 
 		j_cdbs->prev_cpu_idle =
@@ -479,15 +479,15 @@ static int cpufreq_governor_start(struct
 	shared->policy = policy;
 	init_irq_work(&shared->irq_work, dbs_irq_work);
 
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
@@ -501,7 +501,7 @@ static int cpufreq_governor_start(struct
 static int cpufreq_governor_stop(struct cpufreq_policy *policy)
 {
 	struct dbs_data *dbs_data = policy->governor_data;
-	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(policy->cpu);
+	struct cpu_dbs_info *cdbs = dbs_data->gov->get_cpu_cdbs(policy->cpu);
 	struct cpu_common_dbs_info *shared = cdbs->shared;
 
 	/* State should be equivalent to START */
@@ -517,9 +517,9 @@ static int cpufreq_governor_stop(struct
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
@@ -539,7 +539,7 @@ static int cpufreq_governor_limits(struc
 }
 
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
-			 struct common_dbs_data *cdata, unsigned int event)
+			 struct dbs_governor *gov, unsigned int event)
 {
 	int ret = -EINVAL;
 
@@ -547,7 +547,7 @@ int cpufreq_governor_dbs(struct cpufreq_
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
@@ -200,7 +200,7 @@ struct cs_dbs_tuners {
 
 /* Common Governor data across policies */
 struct dbs_data;
-struct common_dbs_data {
+struct dbs_governor {
 	struct cpufreq_governor gov;
 
 	#define GOV_ONDEMAND		0
@@ -222,7 +222,7 @@ struct common_dbs_data {
 
 /* Governor Per policy data */
 struct dbs_data {
-	struct common_dbs_data *cdata;
+	struct dbs_governor *gov;
 	unsigned int min_sampling_rate;
 	int usage_count;
 	void *tuners;
@@ -274,7 +274,7 @@ void gov_set_update_util(struct cpu_comm
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
@@ -223,7 +223,7 @@ static unsigned int od_dbs_timer(struct
 }
 
 /************************** sysfs interface ************************/
-static struct common_dbs_data od_dbs_cdata;
+static struct dbs_governor od_dbs_gov;
 
 /**
  * update_sampling_rate - update sampling rate effective immediately if needed.
@@ -542,7 +542,7 @@ static struct od_ops od_ops = {
 static int od_cpufreq_governor_dbs(struct cpufreq_policy *policy,
 				   unsigned int event);
 
-static struct common_dbs_data od_dbs_cdata = {
+static struct dbs_governor od_dbs_gov = {
 	.gov = {
 		.name = "ondemand",
 		.governor = od_cpufreq_governor_dbs,
@@ -561,12 +561,12 @@ static struct common_dbs_data od_dbs_cda
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

