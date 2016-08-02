From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC][PATCH 1/7] cpufreq / sched: Make schedutil access
 utilization data directly
Date: Tue, 2 Aug 2016 11:38:17 +0100
Message-ID: <20160802103817.GZ22472@e106622-lin>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
 <9887668.FEg7fVruKQ@vostro.rjw.lan>
 <20160801192850.GX19455@graphite.smuckle.net>
 <5472075.XX6bKsbQPI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38077 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbcHBKiV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Aug 2016 06:38:21 -0400
Content-Disposition: inline
In-Reply-To: <5472075.XX6bKsbQPI@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

Hi,

On 02/08/16 01:46, Rafael J. Wysocki wrote:
> On Monday, August 01, 2016 12:28:50 PM Steve Muckle wrote:
> > On Mon, Aug 01, 2016 at 01:34:36AM +0200, Rafael J. Wysocki wrote:
> > ...
> > > Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> > > ===================================================================
> > > --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> > > +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> > > @@ -144,17 +144,47 @@ static unsigned int get_next_freq(struct
> > >  	return cpufreq_driver_resolve_freq(policy, freq);
> > >  }
> > >  
> > > -static void sugov_update_single(struct update_util_data *hook, u64 time,
> > > -				unsigned long util, unsigned long max)
> > > +static void sugov_get_util(unsigned long *util, unsigned long *max)
> > > +{
> > > +	unsigned long dl_util, dl_max;
> > > +	unsigned long cfs_util, cfs_max;
> > > +	int cpu = smp_processor_id();
> > > +	struct dl_bw *dl_bw = dl_bw_of(cpu);
> > > +	struct rq *rq = this_rq();
> > > +
> > > +	if (rt_prio(current->prio)) {
> > > +		*util = ULONG_MAX;
> > > +		return;
> > > +	}
> > > +
> > > +	dl_max = dl_bw_cpus(cpu) << 20;
> > > +	dl_util = dl_bw->total_bw;
> > > +
> > > +	cfs_max = rq->cpu_capacity_orig;
> > > +	cfs_util = min(rq->cfs.avg.util_avg, cfs_max);
> > > +
> > > +	if (cfs_util * dl_max > dl_util * cfs_max) {
> > > +		*util = cfs_util;
> > > +		*max  = cfs_max;
> > > +	} else {
> > > +		*util = dl_util;
> > > +		*max  = dl_max;
> > > +	}
> > > +}
> > 
> > Last Friday I had put together a similar patch based on Peter's. I need
> > the flags field for the remote wakeup support. My previous plan,
> > installing a late callback in check_preempt_curr that gets requested
> > from the earlier existing CFS callback, was not working out since those
> > two events don't always match up 1:1.
> > 
> > Anyway one way that my patch differed was that I had used the flags
> > field to keep the behavior the same for both RT and DL.

Do you mean "go to max" policy for both, until proper policies will be
implemented in the future?

> That happens
> > later on in this series for RT but the DL policy is modified as above.
> > Can the DL policy be left as-is and discussed/modified in a separate
> > series?

Not that we want to start discussing this point now, if we postpone the
change for later, but I just wanted to point out a difference w.r.t.
what the schedfreq thing was doing: it used to sum contributions from
the different classes, instead of taking the max. We probably never
really discussed on the list what is the right thing to do, though.

Best,

- Juri
