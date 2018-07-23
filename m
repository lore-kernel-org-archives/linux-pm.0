From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Show different max frequency with turbo 3 and HWP
Date: Mon, 23 Jul 2018 13:35:02 +0200
Message-ID: <11214467.C5YuPW0axr@aspire.rjw.lan>
References: <20180718215159.28698-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718215159.28698-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 18, 2018 11:51:59 PM CEST Srinivas Pandruvada wrote:
> On HWP platforms with Turbo 3.0, the HWP capability max ratio shows the
> maximum ratio of that core, which can be different than other cores. If
> we show the correct maximum frequency in cpufreq sysfs via
> cpuinfo_max_freq and scaling_max_freq then, user can know which cores
> can run faster for pinning some high priority tasks.
> 
> Currently the max turbo frequency is shown as max frequency, which is
> the max of all cores, even if some cores can't reach that frequency
> even for single threaded workload.
> 
> But it is possible that max ratio in HWP capabilities is set as 0xFF or
> some high invalid value (E.g. One KBL NUC). Since the actual performance
> can never exceed 1 core turbo frequency from MSR TURBO_RATIO_LIMIT, we
> use this as a bound check.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index ece120da3353..97096127d015 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2072,6 +2072,15 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
>  			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
>  	policy->cpuinfo.max_freq *= cpu->pstate.scaling;
>  
> +	if (hwp_active) {
> +		unsigned int max_freq;
> +
> +		max_freq = global.turbo_disabled ?
> +			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
> +		if (max_freq < policy->cpuinfo.max_freq)
> +			policy->cpuinfo.max_freq = max_freq;
> +	}
> +
>  	intel_pstate_init_acpi_perf_limits(policy);
>  
>  	policy->fast_switch_possible = true;
> 

Applied, thanks!
