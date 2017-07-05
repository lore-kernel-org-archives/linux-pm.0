From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2 2/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Wed, 5 Jul 2017 14:04:46 +0100
Message-ID: <20170705130446.GC2659@e110439-lin>
References: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
 <1499189651-18797-3-git-send-email-patrick.bellasi@arm.com>
 <20170705045012.GM3532@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55908 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbdGENEw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jul 2017 09:04:52 -0400
Content-Disposition: inline
In-Reply-To: <20170705045012.GM3532@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On 05-Jul 10:20, Viresh Kumar wrote:
> On 04-07-17, 18:34, Patrick Bellasi wrote:
> > diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> > index d2be2cc..36ac8d2 100644
> > --- a/include/linux/sched/cpufreq.h
> > +++ b/include/linux/sched/cpufreq.h
> > @@ -10,6 +10,7 @@
> >  #define SCHED_CPUFREQ_RT	(1U << 0)
> >  #define SCHED_CPUFREQ_DL	(1U << 1)
> >  #define SCHED_CPUFREQ_IOWAIT	(1U << 2)
> > +#define SCHED_CPUFREQ_IDLE	(1U << 3)
> >  
> >  #define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
> >  
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index eaba6d6..004ae18 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -304,6 +304,12 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
> >  
> >  	sg_cpu->util = util;
> >  	sg_cpu->max = max;
> > +
> > +	/* CPU is entering IDLE, reset flags without triggering an update */
> > +	if (unlikely(flags & SCHED_CPUFREQ_IDLE)) {
> > +		sg_cpu->flags = 0;
> > +		goto done;
> > +	}
> 
> Why is it important to have the above diff at all ? For example we aren't doing
> similar stuff in sugov_update_single() and that will go on and try to change the
> frequency if rate_limit_us time is over since last update.

The p repose here is mainly to avoid interference of IDLE CPUs on
other CPUs in the same frequency domain, by just resetting their
"requests".

In the single case, it's completely up to the policy to decide what to
do when we enter IDLE without risking to affect other CPUs.
But perhaps you are right, maybe we should use the same heuristics in
both cases. Entering idle just reset the flags and do not enforce for
example a frequency drop.

> And also why is it important to write 0 to sg_cpu->flags ? What wouldn't work if
> we set sg_cpu->flags to SCHED_CPUFREQ_IDLE in this case ? i.e. Just the below
> statement should be good for us.

Let say flags have the RT/DL flag set when the RT task sleep, is there
any specific reason to keep this flag up while the CPU is IDLE?
IOW, why should we care about an information related to an even which
is now over?

The proposal of this patch is just meant to make sure that the flags,
being a state variable, always describe the current status of the
sugov "state machine".
If a CPU is IDLE there are not sensible events going on and thus flags
should better be reset.

> 
> >  	sg_cpu->flags = flags;
> >  
> >  	sugov_set_iowait_boost(sg_cpu, time, flags);
> > @@ -318,6 +324,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
> >  		sugov_update_commit(sg_policy, time, next_f);
> >  	}
> >  
> > +done:
> >  	raw_spin_unlock(&sg_policy->update_lock);
> >  }
> >  
> > diff --git a/kernel/sched/idle_task.c b/kernel/sched/idle_task.c
> > index 0c00172..a844c91 100644
> > --- a/kernel/sched/idle_task.c
> > +++ b/kernel/sched/idle_task.c
> > @@ -29,6 +29,10 @@ pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
> >  	put_prev_task(rq, prev);
> >  	update_idle_core(rq);
> >  	schedstat_inc(rq->sched_goidle);
> > +
> > +	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
> > +	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_IDLE);
> > +
> 
> This looks correct.
> 
> Can we completely avoid the utilization contribution of the CPUs which have gone
> idle? Right now we avoid them with help of (delta_ns > TICK_NSEC). Can we
> instead check this SCHED_CPUFREQ_IDLE flag ?

I would say that the blocked utilization of an IDLE CPU is still worth
to be considered, at least for a limited amount of time, for few main
reasons:

1. it represents CPU bandwidth that is likely to be required by a task
   which can wakeup in a short while. Consider for example an 80% task
   activated every 16ms: even if it's not running right now it's
   likely to wakeup in the next ~3ms to run for the following ~13ms.
   Thus, we should probably better consider that CPU utilization.

2. we already have policies to gratefully reduce the current OPP if
   its utilization decrease. This means that we are interested in a
   sort of policy which favors higher OPPs to avoid impacting
   performance of tasks which suddenly wakeup.
 
3. A CPU entering IDLE is not a great source of new information
   for OPP selection, I would not strictly bind an OPP change to this
   event. That's also why this patch propose to clear the flags
   without actually triggering an OPP change.

Moreover, maybe the issue you are trying to solve it's more related to
having a stale utilization for an IDLE CPUs?
In that case we should fix the real source of the issue, which is the
utilization of an IDLE CPU not being updated over time. But that's
outside of the scope of this series.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
