From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 03/13] cpufreq: governor: New sysfs show/store
 callbacks for governor tunables
Date: Mon, 8 Feb 2016 22:36:42 +0100
Message-ID: <CAJZ5v0jZs1=sxq2Fz38dZFj3-4SK7HvLEWoFQe4eJaPPSeFkXQ@mail.gmail.com>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
	<89c003851ca3be77cf3656805303bf4f36d585ea.1454931188.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34173 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756446AbcBHVgo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 16:36:44 -0500
In-Reply-To: <89c003851ca3be77cf3656805303bf4f36d585ea.1454931188.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Feb 8, 2016 at 12:39 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

[cut]

> @@ -331,8 +310,8 @@ static struct dbs_governor cs_dbs_gov = {
>                 .owner = THIS_MODULE,
>         },
>         .governor = GOV_CONSERVATIVE,
> -       .attr_group_gov_sys = &cs_attr_group_gov_sys,
> -       .attr_group_gov_pol = &cs_attr_group_gov_pol,
> +       .kobj_name = "conservative",

I don't think you need this.

> +       .kobj_type = { .default_attrs = cs_attributes },
>         .get_cpu_cdbs = get_cpu_cdbs,
>         .get_cpu_dbs_info_s = get_cpu_dbs_info_s,
>         .gov_dbs_timer = cs_dbs_timer,

[cut]

> @@ -373,10 +420,15 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
>         policy_dbs->dbs_data = dbs_data;
>         policy->governor_data = policy_dbs;
>
> -       ret = sysfs_create_group(get_governor_parent_kobj(policy),
> -                                get_sysfs_attr(gov));
> -       if (ret)
> +       gov->kobj_type.sysfs_ops = &governor_sysfs_ops;
> +       ret = kobject_init_and_add(&dbs_data->kobj, &gov->kobj_type,
> +                                  get_governor_parent_kobj(policy),
> +                                  gov->kobj_name);

gov->gov.name can be used here instead of the new kobj_name thing.

Besides, you forgot about the format argument for kobject_init_and_add().

> +       if (ret) {
> +               pr_err("cpufreq: Governor initialization failed (dbs_data kobject initialization error %d)\n",
> +                      ret);
>                 goto reset_gdbs_data;
> +       }
>
>         return 0;
>

[cut]

> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index 5c5d7936087c..a3afac5d8ab2 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -160,8 +160,44 @@ struct dbs_data {
>         unsigned int sampling_rate;
>         unsigned int sampling_down_factor;
>         unsigned int up_threshold;
> +
> +       struct kobject kobj;
> +       /* Protect concurrent updates to governor tunables from sysfs */
> +       struct mutex mutex;
> +};
> +
> +/* Governor's specific attributes */
> +struct dbs_data;
> +struct governor_attr {
> +       struct attribute attr;
> +       ssize_t (*show)(struct dbs_data *dbs_data, char *buf);
> +       ssize_t (*store)(struct dbs_data *dbs_data, const char *buf,
> +                        size_t count);
>  };
>
> +#define gov_show_one_tunable(_gov, file_name)                          \
> +static ssize_t show_##file_name                                                \
> +(struct dbs_data *dbs_data, char *buf)                                 \
> +{                                                                      \
> +       struct _gov##_dbs_tuners *tuners = dbs_data->tuners;            \
> +       return sprintf(buf, "%u\n", tuners->file_name);                 \
> +}
> +
> +#define gov_show_one(file_name)                                                \
> +static ssize_t show_##file_name                                                \
> +(struct dbs_data *dbs_data, char *buf)                                 \
> +{                                                                      \
> +       return sprintf(buf, "%u\n", dbs_data->file_name);               \
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
>  /* Common to all CPUs of a policy */
>  struct policy_dbs_info {
>         struct cpufreq_policy *policy;
> @@ -236,8 +272,8 @@ struct dbs_governor {
>         #define GOV_ONDEMAND            0
>         #define GOV_CONSERVATIVE        1
>         int governor;
> -       struct attribute_group *attr_group_gov_sys; /* one governor - system */
> -       struct attribute_group *attr_group_gov_pol; /* one governor - policy */
> +       const char *kobj_name;

So this isn't really necessary.

> +       struct kobj_type kobj_type;
>
>         /*
>          * Common data for platforms that don't set
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index cb0d6ff1ced5..bf570800fa78 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c

[cut]

> @@ -544,8 +523,8 @@ static struct dbs_governor od_dbs_gov = {
>                 .owner = THIS_MODULE,
>         },
>         .governor = GOV_ONDEMAND,
> -       .attr_group_gov_sys = &od_attr_group_gov_sys,
> -       .attr_group_gov_pol = &od_attr_group_gov_pol,
> +       .kobj_name = "ondemand",

And this isn't necessary too.

> +       .kobj_type = { .default_attrs = od_attributes },
>         .get_cpu_cdbs = get_cpu_cdbs,
>         .get_cpu_dbs_info_s = get_cpu_dbs_info_s,
>         .gov_dbs_timer = od_dbs_timer,
> --

Thanks,
Rafael
