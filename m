From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [V3 patch 19/19] ARM: imx: cpuidle: use init/exit common routine
Date: Wed, 17 Apr 2013 15:15:14 +0800
Message-ID: <20130417071511.GB3338@S2101-09.ap.freescale.net>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-20-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:12834
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965736Ab3DQHPh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2013 03:15:37 -0400
Content-Disposition: inline
In-Reply-To: <1365770165-27096-20-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Thanks for working on this, Daniel.

The imx6q change looks good to me.  But I have a comment on imx5 changes
below.

On Fri, Apr 12, 2013 at 02:36:05PM +0200, Daniel Lezcano wrote:
> diff --git a/arch/arm/mach-imx/cpuidle-imx5.c b/arch/arm/mach-imx/cpuidle-imx5.c
> new file mode 100644
> index 0000000..ba4565f
> --- /dev/null
> +++ b/arch/arm/mach-imx/cpuidle-imx5.c
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/cpuidle.h>
> +#include <linux/module.h>
> +#include <asm/system_misc.h>
> +#include <asm/proc-fns.h>
> +
> +#include "hardware.h"
> +
> +static int imx5_cpuidle_enter(struct cpuidle_device *dev,
> +			      struct cpuidle_driver *drv, int index)
> +{
> +	arm_pm_idle();

The existing imx5 cpuidle code has an tzic_enable_wake() call before
going to idle.  I think it's there for some reason.

Shawn

> +	return index;
> +}
> +
> +static struct cpuidle_driver imx5_cpuidle_driver = {
> +	.name             = "imx5_cpuidle",
> +	.owner            = THIS_MODULE,
> +	.states[0] = {
> +		.enter            = imx5_cpuidle_enter,
> +		.exit_latency     = 2,
> +		.target_residency = 1,
> +		.flags            = CPUIDLE_FLAG_TIME_VALID,
> +		.name             = "IMX5 SRPG",
> +		.desc             = "CPU state retained,powered off",
> +	},
> +	.state_count = 1,
> +};
> +
> +int __init imx5_cpuidle_init(void)
> +{
> +	return cpuidle_register(&imx5_cpuidle_driver, NULL);
> +}
> diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
> index e2739ad..23ddfb6 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6q.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
> @@ -71,5 +71,5 @@ int __init imx6q_cpuidle_init(void)
>  	/* Set chicken bit to get a reliable WAIT mode support */
>  	imx6q_set_chicken_bit();
>  
> -	return imx_cpuidle_init(&imx6q_cpuidle_driver);
> +	return cpuidle_register(&imx6q_cpuidle_driver, NULL);
>  }
> diff --git a/arch/arm/mach-imx/cpuidle.c b/arch/arm/mach-imx/cpuidle.c
> deleted file mode 100644
> index d4cb511..0000000
> --- a/arch/arm/mach-imx/cpuidle.c
> +++ /dev/null
> @@ -1,80 +0,0 @@
> -/*
> - * Copyright 2012 Freescale Semiconductor, Inc.
> - * Copyright 2012 Linaro Ltd.
> - *
> - * The code contained herein is licensed under the GNU General Public
> - * License. You may obtain a copy of the GNU General Public License
> - * Version 2 or later at the following locations:
> - *
> - * http://www.opensource.org/licenses/gpl-license.html
> - * http://www.gnu.org/copyleft/gpl.html
> - */
> -
> -#include <linux/cpuidle.h>
> -#include <linux/err.h>
> -#include <linux/hrtimer.h>
> -#include <linux/io.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -
> -static struct cpuidle_device __percpu * imx_cpuidle_devices;
> -
> -static void __init imx_cpuidle_devices_uninit(void)
> -{
> -	int cpu_id;
> -	struct cpuidle_device *dev;
> -
> -	for_each_possible_cpu(cpu_id) {
> -		dev = per_cpu_ptr(imx_cpuidle_devices, cpu_id);
> -		cpuidle_unregister_device(dev);
> -	}
> -
> -	free_percpu(imx_cpuidle_devices);
> -}
> -
> -int __init imx_cpuidle_init(struct cpuidle_driver *drv)
> -{
> -	struct cpuidle_device *dev;
> -	int cpu_id, ret;
> -
> -	if (drv->state_count > CPUIDLE_STATE_MAX) {
> -		pr_err("%s: state_count exceeds maximum\n", __func__);
> -		return -EINVAL;
> -	}
> -
> -	ret = cpuidle_register_driver(drv);
> -	if (ret) {
> -		pr_err("%s: Failed to register cpuidle driver with error: %d\n",
> -			 __func__, ret);
> -		return ret;
> -	}
> -
> -	imx_cpuidle_devices = alloc_percpu(struct cpuidle_device);
> -	if (imx_cpuidle_devices == NULL) {
> -		ret = -ENOMEM;
> -		goto unregister_drv;
> -	}
> -
> -	/* initialize state data for each cpuidle_device */
> -	for_each_possible_cpu(cpu_id) {
> -		dev = per_cpu_ptr(imx_cpuidle_devices, cpu_id);
> -		dev->cpu = cpu_id;
> -		dev->state_count = drv->state_count;
> -
> -		ret = cpuidle_register_device(dev);
> -		if (ret) {
> -			pr_err("%s: Failed to register cpu %u, error: %d\n",
> -				__func__, cpu_id, ret);
> -			goto uninit;
> -		}
> -	}
> -
> -	return 0;
> -
> -uninit:
> -	imx_cpuidle_devices_uninit();
> -
> -unregister_drv:
> -	cpuidle_unregister_driver(drv);
> -	return ret;
> -}
> diff --git a/arch/arm/mach-imx/cpuidle.h b/arch/arm/mach-imx/cpuidle.h
> index e092d13..786f98e 100644
> --- a/arch/arm/mach-imx/cpuidle.h
> +++ b/arch/arm/mach-imx/cpuidle.h
> @@ -10,18 +10,16 @@
>   * http://www.gnu.org/copyleft/gpl.html
>   */
>  
> -#include <linux/cpuidle.h>
> -
>  #ifdef CONFIG_CPU_IDLE
> -extern int imx_cpuidle_init(struct cpuidle_driver *drv);
> +extern int imx5_cpuidle_init(void);
>  extern int imx6q_cpuidle_init(void);
>  #else
> -static inline int imx_cpuidle_init(struct cpuidle_driver *drv)
> +static inline int imx5_cpuidle_init(void)
>  {
> -	return -ENODEV;
> +	return 0;
>  }
>  static inline int imx6q_cpuidle_init(void)
>  {
> -	return -ENODEV;
> +	return 0;
>  }
>  #endif
> diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
> index 4b52b3e..82e79c6 100644
> --- a/arch/arm/mach-imx/pm-imx5.c
> +++ b/arch/arm/mach-imx/pm-imx5.c
> @@ -149,32 +149,6 @@ static void imx5_pm_idle(void)
>  	imx5_cpu_do_idle();
>  }
>  
> -static int imx5_cpuidle_enter(struct cpuidle_device *dev,
> -				struct cpuidle_driver *drv, int idx)
> -{
> -	int ret;
> -
> -	ret = imx5_cpu_do_idle();
> -	if (ret < 0)
> -		return ret;
> -
> -	return idx;
> -}
> -
> -static struct cpuidle_driver imx5_cpuidle_driver = {
> -	.name			= "imx5_cpuidle",
> -	.owner			= THIS_MODULE,
> -	.states[0]	= {
> -		.enter			= imx5_cpuidle_enter,
> -		.exit_latency		= 2,
> -		.target_residency	= 1,
> -		.flags			= CPUIDLE_FLAG_TIME_VALID,
> -		.name			= "IMX5 SRPG",
> -		.desc			= "CPU state retained,powered off",
> -	},
> -	.state_count		= 1,
> -};
> -
>  static int __init imx5_pm_common_init(void)
>  {
>  	int ret;
> @@ -192,8 +166,7 @@ static int __init imx5_pm_common_init(void)
>  	/* Set the registers to the default cpu idle state. */
>  	mx5_cpu_lp_set(IMX5_DEFAULT_CPU_IDLE_STATE);
>  
> -	imx_cpuidle_init(&imx5_cpuidle_driver);
> -	return 0;
> +	return imx5_cpuidle_init();
>  }
>  
>  void __init imx51_pm_init(void)
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

