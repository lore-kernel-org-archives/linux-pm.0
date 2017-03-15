From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH 3/6] cpufreq: schedutil: ensure max frequency while
 running RT/DL tasks
Date: Wed, 15 Mar 2017 14:40:51 +0000
Message-ID: <20170315144051.GE18557@e110439-lin>
References: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
 <20170303083145.GA8206@vireshk-i7>
 <20170303123830.GB10420@e110439-lin>
 <4111071.G5qHzPaNa5@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4111071.G5qHzPaNa5@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On 15-Mar 12:52, Rafael J. Wysocki wrote:
> On Friday, March 03, 2017 12:38:30 PM Patrick Bellasi wrote:
> > On 03-Mar 14:01, Viresh Kumar wrote:
> > > On 02-03-17, 15:45, Patrick Bellasi wrote:
> > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > > @@ -293,15 +305,29 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
> > > >  	if (curr == sg_policy->thread)
> > > >  		goto done;
> > > >  
> > > > +	/*
> > > > +	 * While RT/DL tasks are running we do not want FAIR tasks to
> > > > +	 * overwrite this CPU's flags, still we can update utilization and
> > > > +	 * frequency (if required/possible) to be fair with these tasks.
> > > > +	 */
> > > > +	rt_mode = task_has_dl_policy(curr) ||
> > > > +		  task_has_rt_policy(curr) ||
> > > > +		  (flags & SCHED_CPUFREQ_RT_DL);
> > > > +	if (rt_mode)
> > > > +		sg_cpu->flags |= flags;
> > > > +	else
> > > > +		sg_cpu->flags = flags;
> > > 
> > > This looks so hacked up :)
> > 
> > It is... a bit... :)
> > 
> > > Wouldn't it be better to let the scheduler tell us what all kind of tasks it has
> > > in the rq of a CPU and pass a mask of flags?
> > 
> > That would definitively report a more consistent view of what's going
> > on on each CPU.
> > 
> > > I think it wouldn't be difficult (or time consuming) for the
> > > scheduler to know that, but I am not 100% sure.
> > 
> > Main issue perhaps is that cpufreq_update_{util,this_cpu} are
> > currently called by the scheduling classes codes and not from the core
> > scheduler. However I agree that it should be possible to build up such
> > information and make it available to the scheduling classes code.
> > 
> > I'll have a look at that.
> > 
> > > IOW, the flags field in cpufreq_update_util() will represent all tasks in the
> > > rq, instead of just the task that is getting enqueued/dequeued..
> > > 
> > > And obviously we need to get some utilization numbers for the RT and DL tasks
> > > going forward, switching to max isn't going to work for ever :)
> > 
> > Regarding this last point, there are WIP patches Juri is working on to
> > feed DL demands to schedutil, his presentation at last ELC partially
> > covers these developments:
> >   https://www.youtube.com/watch?v=wzrcWNIneWY&index=37&list=PLbzoR-pLrL6pSlkQDW7RpnNLuxPq6WVUR
> > 
> > Instead, RT tasks are currently covered by an rt_avg metric which we
> > already know is not fitting for most purposes.
> > It seems that the main goal is twofold: move people to DL whenever
> > possible otherwise live with the go-to-max policy which is the only
> > sensible solution to satisfy the RT's class main goal, i.e. latency
> > reduction.
> > 
> > Of course such a go-to-max policy for all RT tasks we already know
> > that is going to destroy energy on many different mobile scenarios.
> > 
> > As a possible mitigation for that, while still being compliant with
> > the main RT's class goal, we recently posted the SchedTune v3
> > proposal:
> >   https://lkml.org/lkml/2017/2/28/355
> > 
> > In that proposal, the simple usage of CGroups and the new capacity_max
> > attribute of the (existing) CPU controller should allow to define what
> > is the "max" value which is just enough to match the latency
> > constraints of a mobile application without sacrificing too much
> > energy.

Given the following interesting question, let's add Thomas Gleixner to
the discussion, which can be interested in sharing his viewpoint.
 
> And who's going to figure out what "max" value is most suitable?  And how?

That's usually up to the system profiling which is part of the
platform optimizations and tunings.
For example it's possible to run  experiments to measure the bandwidth
and (completion) latency requirements from the RT workloads.

It's something which people developing embedded/mobile systems are
quite aware of. I'm also quite confident on saying that most of
them can agree that just going to the max OPP, each and every time a
RT task becomes RUNNABLE, it is something which is more likely to hurt
than to give benefits.

AFAIK the current policy (i.e. "go to max") has been adopted for the
following main reasons, which I'm reporting with some observations.


.:: Missing of a suitable utilization metric for RT tasks

 There is actually a utilization signal (rq->rt_avg) but it has been
 verified to be "too slow" for the practical usage of driving OPP
 selection.
 Other possibilities are perhaps under exploration but they are not
 yet there.


.:: Promote the migration from RT to DEADLINE

 Which makes a lot of sens for many existing use-cases, starting from
 Android as well. However, it's also true that we cannot (at least yet)
 split the world in DEALINE vs FAIR.
 There is still, and there will be, a fair amount of RT tasks which
 just it makes sense to serve at best both from the performance as
 well as the power/energy standpoint.


.:: Because RT is all about "reducing latencies"

 Running at the maximum OPP is certainly the best way to aim for the
 minimum latencies but... RT is about doing things "in time", which
 does not imply "as fast as possible".
 There can be many different workloads where a lower OPP is just good
 enough to meet the expected soft RT behaviors provided by the Linux
 RT scheduler.


All that considered, the modifications proposed in this series,
combined with other bits which are for discussion in this [1] other
posting, can work together to provide a better and more tunable OPP
selection policy for RT tasks.

> Thanks,
> Rafael

Cheers Patrick

[1] https://lkml.org/lkml/2017/2/28/355

-- 
#include <best/regards.h>

Patrick Bellasi
