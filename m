From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Date: Mon, 13 Aug 2018 12:50:34 +0200
Message-ID: <20180813105034.GB9851@localhost.localdomain>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com>
 <20180807132630.GB3062@localhost.localdomain>
 <20180809153423.nsoepprhut3dv4u2@darkstar>
 <CAKfTPtCWcq2bOmaC5EDdhS8ih8Sv7Mwzn=84xerKA2tY6kXLkw@mail.gmail.com>
 <20180813101221.GA2605@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180813101221.GA2605@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, viresh kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, "Cc: Steve Muckle" <smuckle@google.com>, surenb@google.com
List-Id: linux-pm@vger.kernel.org

On 13/08/18 11:12, Patrick Bellasi wrote:
> Hi Vincent!
> 
> On 09-Aug 18:03, Vincent Guittot wrote:
> > > On 07-Aug 15:26, Juri Lelli wrote:
> 
> [...]
> 
> > > > > +   util_cfs = cpu_util_cfs(rq);
> > > > > +   util_rt  = cpu_util_rt(rq);
> > > > > +   if (sched_feat(UCLAMP_SCHED_CLASS)) {
> > > > > +           util = 0;
> > > > > +           if (util_cfs)
> > > > > +                   util += uclamp_util(cpu_of(rq), util_cfs);
> > > > > +           if (util_rt)
> > > > > +                   util += uclamp_util(cpu_of(rq), util_rt);
> > > > > +   } else {
> > > > > +           util  = cpu_util_cfs(rq);
> > > > > +           util += cpu_util_rt(rq);
> > > > > +           util  = uclamp_util(cpu_of(rq), util);
> > > > > +   }
> > >
> > > Regarding the two policies, do you have any comment?
> > 
> > Does the policy for (sched_feat(UCLAMP_SCHED_CLASS)== true) really
> > make sense as it is ?
> > I mean, uclamp_util doesn't make any difference between rt and cfs
> > tasks when clamping the utilization so why should be add twice the
> > returned value ?
> > IMHO, this policy would make sense if there were something like
> > uclamp_util_rt() and a uclamp_util_cfs()
> 
> The idea for the UCLAMP_SCHED_CLASS policy is to improve fairness on
> low-priority classese, especially when we have high RT utilization.
> 
> Let say we have:
> 
>  util_rt  = 40%, util_min=0%
>  util_cfs = 10%, util_min=50%
> 
> the two policies will select:
> 
>   UCLAMP_SCHED_CLASS: util = uclamp(40) + uclamp(10) = 50 + 50   = 100%
>  !UCLAMP_SCHED_CLASS: util = uclamp(40 + 10)         = uclmp(50) =  50%
> 
> Which means that, despite the CPU's util_min will be set to 50% when
> CFS is running, these tasks will have almost no boost at all, since
> their bandwidth margin is eclipsed by RT tasks.

Ah, right. But isn't possible to distinguish between classes? I mean, if
you would know that only CFS is clamped (boosted) in this case, you
could have:

 util = util_rt + uclamp(util_cfs) = 40 + 50 = 90%

Which should do what one expects w/o energy side effects?
