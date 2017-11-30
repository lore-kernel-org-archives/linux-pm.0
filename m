From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v3 2/6] cpufreq: schedutil: ensure max frequency while
 running RT/DL tasks
Date: Thu, 30 Nov 2017 14:17:59 +0100
Message-ID: <20171130131759.GB9903@localhost.localdomain>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-3-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171130114723.29210-3-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 30/11/17 11:47, Patrick Bellasi wrote:

[...]

> @@ -340,6 +349,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>  	unsigned long util, max;
>  	unsigned int next_f;
> +	bool rt_mode;
>  
>  	sugov_get_util(&util, &max, sg_cpu->cpu);
>  
> @@ -353,17 +363,27 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  		sg_cpu->flags = 0;
>  		goto done;
>  	}
> -	sg_cpu->flags = flags;
> +
> +	/*
> +	 * While RT/DL tasks are running we do not want FAIR tasks to
> +	 * overwrite this CPU's flags, still we can update utilization and
> +	 * frequency (if required/possible) to be fair with these tasks.
> +	 */
> +	rt_mode = task_has_dl_policy(current) ||
> +		  task_has_rt_policy(current) ||
> +		  (flags & SCHED_CPUFREQ_RT_DL);
> +	if (rt_mode)
> +		sg_cpu->flags |= flags;
> +	else
> +		sg_cpu->flags = flags;
>  
>  	sugov_set_iowait_boost(sg_cpu, time, flags);
>  	sg_cpu->last_update = time;
>  
>  	if (sugov_should_update_freq(sg_policy, time)) {
> -		if (flags & SCHED_CPUFREQ_RT_DL)
> -			next_f = sg_policy->policy->cpuinfo.max_freq;
> -		else
> -			next_f = sugov_next_freq_shared(sg_cpu, time);
> -
> +		next_f = rt_mode
> +			? sg_policy->policy->cpuinfo.max_freq
> +			: sugov_next_freq_shared(sg_cpu, time);
>  		sugov_update_commit(sg_policy, time, next_f);

Aren't we already at max_freq at this point (since an RT/DL task is
running)? Do we need to trigger a frequency update?

Best,

Juri
