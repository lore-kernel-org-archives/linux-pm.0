From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/1] thermal/powerclamp: correct cpu support check
Date: Fri, 7 Oct 2016 05:46:13 -0700
Message-ID: <20161007054613.11c65d59@jacob-builder>
References: <1475769409-188472-1-git-send-email-eric.ernst@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:12066 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752411AbcJGMon (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Oct 2016 08:44:43 -0400
In-Reply-To: <1475769409-188472-1-git-send-email-eric.ernst@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eric Ernst <eric.ernst@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, rafael.j.wysocki@intel.com, jacob.jun.pan@linux.intel.com

On Thu,  6 Oct 2016 08:56:49 -0700
Eric Ernst <eric.ernst@linux.intel.com> wrote:

> Initial logic for checking CPU match resulted in OR of CPU features
> rather than the intended AND.
> 
> Updated to use boot_cpu_has macro rather than x86_match_cpu.
> 
> In addition, MWAIT is the only required CPU feature for idle
> injection to work.  Drop other feature requirements since they are
> only needed for optimal efficiency.
> 

Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

> Signed-off-by: Eric Ernst <eric.ernst@linux.intel.com>
> ---
>  drivers/thermal/intel_powerclamp.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/intel_powerclamp.c
> b/drivers/thermal/intel_powerclamp.c index 0e4dc0afcfd2..7a223074df3d
> 100644 --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -669,20 +669,10 @@ static struct thermal_cooling_device_ops
> powerclamp_cooling_ops = { .set_cur_state = powerclamp_set_cur_state,
>  };
>  
> -static const struct x86_cpu_id intel_powerclamp_ids[] __initconst = {
> -	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY,
> X86_FEATURE_MWAIT },
> -	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY,
> X86_FEATURE_ARAT },
> -	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY,
> X86_FEATURE_NONSTOP_TSC },
> -	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY,
> X86_FEATURE_CONSTANT_TSC},
> -	{}
> -};
> -MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
> -
>  static int __init powerclamp_probe(void)
>  {
> -	if (!x86_match_cpu(intel_powerclamp_ids)) {
> -		pr_err("Intel powerclamp does not run on family %d
> model %d\n",
> -				boot_cpu_data.x86,
> boot_cpu_data.x86_model);
> +	if (!boot_cpu_has(X86_FEATURE_MWAIT)) {
> +		pr_err("CPU does not support MWAIT");
>  		return -ENODEV;
>  	}
>  

[Jacob Pan]
