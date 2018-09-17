From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Date: Mon, 17 Sep 2018 13:27:23 +0100
Message-ID: <20180917122723.GS1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
 <20180914140732.GR1413@e110439-lin>
 <20180914142813.GM24124@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180914142813.GM24124@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 14-Sep 16:28, Peter Zijlstra wrote:
> Just a quick reply because I have to run..
> 
> On Fri, Sep 14, 2018 at 03:07:32PM +0100, Patrick Bellasi wrote:
> > On 14-Sep 13:10, Peter Zijlstra wrote:
> 
> > > I think the problem here is that the two are conflated in the very same
> > > interface.
> > > 
> > > Would it make sense to move the available clamp values out to some sysfs
> > > interface like thing and guard that with a capability, while keeping the
> > > task interface unprivilidged?
> > 
> > You mean something like:
> > 
> >    $ cat /proc/sys/kernel/sched_uclamp_min_utils
> >    0 10 20 ... 100
> > 
> > to notify users about the set of clamp values which are available ?
> > 
> > > Another thing that has me 'worried' about this interface is the direct
> > > tie to CPU capacity (not that I have a better suggestion). But it does
> > > raise the point of how userspace is going to discover the relevant
> > > values of the platform.
> > 
> > This point worries me too, and that's what I think is addressed in a
> > sane way in:
> > 
> >    [PATCH v4 13/16] sched/core: uclamp: use percentage clamp values
> >    https://lore.kernel.org/lkml/20180828135324.21976-14-patrick.bellasi@arm.com/
> > 
> > IMHO percentages are a reasonably safe and generic API to expose to
> > user-space. Don't you think this should address your concern above ?
> 
> Not at all what I meant, and no, percentages don't help.
> 
> The thing is, the values you'd want to use are for example the capacity
> of the little CPUs. or the capacity of the most energy efficient OPP
> (the knee).

I don't think so.

On the knee topic, we had some thinking and on most platforms it seems
to be a rather arbitrary decision.

On sane platforms, the Energy Efficiency (EE) is monotonically
decreasing with frequency increase.  Maybe we can define a threshold
for a "EE derivative ratio", but it will still be quite arbitrary.
Moreover, it could be that in certain use-cases we want to push for
higher energy efficiency (i.e. lower derivatives) then others.

> Similarly for boosting, how are we 'easily' going to find the values
> that correspond to the various available OPPs.

In our experience with SchedTune on Android, we found that we
generally focus on a small set of representative use-cases and then
run an exploration, by tuning the percentage of boost, to identify the
optimal trade-off between Performance and Energy.
The value you get could be something which do not match exactly an OPP
but still, since we (will) bias not only OPP selection but also tasks
placement, it's the one which makes most sense.

Thus, the capacity of little CPUs, or the exact capacity of an OPP, is
something we don't care to specify exactly, since:

 - schedutil will top the util request to the next frequency anyway

 - capacity by itself is a loosely defined metric, since it's usually
   measured considering a specific kind of instructions mix, which
   can be very different from the actual instruction mix (e.g. integer
   vs floating point)

 - certain platforms don't even expose OPPs, but just "performance
   levels"... which ultimately are a "percentage"

 - there are so many rounding errors around on utilization tracking
   and it aggregation that being exact on an OPP if of "relative"
   importance

Do you see specific use-cases where an exact OPP capacity is much
better then a percentage value ?

Of course there can be scenarios in which wa want to clamp to a
specific OPP. But still, why should it be difficult for a platform
integrator to express it as a close enough percentage value ?

> The EAS thing might have these around; but I forgot if/how they're
> exposed to userspace (I'll have to soon look at the latest posting).

The new "Energy Model Management" framework can certainly be use to
get the list of OPPs for each frequency domain. IMO this could be
used to identify the maximum number of clamp groups we can have.
In this case, the discretization patch can translate a generic
percentage clamp into the closest OPP capacity... 

... but to me that's an internal detail which I'm not convinced we
don't need to expose to user-space.

IMHO we should instead focus just on defining a usable and generic
userspace interface. Then, platform specific tuning is something
user-space can do, either offline or on-line.

> But changing the clamp metric to something different than these values
> is going to be pain.

Maybe I don't completely get what you mean here... are you saying that
not using exact capacity values to defined clamps is difficult ?
If that's the case why? Can you elaborate with an example ?

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
