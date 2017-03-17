From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH 3/6] cpufreq: schedutil: ensure max frequency while
 running RT/DL tasks
Date: Fri, 17 Mar 2017 11:36:11 +0000
Message-ID: <20170317113611.GA18539@e110439-lin>
References: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
 <20170303083145.GA8206@vireshk-i7>
 <20170303123830.GB10420@e110439-lin>
 <4111071.G5qHzPaNa5@aspire.rjw.lan>
 <20170315144051.GE18557@e110439-lin>
 <CAJZ5v0g7sz6V328byKpZOcieDjU14E1=sRfO88XvB9DGa5ZnDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750885AbdCQLgj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Mar 2017 07:36:39 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g7sz6V328byKpZOcieDjU14E1=sRfO88XvB9DGa5ZnDA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.c>

On 16-Mar 00:32, Rafael J. Wysocki wrote:
> On Wed, Mar 15, 2017 at 3:40 PM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> > On 15-Mar 12:52, Rafael J. Wysocki wrote:
> >> On Friday, March 03, 2017 12:38:30 PM Patrick Bellasi wrote:
> >> > On 03-Mar 14:01, Viresh Kumar wrote:
> >> > > On 02-03-17, 15:45, Patrick Bellasi wrote:
> >> > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> >> > > > @@ -293,15 +305,29 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
> >> > > >         if (curr == sg_policy->thread)
> >> > > >                 goto done;
> >> > > >
> >> > > > +       /*
> >> > > > +        * While RT/DL tasks are running we do not want FAIR tasks to
> >> > > > +        * overwrite this CPU's flags, still we can update utilization and
> >> > > > +        * frequency (if required/possible) to be fair with these tasks.
> >> > > > +        */
> >> > > > +       rt_mode = task_has_dl_policy(curr) ||
> >> > > > +                 task_has_rt_policy(curr) ||
> >> > > > +                 (flags & SCHED_CPUFREQ_RT_DL);
> >> > > > +       if (rt_mode)
> >> > > > +               sg_cpu->flags |= flags;
> >> > > > +       else
> >> > > > +               sg_cpu->flags = flags;
> >> > >
> >> > > This looks so hacked up :)
> >> >
> >> > It is... a bit... :)
> >> >
> >> > > Wouldn't it be better to let the scheduler tell us what all kind of tasks it has
> >> > > in the rq of a CPU and pass a mask of flags?
> >> >
> >> > That would definitively report a more consistent view of what's going
> >> > on on each CPU.
> >> >
> >> > > I think it wouldn't be difficult (or time consuming) for the
> >> > > scheduler to know that, but I am not 100% sure.
> >> >
> >> > Main issue perhaps is that cpufreq_update_{util,this_cpu} are
> >> > currently called by the scheduling classes codes and not from the core
> >> > scheduler. However I agree that it should be possible to build up such
> >> > information and make it available to the scheduling classes code.
> >> >
> >> > I'll have a look at that.
> >> >
> >> > > IOW, the flags field in cpufreq_update_util() will represent all tasks in the
> >> > > rq, instead of just the task that is getting enqueued/dequeued..
> >> > >
> >> > > And obviously we need to get some utilization numbers for the RT and DL tasks
> >> > > going forward, switching to max isn't going to work for ever :)
> >> >
> >> > Regarding this last point, there are WIP patches Juri is working on to
> >> > feed DL demands to schedutil, his presentation at last ELC partially
> >> > covers these developments:
> >> >   https://www.youtube.com/watch?v=wzrcWNIneWY&index=37&list=PLbzoR-pLrL6pSlkQDW7RpnNLuxPq6WVUR
> >> >
> >> > Instead, RT tasks are currently covered by an rt_avg metric which we
> >> > already know is not fitting for most purposes.
> >> > It seems that the main goal is twofold: move people to DL whenever
> >> > possible otherwise live with the go-to-max policy which is the only
> >> > sensible solution to satisfy the RT's class main goal, i.e. latency
> >> > reduction.
> >> >
> >> > Of course such a go-to-max policy for all RT tasks we already know
> >> > that is going to destroy energy on many different mobile scenarios.
> >> >
> >> > As a possible mitigation for that, while still being compliant with
> >> > the main RT's class goal, we recently posted the SchedTune v3
> >> > proposal:
> >> >   https://lkml.org/lkml/2017/2/28/355
> >> >
> >> > In that proposal, the simple usage of CGroups and the new capacity_max
> >> > attribute of the (existing) CPU controller should allow to define what
> >> > is the "max" value which is just enough to match the latency
> >> > constraints of a mobile application without sacrificing too much
> >> > energy.
> >
> > Given the following interesting question, let's add Thomas Gleixner to
> > the discussion, which can be interested in sharing his viewpoint.
> >
> >> And who's going to figure out what "max" value is most suitable?  And how?
> >
> > That's usually up to the system profiling which is part of the
> > platform optimizations and tunings.
> > For example it's possible to run  experiments to measure the bandwidth
> > and (completion) latency requirements from the RT workloads.
> >
> > It's something which people developing embedded/mobile systems are
> > quite aware of.
> 
> Well, I was expecting an answer like this to be honest and let me say
> that it is not too convincing from my perspective.
> 
> At least throwing embedded and mobile into one bag seems to be a
> stretch, because the usage patterns of those two groups are quite
> different, even though they may be similar from the hardware POV.
> 
> Mobile are mostly used as general-purpose computers nowadays (and I
> guess we're essentially talking about anything running Android, not
> just phones, aren't we?) with applications installed by users rather
> than by system integrators, so I'm doubtful about the viability of the
> "system integrators should take care of it" assumption in this
> particular case.

I would say that it's a stretch also to consider Android systems just
like "general purpose computers".

Main difference with respect to desktop/laptop is that Android (or
ChromeOS) is a quite "complex" run-time sitting in between the Linux
kernel and the "general purpose" applications.
If you miss this point it's actually difficult to see how some of the
things we are proposing can make any sense.

Being a run-time, Android has the power and knowledge to act as an
orchestrator of resources assigned to applications.
Android applications are not completely free to do whatever they want,
which is instead the case of most apps running on a desktop.

Android provides a lot of fundamental and critical services to
applications. These services are ultimately under control of the
"system integrator" which has the power and knowledge to optimize them
as much as possible for a given HW platform.

>From this perspective Android is much more similar to an embedded
system than a "general-purpose computer". Not only from an HW
standpoint but also and mainly form the system tuning and optimization
standpoints.

Thus, the system integrator, whatever it's Google (for the main
framework components) or a smartphone producer (for the platform
dependent components) is more than willing to take care of optimize
its platform for whatever app will run on it.
In other words, the bulk of the possible optimizations are
most of the time in the application agnostic SW stacks and do not
depends on any specific app.

> > I'm also quite confident on saying that most of
> > them can agree that just going to the max OPP, each and every time a
> > RT task becomes RUNNABLE, it is something which is more likely to hurt
> > than to give benefits.
> 
> It would be good to be able to estimate that likelihood somehow ...

True, even if I don't remember a similar likelihood estimation about
"not hurting" when the we decided for the "go-to-max" policy.

We never really even considered to use schedutil with the current
"go-to-max" behavior. However, I've spent some time doing some
experiments. Hereafter are some numbers we have got while running
using the schedutil governor on a Pixel phone. The schedutil governor
code is the mainline version backported to the Android Common Kernel
(ACK) based on a v3.18 Linux kernel.

In the following table compares these configurations:

A) pelt_gtm: PELT for FAIRs and GoToMax for RTs
   This is essentially what mainline schedutil does nowadays.

B) pelt_rtavg: PELT for FAIRs and rq->rt_avg for RTs
   main difference here is that we use the rt_avg metrics to drive OPP
   selection for RT tasks.

C) walt: WALT for both FAIRs and RTs
   Here we use WALT to estimate RT utilization.
   This is reported as a reference just because it's the solution
   currently used on premium and production grade Pixel devices.

No other system tuning parameter are changing between case A and B.
The only change in code is the replacement of the GoToMax policy for
RT tasks with the usage of rt_avg to estimate the utilization of RT
tasks.

	    |  A) pelt_gtm      | B) pelt_rtavg     | C) walt
	    |      mJ  wrt_walt |      mJ  wrt_walt |      mJ
--------------------------------+-----------------------------
Jankbench   |   54170	 24.31% |   43520    -0.13% |   43577
YouTube     | 	90484	 39.53% |   64965     0.18% |   64851
UiBench	    |   24869	 54.57% |   16370     1.75% |   16089
            |                   |                   |
Vellamo	    |  520564	  7.81% |  482332    -0.11% |  482860
PCMark	    |  761806	 27.55% |  596807    -0.08% |  597282

The first three are workloads mainly stressing the UI which are used
to evaluate impact on user experience. These workloads mimics the most
common usage and user interaction patterns on an Android device.
For all of theme the goal is to run at MINIMUM energy consumption
while not generating jank frames. IOW, as much power as required,
noting more. In these cases the system is expected to run on
low-medium OPPs most of the time.

The last two are more standard system stressing benchmarks where the
system is quite likely to run at higher OPPs for most of the time.

I'm not sharing performance scores, because it's not the goal of this
comparison. However, in all cases the performance metrics are just
good with respect to the expectations.

As an additional info, consider that in an Android Pixel phone there
are around 100 RT FIFO tasks. One of these RT tasks is a principal
component of the GFX rendering pipeline. That's why we have such a big
regression on energy consumptions using the gotomax policy wihtout
any sensible performance improvement.

Energy measures for B and C cases are based on averages across
multiple executions collected from our CI system. For A I've run a set
of experiments and the number reported in this table are the _most
favorable_ ones, i.e. the runs where I've got the lower energy
consumption.

I would say that, as a first and simple proof-of-concept, there are
quite good evidence that a (forced) go-to-max policy is more likely to
hurt than give benefits.

> > AFAIK the current policy (i.e. "go to max") has been adopted for the
> > following main reasons, which I'm reporting with some observations.
> >
> >
> > .:: Missing of a suitable utilization metric for RT tasks
> >
> >  There is actually a utilization signal (rq->rt_avg) but it has been
> >  verified to be "too slow" for the practical usage of driving OPP
> >  selection.
> >  Other possibilities are perhaps under exploration but they are not
> >  yet there.
> >
> >
> > .:: Promote the migration from RT to DEADLINE
> >
> >  Which makes a lot of sens for many existing use-cases, starting from
> >  Android as well. However, it's also true that we cannot (at least yet)
> >  split the world in DEALINE vs FAIR.
> >  There is still, and there will be, a fair amount of RT tasks which
> >  just it makes sense to serve at best both from the performance as
> >  well as the power/energy standpoint.
> >
> >
> > .:: Because RT is all about "reducing latencies"
> >
> >  Running at the maximum OPP is certainly the best way to aim for the
> >  minimum latencies but... RT is about doing things "in time", which
> >  does not imply "as fast as possible".
> >  There can be many different workloads where a lower OPP is just good
> >  enough to meet the expected soft RT behaviors provided by the Linux
> >  RT scheduler.
> 
> AFAICS, RT is about determinism and meeting deadlines is one aspect of that.

Determinism, first of all, does not mean you have to go fast, and
deadlines cannot be granted by the Linux RT scheduling class.
What you are speacking about is what DEADLINE provide, which is a RT
scheduler... but not the RT scheduling class.
 
> Essentially, the problem here is to know which OPP is sufficient to do
> things "on time" and there simply is no good way to figure that out
> for RT tasks, again, AFAICS.

I do not agree on that point. If you know the workload composition and
have control on task composition and priority, a suitable set of
profiling experiments can be sufficient to verify how much CPU
bandwidth is required by your tasks to meet the timing requirements,
both in terms of activation and completion latencies.

If that should not be possible, than DEADLINE would be almost useless.
And if that is possible for DEADLINE, than it's possible for RT as
well.

I agree that kernel space cannot know these requirements by just
looking at a utilization tracking signal (e.g. rq->rt_avg).
>From user-space instead these information are more likely to be known
(or obtained by experiment). What we are currently missing is a proper
API to specify these values for RT, if we cannot or don't want to use
DEADLINE of course.

> And since we can't say which OPP is sufficient, we pretty much have no
> choice but to use the top-most one.

This is a big change wrt what on demand used to do, and still this
governor is the default one in many systems where RT tasks are used.

IMHO, if you really care about deadlines then we have a scheduling
class for these tasks. The DEADLINE class is going to be extended to
provide support to specify the exact CPU bandwidth required by these
tasks.
If we instead accept to run using the RT class, than we are already in
the domain of "reduced guarantees".

I fully agree that one simple solution can be that to go to max but at
the same time I'm also convinced that, with a proper profiling activity,
it's possible to identify bandwidth requirements for latency sensitive
tasks.
This would allow to get the expected RT behaviors without sacrificing
energy also when RT tasks are legitimately used.

> > All that considered, the modifications proposed in this series,
> > combined with other bits which are for discussion in this [1] other
> > posting, can work together to provide a better and more tunable OPP
> > selection policy for RT tasks.
> 
> OK, but "more tunable" need not imply "better".

Agree, that's absolutely true. However, for the specific proposal in
[1], it should be noted that the proposed additional tunables:

1. do not affect the default behavior, which is currently a go-to-max
   policy for RT tasks

2. they just add a possible interface to tune at run-time,
   depending on the "context awarness", the default behavior by
   setting a capacity_max value to use instead of the max OPP.

Thus, I would say that's a possible way to improve the current
situation. Maybe not the best, but in that case we should still talk
about a possible alternative approach.

> Thanks,
> Rafael

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
