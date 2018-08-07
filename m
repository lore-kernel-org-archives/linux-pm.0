From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Date: Tue, 7 Aug 2018 15:26:30 +0200
Message-ID: <20180807132630.GB3062@localhost.localdomain>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180806163946.28380-7-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 06/08/18 17:39, Patrick Bellasi wrote:

[...]

> @@ -223,13 +224,25 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>  	 * utilization (PELT windows are synchronized) we can directly add them
>  	 * to obtain the CPU's actual utilization.
>  	 *
> -	 * CFS utilization can be boosted or capped, depending on utilization
> -	 * clamp constraints configured for currently RUNNABLE tasks.
> +	 * CFS and RT utilizations can be boosted or capped, depending on
> +	 * utilization constraints enforce by currently RUNNABLE tasks.
> +	 * They are individually clamped to ensure fairness across classes,
> +	 * meaning that CFS always gets (if possible) the (minimum) required
> +	 * bandwidth on top of that required by higher priority classes.

Is this a stale comment written before UCLAMP_SCHED_CLASS was
introduced? It seems to apply to the below if branch only.

>  	 */
> -	util = cpu_util_cfs(rq);
> -	if (util)
> -		util = uclamp_util(cpu_of(rq), util);
> -	util += cpu_util_rt(rq);
> +	util_cfs = cpu_util_cfs(rq);
> +	util_rt  = cpu_util_rt(rq);
> +	if (sched_feat(UCLAMP_SCHED_CLASS)) {
> +		util = 0;
> +		if (util_cfs)
> +			util += uclamp_util(cpu_of(rq), util_cfs);
> +		if (util_rt)
> +			util += uclamp_util(cpu_of(rq), util_rt);
> +	} else {
> +		util  = cpu_util_cfs(rq);
> +		util += cpu_util_rt(rq);
> +		util  = uclamp_util(cpu_of(rq), util);
> +	}

Best,

- Juri
