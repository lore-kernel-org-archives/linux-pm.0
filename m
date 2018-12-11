From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpufreq: intel_pstate: Force HWP min perf before offline
Date: Tue, 11 Dec 2018 11:46:29 +0100
Message-ID: <1570245.TxyEhuTLgx@aspire.rjw.lan>
References: <20181116222420.24260-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116222420.24260-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, viresh.kumar@linaro.org, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, yu.c.chen@intel.com
List-Id: linux-pm@vger.kernel.org

On Friday, November 16, 2018 11:24:19 PM CET Srinivas Pandruvada wrote:
> Force HWP Request MAX = HWP Request MIN = HWP Capability MIN and EPP to
> 0xFF. In this way the performance limits on the offlined CPU will not
> influence performance limits on its sibling CPU, which is still online.
> 
> If the sibling CPU is calling for higher performance, it will impact the
> max core performance. Here core performance will follow higher of the
> performance requests from each sibling.
> 
> Reported-and-tested-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 14f551a3d36e..501ab9f4489a 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -830,6 +830,28 @@ static void intel_pstate_hwp_set(unsigned int cpu)
>  	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
>  }
>  
> +static void intel_pstate_hwp_force_min_perf(int cpu)
> +{
> +	u64 value;
> +	int min_perf;
> +
> +	value = all_cpu_data[cpu]->hwp_req_cached;
> +	value &= ~GENMASK_ULL(31, 0);
> +	min_perf = HWP_LOWEST_PERF(all_cpu_data[cpu]->hwp_cap_cached);
> +
> +	/* Set hwp_max = hwp_min */
> +	value |= HWP_MAX_PERF(min_perf);
> +	value |= HWP_MIN_PERF(min_perf);
> +
> +	/* Set EPP/EPB to min */
> +	if (static_cpu_has(X86_FEATURE_HWP_EPP))
> +		value |= HWP_ENERGY_PERF_PREFERENCE(HWP_EPP_POWERSAVE);
> +	else
> +		intel_pstate_set_epb(cpu, HWP_EPP_BALANCE_POWERSAVE);
> +
> +	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
> +}
> +
>  static int intel_pstate_hwp_save_state(struct cpufreq_policy *policy)
>  {
>  	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
> @@ -2093,10 +2115,12 @@ static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
>  	pr_debug("CPU %d exiting\n", policy->cpu);
>  
>  	intel_pstate_clear_update_util_hook(policy->cpu);
> -	if (hwp_active)
> +	if (hwp_active) {
>  		intel_pstate_hwp_save_state(policy);
> -	else
> +		intel_pstate_hwp_force_min_perf(policy->cpu);
> +	} else {
>  		intel_cpufreq_stop_cpu(policy);
> +	}
>  }
>  
>  static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
> 

Both this one and the [2/2] applied, thanks!
