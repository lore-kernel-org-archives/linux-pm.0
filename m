From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 2/3] sched/fair: use util_est in LB and WU paths
Date: Wed, 24 Jan 2018 19:31:38 +0000
Message-ID: <20180124193138.GB5739@e110439-lin>
References: <20180123180847.4477-1-patrick.bellasi@arm.com>
 <20180123180847.4477-3-patrick.bellasi@arm.com>
 <20180124113342.GD30677@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56874 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752339AbeAXTbo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Jan 2018 14:31:44 -0500
Content-Disposition: inline
In-Reply-To: <20180124113342.GD30677@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>

On 24-Jan 17:03, Pavan Kondeti wrote:
> Hi Patrick,

Hi Pavan,


> On Tue, Jan 23, 2018 at 06:08:46PM +0000, Patrick Bellasi wrote:
> >  static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
> >  {
> > -	unsigned long util, capacity;
> > +	long util, util_est;
> >  
> >  	/* Task has no contribution or is new */
> >  	if (cpu != task_cpu(p) || !p->se.avg.last_update_time)
> > -		return cpu_util(cpu);
> > +		return cpu_util_est(cpu);
> >  
> > -	capacity = capacity_orig_of(cpu);
> > -	util = max_t(long, cpu_rq(cpu)->cfs.avg.util_avg - task_util(p), 0);
> > +	/* Discount task's blocked util from CPU's util */
> > +	util = cpu_util(cpu) - task_util(p);
> > +	util = max(util, 0L);
> >  
> > -	return (util >= capacity) ? capacity : util;
> > +	if (!sched_feat(UTIL_EST))
> > +		return util;
> 
> At first, It is not clear to me why you are not clamping the capacity to
> CPU original capacity. It looks like it is not needed any more with
> commit f453ae2200b0 ("sched/fair: Consider RT/IRQ pressure in
> capacity_spare_wake()") inclusion.

Mainly because the above code now uses only cpu_util() which is already clamped
by capacity_orig_of().

However, you made me notice that in the few lines which follows, where I do:

> > +       /*
> > +        * These are the main cases covered:
> > +        * - if *p is the only task sleeping on this CPU, then:
> > +        *      cpu_util (== task_util) > util_est (== 0)
> > +        *   and thus we return:
> > +        *      cpu_util_wake = (cpu_util - task_util) = 0
> > +        *
> > +        * - if other tasks are SLEEPING on the same CPU, which is just waking
> > +        *   up, then:
> > +        *      cpu_util >= task_util
> > +        *      cpu_util > util_est (== 0)
> > +        *   and thus we discount *p's blocked utilization to return:
> > +        *      cpu_util_wake = (cpu_util - task_util) >= 0
> > +        *
> > +        * - if other tasks are RUNNABLE on that CPU and
> > +        *      util_est > cpu_util
> > +        *   then we use util_est since it returns a more restrictive
> > +        *   estimation of the spare capacity on that CPU, by just considering
> > +        *   the expected utilization of tasks already runnable on that CPU.
> > +        */
> > +       util_est = cpu_rq(cpu)->cfs.util_est_runnable;
> > +       util = max(util, util_est);
> > +
> > +       return util;

I should instead clamp util before returning it! ;-)

> May be a separate patch to remove  the clamping part?

No, I think we should keep cpu_util_wake clamped to not affect the existing
call sites. I just need to remove it where not needed (done) and add it where
needed (will do on the next iteration).

> Thanks,
> Pavan

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
