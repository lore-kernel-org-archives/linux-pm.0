From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V8 1/6] PM / Domains: Add support to select
 performance-state of domains
Date: Fri, 21 Jul 2017 10:35:42 +0200
Message-ID: <CAPDyKFr0ZMeS=57p48W9f_j3U0T41msxOqQHBXB_soA8-weM+w@mail.gmail.com>
References: <cover.1498026827.git.viresh.kumar@linaro.org> <52daf22d2c9d92b0e61c8c5c5a88516d7a08a31a.1498026827.git.viresh.kumar@linaro.org>
 <CAPDyKFqaFvET9yM_6wr7b1Zw=hePQrE-Ak-7YPCR9izooh4LBA@mail.gmail.com> <20170719123751.GF352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719123751.GF352@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-pm@vger.kernel.org

[...]

>
>> What happens when a power domain gets powered off and then on. Is the
>> performance state restored? Please elaborate a bit on this.
>
> Can this happen while the genpd is still in use? If not then we
> wouldn't have a problem here as the users of it would have revoked
> their constraints by now.

This depends on how drivers are dealing with runtime PM in conjunction
with the new pm_genpd_update_performance_state().

In case you don't want to manage some of this in genpd, then each
driver will have to drop their constraints every time they are about
to runtime suspend its device. And restore them at runtime resume.

To me, that's seems like a bad idea. Then it's better to make genpd
deal with this - somehow.

[...]

>>
>> I think a better name of this function is:
>> dev_pm_genpd_has_performance_state(). What do you think?
>
> Sure.
>
>> We might even want to decide to explicitly stay using the terminology
>> "DVFS" instead. In such case, perhaps converting the names of the
>> callbacks/API to use "dvfs" instead. For the API added here, maybe
>> dev_pm_genpd_can_dvfs().
>
> I am not sure about that really. Because in most of the cases genpd
> wouldn't do any freq switching, but only voltage.

Fair enough, let's stick with "performance" then. However, then please
make sure to not mention DVFS in the changelog/comments as it could be
confusing.

>
>> > Note that, the performance level as returned by
>> > ->get_performance_state() for the parent domain of a device is used for
>> > all domains in parent hierarchy.
>>
>> Please clarify a bit on this. What exactly does this mean?
>
> For a hierarchy like this:
>
> PPdomain 0               PPdomain 1
>    |                        |
>    --------------------------
>                 |
>              Pdomain
>                 |
>               device
>
> ->dev_get_performance_state(dev) would be called for the device and it
> will return a single value (X) representing the performance index of
> its parent ("Pdomain"). But the direct parent domain may not support

This is not parent or parent domain, but just "domain" or perhaps "PM
domain" to make it clear.

> setting of performance index and so we need to propagate the call to
> parents of Pdomain. And that would be PPdomain 0 and 1.

Use "master domains" instead.

>
> Now the paragraph in the commit says that the same performance index
> value X will be used for both these PPdomains, as we don't want to
> make things more complex to begin with.

Alright, I get it, thanks!

>
>> > Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
>> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> > ---
>> >  drivers/base/power/domain.c | 223 ++++++++++++++++++++++++++++++++++++++++++++
>> >  include/linux/pm_domain.h   |  22 +++++
>> >  2 files changed, 245 insertions(+)
>> >
>> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> > index 71c95ad808d5..d506be9ff1f7 100644
>> > --- a/drivers/base/power/domain.c
>> > +++ b/drivers/base/power/domain.c
>> > @@ -466,6 +466,229 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
>> >         return NOTIFY_DONE;
>> >  }
>> >
>> > +/*
>> > + * Returns true if anyone in genpd's parent hierarchy has
>> > + * set_performance_state() set.
>> > + */
>> > +static bool genpd_has_set_performance_state(struct generic_pm_domain *genpd)
>> > +{
>>
>> So this function will be become in-directly called by generic drivers
>> that supports DVFS of the genpd for their devices.
>>
>> I think the data you validate here would be better to be pre-validated
>> at pm_genpd_init() and at pm_genpd_add|remove_subdomain() and the
>> result stored in a variable in the genpd struct. Especially when a
>> subdomain is added, that is a point when you can verify the
>> *_performance_state() callbacks, and thus make sure it's a correct
>> setup from the topology point of view.
>
> Something like this ?
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 4a898e095a1d..182c1911ea9c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -466,25 +466,6 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
>         return NOTIFY_DONE;
>  }
>
> -/*
> - * Returns true if anyone in genpd's parent hierarchy has
> - * set_performance_state() set.
> - */
> -static bool genpd_has_set_performance_state(struct generic_pm_domain *genpd)
> -{
> -       struct gpd_link *link;
> -
> -       if (genpd->set_performance_state)
> -               return true;
> -
> -       list_for_each_entry(link, &genpd->slave_links, slave_node) {
> -               if (genpd_has_set_performance_state(link->master))
> -                       return true;
> -       }
> -
> -       return false;
> -}
> -
>  /**
>   * pm_genpd_has_performance_state - Checks if power domain does performance
>   * state management.
> @@ -507,7 +488,7 @@ bool pm_genpd_has_performance_state(struct device *dev)
>
>         /* The parent domain must have set get_performance_state() */
>         if (!IS_ERR(genpd) && genpd->get_performance_state) {
> -               if (genpd_has_set_performance_state(genpd))
> +               if (genpd->can_set_performance_state)
>                         return true;
>
>                 /*
> @@ -1594,6 +1575,8 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
>         if (genpd_status_on(subdomain))
>                 genpd_sd_counter_inc(genpd);
>
> +       subdomain->can_set_performance_state += genpd->can_set_performance_state;
> +
>   out:
>         genpd_unlock(genpd);
>         genpd_unlock(subdomain);
> @@ -1654,6 +1637,8 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>                 if (genpd_status_on(subdomain))
>                         genpd_sd_counter_dec(genpd);
>
> +               subdomain->can_set_performance_state -= genpd->can_set_performance_state;
> +
>                 ret = 0;
>                 break;
>         }
> @@ -1721,6 +1706,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         genpd->max_off_time_changed = true;
>         genpd->provider = NULL;
>         genpd->has_provider = false;
> +       genpd->can_set_performance_state = !!genpd->set_performance_state;
>         genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
>         genpd->domain.ops.runtime_resume = genpd_runtime_resume;
>         genpd->domain.ops.prepare = pm_genpd_prepare;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index bf90177208a2..995d0cb1bc14 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -64,6 +64,7 @@ struct generic_pm_domain {
>         unsigned int suspended_count;   /* System suspend device counter */
>         unsigned int prepared_count;    /* Suspend counter of prepared devices */
>         unsigned int performance_state; /* Max requested performance state */
> +       unsigned int can_set_performance_state; /* Number of parent domains supporting set state */
>         int (*power_off)(struct generic_pm_domain *domain);
>         int (*power_on)(struct generic_pm_domain *domain);
>         int (*get_performance_state)(struct device *dev, unsigned long rate);
>

Yes!

On top of that change, you could also add some validation if the
get/set callbacks is there are any constraints on how they must be
assigned.

[...]

>> That makes me wonder: what will happen if there are more than one
>> master having a ->set_perfomance_state() callback assigned? I guess
>> that is non-allowed configuration?
>
> This patch supports them at least. Device's domain can have multiple
> masters which require this configuration, but the same performance
> index will be used for all of them (for simplicity unless we have a
> real example to serve).

Okay!

[...]

>> What is a *parent* domain here?
>
> Same crappy wording I have been using. Its about device's genpd.
>
>> In genpd we try to use the terminology of master- and sub-domains.
>> Could you re-phrase this to get some clarity on what you try to
>> explain from the above?
>
> Yeah, sure.
>
> So do we call a device's power domain as its master domain? I thought
> that master is only used in context of sub-domains, right ?

Correct. A master domain should be used in context of sub-domain. In
most cases we also use "PM domain" instead of "power domain" is it has
a slightly different meaning.

>>
>> From a locking point of view we always traverse the topology from
>> bottom an up. In other words, we walk the genpd's ->slave_links, and
>> lock the masters in the order the are defined via the slave_links
>> list. The order is important to avoid deadlocks. I don't think you
>> should walk the master_links as being done above, especially not
>> without using locks.
>
> So we need to look at the performance states of the subdomains of a
> master. The way it is done in this patch with help of
> link->performance_state, we don't need that locking while traversing
> the master_links list. Here is how:
>
> - Master's (genpd) master_links list is only updated under master's
>   lock, which we have already taken here. So master_links list can't
>   get updated concurrently.
>
> - The link->performance_state field of a subdomain (or slave) is only
>   updated from within the master's lock. And we are reading it here
>   from the same lock.
>
> AFAIU, there shouldn't be any deadlocks or locking issues here. Can
> you describe some case that may blow up ?

My main concern is the order of how you take the looks. We never take
a masters lock before the current domain lock.

And when walking the topology, we use the slave links and locks the
first master from that list. Continues with that tree, then get back
to slave list and pick the next master.

If you change that order, we could end getting deadlocks.

[...]

>> A general comment is that I think you should look more closely in the
>> code of genpd_power_off|on(). And also how it calls the
>> ->power_on|off() callbacks.
>>
>> Depending whether you want to update the performance state of the
>> master domain before the subdomain or the opposite, you will find one
>> of them being suited for this case as well.
>
> Isn't it very much similar to that already ? The only major difference
> is link->performance_state and I already explained why is it required
> to be done that way to avoid deadlocks.

No, because you walk the master lists. Thus getting a different order or locks.

I did some drawing of this, using the slave links, and I don't see any
issues why you can't use that instead.

[...]

>> > +{
>> > +       struct generic_pm_domain_data *gpd_data;
>> > +       int ret;
>> > +
>> > +       spin_lock_irq(&dev->power.lock);
>>
>> Actually there is no need to use this lock.
>>
>> Because you hold the genpd lock here, then the device can't be removed
>> from its genpd and thus there is always a valid gpd_data.
>
> I am afraid we still need this lock.
>
> genpd_free_dev_data() is called from genpd_remove_device() without
> genpd lock and so it is possible that we reach here after that lock is
> dropped from genpd_remove_device() but before genpd_free_dev_data() is
> called.
>
> Right ?

I must had something else in mind, because you are absolutely correct.

Sorry for the noise.

[...]

Kind regards
Uffe
