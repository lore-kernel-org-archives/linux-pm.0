From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Drop boost_iowait flag
Date: Fri, 21 Oct 2016 08:08:24 -0700
Message-ID: <1477062504.31557.1.camel@linux.intel.com>
References: <3255301.amKi4OUQkX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:53922 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934851AbcJUPLX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Oct 2016 11:11:23 -0400
In-Reply-To: <3255301.amKi4OUQkX@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 2016-10-19 at 02:53 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The "IOwait boosting" mechanism is only used by the
> get_target_pstate_use_cpu_load() governor function and the
> boost_iowait flag in pid_params is always set when that function
> is in use (and it is never set otherwise).  This means that the
> boost_iowait flag is in fact redundant and may be dropped.
> 
> For this reason, replace the boost_iowait flag check in
> intel_pstate_update_util() with an equivalent check against
> pstate_funcs.get_target_pstate and drop that flag.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/cpufreq/intel_pstate.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -233,7 +233,6 @@ static struct cpudata **all_cpu_data;
>   * @p_gain_pct:		PID proportional gain
>   * @i_gain_pct:		PID integral gain
>   * @d_gain_pct:		PID derivative gain
> - * @boost_iowait:	Whether or not to use iowait boosting.
>   *
>   * Stores per CPU model static PID configuration data.
>   */
> @@ -245,7 +244,6 @@ struct pstate_adjust_policy {
>  	int p_gain_pct;
>  	int d_gain_pct;
>  	int i_gain_pct;
> -	bool boost_iowait;
>  };
>  
>  /**
> @@ -1043,7 +1041,6 @@ static const struct cpu_defaults silverm
>  		.p_gain_pct = 14,
>  		.d_gain_pct = 0,
>  		.i_gain_pct = 4,
> -		.boost_iowait = true,
>  	},
>  	.funcs = {
>  		.get_max = atom_get_max_pstate,
> @@ -1065,7 +1062,6 @@ static const struct cpu_defaults airmont
>  		.p_gain_pct = 14,
>  		.d_gain_pct = 0,
>  		.i_gain_pct = 4,
> -		.boost_iowait = true,
>  	},
>  	.funcs = {
>  		.get_max = atom_get_max_pstate,
> @@ -1107,7 +1103,6 @@ static const struct cpu_defaults bxt_par
>  		.p_gain_pct = 14,
>  		.d_gain_pct = 0,
>  		.i_gain_pct = 4,
> -		.boost_iowait = true,
>  	},
>  	.funcs = {
>  		.get_max = core_get_max_pstate,
> @@ -1346,7 +1341,7 @@ static void intel_pstate_update_util(str
>  	struct cpudata *cpu = container_of(data, struct cpudata,
> update_util);
>  	u64 delta_ns;
>  
> -	if (pid_params.boost_iowait) {
> +	if (pstate_funcs.get_target_pstate ==
> get_target_pstate_use_cpu_load) {
>  		if (flags & SCHED_CPUFREQ_IOWAIT) {
>  			cpu->iowait_boost = int_tofp(1);
>  		} else if (cpu->iowait_boost) {
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
