From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V8 1/6] PM / Domains: Add support to select
 performance-state of domains
Date: Mon, 24 Jul 2017 16:02:25 +0530
Message-ID: <20170724103225.GW352@vireshk-i7>
References: <cover.1498026827.git.viresh.kumar@linaro.org>
 <52daf22d2c9d92b0e61c8c5c5a88516d7a08a31a.1498026827.git.viresh.kumar@linaro.org>
 <CAPDyKFqaFvET9yM_6wr7b1Zw=hePQrE-Ak-7YPCR9izooh4LBA@mail.gmail.com>
 <20170719123751.GF352@vireshk-i7>
 <CAPDyKFr0ZMeS=57p48W9f_j3U0T41msxOqQHBXB_soA8-weM+w@mail.gmail.com>
 <20170721090519.GO352@vireshk-i7>
 <CAPDyKFo_10Q3GOmygejBjW15jk23tbgDNrK2aMV+DvcF5S8oQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33600 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbdGXKca (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 06:32:30 -0400
Received: by mail-pf0-f176.google.com with SMTP id s70so45486028pfs.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2017 03:32:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFo_10Q3GOmygejBjW15jk23tbgDNrK2aMV+DvcF5S8oQw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>

On 23-07-17, 09:20, Ulf Hansson wrote:
> I should have been more clear. Walking the master list, then checking
> each link without using locks - why is that safe?
> 
> Then even if you think it's safe, then please explain in detail why its needed.
> 
> Walking the slave list as being done for power off/on should work
> perfectly okay for your case as well. No?

I got it. I will try to explain why it is done this way with the help
of two versions of genpd_update_performance_state() routine. The first
one is from a previous version and second one is from the current
series.

Just as a note, the problem is not with traversing slave_links list
but the master_links list.

1.) Previous Version (Have deadlock issues, as you reported then).

>> +static int genpd_update_performance_state(struct generic_pm_domain *genpd,
>> +                                         int depth)
>> +{

The genpd is already locked here..

>> +       struct generic_pm_domain_data *pd_data;
>> +       struct generic_pm_domain *subdomain;
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

Above is fine as we traversed list of devices that are powered by the
PM domain. No additional locks are required.

>> +       /* Traverse all subdomains within the domain */
>> +       list_for_each_entry(link, &genpd->master_links, master_node) {
>> +               subdomain = link->slave;
>> +
>> +               if (subdomain->performance_state > state)
>> +                       state = subdomain->performance_state;
>> +       }

But this is not fine at all. subdomain->performance_state might get
updated from another thread for another genpd. And so we need locking
here, but we can't do that as we need to take locks starting from
slaves to masters. This is what you correctly pointed out in earlier
versions.

>> +       if (genpd->performance_state == state)
>> +               return 0;
>> +
>> +       /*
>> +        * Not all domains support updating performance state. Move on to their
>> +        * parent domains in that case.
>> +        */
>> +       if (genpd->set_performance_state) {
>> +               ret = genpd->set_performance_state(genpd, state);
>> +               if (!ret)
>> +                       genpd->performance_state = state;
>> +
>> +               return ret;
>> +       }
>> +
>> +       prev = genpd->performance_state;
>> +       genpd->performance_state = state;

This is racy as well (because of the earlier traversal of
master-list), as genpd->performance_state might be getting read for
one of its masters currently (from another instance of this same
routine).

>> +
>> +       list_for_each_entry(link, &genpd->slave_links, slave_node) {
>> +               struct generic_pm_domain *master = link->master;
>> +
>> +               genpd_lock_nested(master, depth + 1);
>> +               ret = genpd_update_performance_state(master, depth + 1);
>> +               genpd_unlock(master);
>>
>>                 ... Handle errors here.
>> +       }
>> +
>> +       return 0;
>> +}

So the conclusion was that we surely can't lock the subdomains while
running genpd_update_performance_state() for a master genpd.

And that's what the below latest code tried to address.

2.) New code, which shouldn't have any of those deadlock issues.
 
>> +static int genpd_update_performance_state(struct generic_pm_domain *genpd,

genpd is still locked from its caller.

>> +                                         int depth)
>> +{
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

Above remains the same and shouldn't have any issues.

>> +       /* Traverse all subdomains within the domain */
>> +       list_for_each_entry(link, &genpd->master_links, master_node) {
>> +               if (link->performance_state > state)
>> +                       state = link->performance_state;
>> +       }
>> +

Instead of a single performance_state field for the entire subdomain
structure, we store a performance_state value for each
master <-> subdomain pair. And this field is protected by the master
lock, always.

Since the genpd was already locked, the link->performance_state field
of all its subdomains can be accessed without further locking.

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

Lets look at the below one now.

>> +       list_for_each_entry(link, &genpd->slave_links, slave_node) {
>> +               master = link->master;
>> +
>> +               genpd_lock_nested(master, depth + 1);
>> +
>> +               link->performance_state = state;

(I incorrectly mentioned in my last reply to you that this can be
present outside of the lock, this can't be.)

So here we have taken the master's lock and updated the link shared
between master <-> subdomain (genpd here).

>> +               ret = genpd_update_performance_state(master, depth + 1);

So when this recursive call is made for the "master" domain, it will
read link->performance_state of all its subdomains (from the earlier
for-loop) and the current "genpd" domain will be part of that
master-list. And that's why we updated link->performance_state before
calling the genpd_update_performance_state() routine above, so that
its new value can be available.

IOW, we can't have a race now where link->performance_state for any of
the subdomains of genpd is read/updated in parallel.

>> +               if (ret)
>> +                       link->performance_state = prev;
>> +
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

And once we are done with all the master domains, we can update the
genpd->performance_state safely.

>> +       genpd->performance_state = state;
>> +       return 0;
>> +
>> +err:
>>         ...
>> +}
>> +

Was I able to clarify your doubts ?

-- 
viresh
