From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Thu, 13 Apr 2017 11:34:27 +0100
Message-ID: <20170413103427.GA18854@e110439-lin>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <20170320145131.GA3623@htj.duckdns.org>
 <20170320172233.GA28391@e110439-lin>
 <20170410073622.2y6tnpcd2ssuoztz@hirez.programming.kicks-ass.net>
 <20170411175833.GI29455@e110439-lin>
 <20170412124822.GG3093@worktop>
 <20170412132741.GK29455@e110439-lin>
 <20170412143414.2c27dakhrydl2pqb@hirez.programming.kicks-ass.net>
 <20170412144310.GB7572@e110439-lin>
 <20170412161423.jktdg6tacp7wwpno@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbdDMKeg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Apr 2017 06:34:36 -0400
Content-Disposition: inline
In-Reply-To: <20170412161423.jktdg6tacp7wwpno@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@arm.com>, Chris Redpath <chris.redpath@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On 12-Apr 18:14, Peter Zijlstra wrote:
> On Wed, Apr 12, 2017 at 03:43:10PM +0100, Patrick Bellasi wrote:
> > On 12-Apr 16:34, Peter Zijlstra wrote:
> > > On Wed, Apr 12, 2017 at 02:27:41PM +0100, Patrick Bellasi wrote:
> > > > On 12-Apr 14:48, Peter Zijlstra wrote:
> > > > > On Tue, Apr 11, 2017 at 06:58:33PM +0100, Patrick Bellasi wrote:
> > > > > > >     illustrated per your above points in that it affects both, while in
> > > > > > >     fact it actually modifies another metric, namely util_avg.
> > > > > > 
> > > > > > I don't see it modifying in any direct way util_avg.
> > > > > 
> > > > > The point is that clamps called 'capacity' are applied to util. So while
> > > > > you don't modify util directly, you do modify the util signal (for one
> > > > > consumer).
> > > > 
> > > > Right, but this consumer (i.e. schedutil) it's already translating
> > > > the util_avg into a next_freq (which ultimately it's a capacity).

                                                               ^^^^^^^^
                                                                [REF1]

> > > > 
> > > > Thus, I don't see a big misfit in that code path to "filter" this
> > > > translation with a capacity clamp.
> > > 
> > > Still strikes me as odd though.
> > 
> > Can you better elaborate on they why?
> 
> Because capacity is, as you pointed out earlier, a relative measure of
> inter CPU performance (which isn't otherwise exposed to userspace
> afaik).

Perhaps, since I'm biased by EAS concepts which are still not
mainline, I was not clear on specifying what I meant by "capacity" in
[REF1].

My fault, sorry, perhaps it's worth if I start by reviewing some
concepts and see if we can establish a common language.


.:: Mainline

If we look at mainline, "capacity" is actually a concept used to
represent the computational bandwidth available in a CPU, when running
at the highest OPP (let's consider SMP systems to keep it simple).

But things are already a bit more complicated. Specifically, looking
at update_cpu_capacity(), we distinguish between:

- cpu_rq(cpu)->cpu_capacity_orig
  which is the bandwidth available at the max OPP.

- cpu_rq(cpu)->cpu_capacity
  which discounts from the previous metrics the "average" bandwidth used
  by RT tasks, but not (yet) DEADLINE tasks afaics.

Thus, "capacity" is already a polymorphic concept:
  we use cpu_capacity_orig to cap the cpu utilization of CFS tasks
  in cpu_util()
but
  this cpu utilization is a signal which converge to "current capacity"
  in  ___update_load_avg()

The "current capacity" (capacity_curr, but just in some comments) is actually
the computational bandwidth available at a certain OPP.

Thus, we already have in mainline a concepts of capacity which refers to the
bandwidth available in a certain OPP. The "current capacity" is what we
ultimately use to scale PELT depending on the current OPP.


.:: EAS

Looking at EAS, and specifically the energy model, we describe each
OPP using a:

  struct capacity_state {
          unsigned long cap;      /* compute capacity */
          unsigned long power;    /* power consumption at this compute capacity */
  };

Where again we find a usage of the "current capacity", i.e. the
computational bandwidth available at each OPP.


.:: Current Capacity

In [REF1] I was referring to the concept of "current capacity", which is what
schedutil is after. There we need translate cfs.avg.util_avg into an OPP, which
ultimately is a suitable level of "current capacity" to satisfy the
CPU bandwidth requested by CFS tasks.

> While the utilization thing is a per task running signal.

Which still is converging to the "current capacity", at least before
Vincent's patches.

> There is no direct relation between the two.

Give the previous definitions, can we say that there is a relation between task
utilization and "current capacity"?

     Sum(task_utilization) = cpu_utilization
            <= "current capacity" (cpufreq_schedutil::get_next_freq())    [1]
            <= cpu_capacity_orig

> The two main uses for the util signal are:
> 
>   OPP selection: the aggregate util of all runnable tasks for a
>     particular CPU is used to select an OPP for said CPU [*], against
>     whatever max-freq that CPU has. Capacity doesn't really come into play
>     here.

The OPP selected has to provide a suitable amount of "current capacity" to
accommodate the required utilization.

>   Task placement: capacity comes into play in so far that we want to
>     make sure our task fits.

This two usages are not completely independent, at least when EAS is
in use. In EAS we can evaluate/compare scenarios like:

  "should I increase the capacity of CPUx or wakeup CPUy"

Thus, we use capacity indexes to estimate energy deltas by
moving a task and, by consequence, changing a CPU's OPP.

Which means: expected "capacity" variations are affecting OPP selections.

> And I'm not at all sure we want to have both uses of our utilization
> controlled by the one knob. They're quite distinct.

The proposed knobs, for example capacity_min, are used to clamp the
scheduler/schedutil view on what is the required "current capacity" by
modifying the previous relation [1] to be:

                 Sum(task_utilization) = cpu_utilization
            clamp(cpu_utilization, capacity_min, capacity_max)
                        <= "current capacity"
                        <= cpu_capacity_orig

In [1] we already have a transformation from the cpu_utilization
domain to the "current capacity" domain. Here we are just adding a
clamping filter around that transformation.

I hope this is useful to find some common ground, perhaps the naming
capacity_{min,max} is unfortunate and we can find a better one.
However, we should first agree on the utility of the proposed
clamping concept... ;-)

-- 
#include <best/regards.h>

Patrick Bellasi
