From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Set P-state upfront in
 performance mode
Date: Fri, 21 Oct 2016 08:08:39 -0700
Message-ID: <1477062519.31557.2.camel@linux.intel.com>
References: <1724762.8Kf4o5e5cm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19554 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934759AbcJUPLj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Oct 2016 11:11:39 -0400
In-Reply-To: <1724762.8Kf4o5e5cm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 2016-10-19 at 02:57 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit a4675fbc4a7a (cpufreq: intel_pstate: Replace timers with
> utilization update callbacks) the cpufreq governor callbacks may not
> be invoked on NOHZ_FULL CPUs and, in particular, switching to the
> "performance" policy via sysfs may not have any effect on them.  That
> is a problem, because it usually is desirable to squeeze the last
> bit of performance out of those CPUs, so work around it by setting
> the maximum P-state (within the limits) in intel_pstate_set_policy()
> upfront when the policy is CPUFREQ_POLICY_PERFORMANCE.
> 
> Fixes: a4675fbc4a7a (cpufreq: intel_pstate: Replace timers with
> utilization update callbacks)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/cpufreq/intel_pstate.c |   29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -1137,10 +1137,8 @@ static void intel_pstate_get_min_max(str
>  	*min = clamp_t(int, min_perf, cpu->pstate.min_pstate,
> max_perf);
>  }
>  
> -static void intel_pstate_set_min_pstate(struct cpudata *cpu)
> +static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
>  {
> -	int pstate = cpu->pstate.min_pstate;
> -
>  	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
>  	cpu->pstate.current_pstate = pstate;
>  	/*
> @@ -1152,6 +1150,20 @@ static void intel_pstate_set_min_pstate(
>  		      pstate_funcs.get_val(cpu, pstate));
>  }
>  
> +static void intel_pstate_set_min_pstate(struct cpudata *cpu)
> +{
> +	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate);
> +}
> +
> +static void intel_pstate_max_within_limits(struct cpudata *cpu)
> +{
> +	int min_pstate, max_pstate;
> +
> +	update_turbo_state();
> +	intel_pstate_get_min_max(cpu, &min_pstate, &max_pstate);
> +	intel_pstate_set_pstate(cpu, max_pstate);
> +}
> +
>  static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>  {
>  	cpu->pstate.min_pstate = pstate_funcs.get_min();
> @@ -1485,7 +1497,7 @@ static int intel_pstate_set_policy(struc
>  	pr_debug("set_policy cpuinfo.max %u policy->max %u\n",
>  		 policy->cpuinfo.max_freq, policy->max);
>  
> -	cpu = all_cpu_data[0];
> +	cpu = all_cpu_data[policy->cpu];
>  	if (cpu->pstate.max_pstate_physical > cpu->pstate.max_pstate 
> &&
>  	    policy->max < policy->cpuinfo.max_freq &&
>  	    policy->max > cpu->pstate.max_pstate * cpu-
> >pstate.scaling) {
> @@ -1529,6 +1541,15 @@ static int intel_pstate_set_policy(struc
>  	limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
>  
>   out:
> +	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +		/*
> +		 * NOHZ_FULL CPUs need this as the governor callback
> may not
> +		 * be invoked on them.
> +		 */
> +		intel_pstate_clear_update_util_hook(policy->cpu);
> +		intel_pstate_max_within_limits(cpu);
> +	}
> +
>  	intel_pstate_set_update_util_hook(policy->cpu);
>  
>  	intel_pstate_hwp_set_policy(policy);
> 
