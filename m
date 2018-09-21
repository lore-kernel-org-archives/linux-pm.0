From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Date: Fri, 21 Sep 2018 11:13:08 +0200
Message-ID: <20180921091308.GD24082@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
 <20180914140732.GR1413@e110439-lin>
 <20180914142813.GM24124@hirez.programming.kicks-ass.net>
 <20180917122723.GS1413@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180917122723.GS1413@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 17, 2018 at 01:27:23PM +0100, Patrick Bellasi wrote:
> On 14-Sep 16:28, Peter Zijlstra wrote:

> > The thing is, the values you'd want to use are for example the capacity
> > of the little CPUs. or the capacity of the most energy efficient OPP
> > (the knee).
> 
> I don't think so.
> 
> On the knee topic, we had some thinking and on most platforms it seems
> to be a rather arbitrary decision.
> 
> On sane platforms, the Energy Efficiency (EE) is monotonically
> decreasing with frequency increase.  Maybe we can define a threshold
> for a "EE derivative ratio", but it will still be quite arbitrary.
> Moreover, it could be that in certain use-cases we want to push for
> higher energy efficiency (i.e. lower derivatives) then others.

I remember IBM-power folks asking for knee related features a number of
years ago (Dusseldorf IIRC) because after some point their chips start
to _really_ suck power. Sure, the curve is monotonic, but the perf/watt
takes a nose dive.

And given that: P = CfV^2, that seems like a fairly generic observation.

However, maybe, due to the very limited thermal capacity of these mobile
things, the issue doesn't really arrise in them.

Laptops with active cooling however...

> > Similarly for boosting, how are we 'easily' going to find the values
> > that correspond to the various available OPPs.
> 
> In our experience with SchedTune on Android, we found that we
> generally focus on a small set of representative use-cases and then
> run an exploration, by tuning the percentage of boost, to identify the
> optimal trade-off between Performance and Energy.

So you basically do an automated optimization for a benchmark?

> The value you get could be something which do not match exactly an OPP
> but still, since we (will) bias not only OPP selection but also tasks
> placement, it's the one which makes most sense.

*groan*, so how exactly does that work? By limiting the task capacity,
we allow some stacking on the CPUs before we switch to regular
load-balancing?

> Thus, the capacity of little CPUs, or the exact capacity of an OPP, is
> something we don't care to specify exactly, since:
> 
>  - schedutil will top the util request to the next frequency anyway
> 
>  - capacity by itself is a loosely defined metric, since it's usually
>    measured considering a specific kind of instructions mix, which
>    can be very different from the actual instruction mix (e.g. integer
>    vs floating point)

Sure, things like pure SIMD workloads can skew things pretty bad, but on
average it should not drastically change the overall shape of the curve
and the knee point should not move around a lot.

>  - certain platforms don't even expose OPPs, but just "performance
>    levels"... which ultimately are a "percentage"

Well, the whole capacity thing is a 'percentage', it's just that 1024 is
much nicer to work with (for computers) than 100 is (also it provides a
wee bit more resolution).

But even the platforms with hidden OPPs (can) have knee points, and if
you measure their power to capacity curve you can place a workload
around the knee by capping capacity.

But yes, this gets trick real fast :/

>  - there are so many rounding errors around on utilization tracking
>    and it aggregation that being exact on an OPP if of "relative"
>    importance

I'm not sure I understand that argument; sure the measurement is subject
to 'issues', but if we hard clip the result, that will exactly match the
fixed points for OPP selection. Any issues on the measurement are lost
after clipping.

> Do you see specific use-cases where an exact OPP capacity is much
> better then a percentage value ?

If I don't have algorithmic optimization available, hand selecting an
OPP is the 'obvious' thing to do.

> Of course there can be scenarios in which wa want to clamp to a
> specific OPP. But still, why should it be difficult for a platform
> integrator to express it as a close enough percentage value ?

But why put him through the trouble of finding the capacity value in the
EAS exposed data, converting that to a percentage that will work and
then feeding it back in.

I don't see the point or benefit of percentages, there's nothing magical
about 1/100, _any_ other fraction works exactly the same.

So why bother changing it around?

> > The EAS thing might have these around; but I forgot if/how they're
> > exposed to userspace (I'll have to soon look at the latest posting).
> 
> The new "Energy Model Management" framework can certainly be use to
> get the list of OPPs for each frequency domain. IMO this could be
> used to identify the maximum number of clamp groups we can have.
> In this case, the discretization patch can translate a generic
> percentage clamp into the closest OPP capacity... 
> 
> ... but to me that's an internal detail which I'm not convinced we
> don't need to expose to user-space.
> 
> IMHO we should instead focus just on defining a usable and generic
> userspace interface. Then, platform specific tuning is something
> user-space can do, either offline or on-line.

The thing I worry about is how do we determine the value to put in in
the first place.

How are expecting people to determine what to put into the interface?
Knee points, little capacity, those things make 'obvious' sense.

> > But changing the clamp metric to something different than these values
> > is going to be pain.
> 
> Maybe I don't completely get what you mean here... are you saying that
> not using exact capacity values to defined clamps is difficult ?
> If that's the case why? Can you elaborate with an example ?

I meant changing the unit around, 1/1024 is what we use throughout and
is what EAS is also exposing IIRC, so why make things complicated again
and use 1/100 (which is a shit fraction for computers).
