From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Improve IO performance
Date: Thu, 10 Aug 2017 00:50:15 +0200
Message-ID: <2483446.prUEGziT9n@aspire.rjw.lan>
References: <1501812194-55363-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56753 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752225AbdHIW6d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2017 18:58:33 -0400
In-Reply-To: <1501812194-55363-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org

On Friday, August 4, 2017 4:03:14 AM CEST Srinivas Pandruvada wrote:
> In the current implementation the latency from SCHED_CPUFREQ_IOWAIT is
> set to actual P-state adjustment can be upto 10ms. This can be improved
> by reacting to SCHED_CPUFREQ_IOWAIT by jumping to max P-state immediately
> . With this change the IO performance improves significantly.
> 
> With a simple "grep -r . linux" (Here linux is kernel source folder) with
> dropped caches every time on a platform with per core P-states on a
> Broadwell Xeon workstation, the user and system time improves as much as
> 30% to 40%.
> 
> The same performance difference was not observed on clients, which don't
> have per core P-state support.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
> As suggested by Rafael also updating  cpu->last_update time
> 
>  drivers/cpufreq/intel_pstate.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 90e8f2b..1cb318b 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1530,6 +1530,15 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
>  
>  	if (flags & SCHED_CPUFREQ_IOWAIT) {
>  		cpu->iowait_boost = int_tofp(1);
> +		cpu->last_update = time;
> +		/*
> +		 * The last time the busy was 100% so P-state was max anyway
> +		 * so avoid overhead of computation.
> +		 */
> +		if (fp_toint(cpu->sample.busy_scaled) == 100)
> +			return;
> +
> +		goto set_pstate;
>  	} else if (cpu->iowait_boost) {
>  		/* Clear iowait_boost if the CPU may have been idle. */
>  		delta_ns = time - cpu->last_update;
> @@ -1541,6 +1550,7 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
>  	if ((s64)delta_ns < INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL)
>  		return;
>  
> +set_pstate:
>  	if (intel_pstate_sample(cpu, time)) {
>  		int target_pstate;
>  
> 

Applied, thanks!
