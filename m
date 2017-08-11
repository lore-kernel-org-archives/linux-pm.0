From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: remove setting of policy->cpu in policy->cpus
 during init
Date: Fri, 11 Aug 2017 10:39:02 +0530
Message-ID: <20170811050902.GC3638@vireshk-i7>
References: <1502377137-9058-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36668 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdHKFJH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2017 01:09:07 -0400
Received: by mail-pg0-f54.google.com with SMTP id v77so11348595pgb.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2017 22:09:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1502377137-9058-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>

On 10-08-17, 15:58, Sudeep Holla wrote:
> policy->cpu is copied into policy->cpus in cpufreq_online() before
> calling into cpufreq_driver->init(). So there's no need to set the
> same in the individual driver init() functions again.
> 
> This patch removes the redundant setting of policy->cpu in policy->cpus
> in intel_pstate and cppc drivers.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 1 -
>  drivers/cpufreq/intel_pstate.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> Hi Viresh,
> 
> I had copied the cpumask_set_cpu from one of these drivers and when you
> pointed out I thought it's better to remove the reference too. Let me
> know if it makes sense.
> 
> Regards,
> Sudeep
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 10be285c9055..a1c3025f9df7 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -172,7 +172,6 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  		return -EFAULT;
>  	}
> 
> -	cpumask_set_cpu(policy->cpu, policy->cpus);
>  	cpu->cur_policy = policy;
> 
>  	/* Set policy->cur to max now. The governors will adjust later. */
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 0566455f233e..d82429859103 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2133,7 +2133,6 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.max_freq *= cpu->pstate.scaling;
> 
>  	intel_pstate_init_acpi_perf_limits(policy);
> -	cpumask_set_cpu(policy->cpu, policy->cpus);
> 
>  	policy->fast_switch_possible = true;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
