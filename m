From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v2 4/6] sched/fair: Introduce an energy estimation
 helper function
Date: Tue, 10 Apr 2018 14:56:41 +0100
Message-ID: <20180410135640.GB3866@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
 <20180410125105.GC4043@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180410125105.GC4043@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 10 Apr 2018 at 14:51:05 (+0200), Peter Zijlstra wrote:
> On Fri, Apr 06, 2018 at 04:36:05PM +0100, Dietmar Eggemann wrote:
> > +static inline
> > +struct capacity_state *find_cap_state(int cpu, unsigned long util)
> > +{
> > +	struct sched_energy_model *em = *per_cpu_ptr(energy_model, cpu);
> > +	struct capacity_state *cs = NULL;
> > +	int i;
> > +
> > +	util += util >> 2;
> > +
> > +	for (i = 0; i < em->nr_cap_states; i++) {
> > +		cs = &em->cap_states[i];
> > +		if (cs->cap >= util)
> > +			break;
> > +	}
> > +
> > +	return cs;
> > +}
> 
> So in the last thread there was some discussion about this; in
> particular on how this related to schedutil and if we should tie it into
> that.
> 
> I think for starters tying it to schedutil is not a bad idea; ideally
> people _should_ migrate towards using that.
> 
> Also; I think it makes sense to better integrate cpufreq and the
> energy-model values like what rjw already suggested, such that maybe we
> can have cpufreq_driver_resolve_freq() return a structure containing the
> relevant information for the selected frequency.

I guess if we want to do that in the wake-up path, we would also need to
add a new parameter to it to make sure we don't actually call into
cpufreq_driver->resolve_freq() ...

But then, we could sort of rely on cpufreq_schedutil.c::get_next_freq()
to replace find_cap_state() ... Is this what you had in mind ?

> 
> But implementing the frequency selection thing in multiple places like
> now sounds like a very bad idea to me.

Understood. Making sure we share the same code everywhere might have
consequences though. I guess we'll have to either accept the cost of
function calls in the wake-up path, or to accept to inline those
functions for ex. Or maybe you had something else in mind ?

Anyways, that's probably another good discussion topic for OSPM
next week :-)

Thanks,
Quentin
