From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH 4/6] sched/fair: Introduce an energy estimation
 helper function
Date: Wed, 21 Mar 2018 14:02:37 +0000
Message-ID: <20180321140235.GA2168@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
 <20180321090430.GA6913@localhost.localdomain>
 <20180321122621.GA13951@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180321122621.GA13951@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@gmail.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 21 Mar 2018 at 12:26:21 (+0000), Patrick Bellasi wrote:
> On 21-Mar 10:04, Juri Lelli wrote:
> > Hi,
> > 
> > On 20/03/18 09:43, Dietmar Eggemann wrote:
> > > From: Quentin Perret <quentin.perret@arm.com>
> > > 
> > > In preparation for the definition of an energy-aware wakeup path, a
> > > helper function is provided to estimate the consequence on system energy
> > > when a specific task wakes-up on a specific CPU. compute_energy()
> > > estimates the OPPs to be reached by all frequency domains and estimates
> > > the consumption of each online CPU according to its energy model and its
> > > percentage of busy time.
> > > 
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > ---
> > >  kernel/sched/fair.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 81 insertions(+)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 6c72a5e7b1b0..76bd46502486 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6409,6 +6409,30 @@ static inline int cpu_overutilized(int cpu)
> > >  }
> > >  
> > >  /*
> > > + * Returns the util of "cpu" if "p" wakes up on "dst_cpu".
> > > + */
> > > +static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
> > > +{
> > > +	unsigned long util = cpu_rq(cpu)->cfs.avg.util_avg;
> > 
> > What about other classes? Shouldn't we now also take into account
> > DEADLINE (as schedutil does)?
> 
> Good point, although that would likely require to factor out from
> schedutil the utilization aggregation function, isn't it?
> 
> > BTW, we now also have a getter method in sched/sched.h; it takes
> > UTIL_EST into account, though. Do we need to take that into account when
> > estimating energy consumption?
> 
> Actually I think that this whole function can be written "just" as:
> 
> ---8<---
>    unsigned long util = cpu_util_wake(cpu);
> 
>    if (cpu != dst_cpu)
>         return util;
> 
>    return min(util + task_util(p), capacity_orig_of(cpu));
> ---8<---
> 

Yes this should be functionally equivalent. However, with your
suggestion you can potentially remove the task contribution from the
cpu_util in cpu_util_wake() and then add it back right after if
cpu==dst_cpu. This is sub-optimal and that's why I implemented things
slightly differently. But maybe this optimization really is too small to
justify the extra complexity involved ...

> which will reuse existing functions as well as getting for free other
> stuff (like the CPU util_est).
> 
> Considering your observation above, it makes also easy to add into
> util the DEADLINE and RT utilizations, just before returning the
> value.
> 
> > > +	unsigned long capacity = capacity_orig_of(cpu);
> > > +
> > > +	/*
> > > +	 * If p is where it should be, or if it has no impact on cpu, there is
> > > +	 * not much to do.
> > > +	 */
> > > +	if ((task_cpu(p) == dst_cpu) || (cpu != task_cpu(p) && cpu != dst_cpu))
> > > +		goto clamp_util;
> > > +
> > > +	if (dst_cpu == cpu)
> > > +		util += task_util(p);
> > > +	else
> > > +		util = max_t(long, util - task_util(p), 0);
> > > +
> > > +clamp_util:
> > > +	return (util >= capacity) ? capacity : util;
> > > +}
> > > +
> > > +/*
> > >   * Disable WAKE_AFFINE in the case where task @p doesn't fit in the
> > >   * capacity of either the waking CPU @cpu or the previous CPU @prev_cpu.
> > >   *
> > > @@ -6432,6 +6456,63 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
> > >  	return !util_fits_capacity(task_util(p), min_cap);
> > >  }
> > >  
> > > +static struct capacity_state *find_cap_state(int cpu, unsigned long util)
> > > +{
> > > +	struct sched_energy_model *em = *per_cpu_ptr(energy_model, cpu);
> > > +	struct capacity_state *cs = NULL;
> > > +	int i;
> > > +
> > > +	/*
> > > +	 * As the goal is to estimate the OPP reached for a specific util
> > > +	 * value, mimic the behaviour of schedutil with a 1.25 coefficient
> > > +	 */
> > > +	util += util >> 2;
> > 
> > What about other governors (ondemand for example). Is this supposed to
> > work only when schedutil is in use (if so we should probably make it
> > conditional on that)?
> 
> Yes, I would say that EAS mostly makes sense when you have a "minimum"
> control on OPPs... otherwise all the energy estimations are really
> fuzzy.
> 
> > Also, even when schedutil is in use, shouldn't we ask it for a util
> > "computation" instead of replicating its _current_ heuristic?
> 
> Are you proposing to have the 1.25 factor only here and remove it from
> schedutil?
> 
> > I fear  the two might diverge in the future.
> 
> That could be avoided by factoring out from schedutil the
> "compensation" factor into a proper function to be used by all the
> interested playes, isn't it?
> 
> -- 
> #include <best/regards.h>
> 
> Patrick Bellasi
