From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 3/6] cpufreq: governor: New sysfs show/store callbacks for governor tunables
Date: Tue,  9 Feb 2016 09:01:33 +0530
Message-ID: <a8c04722e4e4a79670ed9a1de08471a35d12a042.1454988295.git.viresh.kumar@linaro.org>
References: <cover.1454988295.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454988295.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454988295.git.viresh.kumar@linaro.org>
References: <cover.1454988295.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The ondemand and conservative governors use the global-attr or freq-attr
structures to represent sysfs attributes corresponding to their tunables
(which of them is actually used depends on whether or not different
policy objects can use the same governor with different tunables at the
same time and, consequently, on where those attributes are located in
sysfs).

Unfortunately, in the freq-attr case, the standard cpufreq show/store
sysfs attribute callbacks are applied to the governor tunable attributes
and they always acquire the policy->rwsem lock before carrying out the
operation.  That may lead to an ABBA deadlock if governor tunable
attributes are removed under policy->rwsem while one of them is being
accessed concurrently (if sysfs attributes removal wins the race, it
will wait for the access to complete with policy->rwsem held while the
attribute callback will block on policy->rwsem indefinitely).

We attempted to address this issue by dropping policy->rwsem around
governor tunable attributes removal (that is, around invocations of the
->governor callback with the event arg equal to CPUFREQ_GOV_POLICY_EXIT)
in cpufreq_set_policy(), but that opened up race conditions that had not
been possible with policy->rwsem held all the time.  Therefore
policy->rwsem cannot be dropped in cpufreq_set_policy() at any point,
but the deadlock situation described above must be avoided too.

To that end, use the observation that in principle governor tunables may
be represented by the same data type regardless of whether the governor
is system-wide or per-policy and introduce a new structure, struct
governor_attr, for representing them and new corresponding macros for
creating show/store sysfs callbacks for them.  Also make their parent
kobject use a new kobject type whose default show/store callbacks are
not related to the standard core cpufreq ones in any way (and they don't
acquire policy->rwsem in particular).

[ Rafael: Written changelog ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Juri Lelli <juri.lelli@arm.com>
Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 72 ++++++++++++----------------------
 drivers/cpufreq/cpufreq_governor.c     | 68 ++++++++++++++++++++++++++++----
 drivers/cpufreq/cpufreq_governor.h     | 39 +++++++++++++++++-
 drivers/cpufreq/cpufreq_ondemand.c     | 72 ++++++++++++----------------------
 4 files changed, 147 insertions(+), 104 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 4f640b028c94..ed081dbce00c 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -235,54 +235,33 @@ static ssize_t store_freq_step(struct dbs_data *dbs_data, const char *buf,
 	return count;
 }
 
-show_store_one(cs, down_threshold);
-show_store_one(cs, freq_step);
-show_store_one_common(cs, sampling_rate);
-show_store_one_common(cs, sampling_down_factor);
-show_store_one_common(cs, up_threshold);
-show_store_one_common(cs, ignore_nice_load);
-show_one_common(cs, min_sampling_rate);
-
-gov_sys_pol_attr_rw(sampling_rate);
-gov_sys_pol_attr_rw(sampling_down_factor);
-gov_sys_pol_attr_rw(up_threshold);
-gov_sys_pol_attr_rw(down_threshold);
-gov_sys_pol_attr_rw(ignore_nice_load);
-gov_sys_pol_attr_rw(freq_step);
-gov_sys_pol_attr_ro(min_sampling_rate);
-
-static struct attribute *dbs_attributes_gov_sys[] = {
-	&min_sampling_rate_gov_sys.attr,
-	&sampling_rate_gov_sys.attr,
-	&sampling_down_factor_gov_sys.attr,
-	&up_threshold_gov_sys.attr,
-	&down_threshold_gov_sys.attr,
-	&ignore_nice_load_gov_sys.attr,
-	&freq_step_gov_sys.attr,
+gov_show_one_common(sampling_rate);
+gov_show_one_common(sampling_down_factor);
+gov_show_one_common(up_threshold);
+gov_show_one_common(ignore_nice_load);
+gov_show_one_common(min_sampling_rate);
+gov_show_one(cs, down_threshold);
+gov_show_one(cs, freq_step);
+
+gov_attr_rw(sampling_rate);
+gov_attr_rw(sampling_down_factor);
+gov_attr_rw(up_threshold);
+gov_attr_rw(ignore_nice_load);
+gov_attr_ro(min_sampling_rate);
+gov_attr_rw(down_threshold);
+gov_attr_rw(freq_step);
+
+static struct attribute *cs_attributes[] = {
+	&min_sampling_rate.attr,
+	&sampling_rate.attr,
+	&sampling_down_factor.attr,
+	&up_threshold.attr,
+	&down_threshold.attr,
+	&ignore_nice_load.attr,
+	&freq_step.attr,
 	NULL
 };
 
-static struct attribute_group cs_attr_group_gov_sys = {
-	.attrs = dbs_attributes_gov_sys,
-	.name = "conservative",
-};
-
-static struct attribute *dbs_attributes_gov_pol[] = {
-	&min_sampling_rate_gov_pol.attr,
-	&sampling_rate_gov_pol.attr,
-	&sampling_down_factor_gov_pol.attr,
-	&up_threshold_gov_pol.attr,
-	&down_threshold_gov_pol.attr,
-	&ignore_nice_load_gov_pol.attr,
-	&freq_step_gov_pol.attr,
-	NULL
-};
-
-static struct attribute_group cs_attr_group_gov_pol = {
-	.attrs = dbs_attributes_gov_pol,
-	.name = "conservative",
-};
-
 /************************** sysfs end ************************/
 
 static int cs_init(struct dbs_data *dbs_data, bool notify)
@@ -331,8 +310,7 @@ static struct dbs_governor cs_dbs_gov = {
 		.owner = THIS_MODULE,
 	},
 	.governor = GOV_CONSERVATIVE,
-	.attr_group_gov_sys = &cs_attr_group_gov_sys,
-	.attr_group_gov_pol = &cs_attr_group_gov_pol,
+	.kobj_type = { .default_attrs = cs_attributes },
 	.get_cpu_cdbs = get_cpu_cdbs,
 	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
 	.gov_dbs_timer = cs_dbs_timer,
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index b168a32cc8f0..bba9d3fb8103 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -25,12 +25,58 @@
 DEFINE_MUTEX(dbs_data_mutex);
 EXPORT_SYMBOL_GPL(dbs_data_mutex);
 
-static struct attribute_group *get_sysfs_attr(struct dbs_governor *gov)
+static inline struct dbs_data *to_dbs_data(struct kobject *kobj)
 {
-	return have_governor_per_policy() ?
-		gov->attr_group_gov_pol : gov->attr_group_gov_sys;
+	return container_of(kobj, struct dbs_data, kobj);
 }
 
+static inline struct governor_attr *to_gov_attr(struct attribute *attr)
+{
+	return container_of(attr, struct governor_attr, attr);
+}
+
+static ssize_t governor_show(struct kobject *kobj, struct attribute *attr,
+			     char *buf)
+{
+	struct dbs_data *dbs_data = to_dbs_data(kobj);
+	struct governor_attr *gattr = to_gov_attr(attr);
+	int ret = -EIO;
+
+	if (gattr->show)
+		ret = gattr->show(dbs_data, buf);
+
+	return ret;
+}
+
+static ssize_t governor_store(struct kobject *kobj, struct attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct dbs_data *dbs_data = to_dbs_data(kobj);
+	struct governor_attr *gattr = to_gov_attr(attr);
+	int ret = -EIO;
+
+	mutex_lock(&dbs_data->mutex);
+
+	if (gattr->store)
+		ret = gattr->store(dbs_data, buf, count);
+
+	mutex_unlock(&dbs_data->mutex);
+
+	return ret;
+}
+
+/*
+ * Sysfs Ops for accessing governor attributes.
+ *
+ * All show/store invocations for governor specific sysfs attributes, will first
+ * call the below show/store callbacks and the attribute specific callback will
+ * be called from within it.
+ */
+static const struct sysfs_ops governor_sysfs_ops = {
+	.show	= governor_show,
+	.store	= governor_store,
+};
+
 void dbs_check_cpu(struct cpufreq_policy *policy)
 {
 	int cpu = policy->cpu;
@@ -351,6 +397,7 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
 	}
 
 	dbs_data->usage_count = 1;
+	mutex_init(&dbs_data->mutex);
 
 	ret = gov->init(dbs_data, !policy->governor->initialized);
 	if (ret)
@@ -373,10 +420,15 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
 	policy_dbs->dbs_data = dbs_data;
 	policy->governor_data = policy_dbs;
 
-	ret = sysfs_create_group(get_governor_parent_kobj(policy),
-				 get_sysfs_attr(gov));
-	if (ret)
+	gov->kobj_type.sysfs_ops = &governor_sysfs_ops;
+	ret = kobject_init_and_add(&dbs_data->kobj, &gov->kobj_type,
+				   get_governor_parent_kobj(policy),
+				   gov->gov.name);
+	if (ret) {
+		pr_err("cpufreq: Governor initialization failed (dbs_data kobject initialization error %d)\n",
+		       ret);
 		goto reset_gdbs_data;
+	}
 
 	return 0;
 
@@ -404,8 +456,7 @@ static int cpufreq_governor_exit(struct cpufreq_policy *policy)
 		return -EBUSY;
 
 	if (!--dbs_data->usage_count) {
-		sysfs_remove_group(get_governor_parent_kobj(policy),
-				   get_sysfs_attr(gov));
+		kobject_put(&dbs_data->kobj);
 
 		policy->governor_data = NULL;
 
@@ -413,6 +464,7 @@ static int cpufreq_governor_exit(struct cpufreq_policy *policy)
 			gov->gdbs_data = NULL;
 
 		gov->exit(dbs_data, policy->governor->initialized == 1);
+		mutex_destroy(&dbs_data->mutex);
 		kfree(dbs_data);
 	} else {
 		policy->governor_data = NULL;
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 17d2c4282dcd..32b131bb2081 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -160,8 +160,44 @@ struct dbs_data {
 	unsigned int sampling_rate;
 	unsigned int sampling_down_factor;
 	unsigned int up_threshold;
+
+	struct kobject kobj;
+	/* Protect concurrent updates to governor tunables from sysfs */
+	struct mutex mutex;
+};
+
+/* Governor's specific attributes */
+struct dbs_data;
+struct governor_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct dbs_data *dbs_data, char *buf);
+	ssize_t (*store)(struct dbs_data *dbs_data, const char *buf,
+			 size_t count);
 };
 
+#define gov_show_one(_gov, file_name)					\
+static ssize_t show_##file_name						\
+(struct dbs_data *dbs_data, char *buf)					\
+{									\
+	struct _gov##_dbs_tuners *tuners = dbs_data->tuners;		\
+	return sprintf(buf, "%u\n", tuners->file_name);			\
+}
+
+#define gov_show_one_common(file_name)					\
+static ssize_t show_##file_name						\
+(struct dbs_data *dbs_data, char *buf)					\
+{									\
+	return sprintf(buf, "%u\n", dbs_data->file_name);		\
+}
+
+#define gov_attr_ro(_name)						\
+static struct governor_attr _name =					\
+__ATTR(_name, 0444, show_##_name, NULL)
+
+#define gov_attr_rw(_name)						\
+static struct governor_attr _name =					\
+__ATTR(_name, 0644, show_##_name, store_##_name)
+
 /* Common to all CPUs of a policy */
 struct policy_dbs_info {
 	struct cpufreq_policy *policy;
@@ -236,8 +272,7 @@ struct dbs_governor {
 	#define GOV_ONDEMAND		0
 	#define GOV_CONSERVATIVE	1
 	int governor;
-	struct attribute_group *attr_group_gov_sys; /* one governor - system */
-	struct attribute_group *attr_group_gov_pol; /* one governor - policy */
+	struct kobj_type kobj_type;
 
 	/*
 	 * Common data for platforms that don't set
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 13c64b662fa1..e36792f60348 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -432,54 +432,33 @@ static ssize_t store_powersave_bias(struct dbs_data *dbs_data, const char *buf,
 	return count;
 }
 
-show_store_one(od, io_is_busy);
-show_store_one(od, powersave_bias);
-show_store_one_common(od, sampling_rate);
-show_store_one_common(od, up_threshold);
-show_store_one_common(od, sampling_down_factor);
-show_store_one_common(od, ignore_nice_load);
-show_one_common(od, min_sampling_rate);
-
-gov_sys_pol_attr_rw(sampling_rate);
-gov_sys_pol_attr_rw(io_is_busy);
-gov_sys_pol_attr_rw(up_threshold);
-gov_sys_pol_attr_rw(sampling_down_factor);
-gov_sys_pol_attr_rw(ignore_nice_load);
-gov_sys_pol_attr_rw(powersave_bias);
-gov_sys_pol_attr_ro(min_sampling_rate);
-
-static struct attribute *dbs_attributes_gov_sys[] = {
-	&min_sampling_rate_gov_sys.attr,
-	&sampling_rate_gov_sys.attr,
-	&up_threshold_gov_sys.attr,
-	&sampling_down_factor_gov_sys.attr,
-	&ignore_nice_load_gov_sys.attr,
-	&powersave_bias_gov_sys.attr,
-	&io_is_busy_gov_sys.attr,
+gov_show_one_common(sampling_rate);
+gov_show_one_common(up_threshold);
+gov_show_one_common(sampling_down_factor);
+gov_show_one_common(ignore_nice_load);
+gov_show_one_common(min_sampling_rate);
+gov_show_one(od, io_is_busy);
+gov_show_one(od, powersave_bias);
+
+gov_attr_rw(sampling_rate);
+gov_attr_rw(io_is_busy);
+gov_attr_rw(up_threshold);
+gov_attr_rw(sampling_down_factor);
+gov_attr_rw(ignore_nice_load);
+gov_attr_rw(powersave_bias);
+gov_attr_ro(min_sampling_rate);
+
+static struct attribute *od_attributes[] = {
+	&min_sampling_rate.attr,
+	&sampling_rate.attr,
+	&up_threshold.attr,
+	&sampling_down_factor.attr,
+	&ignore_nice_load.attr,
+	&powersave_bias.attr,
+	&io_is_busy.attr,
 	NULL
 };
 
-static struct attribute_group od_attr_group_gov_sys = {
-	.attrs = dbs_attributes_gov_sys,
-	.name = "ondemand",
-};
-
-static struct attribute *dbs_attributes_gov_pol[] = {
-	&min_sampling_rate_gov_pol.attr,
-	&sampling_rate_gov_pol.attr,
-	&up_threshold_gov_pol.attr,
-	&sampling_down_factor_gov_pol.attr,
-	&ignore_nice_load_gov_pol.attr,
-	&powersave_bias_gov_pol.attr,
-	&io_is_busy_gov_pol.attr,
-	NULL
-};
-
-static struct attribute_group od_attr_group_gov_pol = {
-	.attrs = dbs_attributes_gov_pol,
-	.name = "ondemand",
-};
-
 /************************** sysfs end ************************/
 
 static int od_init(struct dbs_data *dbs_data, bool notify)
@@ -544,8 +523,7 @@ static struct dbs_governor od_dbs_gov = {
 		.owner = THIS_MODULE,
 	},
 	.governor = GOV_ONDEMAND,
-	.attr_group_gov_sys = &od_attr_group_gov_sys,
-	.attr_group_gov_pol = &od_attr_group_gov_pol,
+	.kobj_type = { .default_attrs = od_attributes },
 	.get_cpu_cdbs = get_cpu_cdbs,
 	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
 	.gov_dbs_timer = od_dbs_timer,
-- 
2.7.1.370.gb2aa7f8
