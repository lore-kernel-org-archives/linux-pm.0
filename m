From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] ARM: clps711x: Add cpuidle driver
Date: Mon, 24 Mar 2014 16:34:44 +0100
Message-ID: <53305094.8010008@linaro.org>
References: <1395467076-29462-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58090 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbaCXPef (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Mar 2014 11:34:35 -0400
Received: by mail-bk0-f46.google.com with SMTP id v15so555246bkz.19
        for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2014 08:34:34 -0700 (PDT)
In-Reply-To: <1395467076-29462-1-git-send-email-shc_work@mail.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>

On 03/22/2014 06:44 AM, Alexander Shiyan wrote:
> Add cpuidle support for ARM Cirrus Logic CLPS711X CPUs.
> This CPU has an unique internal register and write to this location
> will put the system into the Idle State by halting the clock to the
> processor until an interrupt is generated.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>   drivers/cpuidle/Kconfig.arm        |  6 ++++
>   drivers/cpuidle/Makefile           |  1 +
>   drivers/cpuidle/cpuidle-clps711x.c | 64 +++++++++++++++++++++++++++=
+++++++++++
>   3 files changed, 71 insertions(+)
>   create mode 100644 drivers/cpuidle/cpuidle-clps711x.c
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> index 97ccc31..371e75d 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -13,6 +13,12 @@ config ARM_BIG_LITTLE_CPUIDLE
>   	  define different C-states for little and big cores through the
>   	  multiple CPU idle drivers infrastructure.
>
> +config ARM_CLPS711X_CPUIDLE
> +	bool "CPU Idle Driver for CLPS711X processors"
> +	depends on ARCH_CLPS711X || COMPILE_TEST
> +	help
> +	  Select this to enable cpuidle on Cirrus Logic CLPS711X SOCs.
> +
>   config ARM_HIGHBANK_CPUIDLE
>   	bool "CPU Idle Driver for Calxeda processors"
>   	depends on ARM_PSCI
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index f71ae1b..534fff5 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) +=3D couple=
d.o
>   ###################################################################=
###############
>   # ARM SoC drivers
>   obj-$(CONFIG_ARM_BIG_LITTLE_CPUIDLE)	+=3D cpuidle-big_little.o
> +obj-$(CONFIG_ARM_CLPS711X_CPUIDLE)	+=3D cpuidle-clps711x.o
>   obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+=3D cpuidle-calxeda.o
>   obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+=3D cpuidle-kirkwood.o
>   obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+=3D cpuidle-zynq.o
> diff --git a/drivers/cpuidle/cpuidle-clps711x.c b/drivers/cpuidle/cpu=
idle-clps711x.c
> new file mode 100644
> index 0000000..5243811
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-clps711x.c
> @@ -0,0 +1,64 @@
> +/*
> + *  CLPS711X CPU idle driver
> + *
> + *  Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/cpuidle.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define CLPS711X_CPUIDLE_NAME	"clps711x-cpuidle"
> +
> +static void __iomem *clps711x_halt;
> +
> +static int clps711x_cpuidle_halt(struct cpuidle_device *dev,
> +				 struct cpuidle_driver *drv, int index)
> +{
> +	writel(0xaa, clps711x_halt);
> +
> +	return index;
> +}
> +
> +static struct cpuidle_driver clps711x_idle_driver =3D {
> +	.name		=3D CLPS711X_CPUIDLE_NAME,
> +	.owner		=3D THIS_MODULE,
> +	.states[0]	=3D {
> +		.name		=3D "HALT",
> +		.desc		=3D "CLPS711X HALT",
> +		.enter		=3D clps711x_cpuidle_halt,
> +		.exit_latency	=3D 1,

Did you forget target_residency ? Or just not defined it as it is 0 ?

> +	},
> +	.state_count	=3D 1,
> +};
> +
> +static int __init clps711x_cpuidle_probe(struct platform_device *pde=
v)
> +{
> +	struct resource *res;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	clps711x_halt =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(clps711x_halt))
> +		return PTR_ERR(clps711x_halt);
> +
> +	return cpuidle_register(&clps711x_idle_driver, NULL);
> +}
> +
> +static struct platform_driver clps711x_cpuidle_driver =3D {
> +	.driver	=3D {
> +		.name	=3D CLPS711X_CPUIDLE_NAME,
> +		.owner	=3D THIS_MODULE,
> +	},
> +};
> +module_platform_driver_probe(clps711x_cpuidle_driver, clps711x_cpuid=
le_probe);
> +
> +MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
> +MODULE_DESCRIPTION("CLPS711X CPU idle driver");
> +MODULE_LICENSE("GPL");
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

