From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Limit the scope of HWP dynamic boost platforms
Date: Tue, 31 Jul 2018 11:18:44 +0200
Message-ID: <1750924.cJQU9QUSYP@aspire.rjw.lan>
References: <20180730220029.81983-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730220029.81983-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, eero.t.tamminen@intel.com, ggherdovich@suse.cz, mgorman@techsingularity.net, currojerez@riseup.net
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 31, 2018 12:00:29 AM CEST Srinivas Pandruvada wrote:
> Dynamic boosting of HWP performance on IO wake showed significant
> improvement to IO workloads. This series was intended for Skylake Xeon
> platforms only and feature was enabled by default based on CPU model
> number.
> 
> But some Xeon platforms reused the Skylake desktop CPU model number. This
> caused some undesirable side effects to some graphics workloads. Since
> they are heavily IO bound, the increase in CPU performance decreased the
> power available for GPU to do its computing and hence decrease in graphics
> benchmark performance.
> 
> For example on a Skylake desktop, GpuTest benchmark showed average FPS
> reduction from 529 to 506.
> 
> This change makes sure that HWP boost feature is only enabled for Skylake
> server platforms by using ACPI FADT preferred PM Profile. If some desktop
> users wants to get benefit of boost, they can still enable boost from
> intel_pstate sysfs attribute "hwp_dynamic_boost".
> 
> Fixes: 41ab43c9c89e (cpufreq: intel_pstate: enable boost for Skylake Xeon)
> Link: https://bugs.freedesktop.org/show_bug.cgi?id=107410
> Reported-by: Eero Tamminen <eero.t.tamminen@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 3c3971256130..d4ed0022b0dd 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -311,12 +311,20 @@ static DEFINE_MUTEX(intel_pstate_limits_lock);
>  
>  #ifdef CONFIG_ACPI
>  
> -static bool intel_pstate_get_ppc_enable_status(void)
> +static bool intel_pstate_acpi_pm_profile_server(void)
>  {
>  	if (acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER ||
>  	    acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER)
>  		return true;
>  
> +	return false;
> +}
> +
> +static bool intel_pstate_get_ppc_enable_status(void)
> +{
> +	if (intel_pstate_acpi_pm_profile_server())
> +		return true;
> +
>  	return acpi_ppc;
>  }
>  
> @@ -459,6 +467,11 @@ static inline void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *pol
>  static inline void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
>  {
>  }
> +
> +static inline bool intel_pstate_acpi_pm_profile_server(void)
> +{
> +	return false;
> +}
>  #endif
>  
>  static inline void update_turbo_state(void)
> @@ -1841,7 +1854,7 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
>  		intel_pstate_hwp_enable(cpu);
>  
>  		id = x86_match_cpu(intel_pstate_hwp_boost_ids);
> -		if (id)
> +		if (id && intel_pstate_acpi_pm_profile_server())
>  			hwp_boost = true;
>  	}
>  
> 

Applied, thanks!
