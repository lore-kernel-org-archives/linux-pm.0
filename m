From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC PATCH 3/4] intel_pstate: support scheduler cpufreq
 callbacks on remote CPUs
Date: Wed, 20 Apr 2016 19:20:15 -0700
Message-ID: <20160421022015.GA10028@sky.smuckle.net>
References: <1461119969-10371-1-git-send-email-smuckle@linaro.org>
 <1461119969-10371-3-git-send-email-smuckle@linaro.org>
 <48732338.GBX16FRDRa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34365 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbcDUCUT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 22:20:19 -0400
Received: by mail-pa0-f46.google.com with SMTP id r5so21432434pag.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Apr 2016 19:20:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48732338.GBX16FRDRa@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Wed, Apr 20, 2016 at 02:37:18PM +0200, Rafael J. Wysocki wrote:
...
> > @@ -1173,20 +1179,88 @@ static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
> >  		get_avg_frequency(cpu));
> >  }
> >  
> > +static void _intel_pstate_update_util(struct cpudata *cpu, u64 time)
> 
> What about calling this intel_pstate_update_cpu()?

Sure will change.

...
> >  static void intel_pstate_update_util(struct update_util_data *data, u64 time,
> >  				     unsigned long util, unsigned long max)
> >  {
> >  	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
> > -	u64 delta_ns = time - cpu->sample.time;
> > +	s64 delta_ns = time - cpu->sample.time;
> >  
> > -	if ((s64)delta_ns >= pid_params.sample_rate_ns) {
> > -		bool sample_taken = intel_pstate_sample(cpu, time);
> > +	if (delta_ns < pid_params.sample_rate_ns)
> 
> Why don't you check cpu->ipi_in_progress here too and bail out if it is set?
> 
> That would allow you to avoid checking the time again below, woulnd't it?

Yeah I think that should work. I can't recall why I thought I needed
to check the time first, then ipi_in_progress, then the time. As long
as ipi_in_progress is checked prior to the time, it should be fine.

> 
> > +		return;
> >  
> > -		if (sample_taken && !hwp_active)
> > -			intel_pstate_adjust_busy_pstate(cpu);
> > +	if (cpu->cpu == smp_processor_id()) {
> > +		_intel_pstate_update_util(cpu, time);
> > +	} else {
> > +		/* The target CPU's rq lock is held. */
> > +		if (cpu->ipi_in_progress)
> > +			return;
> > +
> > +		/* Re-check sample_time which may have advanced. */
> > +		smp_rmb();
> > +		delta_ns = time - READ_ONCE(cpu->sample.time);
> > +		if (delta_ns < pid_params.sample_rate_ns)
> > +			return;
> > +
> > +		cpu->ipi_in_progress = true;
> > +		cpu->time = time;
> > +		irq_work_queue_on(&cpu->irq_work, cpu->cpu);
> >  	}
> >  }
> >  
> > +static inline void intel_pstate_irq_work_sync(unsigned int cpu)
> > +{
> > +	irq_work_sync(&all_cpu_data[cpu]->irq_work);
> > +}
> > +
> > +static inline void intel_pstate_init_irq_work(struct cpudata *cpu)
> > +{
> > +	init_irq_work(&cpu->irq_work, intel_pstate_update_util_remote);
> > +}
> > +#else /* !CONFIG_SMP */
> > +static inline void intel_pstate_irq_work_sync(unsigned int cpu) {}
> > +static inline void intel_pstate_init_irq_work(struct cpudata *cpu) {}
> > +
> > +static void intel_pstate_update_util(struct update_util_data *data, u64 time,
> > +				     unsigned long util, unsigned long max)
> > +{
> > +	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
> > +	s64 delta_ns = time - cpu->sample.time;
> > +
> > +	if (delta_ns < pid_params.sample_rate_ns)
> > +		return;
> > +
> > +	_intel_pstate_update_util(cpu, time);
> > +}
> > +#endif
> > +
> > +
> > +
> 
> The additional two empty lines are not necessary.
> 

Sorry yeah these were unintentional, will remove these and the ones below.

Thanks for the review.

thanks,
Steve
