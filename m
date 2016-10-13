From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RESEND PATCH 06/11] cpufreq: intel_pstate: Add Knights Mill
 CPUID
Date: Thu, 13 Oct 2016 10:51:59 -0700
Message-ID: <1476381119.114531.61.camel@linux.intel.com>
References: <20161013153105.2517-1-piotr.luc@intel.com>
         <20161013153105.2517-7-piotr.luc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59956 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934461AbcJMR5u (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Oct 2016 13:57:50 -0400
In-Reply-To: <20161013153105.2517-7-piotr.luc@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Piotr Luc <piotr.luc@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Doug Thompson <dougthompson@xmission.com>, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org

On Thu, 2016-10-13 at 17:31 +0200, Piotr Luc wrote:
> Add Knights Mill (KNM) to the list of CPUIDs supported by
> intel_pstate.
> 
> Signed-off-by: Piotr Luc <piotr.luc@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> This patch depends on [PATCH 03/11] x86/cpu/intel: Add Knights Mill 
> to Intel family
> 
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index be9eade..4240aff 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1367,6 +1367,7 @@ static const struct x86_cpu_id
> intel_pstate_cpu_ids[] = {
>  	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP,	core_params),
>  	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_params),
>  	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_params),
> +	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_params),
>  	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		bxt_params),
>  	{}
>  };
