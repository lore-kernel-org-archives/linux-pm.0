From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V8 1/6] PM / Domains: Add support to select
 performance-state of domains
Date: Sat, 29 Jul 2017 10:24:00 +0200
Message-ID: <CAPDyKFrt8_dWZSFYh3ERfDSxBGjfEHFEYbeMnnT7tfNKnBp6dw@mail.gmail.com>
References: <cover.1498026827.git.viresh.kumar@linaro.org> <52daf22d2c9d92b0e61c8c5c5a88516d7a08a31a.1498026827.git.viresh.kumar@linaro.org>
 <CAPDyKFqaFvET9yM_6wr7b1Zw=hePQrE-Ak-7YPCR9izooh4LBA@mail.gmail.com>
 <20170719123751.GF352@vireshk-i7> <CAPDyKFr0ZMeS=57p48W9f_j3U0T41msxOqQHBXB_soA8-weM+w@mail.gmail.com>
 <20170728110030.GG352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35501 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753459AbdG2IYB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 Jul 2017 04:24:01 -0400
Received: by mail-qt0-f170.google.com with SMTP id p3so87514398qtg.2
        for <linux-pm@vger.kernel.org>; Sat, 29 Jul 2017 01:24:01 -0700 (PDT)
In-Reply-To: <20170728110030.GG352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>

On 28 July 2017 at 13:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 21-07-17, 10:35, Ulf Hansson wrote:
>> >> > +/*
>> >> > + * Returns true if anyone in genpd's parent hierarchy has
>> >> > + * set_performance_state() set.
>> >> > + */
>> >> > +static bool genpd_has_set_performance_state(struct generic_pm_domain *genpd)
>> >> > +{
>> >>
>> >> So this function will be become in-directly called by generic drivers
>> >> that supports DVFS of the genpd for their devices.
>> >>
>> >> I think the data you validate here would be better to be pre-validated
>> >> at pm_genpd_init() and at pm_genpd_add|remove_subdomain() and the
>> >> result stored in a variable in the genpd struct. Especially when a
>> >> subdomain is added, that is a point when you can verify the
>> >> *_performance_state() callbacks, and thus make sure it's a correct
>> >> setup from the topology point of view.
>
> Looks like I have to keep this routine as is and your solution may not
> work well. :(
>
>> > Something like this ?
>> >
>> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> > index 4a898e095a1d..182c1911ea9c 100644
>> > --- a/drivers/base/power/domain.c
>> > +++ b/drivers/base/power/domain.c
>> > @@ -466,25 +466,6 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
>> >         return NOTIFY_DONE;
>> >  }
>> >
>> > -/*
>> > - * Returns true if anyone in genpd's parent hierarchy has
>> > - * set_performance_state() set.
>> > - */
>> > -static bool genpd_has_set_performance_state(struct generic_pm_domain *genpd)
>> > -{
>> > -       struct gpd_link *link;
>> > -
>> > -       if (genpd->set_performance_state)
>> > -               return true;
>> > -
>> > -       list_for_each_entry(link, &genpd->slave_links, slave_node) {
>> > -               if (genpd_has_set_performance_state(link->master))
>> > -                       return true;
>> > -       }
>> > -
>> > -       return false;
>> > -}
>> > -
>> >  /**
>> >   * pm_genpd_has_performance_state - Checks if power domain does performance
>> >   * state management.
>> > @@ -507,7 +488,7 @@ bool pm_genpd_has_performance_state(struct device *dev)
>> >
>> >         /* The parent domain must have set get_performance_state() */
>> >         if (!IS_ERR(genpd) && genpd->get_performance_state) {
>> > -               if (genpd_has_set_performance_state(genpd))
>> > +               if (genpd->can_set_performance_state)
>> >                         return true;
>> >
>> >                 /*
>> > @@ -1594,6 +1575,8 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
>> >         if (genpd_status_on(subdomain))
>> >                 genpd_sd_counter_inc(genpd);
>> >
>> > +       subdomain->can_set_performance_state += genpd->can_set_performance_state;
>> > +
>> >   out:
>> >         genpd_unlock(genpd);
>> >         genpd_unlock(subdomain);
>> > @@ -1654,6 +1637,8 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>> >                 if (genpd_status_on(subdomain))
>> >                         genpd_sd_counter_dec(genpd);
>> >
>> > +               subdomain->can_set_performance_state -= genpd->can_set_performance_state;
>> > +
>> >                 ret = 0;
>> >                 break;
>> >         }
>> > @@ -1721,6 +1706,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>> >         genpd->max_off_time_changed = true;
>> >         genpd->provider = NULL;
>> >         genpd->has_provider = false;
>> > +       genpd->can_set_performance_state = !!genpd->set_performance_state;
>> >         genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
>> >         genpd->domain.ops.runtime_resume = genpd_runtime_resume;
>> >         genpd->domain.ops.prepare = pm_genpd_prepare;
>> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> > index bf90177208a2..995d0cb1bc14 100644
>> > --- a/include/linux/pm_domain.h
>> > +++ b/include/linux/pm_domain.h
>> > @@ -64,6 +64,7 @@ struct generic_pm_domain {
>> >         unsigned int suspended_count;   /* System suspend device counter */
>> >         unsigned int prepared_count;    /* Suspend counter of prepared devices */
>> >         unsigned int performance_state; /* Max requested performance state */
>> > +       unsigned int can_set_performance_state; /* Number of parent domains supporting set state */
>> >         int (*power_off)(struct generic_pm_domain *domain);
>> >         int (*power_on)(struct generic_pm_domain *domain);
>> >         int (*get_performance_state)(struct device *dev, unsigned long rate);
>> >
>>
>> Yes!
>
> The above diff will work fine only for the case where the master
> domain has all its masters set properly before genpd_add_subdomain()
> is called for the subdomain, as the genpd->can_set_performance_state
> count wouldn't change after that. But if the masters of the
> master are linked to the master after genpd_add_subdomain() is called
> for the subdomain, then we wouldn't be update the
> subdomain->can_set_performance_state field later.
>
> For example, consider this scenario:
>
>                Domain A (has set_performance_state())
>
>        Domain B                Domain C        (both don't have set_performance_state())
>
>        Domain D                Domain E         (both don't have set_performance_state(), but have get_performance_state())
>
>
> and here is the call sequence:
>
> genpd_add_subdomain(B, D); can_set_performance_state of B and D = 0;
> genpd_add_subdomain(C, E); ... C and E = 0;
> genpd_add_subdomain(A, B); ... A = 1, B = 1;
> genpd_add_subdomain(A, C); ... A = 1, C = 1;
>
> While the count is set properly for A, B and C, it isn't propagated to
> C and E. :(
>
> Though everything would have worked fine if we had this sequence:
>
> genpd_add_subdomain(A, B); ... A = 1, B = 1;
> genpd_add_subdomain(A, C); ... A = 1, C = 1;
> genpd_add_subdomain(B, D); ... D = 1 ;
> genpd_add_subdomain(C, E); ... E = 1;
>
> How to fix it? I tried solving that by propagating the count to all
> the subdomains of the subdomain getting added here. But that requires
> locking and we can't do that in the reverse direction :(

Yeah, you are right!

>
> Anyway, genpd_has_set_performance_state() is supposed to be called
> only ONCE by the drivers and so its fine if we have to traverse the
> list of subdomains there.
>
> I will keep the original code unless you suggest a good way of getting
> around that.

Let's invent a new genpd flag, GENPD_FLAG_PERF_STATE!

The creator of the genpd then needs to set this before calling
pm_genpd_init(). Similar as we are dealing with GENPD_FLAG_PM_CLK.

The requirement for GENPD_FLAG_PERF_STATES, is to have the
->get_performance_state() assigned. This shall be verified during
pm_genpd_init().

The pm_genpd_has_performance_state() then only need to return true, in
cases the device's genpd has GENPD_FLAG_PERF_STATE set - else false.

Regarding ->set_performance_state(), let's just make it optional - and
when trying to set a new performance state, just walk the genpd
hierarchy, from bottom to up, then invoke the callback when it's
assigned.

Kind regards
Uffe
