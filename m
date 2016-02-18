From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 9/12] cpufreq: governor: Move per-CPU data to the common code
Date: Thu, 18 Feb 2016 02:31:52 +0100
Message-ID: <4441299.INuf21BhVZ@vostro.rjw.lan>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2938006.67J0esUvOA@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After previous changes there is only one piece of code in the
ondemand governor making references to per-CPU data structures,
but it can be easily modified to avoid doing that, so modify it
accordingly and move the definition of per-CPU data used by the
ondemand and conservative governors to the common code.  Next,
change that code to access the per-CPU data structures directly
rather than via a governor callback.

This causes the ->get_cpu_cdbs governor callback to become
unnecessary, so drop it along with the macro and function
definitions related to it.

Finally, drop the definitions of struct od_cpu_dbs_info_s and
struct cs_cpu_dbs_info_s that aren't necessary any more.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_conservative.c |    9 +--------
 drivers/cpufreq/cpufreq_governor.c     |   24 ++++++++++--------------
 drivers/cpufreq/cpufreq_governor.h     |   18 +-----------------
 drivers/cpufreq/cpufreq_ondemand.c     |   26 ++++++++++----------------
 4 files changed, 22 insertions(+), 55 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -22,6 +22,8 @@
 
 #include "cpufreq_governor.h"
 
+static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
+
 DEFINE_MUTEX(dbs_data_mutex);
 EXPORT_SYMBOL_GPL(dbs_data_mutex);
 
@@ -82,7 +84,6 @@ EXPORT_SYMBOL_GPL(store_sampling_rate);
 
 /**
  * gov_update_cpu_data - Update CPU load data.
- * @gov: Governor whose data is to be updated.
  * @dbs_data: Top-level governor data pointer.
  *
  * Update CPU load data for all CPUs in the domain governed by @dbs_data
@@ -91,7 +92,7 @@ EXPORT_SYMBOL_GPL(store_sampling_rate);
  *
  * Call under the @dbs_data mutex.
  */
-void gov_update_cpu_data(struct dbs_governor *gov, struct dbs_data *dbs_data)
+void gov_update_cpu_data(struct dbs_data *dbs_data)
 {
 	struct policy_dbs_info *policy_dbs;
 
@@ -99,7 +100,7 @@ void gov_update_cpu_data(struct dbs_gove
 		unsigned int j;
 
 		for_each_cpu(j, policy_dbs->policy->cpus) {
-			struct cpu_dbs_info *j_cdbs = gov->get_cpu_cdbs(j);
+			struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
 
 			j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_cpu_wall,
 								  dbs_data->io_is_busy);
@@ -164,7 +165,6 @@ static const struct sysfs_ops governor_s
 
 unsigned int dbs_update(struct cpufreq_policy *policy)
 {
-	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	unsigned int ignore_nice = dbs_data->ignore_nice_load;
@@ -187,13 +187,11 @@ unsigned int dbs_update(struct cpufreq_p
 
 	/* Get Absolute Load */
 	for_each_cpu(j, policy->cpus) {
-		struct cpu_dbs_info *j_cdbs;
+		struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
 		u64 cur_wall_time, cur_idle_time;
 		unsigned int idle_time, wall_time;
 		unsigned int load;
 
-		j_cdbs = gov->get_cpu_cdbs(j);
-
 		cur_idle_time = get_cpu_idle_time(j, &cur_wall_time, io_busy);
 
 		wall_time = cur_wall_time - j_cdbs->prev_cpu_wall;
@@ -268,14 +266,13 @@ void gov_set_update_util(struct policy_d
 			 unsigned int delay_us)
 {
 	struct cpufreq_policy *policy = policy_dbs->policy;
-	struct dbs_governor *gov = dbs_governor_of(policy);
 	int cpu;
 
 	gov_update_sample_delay(policy_dbs, delay_us);
 	policy_dbs->last_sample_time = 0;
 
 	for_each_cpu(cpu, policy->cpus) {
-		struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
+		struct cpu_dbs_info *cdbs = &per_cpu(cpu_dbs, cpu);
 
 		cpufreq_set_update_util_data(cpu, &cdbs->update_util);
 	}
@@ -398,7 +395,7 @@ static struct policy_dbs_info *alloc_pol
 
 	/* Set policy_dbs for all CPUs, online+offline */
 	for_each_cpu(j, policy->related_cpus) {
-		struct cpu_dbs_info *j_cdbs = gov->get_cpu_cdbs(j);
+		struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
 
 		j_cdbs->policy_dbs = policy_dbs;
 		j_cdbs->update_util.func = dbs_update_util_handler;
@@ -409,14 +406,13 @@ static struct policy_dbs_info *alloc_pol
 static void free_policy_dbs_info(struct cpufreq_policy *policy,
 				 struct dbs_governor *gov)
 {
-	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
-	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	int j;
 
 	mutex_destroy(&policy_dbs->timer_mutex);
 
 	for_each_cpu(j, policy->related_cpus) {
-		struct cpu_dbs_info *j_cdbs = gov->get_cpu_cdbs(j);
+		struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
 
 		j_cdbs->policy_dbs = NULL;
 		j_cdbs->update_util.func = NULL;
@@ -561,7 +557,7 @@ static int cpufreq_governor_start(struct
 	io_busy = dbs_data->io_is_busy;
 
 	for_each_cpu(j, policy->cpus) {
-		struct cpu_dbs_info *j_cdbs = gov->get_cpu_cdbs(j);
+		struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
 		unsigned int prev_load;
 
 		j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_cpu_wall, io_busy);
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -41,9 +41,6 @@ static inline struct od_policy_dbs_info
 #define MIN_FREQUENCY_UP_THRESHOLD		(11)
 #define MAX_FREQUENCY_UP_THRESHOLD		(100)
 
-static DEFINE_PER_CPU(struct od_cpu_dbs_info_s, od_cpu_dbs_info);
-
-static struct dbs_governor od_dbs_gov;
 static struct od_ops od_ops;
 
 static unsigned int default_powersave_bias;
@@ -235,7 +232,7 @@ static ssize_t store_io_is_busy(struct d
 	dbs_data->io_is_busy = !!input;
 
 	/* we need to re-evaluate prev_cpu_idle */
-	gov_update_cpu_data(&od_dbs_gov, dbs_data);
+	gov_update_cpu_data(dbs_data);
 
 	return count;
 }
@@ -302,7 +299,7 @@ static ssize_t store_ignore_nice_load(st
 	dbs_data->ignore_nice_load = input;
 
 	/* we need to re-evaluate prev_cpu_idle */
-	gov_update_cpu_data(&od_dbs_gov, dbs_data);
+	gov_update_cpu_data(dbs_data);
 
 	return count;
 }
@@ -426,8 +423,6 @@ static void od_start(struct cpufreq_poli
 	ondemand_powersave_bias_init(policy);
 }
 
-define_get_cpu_dbs_routines(od_cpu_dbs_info);
-
 static struct od_ops od_ops = {
 	.powersave_bias_target = generic_powersave_bias_target,
 };
@@ -440,7 +435,6 @@ static struct dbs_governor od_dbs_gov =
 		.owner = THIS_MODULE,
 	},
 	.kobj_type = { .default_attrs = od_attributes },
-	.get_cpu_cdbs = get_cpu_cdbs,
 	.gov_dbs_timer = od_dbs_timer,
 	.alloc = od_alloc,
 	.free = od_free,
@@ -453,9 +447,6 @@ static struct dbs_governor od_dbs_gov =
 
 static void od_set_powersave_bias(unsigned int powersave_bias)
 {
-	struct cpufreq_policy *policy;
-	struct dbs_data *dbs_data;
-	struct od_dbs_tuners *od_tuners;
 	unsigned int cpu;
 	cpumask_t done;
 
@@ -464,21 +455,24 @@ static void od_set_powersave_bias(unsign
 
 	get_online_cpus();
 	for_each_online_cpu(cpu) {
+		struct cpufreq_policy *policy;
 		struct policy_dbs_info *policy_dbs;
+		struct dbs_data *dbs_data;
+		struct od_dbs_tuners *od_tuners;
 
 		if (cpumask_test_cpu(cpu, &done))
 			continue;
 
-		policy_dbs = per_cpu(od_cpu_dbs_info, cpu).cdbs.policy_dbs;
+		policy = cpufreq_cpu_get_raw(cpu);
+		if (!policy || policy->governor != CPU_FREQ_GOV_ONDEMAND)
+			continue;
+
+		policy_dbs = policy->governor_data;
 		if (!policy_dbs)
 			continue;
 
-		policy = policy_dbs->policy;
 		cpumask_or(&done, &done, policy->cpus);
 
-		if (policy->governor != CPU_FREQ_GOV_ONDEMAND)
-			continue;
-
 		dbs_data = policy_dbs->dbs_data;
 		od_tuners = dbs_data->tuners;
 		od_tuners->powersave_bias = default_powersave_bias;
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -32,10 +32,6 @@ static inline struct cs_policy_dbs_info
 #define DEF_SAMPLING_DOWN_FACTOR		(1)
 #define MAX_SAMPLING_DOWN_FACTOR		(10)
 
-static DEFINE_PER_CPU(struct cs_cpu_dbs_info_s, cs_cpu_dbs_info);
-
-static struct dbs_governor cs_dbs_gov;
-
 static inline unsigned int get_freq_target(struct cs_dbs_tuners *cs_tuners,
 					   struct cpufreq_policy *policy)
 {
@@ -193,7 +189,7 @@ static ssize_t store_ignore_nice_load(st
 	dbs_data->ignore_nice_load = input;
 
 	/* we need to re-evaluate prev_cpu_idle */
-	gov_update_cpu_data(&cs_dbs_gov, dbs_data);
+	gov_update_cpu_data(dbs_data);
 
 	return count;
 }
@@ -306,8 +302,6 @@ static void cs_start(struct cpufreq_poli
 	dbs_info->requested_freq = policy->cur;
 }
 
-define_get_cpu_dbs_routines(cs_cpu_dbs_info);
-
 static struct dbs_governor cs_dbs_gov = {
 	.gov = {
 		.name = "conservative",
@@ -316,7 +310,6 @@ static struct dbs_governor cs_dbs_gov =
 		.owner = THIS_MODULE,
 	},
 	.kobj_type = { .default_attrs = cs_attributes },
-	.get_cpu_cdbs = get_cpu_cdbs,
 	.gov_dbs_timer = cs_dbs_timer,
 	.alloc = cs_alloc,
 	.free = cs_free,
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -41,13 +41,6 @@
 /* Ondemand Sampling types */
 enum {OD_NORMAL_SAMPLE, OD_SUB_SAMPLE};
 
-/* create helper routines */
-#define define_get_cpu_dbs_routines(_dbs_info)				\
-static struct cpu_dbs_info *get_cpu_cdbs(int cpu)			\
-{									\
-	return &per_cpu(_dbs_info, cpu).cdbs;				\
-}
-
 /*
  * Abbreviations:
  * dbs: used as a shortform for demand based switching It helps to keep variable
@@ -155,14 +148,6 @@ struct cpu_dbs_info {
 	struct policy_dbs_info *policy_dbs;
 };
 
-struct od_cpu_dbs_info_s {
-	struct cpu_dbs_info cdbs;
-};
-
-struct cs_cpu_dbs_info_s {
-	struct cpu_dbs_info cdbs;
-};
-
 /* Per policy Governors sysfs tunables */
 struct od_dbs_tuners {
 	unsigned int powersave_bias;
@@ -184,7 +169,6 @@ struct dbs_governor {
 	 */
 	struct dbs_data *gdbs_data;
 
-	struct cpu_dbs_info *(*get_cpu_cdbs)(int cpu);
 	unsigned int (*gov_dbs_timer)(struct cpufreq_policy *policy);
 	struct policy_dbs_info *(*alloc)(void);
 	void (*free)(struct policy_dbs_info *policy_dbs);
@@ -213,5 +197,5 @@ void od_register_powersave_bias_handler(
 void od_unregister_powersave_bias_handler(void);
 ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
 			    size_t count);
-void gov_update_cpu_data(struct dbs_governor *gov, struct dbs_data *dbs_data);
+void gov_update_cpu_data(struct dbs_data *dbs_data);
 #endif /* _CPUFREQ_GOVERNOR_H */
