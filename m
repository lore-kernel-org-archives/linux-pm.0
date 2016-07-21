From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/3] cpufreq: add cpufreq_driver_resolve_freq()
Date: Thu, 21 Jul 2016 22:52:43 +0200
Message-ID: <1628802.LW0F6bbOgI@vostro.rjw.lan>
References: <1468441527-23534-1-git-send-email-smuckle@linaro.org> <2012245.HQXNKhffmu@vostro.rjw.lan> <20160721203041.GH3122@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57653 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753968AbcGUUrr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2016 16:47:47 -0400
In-Reply-To: <20160721203041.GH3122@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>

On Thursday, July 21, 2016 01:30:41 PM Viresh Kumar wrote:
> On 21-07-16, 22:31, Rafael J. Wysocki wrote:
> > On Thursday, July 21, 2016 12:59:26 PM Viresh Kumar wrote:
> > > On 13-07-16, 13:25, Steve Muckle wrote:
> > > > Cpufreq governors may need to know what a particular target frequency
> > > > maps to in the driver without necessarily wanting to set the frequency.
> > > > Support this operation via a new cpufreq API,
> > > > cpufreq_driver_resolve_freq(). This API returns the lowest driver
> > > > frequency equal or greater than the target frequency
> > > > (CPUFREQ_RELATION_L), subject to any policy (min/max) or driver
> > > > limitations. The mapping is also cached in the policy so that a
> > > > subsequent fast_switch operation can avoid repeating the same lookup.
> > > > 
> > > > The API will call a new cpufreq driver callback, resolve_freq(), if it
> > > > has been registered by the driver. Otherwise the frequency is resolved
> > > > via cpufreq_frequency_table_target(). Rather than require ->target()
> > > > style drivers to provide a resolve_freq() callback it is left to the
> > > > caller to ensure that the driver implements this callback if necessary
> > > > to use cpufreq_driver_resolve_freq().
> > > > 
> > > > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Signed-off-by: Steve Muckle <smuckle@linaro.org>
> > > > ---
> > > >  drivers/cpufreq/cpufreq.c | 25 +++++++++++++++++++++++++
> > > >  include/linux/cpufreq.h   | 16 ++++++++++++++++
> > > >  2 files changed, 41 insertions(+)
> > > > 
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index 118b4f30a406..b696baeb249d 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -492,6 +492,29 @@ void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
> > > >  
> > > > +/**
> > > > + * cpufreq_driver_resolve_freq - Map a target frequency to a driver-supported
> > > > + * one.
> > > > + * @target_freq: target frequency to resolve.
> > > > + *
> > > > + * The target to driver frequency mapping is cached in the policy.
> > > > + *
> > > > + * Return: Lowest driver-supported frequency greater than or equal to the
> > > > + * given target_freq, subject to policy (min/max) and driver limitations.
> > > > + */
> > > > +unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
> > > > +					 unsigned int target_freq)
> > > > +{
> > > > +	target_freq = clamp_val(target_freq, policy->min, policy->max);
> > > > +	policy->cached_target_freq = target_freq;
> > > > +	if (cpufreq_driver->resolve_freq)
> > > > +		return cpufreq_driver->resolve_freq(policy, target_freq);
> > > 
> > > Any reason why we still have this call around ? I thought the whole
> > > attempt I made was to get rid of this :)
> > > 
> > > The core can do this pretty much now by itself, why do we still want
> > > this call?
> > 
> > In case some drivers that don't use frequency tables want to implemet
> > fast switching, for example.
> 
> Okay, but in that case shouldn't we do something like this:

That'd be fine by me.

Please send a patch on top of the Steve's series and I can apply it too
(unless Steve sees some major problems in it, which seems unlikely to me).

> unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>                                         unsigned int target_freq)
> {
>        target_freq = clamp_val(target_freq, policy->min, policy->max);
>        policy->cached_target_freq = target_freq;
> 
>        if (cpufreq_driver->target_index) {
>        		policy->cached_resolved_idx =
>        		        cpufreq_frequency_table_target(policy, target_freq,
>        		                                       CPUFREQ_RELATION_L);
>        		return policy->freq_table[policy->cached_resolved_idx].frequency;
>        }
> 
>        if (cpufreq_driver->resolve_freq)
>                return cpufreq_driver->resolve_freq(policy, target_freq);
> }
> 
> ??

Thanks,
Rafael

