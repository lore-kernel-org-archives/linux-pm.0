From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 2/2] sched: cpufreq: use rt_avg as estimate of required
 RT CPU capacity
Date: Wed, 31 Aug 2016 07:49:39 -0700
Message-ID: <20160831144939.GM5599@graphite.smuckle.net>
References: <1472236848-17038-1-git-send-email-smuckle@linaro.org>
 <1472236848-17038-3-git-send-email-smuckle@linaro.org>
 <1779842.1JHXT67au9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35826 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934968AbcHaOto (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2016 10:49:44 -0400
Received: by mail-pf0-f175.google.com with SMTP id x72so20312535pfd.2
        for <linux-pm@vger.kernel.org>; Wed, 31 Aug 2016 07:49:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1779842.1JHXT67au9@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Wed, Aug 31, 2016 at 03:31:07AM +0200, Rafael J. Wysocki wrote:
> On Friday, August 26, 2016 11:40:48 AM Steve Muckle wrote:
> > A policy of going to fmax on any RT activity will be detrimental
> > for power on many platforms. Often RT accounts for only a small amount
> > of CPU activity so sending the CPU frequency to fmax is overkill. Worse
> > still, some platforms may not be able to even complete the CPU frequency
> > change before the RT activity has already completed.
> > 
> > Cpufreq governors have not treated RT activity this way in the past so
> > it is not part of the expected semantics of the RT scheduling class. The
> > DL class offers guarantees about task completion and could be used for
> > this purpose.
> > 
> > Modify the schedutil algorithm to instead use rt_avg as an estimate of
> > RT utilization of the CPU.
> > 
> > Based on previous work by Vincent Guittot <vincent.guittot@linaro.org>.
> 
> If we do it for RT, why not to do a similar thing for DL?  As in the
> original patch from Peter, for example?

Agreed DL should have a similar change. I think that could be done in a
separate patch. I also would need to discuss it with the deadline sched
devs to fully understand the metric used there.

> 
> > Signed-off-by: Steve Muckle <smuckle@linaro.org>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index cb8a77b1ef1b..89094a466250 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -146,13 +146,21 @@ static unsigned int get_next_freq(struct sugov_cpu *sg_cpu, unsigned long util,
> >  
> >  static void sugov_get_util(unsigned long *util, unsigned long *max)
> >  {
> > -	struct rq *rq = this_rq();
> > -	unsigned long cfs_max;
> > +	int cpu = smp_processor_id();
> > +	struct rq *rq = cpu_rq(cpu);
> > +	unsigned long max_cap, rt;
> > +	s64 delta;
> >  
> > -	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> > +	max_cap = arch_scale_cpu_capacity(NULL, cpu);
> >  
> > -	*util = min(rq->cfs.avg.util_avg, cfs_max);
> > -	*max = cfs_max;
> > +	delta = rq_clock(rq) - rq->age_stamp;
> > +	if (unlikely(delta < 0))
> > +		delta = 0;
> > +	rt = div64_u64(rq->rt_avg, sched_avg_period() + delta);
> > +	rt = (rt * max_cap) >> SCHED_CAPACITY_SHIFT;
> 
> These computations are rather heavy, so I wonder if they are avoidable based
> on the flags, for example?

Yeah the div is bad. I don't know that we can avoid it based on the
flags because rt_avg will decay during CFS activity and you'd want to
take note of that.

One way to make this a little better is to ssume that the divisor,
sched_avg_period() + delta, fits into 32 bits so that div_u64 can be
used, which I believe is less bad. Doing that means placing a
restriction on how large sysctl_sched_time_avg (which determines
sched_avg_period()) can be, a max of 4.2 seconds I think. I don't know
that anyone uses a value that large anyway but there's currently no
limit on it.

Another option would be just adding another separate metric to track rt
activity that is more mathematically favorable to deal with.

Both these seemed potentially heavy handed so I figured I'd just start
with the obvious, if suboptimal, solution...

> Plus is SCHED_CAPACITY_SHIFT actually defined for all architectures?

Yes.

> One more ugly thing is about using rq_clock(rq) directly from here whereas we
> pass it around as the 'time' argument elsewhere.

Sure I'll clean this up.

> 
> > +
> > +	*util = min(rq->cfs.avg.util_avg + rt, max_cap);
> > +	*max = max_cap;
> >  }
