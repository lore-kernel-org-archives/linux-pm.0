From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: CPPC: Correct desired_perf calculation
Date: Tue, 11 Oct 2016 23:50:27 +0200
Message-ID: <12733315.XoNTxDd2zv@vostro.rjw.lan>
References: <1476220320-19685-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476220320-19685-1-git-send-email-hotran@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, pprakash@codeaurora.org, Al Stone <ahs3@redhat.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 11, 2016 02:12:00 PM Hoan Tran wrote:
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
>  
> 

This patch has already been applied AFAICS.

Thanks,
Rafael
