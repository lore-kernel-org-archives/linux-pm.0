From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 5/8] PM / OPP: Add infrastructure to manage multiple
 regulators
Date: Wed, 9 Nov 2016 17:37:00 -0800
Message-ID: <20161110013700.GX16026@codeaurora.org>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <32c1feabb59b1f00e1cefde606e3ec7ef738ac12.1476952750.git.viresh.kumar@linaro.org>
 <20161025164953.GT26139@codeaurora.org>
 <20161026060512.GI9162@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35346 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754586AbcKJBhC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2016 20:37:02 -0500
Content-Disposition: inline
In-Reply-To: <20161026060512.GI9162@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org

On 10/26, Viresh Kumar wrote:
> On 25-10-16, 09:49, Stephen Boyd wrote:
> > On 10/20, Viresh Kumar wrote:
> > > diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> > > index 37fad2eb0f47..45c70ce07864 100644
> > > --- a/drivers/base/power/opp/core.c
> > > +++ b/drivers/base/power/opp/core.c
> > > @@ -235,21 +237,44 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
> > >  		return 0;
> > >  	}
> > >  
> > > -	reg = opp_table->regulator;
> > > -	if (IS_ERR(reg)) {
> > > +	count = opp_table->regulator_count;
> > > +
> > > +	if (!count) {
> > >  		/* Regulator may not be required for device */
> > >  		rcu_read_unlock();
> > >  		return 0;
> > >  	}
> > >  
> > > -	list_for_each_entry_rcu(opp, &opp_table->opp_list, node) {
> > > -		if (!opp->available)
> > > -			continue;
> > > +	size = count * sizeof(*regulators);
> > > +	regulators = kmemdup(opp_table->regulators, size, GFP_KERNEL);
> > 
> > How do we allocate under RCU? Doesn't that spit out big warnings?
> 
> That doesn't. I even tried enabling several locking debug config options.

Please read RCU documentation. From rcu_read_lock() function
documentation:

 In non-preemptible RCU implementations (TREE_RCU and TINY_RCU),
 it is illegal to block while in an RCU read-side critical section.
 In preemptible RCU implementations (TREE_PREEMPT_RCU) in CONFIG_PREEMPT
 kernel builds, RCU read-side critical sections may be preempted,
 but explicit blocking is illegal.  Finally, in preemptible RCU
 implementations in real-time (with -rt patchset) kernel builds, RCU
 read-side critical sections may be preempted and they may also block, but
 only when acquiring spinlocks that are subject to priority inheritance.

I suppose that in certain configurations it will warn and in
others it won't. I thought lockdep would always complain though,
so that's sad it doesn't. At least in some implementations of RCU
rcu_read_lock() is the same as preempt_disable(), which basically
means no sleeping calls like GFP_KERNEL allocations.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
