From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/5] cpufreq: governor: Create separate sysfs-ops
Date: Tue, 2 Feb 2016 22:23:55 +0100
Message-ID: <CAJZ5v0j4sjyQJoPCE0-XHCtZRTjSZU+xpJJHU3UBci0_v1BDvw@mail.gmail.com>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
	<5a012e56b8404e2d07e172b6699ce02f5c5b5f26.1454410226.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5a012e56b8404e2d07e172b6699ce02f5c5b5f26.1454410226.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 2, 2016 at 11:57 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

First, the subject might be better.  What about something like
"cpufreq: governor: New sysfs show/store callbacks for governor
tunables", for example?

> Until now, governors (ondemand/conservative) were using the
> 'global-attr' or 'freq-attr', depending on the sysfs location where we
> want to create governor's directory.

"The ondemand and conservative governors use the global-attr or
freq-attr structures to represent sysfs attributes corresponding to
their tunables (which of them is actually used depends on whether or
not different policy objects can use different governors at the same
time and, consequently, on where those attributes are located in
sysfs).

Unfortunately, in the freq-attr case, the standard cpufreq show/store
sysfs attribute callbacks are applied to the governor tunable
attributes and they always acquire the policy->rwsem lock before
carrying out the operation.  That may lead to an ABBA deadlock if
governor tunable attributes are removed under policy->rwsem while one
of them is being accessed concurrently (if sysfs attributes removal
wins the race, it will wait for the access to complete with
policy->rwsem held while the attribute callback will block on
policy->rwsem indefinitely).

We attempted to address this issue by dropping policy->rwsem around
governor tunable attributes removal (that is, around invocations of
the ->governor callback with the event arg equal to
CPUFREQ_GOV_POLICY_EXIT) in cpufreq_set_policy(), but that opened up
race conditions that had not been possible with policy->rwsem held all
the time.  Therefore policy->rwsem cannot be dropped in
cpufreq_set_policy() at any point, but the deadlock situation
described above must be avoided too.

To that end, use the observation that in principle governor tunables
may be represented by the same data type regardless of whether the
governor is system-wide or per-policy and introduce a new structure,
struct governor_attr, for representing them and new corresponding
macros for creating show/store sysfs callbacks for them.  Also make
their parent kobject use a new kobject type whose default show/store
callbacks are not related to the standard core cpufreq ones in any way
(and they don't acquire policy->rwsem in particular)."

IOW, (1) describe the problem you're addressing so that people
unfamiliar with the code in question can understand it, (2) describe
what is done to address the problem (what's the idea and what changes
are made to implement it).

[cut]

> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -22,14 +22,37 @@
>
>  #include "cpufreq_governor.h"
>
> -static struct attribute_group *get_sysfs_attr(struct dbs_data *dbs_data)
> +#define to_dbs_data(k) container_of(k, struct dbs_data, kobj)
> +#define to_attr(a) container_of(a, struct governor_attr, attr)

Please change the above to static inline routines.

> +
> +static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)

A better name please.  Something that will correspond to the purpose.

>  {
> -       if (have_governor_per_policy())
> -               return dbs_data->cdata->attr_group_gov_pol;
> -       else
> -               return dbs_data->cdata->attr_group_gov_sys;
> +       struct dbs_data *dbs_data = to_dbs_data(kobj);
> +       struct governor_attr *gattr = to_attr(attr);
> +
> +       if (gattr->show)
> +               return gattr->show(dbs_data, buf);
> +
> +       return -EIO;
> +}
> +
> +static ssize_t store(struct kobject *kobj, struct attribute *attr,
> +                    const char *buf, size_t count)

Ditto.

> +{
> +       struct dbs_data *dbs_data = to_dbs_data(kobj);
> +       struct governor_attr *gattr = to_attr(attr);
> +
> +       if (gattr->store)
> +               return gattr->store(dbs_data, buf, count);

Say two instances of this run in parallel with each other, either for
the same attribute or for different attributes under the same
dbs_data.  What's the guarantee that they won't make conflicting
changes?

> +
> +       return -EIO;
>  }
>
> +static const struct sysfs_ops sysfs_ops = {
> +       .show   = show,
> +       .store  = store,
> +};

That is completely enigmatic, so please at least add a comment describing it.

> +
>  void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
>  {
>         struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
> @@ -354,6 +377,7 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
>                                  struct dbs_data *dbs_data,
>                                  struct common_dbs_data *cdata)
>  {
> +       struct attribute_group *attr_group;
>         int ret;
>
>         /* State should be equivalent to EXIT */
> @@ -395,10 +419,17 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
>
>         policy->governor_data = dbs_data;
>
> -       ret = sysfs_create_group(get_governor_parent_kobj(policy),
> -                                get_sysfs_attr(dbs_data));
> -       if (ret)
> +       attr_group = dbs_data->cdata->attr_group;
> +       dbs_data->kobj_type.sysfs_ops = &sysfs_ops;
> +       dbs_data->kobj_type.default_attrs = attr_group->attrs;

Why can't the kobject type be defined in struct common_dbs_data?
Surely, it will be the same for all dbs_data objects corresponding to
the same governor, won't it?

> +
> +       ret = kobject_init_and_add(&dbs_data->kobj, &dbs_data->kobj_type,
> +                                  get_governor_parent_kobj(policy),
> +                                  attr_group->name);
> +       if (ret) {
> +               pr_err("%s: failed to init dbs_data kobj: %d\n", __func__, ret);

pr_debug() would be better here.

>                 goto reset_gdbs_data;
> +       }
>
>         return 0;
>
> @@ -426,8 +457,7 @@ static int cpufreq_governor_exit(struct cpufreq_policy *policy,
>                 return -EBUSY;
>
>         if (!--dbs_data->usage_count) {
> -               sysfs_remove_group(get_governor_parent_kobj(policy),
> -                                  get_sysfs_attr(dbs_data));
> +               kobject_put(&dbs_data->kobj);

Don't we need a ->release callback for this kobject?

>
>                 policy->governor_data = NULL;
>
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index ad44a8546a3a..59b28133dd68 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -108,6 +108,31 @@ static ssize_t store_##file_name##_gov_pol                         \
>  show_one(_gov, file_name);                                             \
>  store_one(_gov, file_name)
>
> +/* Governor's specific attributes */
> +struct dbs_data;
> +struct governor_attr {
> +       struct attribute attr;
> +       ssize_t (*show)(struct dbs_data *dbs_data, char *buf);
> +       ssize_t (*store)(struct dbs_data *dbs_data, const char *buf,
> +                        size_t count);
> +};
> +
> +#define gov_show_one(_gov, file_name)                                  \
> +static ssize_t show_##file_name                                                \
> +(struct dbs_data *dbs_data, char *buf)                                 \
> +{                                                                      \
> +       struct _gov##_dbs_tuners *tuners = dbs_data->tuners;            \
> +       return sprintf(buf, "%u\n", tuners->file_name);                 \
> +}
> +
> +#define gov_attr_ro(_name)                                             \
> +static struct governor_attr _name =                                    \
> +__ATTR(_name, 0444, show_##_name, NULL)
> +
> +#define gov_attr_rw(_name)                                             \
> +static struct governor_attr _name =                                    \
> +__ATTR(_name, 0644, show_##_name, store_##_name)
> +
>  /* create helper routines */
>  #define define_get_cpu_dbs_routines(_dbs_info)                         \
>  static struct cpu_dbs_info *get_cpu_cdbs(int cpu)                      \
> @@ -197,14 +222,12 @@ struct cs_dbs_tuners {
>  };
>
>  /* Common Governor data across policies */
> -struct dbs_data;
>  struct common_dbs_data {
>         /* Common across governors */
>         #define GOV_ONDEMAND            0
>         #define GOV_CONSERVATIVE        1
>         int governor;
> -       struct attribute_group *attr_group_gov_sys; /* one governor - system */
> -       struct attribute_group *attr_group_gov_pol; /* one governor - policy */
> +       struct attribute_group *attr_group; /* one governor - system */
>
>         /*
>          * Common data for platforms that don't set
> @@ -234,6 +257,8 @@ struct dbs_data {
>         struct common_dbs_data *cdata;
>         int usage_count;
>         void *tuners;
> +       struct kobject kobj;
> +       struct kobj_type kobj_type;

This is questionable.  The kobject type doesn't have to be dynamic IMO.

>  };

Thanks,
Rafael
