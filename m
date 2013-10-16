From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [Update][PATCH] intel_pstate: Fix type mismatch warning
Date: Wed, 16 Oct 2013 10:24:46 -0700
Message-ID: <525ECBDE.5000801@linux.intel.com>
References: <9494730.EGV2mTSpNl@vostro.rjw.lan> <2582369.lNhAMrrx8s@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16826 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760932Ab3JPRZU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Oct 2013 13:25:20 -0400
In-Reply-To: <2582369.lNhAMrrx8s@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, dirk.brandewie@gmail.com, Dirk Brandewie <dirk.j.brandewie@intel.com>

On 10/16/2013 05:53 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The expression in line 398 of intel_pstate.c causes the following
> warning to be emitted:
>
> drivers/cpufreq/intel_pstate.c:398:3: warning: left shift count >= width of type
>
> which happens because unsigned long is 32-bit on some architectures.
> Fix that by using a helper u64 variable and simplify the code
> slightly.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/cpufreq/intel_pstate.c |    7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -383,6 +383,7 @@ static void intel_pstate_get_min_max(str
>   static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
>   {
>   	int max_perf, min_perf;
> +	u64 val;
>   
>   	intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
>   
> @@ -394,11 +395,11 @@ static void intel_pstate_set_pstate(stru
>   	trace_cpu_frequency(pstate * 100000, cpu->cpu);
>   
>   	cpu->pstate.current_pstate = pstate;
> +	val = pstate << 8;
>   	if (limits.no_turbo)
> -		wrmsrl(MSR_IA32_PERF_CTL, BIT(32) | (pstate << 8));
> -	else
> -		wrmsrl(MSR_IA32_PERF_CTL, pstate << 8);
> +		val |= (u64)1 << 32;
>   
> +	wrmsrl(MSR_IA32_PERF_CTL, val);
>   }
>   
>   static inline void intel_pstate_pstate_increase(struct cpudata *cpu, int steps)
>
>
Tested with this change.

Thanks,
Srinivas
