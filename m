From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v6 07/14] sched/topology: Introduce sched_energy_present
 static key
Date: Thu, 6 Sep 2018 10:29:56 +0100
Message-ID: <20180906092955.tq27mhzfkovo2ehn@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-8-quentin.perret@arm.com>
 <f206f192-1bbf-f868-c8c6-8215334639db@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f206f192-1bbf-f868-c8c6-8215334639db@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Dietmar,

On Wednesday 05 Sep 2018 at 23:06:38 (-0700), Dietmar Eggemann wrote:
> On 08/20/2018 02:44 AM, Quentin Perret wrote:
> > In order to ensure a minimal performance impact on non-energy-aware
> > systems, introduce a static_key guarding the access to Energy-Aware
> > Scheduling (EAS) code.
> > 
> > The static key is set iff all the following conditions are met for at
> > least one root domain:
> >    1. all online CPUs of the root domain are covered by the Energy
> >       Model (EM);
> >    2. the complexity of the root domain's EM is low enough to keep
> >       scheduling overheads low;
> >    3. the root domain has an asymmetric CPU capacity topology (detected
> >       by looking for the SD_ASYM_CPUCAPACITY flag in the sched_domain
> >       hierarchy).
> 
> This is pretty much the list (+ is schedutil running) of conditions to set
> rd->pd != NULL in build_perf_domains().

Yes, exactly. I actually loop over the rds to check if one of them has a
pd != NULL in order to enable/disable the static key. So the check for
those conditions is always done at the rd level.

> So when testing 'static_branch_unlikely(&sched_energy_present) &&
> rcu_dereference(rd->pd)' don't you test two times the same thing?

Well, not exactly. You could have two rds in your system, and only one
of the two has an Energy Model. The static key is just a performance
optimization for !EAS systems really. But I must admit it sort of lost a
bit of its interest over the versions. I mean, it's not that clear now
that a static key is a better option than a sched_feat as you suggest
below.

> Also, if let's say somebody wants to run another EM user (e.g. a thermal
> governor, like IPA) but not EAS on a asymmetric CPU capacity system. This
> can't be achieved with the current static branch approach

I assume you're talking about IPA once migrated to using the EM
framework ? In this case, I think you're right, we won't have a single
tunable left to enable/disable EAS. On a big.LITTLE platform, if you
want IPA, EAS will always be enabled by side effect ...

That's a very good point actually. I think some people will not be happy
with that. There are big.LITTLE users (not very many of them, but still)
who don't care that much about energy, but do about performance. And
those guys might want to use IPA without EAS. So I guess we really need
a new knob.

> So what about using a (disabled by default ?) sched_feature + rd->pd != NULL
> instead?

Right, that's an option. I could remove the static key and
sched_energy_start() altogether and replace all the
"if (static_branch_unlikely(&sched_energy_present))" by
"if (sched_feat(ENERGY_AWARE))" for example. That should be equivalent
to what I did with the static key from a performance standpoint. But that
would mean users have to manually flip switches to get EAS up and
running ... I assume it's the price to pay for configurability.

Another option would be a KConfig option + static key. I could keep all
of the ifdefery inside an accessor function like the following:

	static inline bool sched_energy_aware(void)
	{
	#ifdef CONFIG_SCHED_ENERGY
		return static_branch_likely(&sched_energy_present);
	#else
		return false;
	#endif
	}

Now, I understand that scheduler-related KConfig options aren't welcome
in general, so I tend to prefer the sched_feat option.

Thoughts ?

Thanks,
Quentin
