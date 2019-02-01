From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq: intel_pstate: Rework iowait boosting to be less aggressive
Date: Fri, 1 Feb 2019 08:54:37 -0800
Message-ID: <000001d4ba4e$d33c3220$79b49660$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: ozrUgGQWNCLmLozrWgF2we
In-Reply-To: ozrUgGQWNCLmLozrWgF2we
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2019.01.30 16:05 Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The current iowait boosting mechanism in intel_pstate_update_util()
> is quite aggressive, as it goes to the maximum P-state right away,
> and may cause excessive amounts of energy to be used, which is not
> desirable and arguably isn't necessary too.
>
> Follow commit a5a0809bc58e ("cpufreq: schedutil: Make iowait boost
> more energy efficient") that reworked the analogous iowait boost
> mechanism in the schedutil governor and make the iowait boosting
> in intel_pstate_update_util() work along the same lines.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |   46 +++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -50,6 +50,8 @@
>  #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
>  #define fp_toint(X) ((X) >> FRAC_BITS)
> 
> +#define ONE_EIGHTH_FP ((int64_t)1 << (FRAC_BITS - 3))
> +
>  #define EXT_BITS 6
>  #define EXT_FRAC_BITS (EXT_BITS + FRAC_BITS)
>  #define fp_ext_toint(X) ((X) >> EXT_FRAC_BITS)
> @@ -1678,17 +1680,14 @@ static inline int32_t get_avg_pstate(str
>  static inline int32_t get_target_pstate(struct cpudata *cpu)
>  {
> 	struct sample *sample = &cpu->sample;
> -	int32_t busy_frac, boost;
> +	int32_t busy_frac;
> 	int target, avg_pstate;
> 
> 	busy_frac = div_fp(sample->mperf << cpu->aperf_mperf_shift,
> 			   sample->tsc);
> 
> -	boost = cpu->iowait_boost;
> -	cpu->iowait_boost >>= 1;
> -
> -	if (busy_frac < boost)
> -		busy_frac = boost;
> +	if (busy_frac < cpu->iowait_boost)
> +		busy_frac = cpu->iowait_boost;
> 
> 	sample->busy_scaled = busy_frac * 100;
> 
> @@ -1767,22 +1766,35 @@ static void intel_pstate_update_util(str
> 	if (smp_processor_id() != cpu->cpu)
>  		return;
>
> +	delta_ns = time - cpu->last_update;
> 	if (flags & SCHED_CPUFREQ_IOWAIT) {
> -		cpu->iowait_boost = int_tofp(1);
> -		cpu->last_update = time;
> -		/*
> -		 * The last time the busy was 100% so P-state was max anyway
> -		 * so avoid overhead of computation.
> -		 */
> -		if (fp_toint(cpu->sample.busy_scaled) == 100)
> -			return;
> -
> -		goto set_pstate;
> +		/* Start over if the CPU may have been idle. */
> +		if (delta_ns > TICK_NSEC) {
> +			cpu->iowait_boost = ONE_EIGHTH_FP;
> +		} else if (cpu->iowait_boost) {
> +			cpu->iowait_boost <<= 1;
> +			if (cpu->iowait_boost >= int_tofp(1)) {
> +				cpu->iowait_boost = int_tofp(1);
> +				cpu->last_update = time;
> +				/*
> +				 * The last time the busy was 100% so P-state
> +				 * was max anyway, so avoid the overhead of
> +				 * computation.
> +				 */
> +				if (fp_toint(cpu->sample.busy_scaled) == 100)
> +					return;

Hi Rafael,

By exiting here, the trace, if enabled, is also bypassed.
We want the trace sample.
Also, there is a generic:
"If the target ptstate is the same as before, then don't set it"
later on.
Suggest to delete this test and exit condition. (I see that this early exit was done before also.)

> +
> +				goto set_pstate;
> +			}
> +		} else {
> +			cpu->iowait_boost = ONE_EIGHTH_FP;
> +		}
> 	} else if (cpu->iowait_boost) {
> 		/* Clear iowait_boost if the CPU may have been idle. */
> -		delta_ns = time - cpu->last_update;
> 		if (delta_ns > TICK_NSEC)
>  			cpu->iowait_boost = 0;
> +		else
> +			cpu->iowait_boost >>= 1;
> 	}
> 	cpu->last_update = time;
> 	delta_ns = time - cpu->sample.time;
