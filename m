From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC/PATCH 1/6] cpuidle: renesas: Add CPUIdle Driver for Renesas
 SoCs
Date: Thu, 05 Mar 2015 19:05:40 +0100
Message-ID: <54F89AF4.7020805@linaro.org>
References: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com> <1425444946-3084-2-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36058 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbbCESFo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2015 13:05:44 -0500
Received: by widem10 with SMTP id em10so40645229wid.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2015 10:05:42 -0800 (PST)
In-Reply-To: <1425444946-3084-2-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keita Kobayashi <keita.kobayashi.ym@renesas.com>, horms@verge.net.au, rjw@rjwysocki.net
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com

On 03/04/2015 05:55 AM, Keita Kobayashi wrote:
> This patch adds a cpuidle driver for Renesas SoCs.
>
> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> ---
>   drivers/cpuidle/Kconfig.arm                   |   8 ++
>   drivers/cpuidle/Makefile                      |   1 +
>   drivers/cpuidle/cpuidle-renesas.c             | 118 +++++++++++++++=
+++++++++++
>   include/linux/platform_data/renesas-cpuidle.h |  24 ++++++
>   4 files changed, 151 insertions(+)
>   create mode 100644 drivers/cpuidle/cpuidle-renesas.c
>   create mode 100644 include/linux/platform_data/renesas-cpuidle.h
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> index 8e07c94..01cb8cc 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -64,3 +64,11 @@ config ARM_MVEBU_V7_CPUIDLE
>   	depends on ARCH_MVEBU
>   	help
>   	  Select this to enable cpuidle on Armada 370, 38x and XP processo=
rs.
> +
> +config ARM_RENESAS_CPUIDLE
> +	bool "CPU Idle Driver for the renesas SoCs"
> +	depends on ARCH_SHMOBILE_MULTI
> +	select ARM_CPU_SUSPEND
> +	select CPU_IDLE_MULTIPLE_DRIVERS
> +	help
> +	  Select this to enable cpuidle for renesas SoCs
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 4d177b9..c718906 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+=3D cpuidle-zynq.o
>   obj-$(CONFIG_ARM_U8500_CPUIDLE)         +=3D cpuidle-ux500.o
>   obj-$(CONFIG_ARM_AT91_CPUIDLE)          +=3D cpuidle-at91.o
>   obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        +=3D cpuidle-exynos.o
> +obj-$(CONFIG_ARM_RENESAS_CPUIDLE)	+=3D cpuidle-renesas.o
>
>   ###################################################################=
############
>   # MIPS drivers
> diff --git a/drivers/cpuidle/cpuidle-renesas.c b/drivers/cpuidle/cpui=
dle-renesas.c
> new file mode 100644
> index 0000000..b469e95
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-renesas.c
> @@ -0,0 +1,118 @@
> +/*
> + * CPUIdle support code for Renesas ARM
> + *
> + *  Copyright (C) 2014 Renesas Electronics Corporation
> + *
> + * This file is subject to the terms and conditions of the GNU Gener=
al Public
> + * License.  See the file "COPYING" in the main directory of this ar=
chive
> + * for more details.
> + */
> +
> +#include <linux/cpuidle.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/platform_data/renesas-cpuidle.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/suspend.h>
> +#include <asm/cpuidle.h>
> +#include <asm/proc-fns.h>
> +#include <asm/smp_plat.h>
> +
> +static struct cpuidle_driver renesas_cpuidle_default_driver =3D {
> +	.name			=3D "renesas_default_cpuidle",
> +	.owner			=3D THIS_MODULE,
> +	.states[0]		=3D ARM_CPUIDLE_WFI_STATE,
> +	.safe_state_index	=3D 0, /* C1 */
> +	.state_count		=3D 1,
> +};
> +
> +static struct renesas_cpuidle_driver default_driver =3D {
> +	.target_cpu	=3D -1, /* default */
> +	.renesas_drv	=3D &renesas_cpuidle_default_driver,
> +};
> +
> +static struct renesas_cpuidle cpuidle_data =3D {
> +	.num_drvs	=3D 1,
> +	.rcd		=3D &default_driver,
> +};
> +
> +static int __init renesas_idle_driver_init(struct device *dev,
> +				struct renesas_cpuidle_driver *rcd)
> +{
> +	struct cpumask *cpumask =3D NULL;
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		if (smp_cpuid_part(cpu) =3D=3D rcd->target_cpu ||
> +		    rcd->target_cpu =3D=3D -1) { /* default */
> +			if (!cpumask) {
> +				cpumask =3D devm_kzalloc(dev,
> +					  cpumask_size(), GFP_KERNEL);
> +				if (!cpumask)
> +					return -ENOMEM;
> +			}
> +			cpumask_set_cpu(cpu, cpumask);
> +			rcd->renesas_drv->cpumask =3D cpumask;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int renesas_cpuidle_probe(struct platform_device *pdev)
> +{
> +	struct renesas_cpuidle *pd =3D pdev->dev.platform_data;
> +	struct renesas_cpuidle_driver *rcd;
> +	int i, j, ret;
> +
> +	if (!pd->num_drvs || !pd->rcd)
> +		pd =3D &cpuidle_data;
> +
> +	for (i =3D 0; i < pd->num_drvs; i++) {
> +		rcd =3D pd->rcd + i;
> +		ret =3D renesas_idle_driver_init(&pdev->dev, rcd);
> +		if (ret)
> +			goto out_uninit_driver;
> +
> +		if (!rcd->renesas_drv->cpumask)
> +			continue;
> +
> +		ret =3D cpuidle_register(rcd->renesas_drv, NULL);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"failed to register cpuidle driver\n");
> +			goto out_uninit_driver;
> +		}
> +	}
> +
> +	return 0;
> +
> +out_uninit_driver:
> +	for (j =3D 0; j < i; j++) {
> +		rcd =3D pd->rcd + j;
> +
> +		if (!rcd->renesas_drv->cpumask)
> +			continue;
> +
> +		cpuidle_unregister(rcd->renesas_drv);
> +	}
> +
> +	return ret;
> +}

The initialization looks very complex. Can you explain why and what the=
=20
code is doing ?

> +static struct platform_driver renesas_cpuidle_driver =3D {
> +	.probe	=3D renesas_cpuidle_probe,
> +	.driver	=3D {
> +		.name =3D "cpuidle-renesas",
> +		.owner =3D THIS_MODULE,
> +	},
> +};
> +
> +module_platform_driver(renesas_cpuidle_driver);
> +
> +MODULE_DESCRIPTION("Renesas cpuidle driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/platform_data/renesas-cpuidle.h b/include/=
linux/platform_data/renesas-cpuidle.h
> new file mode 100644
> index 0000000..9446215
> --- /dev/null
> +++ b/include/linux/platform_data/renesas-cpuidle.h
> @@ -0,0 +1,24 @@
> +/*
> + * renesas-cpuidle.h -- CPUIdle support code for Renesas ARM
> + *
> + *  Copyright (C) 2014 Renesas Electronics Corporation
> + *
> + * This file is subject to the terms and conditions of the GNU Gener=
al Public
> + * License.  See the file "COPYING" in the main directory of this ar=
chive
> + * for more details.
> + */
> +
> +#ifndef __RENESAS_CPUIDLE_H__
> +#define __RENESAS_CPUIDLE_H__
> +
> +struct renesas_cpuidle_driver {
> +	unsigned int		target_cpu;
> +	struct cpuidle_driver	*renesas_drv;
> +};
> +
> +struct renesas_cpuidle {
> +	unsigned int		num_drvs;
> +	struct renesas_cpuidle_driver *rcd;
> +};
> +
> +#endif /* __RENESAS_CPUIDLE_H__ */
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

