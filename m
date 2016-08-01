From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC][PATCH 1/7] cpufreq / sched: Make schedutil access
 utilization data directly
Date: Mon, 1 Aug 2016 12:28:50 -0700
Message-ID: <20160801192850.GX19455@graphite.smuckle.net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
 <9887668.FEg7fVruKQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9887668.FEg7fVruKQ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 01, 2016 at 01:34:36AM +0200, Rafael J. Wysocki wrote:
...
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -144,17 +144,47 @@ static unsigned int get_next_freq(struct
>  	return cpufreq_driver_resolve_freq(policy, freq);
>  }
>  
> -static void sugov_update_single(struct update_util_data *hook, u64 time,
> -				unsigned long util, unsigned long max)
> +static void sugov_get_util(unsigned long *util, unsigned long *max)
> +{
> +	unsigned long dl_util, dl_max;
> +	unsigned long cfs_util, cfs_max;
> +	int cpu = smp_processor_id();
> +	struct dl_bw *dl_bw = dl_bw_of(cpu);
> +	struct rq *rq = this_rq();
> +
> +	if (rt_prio(current->prio)) {
> +		*util = ULONG_MAX;
> +		return;
> +	}
> +
> +	dl_max = dl_bw_cpus(cpu) << 20;
> +	dl_util = dl_bw->total_bw;
> +
> +	cfs_max = rq->cpu_capacity_orig;
> +	cfs_util = min(rq->cfs.avg.util_avg, cfs_max);
> +
> +	if (cfs_util * dl_max > dl_util * cfs_max) {
> +		*util = cfs_util;
> +		*max  = cfs_max;
> +	} else {
> +		*util = dl_util;
> +		*max  = dl_max;
> +	}
> +}

Last Friday I had put together a similar patch based on Peter's. I need
the flags field for the remote wakeup support. My previous plan,
installing a late callback in check_preempt_curr that gets requested
from the earlier existing CFS callback, was not working out since those
two events don't always match up 1:1.

Anyway one way that my patch differed was that I had used the flags
field to keep the behavior the same for both RT and DL. That happens
later on in this series for RT but the DL policy is modified as above.
Can the DL policy be left as-is and discussed/modified in a separate
series?

thanks,
Steve
