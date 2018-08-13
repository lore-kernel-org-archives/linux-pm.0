From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Date: Mon, 13 Aug 2018 14:09:06 +0200
Message-ID: <CAKfTPtCReRSGY_O8c+gpVbYJ_OgUFXsO=Ua1V_QaW41+4PWw8A@mail.gmail.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com> <20180807132630.GB3062@localhost.localdomain>
 <20180809153423.nsoepprhut3dv4u2@darkstar> <CAKfTPtCWcq2bOmaC5EDdhS8ih8Sv7Mwzn=84xerKA2tY6kXLkw@mail.gmail.com>
 <20180813101221.GA2605@e110439-lin> <CAKfTPtBN+K=8fqukZix2k0rdcjG8YiYagxZtzLx7kk3US+9V2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKfTPtBN+K=8fqukZix2k0rdcjG8YiYagxZtzLx7kk3US+9V2Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, viresh kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, "Cc: Steve Muckle" <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 13 Aug 2018 at 14:07, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
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
>
> So cfs task can get double boosted by a small rt task.
>
> Furthermore, if there is no rt task but 2 cfs tasks of 40% and 10%
> the UCLAMP_SCHED_CLASS: util = uclamp(0) + uclamp(40) = 50   = 50%

s/uclamp(40)/uclamp(50)/

>
> So in this case cfs tasks don't get more boost and have to share the
> bandwidth and you don't ensure 50% for each unlike what you try to do
> for rt.
> You create a difference in the behavior depending of the class of the
> others co-schedule tasks which is not sane IMHO
>
>
> >
> > > > We had an internal discussion and we found pro/cons for both... but
> >
> > The UCLAMP_SCHED_CLASS policy is thus less energy efficiency but it
> > should grant a better "isolation" in terms of what is the expected
> > speed-up a task will get at run-time, independently from higher
> > priority classes.
> >
> > Does that make sense?
> >
> > > > I'm not sure keeping the sched_feat is a good solution on the long
> > > > run, i.e. mainline merge ;)
> >
> > This problem still stands...
> >
> > --
> > #include <best/regards.h>
> >
> > Patrick Bellasi
