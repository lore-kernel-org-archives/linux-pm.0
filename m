From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFCv4 1/6] sched/core: add utilization clamping to CPU
 controller
Date: Mon, 4 Sep 2017 18:25:42 +0100
Message-ID: <20170904172542.GE2618@e110439-lin>
References: <20170824180857.32103-1-patrick.bellasi@arm.com>
 <20170824180857.32103-2-patrick.bellasi@arm.com>
 <20170828182303.GZ491396@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170828182303.GZ491396@devbig577.frc2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 28-Aug 11:23, Tejun Heo wrote:
> Hello,

Hi Teo,

> No idea whether this makes sense overall.  I'll just comment on the
> cgroup interface part.

Thanks for the feedback, some comments follow inline...


> On Thu, Aug 24, 2017 at 07:08:52PM +0100, Patrick Bellasi wrote:
> > This patch extends the CPU controller by adding a couple of new attributes,
> > util_min and util_max, which can be used to enforce frequency boosting and
> > capping. Specifically:
> > 
> > - util_min: defines the minimum CPU utilization which should be considered,
> > 	    e.g. when  schedutil selects the frequency for a CPU while a
> > 	    task in this group is RUNNABLE.
> > 	    i.e. the task will run at least at a minimum frequency which
> > 	         corresponds to the min_util utilization
> > 
> > - util_max: defines the maximum CPU utilization which should be considered,
> > 	    e.g. when schedutil selects the frequency for a CPU while a
> > 	    task in this group is RUNNABLE.
> > 	    i.e. the task will run up to a maximum frequency which
> > 	         corresponds to the max_util utilization
> 
> I'm not sure min/max are the right names here.  min/low/high/max are
> used to designate guarantees and limits on resources and the above is
> more restricting the range of an attribute.  I'll think more about
> what'd be better names here.

You right, these are used mainly for range restrictions, but still:
- utilization is the measure of a resource, i.e. the CPU bandwidth
- to a certain extend we are still using them to designate a guarantee
  i.e. util_min guarantee that tasks will not run below a minimum
  frequency, while util_max guarantee that a task will never run (when
  alone on a CPU) above a certain frequency.

If this is still considered a too wake definition of guarantees,
what about something like util_{lower,upper}_bound?

> > These attributes:
> > a) are tunable at all hierarchy levels, i.e. at root group level too, thus
> >    allowing to defined minimum and maximum frequency constraints for all
> >    otherwise non-classified tasks (e.g. autogroups)
> 
> The problem with doing the above is two-fold.
> 
> 1. The feature becomes inaccessible without cgroup even though it
>    doesn't have much to do with cgroup at system level.

As I commented in the cover letter, we currently use CGroups as the
only interface just because so fare we identified sensible use-cases
where cgroups are required.

Android needs to classify tasks depending on their role in the system
to allocate them different resources depending on the run-time
scenario. Thus, cgroups is just the most natural interface to extend
to get the frequency boosting/capping support.

Not to speak about the, at least incomplete, cpu bandwidth controller
interface, which is currently defined based just on "elapsed time"
without accounting for the actual amount of computation performed on
systems where the frequency can be changed dynamically.

Nevertheless, the internal implementation allows for a different
(primary) interface whenever that should be required.

> 2. For the above and other historical reasons, most other features
>    have a separate way to configure at the system level.
>
> I think it'd be better to keep the root level control outside cgorup.

For this specific feature, the system level configuration using the
root control group allows to define the "default" behavior for tasks
not otherwise classified.

Considering also my comment on point 1 above, having a different API
for the system tuning would make the implementation more complex
without real benefits.


> > b) allow to create subgroups of tasks which are not violating the
> >    utilization constraints defined by the parent group.
> 
> The problem with doing the above is that it ties the configs of a
> cgroup with its ancestors and that gets weird across delegation
> boundaries.  Other resource knobs don't behave this way - a descendant
> cgroup can have any memory.low/high/max values and an ancestor
> changing config doesn't destory its descendants' configs.  Please
> follow the same convention.

Also in this implementation an ancestor config change cannot destroy
its descendants' config.

For example, if we have:

  group1/util_min = 10
  group1/child1/util_min = 20

we cannot set:

  group1/util_min = 30

Right now we just fails, since this will produce an inversion in the
parent/child constraints relationships (see below).

The right operations would be:

  group1/child1/util_min = 30, or more, and only after:
  group1/util_min = 30


> > Tasks on a subgroup can only be more boosted and/or capped, which is
> > matching with the "limits" schema proposed by the "Resource Distribution
> > Model (RDM)" suggested by the CGroups v2 documentation:
> >    Documentation/cgroup-v2.txt
> 
> So, the guarantee side (min / low) shouldn't allow the descendants to
> have more.  ie. if memory.low is 512M at the parent, its children can
> never have more than 512M of low protection.

Does that not means, more generically, that children are not allowed to
have "more relaxed" constraints then their parents?
IOW children can only be more constrained.

Here we are applying exactly the same rule, what change is just the
definition of "more relaxed" constraint.

For example, for frequency boosting: if a parent is 10% boosted,
then its children are not allowed to have a lower boost value because
this will relax their parent's boost constraint (see below).

> Given that "boosting"
> means more CPU consumption, I think it'd make more sense to follow
> such semantics - ie. a descendant cannot have higher boosting than the
> lowest of its ancestors.

>From a functional standpoint, what we want to avoid is that by
lowering the boost value of children we can (indirectly) affect the
"performance" of their ancestors.

That's why a more restrictive constraint implies that we allow only
higher boost value than the highest of its ancestors.

For frequency capping instead the logic is the opposite. In that case
the optimization goal is to constraint the maximum frequency, for
example to save energy. Thus, children are allowed only to set lower
util_max values.


> Thanks.
> 
> --
> tejun

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
