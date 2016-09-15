From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: CPPC: Avoid overflow when calculating desired_perf
Date: Thu, 15 Sep 2016 02:50:09 +0200
Message-ID: <2037077.Sk8HnobN5X@vostro.rjw.lan>
References: <1473894508-22270-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473894508-22270-1-git-send-email-hotran@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, pprakash@codeaurora.org, Al Stone <ahs3@redhat.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 14, 2016 04:08:28 PM Hoan Tran wrote:
> This patch fixes overflow issue when calculating the desired_perf.
> 
> Signed-off-by: Hoan Tran <hotran@apm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 894e465..3e0961e 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -84,7 +84,8 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>  
>  	cpu = all_cpu_data[policy->cpu];
>  
> -	cpu->perf_ctrls.desired_perf = target_freq * policy->max / cppc_dmi_max_khz;
> +	cpu->perf_ctrls.desired_perf =
> +		(u64)target_freq * policy->max / cppc_dmi_max_khz;
>  	freqs.old = policy->cur;
>  	freqs.new = target_freq;

That's on top of the CPPC material in linux-next I gather?

Which commit does it fix?

Thanks,
Rafael
