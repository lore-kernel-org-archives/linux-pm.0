From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 8/12] cpufreq: governor: Make governor private data per-policy
Date: Thu, 18 Feb 2016 02:30:30 +0100
Message-ID: <1954429.fugFc6iA7T@vostro.rjw.lan>
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

Some fields in struct od_cpu_dbs_info_s and struct cs_cpu_dbs_info_s
are only used for a limited set of CPUs.  Namely, if a policy is
shared between multiple CPUs, those fields will only be used for one
of them (policy->cpu).  This means that they really are per-policy
rather than per-CPU and holding room for them in per-CPU data
structures is generally wasteful.  Also moving those fields into
per-policy data structures will allow some significant simplifications
to be made going forward.

For this reason, introduce struct cs_policy_dbs_info and
struct od_policy_dbs_info to hold those fields.  Define each of the
new structures as an extension of struct policy_dbs_info (such that
struct policy_dbs_info is embedded in each of them) and introduce
new ->alloc and ->free governor callbacks to allocate and free
those structures, respectively, such that ->alloc() will return
a pointer to the struct policy_dbs_info embedded in the allocated
data structure and ->free() will take that pointer as its argument.

With that, modify the code accessing the data fields in question
in per-CPU data objects to look for them in the new structures
via the struct policy_dbs_info pointer available to it and drop
them from struct od_cpu_dbs_info_s and struct cs_cpu_dbs_info_s.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_conservative.c |   34 ++++++++++++++++++++++--
 drivers/cpufreq/cpufreq_governor.c     |    7 ++---
 drivers/cpufreq/cpufreq_governor.h     |    9 +-----
 drivers/cpufreq/cpufreq_ondemand.c     |   45 ++++++++++++++++++++++++++-------
 4 files changed, 71 insertions(+), 24 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -14,6 +14,17 @@
 #include <linux/slab.h>
 #include "cpufreq_governor.h"
 
+struct cs_policy_dbs_info {
+	struct policy_dbs_info policy_dbs;
+	unsigned int down_skip;
+	unsigned int requested_freq;
+};
+
+static inline struct cs_policy_dbs_info *to_dbs_info(struct policy_dbs_info *policy_dbs)
+{
+	return container_of(policy_dbs, struct cs_policy_dbs_info, policy_dbs);
+}
+
 /* Conservative governor macros */
 #define DEF_FREQUENCY_UP_THRESHOLD		(80)
 #define DEF_FREQUENCY_DOWN_THRESHOLD		(20)
@@ -48,8 +59,8 @@ static inline unsigned int get_freq_targ
  */
 static unsigned int cs_dbs_timer(struct cpufreq_policy *policy)
 {
-	struct cs_cpu_dbs_info_s *dbs_info = &per_cpu(cs_cpu_dbs_info, policy->cpu);
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy_dbs);
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int load = dbs_update(policy);
@@ -238,6 +249,19 @@ static struct attribute *cs_attributes[]
 
 /************************** sysfs end ************************/
 
+static struct policy_dbs_info *cs_alloc(void)
+{
+	struct cs_policy_dbs_info *dbs_info;
+
+	dbs_info = kzalloc(sizeof(*dbs_info), GFP_KERNEL);
+	return dbs_info ? &dbs_info->policy_dbs : NULL;
+}
+
+static void cs_free(struct policy_dbs_info *policy_dbs)
+{
+	kfree(to_dbs_info(policy_dbs));
+}
+
 static int cs_init(struct dbs_data *dbs_data, bool notify)
 {
 	struct cs_dbs_tuners *tuners;
@@ -276,7 +300,7 @@ static void cs_exit(struct dbs_data *dbs
 
 static void cs_start(struct cpufreq_policy *policy)
 {
-	struct cs_cpu_dbs_info_s *dbs_info = &per_cpu(cs_cpu_dbs_info, policy->cpu);
+	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
 
 	dbs_info->down_skip = 0;
 	dbs_info->requested_freq = policy->cur;
@@ -294,6 +318,8 @@ static struct dbs_governor cs_dbs_gov =
 	.kobj_type = { .default_attrs = cs_attributes },
 	.get_cpu_cdbs = get_cpu_cdbs,
 	.gov_dbs_timer = cs_dbs_timer,
+	.alloc = cs_alloc,
+	.free = cs_free,
 	.init = cs_init,
 	.exit = cs_exit,
 	.start = cs_start,
@@ -305,9 +331,8 @@ static int dbs_cpufreq_notifier(struct n
 				void *data)
 {
 	struct cpufreq_freqs *freq = data;
-	struct cs_cpu_dbs_info_s *dbs_info =
-					&per_cpu(cs_cpu_dbs_info, freq->cpu);
 	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(freq->cpu);
+	struct cs_policy_dbs_info *dbs_info;
 
 	if (!policy)
 		return 0;
@@ -316,6 +341,7 @@ static int dbs_cpufreq_notifier(struct n
 	if (policy->governor != CPU_FREQ_GOV_CONSERVATIVE)
 		return 0;
 
+	dbs_info = to_dbs_info(policy->governor_data);
 	/*
 	 * we only care if our internally tracked freq moves outside the 'valid'
 	 * ranges of frequency available to us otherwise we do not change it
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -157,17 +157,10 @@ struct cpu_dbs_info {
 
 struct od_cpu_dbs_info_s {
 	struct cpu_dbs_info cdbs;
-	struct cpufreq_frequency_table *freq_table;
-	unsigned int freq_lo;
-	unsigned int freq_lo_delay_us;
-	unsigned int freq_hi_delay_us;
-	unsigned int sample_type:1;
 };
 
 struct cs_cpu_dbs_info_s {
 	struct cpu_dbs_info cdbs;
-	unsigned int down_skip;
-	unsigned int requested_freq;
 };
 
 /* Per policy Governors sysfs tunables */
@@ -193,6 +186,8 @@ struct dbs_governor {
 
 	struct cpu_dbs_info *(*get_cpu_cdbs)(int cpu);
 	unsigned int (*gov_dbs_timer)(struct cpufreq_policy *policy);
+	struct policy_dbs_info *(*alloc)(void);
+	void (*free)(struct policy_dbs_info *policy_dbs);
 	int (*init)(struct dbs_data *dbs_data, bool notify);
 	void (*exit)(struct dbs_data *dbs_data, bool notify);
 	void (*start)(struct cpufreq_policy *policy);
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -18,6 +18,20 @@
 #include <linux/tick.h>
 #include "cpufreq_governor.h"
 
+struct od_policy_dbs_info {
+	struct policy_dbs_info policy_dbs;
+	struct cpufreq_frequency_table *freq_table;
+	unsigned int freq_lo;
+	unsigned int freq_lo_delay_us;
+	unsigned int freq_hi_delay_us;
+	unsigned int sample_type:1;
+};
+
+static inline struct od_policy_dbs_info *to_dbs_info(struct policy_dbs_info *policy_dbs)
+{
+	return container_of(policy_dbs, struct od_policy_dbs_info, policy_dbs);
+}
+
 /* On-demand governor macros */
 #define DEF_FREQUENCY_UP_THRESHOLD		(80)
 #define DEF_SAMPLING_DOWN_FACTOR		(1)
@@ -69,9 +83,8 @@ static unsigned int generic_powersave_bi
 	unsigned int freq_hi, freq_lo;
 	unsigned int index = 0;
 	unsigned int delay_hi_us;
-	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info,
-						   policy->cpu);
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct od_policy_dbs_info *dbs_info = to_dbs_info(policy_dbs);
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 
@@ -114,10 +127,9 @@ static unsigned int generic_powersave_bi
 
 static void ondemand_powersave_bias_init(struct cpufreq_policy *policy)
 {
-	unsigned int cpu = policy->cpu;
-	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
+	struct od_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
 
-	dbs_info->freq_table = cpufreq_frequency_get_table(cpu);
+	dbs_info->freq_table = cpufreq_frequency_get_table(policy->cpu);
 	dbs_info->freq_lo = 0;
 }
 
@@ -144,8 +156,8 @@ static void dbs_freq_increase(struct cpu
  */
 static void od_update(struct cpufreq_policy *policy)
 {
-	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, policy->cpu);
-	struct policy_dbs_info *policy_dbs = dbs_info->cdbs.policy_dbs;
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct od_policy_dbs_info *dbs_info = to_dbs_info(policy_dbs);
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	unsigned int load = dbs_update(policy);
@@ -182,7 +194,7 @@ static unsigned int od_dbs_timer(struct
 {
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
-	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, policy->cpu);
+	struct od_policy_dbs_info *dbs_info = to_dbs_info(policy_dbs);
 	int sample_type = dbs_info->sample_type;
 
 	/* Common NORMAL_SAMPLE setup */
@@ -347,6 +359,19 @@ static struct attribute *od_attributes[]
 
 /************************** sysfs end ************************/
 
+static struct policy_dbs_info *od_alloc(void)
+{
+	struct od_policy_dbs_info *dbs_info;
+
+	dbs_info = kzalloc(sizeof(*dbs_info), GFP_KERNEL);
+	return dbs_info ? &dbs_info->policy_dbs : NULL;
+}
+
+static void od_free(struct policy_dbs_info *policy_dbs)
+{
+	kfree(to_dbs_info(policy_dbs));
+}
+
 static int od_init(struct dbs_data *dbs_data, bool notify)
 {
 	struct od_dbs_tuners *tuners;
@@ -395,7 +420,7 @@ static void od_exit(struct dbs_data *dbs
 
 static void od_start(struct cpufreq_policy *policy)
 {
-	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, policy->cpu);
+	struct od_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
 
 	dbs_info->sample_type = OD_NORMAL_SAMPLE;
 	ondemand_powersave_bias_init(policy);
@@ -417,6 +442,8 @@ static struct dbs_governor od_dbs_gov =
 	.kobj_type = { .default_attrs = od_attributes },
 	.get_cpu_cdbs = get_cpu_cdbs,
 	.gov_dbs_timer = od_dbs_timer,
+	.alloc = od_alloc,
+	.free = od_free,
 	.init = od_init,
 	.exit = od_exit,
 	.start = od_start,
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -385,8 +385,8 @@ static struct policy_dbs_info *alloc_pol
 	struct policy_dbs_info *policy_dbs;
 	int j;
 
-	/* Allocate memory for the common information for policy->cpus */
-	policy_dbs = kzalloc(sizeof(*policy_dbs), GFP_KERNEL);
+	/* Allocate memory for per-policy governor data. */
+	policy_dbs = gov->alloc();
 	if (!policy_dbs)
 		return NULL;
 
@@ -421,7 +421,7 @@ static void free_policy_dbs_info(struct
 		j_cdbs->policy_dbs = NULL;
 		j_cdbs->update_util.func = NULL;
 	}
-	kfree(policy_dbs);
+	gov->free(policy_dbs);
 }
 
 static int cpufreq_governor_init(struct cpufreq_policy *policy)
@@ -582,7 +582,6 @@ static int cpufreq_governor_start(struct
 static int cpufreq_governor_stop(struct cpufreq_policy *policy)
 {
 	gov_cancel_work(policy);
-
 	return 0;
 }
 
