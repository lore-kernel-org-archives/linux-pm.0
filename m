From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2 4/4] sched/cpufreq_schedutil: use util_est for OPP
 selection
Date: Mon, 18 Dec 2017 10:48:35 +0000
Message-ID: <20171218104835.GG19821@e110439-lin>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
 <20171205171018.9203-5-patrick.bellasi@arm.com>
 <1730241.78TPuThRce@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdLRKsl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Dec 2017 05:48:41 -0500
Content-Disposition: inline
In-Reply-To: <1730241.78TPuThRce@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

Hi Rafael,

On 16-Dec 03:35, Rafael J. Wysocki wrote:
> On Tuesday, December 5, 2017 6:10:18 PM CET Patrick Bellasi wrote:
[...]

> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 2f52ec0f1539..465430d99440 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -183,7 +183,11 @@ static void sugov_get_util(unsigned long *util, unsigned long *max, int cpu)
> >  
> >  	cfs_max = arch_scale_cpu_capacity(NULL, cpu);
> >  
> > -	*util = min(rq->cfs.avg.util_avg, cfs_max);
> > +	*util = rq->cfs.avg.util_avg;
> 
> I would use a local variable here.
> 
> That *util everywhere looks a bit dirtyish.

Yes, right... will update for the next respin.

> 
> > +	if (sched_feat(UTIL_EST))
> > +		*util = max(*util, rq->cfs.util_est_runnable);
> > +	*util = min(*util, cfs_max);
> > +
> >  	*max = cfs_max;
> >  }
> >  
> > 

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
