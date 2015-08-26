From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/5] cpufreq: intel-pstate: Use separate max pstate for scaling
Date: Thu, 27 Aug 2015 01:14:48 +0200
Message-ID: <2064519.Kpvm97aGW8@vostro.rjw.lan>
References: <1440621161-2732-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1440621161-2732-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48988 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752831AbbHZWrP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2015 18:47:15 -0400
In-Reply-To: <1440621161-2732-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com, linux-pm@vger.kernel.org

On Wednesday, August 26, 2015 01:32:39 PM Srinivas Pandruvada wrote:
> Systems with configurable TDP have multiple max non turbo p state. Intel
> P state uses max non turbo P state for scaling. But using the real max
> non turbo p state causes underestimation of next P state. So using
> the physical max non turbo P state as before for scaling.

What does "physical" mean here?

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 2641102..a349462 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -77,6 +77,7 @@ struct pstate_data {
>  	int	current_pstate;
>  	int	min_pstate;
>  	int	max_pstate;
> +	int	max_pstate_physical;
>  	int	scaling;
>  	int	turbo_pstate;
>  	u64	turbo_ratio_limit;
> @@ -127,6 +128,7 @@ struct pstate_adjust_policy {
>  
>  struct pstate_funcs {
>  	int (*get_max)(void);
> +	int (*get_max_physical)(void);
>  	int (*get_min)(void);
>  	int (*get_turbo)(void);
>  	int (*get_scaling)(void);
> @@ -599,6 +601,14 @@ static int core_get_min_pstate(void)
>  	return (value >> 40) & 0xFF;
>  }
>  
> +static int core_get_max_pstate_physical(void)
> +{
> +	u64 value;
> +
> +	rdmsrl(MSR_PLATFORM_INFO, value);
> +	return (value >> 8) & 0xFF;
> +}
> +
>  static int core_get_max_pstate(void)
>  {
>  	u64 tar;
> @@ -741,6 +751,7 @@ static struct cpu_defaults core_params = {
>  	},
>  	.funcs = {
>  		.get_max = core_get_max_pstate,
> +		.get_max_physical = core_get_max_pstate_physical,
>  		.get_min = core_get_min_pstate,
>  		.get_turbo = core_get_turbo_pstate,
>  		.get_scaling = core_get_scaling,
> @@ -761,6 +772,7 @@ static struct cpu_defaults byt_params = {
>  	},
>  	.funcs = {
>  		.get_max = byt_get_max_pstate,
> +		.get_max_physical = byt_get_max_pstate,
>  		.get_min = byt_get_min_pstate,
>  		.get_turbo = byt_get_turbo_pstate,
>  		.set = byt_set_pstate,
> @@ -780,6 +792,7 @@ static struct cpu_defaults knl_params = {
>  	},
>  	.funcs = {
>  		.get_max = core_get_max_pstate,
> +		.get_max_physical = core_get_max_pstate_physical,
>  		.get_min = core_get_min_pstate,
>  		.get_turbo = knl_get_turbo_pstate,
>  		.set = core_set_pstate,
> @@ -833,6 +846,7 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>  {
>  	cpu->pstate.min_pstate = pstate_funcs.get_min();
>  	cpu->pstate.max_pstate = pstate_funcs.get_max();
> +	cpu->pstate.max_pstate_physical = pstate_funcs.get_max_physical();
>  	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
>  	cpu->pstate.scaling = pstate_funcs.get_scaling();
>  	if (pstate_funcs.get_turbo_ratio_limit &&
> @@ -854,7 +868,8 @@ static inline void intel_pstate_calc_busy(struct cpudata *cpu)
>  
>  	sample->freq = fp_toint(
>  		mul_fp(int_tofp(
> -			cpu->pstate.max_pstate * cpu->pstate.scaling / 100),
> +			cpu->pstate.max_pstate_physical *
> +			cpu->pstate.scaling / 100),
>  			core_pct));
>  
>  	sample->core_pct_busy = (int32_t)core_pct;
> @@ -922,7 +937,7 @@ static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
>  	 * specified pstate.
>  	 */
>  	core_busy = cpu->sample.core_pct_busy;
> -	max_pstate = int_tofp(cpu->pstate.max_pstate);
> +	max_pstate = int_tofp(cpu->pstate.max_pstate_physical);
>  	current_pstate = int_tofp(cpu->pstate.current_pstate);
>  	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
>  
> @@ -1215,6 +1230,7 @@ static void copy_pid_params(struct pstate_adjust_policy *policy)
>  static void copy_cpu_funcs(struct pstate_funcs *funcs)
>  {
>  	pstate_funcs.get_max   = funcs->get_max;
> +	pstate_funcs.get_max_physical = funcs->get_max_physical;
>  	pstate_funcs.get_min   = funcs->get_min;
>  	pstate_funcs.get_turbo = funcs->get_turbo;
>  	pstate_funcs.get_scaling = funcs->get_scaling;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
