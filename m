From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/3] cpufreq: intel_pstate: configurable algorithm to
 get target pstate
Date: Fri, 04 Dec 2015 09:35:42 -0800
Message-ID: <1449250542.3240.91.camel@spandruv-desk3.jf.intel.com>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com>
	 <1449247235-29389-4-git-send-email-philippe.longepe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20965 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641AbbLDRgo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 12:36:44 -0500
In-Reply-To: <1449247235-29389-4-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Longepe <philippe.longepe@linux.intel.com>
Cc: linux-pm@vger.kernel.org, Philippe Longepe <philippe.longepe@intel.com>

On Fri, 2015-12-04 at 17:40 +0100, Philippe Longepe wrote:
> From: Philippe Longepe <philippe.longepe@intel.com>
> 
Rafael meant signed-off not --author"". But it is fine for me.

Thanks,
Srinivas

> Target systems using different cpus have different power and performance
> requirements. They may use different algorithms to get the next P-state
> based on their power or performance preference.
> 
> For example, power-constrained systems may not want to use
> high-performance P-states as aggressively as a full-size desktop or a
> server platform. A server platform may want to run close to the max to
> achieve better performance, while laptop-like systems may prefer
> sacrificing performance for longer battery lifes.
> 
> For the above reasons, modify intel_pstate to allow the target P-state
> selection algorithm to be depend on the CPU ID.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Philippe Longepe <philippe.longepe@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index d3b0e50..6a301e1 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -66,6 +66,7 @@ static inline int ceiling_fp(int32_t x)
>  
>  struct sample {
>  	int32_t core_pct_busy;
> +	int32_t busy_scaled;
>  	u64 aperf;
>  	u64 mperf;
>  	u64 tsc;
> @@ -133,6 +134,7 @@ struct pstate_funcs {
>  	int (*get_scaling)(void);
>  	void (*set)(struct cpudata*, int pstate);
>  	void (*get_vid)(struct cpudata *);
> +	int32_t (*get_target_pstate)(struct cpudata *);
>  };
>  
>  struct cpu_defaults {
> @@ -140,6 +142,8 @@ struct cpu_defaults {
>  	struct pstate_funcs funcs;
>  };
>  
> +static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu);
> +
>  static struct pstate_adjust_policy pid_params;
>  static struct pstate_funcs pstate_funcs;
>  static int hwp_active;
> @@ -738,6 +742,7 @@ static struct cpu_defaults core_params = {
>  		.get_turbo = core_get_turbo_pstate,
>  		.get_scaling = core_get_scaling,
>  		.set = core_set_pstate,
> +		.get_target_pstate = get_target_pstate_use_performance,
>  	},
>  };
>  
> @@ -758,6 +763,7 @@ static struct cpu_defaults silvermont_params = {
>  		.set = atom_set_pstate,
>  		.get_scaling = silvermont_get_scaling,
>  		.get_vid = atom_get_vid,
> +		.get_target_pstate = get_target_pstate_use_performance,
>  	},
>  };
>  
> @@ -778,6 +784,7 @@ static struct cpu_defaults airmont_params = {
>  		.set = atom_set_pstate,
>  		.get_scaling = airmont_get_scaling,
>  		.get_vid = atom_get_vid,
> +		.get_target_pstate = get_target_pstate_use_performance,
>  	},
>  };
>  
> @@ -797,6 +804,7 @@ static struct cpu_defaults knl_params = {
>  		.get_turbo = knl_get_turbo_pstate,
>  		.get_scaling = core_get_scaling,
>  		.set = core_set_pstate,
> +		.get_target_pstate = get_target_pstate_use_performance,
>  	},
>  };
>  
> @@ -922,7 +930,7 @@ static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
>  	mod_timer_pinned(&cpu->timer, jiffies + delay);
>  }
>  
> -static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
> +static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
>  {
>  	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
>  	s64 duration_us;
> @@ -960,30 +968,24 @@ static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
>  		core_busy = mul_fp(core_busy, sample_ratio);
>  	}
>  
> -	return core_busy;
> +	cpu->sample.busy_scaled = core_busy;
> +	return cpu->pstate.current_pstate - pid_calc(&cpu->pid, core_busy);
>  }
>  
>  static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
>  {
> -	int32_t busy_scaled;
> -	struct _pid *pid;
> -	signed int ctl;
> -	int from;
> +	int from, target_pstate;
>  	struct sample *sample;
>  
>  	from = cpu->pstate.current_pstate;
>  
> -	pid = &cpu->pid;
> -	busy_scaled = intel_pstate_get_scaled_busy(cpu);
> +	target_pstate = pstate_funcs.get_target_pstate(cpu);
>  
> -	ctl = pid_calc(pid, busy_scaled);
> -
> -	/* Negative values of ctl increase the pstate and vice versa */
> -	intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ctl, true);
> +	intel_pstate_set_pstate(cpu, target_pstate, true);
>  
>  	sample = &cpu->sample;
>  	trace_pstate_sample(fp_toint(sample->core_pct_busy),
> -		fp_toint(busy_scaled),
> +		fp_toint(sample->busy_scaled),
>  		from,
>  		cpu->pstate.current_pstate,
>  		sample->mperf,
> @@ -1238,6 +1240,8 @@ static void copy_cpu_funcs(struct pstate_funcs *funcs)
>  	pstate_funcs.get_scaling = funcs->get_scaling;
>  	pstate_funcs.set       = funcs->set;
>  	pstate_funcs.get_vid   = funcs->get_vid;
> +	pstate_funcs.get_target_pstate = funcs->get_target_pstate;
> +
>  }
>  
>  #if IS_ENABLED(CONFIG_ACPI)


