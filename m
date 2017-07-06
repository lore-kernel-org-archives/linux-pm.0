From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 01/10] drivers base/arch_topology: free cpumask
 cpus_to_visit
Date: Thu, 6 Jul 2017 16:45:06 +0530
Message-ID: <20170706111506.GB1523@vireshk-i7>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-2-dietmar.eggemann@arm.com>
 <20170706102249.GA13048@vireshk-i7>
 <20170706105921.hbio5jrwsb4xlxeu@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170706105921.hbio5jrwsb4xlxeu@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 06-07-17, 11:59, Juri Lelli wrote:
> On 06/07/17 15:52, Viresh Kumar wrote:

> > CPU0 (big)                            CPU4 (LITTLE)
> > 
> >                                       if (cap_parsing_failed || cap_parsing_done)
> >                                           return 0;
> > 
> 
> But, in this case the policy notifier for LITTLE cluster has not been
> executed yet,

Not necessarily. The cpufreq notifier with CPUFREQ_NOTIFY event can get called
again and again (as soon as the policy is changed, for example min/max changed
from sysfs). And so it is possible that the LITTLE cpus are already cleared from
the mask.

> so the domain's CPUs have not yet been cleared out from
> cpus_to_visit. CPU0 won't see the mask as empty then, right?

And so it can.

> > cap_parsing_done = true;
> > schedule_work(&parsing_done_work);
> > 
> > parsing_done_workfn(work)
> >   -> free_cpumask_var(cpus_to_visit);
> >   -> cpufreq_unregister_notifier()
> > 
> > 
> >                                       switch (val) {
> >                                           ...
> >                                           /* Touch cpus_to_visit and crash */
> > 
> > 
> > My assumption here is that the same notifier head can get called in parallel on
> > two CPUs as all I see there is a down_read() in __blocking_notifier_call_chain()
> > which shouldn't block parallel calls.
> > 
> 
> If that's the case I'm wondering however if we need explicit
> synchronization though. Otherwise both threads can read the mask as
> full, clear only their bits and not schedule the workfn?

Maybe not as the policies are created one by one only, not concurrently.

> But, can the policies be concurrently initialized? Or is the
> initialization process serialized or the different domains?

There can be complex cases here. For example consider this.

Only the little CPUs are brought online at boot. Their policy is set and they
are cleared from the cpus_to_visit mask. Now we try to bring any big CPU online
and at the same time try changing min/max from sysfs for the LITTLE CPU policy.

The notifier may get called concurrently here I believe and cause the problem I
mentioned earlier.

-- 
viresh
