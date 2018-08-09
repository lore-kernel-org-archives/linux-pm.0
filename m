From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Date: Thu, 9 Aug 2018 18:03:57 +0200
Message-ID: <CAKfTPtCWcq2bOmaC5EDdhS8ih8Sv7Mwzn=84xerKA2tY6kXLkw@mail.gmail.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com> <20180807132630.GB3062@localhost.localdomain>
 <20180809153423.nsoepprhut3dv4u2@darkstar>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809153423.nsoepprhut3dv4u2@darkstar>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, viresh kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, "Cc: Steve Muckle" <smuckle@google.com>, surenb@google.com
List-Id: linux-pm@vger.kernel.org

Hi Patrick,

On Thu, 9 Aug 2018 at 17:34, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> On 07-Aug 15:26, Juri Lelli wrote:
> > Hi,
> >
> > On 06/08/18 17:39, Patrick Bellasi wrote:
> >
> > [...]
> >
> > > @@ -223,13 +224,25 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> > >      * utilization (PELT windows are synchronized) we can directly add them
> > >      * to obtain the CPU's actual utilization.
> > >      *
> > > -    * CFS utilization can be boosted or capped, depending on utilization
> > > -    * clamp constraints configured for currently RUNNABLE tasks.
> > > +    * CFS and RT utilizations can be boosted or capped, depending on
> > > +    * utilization constraints enforce by currently RUNNABLE tasks.
> > > +    * They are individually clamped to ensure fairness across classes,
> > > +    * meaning that CFS always gets (if possible) the (minimum) required
> > > +    * bandwidth on top of that required by higher priority classes.
> >
> > Is this a stale comment written before UCLAMP_SCHED_CLASS was
> > introduced? It seems to apply to the below if branch only.
>
> Yes, you right... I'll update the comment.
>
> > >      */
> > > -   util = cpu_util_cfs(rq);
> > > -   if (util)
> > > -           util = uclamp_util(cpu_of(rq), util);
> > > -   util += cpu_util_rt(rq);
> > > +   util_cfs = cpu_util_cfs(rq);
> > > +   util_rt  = cpu_util_rt(rq);
> > > +   if (sched_feat(UCLAMP_SCHED_CLASS)) {
> > > +           util = 0;
> > > +           if (util_cfs)
> > > +                   util += uclamp_util(cpu_of(rq), util_cfs);
> > > +           if (util_rt)
> > > +                   util += uclamp_util(cpu_of(rq), util_rt);
> > > +   } else {
> > > +           util  = cpu_util_cfs(rq);
> > > +           util += cpu_util_rt(rq);
> > > +           util  = uclamp_util(cpu_of(rq), util);
> > > +   }
>
> Regarding the two policies, do you have any comment?

Does the policy for (sched_feat(UCLAMP_SCHED_CLASS)== true) really
make sense as it is ?
I mean, uclamp_util doesn't make any difference between rt and cfs
tasks when clamping the utilization so why should be add twice the
returned value ?
IMHO, this policy would make sense if there were something like
uclamp_util_rt() and a uclamp_util_cfs()

>
> We had an internal discussion and we found pro/cons for both... but
> I'm not sure keeping the sched_feat is a good solution on the long
> run, i.e. mainline merge ;)
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
