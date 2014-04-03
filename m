From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v6 10/11] cpuidle: mvebu: Add initial CPU idle support
 for Armada 370/XP SoC
Date: Thu, 03 Apr 2014 10:16:56 +0200
Message-ID: <533D18F8.3040102@linaro.org>
References: <1396005211-15573-1-git-send-email-gregory.clement@free-electrons.com> <1396005211-15573-11-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396005211-15573-11-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/28/2014 12:13 PM, Gregory CLEMENT wrote:
> Add the wfi, cpu idle and cpu deep idle power states support for the
> Armada XP SoCs.
>
> All the latencies and the power consumption values used at the
> "armada_370_xp_idle_driver" structure are preliminary and will be
> modified in the future after running some measurements and analysis.
>
> Based on the work of Nadav Haklai.
>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/cpuidle/Kconfig.arm             |  5 ++
>   drivers/cpuidle/Makefile                |  1 +
>   drivers/cpuidle/cpuidle-armada-370-xp.c | 93 ++++++++++++++++++++++=
+++++++++++
>   3 files changed, 99 insertions(+)
>   create mode 100644 drivers/cpuidle/cpuidle-armada-370-xp.c
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> index 97ccc31dbdd8..5bb94780d377 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -1,6 +1,11 @@
>   #
>   # ARM CPU Idle drivers
>   #
> +config ARM_ARMADA_370_XP_CPUIDLE
> +	bool "CPU Idle Driver for Armada 370/XP family processors"
> +	depends on ARCH_MVEBU
> +	help
> +	  Select this to enable cpuidle on Armada 370/XP processors.
>
>   config ARM_BIG_LITTLE_CPUIDLE
>   	bool "Support for ARM big.LITTLE processors"
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index f71ae1b373c5..9902d052bd87 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) +=3D couple=
d.o
>
>   ###################################################################=
###############
>   # ARM SoC drivers
> +obj-$(CONFIG_ARM_ARMADA_370_XP_CPUIDLE) +=3D cpuidle-armada-370-xp.o
>   obj-$(CONFIG_ARM_BIG_LITTLE_CPUIDLE)	+=3D cpuidle-big_little.o
>   obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+=3D cpuidle-calxeda.o
>   obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+=3D cpuidle-kirkwood.o
> diff --git a/drivers/cpuidle/cpuidle-armada-370-xp.c b/drivers/cpuidl=
e/cpuidle-armada-370-xp.c
> new file mode 100644
> index 000000000000..6b98608c222e
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-armada-370-xp.c
> @@ -0,0 +1,93 @@
> +/*
> + * Marvell Armada 370 and Armada XP SoC cpuidle driver
> + *
> + * Copyright (C) 2013 Marvell

2014 ?

> + *
> + * Nadav Haklai <nadavh@marvell.com>
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * Maintainer: Gregory CLEMENT <gregory.clement@free-electrons.com>
> + */
> +
> +#include <linux/cpu_pm.h>
> +#include <linux/cpuidle.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/suspend.h>
> +#include <linux/platform_device.h>
> +#include <asm/cpuidle.h>
> +
> +#define ARMADA_370_XP_MAX_STATES	3
> +#define ARMADA_370_XP_FLAG_DEEP_IDLE	0x10000
> +
> +static int (*armada_370_xp_cpu_suspend)(int);
> +
> +static int armada_370_xp_enter_idle(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv,
> +				int index)
> +{
> +	int ret;
> +	bool deepidle =3D false;
> +	cpu_pm_enter();
> +
> +	if (drv->states[index].flags & ARMADA_370_XP_FLAG_DEEP_IDLE)
> +		deepidle =3D true;
> +
> +	ret =3D armada_370_xp_cpu_suspend(deepidle);
> +	if (ret)
> +		return ret;
> +
> +	cpu_pm_exit();
> +
> +	return index;
> +}
> +
> +static struct cpuidle_driver armada_370_xp_idle_driver =3D {
> +	.name			=3D "armada_370_xp_idle",
> +	.states[0]		=3D ARM_CPUIDLE_WFI_STATE,
> +	.states[1]		=3D {
> +		.enter			=3D armada_370_xp_enter_idle,
> +		.exit_latency		=3D 10,
> +		.power_usage		=3D 50,
> +		.target_residency	=3D 100,
> +		.flags			=3D CPUIDLE_FLAG_TIME_VALID,
> +		.name			=3D "MV CPU IDLE",
> +		.desc			=3D "CPU power down",
> +	},
> +	.states[2]		=3D {
> +		.enter			=3D armada_370_xp_enter_idle,
> +		.exit_latency		=3D 100,
> +		.power_usage		=3D 5,
> +		.target_residency	=3D 1000,
> +		.flags			=3D CPUIDLE_FLAG_TIME_VALID |
> +						ARMADA_370_XP_FLAG_DEEP_IDLE,
> +		.name			=3D "MV CPU DEEP IDLE",
> +		.desc			=3D "CPU and L2 Fabric power down",
> +	},
> +	.state_count =3D ARMADA_370_XP_MAX_STATES,
> +};
> +
> +static int armada_370_xp_cpuidle_probe(struct platform_device *pdev)
> +{
> +
> +	armada_370_xp_cpu_suspend =3D (void *)(pdev->dev.platform_data);
> +	return cpuidle_register(&armada_370_xp_idle_driver, NULL);
> +}
> +
> +static struct platform_driver armada_370_xp_cpuidle_plat_driver =3D =
{
> +	.driver =3D {
> +		.name =3D "cpuidle-armada-370-xp",
> +		.owner =3D THIS_MODULE,
> +	},
> +	.probe =3D armada_370_xp_cpuidle_probe,
> +};
> +
> +module_platform_driver(armada_370_xp_cpuidle_plat_driver);
> +
> +MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>"=
);
> +MODULE_DESCRIPTION("Armada 370/XP cpu idle driver");
> +MODULE_LICENSE("GPL");
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
