From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 3/7][Resend] cpufreq: governor: New data type for management part of dbs_data
Date: Tue, 08 Mar 2016 03:28:07 +0100
Message-ID: <1791259.hDOZkOUDyY@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <2409306.qzzMXcm4dm@vostro.rjw.lan> <4088601.C2vItRYpQn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51424 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753378AbcCHCxA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2016 21:53:00 -0500
In-Reply-To: <4088601.C2vItRYpQn@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In addition to fields representing governor tunables, struct dbs_data
contains some fields needed for the management of objects of that
type.  As it turns out, that part of struct dbs_data may be shared
with (future) governors that won't use the common code used by
"ondemand" and "conservative", so move it to a separate struct type
and modify the code using struct dbs_data to follow.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---

No changes from v2.

---
 drivers/cpufreq/cpufreq_conservative.c |   25 +++++----
 drivers/cpufreq/cpufreq_governor.c     |   90 ++++++++++++++++++++-------------
 drivers/cpufreq/cpufreq_governor.h     |   35 +++++++-----
 drivers/cpufreq/cpufreq_ondemand.c     |   29 ++++++----
 4 files changed, 107 insertions(+), 72 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -41,6 +41,13 @@
 /* Ondemand Sampling types */
 enum {OD_NORMAL_SAMPLE, OD_SUB_SAMPLE};
 
+struct gov_attr_set {
+	struct kobject kobj;
+	struct list_head policy_list;
+	struct mutex update_lock;
+	int usage_count;
+};
+
 /*
  * Abbreviations:
  * dbs: used as a shortform for demand based switching It helps to keep variable
@@ -52,7 +59,7 @@ enum {OD_NORMAL_SAMPLE, OD_SUB_SAMPLE};
 
 /* Governor demand based switching data (per-policy or global). */
 struct dbs_data {
-	int usage_count;
+	struct gov_attr_set attr_set;
 	void *tuners;
 	unsigned int min_sampling_rate;
 	unsigned int ignore_nice_load;
@@ -60,37 +67,35 @@ struct dbs_data {
 	unsigned int sampling_down_factor;
 	unsigned int up_threshold;
 	unsigned int io_is_busy;
-
-	struct kobject kobj;
-	struct list_head policy_dbs_list;
-	/*
-	 * Protect concurrent updates to governor tunables from sysfs,
-	 * policy_dbs_list and usage_count.
-	 */
-	struct mutex mutex;
 };
 
+static inline struct dbs_data *to_dbs_data(struct gov_attr_set *attr_set)
+{
+	return container_of(attr_set, struct dbs_data, attr_set);
+}
+
 /* Governor's specific attributes */
-struct dbs_data;
 struct governor_attr {
 	struct attribute attr;
-	ssize_t (*show)(struct dbs_data *dbs_data, char *buf);
-	ssize_t (*store)(struct dbs_data *dbs_data, const char *buf,
+	ssize_t (*show)(struct gov_attr_set *attr_set, char *buf);
+	ssize_t (*store)(struct gov_attr_set *attr_set, const char *buf,
 			 size_t count);
 };
 
 #define gov_show_one(_gov, file_name)					\
 static ssize_t show_##file_name						\
-(struct dbs_data *dbs_data, char *buf)					\
+(struct gov_attr_set *attr_set, char *buf)				\
 {									\
+	struct dbs_data *dbs_data = to_dbs_data(attr_set);		\
 	struct _gov##_dbs_tuners *tuners = dbs_data->tuners;		\
 	return sprintf(buf, "%u\n", tuners->file_name);			\
 }
 
 #define gov_show_one_common(file_name)					\
 static ssize_t show_##file_name						\
-(struct dbs_data *dbs_data, char *buf)					\
+(struct gov_attr_set *attr_set, char *buf)				\
 {									\
+	struct dbs_data *dbs_data = to_dbs_data(attr_set);		\
 	return sprintf(buf, "%u\n", dbs_data->file_name);		\
 }
 
@@ -184,7 +189,7 @@ void od_register_powersave_bias_handler(
 		(struct cpufreq_policy *, unsigned int, unsigned int),
 		unsigned int powersave_bias);
 void od_unregister_powersave_bias_handler(void);
-ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
+ssize_t store_sampling_rate(struct gov_attr_set *attr_set, const char *buf,
 			    size_t count);
 void gov_update_cpu_data(struct dbs_data *dbs_data);
 #endif /* _CPUFREQ_GOVERNOR_H */
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -43,9 +43,10 @@ static DEFINE_MUTEX(gov_dbs_data_mutex);
  * This must be called with dbs_data->mutex held, otherwise traversing
  * policy_dbs_list isn't safe.
  */
-ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
+ssize_t store_sampling_rate(struct gov_attr_set *attr_set, const char *buf,
 			    size_t count)
 {
+	struct dbs_data *dbs_data = to_dbs_data(attr_set);
 	struct policy_dbs_info *policy_dbs;
 	unsigned int rate;
 	int ret;
@@ -59,7 +60,7 @@ ssize_t store_sampling_rate(struct dbs_d
 	 * We are operating under dbs_data->mutex and so the list and its
 	 * entries can't be freed concurrently.
 	 */
-	list_for_each_entry(policy_dbs, &dbs_data->policy_dbs_list, list) {
+	list_for_each_entry(policy_dbs, &attr_set->policy_list, list) {
 		mutex_lock(&policy_dbs->timer_mutex);
 		/*
 		 * On 32-bit architectures this may race with the
@@ -96,7 +97,7 @@ void gov_update_cpu_data(struct dbs_data
 {
 	struct policy_dbs_info *policy_dbs;
 
-	list_for_each_entry(policy_dbs, &dbs_data->policy_dbs_list, list) {
+	list_for_each_entry(policy_dbs, &dbs_data->attr_set.policy_list, list) {
 		unsigned int j;
 
 		for_each_cpu(j, policy_dbs->policy->cpus) {
@@ -111,9 +112,9 @@ void gov_update_cpu_data(struct dbs_data
 }
 EXPORT_SYMBOL_GPL(gov_update_cpu_data);
 
-static inline struct dbs_data *to_dbs_data(struct kobject *kobj)
+static inline struct gov_attr_set *to_gov_attr_set(struct kobject *kobj)
 {
-	return container_of(kobj, struct dbs_data, kobj);
+	return container_of(kobj, struct gov_attr_set, kobj);
 }
 
 static inline struct governor_attr *to_gov_attr(struct attribute *attr)
@@ -124,25 +125,24 @@ static inline struct governor_attr *to_g
 static ssize_t governor_show(struct kobject *kobj, struct attribute *attr,
 			     char *buf)
 {
-	struct dbs_data *dbs_data = to_dbs_data(kobj);
 	struct governor_attr *gattr = to_gov_attr(attr);
 
-	return gattr->show(dbs_data, buf);
+	return gattr->show(to_gov_attr_set(kobj), buf);
 }
 
 static ssize_t governor_store(struct kobject *kobj, struct attribute *attr,
 			      const char *buf, size_t count)
 {
-	struct dbs_data *dbs_data = to_dbs_data(kobj);
+	struct gov_attr_set *attr_set = to_gov_attr_set(kobj);
 	struct governor_attr *gattr = to_gov_attr(attr);
 	int ret = -EBUSY;
 
-	mutex_lock(&dbs_data->mutex);
+	mutex_lock(&attr_set->update_lock);
 
-	if (dbs_data->usage_count)
-		ret = gattr->store(dbs_data, buf, count);
+	if (attr_set->usage_count)
+		ret = gattr->store(attr_set, buf, count);
 
-	mutex_unlock(&dbs_data->mutex);
+	mutex_unlock(&attr_set->update_lock);
 
 	return ret;
 }
@@ -424,6 +424,41 @@ static void free_policy_dbs_info(struct
 	gov->free(policy_dbs);
 }
 
+static void gov_attr_set_init(struct gov_attr_set *attr_set,
+			      struct list_head *list_node)
+{
+	INIT_LIST_HEAD(&attr_set->policy_list);
+	mutex_init(&attr_set->update_lock);
+	attr_set->usage_count = 1;
+	list_add(list_node, &attr_set->policy_list);
+}
+
+static void gov_attr_set_get(struct gov_attr_set *attr_set,
+			     struct list_head *list_node)
+{
+	mutex_lock(&attr_set->update_lock);
+	attr_set->usage_count++;
+	list_add(list_node, &attr_set->policy_list);
+	mutex_unlock(&attr_set->update_lock);
+}
+
+static unsigned int gov_attr_set_put(struct gov_attr_set *attr_set,
+				     struct list_head *list_node)
+{
+	unsigned int count;
+
+	mutex_lock(&attr_set->update_lock);
+	list_del(list_node);
+	count = --attr_set->usage_count;
+	mutex_unlock(&attr_set->update_lock);
+	if (count)
+		return count;
+
+	kobject_put(&attr_set->kobj);
+	mutex_destroy(&attr_set->update_lock);
+	return 0;
+}
+
 static int cpufreq_governor_init(struct cpufreq_policy *policy)
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
@@ -452,10 +487,7 @@ static int cpufreq_governor_init(struct
 		policy_dbs->dbs_data = dbs_data;
 		policy->governor_data = policy_dbs;
 
-		mutex_lock(&dbs_data->mutex);
-		dbs_data->usage_count++;
-		list_add(&policy_dbs->list, &dbs_data->policy_dbs_list);
-		mutex_unlock(&dbs_data->mutex);
+		gov_attr_set_get(&dbs_data->attr_set, &policy_dbs->list);
 		goto out;
 	}
 
@@ -465,8 +497,7 @@ static int cpufreq_governor_init(struct
 		goto free_policy_dbs_info;
 	}
 
-	INIT_LIST_HEAD(&dbs_data->policy_dbs_list);
-	mutex_init(&dbs_data->mutex);
+	gov_attr_set_init(&dbs_data->attr_set, &policy_dbs->list);
 
 	ret = gov->init(dbs_data, !policy->governor->initialized);
 	if (ret)
@@ -486,14 +517,11 @@ static int cpufreq_governor_init(struct
 	if (!have_governor_per_policy())
 		gov->gdbs_data = dbs_data;
 
-	policy->governor_data = policy_dbs;
-
 	policy_dbs->dbs_data = dbs_data;
-	dbs_data->usage_count = 1;
-	list_add(&policy_dbs->list, &dbs_data->policy_dbs_list);
+	policy->governor_data = policy_dbs;
 
 	gov->kobj_type.sysfs_ops = &governor_sysfs_ops;
-	ret = kobject_init_and_add(&dbs_data->kobj, &gov->kobj_type,
+	ret = kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->kobj_type,
 				   get_governor_parent_kobj(policy),
 				   "%s", gov->gov.name);
 	if (!ret)
@@ -522,29 +550,21 @@ static int cpufreq_governor_exit(struct
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
-	int count;
+	unsigned int count;
 
 	/* Protect gov->gdbs_data against concurrent updates. */
 	mutex_lock(&gov_dbs_data_mutex);
 
-	mutex_lock(&dbs_data->mutex);
-	list_del(&policy_dbs->list);
-	count = --dbs_data->usage_count;
-	mutex_unlock(&dbs_data->mutex);
+	count = gov_attr_set_put(&dbs_data->attr_set, &policy_dbs->list);
 
-	if (!count) {
-		kobject_put(&dbs_data->kobj);
-
-		policy->governor_data = NULL;
+	policy->governor_data = NULL;
 
+	if (!count) {
 		if (!have_governor_per_policy())
 			gov->gdbs_data = NULL;
 
 		gov->exit(dbs_data, policy->governor->initialized == 1);
-		mutex_destroy(&dbs_data->mutex);
 		kfree(dbs_data);
-	} else {
-		policy->governor_data = NULL;
 	}
 
 	free_policy_dbs_info(policy_dbs, gov);
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -207,9 +207,10 @@ static unsigned int od_dbs_timer(struct
 /************************** sysfs interface ************************/
 static struct dbs_governor od_dbs_gov;
 
-static ssize_t store_io_is_busy(struct dbs_data *dbs_data, const char *buf,
-		size_t count)
+static ssize_t store_io_is_busy(struct gov_attr_set *attr_set, const char *buf,
+				size_t count)
 {
+	struct dbs_data *dbs_data = to_dbs_data(attr_set);
 	unsigned int input;
 	int ret;
 
@@ -224,9 +225,10 @@ static ssize_t store_io_is_busy(struct d
 	return count;
 }
 
-static ssize_t store_up_threshold(struct dbs_data *dbs_data, const char *buf,
-		size_t count)
+static ssize_t store_up_threshold(struct gov_attr_set *attr_set,
+				  const char *buf, size_t count)
 {
+	struct dbs_data *dbs_data = to_dbs_data(attr_set);
 	unsigned int input;
 	int ret;
 	ret = sscanf(buf, "%u", &input);
@@ -240,9 +242,10 @@ static ssize_t store_up_threshold(struct
 	return count;
 }
 
-static ssize_t store_sampling_down_factor(struct dbs_data *dbs_data,
-		const char *buf, size_t count)
+static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
+					  const char *buf, size_t count)
 {
+	struct dbs_data *dbs_data = to_dbs_data(attr_set);
 	struct policy_dbs_info *policy_dbs;
 	unsigned int input;
 	int ret;
@@ -254,7 +257,7 @@ static ssize_t store_sampling_down_facto
 	dbs_data->sampling_down_factor = input;
 
 	/* Reset down sampling multiplier in case it was active */
-	list_for_each_entry(policy_dbs, &dbs_data->policy_dbs_list, list) {
+	list_for_each_entry(policy_dbs, &attr_set->policy_list, list) {
 		/*
 		 * Doing this without locking might lead to using different
 		 * rate_mult values in od_update() and od_dbs_timer().
@@ -267,9 +270,10 @@ static ssize_t store_sampling_down_facto
 	return count;
 }
 
-static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
-		const char *buf, size_t count)
+static ssize_t store_ignore_nice_load(struct gov_attr_set *attr_set,
+				      const char *buf, size_t count)
 {
+	struct dbs_data *dbs_data = to_dbs_data(attr_set);
 	unsigned int input;
 	int ret;
 
@@ -291,9 +295,10 @@ static ssize_t store_ignore_nice_load(st
 	return count;
 }
 
-static ssize_t store_powersave_bias(struct dbs_data *dbs_data, const char *buf,
-		size_t count)
+static ssize_t store_powersave_bias(struct gov_attr_set *attr_set,
+				    const char *buf, size_t count)
 {
+	struct dbs_data *dbs_data = to_dbs_data(attr_set);
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	struct policy_dbs_info *policy_dbs;
 	unsigned int input;
@@ -308,7 +313,7 @@ static ssize_t store_powersave_bias(stru
 
 	od_tuners->powersave_bias = input;
 
-	list_for_each_entry(policy_dbs, &dbs_data->policy_dbs_list, list)
+	list_for_each_entry(policy_dbs, &attr_set->policy_list, list)
 		ondemand_powersave_bias_init(policy_dbs->policy);
 
 	return count;
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -129,9 +129,10 @@ static struct notifier_block cs_cpufreq_
 /************************** sysfs interface ************************/
 static struct dbs_governor cs_dbs_gov;
 
-static ssize_t store_sampling_down_factor(struct dbs_data *dbs_data,
-		const char *buf, size_t count)
+static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
+					  const char *buf, size_t count)
 {
+	struct dbs_data *dbs_data = to_dbs_data(attr_set);
 	unsigned int input;
 	int ret;
 	ret = sscanf(buf, "%u", &input);
@@ -143,9 +144,10 @@ static ssize_t store_sampling_down_facto
 	return count;
 }
 
-static ssize_t store_up_threshold(struct dbs_data *dbs_data, const char *buf,
-		size_t count)
+static ssize_t store_up_threshold(struct gov_attr_set *attr_set,
+				  const char *buf, size_t count)
 {
+	struct dbs_data *dbs_data = to_dbs_data(attr_set);
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int input;
 	int ret;
@@ -158,9 +160,10 @@ static ssize_t store_up_threshold(struct
 	return count;
 }
 
-static ssize_t store_down_threshold(struct dbs_data *dbs_data, const char *buf,
-		size_t count)
+static ssize_t store_down_threshold(struct gov_attr_set *attr_set,
+				    const char *buf, size_t count)
 {
+	struct dbs_data *dbs_data = to_dbs_data(attr_set);
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int input;
 	int ret;
@@ -175,9 +178,10 @@ static ssize_t store_down_threshold(stru
 	return count;
 }
 
-static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
-		const char *buf, size_t count)
+static ssize_t store_ignore_nice_load(struct gov_attr_set *attr_set,
+				      const char *buf, size_t count)
 {
+	struct dbs_data *dbs_data = to_dbs_data(attr_set);
 	unsigned int input;
 	int ret;
 
@@ -199,9 +203,10 @@ static ssize_t store_ignore_nice_load(st
 	return count;
 }
 
-static ssize_t store_freq_step(struct dbs_data *dbs_data, const char *buf,
-		size_t count)
+static ssize_t store_freq_step(struct gov_attr_set *attr_set, const char *buf,
+			       size_t count)
 {
+	struct dbs_data *dbs_data = to_dbs_data(attr_set);
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int input;
 	int ret;
