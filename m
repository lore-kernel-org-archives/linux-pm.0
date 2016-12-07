From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 07/10] PM / OPP: Don't allocate OPP table from
 _opp_allocate()
Date: Wed, 7 Dec 2016 14:05:25 -0800
Message-ID: <20161207220525.GB5423@codeaurora.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <ab1dbd94f4638ac04a9dd4b526ddaaf136154dd1.1481015522.git.viresh.kumar@linaro.org>
 <20161207010221.GE4388@codeaurora.org>
 <20161207041744.GF31255@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56072 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932595AbcLGWF2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 17:05:28 -0500
Content-Disposition: inline
In-Reply-To: <20161207041744.GF31255@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/07, Viresh Kumar wrote:
> On 06-12-16, 17:02, Stephen Boyd wrote:
> > On 12/06, Viresh Kumar wrote:
> > > diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> > > index ef114cf9edcd..6bcbb64a5582 100644
> > > --- a/drivers/base/power/opp/core.c
> > > +++ b/drivers/base/power/opp/core.c
> > > @@ -1030,33 +1029,24 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
> > >  EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
> > >  
> > >  struct dev_pm_opp *_opp_allocate(struct device *dev,
> > > -				 struct opp_table **opp_table)
> > > +				 struct opp_table *opp_table)
> > 
> > Please call it table instead.
> 
> Sure.
> 
> > >  {
> > >  	struct dev_pm_opp *opp;
> > >  	int count, supply_size;
> > > -	struct opp_table *table;
> > > -
> > > -	table = _add_opp_table(dev);
> > 
> > Is this the only user of dev? Why do we keep passing dev to this
> > function then?
> 
> Because we are still working with struct list_dev, which needs to save
> a pointer to dev. We may simplify that with later series though, not
> sure yet.

Sorry I don't understand. After this patch it looks like dev is
unused in the function because we delete the only user
_add_opp_table().

> 
> > > +int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
> > > +		unsigned long freq, long u_volt, bool dynamic)
> > >  {
> > > -	struct opp_table *opp_table;
> > >  	struct dev_pm_opp *new_opp;
> > >  	unsigned long tol;
> > >  	int ret;
> > >  
> > > -	/* Hold our table modification lock here */
> > > -	mutex_lock(&opp_table_lock);
> > 
> > Can we have a mutex locked assertion here? Or a note in the
> > comments that we assume the opp table lock is held?
> 
> Done.
> 
> > > -
> > > -	new_opp = _opp_allocate(dev, &opp_table);
> > > -	if (!new_opp) {
> > > -		ret = -ENOMEM;
> > > -		goto unlock;
> > > -	}
> > > +	new_opp = _opp_allocate(dev, opp_table);
> > > +	if (!new_opp)
> > > +		return -ENOMEM;
> > >  
> > >  	/* populate the opp table */
> > >  	new_opp->rate = freq;
> > 
> > Also, now we call the srcu notifier chain with the opp_table_lock
> > held? That seems not so good. Do we need to drop it and reaquire
> > the lock across the table lock? Or perhaps we should rethink
> > widening the lock this much across the notifier.
> 
> Hmm, fair point but:
> - The OPP notifiers are used only by devfreq and no one else. So the
>   most common case of cpufreq will be just fine.
> - The lock is taken across only OPP_EVENT_ADD event and that doesn't
>   get called all the time. Normally it will happen only at boot (once
>   for each OPP) and that's it. I am not sure if we should actually
>   remove the notifier completely going forward.
> - Looking at devfreq implementation it seems that they are mostly
>   interested in the updates to the OPP nodes.
> - The later series (which I may post today as this one is reviewed
>   mostly), will simplify it a lot. The lock wouldn't be taken across
>   any big parts as we will use kref instead.
> - So, I would like to keep this patch as is as this is going to be
>   sorted out anyway.

I haven't looked at the next round of patches. If the lock is
still held across the notifier for OPP_EVENT_ADD then it would
seem that we should get some sort of lockdep splat if the
notified functions want to call back into the OPP code and that
takes the same lock we held across the notifier. Even if it would
work for the other notifiers that aren't OPP_EVENT_ADD, lockdep
wouldn't know that because of locking classes, hence the splat.
That's my only concern. Obviously if the locking is going away
then it's just a bisection hole problem that I'm willing to
ignore.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
