From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Thu, 30 Nov 2017 15:41:11 +0000
Message-ID: <20171130154111.GC31247@e110439-lin>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-2-patrick.bellasi@arm.com>
 <20171130131222.GA9903@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171130131222.GA9903@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 30-Nov 14:12, Juri Lelli wrote:
> Hi,
> 
> On 30/11/17 11:47, Patrick Bellasi wrote:
> 
> [...]
> 
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
> 
> Looks good for now. I'm just thinking that we will happen for DL, as a
> CPU that still "has" a sleeping task is not going to be really idle
> until the 0-lag time.

AFAIU, for the time being, DL already cannot really rely on this flag
for its behaviors to be correct. Indeed, flags are reset as soon as
a FAIR task wakes up and it's enqueued.

Only once your DL integration patches are in, we do not depends on
flags anymore since DL will report a ceratain utilization up to the
0-lag time, isn't it?

If that's the case, I would say that the flags will be used only to
jump to the max OPP for RT tasks. Thus, this patch should still be valid.

> I guess we could move this at that point in time?

Not sure what you mean here. Right now the new SCHED_CPUFREQ_IDLE flag
is notified only by idle tasks. That's the only code path where we are
sure the CPU is entering IDLE.

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
> Don't know if it make things any cleaner, but you could add to the
> comment that we don't actually trigger a frequency update with this
> call.

Right, will add on next posting.

> Best,
> 
> Juri

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
