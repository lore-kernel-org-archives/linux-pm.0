From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [V3 patch 19/19] ARM: imx: cpuidle: use init/exit common routine
Date: Wed, 17 Apr 2013 08:24:49 +0200
Message-ID: <516E4031.3000906@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org> <1365770165-27096-20-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56215 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965746Ab3DQGYy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2013 02:24:54 -0400
Received: by mail-wg0-f44.google.com with SMTP id a12so1203154wgh.11
        for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2013 23:24:52 -0700 (PDT)
In-Reply-To: <1365770165-27096-20-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, andrew@lunn.ch, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

On 04/12/2013 02:36 PM, Daniel Lezcano wrote:
> The code intializes the cpuidle driver at different places.
> The cpuidle driver for :
>   * imx5 : is in the pm-imx5.c, the init function is in cpuidle.c
>   * imx6 : is in cpuidle-imx6q.c, the init function is in cpuidle.c
>            and cpuidle-imx6q.c
>
> Instead of having the cpuidle code spread across different files,
> let's create a driver for each SoC and use the common register functi=
on.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Hi Sascha, Shawn,

are you ok with this patch ?

Thanks
-- Daniel


>  arch/arm/mach-imx/Makefile        |    2 +-
>  arch/arm/mach-imx/cpuidle-imx5.c  |   40 +++++++++++++++++++
>  arch/arm/mach-imx/cpuidle-imx6q.c |    2 +-
>  arch/arm/mach-imx/cpuidle.c       |   80 ---------------------------=
----------
>  arch/arm/mach-imx/cpuidle.h       |   10 ++---
>  arch/arm/mach-imx/pm-imx5.c       |   29 +-------------
>  6 files changed, 47 insertions(+), 116 deletions(-)
>  create mode 100644 arch/arm/mach-imx/cpuidle-imx5.c
>  delete mode 100644 arch/arm/mach-imx/cpuidle.c
>
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index c4ce090..cb70961 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -30,7 +30,7 @@ obj-$(CONFIG_MXC_DEBUG_BOARD) +=3D 3ds_debugboard.o
>  obj-$(CONFIG_CPU_FREQ_IMX)    +=3D cpufreq.o
> =20
>  ifeq ($(CONFIG_CPU_IDLE),y)
> -obj-y +=3D cpuidle.o
> +obj-$(CONFIG_SOC_IMX5) +=3D cpuidle-imx5.o
>  obj-$(CONFIG_SOC_IMX6Q) +=3D cpuidle-imx6q.o
>  endif
> =20
> diff --git a/arch/arm/mach-imx/cpuidle-imx5.c b/arch/arm/mach-imx/cpu=
idle-imx5.c
> new file mode 100644
> index 0000000..ba4565f
> --- /dev/null
> +++ b/arch/arm/mach-imx/cpuidle-imx5.c
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
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
> +	return index;
> +}
> +
> +static struct cpuidle_driver imx5_cpuidle_driver =3D {
> +	.name             =3D "imx5_cpuidle",
> +	.owner            =3D THIS_MODULE,
> +	.states[0] =3D {
> +		.enter            =3D imx5_cpuidle_enter,
> +		.exit_latency     =3D 2,
> +		.target_residency =3D 1,
> +		.flags            =3D CPUIDLE_FLAG_TIME_VALID,
> +		.name             =3D "IMX5 SRPG",
> +		.desc             =3D "CPU state retained,powered off",
> +	},
> +	.state_count =3D 1,
> +};
> +
> +int __init imx5_cpuidle_init(void)
> +{
> +	return cpuidle_register(&imx5_cpuidle_driver, NULL);
> +}
> diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cp=
uidle-imx6q.c
> index e2739ad..23ddfb6 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6q.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
> @@ -71,5 +71,5 @@ int __init imx6q_cpuidle_init(void)
>  	/* Set chicken bit to get a reliable WAIT mode support */
>  	imx6q_set_chicken_bit();
> =20
> -	return imx_cpuidle_init(&imx6q_cpuidle_driver);
> +	return cpuidle_register(&imx6q_cpuidle_driver, NULL);
>  }
> diff --git a/arch/arm/mach-imx/cpuidle.c b/arch/arm/mach-imx/cpuidle.=
c
> deleted file mode 100644
> index d4cb511..0000000
> --- a/arch/arm/mach-imx/cpuidle.c
> +++ /dev/null
> @@ -1,80 +0,0 @@
> -/*
> - * Copyright 2012 Freescale Semiconductor, Inc.
> - * Copyright 2012 Linaro Ltd.
> - *
> - * The code contained herein is licensed under the GNU General Publi=
c
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
> -		dev =3D per_cpu_ptr(imx_cpuidle_devices, cpu_id);
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
> -	ret =3D cpuidle_register_driver(drv);
> -	if (ret) {
> -		pr_err("%s: Failed to register cpuidle driver with error: %d\n",
> -			 __func__, ret);
> -		return ret;
> -	}
> -
> -	imx_cpuidle_devices =3D alloc_percpu(struct cpuidle_device);
> -	if (imx_cpuidle_devices =3D=3D NULL) {
> -		ret =3D -ENOMEM;
> -		goto unregister_drv;
> -	}
> -
> -	/* initialize state data for each cpuidle_device */
> -	for_each_possible_cpu(cpu_id) {
> -		dev =3D per_cpu_ptr(imx_cpuidle_devices, cpu_id);
> -		dev->cpu =3D cpu_id;
> -		dev->state_count =3D drv->state_count;
> -
> -		ret =3D cpuidle_register_device(dev);
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
> diff --git a/arch/arm/mach-imx/cpuidle.h b/arch/arm/mach-imx/cpuidle.=
h
> index e092d13..786f98e 100644
> --- a/arch/arm/mach-imx/cpuidle.h
> +++ b/arch/arm/mach-imx/cpuidle.h
> @@ -10,18 +10,16 @@
>   * http://www.gnu.org/copyleft/gpl.html
>   */
> =20
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
> diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.=
c
> index 4b52b3e..82e79c6 100644
> --- a/arch/arm/mach-imx/pm-imx5.c
> +++ b/arch/arm/mach-imx/pm-imx5.c
> @@ -149,32 +149,6 @@ static void imx5_pm_idle(void)
>  	imx5_cpu_do_idle();
>  }
> =20
> -static int imx5_cpuidle_enter(struct cpuidle_device *dev,
> -				struct cpuidle_driver *drv, int idx)
> -{
> -	int ret;
> -
> -	ret =3D imx5_cpu_do_idle();
> -	if (ret < 0)
> -		return ret;
> -
> -	return idx;
> -}
> -
> -static struct cpuidle_driver imx5_cpuidle_driver =3D {
> -	.name			=3D "imx5_cpuidle",
> -	.owner			=3D THIS_MODULE,
> -	.states[0]	=3D {
> -		.enter			=3D imx5_cpuidle_enter,
> -		.exit_latency		=3D 2,
> -		.target_residency	=3D 1,
> -		.flags			=3D CPUIDLE_FLAG_TIME_VALID,
> -		.name			=3D "IMX5 SRPG",
> -		.desc			=3D "CPU state retained,powered off",
> -	},
> -	.state_count		=3D 1,
> -};
> -
>  static int __init imx5_pm_common_init(void)
>  {
>  	int ret;
> @@ -192,8 +166,7 @@ static int __init imx5_pm_common_init(void)
>  	/* Set the registers to the default cpu idle state. */
>  	mx5_cpu_lp_set(IMX5_DEFAULT_CPU_IDLE_STATE);
> =20
> -	imx_cpuidle_init(&imx5_cpuidle_driver);
> -	return 0;
> +	return imx5_cpuidle_init();
>  }
> =20
>  void __init imx51_pm_init(void)


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

