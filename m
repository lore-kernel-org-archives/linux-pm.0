From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] cpufreq: intel_pstate: Don't use ACPI perf for HWP
Date: Sat, 14 Nov 2015 01:44:36 +0100
Message-ID: <2644475.8oqnsM3MHE@vostro.rjw.lan>
References: <1447124291-14059-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1447124291-14059-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60593 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751085AbbKNAPN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2015 19:15:13 -0500
In-Reply-To: <1447124291-14059-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, lenlenb@kernel.org, linux-pm@vger.kernel.org

On Monday, November 09, 2015 06:58:09 PM Srinivas Pandruvada wrote:
> When HWP is enabled, the information in _PSS and _PPC prevents entering
> turbo states. The reason is HWP and legacy pstate are not compatible.
> There is no processing of turbo activation ratio in HWP, but _PPC setting
> still behaves as there is support. So we end up in a pstate, which is
> below or equal to max non turbo ratio. Also the max turbo ratio is set to
> wrong value in _PSS, so even if HWP is disabled to use acpi-cpufrq or
> intel_pstate in legacy mode, this will still cause issue. This change will
> not read any _PSS table or call acpi_processor_register_performance,
> when the platform has HWP feature.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 93a3c63..a0b8180 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1557,8 +1557,11 @@ static int __init intel_pstate_init(void)
>  	if (!all_cpu_data)
>  		return -ENOMEM;
>  
> -	if (static_cpu_has_safe(X86_FEATURE_HWP) && !no_hwp)
> -		hwp_active++;
> +	if (static_cpu_has_safe(X86_FEATURE_HWP)) {
> +		if (!no_hwp)
> +			hwp_active++;
> +		no_acpi_perf = 1;
> +	}
>  
>  	if (!hwp_active && hwp_only)
>  		goto out;

Rebased on top of the current Linus' tree and applied.

Thanks,
Rafael

