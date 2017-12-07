From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Thu, 7 Dec 2017 12:45:10 +0000
Message-ID: <20171207124510.GP31247@e110439-lin>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-2-patrick.bellasi@arm.com>
 <20171207050135.vvhqttazumjg7n7n@vireshk-mac-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171207050135.vvhqttazumjg7n7n@vireshk-mac-ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 07-Dec 10:31, Viresh Kumar wrote:
> On 30-11-17, 11:47, Patrick Bellasi wrote:
> > diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> > index d1ad3d825561..bb5f778db023 100644
> > --- a/include/linux/sched/cpufreq.h
> > +++ b/include/linux/sched/cpufreq.h
> > @@ -11,6 +11,7 @@
> >  #define SCHED_CPUFREQ_RT	(1U << 0)
> >  #define SCHED_CPUFREQ_DL	(1U << 1)
> >  #define SCHED_CPUFREQ_IOWAIT	(1U << 2)
> > +#define SCHED_CPUFREQ_IDLE	(1U << 3)
> >  
> >  #define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
> >  
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 2f52ec0f1539..67339ccb5595 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -347,6 +347,12 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
> >  
> >  	sg_cpu->util = util;
> >  	sg_cpu->max = max;
> > +
> > +	/* CPU is entering IDLE, reset flags without triggering an update */
> > +	if (unlikely(flags & SCHED_CPUFREQ_IDLE)) {
> > +		sg_cpu->flags = 0;
> > +		goto done;
> > +	}
> >  	sg_cpu->flags = flags;
> >  
> >  	sugov_set_iowait_boost(sg_cpu, time, flags);
> > @@ -361,6 +367,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
> >  		sugov_update_commit(sg_policy, time, next_f);
> >  	}
> >  
> > +done:
> >  	raw_spin_unlock(&sg_policy->update_lock);
> >  }
> >  
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
> 
> We posted some comments on V2 for this particular patch suggesting
> some improvements. The patch hasn't changed at all and you haven't
> replied to few of those suggestions as well. Any particular reason for
> that?

You right, since the previous posting has been a long time ago, with
this one I mainly wanted to refresh the discussion. Thanks for
highlighting hereafter which one was the main discussion points.


> For example:
> - I suggested to get rid of the conditional expression in
>   cpufreq_schedutil.c file that you have added.

We can probably set flags to SCHED_CPUFREQ_IDLE (instead of resetting
them), however I think we still need an if condition somewhere.

Indeed, when SCHED_CPUFREQ_IDLE is asserted we don't want to trigger
an OPP change (reasons described in the changelog).

If that's still a goal, then we will need to check this flag and bail
out from sugov_update_shared straight away. That's why I've added a
check at the beginning and also defined it as unlikely to have not
impact on all cases where we call a schedutil update with runnable
tasks.

Does this makes sense?

> - And Joel suggested to clear the RT/DL flags from dequeue path to
>   avoid adding SCHED_CPUFREQ_IDLE flag.

I had a thought about Joel's proposal:

>> wouldn't another way be to just clear the flag from the RT scheduling
>> class with an extra call to cpufreq_update_util with flags = 0 during
>> dequeue_rt_entity?

The main concern for me was that the current API is completely
transparent about which scheduling class is calling schedutil for
updates.

Thus, at dequeue time of an RT task we cannot really clear
all the flags (e.g. IOWAIT of a fair task), we should clear only
the RT related flags.

This means that we likely need to implement Joel's idea by:

1. adding a new set of flags like:
   SCHED_CPUFREQ_RT_IDLE, SCHED_CPUFREQ_DL_IDLE, etc...

3. add an operation flag, e.g.
   SCHED_CPUFERQ_SET, SCHED_CPUFREQ_RESET to be ORed with the class
   flag, e.g.
   cpufreq_update_util(rq, SCHED_CPUFREQ_SET|SCHED_CPUFREQ_RT);

3. change the API to carry the operation required for a flag, e.g.:
   cpufreq_update_util(rq, flag, set={true, false});

To be honest I don't like any of those, especially compared to the
simplicity of the one proposed by this patch. :)

IMO, the only pitfall of this patch is that (as Juri pointed out in
v2) for DL it can happen that we do not want to reset the flag right
when a CPU enters IDLE. We need instead a specific call to reset the
DL flag at the 0-lag time.

However, AFAIU, this special case for DL will disappear as long as we
have last Juri's set [1]in.  Indeed, at this point, schedutil will
always and only need to know the utilization required by DL.

[1] https://lkml.org/lkml/2017/12/4/173

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
