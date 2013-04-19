From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [V3 patch 13/19] ARM: OMAP4: cpuidle: use init/exit common routine
Date: Fri, 19 Apr 2013 15:19:33 -0700
Message-ID: <87k3nyw4cq.fsf@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
	<1365770165-27096-14-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:58032 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933748Ab3DSWTh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Apr 2013 18:19:37 -0400
Received: by mail-da0-f41.google.com with SMTP id p8so2001061dan.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Apr 2013 15:19:36 -0700 (PDT)
In-Reply-To: <1365770165-27096-14-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Fri, 12 Apr 2013 14:35:59 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> Remove the duplicated code and use the cpuidle common code for initialization.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Kevin Hilman <khilman@linaro.org>

> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |   22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index cd188de..861dd90 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -15,6 +15,7 @@
>  #include <linux/cpu_pm.h>
>  #include <linux/export.h>
>  
> +#include <asm/cpuidle.h>
>  #include <asm/proc-fns.h>
>  
>  #include "common.h"
> @@ -157,8 +158,6 @@ fail:
>  	return index;
>  }
>  
> -static DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
> -
>  static struct cpuidle_driver omap4_idle_driver = {
>  	.name				= "omap4_idle",
>  	.owner				= THIS_MODULE,
> @@ -207,9 +206,6 @@ static struct cpuidle_driver omap4_idle_driver = {
>   */
>  int __init omap4_idle_init(void)
>  {
> -	struct cpuidle_device *dev;
> -	unsigned int cpu_id = 0;
> -
>  	mpu_pd = pwrdm_lookup("mpu_pwrdm");
>  	cpu_pd[0] = pwrdm_lookup("cpu0_pwrdm");
>  	cpu_pd[1] = pwrdm_lookup("cpu1_pwrdm");
> @@ -221,19 +217,5 @@ int __init omap4_idle_init(void)
>  	if (!cpu_clkdm[0] || !cpu_clkdm[1])
>  		return -ENODEV;
>  
> -	for_each_cpu(cpu_id, cpu_online_mask) {
> -		dev = &per_cpu(omap4_idle_dev, cpu_id);
> -		dev->cpu = cpu_id;
> -#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
> -		dev->coupled_cpus = *cpu_online_mask;
> -#endif
> -		cpuidle_register_driver(&omap4_idle_driver);
> -
> -		if (cpuidle_register_device(dev)) {
> -			pr_err("%s: CPUidle register failed\n", __func__);
> -			return -EIO;
> -		}
> -	}
> -
> -	return 0;
> +	return cpuidle_register(&omap4_idle_driver, cpu_online_mask);
>  }
