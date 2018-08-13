From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Date: Mon, 13 Aug 2018 13:49:11 +0100
Message-ID: <20180813124911.GD2605@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com>
 <20180807132630.GB3062@localhost.localdomain>
 <20180809153423.nsoepprhut3dv4u2@darkstar>
 <CAKfTPtCWcq2bOmaC5EDdhS8ih8Sv7Mwzn=84xerKA2tY6kXLkw@mail.gmail.com>
 <20180813101221.GA2605@e110439-lin>
 <CAKfTPtBN+K=8fqukZix2k0rdcjG8YiYagxZtzLx7kk3US+9V2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtBN+K=8fqukZix2k0rdcjG8YiYagxZtzLx7kk3US+9V2Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, viresh kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, "Cc: Steve Muckle" <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 13-Aug 14:07, Vincent Guittot wrote:
> On Mon, 13 Aug 2018 at 12:12, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> >
> > Hi Vincent!
> >
> > On 09-Aug 18:03, Vincent Guittot wrote:
> > > > On 07-Aug 15:26, Juri Lelli wrote:
> >
> > [...]
> >
> > > > > > +   util_cfs = cpu_util_cfs(rq);
> > > > > > +   util_rt  = cpu_util_rt(rq);
> > > > > > +   if (sched_feat(UCLAMP_SCHED_CLASS)) {
> > > > > > +           util = 0;
> > > > > > +           if (util_cfs)
> > > > > > +                   util += uclamp_util(cpu_of(rq), util_cfs);
> > > > > > +           if (util_rt)
> > > > > > +                   util += uclamp_util(cpu_of(rq), util_rt);
> > > > > > +   } else {
> > > > > > +           util  = cpu_util_cfs(rq);
> > > > > > +           util += cpu_util_rt(rq);
> > > > > > +           util  = uclamp_util(cpu_of(rq), util);
> > > > > > +   }
> > > >
> > > > Regarding the two policies, do you have any comment?
> > >
> > > Does the policy for (sched_feat(UCLAMP_SCHED_CLASS)== true) really
> > > make sense as it is ?
> > > I mean, uclamp_util doesn't make any difference between rt and cfs
> > > tasks when clamping the utilization so why should be add twice the
> > > returned value ?
> > > IMHO, this policy would make sense if there were something like
> > > uclamp_util_rt() and a uclamp_util_cfs()
> >
> > The idea for the UCLAMP_SCHED_CLASS policy is to improve fairness on
> > low-priority classese, especially when we have high RT utilization.
> >
> > Let say we have:
> >
> >  util_rt  = 40%, util_min=0%
> >  util_cfs = 10%, util_min=50%
> >
> > the two policies will select:
> >
> >   UCLAMP_SCHED_CLASS: util = uclamp(40) + uclamp(10) = 50 + 50   = 100%
> >  !UCLAMP_SCHED_CLASS: util = uclamp(40 + 10)         = uclmp(50) =  50%
> >
> > Which means that, despite the CPU's util_min will be set to 50% when
> > CFS is running, these tasks will have almost no boost at all, since
> > their bandwidth margin is eclipsed by RT tasks.
> 
> Hmm ... At the opposite, even if there is no running rt task but only
> some remaining blocked rt utilization,
> even if util_rt  = 10%, util_min=0%
> and  util_cfs = 40%, util_min=50%
> the UCLAMP_SCHED_CLASS: util = uclamp(10) + uclamp(40) = 50 + 50   = 100%

Yes, that's true... since now I clamp util_rt if it's non zero.
Perhaps this can be fixed by clamping util_rt only:
  if (rt_rq_is_runnable(&rq->rt))
?

> So cfs task can get double boosted by a small rt task.

Well, in principle we don't know if the 50% clamp was asserted by the
RT or the CFS task, since in the current implementation we max
aggregate clamp values across all RT and CFS tasks.

> Furthermore, if there is no rt task but 2 cfs tasks of 40% and 10%
> the UCLAMP_SCHED_CLASS: util = uclamp(0) + uclamp(40) = 50   = 50%

True, but here we are within the same class and what utilization
clamping aims to do is to defined the minimum capacity to run _all_
the RUNNABLE tasks... not the minimum capacity for _each_ one of them.

> So in this case cfs tasks don't get more boost and have to share the
> bandwidth and you don't ensure 50% for each unlike what you try to do
> for rt.

Above I'm not trying to fix a per-task issue. The UCLAMP_SCHED_CLASS
policy is just "trying" to fix a cross-class issue... if we agree
there can be a cross-class issue worth to be fixed.

> You create a difference in the behavior depending of the class of the
> others co-schedule tasks which is not sane IMHO

Yes I agree that the current behavior is not completely clean... still
the question is: do you reckon the problem I depicted above, i.e. RT
workloads eclipsing the min_util required by lower priority classes?

To a certain extend I see this problem similar to the rt/dl/irq pressure
in defining cpu_capacity, isn't it?

Maybe we can make use of (cpu_capacity_orig - cpu_capacity) to factor
in a util_min compensation for CFS tasks?

-- 
#include <best/regards.h>

Patrick Bellasi
