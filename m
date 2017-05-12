From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq / CPPC: Initialize policy->min to lowest
 nonlinear performance
Date: Fri, 12 May 2017 10:55:03 +0530
Message-ID: <20170512052503.GQ17481@vireshk-i7>
References: <1494542384-7502-1-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34897 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdELFZI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 May 2017 01:25:08 -0400
Received: by mail-pf0-f173.google.com with SMTP id n23so19606441pfb.2
        for <linux-pm@vger.kernel.org>; Thu, 11 May 2017 22:25:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1494542384-7502-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, ahs3@redhat.com, hotran@apm.com, alexey.klimov@arm.com

On 11-05-17, 16:39, Prashanth Prakash wrote:
> Description of Lowest Perfomance in ACPI 6.1 specification states:
> "Lowest Performance is the absolute lowest performance level of
> the platform. Selecting a performance level lower than the lowest
> nonlinear performance level may actually cause an efficiency penalty,
> but should reduce the instantaneous power consumption of the processor.
> In traditional terms, this represents the T-state range of performance
> levels."
> 
> Set the default value of policy->min to Lowest Nonlinear Performance
> to avoid any potential efficiency penalty.
> 
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index e82bb3c..10be285 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -144,10 +144,23 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  
>  	cppc_dmi_max_khz = cppc_get_dmi_max_khz();
>  
> -	policy->min = cpu->perf_caps.lowest_perf * cppc_dmi_max_khz / cpu->perf_caps.highest_perf;
> +	/*
> +	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
> +	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
> +	 */
> +	policy->min = cpu->perf_caps.lowest_nonlinear_perf * cppc_dmi_max_khz /
> +		cpu->perf_caps.highest_perf;
>  	policy->max = cppc_dmi_max_khz;
> -	policy->cpuinfo.min_freq = policy->min;
> -	policy->cpuinfo.max_freq = policy->max;
> +
> +	/*
> +	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
> +	 * available if userspace wants to use any perf between lowest & lowest
> +	 * nonlinear perf
> +	 */
> +	policy->cpuinfo.min_freq = cpu->perf_caps.lowest_perf * cppc_dmi_max_khz /
> +		cpu->perf_caps.highest_perf;
> +	policy->cpuinfo.max_freq = cppc_dmi_max_khz;
> +
>  	policy->cpuinfo.transition_latency = cppc_get_transition_latency(cpu_num);
>  	policy->shared_type = cpu->shared_type;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
