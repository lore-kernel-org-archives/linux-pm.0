From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Wed, 20 Dec 2017 14:51:36 +0000
Message-ID: <20171220145136.GK19821@e110439-lin>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-2-patrick.bellasi@arm.com>
 <20171220143344.o2kjuzvrnfghtjej@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171220143344.o2kjuzvrnfghtjej@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 20-Dec 15:33, Peter Zijlstra wrote:
> On Thu, Nov 30, 2017 at 11:47:18AM +0000, Patrick Bellasi wrote:
> > Currently, sg_cpu's flags are set to the value defined by the last call
> > of the cpufreq_update_util(); for RT/DL classes this corresponds to the
> > SCHED_CPUFREQ_{RT/DL} flags always being set.
> > 
> > When multiple CPUs share the same frequency domain it might happen that
> > a CPU which executed an RT task, right before entering IDLE, has one of
> > the SCHED_CPUFREQ_RT_DL flags set, permanently, until it exits IDLE.
> > 
> > Although such an idle CPU is _going to be_ ignored by the
> > sugov_next_freq_shared():
> >   1. this kind of "useless RT requests" are ignored only if more then
> >      TICK_NSEC have elapsed since the last update
> >   2. we can still potentially trigger an already too late switch to
> >      MAX, which starts also a new throttling interval
> >   3. the internal state machine is not consistent with what the
> >      scheduler knows, i.e. the CPU is now actually idle
> 
> So I _really_ hate having to clutter the idle path for this shared case
> :/

:)

We would like to have per-CPU frequency domains... but the HW guys
always complain that's too costly from an HW/power standpoint...
and they are likely right :-/

So, here are are just at trying hard to have a SW status matching
the HW status... which is just another pain :-/

> 1, can obviously be fixed by short-circuiting the timeout when idle.

Mmm.. right... it should be possible for schedutil to detect that a
certain CPU is currently idle.

Can we use core.c::idle_cpu() from cpufreq_schedutil?

> 2. not sure how if you do 1; anybody doing a switch will go through
>    sugov_next_freq_shared() which will poll all relevant CPUs and per 1
>    will see its idle, no?

Right, that should work...

> Not sure what that leaves for 3.

When a CPU is detected idle, perhaps we can still clear the RT flags...
... just for "consistency" of current status representation.

> 
> > diff --git a/kernel/sched/idle_task.c b/kernel/sched/idle_task.c
> > index d518664cce4f..6e8ae2aa7a13 100644
> > --- a/kernel/sched/idle_task.c
> > +++ b/kernel/sched/idle_task.c
> > @@ -30,6 +30,10 @@ pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
> >  	put_prev_task(rq, prev);
> >  	update_idle_core(rq);
> >  	schedstat_inc(rq->sched_goidle);
> > +
> > +	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
> > +	cpufreq_update_util(rq, SCHED_CPUFREQ_IDLE);
> > +
> >  	return rq->idle;
> >  }
> >  
> > -- 
> > 2.14.1
> > 

-- 
#include <best/regards.h>

Patrick Bellasi
