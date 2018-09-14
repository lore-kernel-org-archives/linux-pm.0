From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 06/16] sched/cpufreq: uclamp: add utilization clamping
 for FAIR tasks
Date: Fri, 14 Sep 2018 11:32:40 +0200
Message-ID: <20180914093240.GB24082@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-7-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-7-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 28, 2018 at 02:53:14PM +0100, Patrick Bellasi wrote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 3fffad3bc8a8..949082555ee8 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -222,8 +222,13 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>  	 * CFS tasks and we use the same metric to track the effective
>  	 * utilization (PELT windows are synchronized) we can directly add them
>  	 * to obtain the CPU's actual utilization.
> +	 *
> +	 * CFS utilization can be boosted or capped, depending on utilization
> +	 * clamp constraints configured for currently RUNNABLE tasks.
>  	 */
>  	util = cpu_util_cfs(rq);
> +	if (util)
> +		util = uclamp_util(rq, util);

Should that not be:

	util = clamp_util(rq, cpu_util_cfs(rq));

Because if !util might we not still want to enforce the min clamp?

>  	util += cpu_util_rt(rq);
>  
>  	/*

> @@ -322,11 +328,24 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>  		return;
>  	sg_cpu->iowait_boost_pending = true;
>  
> +	/*
> +	 * Boost FAIR tasks only up to the CPU clamped utilization.
> +	 *
> +	 * Since DL tasks have a much more advanced bandwidth control, it's
> +	 * safe to assume that IO boost does not apply to those tasks.
> +	 * Instead, since RT tasks are not utiliation clamped, we don't want
> +	 * to apply clamping on IO boost while there is blocked RT
> +	 * utilization.
> +	 */
> +	max_boost = sg_cpu->iowait_boost_max;
> +	if (!cpu_util_rt(cpu_rq(sg_cpu->cpu)))
> +		max_boost = uclamp_util(cpu_rq(sg_cpu->cpu), max_boost);

OK I suppose.

> +
>  	/* Double the boost at each request */
>  	if (sg_cpu->iowait_boost) {
>  		sg_cpu->iowait_boost <<= 1;
> -		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
> -			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
> +		if (sg_cpu->iowait_boost > max_boost)
> +			sg_cpu->iowait_boost = max_boost;
>  		return;
>  	}
>  


> +static inline unsigned int uclamp_value(struct rq *rq, int clamp_id)
> +{
> +	struct uclamp_cpu *uc_cpu = &rq->uclamp;
> +
> +	if (uc_cpu->value[clamp_id] == UCLAMP_NOT_VALID)
> +		return uclamp_none(clamp_id);
> +
> +	return uc_cpu->value[clamp_id];
> +}

Would that not be more readable as:

static inline unsigned int uclamp_value(struct rq *rq, int clamp_id)
{
	unsigned int val = rq->uclamp.value[clamp_id];

	if (unlikely(val == UCLAMP_NOT_VALID))
		val = uclamp_none(clamp_id);

	return val;
}

And how come NOT_VALID is possible? I thought the idea was to always
have all things a valid value.
