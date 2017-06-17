From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/5] intel_pstate: skip scheduler hook when in "performance" mode.
Date: Sat, 17 Jun 2017 02:04:59 +0200
Message-ID: <6542869.y10POnRxLl@aspire.rjw.lan>
References: <1496889556-17923-1-git-send-email-lenb@kernel.org> <1ecfadf4193fbd8873d4bcda9e9faec5825bcafb.1496889051.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44916 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751144AbdFQAMK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2017 20:12:10 -0400
In-Reply-To: <1ecfadf4193fbd8873d4bcda9e9faec5825bcafb.1496889051.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, srinivas.pandruvada@linux.intel.com
Cc: x86@kernel.org, hpa@linux.intel.com, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Wednesday, June 07, 2017 07:39:15 PM Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> When the governor is set to "performance", intel_pstate does not
> need the scheduler hook for doing any calculations.  Under these
> conditions, its only purpose is to continue to maintain
> cpufreq/scaling_cur_freq.
> 
> But the cpufreq/scaling_cur_freq sysfs attribute is now provided by
> the x86 cpufreq core on all modern x86 systems, including
> all systems supported by the intel_pstate driver.
> 
> So in "performance" governor mode, the scheduler hook can be skipped.
> This applies to both in Software and Hardware P-state control modes.
> 
> Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 5d67780..0ff3a4b 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2025,10 +2025,10 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  		 */
>  		intel_pstate_clear_update_util_hook(policy->cpu);

The statement above shouldn't be necessary any more after the change below.

>  		intel_pstate_max_within_limits(cpu);
> +	} else {
> +		intel_pstate_set_update_util_hook(policy->cpu);
>  	}
>  
> -	intel_pstate_set_update_util_hook(policy->cpu);
> -
>  	if (hwp_active)
>  		intel_pstate_hwp_set(policy->cpu);
>  
> 

What about update_turbo_pstate()?

In theory MSR_IA32_MISC_ENABLE_TURBO_DISABLE can be set at any time, so
wouldn't that become problematic after this change?

Thanks,
Rafael
