From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] drivers/idle: make intel_idle.c driver more explicitly
 non-modular
Date: Mon, 4 Apr 2016 15:55:35 -0400
Message-ID: <20160404195535.GQ1778@windriver.com>
References: <1459099777-4962-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:53278 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbcDDTzy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2016 15:55:54 -0400
Content-Disposition: inline
In-Reply-To: <1459099777-4962-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Richard Cochran <rcochran@linutronix.de>

[[PATCH] drivers/idle: make intel_idle.c driver more explicitly non-modular] On 27/03/2016 (Sun 13:29) Paul Gortmaker wrote:

> The Kconfig for this driver is currently declared with:
> 
> config INTEL_IDLE
>         bool "Cpuidle Driver for Intel Processors"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> This was done in commit 6ce9cd8669fa1195fdc21643370e34523c7ac988
> ("intel_idle: disable module support") since "...the module capability
> is cauing more trouble than it is worth."
> 
> Since this was done over 5y ago, it is safe to say there is no big desire
> to overcome the issues with modular versions.  So lets remove the modular
> code that is essentially orphaned, so that when reading the driver there
> is no doubt it is builtin-only.

This patch will no longer apply since there were several updates to this
driver by Richard Cochran dated March 29th.   Before I go and refresh
the patch for a v2, is there any objections to the general goal of what
the patch was aiming to achieve -- avoiding use of modular infrastructure
in non-modular code, and not having module_exit code that can't be run?

Thanks,
Paul.
--

> 
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.  At a
> later date we might want to consider whether subsys_init or another
> init category seems more appropriate than device_init.
> 
> We replace module.h with moduleparam.h since the file does declare
> some module parameters, and leaving them as such is currently the
> easiest way to remain compatible with existing boot arg use cases.
> 
> Note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> Also note that we can't remove intel_idle_cpuidle_devices_uninit() as
> that is still used for unwind purposes if the init fails.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: Len Brown <lenb@kernel.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/idle/intel_idle.c | 35 ++++++++---------------------------
>  1 file changed, 8 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index ba947df5a8c7..d1b5a821664d 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -46,8 +46,6 @@
>   * to avoid complications with the lapic timer workaround.
>   * Have not seen issues with suspend, but may need same workaround here.
>   *
> - * There is currently no kernel-based automatic probing/loading mechanism
> - * if the driver is built as a module.
>   */
>  
>  /* un-comment DEBUG to enable pr_debug() statements */
> @@ -60,7 +58,7 @@
>  #include <linux/sched.h>
>  #include <linux/notifier.h>
>  #include <linux/cpu.h>
> -#include <linux/module.h>
> +#include <linux/moduleparam.h>
>  #include <asm/cpu_device_id.h>
>  #include <asm/mwait.h>
>  #include <asm/msr.h>
> @@ -948,7 +946,6 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>  	ICPU(0x57, idle_cpu_knl),
>  	{}
>  };
> -MODULE_DEVICE_TABLE(x86cpu, intel_idle_ids);
>  
>  /*
>   * intel_idle_probe()
> @@ -1247,28 +1244,12 @@ static int __init intel_idle_init(void)
>  
>  	return 0;
>  }
> +device_initcall(intel_idle_init);
>  
> -static void __exit intel_idle_exit(void)
> -{
> -	intel_idle_cpuidle_devices_uninit();
> -	cpuidle_unregister_driver(&intel_idle_driver);
> -
> -	cpu_notifier_register_begin();
> -
> -	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
> -		on_each_cpu(__setup_broadcast_timer, (void *)false, 1);
> -	__unregister_cpu_notifier(&cpu_hotplug_notifier);
> -
> -	cpu_notifier_register_done();
> -
> -	return;
> -}
> -
> -module_init(intel_idle_init);
> -module_exit(intel_idle_exit);
> -
> +/*
> + * We are not really modular, but we used to support that.  Meaning we also
> + * support "intel_idle.max_cstate=..." at boot and also a read-only export of
> + * it at /sys/module/intel_idle/parameters/max_cstate -- so using module_param
> + * is the easiest way (currently) to continue doing that.
> + */
>  module_param(max_cstate, int, 0444);
> -
> -MODULE_AUTHOR("Len Brown <len.brown@intel.com>");
> -MODULE_DESCRIPTION("Cpuidle driver for Intel Hardware v" INTEL_IDLE_VERSION);
> -MODULE_LICENSE("GPL");
> -- 
> 2.6.1
> 
