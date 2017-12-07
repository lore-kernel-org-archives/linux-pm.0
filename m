From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 2/6] cpufreq: schedutil: ensure max frequency while
 running RT/DL tasks
Date: Thu, 7 Dec 2017 10:35:09 +0530
Message-ID: <20171207050509.vfa64mbp23gnq547@vireshk-mac-ubuntu>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-3-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44956 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbdLGFFN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Dec 2017 00:05:13 -0500
Received: by mail-pf0-f194.google.com with SMTP id m26so3828863pfj.11
        for <linux-pm@vger.kernel.org>; Wed, 06 Dec 2017 21:05:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171130114723.29210-3-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle.linux@gmail.com>

On 30-11-17, 11:47, Patrick Bellasi wrote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 67339ccb5595..448f49de5335 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -262,6 +262,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  	struct cpufreq_policy *policy = sg_policy->policy;
>  	unsigned long util, max;
>  	unsigned int next_f;
> +	bool rt_mode;
>  	bool busy;
>  
>  	sugov_set_iowait_boost(sg_cpu, time, flags);
> @@ -272,7 +273,15 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  
>  	busy = sugov_cpu_is_busy(sg_cpu);
>  
> -	if (flags & SCHED_CPUFREQ_RT_DL) {
> +	/*
> +	 * While RT/DL tasks are running we do not want FAIR tasks to
> +	 * overvrite this CPU's flags, still we can update utilization and
> +	 * frequency (if required/possible) to be fair with these tasks.
> +	 */
> +	rt_mode = task_has_dl_policy(current) ||
> +		  task_has_rt_policy(current) ||
> +		  (flags & SCHED_CPUFREQ_RT_DL);
> +	if (rt_mode) {
>  		next_f = policy->cpuinfo.max_freq;
>  	} else {
>  		sugov_get_util(&util, &max, sg_cpu->cpu);
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
>  	}

Same here. There are pending comments from V2 which no one objected to
and I was looking to see those modifications here.

-- 
viresh
