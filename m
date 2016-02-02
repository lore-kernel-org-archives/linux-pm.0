From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/5] cpufreq: governor: Create separate sysfs-ops
Date: Tue,  2 Feb 2016 16:27:22 +0530
Message-ID: <5a012e56b8404e2d07e172b6699ce02f5c5b5f26.1454410226.git.viresh.kumar@linaro.org>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454410226.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454410226.git.viresh.kumar@linaro.org>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Until now, governors (ondemand/conservative) were using the
'global-attr' or 'freq-attr', depending on the sysfs location where we
want to create governor's directory.

The problem is that, in case of 'freq-attr', we are forced to use
show()/store() present in cpufreq.c, which always take policy->rwsem.

And because of that we were facing some ABBA lockups during governor
callback event CPUFREQ_GOV_POLICY_EXIT. And so we were dropping the
rwsem right before calling governor callback for CPUFREQ_GOV_POLICY_EXIT
event.

That caused further problems and it never worked perfectly.

This patch attempts to fix that by creating separate sysfs-ops for
cpufreq governors.

Because things got much simplified now, we don't need separate
show/store callbacks for governor-for-system and governor-per-policy
cases.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 71 +++++++++++++---------------------
 drivers/cpufreq/cpufreq_governor.c     | 50 +++++++++++++++++++-----
 drivers/cpufreq/cpufreq_governor.h     | 31 +++++++++++++--
 drivers/cpufreq/cpufreq_ondemand.c     | 71 +++++++++++++---------------------
 4 files changed, 122 insertions(+), 101 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 57750367bd26..980145da796a 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -275,51 +275,35 @@ static ssize_t store_freq_step(struct dbs_data *dbs_data, const char *buf,
 	return count;
 }
 
-show_store_one(cs, sampling_rate);
-show_store_one(cs, sampling_down_factor);
-show_store_one(cs, up_threshold);
-show_store_one(cs, down_threshold);
-show_store_one(cs, ignore_nice_load);
-show_store_one(cs, freq_step);
-show_one(cs, min_sampling_rate);
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
+gov_show_one(cs, sampling_rate);
+gov_show_one(cs, sampling_down_factor);
+gov_show_one(cs, up_threshold);
+gov_show_one(cs, down_threshold);
+gov_show_one(cs, ignore_nice_load);
+gov_show_one(cs, freq_step);
+gov_show_one(cs, min_sampling_rate);
+
+gov_attr_rw(sampling_rate);
+gov_attr_rw(sampling_down_factor);
+gov_attr_rw(up_threshold);
+gov_attr_rw(down_threshold);
+gov_attr_rw(ignore_nice_load);
+gov_attr_rw(freq_step);
+gov_attr_ro(min_sampling_rate);
+
+static struct attribute *dbs_attributes[] = {
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
+static struct attribute_group cs_attr_group = {
+	.attrs = dbs_attributes,
 	.name = "conservative",
 };
 
@@ -365,8 +349,7 @@ define_get_cpu_dbs_routines(cs_cpu_dbs_info);
 
 static struct common_dbs_data cs_dbs_cdata = {
 	.governor = GOV_CONSERVATIVE,
-	.attr_group_gov_sys = &cs_attr_group_gov_sys,
-	.attr_group_gov_pol = &cs_attr_group_gov_pol,
+	.attr_group = &cs_attr_group,
 	.get_cpu_cdbs = get_cpu_cdbs,
 	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
 	.gov_dbs_timer = cs_dbs_timer,
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 9a7edc91ad57..e785a118cbdc 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -22,14 +22,37 @@
 
 #include "cpufreq_governor.h"
 
-static struct attribute_group *get_sysfs_attr(struct dbs_data *dbs_data)
+#define to_dbs_data(k) container_of(k, struct dbs_data, kobj)
+#define to_attr(a) container_of(a, struct governor_attr, attr)
+
+static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 {
-	if (have_governor_per_policy())
-		return dbs_data->cdata->attr_group_gov_pol;
-	else
-		return dbs_data->cdata->attr_group_gov_sys;
+	struct dbs_data *dbs_data = to_dbs_data(kobj);
+	struct governor_attr *gattr = to_attr(attr);
+
+	if (gattr->show)
+		return gattr->show(dbs_data, buf);
+
+	return -EIO;
+}
+
+static ssize_t store(struct kobject *kobj, struct attribute *attr,
+		     const char *buf, size_t count)
+{
+	struct dbs_data *dbs_data = to_dbs_data(kobj);
+	struct governor_attr *gattr = to_attr(attr);
+
+	if (gattr->store)
+		return gattr->store(dbs_data, buf, count);
+
+	return -EIO;
 }
 
+static const struct sysfs_ops sysfs_ops = {
+	.show	= show,
+	.store	= store,
+};
+
 void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 {
 	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
@@ -354,6 +377,7 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
 				 struct dbs_data *dbs_data,
 				 struct common_dbs_data *cdata)
 {
+	struct attribute_group *attr_group;
 	int ret;
 
 	/* State should be equivalent to EXIT */
@@ -395,10 +419,17 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
 
 	policy->governor_data = dbs_data;
 
-	ret = sysfs_create_group(get_governor_parent_kobj(policy),
-				 get_sysfs_attr(dbs_data));
-	if (ret)
+	attr_group = dbs_data->cdata->attr_group;
+	dbs_data->kobj_type.sysfs_ops = &sysfs_ops;
+	dbs_data->kobj_type.default_attrs = attr_group->attrs;
+
+	ret = kobject_init_and_add(&dbs_data->kobj, &dbs_data->kobj_type,
+				   get_governor_parent_kobj(policy),
+				   attr_group->name);
+	if (ret) {
+		pr_err("%s: failed to init dbs_data kobj: %d\n", __func__, ret);
 		goto reset_gdbs_data;
+	}
 
 	return 0;
 
@@ -426,8 +457,7 @@ static int cpufreq_governor_exit(struct cpufreq_policy *policy,
 		return -EBUSY;
 
 	if (!--dbs_data->usage_count) {
-		sysfs_remove_group(get_governor_parent_kobj(policy),
-				   get_sysfs_attr(dbs_data));
+		kobject_put(&dbs_data->kobj);
 
 		policy->governor_data = NULL;
 
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index ad44a8546a3a..59b28133dd68 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -108,6 +108,31 @@ static ssize_t store_##file_name##_gov_pol				\
 show_one(_gov, file_name);						\
 store_one(_gov, file_name)
 
+/* Governor's specific attributes */
+struct dbs_data;
+struct governor_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct dbs_data *dbs_data, char *buf);
+	ssize_t (*store)(struct dbs_data *dbs_data, const char *buf,
+			 size_t count);
+};
+
+#define gov_show_one(_gov, file_name)					\
+static ssize_t show_##file_name						\
+(struct dbs_data *dbs_data, char *buf)					\
+{									\
+	struct _gov##_dbs_tuners *tuners = dbs_data->tuners;		\
+	return sprintf(buf, "%u\n", tuners->file_name);			\
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
 /* create helper routines */
 #define define_get_cpu_dbs_routines(_dbs_info)				\
 static struct cpu_dbs_info *get_cpu_cdbs(int cpu)			\
@@ -197,14 +222,12 @@ struct cs_dbs_tuners {
 };
 
 /* Common Governor data across policies */
-struct dbs_data;
 struct common_dbs_data {
 	/* Common across governors */
 	#define GOV_ONDEMAND		0
 	#define GOV_CONSERVATIVE	1
 	int governor;
-	struct attribute_group *attr_group_gov_sys; /* one governor - system */
-	struct attribute_group *attr_group_gov_pol; /* one governor - policy */
+	struct attribute_group *attr_group; /* one governor - system */
 
 	/*
 	 * Common data for platforms that don't set
@@ -234,6 +257,8 @@ struct dbs_data {
 	struct common_dbs_data *cdata;
 	int usage_count;
 	void *tuners;
+	struct kobject kobj;
+	struct kobj_type kobj_type;
 };
 
 /* Governor specific ops, will be passed to dbs_data->gov_ops */
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index b31f64745232..b7983dd02e24 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -436,51 +436,35 @@ static ssize_t store_powersave_bias(struct dbs_data *dbs_data, const char *buf,
 	return count;
 }
 
-show_store_one(od, sampling_rate);
-show_store_one(od, io_is_busy);
-show_store_one(od, up_threshold);
-show_store_one(od, sampling_down_factor);
-show_store_one(od, ignore_nice_load);
-show_store_one(od, powersave_bias);
-show_one(od, min_sampling_rate);
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
+gov_show_one(od, sampling_rate);
+gov_show_one(od, io_is_busy);
+gov_show_one(od, up_threshold);
+gov_show_one(od, sampling_down_factor);
+gov_show_one(od, ignore_nice_load);
+gov_show_one(od, powersave_bias);
+gov_show_one(od, min_sampling_rate);
+
+gov_attr_rw(sampling_rate);
+gov_attr_rw(io_is_busy);
+gov_attr_rw(up_threshold);
+gov_attr_rw(sampling_down_factor);
+gov_attr_rw(ignore_nice_load);
+gov_attr_rw(powersave_bias);
+gov_attr_ro(min_sampling_rate);
+
+static struct attribute *dbs_attributes[] = {
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
+static struct attribute_group od_attr_group = {
+	.attrs = dbs_attributes,
 	.name = "ondemand",
 };
 
@@ -542,8 +526,7 @@ static struct od_ops od_ops = {
 
 static struct common_dbs_data od_dbs_cdata = {
 	.governor = GOV_ONDEMAND,
-	.attr_group_gov_sys = &od_attr_group_gov_sys,
-	.attr_group_gov_pol = &od_attr_group_gov_pol,
+	.attr_group = &od_attr_group,
 	.get_cpu_cdbs = get_cpu_cdbs,
 	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
 	.gov_dbs_timer = od_dbs_timer,
-- 
2.7.0.79.gdc08a19
