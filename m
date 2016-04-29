From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC/PATCH] cpufreq: Fix GOV_LIMITS handling for the userspace
 governor
Date: Fri, 29 Apr 2016 09:18:00 +0530
Message-ID: <20160429034800.GR2915@vireshk-i7>
References: <57224FA2.2080000@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36790 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbcD2DsF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2016 23:48:05 -0400
Received: by mail-pf0-f174.google.com with SMTP id c189so42993931pfb.3
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2016 20:48:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <57224FA2.2080000@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sai Gurrappadi <sgurrappadi@nvidia.com>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, mlongnecker@nvidia.com

On 28-04-16, 11:00, Sai Gurrappadi wrote:
> Currently, the userspace governor only updates frequency on GOV_LIMITS
> if policy->cur falls outside policy->{min/max}. However, it is also
> necessary to update current frequency on GOV_LIMITS to match the user
> requested value if it can be achieved within the new policy->{max/min}.
> 
> This was previously the behaviour in the governor until commit d1922f0
> ("cpufreq: Simplify userspace governor") which incorrectly assumed that
> policy->cur == user requested frequency via scaling_setspeed. This won't

Urg...

> be true if the user requested frequency falls outside policy->{min/max}.
> Ex: a temporary thermal cap throttled the user requested frequency.
> 
> Fix this by doing a partial revert of commit d1922f0 to bring back the
> per-cpu cpu_set_freq variable that stores the user requested frequency.
> The governor will then try to achieve this request on every GOV_LIMITS.
> 

Add this here (just before your sob)

Fixes: d1922f02562f ("cpufreq: Simplify userspace governor")

> Signed-off-by: Sai Gurrappadi <sgurrappadi@nvidia.com>
> ---
>  drivers/cpufreq/cpufreq_userspace.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_userspace.c
> b/drivers/cpufreq/cpufreq_userspace.c
> index 4d16f45..ae03ba7 100644
> --- a/drivers/cpufreq/cpufreq_userspace.c
> +++ b/drivers/cpufreq/cpufreq_userspace.c
> @@ -18,6 +18,8 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> 
> +static DEFINE_PER_CPU(unsigned int, cpu_set_freq); /* CPU freq desired by
> +							userspace */

We don't have to be this bad now. The policy structure has a governor_data
field, please use that for storing any policy specific values.

>  static DEFINE_PER_CPU(unsigned int, cpu_is_managed);
>  static DEFINE_MUTEX(userspace_mutex);
> 
> @@ -38,6 +40,8 @@ static int cpufreq_set(struct cpufreq_policy *policy,
> unsigned int freq)
>  	if (!per_cpu(cpu_is_managed, policy->cpu))
>  		goto err;
> 
> +	per_cpu(cpu_set_freq, policy->cpu) = freq;
> +
>  	ret = __cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
>   err:
>  	mutex_unlock(&userspace_mutex);
> @@ -62,6 +66,7 @@ static int cpufreq_governor_userspace(struct cpufreq_policy
> *policy,
> 
>  		mutex_lock(&userspace_mutex);
>  		per_cpu(cpu_is_managed, cpu) = 1;
> +		per_cpu(cpu_set_freq, cpu) = policy->cur;
>  		mutex_unlock(&userspace_mutex);
>  		break;
>  	case CPUFREQ_GOV_STOP:
> @@ -69,20 +74,27 @@ static int cpufreq_governor_userspace(struct
> cpufreq_policy *policy,
> 
>  		mutex_lock(&userspace_mutex);
>  		per_cpu(cpu_is_managed, cpu) = 0;
> +		per_cpu(cpu_set_freq, cpu) = 0;
>  		mutex_unlock(&userspace_mutex);
>  		break;
>  	case CPUFREQ_GOV_LIMITS:
>  		mutex_lock(&userspace_mutex);
> -		pr_debug("limit event for cpu %u: %u - %u kHz, currently %u kHz\n",
> +		pr_debug("limit event for cpu %u: %u - %u kHz, "
> +			"currently %u kHz, last set to %u kHz\n",

*Never* break print messages into multiple lines, let them cross 80 columns.

>  			cpu, policy->min, policy->max,
> -			policy->cur);
> +			policy->cur, per_cpu(cpu_set_freq, cpu));
> 
> -		if (policy->max < policy->cur)
> +		if (policy->max < per_cpu(cpu_set_freq, cpu)) {
>  			__cpufreq_driver_target(policy, policy->max,
>  						CPUFREQ_RELATION_H);
> -		else if (policy->min > policy->cur)
> +		} else if (policy->min > per_cpu(cpu_set_freq, cpu)) {
>  			__cpufreq_driver_target(policy, policy->min,
>  						CPUFREQ_RELATION_L);
> +		} else {
> +			__cpufreq_driver_target(policy,
> +						per_cpu(cpu_set_freq, cpu),
> +						CPUFREQ_RELATION_L);
> +		}
>  		mutex_unlock(&userspace_mutex);
>  		break;
>  	}

Good catch :)

-- 
viresh
