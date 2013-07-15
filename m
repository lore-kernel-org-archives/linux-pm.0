From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] Thermal: x86 package temp thermal crash
Date: Mon, 15 Jul 2013 16:27:19 +0800
Message-ID: <1373876839.3034.1.camel@rzhang1-mobl4>
References: <1373561430-29314-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15355 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345Ab3GOI13 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Jul 2013 04:27:29 -0400
In-Reply-To: <1373561430-29314-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: dwalker@fifo99.com, linux-pm@vger.kernel.org, eduardo.valentin@ti.com

On Thu, 2013-07-11 at 09:50 -0700, Srinivas Pandruvada wrote:
> On systems with no package MSR support this caused crash as there
> is a bug in the logic to check presence of DTHERM and PTS feature
> together. Added a change so that when there is no PTS support, module
> doesn't get loaded. Even if some CPU comes online with the PTS
> feature disabled, and other CPUs has this support, this patch
> will still prevent such MSR accesses.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reported-by: Daniel Walker <dwalker@fifo99.com>

applied to thermal -next.

thanks,
rui
> ---
>  drivers/thermal/x86_pkg_temp_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
> index 5de56f6..034604c 100644
> --- a/drivers/thermal/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/x86_pkg_temp_thermal.c
> @@ -511,7 +511,7 @@ static int get_core_online(unsigned int cpu)
>  
>  	/* Check if there is already an instance for this package */
>  	if (!phdev) {
> -		if (!cpu_has(c, X86_FEATURE_DTHERM) &&
> +		if (!cpu_has(c, X86_FEATURE_DTHERM) ||
>  					!cpu_has(c, X86_FEATURE_PTS))
>  			return -ENODEV;
>  		if (pkg_temp_thermal_device_add(cpu))
> @@ -562,7 +562,7 @@ static struct notifier_block pkg_temp_thermal_notifier __refdata = {
>  };
>  
>  static const struct x86_cpu_id __initconst pkg_temp_thermal_ids[] = {
> -	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_DTHERM },
> +	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_PTS },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, pkg_temp_thermal_ids);


