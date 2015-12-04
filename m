From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V5 2/3] cpufreq: intel_pstate: account for non C0 time
Date: Fri, 04 Dec 2015 03:12:26 +0100
Message-ID: <8155583.il0EyZ155W@vostro.rjw.lan>
References: <1449165359-25832-1-git-send-email-philippe.longepe@linux.intel.com> <1449165359-25832-5-git-send-email-philippe.longepe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61477 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753858AbbLDBme (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2015 20:42:34 -0500
In-Reply-To: <1449165359-25832-5-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Longepe <philippe.longepe@linux.intel.com>
Cc: linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com, Stephane Gasparini <stephane.gasparini@linux.intel.com>

On Thursday, December 03, 2015 06:55:56 PM Philippe Longepe wrote:
> The current function to calculate business uses the ratio of actual

"Utilization" would be a better word here.

> performance to max non turbo state requested during the last sample
> period.

What it really does is to use the measured percentage of busy cycles
scaled by the ratio of the current P-state to the max available
non-turbo one.

> This causes overestimation of busyness which results in higher
> power consumption.

"This leads to an overestimation of utilization which causes higher-performance
P-states to be selected more often and that leads to increased energy
consumption."  [Power can't be consumed.]

> This is a problem for low power systems.

"This is a problem for low-power systems, so it is better to use a different
utilization calculation algorithm for them."

> The algorithm here uses cpu busyness to select next target P state.
> The Percent Busy (or load) can be estimated as the ratio of the mperf
> counter running at a constant frequency only during active periods (C0)
> and the time stamp counter running at the same frequency but also during
> idle.

"Namely, the Percent Busy value (or load) can be estimated as the ratio of the
MPERF counter that runs at a constant rate only during active periods (C0) to
the time stamp counter (TSC) that also runs (at the same rate) during idle. 
That is"

> Percent Busy = 100 * (delta_mperf / delta_tsc)

> Use this algorithm for platforms with SoCs based on airmont and silvermont
> cores.

"based on the Airmont and Silvermont Atom cores".

> 
> Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
> Signed-off-by: Stephane Gasparini <stephane.gasparini@linux.intel.com>

Is Stephane a co-author of the patch?  Or if not, then what's his role?

> ---
>  drivers/cpufreq/intel_pstate.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index c2553a1..2cf8bb6 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -143,6 +143,7 @@ struct cpu_defaults {
>  };
>  
>  static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu);
> +static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu);
>  
>  static struct pstate_adjust_policy pid_params;
>  static struct pstate_funcs pstate_funcs;
> @@ -763,7 +764,7 @@ static struct cpu_defaults silvermont_params = {
>  		.set = atom_set_pstate,
>  		.get_scaling = silvermont_get_scaling,
>  		.get_vid = atom_get_vid,
> -		.get_target_pstate = get_target_pstate_use_performance,
> +		.get_target_pstate = get_target_pstate_use_cpu_load,
>  	},
>  };
>  
> @@ -784,7 +785,7 @@ static struct cpu_defaults airmont_params = {
>  		.set = atom_set_pstate,
>  		.get_scaling = airmont_get_scaling,
>  		.get_vid = atom_get_vid,
> -		.get_target_pstate = get_target_pstate_use_performance,
> +		.get_target_pstate = get_target_pstate_use_cpu_load,
>  	},
>  };
>  
> @@ -930,6 +931,26 @@ static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
>  	mod_timer_pinned(&cpu->timer, jiffies + delay);
>  }
>  
> +static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)

The function name might have been better, but well.

> +{
> +	struct sample *sample = &cpu->sample;
> +	int32_t cpu_load;
> +
> +	/*
> +	 * The load can be estimated as the ratio of the mperf counter
> +	 * running at a constant frequency during active periods
> +	 * (C0) and the time stamp counter running at the same frequency
> +	 * also during C-states.
> +	 */
> +	cpu_load = div64_u64(100 * sample->mperf, sample->tsc);
> +
> +	cpu->sample.busy_scaled = int_tofp(cpu_load);

This is questionable somewhat.

Why do you convert the result of an integer calculation to fixed point
instead of doing the calculation in fixed point in the first place?

> +
> +	return (cpu->pstate.current_pstate - pid_calc(&cpu->pid,
> +						cpu->sample.busy_scaled));
> +}
> +
> +
>  static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
>  {
>  	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
> 

Thanks,
Rafael

