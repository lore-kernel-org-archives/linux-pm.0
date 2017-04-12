From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Wed, 12 Apr 2017 17:37:12 +0200
Message-ID: <20170412153712.albkjck27ewzmbjr@hirez.programming.kicks-ass.net>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <20170320145131.GA3623@htj.duckdns.org>
 <20170320172233.GA28391@e110439-lin>
 <20170410073622.2y6tnpcd2ssuoztz@hirez.programming.kicks-ass.net>
 <20170411175833.GI29455@e110439-lin>
 <20170412121009.GD3093@worktop>
 <20170412135538.GM29455@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:59054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdDLPhU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 11:37:20 -0400
Content-Disposition: inline
In-Reply-To: <20170412135538.GM29455@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@arm.com>, Chris Redpath <chris.redpath@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On Wed, Apr 12, 2017 at 02:55:38PM +0100, Patrick Bellasi wrote:
> On 12-Apr 14:10, Peter Zijlstra wrote:

> > Even for the cgroup interface, I think they should set a per-task
> > property, not a group property.
> 
> Ok, right now using CGroups ans primary (and unique) interface, these
> values are tracked as attributes of the CPU controller. Tasks gets
> them by reading these attributes once they are binded to a CGroup.
> 
> Are you proposing to move these attributes within the task_struct?

/me goes look at your patches again, because I thought you already set
per task_struct values.

@@ -1531,6 +1531,9 @@ struct task_struct {
        struct sched_rt_entity rt;
 #ifdef CONFIG_CGROUP_SCHED
        struct task_group *sched_task_group;
+#ifdef CONFIG_CAPACITY_CLAMPING
+       struct rb_node cap_clamp_node[2];
+#endif

Yeah, see...

> In that case we should also defined a primary interface to set them,
> any preferred proposal? sched_setattr(), prctl?

We could, which I think is the important point.

> By regular rb-tree do you mean the cfs_rq->tasks_timeline?

Yep.

> Because in that case this would apply only to the FAIR class, while
> the rb-tree we are using here are across classes.
> Supporting both FAIR and RT I think is a worth having feature.

*groan* I don't want to even start thinking what this feature means in
the context of RT, head hurts enough.

> > So the bigger point is that if the min/max is a per-task property (even
> > if set through a cgroup interface), the min(max) / max(min) thing is
> > wrong.
> 
> Perhaps I'm not following you here but, being per-task does not mean
> that we need to aggregate these constraints by summing them (look
> below)...
>
> > If the min/max were to apply to each individual task's util, you'd end
> > up with something like: Dom(\Sum util) = [min(1, \Sum min), min(1, \Sum max)].
> 
> ... as you do here.
> 
> Let's use the usual simple example, where these per-tasks constraints
> are configured:
>
> - TaskA: capacity_min: 20% capacity_max: 80%
> - TaskB: capacity_min: 40% capacity_max: 60%
> 
> This means that, at CPU level, we want to enforce the following
> clamping depending on the tasks status:
> 
>  RUNNABLE tasks    capacity_min    capacity_max
> A) TaskA                      20%             80%
> B) TaskA,TaskB                40%             80%
> C) TaskB                      40%             60%
>  
> In case C, TaskA gets a bigger boost while is co-scheduled with TaskB.

(bit unfortunate you gave your cases and tasks the same enumeration)

But this I quite strongly feel is wrong. If you've given your tasks a
minimum OPP, you've in fact given them a minimum bandwidth, for at a
given frequency you can say how long they'll run, right?

So if you want to maintain that case B should be 60%. Once one of the
tasks completes it will drop again. That is, the increased value
represents the additional runnable 'load' over the min from the
currently running task. Combined they will still complete in reduced
time.

> Notice that this CPU-level aggregation is used just for OPP selection
> on that CPU, while for TaskA we still use capacity_min=20% when we are
> looking for a CPU.

And you don't find that inconsistent?
