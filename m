From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use cpu load based algorithm for mobile class devices
Date: Mon, 14 Nov 2016 01:41:03 +0100
Message-ID: <2011718.9oVlD39bSu@vostro.rjw.lan>
References: <1478908059-56178-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57489 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750856AbcKNAda (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Nov 2016 19:33:30 -0500
In-Reply-To: <1478908059-56178-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org

On Friday, November 11, 2016 03:47:39 PM Srinivas Pandruvada wrote:
> Use get_target_pstate_use_cpu_load() to calculate target P-State for
> devices, which uses preferred power management profile as PM_MOBILE
> in ACPI FADT.
> This may help in resolving some thermal issues caused by low sustained
> cpu bound workloads. The current algorithm tend to over provision in this
> case as it doesn't look at the CPU busyness.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index eb76073..8f683e2 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1828,6 +1828,19 @@ static void __init copy_pid_params(struct pstate_adjust_policy *policy)
>  	pid_params.setpoint = policy->setpoint;
>  }
>  
> +#ifdef CONFIG_ACPI
> +static void intel_pstate_use_acpi_profile(void)
> +{
> +	if (acpi_gbl_FADT.preferred_profile == PM_MOBILE)
> +		pstate_funcs.get_target_pstate =
> +				get_target_pstate_use_cpu_load;
> +}
> +#else
> +static void intel_pstate_use_acpi_profile(struct pstate_funcs *funcs)
> +{
> +}
> +#endif
> +
>  static void __init copy_cpu_funcs(struct pstate_funcs *funcs)
>  {
>  	pstate_funcs.get_max   = funcs->get_max;
> @@ -1839,6 +1852,7 @@ static void __init copy_cpu_funcs(struct pstate_funcs *funcs)
>  	pstate_funcs.get_vid   = funcs->get_vid;
>  	pstate_funcs.get_target_pstate = funcs->get_target_pstate;
>  
> +	intel_pstate_use_acpi_profile();
>  }
>  
>  #ifdef CONFIG_ACPI

Applied.

Thanks,
Rafael

