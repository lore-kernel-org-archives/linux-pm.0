From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH] cpufreq: intel_pstate: Improve IO performance
Date: Mon, 31 Jul 2017 14:21:47 +0200
Message-ID: <1915794.l080sD0sSP@aspire.rjw.lan>
References: <1501224292-45740-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60554 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751792AbdGaM3x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2017 08:29:53 -0400
In-Reply-To: <1501224292-45740-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org

On Thursday, July 27, 2017 11:44:52 PM Srinivas Pandruvada wrote:
> In the current implementation the latency from SCHED_CPUFREQ_IOWAIT is
> set to actual P-state adjustment can be upto 10ms. This can be improved
> by reacting to SCHED_CPUFREQ_IOWAIT faster in a milli second. With this
> trivial change the IO performance improves significantly.
> 
> With a simple "grep -r . linux" (Here linux is kernel source folder) with
> dropped caches every time on a platform with per core P-states
> (Broadwell and Haswell Xeon ), the performance difference is significant.
> The user and kernel time improvement is more than 20%.
> 
> The same performance difference was not observed on clients and on a
> IvyTown server. which don't have per core P-state support.
> So the performance gain may not be apparent on all systems.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> The idea of this patch is to test if it brings in any significant
> improvement on real world use cases.
> 
>  drivers/cpufreq/intel_pstate.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 8c67b77..639979c 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -38,6 +38,7 @@
>  #include <asm/intel-family.h>
>  
>  #define INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL	(10 * NSEC_PER_MSEC)
> +#define INTEL_PSTATE_IO_WAIT_SAMPLING_INTERVAL	(NSEC_PER_MSEC)
>  #define INTEL_PSTATE_HWP_SAMPLING_INTERVAL	(50 * NSEC_PER_MSEC)

First offf, can we simply set INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL to NSEC_PER_MSEC?

I guess it may help quite a bit in the more "interactive" cases overall.

Or would that be too much overhead?

>  #define INTEL_CPUFREQ_TRANSITION_LATENCY	20000
> @@ -287,6 +288,7 @@ static struct pstate_funcs pstate_funcs __read_mostly;
>  
>  static int hwp_active __read_mostly;
>  static bool per_cpu_limits __read_mostly;
> +static int current_sample_interval = INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL;
>  
>  static struct cpufreq_driver *intel_pstate_driver __read_mostly;
>  
> @@ -1527,15 +1529,18 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
>  
>  	if (flags & SCHED_CPUFREQ_IOWAIT) {
>  		cpu->iowait_boost = int_tofp(1);
> +		current_sample_interval = INTEL_PSTATE_IO_WAIT_SAMPLING_INTERVAL;
>  	} else if (cpu->iowait_boost) {
>  		/* Clear iowait_boost if the CPU may have been idle. */
>  		delta_ns = time - cpu->last_update;
> -		if (delta_ns > TICK_NSEC)
> +		if (delta_ns > TICK_NSEC) {
>  			cpu->iowait_boost = 0;
> +			current_sample_interval = INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL;

Second, if reducing INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL is not viable, why
does the sample interval have to be reduced for all CPUs if SCHED_CPUFREQ_IOWAIT
is set for one of them and not just for the CPU receiving that flag?

> +		}
>  	}
>  	cpu->last_update = time;
>  	delta_ns = time - cpu->sample.time;
> -	if ((s64)delta_ns < INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL)
> +	if ((s64)delta_ns < current_sample_interval)
>  		return;
>  
>  	if (intel_pstate_sample(cpu, time)) {
> 
