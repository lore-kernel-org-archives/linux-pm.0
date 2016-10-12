From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH] cpufreq: CPPC: Correct desired_perf calculation
Date: Wed, 12 Oct 2016 09:36:34 -0600
Message-ID: <507da442-1193-3b51-cae2-78779a90bb17@codeaurora.org>
References: <1476220320-19685-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60382 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbcJLPgh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2016 11:36:37 -0400
In-Reply-To: <1476220320-19685-1-git-send-email-hotran@apm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hoan Tran <hotran@apm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Al Stone <ahs3@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>

Hi Hoan,

On 10/11/2016 3:12 PM, Hoan Tran wrote:
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
The patch looks good, I suppose we can add a small optimization. We can do a simple check
to see if the newly computed desired_perf is same as old one, If it is same we can just return
here instead of calling cppc_set_perf with same desired_perf value.

Thanks,
Prashanth
