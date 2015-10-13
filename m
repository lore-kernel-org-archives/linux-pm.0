From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH v3 3/6] cpufreq: intel-pstate: Use separate max pstate
 for scaling
Date: Tue, 13 Oct 2015 13:36:47 -0700
Message-ID: <20151013133647.037179dd@kcaccard-desk.amr.corp.intel.com>
References: <1443567248-27134-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<1443567248-27134-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59127 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbbJMUgs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Oct 2015 16:36:48 -0400
In-Reply-To: <1443567248-27134-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, len.brown@intel.com, linux-pm@vger.kernel.org

On Tue, 29 Sep 2015 15:54:05 -0700
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Systems with configurable TDP have multiple max non turbo p state. Intel
> P state uses max non turbo P state for scaling. But using the real max
> non turbo p state causes underestimation of next P state. So using
> the physical max non turbo P state as before for scaling.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Acked-by: Kristen Carlson Accardi <kristen@linux.intel.com>

> ---
>  drivers/cpufreq/intel_pstate.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index b0ae951..0ae9618 100644
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
> @@ -610,6 +612,14 @@ static int core_get_min_pstate(void)
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
> @@ -752,6 +762,7 @@ static struct cpu_defaults core_params = {
>  	},
>  	.funcs = {
>  		.get_max = core_get_max_pstate,
> +		.get_max_physical = core_get_max_pstate_physical,
>  		.get_min = core_get_min_pstate,
>  		.get_turbo = core_get_turbo_pstate,
>  		.get_scaling = core_get_scaling,
> @@ -772,6 +783,7 @@ static struct cpu_defaults byt_params = {
>  	},
>  	.funcs = {
>  		.get_max = byt_get_max_pstate,
> +		.get_max_physical = byt_get_max_pstate,
>  		.get_min = byt_get_min_pstate,
>  		.get_turbo = byt_get_turbo_pstate,
>  		.set = byt_set_pstate,
> @@ -791,6 +803,7 @@ static struct cpu_defaults knl_params = {
>  	},
>  	.funcs = {
>  		.get_max = core_get_max_pstate,
> +		.get_max_physical = core_get_max_pstate_physical,
>  		.get_min = core_get_min_pstate,
>  		.get_turbo = knl_get_turbo_pstate,
>  		.get_scaling = core_get_scaling,
> @@ -845,6 +858,7 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>  {
>  	cpu->pstate.min_pstate = pstate_funcs.get_min();
>  	cpu->pstate.max_pstate = pstate_funcs.get_max();
> +	cpu->pstate.max_pstate_physical = pstate_funcs.get_max_physical();
>  	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
>  	cpu->pstate.scaling = pstate_funcs.get_scaling();
>  	if (pstate_funcs.get_turbo_ratio_limit &&
> @@ -866,7 +880,8 @@ static inline void intel_pstate_calc_busy(struct cpudata *cpu)
>  
>  	sample->freq = fp_toint(
>  		mul_fp(int_tofp(
> -			cpu->pstate.max_pstate * cpu->pstate.scaling / 100),
> +			cpu->pstate.max_pstate_physical *
> +			cpu->pstate.scaling / 100),
>  			core_pct));
>  
>  	sample->core_pct_busy = (int32_t)core_pct;
> @@ -934,7 +949,7 @@ static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
>  	 * specified pstate.
>  	 */
>  	core_busy = cpu->sample.core_pct_busy;
> -	max_pstate = int_tofp(cpu->pstate.max_pstate);
> +	max_pstate = int_tofp(cpu->pstate.max_pstate_physical);
>  	current_pstate = int_tofp(cpu->pstate.current_pstate);
>  	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
>  
> @@ -1232,6 +1247,7 @@ static void copy_pid_params(struct pstate_adjust_policy *policy)
>  static void copy_cpu_funcs(struct pstate_funcs *funcs)
>  {
>  	pstate_funcs.get_max   = funcs->get_max;
> +	pstate_funcs.get_max_physical = funcs->get_max_physical;
>  	pstate_funcs.get_min   = funcs->get_min;
>  	pstate_funcs.get_turbo = funcs->get_turbo;
>  	pstate_funcs.get_scaling = funcs->get_scaling;

