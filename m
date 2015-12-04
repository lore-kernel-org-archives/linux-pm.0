From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V5 3/3] cpufreq: intel_pstate: Account for IO wait time
Date: Fri, 04 Dec 2015 03:27:30 +0100
Message-ID: <2687831.oTQipaeDPC@vostro.rjw.lan>
References: <1449165359-25832-1-git-send-email-philippe.longepe@linux.intel.com> <1449165359-25832-7-git-send-email-philippe.longepe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56480 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753366AbbLDB5h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2015 20:57:37 -0500
In-Reply-To: <1449165359-25832-7-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Longepe <philippe.longepe@linux.intel.com>
Cc: linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com, Stephane Gasparini <stephane.gasparini@intel.com>, Philippe Longepe <philippe.longepe@intel.com>

On Thursday, December 03, 2015 06:55:58 PM Philippe Longepe wrote:
> From: Stephane Gasparini <stephane.gasparini@intel.com>
> 
> To improve IO bound work,

Improve how?

> account IO wait time in calculating
> CPU busy. This change gets IO wait time using get_cpu_iowait_time_us,

"uses get_cpu_iowait_time_us() to obtain the IO wait time value "

> and converts time into number of IO cycles spent at max non turbo

Surely CPU cycles spent waiting on IO?

> frequency. This IO cycle count is added to mperf value to account
> for IO wait time.

This also should say that the trick is only used for Atom.

What about:

"The CPU utilization calculation algorithm used for the Airmont/Silvermont
Atom cores is modified by adding that "IO cycles count" to the MPERF value
to account for the IO wait time."

You should also say what's the expected impact of this change.

> 
> Signed-off-by: Philippe Longepe <philippe.longepe@intel.com>
> Signed-off-by: Stephane Gasparini <stephane.gasparini@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 2cf8bb6..fb92402 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -114,6 +114,7 @@ struct cpudata {
>  	u64	prev_mperf;
>  	u64	prev_tsc;
>  	struct sample sample;
> +	u64 prev_cummulative_iowait;
>  };
>  
>  static struct cpudata **all_cpu_data;
> @@ -934,16 +935,28 @@ static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
>  static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)
>  {
>  	struct sample *sample = &cpu->sample;
> +	u64 cummulative_iowait, delta_iowait_us;
> +	u64 delta_iowait_mperf;
> +	u64 mperf, now;
>  	int32_t cpu_load;
>  
> +	cummulative_iowait = get_cpu_iowait_time_us(cpu->cpu, &now);
> +
> +	/* Convert iowait time into number of IO cycles spent at max_freq */

It would be good to say why this is done here in the comment.

> +	delta_iowait_us = cummulative_iowait - cpu->prev_cummulative_iowait;
> +	delta_iowait_mperf = div64_u64(delta_iowait_us * cpu->pstate.scaling *
> +		cpu->pstate.max_pstate, 1000);

MSEC_PER_SEC should be used here if I'm not mistaken.

> +
> +	mperf = cpu->sample.mperf + delta_iowait_mperf;
> +	cpu->prev_cummulative_iowait = cummulative_iowait;
> +
>  	/*
>  	 * The load can be estimated as the ratio of the mperf counter
>  	 * running at a constant frequency during active periods
>  	 * (C0) and the time stamp counter running at the same frequency
>  	 * also during C-states.
>  	 */
> -	cpu_load = div64_u64(100 * sample->mperf, sample->tsc);
> -
> +	cpu_load = div64_u64(100 * mperf, sample->tsc);
>  	cpu->sample.busy_scaled = int_tofp(cpu_load);
>  
>  	return (cpu->pstate.current_pstate - pid_calc(&cpu->pid,
> 

Thanks,
Rafael

