From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: CPPC: Correct desired_perf calculation
Date: Wed, 12 Oct 2016 08:51:53 +0530
Message-ID: <20161012032153.GE19385@vireshk-i7>
References: <1476220320-19685-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36418 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752475AbcJLD3B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Oct 2016 23:29:01 -0400
Received: by mail-pf0-f171.google.com with SMTP id e6so11656265pfk.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2016 20:28:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1476220320-19685-1-git-send-email-hotran@apm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, pprakash@codeaurora.org, Al Stone <ahs3@redhat.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>

On 11-10-16, 14:12, Hoan Tran wrote:
> The desired_perf is an abstract performance number. Its value should
> be in the range of [lowest perf, highest perf] of CPPC.
> The correct calculation is
>   desired_perf = freq * cppc_highest_perf / cppc_dmi_max_khz
> 
> Signed-off-by: Hoan Tran <hotran@apm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 1b2f28f..ab1d4b7 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -84,7 +84,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>  
>  	cpu = all_cpu_data[policy->cpu];
>  
> -	cpu->perf_ctrls.desired_perf = (u64)target_freq * policy->max / cppc_dmi_max_khz;
> +	cpu->perf_ctrls.desired_perf = (u64)target_freq * cpu->perf_caps.highest_perf / cppc_dmi_max_khz;
>  	freqs.old = policy->cur;
>  	freqs.new = target_freq;

I am not sure what the calculations should be like, but I don't have
any objections against applying this..

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
