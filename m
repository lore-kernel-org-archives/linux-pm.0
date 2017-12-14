From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: powernv: Add support of frequency domain
Date: Thu, 14 Dec 2017 10:12:39 +0530
Message-ID: <20171214044239.GU3322@vireshk-i7>
References: <20171213081937.16376-1-huntbag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:42869 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbdLNEmm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 23:42:42 -0500
Received: by mail-pg0-f44.google.com with SMTP id e14so2674197pgr.9
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2017 20:42:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171213081937.16376-1-huntbag@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>, ego@linux.vnet.ibm.com
Cc: rjw@rjwysocki.net, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

+ Gautham,

@Gautham: Can you please help reviewing this one ?

On 13-12-17, 13:49, Abhishek Goel wrote:
> @@ -693,6 +746,8 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>  {
>  	struct powernv_smp_call_data freq_data;
>  	unsigned int cur_msec, gpstate_idx;
> +	cpumask_t temp;
> +	u32 cpu;
>  	struct global_pstate_info *gpstates = policy->driver_data;
>  
>  	if (unlikely(rebooting) && new_index != get_nominal_index())
> @@ -761,24 +816,48 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>  	spin_unlock(&gpstates->gpstate_lock);
>  
>  	/*
> -	 * Use smp_call_function to send IPI and execute the
> -	 * mtspr on target CPU.  We could do that without IPI
> -	 * if current CPU is within policy->cpus (core)
> +	 * Use smp_call_function to send IPI and execute the mtspr on CPU.
> +	 * This needs to be done on every core of the policy

Why on each CPU ?

>  	 */
> -	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
> +	cpumask_copy(&temp, policy->cpus);
> +
> +	while (!cpumask_empty(&temp)) {
> +		cpu = cpumask_first(&temp);
> +		smp_call_function_any(cpu_sibling_mask(cpu),
> +					set_pstate, &freq_data, 1);
> +		cpumask_andnot(&temp, &temp, cpu_sibling_mask(cpu));
> +	}
> +
>  	return 0;
>  }

-- 
viresh
