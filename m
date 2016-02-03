From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 8/11] cpufreq: governor: Drop the gov pointer from struct dbs_data
Date: Thu, 04 Feb 2016 00:35:01 +0100
Message-ID: <2027049.89TTYSMccL@vostro.rjw.lan>
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

Since it is possible to obtain a pointer to struct dbs_governor
from a pointer to the struct governor embedded in it with the help
of container_of(), the additional gov pointer in struct dbs_data
isn't really necessary.

Drop that pointer and make the code using it reach the dbs_governor
object via policy->governor.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_conservative.c |    2 -
 drivers/cpufreq/cpufreq_governor.c     |   62 ++++++++++++++++-----------------
 drivers/cpufreq/cpufreq_governor.h     |    8 +++-
 drivers/cpufreq/cpufreq_ondemand.c     |    2 -
 4 files changed, 39 insertions(+), 35 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -220,9 +220,13 @@ struct dbs_governor {
 	void *gov_ops;
 };
 
+static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy)
+{
+	return container_of(policy->governor, struct dbs_governor, gov);
+}
+
 /* Governor Per policy data */
 struct dbs_data {
-	struct dbs_governor *gov;
 	unsigned int min_sampling_rate;
 	int usage_count;
 	void *tuners;
@@ -272,7 +276,7 @@ extern struct mutex cpufreq_governor_loc
 void gov_set_update_util(struct cpu_common_dbs_info *shared,
 			 unsigned int delay_us);
 void gov_cancel_work(struct cpu_common_dbs_info *shared);
-void dbs_check_cpu(struct dbs_data *dbs_data, int cpu);
+void dbs_check_cpu(struct cpufreq_policy *policy, int cpu);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy, unsigned int event);
 void od_register_powersave_bias_handler(unsigned int (*f)
 		(struct cpufreq_policy *, unsigned int, unsigned int),
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -107,7 +107,7 @@ static unsigned int cs_dbs_timer(struct
 	struct dbs_data *dbs_data = policy->governor_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
-	dbs_check_cpu(dbs_data, policy->cpu);
+	dbs_check_cpu(policy, policy->cpu);
 	return delay_for_sampling_rate(cs_tuners->sampling_rate);
 }
 
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -28,28 +28,27 @@ EXPORT_SYMBOL_GPL(global_dbs_data);
 DEFINE_MUTEX(dbs_data_mutex);
 EXPORT_SYMBOL_GPL(dbs_data_mutex);
 
-static struct attribute_group *get_sysfs_attr(struct dbs_data *dbs_data)
+static struct attribute_group *get_sysfs_attr(struct dbs_governor *gov)
 {
-	if (have_governor_per_policy())
-		return dbs_data->gov->attr_group_gov_pol;
-	else
-		return dbs_data->gov->attr_group_gov_sys;
+	return have_governor_per_policy() ?
+		gov->attr_group_gov_pol : gov->attr_group_gov_sys;
 }
 
-void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
+void dbs_check_cpu(struct cpufreq_policy *policy, int cpu)
 {
-	struct cpu_dbs_info *cdbs = dbs_data->gov->get_cpu_cdbs(cpu);
+	struct dbs_governor *gov = dbs_governor_of(policy);
+	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
+	struct dbs_data *dbs_data = policy->governor_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
-	struct cpufreq_policy *policy = cdbs->shared->policy;
 	unsigned int sampling_rate;
 	unsigned int max_load = 0;
 	unsigned int ignore_nice;
 	unsigned int j;
 
-	if (dbs_data->gov->governor == GOV_ONDEMAND) {
+	if (gov->governor == GOV_ONDEMAND) {
 		struct od_cpu_dbs_info_s *od_dbs_info =
-				dbs_data->gov->get_cpu_dbs_info_s(cpu);
+				gov->get_cpu_dbs_info_s(cpu);
 
 		/*
 		 * Sometimes, the ondemand governor uses an additional
@@ -74,7 +73,7 @@ void dbs_check_cpu(struct dbs_data *dbs_
 		unsigned int load;
 		int io_busy = 0;
 
-		j_cdbs = dbs_data->gov->get_cpu_cdbs(j);
+		j_cdbs = gov->get_cpu_cdbs(j);
 
 		/*
 		 * For the purpose of ondemand, waiting for disk IO is
@@ -82,7 +81,7 @@ void dbs_check_cpu(struct dbs_data *dbs_
 		 * not that the system is actually idle. So do not add
 		 * the iowait time to the cpu idle time.
 		 */
-		if (dbs_data->gov->governor == GOV_ONDEMAND)
+		if (gov->governor == GOV_ONDEMAND)
 			io_busy = od_tuners->io_is_busy;
 		cur_idle_time = get_cpu_idle_time(j, &cur_wall_time, io_busy);
 
@@ -163,7 +162,7 @@ void dbs_check_cpu(struct dbs_data *dbs_
 			max_load = load;
 	}
 
-	dbs_data->gov->gov_check_cpu(cpu, max_load);
+	gov->gov_check_cpu(cpu, max_load);
 }
 EXPORT_SYMBOL_GPL(dbs_check_cpu);
 
@@ -171,14 +170,14 @@ void gov_set_update_util(struct cpu_comm
 			 unsigned int delay_us)
 {
 	struct cpufreq_policy *policy = shared->policy;
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct dbs_governor *gov = dbs_governor_of(policy);
 	int cpu;
 
 	shared->sample_delay_ns = delay_us * NSEC_PER_USEC;
 	shared->time_stamp = ktime_get();
 
 	for_each_cpu(cpu, policy->cpus) {
-		struct cpu_dbs_info *cdbs = dbs_data->gov->get_cpu_cdbs(cpu);
+		struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
 
 		cdbs->last_sample_time = 0;
 		cpufreq_set_update_util_data(cpu, &cdbs->update_util);
@@ -216,13 +215,15 @@ static void dbs_work_handler(struct work
 	struct cpu_common_dbs_info *shared = container_of(work, struct
 					cpu_common_dbs_info, work);
 	struct cpufreq_policy *policy;
+	struct dbs_governor *gov;
 	struct dbs_data *dbs_data;
 	unsigned int sampling_rate, delay;
 
 	policy = shared->policy;
 	dbs_data = policy->governor_data;
+	gov = dbs_governor_of(policy);
 
-	if (dbs_data->gov->governor == GOV_CONSERVATIVE) {
+	if (gov->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
 		sampling_rate = cs_tuners->sampling_rate;
@@ -238,7 +239,7 @@ static void dbs_work_handler(struct work
 	 * parallel.
 	 */
 	mutex_lock(&shared->timer_mutex);
-	delay = dbs_data->gov->gov_dbs_timer(policy);
+	delay = gov->gov_dbs_timer(policy);
 	shared->sample_delay_ns = jiffies_to_nsecs(delay);
 	shared->time_stamp = ktime_get();
 	mutex_unlock(&shared->timer_mutex);
@@ -282,9 +283,10 @@ static void dbs_update_util_handler(stru
 }
 
 static void set_sampling_rate(struct dbs_data *dbs_data,
-		unsigned int sampling_rate)
+			      struct dbs_governor *gov,
+			      unsigned int sampling_rate)
 {
-	if (dbs_data->gov->governor == GOV_CONSERVATIVE) {
+	if (gov->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 		cs_tuners->sampling_rate = sampling_rate;
 	} else {
@@ -340,7 +342,7 @@ static int cpufreq_governor_init(struct
 	if (policy->governor_data)
 		return -EBUSY;
 
-	gov = container_of(policy->governor, struct dbs_governor, gov);
+	gov = dbs_governor_of(policy);
 	if (global_dbs_data) {
 		if (WARN_ON(have_governor_per_policy()))
 			return -EINVAL;
@@ -362,7 +364,6 @@ static int cpufreq_governor_init(struct
 	if (ret)
 		goto free_dbs_data;
 
-	dbs_data->gov = gov;
 	dbs_data->usage_count = 1;
 
 	ret = gov->init(dbs_data, !policy->governor->initialized);
@@ -377,7 +378,7 @@ static int cpufreq_governor_init(struct
 	/* Bring kernel and HW constraints together */
 	dbs_data->min_sampling_rate = max(dbs_data->min_sampling_rate,
 					  MIN_LATENCY_MULTIPLIER * latency);
-	set_sampling_rate(dbs_data, max(dbs_data->min_sampling_rate,
+	set_sampling_rate(dbs_data, gov, max(dbs_data->min_sampling_rate,
 					latency * LATENCY_MULTIPLIER));
 
 	if (!have_governor_per_policy())
@@ -386,7 +387,7 @@ static int cpufreq_governor_init(struct
 	policy->governor_data = dbs_data;
 
 	ret = sysfs_create_group(get_governor_parent_kobj(policy),
-				 get_sysfs_attr(dbs_data));
+				 get_sysfs_attr(gov));
 	if (!ret)
 		return 0;
 
@@ -404,8 +405,8 @@ free_dbs_data:
 
 static int cpufreq_governor_exit(struct cpufreq_policy *policy)
 {
+	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct dbs_data *dbs_data = policy->governor_data;
-	struct dbs_governor *gov = dbs_data->gov;
 	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
 
 	/* State should be equivalent to INIT */
@@ -414,7 +415,7 @@ static int cpufreq_governor_exit(struct
 
 	if (!--dbs_data->usage_count) {
 		sysfs_remove_group(get_governor_parent_kobj(policy),
-				   get_sysfs_attr(dbs_data));
+				   get_sysfs_attr(gov));
 
 		policy->governor_data = NULL;
 
@@ -433,8 +434,8 @@ static int cpufreq_governor_exit(struct
 
 static int cpufreq_governor_start(struct cpufreq_policy *policy)
 {
+	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct dbs_data *dbs_data = policy->governor_data;
-	struct dbs_governor *gov = dbs_data->gov;
 	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
 	struct cpu_common_dbs_info *shared = cdbs->shared;
@@ -501,8 +502,8 @@ static int cpufreq_governor_start(struct
 
 static int cpufreq_governor_stop(struct cpufreq_policy *policy)
 {
-	struct dbs_data *dbs_data = policy->governor_data;
-	struct cpu_dbs_info *cdbs = dbs_data->gov->get_cpu_cdbs(policy->cpu);
+	struct dbs_governor *gov = dbs_governor_of(policy);
+	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
 	struct cpu_common_dbs_info *shared = cdbs->shared;
 
 	/* State should be equivalent to START */
@@ -517,8 +518,7 @@ static int cpufreq_governor_stop(struct
 
 static int cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
-	struct dbs_data *dbs_data = policy->governor_data;
-	struct dbs_governor *gov = dbs_data->gov;
+	struct dbs_governor *gov = dbs_governor_of(policy);
 	unsigned int cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
 
@@ -533,7 +533,7 @@ static int cpufreq_governor_limits(struc
 	else if (policy->min > cdbs->shared->policy->cur)
 		__cpufreq_driver_target(cdbs->shared->policy, policy->min,
 					CPUFREQ_RELATION_L);
-	dbs_check_cpu(dbs_data, cpu);
+	dbs_check_cpu(policy, cpu);
 	mutex_unlock(&cdbs->shared->timer_mutex);
 
 	return 0;
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -207,7 +207,7 @@ static unsigned int od_dbs_timer(struct
 		__cpufreq_driver_target(policy, dbs_info->freq_lo,
 					CPUFREQ_RELATION_H);
 	} else {
-		dbs_check_cpu(dbs_data, cpu);
+		dbs_check_cpu(policy, cpu);
 		if (dbs_info->freq_lo) {
 			/* Setup timer for SUB_SAMPLE */
 			dbs_info->sample_type = OD_SUB_SAMPLE;
