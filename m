From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v2 01/10] drivers base/arch_topology: free cpumask
 cpus_to_visit
Date: Thu, 6 Jul 2017 11:59:21 +0100
Message-ID: <20170706105921.hbio5jrwsb4xlxeu@e106622-lin>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-2-dietmar.eggemann@arm.com>
 <20170706102249.GA13048@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170706102249.GA13048@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 06/07/17 15:52, Viresh Kumar wrote:
> On 06-07-17, 10:49, Dietmar Eggemann wrote:

[...]

> >  static void parsing_done_workfn(struct work_struct *work)
> >  {
> > +	free_cpumask_var(cpus_to_visit);
> >  	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
> >  					 CPUFREQ_POLICY_NOTIFIER);
> 
> As a general rule (and good coding practice), it is better to free resources
> only after the users are gone. And so we should have changed the order here.
> i.e. Unregister the notifier first and then free the cpumask.
> 
> And because of that we may end up crashing the kernel here.
> 
> Here is an example:
> 
> Consider that init_cpu_capacity_callback() is getting called concurrently on big
> and LITTLE CPUs.
> 
> 
> CPU0 (big)                            CPU4 (LITTLE)
> 
>                                       if (cap_parsing_failed || cap_parsing_done)
>                                           return 0;
> 

But, in this case the policy notifier for LITTLE cluster has not been
executed yet, so the domain's CPUs have not yet been cleared out from
cpus_to_visit. CPU0 won't see the mask as empty then, right?

> cap_parsing_done = true;
> schedule_work(&parsing_done_work);
> 
> parsing_done_workfn(work)
>   -> free_cpumask_var(cpus_to_visit);
>   -> cpufreq_unregister_notifier()
> 
> 
>                                       switch (val) {
>                                           ...
>                                           /* Touch cpus_to_visit and crash */
> 
> 
> My assumption here is that the same notifier head can get called in parallel on
> two CPUs as all I see there is a down_read() in __blocking_notifier_call_chain()
> which shouldn't block parallel calls.
> 

If that's the case I'm wondering however if we need explicit
synchronization though. Otherwise both threads can read the mask as
full, clear only their bits and not schedule the workfn?

But, can the policies be concurrently initialized? Or is the
initialization process serialized or the different domains?

Thanks,

- Juri
