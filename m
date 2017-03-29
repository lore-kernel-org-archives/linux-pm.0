From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 5/9] sched: cpufreq: remove smp_processor_id() in remote paths
Date: Wed, 29 Mar 2017 23:28:12 +0200
Message-ID: <1836427.bpauTYz19k@aspire.rjw.lan>
References: <cover.1489058244.git.viresh.kumar@linaro.org> <834d098efe029ee687bac7690bb482e9263a766b.1489058244.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <834d098efe029ee687bac7690bb482e9263a766b.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thursday, March 09, 2017 05:15:15 PM Viresh Kumar wrote:
> From: Steve Muckle <smuckle.linux@gmail.com>
> 
> Upcoming support for remote callbacks from the scheduler into schedutil
> requires that the CPU identified in the hook structure be used to
> indicate the CPU being operated on, rather than relying on
> smp_processor_id().
> 
> Note that policy->cpu is passed to trace_cpu_frequency() in fast switch
> path, as it is safe to use any CPU which is managed by the current
> policy.

This should be commented about in the code too IMO.

> 
> Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
> [ vk: updated commit log, minor code cleanups and use policy->cpu for
>       traces ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index a418544c51b1..b168c31f1c8f 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -96,7 +96,7 @@ static void sugov_fast_switch(struct cpufreq_policy *policy,
>  		return;
>  
>  	policy->cur = next_freq;
> -	trace_cpu_frequency(next_freq, smp_processor_id());
> +	trace_cpu_frequency(next_freq, policy->cpu);
>  }
>  
>  static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
> @@ -106,7 +106,7 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>  
>  	if (policy->fast_switch_enabled) {
>  		if (sg_policy->next_freq == next_freq) {
> -			trace_cpu_frequency(policy->cur, smp_processor_id());
> +			trace_cpu_frequency(policy->cur, policy->cpu);
>  			return;
>  		}
>  		sg_policy->next_freq = next_freq;
> @@ -157,12 +157,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  	return cpufreq_driver_resolve_freq(policy, freq);
>  }
>  
> -static void sugov_get_util(unsigned long *util, unsigned long *max)
> +static void sugov_get_util(unsigned long *util, unsigned long *max, int cpu)
>  {
> -	struct rq *rq = this_rq();
> +	struct rq *rq = cpu_rq(cpu);
>  	unsigned long cfs_max;
>  
> -	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> +	cfs_max = arch_scale_cpu_capacity(NULL, cpu);
>  
>  	*util = min(rq->cfs.avg.util_avg, cfs_max);
>  	*max = cfs_max;
> @@ -216,7 +216,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  	if (flags & SCHED_CPUFREQ_RT_DL) {
>  		next_f = policy->cpuinfo.max_freq;
>  	} else {
> -		sugov_get_util(&util, &max);
> +		sugov_get_util(&util, &max, hook->cpu);

Why is this not racy?

>  		sugov_iowait_boost(sg_cpu, &util, &max);
>  		next_f = get_next_freq(sg_policy, util, max);
>  	}
> @@ -272,7 +272,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  	unsigned long util, max;
>  	unsigned int next_f;
>  
> -	sugov_get_util(&util, &max);
> +	sugov_get_util(&util, &max, hook->cpu);
>  

And here?

>  	raw_spin_lock(&sg_policy->update_lock);
>  
> 

Thanks,
Rafael
