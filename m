From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix compilation for !CONFIG_ACPI
Date: Tue, 23 Oct 2018 12:17:28 -0700
Message-ID: <e8e018e267434cabc2b8db434a3576c082ab3fff.camel@linux.intel.com>
References: <20181023185429.GA6756@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181023185429.GA6756@light.dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, linux-pm@vger.kernel.org, lenb@kernel.org
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2018-10-23 at 20:54 +0200, Dominik Brodowski wrote:
> Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency
> attribute")
Thanks for the fix.

> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 49c0abf2d48f..50c5699970c5 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -390,11 +390,6 @@ static int intel_pstate_get_cppc_guranteed(int
> cpu)
>  static void intel_pstate_set_itmt_prio(int cpu)
>  {
>  }
> -
> -static int intel_pstate_get_cppc_guranteed(int cpu)
> -{
> -	return -ENOTSUPP;
> -}
What is ACPI is defined but SCHED_MC_PRIO is not defined?
Based on
"select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO"

So the above is still required. correct?

>  #endif
>  
>  static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy
> *policy)
> @@ -490,6 +485,11 @@ static inline bool
> intel_pstate_acpi_pm_profile_server(void)
>  {
>  	return false;
>  }
> +
> +static int intel_pstate_get_cppc_guranteed(int cpu)
> +{
> +	return -ENOTSUPP;
> +}
>  #endif
>  
>  static inline void update_turbo_state(void)
