From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC PATCH v2 4/8] sched/cpufreq_schedutil: split utilization
 signals
Date: Tue, 5 Dec 2017 15:17:34 +0000
Message-ID: <20171205151734.GM31247@e110439-lin>
References: <20171204102325.5110-1-juri.lelli@redhat.com>
 <20171204102325.5110-5-juri.lelli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171204102325.5110-5-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, alessio.balsini@arm.com, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Juri,

On 04-Dec 11:23, Juri Lelli wrote:
> From: Juri Lelli <juri.lelli@arm.com>
> 
> To be able to treat utilization signals of different scheduling classes
> in different ways (e.g., CFS signal might be stale while DEADLINE signal
> is never stale by design) we need to split sugov_cpu::util signal in two:
> util_cfs and util_dl.
> 
> This patch does that by also changing sugov_get_util() parameter list.
> After this change, aggregation of the different signals has to be performed
> by sugov_get_util() users (so that they can decide what to do with the
> different signals).

Did not tried myself, but to me it would be nice to have this patch
squashed with the first one of this series. After all, looking at this
one it seems that [RFC PATH 1/8] is just adding util_dl but it's not
really using it the proper way.

Here instead is where you better introduce two separate signals,
tracked by struct sugov_cpu, and properly aggregate them.

But perhaps that's just me being picky ;-)

> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> Cc: Claudio Scordino <claudio@evidence.eu.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index c22457868ee6..a3072f24dc16 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -60,7 +60,8 @@ struct sugov_cpu {
>  	u64 last_update;
>  
>  	/* The fields below are only needed when sharing a policy. */
> -	unsigned long util;
> +	unsigned long util_cfs;
> +	unsigned long util_dl;
>  	unsigned long max;
>  	unsigned int flags;
>  
> @@ -176,20 +177,25 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  	return cpufreq_driver_resolve_freq(policy, freq);
>  }
>  
> -static void sugov_get_util(unsigned long *util, unsigned long *max, int cpu)
> +static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
> -	struct rq *rq = cpu_rq(cpu);
> -	unsigned long dl_util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE)
> -				>> BW_SHIFT;
> +	struct rq *rq = cpu_rq(sg_cpu->cpu);
>  
> -	*max = arch_scale_cpu_capacity(NULL, cpu);
> +	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
> +	sg_cpu->util_cfs = rq->cfs.avg.util_avg;
> +	sg_cpu->util_dl = (rq->dl.running_bw * SCHED_CAPACITY_SCALE)
> +			  >> BW_SHIFT;
> +}
> +
> +static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> +{
>  
>  	/*
>  	 * Ideally we would like to set util_dl as min/guaranteed freq and
>  	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
>  	 * ready for such an interface. So, we only do the latter for now.
>  	 */
> -	*util = min(rq->cfs.avg.util_avg + dl_util, *max);
> +	return min(sg_cpu->util_cfs + sg_cpu->util_dl, sg_cpu->max);
>  }
>  
>  static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
> @@ -280,7 +286,9 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  	if (flags & SCHED_CPUFREQ_RT) {
>  		next_f = policy->cpuinfo.max_freq;
>  	} else {
> -		sugov_get_util(&util, &max, sg_cpu->cpu);
> +		sugov_get_util(sg_cpu);
> +		max = sg_cpu->max;
> +		util = sugov_aggregate_util(sg_cpu);
>  		sugov_iowait_boost(sg_cpu, &util, &max);
>  		next_f = get_next_freq(sg_policy, util, max);
>  		/*
> @@ -325,8 +333,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT)
>  			return policy->cpuinfo.max_freq;
>  
> -		j_util = j_sg_cpu->util;
>  		j_max = j_sg_cpu->max;
> +		j_util = sugov_aggregate_util(j_sg_cpu);
>  		if (j_util * max > j_max * util) {
>  			util = j_util;
>  			max = j_max;
> @@ -343,15 +351,11 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  {
>  	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
>  	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> -	unsigned long util, max;
>  	unsigned int next_f;
>  
> -	sugov_get_util(&util, &max, sg_cpu->cpu);
> -
>  	raw_spin_lock(&sg_policy->update_lock);
>  
> -	sg_cpu->util = util;
> -	sg_cpu->max = max;
> +	sugov_get_util(sg_cpu);
>  	sg_cpu->flags = flags;
>  
>  	sugov_set_iowait_boost(sg_cpu, time, flags);
> -- 
> 2.14.3
> 

-- 
#include <best/regards.h>

Patrick Bellasi
