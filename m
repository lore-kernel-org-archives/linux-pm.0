From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq / sched: Check cpu_of(rq) in
 cpufreq_update_util()
Date: Thu, 11 Aug 2016 15:34:02 -0700
Message-ID: <20160811223402.GD14324@graphite.smuckle.net>
References: <4498725.ix9jPCHteg@vostro.rjw.lan>
 <2203967.KPfYM1XZ4Q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2203967.KPfYM1XZ4Q@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 10, 2016 at 03:11:17AM +0200, Rafael J. Wysocki wrote:
> Index: linux-pm/kernel/sched/fair.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/fair.c
> +++ linux-pm/kernel/sched/fair.c
> @@ -2876,8 +2876,6 @@ static inline void update_tg_load_avg(st
>  static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
>  {
>  	if (&this_rq()->cfs == cfs_rq) {
> -		struct rq *rq = rq_of(cfs_rq);
> -
>  		/*
>  		 * There are a few boundary cases this might miss but it should
>  		 * get called often enough that that should (hopefully) not be
> @@ -2894,8 +2892,7 @@ static inline void cfs_rq_util_change(st
>  		 *
>  		 * See cpu_util().
>  		 */
> -		if (cpu_of(rq) == smp_processor_id())
> -			cpufreq_update_util(rq_clock(rq), 0);
> +		cpufreq_update_util(rq_of(cfs_rq), 0);
>  	}
...
> +static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
>  {
>  	struct update_util_data *data;
>  
> +	if (cpu_of(rq) != smp_processor_id())
> +		return;

This test is unecessary in the CFS (most common) path due to the check
on this_rq in cfs_rq_util_change().

I think instead of bringing the test into cpufreq_update_util it should
be left at the call sites for RT and DL, and removed from CFS as part of
the first patch.

thanks,
Steve
