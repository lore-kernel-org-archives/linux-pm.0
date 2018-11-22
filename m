From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 13/15] sched/fair: Introduce an energy estimation
 helper function
Date: Thu, 22 Nov 2018 14:56:06 +0100
Message-ID: <20181122135606.GG2113@hirez.programming.kicks-ass.net>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-14-quentin.perret@arm.com>
 <20181121142803.GF2113@hirez.programming.kicks-ass.net>
 <20181121160524.ulj6n3shb2fdwboj@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181121160524.ulj6n3shb2fdwboj@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 21, 2018 at 04:05:27PM +0000, Quentin Perret wrote:
> On Wednesday 21 Nov 2018 at 15:28:03 (+0100), Peter Zijlstra wrote:
> > On Mon, Nov 19, 2018 at 02:18:55PM +0000, Quentin Perret wrote:
> > > +static long
> > > +compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
> > > +{
> > > +	long util, max_util, sum_util, energy = 0;
> > > +	int cpu;
> > > +
> > > +	for (; pd; pd = pd->next) {
> > > +		max_util = sum_util = 0;
> > > +		/*
> > > +		 * The capacity state of CPUs of the current rd can be driven by
> > > +		 * CPUs of another rd if they belong to the same performance
> > > +		 * domain. So, account for the utilization of these CPUs too
> > > +		 * by masking pd with cpu_online_mask instead of the rd span.
> > > +		 *
> > > +		 * If an entire performance domain is outside of the current rd,
> > > +		 * it will not appear in its pd list and will not be accounted
> > > +		 * by compute_energy().
> > > +		 */
> > > +		for_each_cpu_and(cpu, perf_domain_span(pd), cpu_online_mask) {
> > 
> > Should that not be cpu_active_mask ?
> 
> Hmm, I must admit I'm sometimes a bit confused by the exact difference
> between these masks, so maybe yeah ...
> 
> IIUC, cpu_active_mask is basically the set of CPUs on which the
> scheduler is actually allowed to migrate tasks. Is that correct ?

Yep. Which is a strict subset of online. The difference only matters
during hotplug. We take a CPU out of active before we take if offline
and we add it to active only after the CPU is fully online and
scheduling.

> I have always seen cpu_online_mask as a superset of cpu_active_mask
> which can also include CPUs which are still running 'special' tasks
> (kthreads and things like that I assume) although not allowed for
> migration any more (or not yet) because we're in the process of
> hotplugging that CPU.

Right.

> So, the thing is, I'm not trying to select a CPU candidate for my task
> here, I'm trying to understand what's the energy impact of a migration.
> That involves all CPUs that are running _something_ in a perf domain
> no matter if they're allowed to run more tasks or not. I mean, raising
> the OPP will make running online && !active CPUs more expensive as well.
> That's why I thought cpu_online_mask was good match here.

Ah, fair enough. Thanks!
