From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Date: Mon, 11 Feb 2019 14:08:29 +0000
Message-ID: <20190211140829.GA4269@e107155-lin>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
 <20190208110053.GA7913@e107155-lin>
 <87302853-74cc-8eeb-6bd4-6338746e0738@samsung.com>
 <20190208115122.GA13043@e107155-lin>
 <66b33c07-4970-b60a-d924-d4baba79c836@samsung.com>
 <20190208174131.GB22401@e107155-lin>
 <20190211084714.nq3wqxk66dbrfqvy@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190211084714.nq3wqxk66dbrfqvy@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Gerlach <d-gerlach@ti.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 11, 2019 at 02:17:14PM +0530, Viresh Kumar wrote:
> On 08-02-19, 17:41, Sudeep Holla wrote:
> > Based on Rafael's suggestion, I cooked up something. See if this helps ?
> > The policy to cpu dance can be removed and we can just run through the
> > online cpumask I think.
> >
> > Regards,
> > Sudeep
> >
> > -->8
> >
> > diff --git i/drivers/cpufreq/cpufreq.c w/drivers/cpufreq/cpufreq.c
> > index e35a886e00bc..03d65a02a542 100644
> > --- i/drivers/cpufreq/cpufreq.c
> > +++ w/drivers/cpufreq/cpufreq.c
> > @@ -1640,6 +1640,7 @@ EXPORT_SYMBOL(cpufreq_generic_suspend);
> >  void cpufreq_suspend(void)
> >  {
> >  	struct cpufreq_policy *policy;
> > +	int cpu;
> >
> >  	if (!cpufreq_driver)
> >  		return;
> > @@ -1662,6 +1663,11 @@ void cpufreq_suspend(void)
> >  	}
> >
> >  suspend:
> > +	if (cpufreq_driver->flags & CPUFREQ_DEFER_INIT_DURING_RESUME)
> > +		for_each_active_policy(policy)
> > +			for_each_cpu(cpu, policy->cpus)
> > +				cpufreq_offline(cpu);
>
> You will offline boot-cpu as well :)
>

Indeed, I was just trying to check the idea of flags and clearly missed
the boot cpu :(


[..]

> > @@ -2444,14 +2455,16 @@ static enum cpuhp_state hp_online;
> >
> >  static int cpuhp_cpufreq_online(unsigned int cpu)
> >  {
> > -	cpufreq_online(cpu);
> > +	if (!(cpufreq_driver->flags & CPUFREQ_DEFER_INIT_DURING_RESUME))
> > +		cpufreq_online(cpu);
>
> This isn't correct as we can offline the CPUs without suspend as well
> and cpufreq_online/offline should always be called in such cases.
>

Understood

> Anyways, I have cc'd you on another series which may end up fixing
> this problem as well.

Sure, will have a look.

--
Regards,
Sudeep
