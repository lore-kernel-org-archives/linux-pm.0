From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V8 1/6] PM / Domains: Add support to select
 performance-state of domains
Date: Fri, 21 Jul 2017 14:35:19 +0530
Message-ID: <20170721090519.GO352@vireshk-i7>
References: <cover.1498026827.git.viresh.kumar@linaro.org>
 <52daf22d2c9d92b0e61c8c5c5a88516d7a08a31a.1498026827.git.viresh.kumar@linaro.org>
 <CAPDyKFqaFvET9yM_6wr7b1Zw=hePQrE-Ak-7YPCR9izooh4LBA@mail.gmail.com>
 <20170719123751.GF352@vireshk-i7>
 <CAPDyKFr0ZMeS=57p48W9f_j3U0T41msxOqQHBXB_soA8-weM+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFr0ZMeS=57p48W9f_j3U0T41msxOqQHBXB_soA8-weM+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 21-07-17, 10:35, Ulf Hansson wrote:
> This depends on how drivers are dealing with runtime PM in conjunction
> with the new pm_genpd_update_performance_state().
> 
> In case you don't want to manage some of this in genpd, then each
> driver will have to drop their constraints every time they are about
> to runtime suspend its device. And restore them at runtime resume.
> 
> To me, that's seems like a bad idea. Then it's better to make genpd
> deal with this - somehow.

Right. So we should call the ->set_performance_state() from off/on as
well. Will do that.

> Yes!
> 
> On top of that change, you could also add some validation if the
> get/set callbacks is there are any constraints on how they must be
> assigned.

I am not sure if I understood that, sorry. What other constraints are
you talking about ?

> >> From a locking point of view we always traverse the topology from
> >> bottom an up. In other words, we walk the genpd's ->slave_links, and
> >> lock the masters in the order the are defined via the slave_links
> >> list. The order is important to avoid deadlocks. I don't think you
> >> should walk the master_links as being done above, especially not
> >> without using locks.
> >
> > So we need to look at the performance states of the subdomains of a
> > master. The way it is done in this patch with help of
> > link->performance_state, we don't need that locking while traversing
> > the master_links list. Here is how:
> >
> > - Master's (genpd) master_links list is only updated under master's
> >   lock, which we have already taken here. So master_links list can't
> >   get updated concurrently.
> >
> > - The link->performance_state field of a subdomain (or slave) is only
> >   updated from within the master's lock. And we are reading it here
> >   from the same lock.
> >
> > AFAIU, there shouldn't be any deadlocks or locking issues here. Can
> > you describe some case that may blow up ?
> 
> My main concern is the order of how you take the looks. We never take
> a masters lock before the current domain lock.

Right and this patch doesn't break that.

> And when walking the topology, we use the slave links and locks the
> first master from that list. Continues with that tree, then get back
> to slave list and pick the next master.

Again, that's how this patch does it.

> If you change that order, we could end getting deadlocks.

And because that order isn't changed at all, we shouldn't have
deadlocks.

> >> A general comment is that I think you should look more closely in the
> >> code of genpd_power_off|on(). And also how it calls the
> >> ->power_on|off() callbacks.
> >>
> >> Depending whether you want to update the performance state of the
> >> master domain before the subdomain or the opposite, you will find one
> >> of them being suited for this case as well.
> >
> > Isn't it very much similar to that already ? The only major difference
> > is link->performance_state and I already explained why is it required
> > to be done that way to avoid deadlocks.
> 
> No, because you walk the master lists. Thus getting a different order or locks.
> 
> I did some drawing of this, using the slave links, and I don't see any
> issues why you can't use that instead.

Damn, I am confused on which part are you talking about. Let me paste
the code here once again and clarify how this is supposed to work just fine :)

>> +static int genpd_update_performance_state(struct generic_pm_domain *genpd,
>> +                                         int depth)
>> +{

genpd is already locked.

>> +       struct generic_pm_domain_data *pd_data;
>> +       struct generic_pm_domain *master;
>> +       struct pm_domain_data *pdd;
>> +       unsigned int state = 0, prev;
>> +       struct gpd_link *link;
>> +       int ret;
>> +
>> +       /* Traverse all devices within the domain */
>> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
>> +               pd_data = to_gpd_data(pdd);
>> +
>> +               if (pd_data->performance_state > state)
>> +                       state = pd_data->performance_state;
>> +       }
>> +
>> +       /* Traverse all subdomains within the domain */
>> +       list_for_each_entry(link, &genpd->master_links, master_node) {

This is the only place where we look at all the sub-domains, but we
don't need locking here at all as link->performance_state is only
accessed while "genpd" is locked. It doesn't need sub-domain's lock.

>> +               if (link->performance_state > state)
>> +                       state = link->performance_state;
>> +       }
>> +
>> +       if (genpd->performance_state == state)
>> +               return 0;
>> +
>> +       if (genpd->set_performance_state) {
>> +               ret = genpd->set_performance_state(genpd, state);
>> +               if (!ret)
>> +                       genpd->performance_state = state;
>> +
>> +               return ret;
>> +       }
>> +
>> +       /*
>> +        * Not all domains support updating performance state. Move on to their
>> +        * parent domains in that case.
>> +        */
>> +       prev = genpd->performance_state;
>> +

The below part is what I assumed you were commenting on and this is
very similar to how on/off are implemented today.

>> +       list_for_each_entry(link, &genpd->slave_links, slave_node) {

i.e. we traverse the list of masters from slave_links list.

>> +               master = link->master;
>> +
>> +               genpd_lock_nested(master, depth + 1);

Take master's lock (and "genpd" is already locked when this function
is called.)

>> +
>> +               link->performance_state = state;
>> +               ret = genpd_update_performance_state(master, depth + 1);

Do recursive calling and so the master tree will finish first before
moving to next master.

>> +               if (ret)
>> +                       link->performance_state = prev;
>> +

The above can actually be done outside of this lock as we are only
concerned about "genpd" lock here.

Where do you think the order of locking is screwed up ?

>> +               genpd_unlock(master);
>> +
>> +               if (ret)
>> +                       goto err;
>> +       }
>> +
>> +       /*
>> +        * The parent domains are updated now, lets get genpd performance_state
>> +        * in sync with those.
>> +        */
>> +       genpd->performance_state = state;
>> +       return 0;
>> +
>> +err:
>> +       list_for_each_entry_continue_reverse(link, &genpd->slave_links,
>> +                                            slave_node) {
>> +               master = link->master;
>> +
>> +               genpd_lock_nested(master, depth + 1);
>> +               link->performance_state = prev;
>> +               if (genpd_update_performance_state(master, depth + 1))
>> +                       pr_err("%s: Failed to roll back to %d performance state\n",
>> +                              genpd->name, prev);
>> +               genpd_unlock(master);
>> +       }
>> +
>> +       return ret;
>> +}
>> +

-- 
viresh
