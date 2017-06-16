From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/5] intel_pstate: remove intel_pstate.get()
Date: Sat, 17 Jun 2017 01:53:32 +0200
Message-ID: <1968308.WZqDeDH7Bi@aspire.rjw.lan>
References: <1496889556-17923-1-git-send-email-lenb@kernel.org> <2e0f8c13884240d7189087d19bb8274573638aaf.1496889051.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42732 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750967AbdFQAAo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2017 20:00:44 -0400
In-Reply-To: <2e0f8c13884240d7189087d19bb8274573638aaf.1496889051.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, srinivas.pandruvada@linux.intel.com, hpa@linux.intel.com, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Wednesday, June 07, 2017 07:39:14 PM Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> The x86 cpufreq core now uses aperfmperf_khz_on_cpu()
> to supply /sys/.../cpufreq/scaling_cur_freq
> on all x86 systems supporting APERF/MPERF.
> 
> That includes 100% of systems supported by intel_pstate,
> and so intel_pstate.get() is now a NOP -- remove it.
> 
> Invoke aperfmperf_khz_on_cpu() directly,
> if legacy-mode p-state tracing is enabled.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index b7de5bd..5d67780 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1597,12 +1597,6 @@ static inline bool intel_pstate_sample(struct cpudata *cpu, u64 time)
>  	return false;
>  }
>  
> -static inline int32_t get_avg_frequency(struct cpudata *cpu)
> -{
> -	return mul_ext_fp(cpu->sample.core_avg_perf,
> -			  cpu->pstate.max_pstate_physical * cpu->pstate.scaling);
> -}
> -
>  static inline int32_t get_avg_pstate(struct cpudata *cpu)
>  {
>  	return mul_ext_fp(cpu->pstate.max_pstate_physical,
> @@ -1728,7 +1722,7 @@ static void intel_pstate_adjust_pstate(struct cpudata *cpu, int target_pstate)
>  		sample->mperf,
>  		sample->aperf,
>  		sample->tsc,
> -		get_avg_frequency(cpu),
> +		aperfmperf_khz_on_cpu(cpu->cpu),
>  		fp_toint(cpu->iowait_boost * 100));
>  }
>  
> @@ -1922,13 +1916,6 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
>  	return 0;
>  }
>  
> -static unsigned int intel_pstate_get(unsigned int cpu_num)
> -{
> -	struct cpudata *cpu = all_cpu_data[cpu_num];
> -
> -	return cpu ? get_avg_frequency(cpu) : 0;
> -}
> -
>  static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
>  {
>  	struct cpudata *cpu = all_cpu_data[cpu_num];
> @@ -2157,7 +2144,6 @@ static struct cpufreq_driver intel_pstate = {
>  	.setpolicy	= intel_pstate_set_policy,
>  	.suspend	= intel_pstate_hwp_save_state,
>  	.resume		= intel_pstate_resume,
> -	.get		= intel_pstate_get,
>  	.init		= intel_pstate_cpu_init,
>  	.exit		= intel_pstate_cpu_exit,
>  	.stop_cpu	= intel_pstate_stop_cpu,
> 

This change will cause cpufreq_quick_get() to work differently and it is
called by KVM among other things.  Will that still work?

Thanks,
Rafael
