From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: schedutil: Examine the correct CPU when we
 update util
Date: Thu, 2 Nov 2017 17:10:48 +0530
Message-ID: <20171102114048.GC4240@vireshk-i7>
References: <20171102111022.GB4240@vireshk-i7>
 <20171102113840.17439-1-chris.redpath@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:53868 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbdKBLkx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Nov 2017 07:40:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id s2so4843045pge.10
        for <linux-pm@vger.kernel.org>; Thu, 02 Nov 2017 04:40:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171102113840.17439-1-chris.redpath@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Redpath <chris.redpath@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On 02-11-17, 11:38, Chris Redpath wrote:
> Since:
> 4296f23ed cpufreq: schedutil: Fix per-CPU structure initialization in
>  sugov_start()

This is still incorrect. This BUG has nothing to do with 4296f23ed
AFAICT.

> We lost the value of sg_cpu->cpu which is assigned during
> sugov_register. The memset in sugov_start overwrites it with zero.
> 
> The change here was triggered by the commit adding the remote update
> functionality.
> 674e75411fc2 ("sched: cpufreq: Allow remote cpufreq callbacks")
> 
> This leads to always looking at the utilization of CPU0 instead of
> the one we just updated when we do a utilization update callback.
> 
> Let's fix this by consolidating the initialization code into
> sugov_start().
> 
> Fixes: 674e75411fc2 ("sched: cpufreq: Allow remote cpufreq callbacks")
> Signed-off-by: Chris Redpath <chris.redpath@arm.com>
> Reviewed-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Reviewed-by: Brendan Jackman <brendan.jackman@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 6c1a7fcfa2a7..dc68a1ccdb33 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -728,6 +728,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>  		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
>  
>  		memset(sg_cpu, 0, sizeof(*sg_cpu));
> +		sg_cpu->cpu = cpu;
>  		sg_cpu->sg_policy = sg_policy;
>  		sg_cpu->flags = SCHED_CPUFREQ_RT;
>  		sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
> @@ -793,11 +794,6 @@ struct cpufreq_governor *cpufreq_default_governor(void)
>  
>  static int __init sugov_register(void)
>  {
> -	int cpu;
> -
> -	for_each_possible_cpu(cpu)
> -		per_cpu(sugov_cpu, cpu).cpu = cpu;
> -
>  	return cpufreq_register_governor(&schedutil_gov);
>  }
>  fs_initcall(sugov_register);
> -- 
> 2.13.1.449.g02a2850

-- 
viresh
