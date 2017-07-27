From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V4 1/3] sched: cpufreq: Allow remote cpufreq callbacks
Date: Thu, 27 Jul 2017 11:56:28 +0200
Message-ID: <20170727095628.vq2lwxrfenhnpdag@hirez.programming.kicks-ass.net>
References: <cover.1501060871.git.viresh.kumar@linaro.org>
 <8797d4993baa6580e3af741d081be492032ce9dd.1501060871.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:57580 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdG0J4q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 05:56:46 -0400
Content-Disposition: inline
In-Reply-To: <8797d4993baa6580e3af741d081be492032ce9dd.1501060871.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, linux-kernel@vger.kernel.org

On Wed, Jul 26, 2017 at 02:52:32PM +0530, Viresh Kumar wrote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 45fcf21ad685..bb834747e49b 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -72,10 +72,15 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>  
>  /************************ Governor internals ***********************/
>  
> -static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> +static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time,
> +				     int target_cpu)
>  {
>  	s64 delta_ns;
>  
> +	/* Don't allow remote callbacks */

So I think you can reduce confusion in general if we extend this comment
somewhat.

	/*
	 * Since cpufreq_update_util() is called with rq->lock held for
	 * the @target_cpu, our per-cpu data is fully serialized.
	 *
	 * However, drivers cannot in general deal with cross-cpu
	 * requests, so while get_next_freq() will work, our
	 * sugov_update_commit() -> cpufreq_driver_fast_switch()
	 * call will not.
	 *
	 * Hence stop here for remote requests, as calculating the
	 * frequency is pointless if we cannot in fact act on it.
	 */

> +	if (smp_processor_id() != target_cpu)
> +		return false;
> +
>  	if (sg_policy->work_in_progress)
>  		return false;
>  
