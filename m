From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [Update][PATCH 1/2] cpufreq / sched: Pass flags to
 cpufreq_update_util()
Date: Thu, 11 Aug 2016 11:05:23 -0700
Message-ID: <20160811180523.GC14324@graphite.smuckle.net>
References: <4498725.ix9jPCHteg@vostro.rjw.lan>
 <14590530.PIp5juoJ7q@vostro.rjw.lan>
 <1878295.pk6FjfzjrR@vostro.rjw.lan>
 <20160811180347.GB14324@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160811180347.GB14324@graphite.smuckle.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 11, 2016 at 11:03:47AM -0700, Steve Muckle wrote:
> On Wed, Aug 10, 2016 at 03:49:07AM +0200, Rafael J. Wysocki wrote:
> > Index: linux-pm/kernel/sched/fair.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/fair.c
> > +++ linux-pm/kernel/sched/fair.c
> > @@ -2875,11 +2875,8 @@ static inline void update_tg_load_avg(st
> >  
> >  static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
> >  {
> > -	struct rq *rq = rq_of(cfs_rq);
> > -	int cpu = cpu_of(rq);
> > -
> > -	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
> > -		unsigned long max = rq->cpu_capacity_orig;
> > +	if (&this_rq()->cfs == cfs_rq) {
> > +		struct rq *rq = rq_of(cfs_rq);
> >  
> >  		/*
> >  		 * There are a few boundary cases this might miss but it should
> > @@ -2897,8 +2894,8 @@ static inline void cfs_rq_util_change(st
> >  		 *
> >  		 * See cpu_util().
> >  		 */
> > -		cpufreq_update_util(rq_clock(rq),
> > -				    min(cfs_rq->avg.util_avg, max), max);
> > +		if (cpu_of(rq) == smp_processor_id())
> 
> Isn't this test against smp_processor_id() redundant since
> this_rq()->cfs == cfs_rq?

Sorry, I see this is modified in the next patch.
