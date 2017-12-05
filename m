From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH v2 1/8] sched/cpufreq_schedutil: make use of DEADLINE
 utilization signal
Date: Tue, 5 Dec 2017 16:24:24 +0100
Message-ID: <20171205152424.GC15085@localhost.localdomain>
References: <20171204102325.5110-1-juri.lelli@redhat.com>
 <20171204102325.5110-2-juri.lelli@redhat.com>
 <20171205150935.GL31247@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43243 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753079AbdLEPYa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Dec 2017 10:24:30 -0500
Received: by mail-wr0-f195.google.com with SMTP id z34so687507wrz.10
        for <linux-pm@vger.kernel.org>; Tue, 05 Dec 2017 07:24:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171205150935.GL31247@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, alessio.balsini@arm.com, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

Hi,

On 05/12/17 15:09, Patrick Bellasi wrote:
> Hi Juri,
> 

[...]

> >  static void sugov_get_util(unsigned long *util, unsigned long *max, int cpu)
> >  {
> >  	struct rq *rq = cpu_rq(cpu);
> > -	unsigned long cfs_max;
> > +	unsigned long dl_util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE)
> > +				>> BW_SHIFT;
> 
> What about using a pair of getter methods (e.g. cpu_util_{cfs,dl}) to
> be defined in kernel/sched/sched.h?
> 
> This would help to hide class-specific signals mangling from cpufreq.
> And here we can have something "more abstract" like:
> 
>        unsigned long util_cfs = cpu_util_cfs(rq);
>        unsigned long util_dl = cpu_util_dl(rq);

LGTM. I'll cook something for next spin.

> 
> >  
> > -	cfs_max = arch_scale_cpu_capacity(NULL, cpu);
> > +	*max = arch_scale_cpu_capacity(NULL, cpu);
> >  
> > -	*util = min(rq->cfs.avg.util_avg, cfs_max);
> > -	*max = cfs_max;
> > +	/*
> > +	 * Ideally we would like to set util_dl as min/guaranteed freq and
> > +	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
> > +	 * ready for such an interface. So, we only do the latter for now.
> > +	 */
> 
> Maybe I don't completely get the above comment, but to me it is not
> really required.
> 
> When you say that "util_dl" should be set to a min/guaranteed freq
> are you not actually talking about a DL implementation detail?
> 
> From the cpufreq standpoint instead, we should always set a capacity
> which can accommodate util_dl + util_cfs.

It's more for platforms which supports such combination of values for
frequency requests (CPPC like, AFAIU). The idea being that util_dl is
what the system has to always guarantee, but it could go up to the sum
if feasible.

> 
> We don't care about the meaning of util_dl and we should always assume
> (by default) that the signal is properly updated by the scheduling
> class... which unfortunately does not always happen for CFS.
> 
> 
> > +	*util = min(rq->cfs.avg.util_avg + dl_util, *max);
> 
> With the above proposal, here also we will have:
> 
> 	*util = min(util_cfs + util_dl, *max);

Looks cleaner.

Thanks,

- Juri
