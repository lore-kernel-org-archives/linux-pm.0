From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/5] cpufreq: governor: Create separate sysfs-ops
Date: Wed, 3 Feb 2016 12:28:39 +0530
Message-ID: <20160203065839.GX31828@vireshk>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
 <5a012e56b8404e2d07e172b6699ce02f5c5b5f26.1454410226.git.viresh.kumar@linaro.org>
 <CAJZ5v0j4sjyQJoPCE0-XHCtZRTjSZU+xpJJHU3UBci0_v1BDvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33529 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933280AbcBCG6n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 01:58:43 -0500
Received: by mail-pf0-f182.google.com with SMTP id w123so8818075pfb.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2016 22:58:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j4sjyQJoPCE0-XHCtZRTjSZU+xpJJHU3UBci0_v1BDvw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 02-02-16, 22:23, Rafael J. Wysocki wrote:
> On Tue, Feb 2, 2016 at 11:57 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> "The ondemand and conservative governors use the global-attr or
> freq-attr structures to represent sysfs attributes corresponding to
> their tunables

> (which of them is actually used depends on whether or
> not different policy objects can use different governors at the same
> time

Not exactly. Different policies can always use different governors.
What made the difference was that different policies using same
governor, with different tunables or separate governor directories.

I have reworded this para like:

    The ondemand and conservative governors use the global-attr or freq-attr
    structures to represent sysfs attributes corresponding to their tunables
    (which of them is actually used depends on whether or not different
    policy objects can use same governor with different tunables at the same
    time and, consequently, on where those attributes are located in sysfs).

Please let me know if isn't clear.

> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +       ret = kobject_init_and_add(&dbs_data->kobj, &dbs_data->kobj_type,
> > +                                  get_governor_parent_kobj(policy),
> > +                                  attr_group->name);
> > +       if (ret) {
> > +               pr_err("%s: failed to init dbs_data kobj: %d\n", __func__, ret);
> 
> pr_debug() would be better here.

Its a real error, why pr_debug for that ?

> >                 goto reset_gdbs_data;
> > +       }
> >
> >         return 0;
> >
> > @@ -426,8 +457,7 @@ static int cpufreq_governor_exit(struct cpufreq_policy *policy,
> >                 return -EBUSY;
> >
> >         if (!--dbs_data->usage_count) {
> > -               sysfs_remove_group(get_governor_parent_kobj(policy),
> > -                                  get_sysfs_attr(dbs_data));
> > +               kobject_put(&dbs_data->kobj);
> 
> Don't we need a ->release callback for this kobject?

There is nothing that we need to free from the ->release() callback.
We are using the kobject here just to get separate show/store
callbacks.

Here is the new version based on the review comments received until
now:

-------------------------8<-------------------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 2 Feb 2016 12:35:01 +0530
Subject: [PATCH] cpufreq: governor: New sysfs show/store callbacks for
 governor tunables

The ondemand and conservative governors use the global-attr or freq-attr
structures to represent sysfs attributes corresponding to their tunables
(which of them is actually used depends on whether or not different
policy objects can use same governor with different tunables at the same
time and, consequently, on where those attributes are located in sysfs).

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
---
 drivers/cpufreq/cpufreq_conservative.c | 73 ++++++++++++----------------------
 drivers/cpufreq/cpufreq_governor.c     | 71 ++++++++++++++++++++++++++++-----
 drivers/cpufreq/cpufreq_governor.h     | 34 ++++++++++++++--
 drivers/cpufreq/cpufreq_ondemand.c     | 73 ++++++++++++----------------------
 4 files changed, 144 insertions(+), 107 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 57750367bd26..c749fb4fe5d2 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -275,54 +275,33 @@ static ssize_t store_freq_step(struct dbs_data *dbs_data, const char *buf,
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
@@ -365,8 +344,8 @@ define_get_cpu_dbs_routines(cs_cpu_dbs_info);
 
 static struct common_dbs_data cs_dbs_cdata = {
 	.governor = GOV_CONSERVATIVE,
-	.attr_group_gov_sys = &cs_attr_group_gov_sys,
-	.attr_group_gov_pol = &cs_attr_group_gov_pol,
+	.kobj_name = "conservative",
+	.kobj_type = { .sysfs_ops = &governor_sysfs_ops, .default_attrs = cs_attributes },
 	.get_cpu_cdbs = get_cpu_cdbs,
 	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
 	.gov_dbs_timer = cs_dbs_timer,
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 9a7edc91ad57..a9f335c4e461 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -22,14 +22,62 @@
 
 #include "cpufreq_governor.h"
 
-static struct attribute_group *get_sysfs_attr(struct dbs_data *dbs_data)
+static inline struct dbs_data *to_dbs_data(struct kobject *kobj)
 {
-	if (have_governor_per_policy())
-		return dbs_data->cdata->attr_group_gov_pol;
-	else
-		return dbs_data->cdata->attr_group_gov_sys;
+	return container_of(kobj, struct dbs_data, kobj);
+}
+
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
+	down_read(&dbs_data->rwsem);
+
+	if (gattr->show)
+		ret = gattr->show(dbs_data, buf);
+
+	up_read(&dbs_data->rwsem);
+
+	return ret;
 }
 
+static ssize_t governor_store(struct kobject *kobj, struct attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct dbs_data *dbs_data = to_dbs_data(kobj);
+	struct governor_attr *gattr = to_gov_attr(attr);
+	int ret = -EIO;
+
+	down_write(&dbs_data->rwsem);
+
+	if (gattr->store)
+		ret = gattr->store(dbs_data, buf, count);
+
+	up_write(&dbs_data->rwsem);
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
+const struct sysfs_ops governor_sysfs_ops = {
+	.show	= governor_show,
+	.store	= governor_store,
+};
+
 void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 {
 	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
@@ -383,6 +431,7 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
 
 	dbs_data->cdata = cdata;
 	dbs_data->usage_count = 1;
+	init_rwsem(&dbs_data->rwsem);
 
 	ret = cdata->init(dbs_data, !policy->governor->initialized);
 	if (ret)
@@ -395,10 +444,13 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
 
 	policy->governor_data = dbs_data;
 
-	ret = sysfs_create_group(get_governor_parent_kobj(policy),
-				 get_sysfs_attr(dbs_data));
-	if (ret)
+	ret = kobject_init_and_add(&dbs_data->kobj, &cdata->kobj_type,
+				   get_governor_parent_kobj(policy),
+				   cdata->kobj_name);
+	if (ret) {
+		pr_err("%s: failed to init dbs_data kobj: %d\n", __func__, ret);
 		goto reset_gdbs_data;
+	}
 
 	return 0;
 
@@ -426,8 +478,7 @@ static int cpufreq_governor_exit(struct cpufreq_policy *policy,
 		return -EBUSY;
 
 	if (!--dbs_data->usage_count) {
-		sysfs_remove_group(get_governor_parent_kobj(policy),
-				   get_sysfs_attr(dbs_data));
+		kobject_put(&dbs_data->kobj);
 
 		policy->governor_data = NULL;
 
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index ad44a8546a3a..67500a1015cf 100644
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
@@ -197,14 +222,13 @@ struct cs_dbs_tuners {
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
+	const char *kobj_name;
+	struct kobj_type kobj_type;
 
 	/*
 	 * Common data for platforms that don't set
@@ -234,6 +258,9 @@ struct dbs_data {
 	struct common_dbs_data *cdata;
 	int usage_count;
 	void *tuners;
+	struct kobject kobj;
+	/* Protect concurrent updates to governor tunables from sysfs */
+	struct rw_semaphore rwsem;
 };
 
 /* Governor specific ops, will be passed to dbs_data->gov_ops */
@@ -256,6 +283,7 @@ static inline int delay_for_sampling_rate(unsigned int sampling_rate)
 }
 
 extern struct mutex cpufreq_governor_lock;
+extern const struct sysfs_ops governor_sysfs_ops;
 
 void gov_add_timers(struct cpufreq_policy *policy, unsigned int delay);
 void gov_cancel_work(struct cpu_common_dbs_info *shared);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index b31f64745232..82ed490f7de0 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -436,54 +436,33 @@ static ssize_t store_powersave_bias(struct dbs_data *dbs_data, const char *buf,
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
@@ -542,8 +521,8 @@ static struct od_ops od_ops = {
 
 static struct common_dbs_data od_dbs_cdata = {
 	.governor = GOV_ONDEMAND,
-	.attr_group_gov_sys = &od_attr_group_gov_sys,
-	.attr_group_gov_pol = &od_attr_group_gov_pol,
+	.kobj_name = "ondemand",
+	.kobj_type = { .sysfs_ops = &governor_sysfs_ops, .default_attrs = od_attributes },
 	.get_cpu_cdbs = get_cpu_cdbs,
 	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
 	.gov_dbs_timer = od_dbs_timer,
