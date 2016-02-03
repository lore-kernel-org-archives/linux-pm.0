From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/5] cpufreq: governor: Create separate sysfs-ops
Date: Wed, 3 Feb 2016 13:42:03 +0100
Message-ID: <CAJZ5v0g1ebO_S9YJkZjUNZDHqspBATp3jErRP6RqXCy3zh7NDw@mail.gmail.com>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
	<5a012e56b8404e2d07e172b6699ce02f5c5b5f26.1454410226.git.viresh.kumar@linaro.org>
	<CAJZ5v0j4sjyQJoPCE0-XHCtZRTjSZU+xpJJHU3UBci0_v1BDvw@mail.gmail.com>
	<20160203065839.GX31828@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160203065839.GX31828@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 3, 2016 at 7:58 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 02-02-16, 22:23, Rafael J. Wysocki wrote:
>> On Tue, Feb 2, 2016 at 11:57 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
>> "The ondemand and conservative governors use the global-attr or
>> freq-attr structures to represent sysfs attributes corresponding to
>> their tunables
>
>> (which of them is actually used depends on whether or
>> not different policy objects can use different governors at the same
>> time
>
> Not exactly. Different policies can always use different governors.
> What made the difference was that different policies using same
> governor, with different tunables or separate governor directories.
>
> I have reworded this para like:
>
>     The ondemand and conservative governors use the global-attr or freq-attr
>     structures to represent sysfs attributes corresponding to their tunables
>     (which of them is actually used depends on whether or not different
>     policy objects can use same governor with different tunables at the same
>     time and, consequently, on where those attributes are located in sysfs).
>
> Please let me know if isn't clear.

That's OK.  IMO you should say "use the same governor", but that's
easily fixable. :-)

>> > --- a/drivers/cpufreq/cpufreq_governor.c
>> > +       ret = kobject_init_and_add(&dbs_data->kobj, &dbs_data->kobj_type,
>> > +                                  get_governor_parent_kobj(policy),
>> > +                                  attr_group->name);
>> > +       if (ret) {
>> > +               pr_err("%s: failed to init dbs_data kobj: %d\n", __func__, ret);
>>
>> pr_debug() would be better here.
>
> Its a real error, why pr_debug for that ?

What's the value of printing that on user systems?  It contains debug
information only and it is not useful to anyone unfamiliar with the
code in question anyway.

>> >                 goto reset_gdbs_data;
>> > +       }
>> >
>> >         return 0;
>> >
>> > @@ -426,8 +457,7 @@ static int cpufreq_governor_exit(struct cpufreq_policy *policy,
>> >                 return -EBUSY;
>> >
>> >         if (!--dbs_data->usage_count) {
>> > -               sysfs_remove_group(get_governor_parent_kobj(policy),
>> > -                                  get_sysfs_attr(dbs_data));
>> > +               kobject_put(&dbs_data->kobj);
>>
>> Don't we need a ->release callback for this kobject?
>
> There is nothing that we need to free from the ->release() callback.
> We are using the kobject here just to get separate show/store
> callbacks.

Well, I guess the answer should be that there can't be more active
references to the kobject, so it is safe to free it synchronously
later.

> Here is the new version based on the review comments received until
> now:
>
> -------------------------8<-------------------------
>
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Tue, 2 Feb 2016 12:35:01 +0530
> Subject: [PATCH] cpufreq: governor: New sysfs show/store callbacks for
>  governor tunables
>

[cut]

> @@ -22,14 +22,62 @@
>
>  #include "cpufreq_governor.h"
>
> -static struct attribute_group *get_sysfs_attr(struct dbs_data *dbs_data)
> +static inline struct dbs_data *to_dbs_data(struct kobject *kobj)
>  {
> -       if (have_governor_per_policy())
> -               return dbs_data->cdata->attr_group_gov_pol;
> -       else
> -               return dbs_data->cdata->attr_group_gov_sys;
> +       return container_of(kobj, struct dbs_data, kobj);
> +}
> +
> +static inline struct governor_attr *to_gov_attr(struct attribute *attr)
> +{
> +       return container_of(attr, struct governor_attr, attr);
> +}
> +
> +static ssize_t governor_show(struct kobject *kobj, struct attribute *attr,
> +                            char *buf)
> +{
> +       struct dbs_data *dbs_data = to_dbs_data(kobj);
> +       struct governor_attr *gattr = to_gov_attr(attr);
> +       int ret = -EIO;
> +
> +       down_read(&dbs_data->rwsem);
> +
> +       if (gattr->show)
> +               ret = gattr->show(dbs_data, buf);
> +
> +       up_read(&dbs_data->rwsem);

Do we need the lock here too?

show() is only going to read the value, isn't it?  And everything u32
or smaller is read atomically anyway.

Apart from this it looks good to me.

When you're ready, please resend the whole series without patch [5/5]
which is premature IMO.

Thanks,
Rafael
