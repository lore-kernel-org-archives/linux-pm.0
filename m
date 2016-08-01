From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 1/7] cpufreq / sched: Make schedutil access utilization data directly
Date: Tue, 02 Aug 2016 01:46:51 +0200
Message-ID: <5472075.XX6bKsbQPI@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <9887668.FEg7fVruKQ@vostro.rjw.lan> <20160801192850.GX19455@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53556 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753487AbcHAXn4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2016 19:43:56 -0400
In-Reply-To: <20160801192850.GX19455@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

On Monday, August 01, 2016 12:28:50 PM Steve Muckle wrote:
> On Mon, Aug 01, 2016 at 01:34:36AM +0200, Rafael J. Wysocki wrote:
> ...
> > Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> > +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> > @@ -144,17 +144,47 @@ static unsigned int get_next_freq(struct
> >  	return cpufreq_driver_resolve_freq(policy, freq);
> >  }
> >  
> > -static void sugov_update_single(struct update_util_data *hook, u64 time,
> > -				unsigned long util, unsigned long max)
> > +static void sugov_get_util(unsigned long *util, unsigned long *max)
> > +{
> > +	unsigned long dl_util, dl_max;
> > +	unsigned long cfs_util, cfs_max;
> > +	int cpu = smp_processor_id();
> > +	struct dl_bw *dl_bw = dl_bw_of(cpu);
> > +	struct rq *rq = this_rq();
> > +
> > +	if (rt_prio(current->prio)) {
> > +		*util = ULONG_MAX;
> > +		return;
> > +	}
> > +
> > +	dl_max = dl_bw_cpus(cpu) << 20;
> > +	dl_util = dl_bw->total_bw;
> > +
> > +	cfs_max = rq->cpu_capacity_orig;
> > +	cfs_util = min(rq->cfs.avg.util_avg, cfs_max);
> > +
> > +	if (cfs_util * dl_max > dl_util * cfs_max) {
> > +		*util = cfs_util;
> > +		*max  = cfs_max;
> > +	} else {
> > +		*util = dl_util;
> > +		*max  = dl_max;
> > +	}
> > +}
> 
> Last Friday I had put together a similar patch based on Peter's. I need
> the flags field for the remote wakeup support. My previous plan,
> installing a late callback in check_preempt_curr that gets requested
> from the earlier existing CFS callback, was not working out since those
> two events don't always match up 1:1.
> 
> Anyway one way that my patch differed was that I had used the flags
> field to keep the behavior the same for both RT and DL. That happens
> later on in this series for RT but the DL policy is modified as above.
> Can the DL policy be left as-is and discussed/modified in a separate
> series?

No problem with that as far as I'm concerned, but in that case it won't be
a Peter's patch any more. :-)

Thanks,
Rafael

