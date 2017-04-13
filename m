From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Thu, 13 Apr 2017 12:33:31 +0100
Message-ID: <20170413113331.GB18854@e110439-lin>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <20170320145131.GA3623@htj.duckdns.org>
 <20170320172233.GA28391@e110439-lin>
 <20170410073622.2y6tnpcd2ssuoztz@hirez.programming.kicks-ass.net>
 <20170411175833.GI29455@e110439-lin>
 <20170412121009.GD3093@worktop>
 <20170412135538.GM29455@e110439-lin>
 <20170412153712.albkjck27ewzmbjr@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbdDMLdh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Apr 2017 07:33:37 -0400
Content-Disposition: inline
In-Reply-To: <20170412153712.albkjck27ewzmbjr@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@arm.com>, Chris Redpath <chris.redpath@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On 12-Apr 17:37, Peter Zijlstra wrote:
> On Wed, Apr 12, 2017 at 02:55:38PM +0100, Patrick Bellasi wrote:
> > On 12-Apr 14:10, Peter Zijlstra wrote:
> 
> > > Even for the cgroup interface, I think they should set a per-task
> > > property, not a group property.
> > 
> > Ok, right now using CGroups ans primary (and unique) interface, these
> > values are tracked as attributes of the CPU controller. Tasks gets
> > them by reading these attributes once they are binded to a CGroup.
> > 
> > Are you proposing to move these attributes within the task_struct?
> 
> /me goes look at your patches again, because I thought you already set
> per task_struct values.
> 
> @@ -1531,6 +1531,9 @@ struct task_struct {
>         struct sched_rt_entity rt;
>  #ifdef CONFIG_CGROUP_SCHED
>         struct task_group *sched_task_group;
> +#ifdef CONFIG_CAPACITY_CLAMPING
> +       struct rb_node cap_clamp_node[2];
> +#endif
> 
> Yeah, see...

Well, these are not the actual attributes.

These rb_nodes are used to sort the tasks based on their constraints, but the
actual attributes values are stored in:

@@ -273,6 +273,14 @@ struct task_group {
 #endif
 #endif
 
+#ifdef CONFIG_CAPACITY_CLAMPING
+#define CAP_CLAMP_MIN 0
+#define CAP_CLAMP_MAX 1
+
+       /* Min and Max capacity constraints for tasks in this group */
+       unsigned int cap_clamp[2];
+#endif
+

This is done to avoid replicated information in each tasks structure.

> > In that case we should also defined a primary interface to set them,
> > any preferred proposal? sched_setattr(), prctl?
> 
> We could, which I think is the important point.
> 
> > By regular rb-tree do you mean the cfs_rq->tasks_timeline?
> 
> Yep.
> 
> > Because in that case this would apply only to the FAIR class, while
> > the rb-tree we are using here are across classes.
> > Supporting both FAIR and RT I think is a worth having feature.
> 
> *groan* I don't want to even start thinking what this feature means in
> the context of RT, head hurts enough.

:-)

Still, mobile people *groan* when we go to max OPP every time a RT task runs.
Here you can find some energy numbers I've got recently on Pixel phones:
   https://lkml.org/lkml/2017/3/17/214
7%-54% (useless) more energy is a big deal.

Of course, there can be many different solution to this problem, but
capacity_max allows to easily clamp the frequency used when certain RT
while still keeping them within expected latency performance.

> > > So the bigger point is that if the min/max is a per-task property (even
> > > if set through a cgroup interface), the min(max) / max(min) thing is
> > > wrong.
> > 
> > Perhaps I'm not following you here but, being per-task does not mean
> > that we need to aggregate these constraints by summing them (look
> > below)...
> >
> > > If the min/max were to apply to each individual task's util, you'd end
> > > up with something like: Dom(\Sum util) = [min(1, \Sum min), min(1, \Sum max)].
> > 
> > ... as you do here.
> > 
> > Let's use the usual simple example, where these per-tasks constraints
> > are configured:
> >
> > - TaskA: capacity_min: 20% capacity_max: 80%
> > - TaskB: capacity_min: 40% capacity_max: 60%
> > 
> > This means that, at CPU level, we want to enforce the following
> > clamping depending on the tasks status:
> > 
> >  RUNNABLE tasks    capacity_min    capacity_max
> > A) TaskA                      20%             80%
> > B) TaskA,TaskB                40%             80%
> > C) TaskB                      40%             60%
> >  
> > In case C, TaskA gets a bigger boost while is co-scheduled with TaskB.
> 
> (bit unfortunate you gave your cases and tasks the same enumeration)
> 
> But this I quite strongly feel is wrong. If you've given your tasks a
> minimum OPP, you've in fact given them a minimum bandwidth, for at a
> given frequency you can say how long they'll run, right?

Not really, we are still in the domain of a best-effort solution, and
I think we should stick with that.

The overall idea is not about allocating bandwidth at all, but instead
on expressing preferences, and there are two main reasons:

1) in principle we don't know how long a CFS task will run.
   we just know that if it completes faster than it's better

   Think about a task which is relatively small but functional to
   trigger further processing on an external device (e.g. a GPU).
   In this case the task is part of a critical-path and the sooner it
   finished the better it is.
   It can be the case that allocating bandwidth for such a task is not
   easy, e.g. because the amout of processing the task does can
   sensible change between each activation.

   In this case you have two options:
   a) meaure/estimate the WCET and go for over-budgeting
      likely using DEADLINE
   b) find the minimum capacity which allows your task to complete
      reasonably fast most of the time

   The second is of course a best-effort approach, still I find it
   could be useful to have and it can be easily adapted at run-time to
   express a sort-of power-vs-performance trade-off.

2) if you really want a granted bandwidth, you quite likely want also
   a granted deadline... and you should go for DEADLINE.

> So if you want to maintain that case B should be 60%. Once one of the
> tasks completes it will drop again. That is, the increased value
> represents the additional runnable 'load' over the min from the
> currently running task. Combined they will still complete in reduced
> time.

We already experimented with this approach in the past, actually the
first version of SchedTune was based on the idea to aggregate by
adding the boosted utilizations.

It's true that in that way we are more likely to speed-up tasks
completion also in case of co-scheduling but the downside is that we
are entering the domain of "granted bandwidth allocation" which is
likely overkilling for the scope of a best-effort solution.

Moreover, since bandwidth is a limited resource, we also found such an
approach not fitting well for systems where you have a certain number
of tasks running concurrently. While, a simple threshold based
boosting, where max() is used as the aggregation function, seems to be
still useful.


> > Notice that this CPU-level aggregation is used just for OPP selection
> > on that CPU, while for TaskA we still use capacity_min=20% when we are
> > looking for a CPU.
> 
> And you don't find that inconsistent?

In the previous example, TaskB seems to prefer a CPU which has between
40% and 60% capacity.
Let's assume these numbers comes from a use-case where:
 a) your system provides 60% capacity in a LITTLE CPU
 b) your are after "sustained performances" for TaskA, which on that
    platform can be easily achieved by running at 40% of a LITTLE CPU

Don't you think that this can be a valuable information for the
scheduler to just (possibly) prefer a LITTLE CPU?

With a max() aggregation we can place both TaskA and TaskB on the
LITTLE CPU and try to run them at least at 40% capacity.

-- 
#include <best/regards.h>

Patrick Bellasi
