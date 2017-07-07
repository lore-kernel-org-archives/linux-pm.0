From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH v1 5/8] sched/cpufreq_schedutil: always consider all
 CPUs when deciding next freq
Date: Fri, 7 Jul 2017 14:29:11 +0530
Message-ID: <20170707085911.GB32542@vireshk-i7>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170705085905.6558-6-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33859 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752104AbdGGI7O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2017 04:59:14 -0400
Received: by mail-pg0-f54.google.com with SMTP id t186so14306926pgb.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2017 01:59:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170705085905.6558-6-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On 05-07-17, 09:59, Juri Lelli wrote:
> No assumption can be made upon the rate at which frequency updates get
> triggered, as there are scheduling policies (like SCHED_DEADLINE) which
> don't trigger them so frequently.
> 
> Remove such assumption from the code, by always considering
> SCHED_DEADLINE utilization signal as not stale.
> 
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> Cc: Claudio Scordino <claudio@evidence.eu.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e835fa886225..066b876d81e7 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -267,17 +267,22 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  		s64 delta_ns;
>  
>  		/*
> -		 * If the CPU utilization was last updated before the previous
> -		 * frequency update and the time elapsed between the last update
> -		 * of the CPU utilization and the last frequency update is long
> -		 * enough, don't take the CPU into account as it probably is
> -		 * idle now (and clear iowait_boost for it).
> +		 * If the CFS CPU utilization was last updated before the
> +		 * previous frequency update and the time elapsed between the
> +		 * last update of the CPU utilization and the last frequency
> +		 * update is long enough, reset iowait_boost and util_cfs, as
> +		 * they are now probably stale. However, still consider the
> +		 * CPU contribution if it has some DEADLINE utilization
> +		 * (util_dl).
>  		 */
>  		delta_ns = time - j_sg_cpu->last_update;
>  		if (delta_ns > TICK_NSEC) {
>  			j_sg_cpu->iowait_boost = 0;
> -			continue;
> +			j_sg_cpu->util_cfs = 0;
> +			if (j_sg_cpu->util_dl == 0)
> +				continue;
>  		}
> +
>  		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT)
>  			return policy->cpuinfo.max_freq;
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
