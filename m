From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Add Knights Mill CPUID
Date: Wed, 12 Oct 2016 21:39:24 +0200
Message-ID: <1991911.AIWBrncZ9n@vostro.rjw.lan>
References: <20161012182550.2102-1-piotr.luc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161012182550.2102-1-piotr.luc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Piotr Luc <piotr.luc@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 12, 2016 08:25:50 PM Piotr Luc wrote:
> Add Knights Mill (KNM) to the list of CPUIDs supported by intel_pstate.
> 
> Signed-off-by: Piotr Luc <piotr.luc@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Depends-on: x86/cpu/intel: Add Knights Mill to Intel family
> https://lkml.kernel.org/r/20161012180520.30976-1-piotr.luc () intel ! com

First, putting broken URLs into patch tags doesn't really help.

Second, please send all of these patches as a series where the first
patch makes the change the rest depends on.  That would make them easier to
handle.

> 
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index be9eade..4240aff 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1367,6 +1367,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
>  	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP,	core_params),
>  	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_params),
>  	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_params),
> +	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_params),
>  	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		bxt_params),
>  	{}
>  };
> 

Thanks,
Rafael
