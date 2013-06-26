From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/3] ARM: EXYNOS: move cpuidle driver to drivers/cpuidle/
Date: Wed, 26 Jun 2013 12:46:42 +0200
Message-ID: <51CAC692.4080902@linaro.org>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com> <1372241627-22695-4-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1372241627-22695-4-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, jc.lee@samsung.com, lorenzo.pieralisi@arm.com, amit.kachhap@linaro.org, t.figa@samsung.com, rjw@sisk.pl, kyungmin.park@samsung.com
List-Id: linux-pm@vger.kernel.org

On 06/26/2013 12:13 PM, Bartlomiej Zolnierkiewicz wrote:
> While at it:
> - remove "common.h" include
> - remove wrong comment about file path
>=20
> Tested on Exynos4210 (Universal C210 board).

I agree to move the driver to the drivers/cpuidle, but the header
#include <mach/regs-clock.h> shouldn't appear in this file.

There were several attempts to move the cpuidle drivers to this
directory [1]  and we agree to separate the pm code from the driver
code. A bit of code encapsulation should be done here before.

Thanks
  -- Daniel

ps : "use -M to generate the patch" when moving files from one director=
y
to another one.

[1] https://patchwork.kernel.org/patch/2445191/

> Cc: Jaecheol Lee <jc.lee@samsung.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/Makefile    |  1 -
>  arch/arm/mach-exynos/cpuidle.c   | 95 ------------------------------=
----------
>  drivers/cpuidle/Makefile         |  3 ++
>  drivers/cpuidle/cpuidle-exynos.c | 92 ++++++++++++++++++++++++++++++=
++++++++
>  4 files changed, 95 insertions(+), 96 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos/cpuidle.c
>  create mode 100644 drivers/cpuidle/cpuidle-exynos.c
>=20
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Mak=
efile
> index b09b027..0f91c7a 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -16,7 +16,6 @@ obj-$(CONFIG_ARCH_EXYNOS)	+=3D common.o
> =20
>  obj-$(CONFIG_PM)		+=3D pm.o
>  obj-$(CONFIG_PM_GENERIC_DOMAINS) +=3D pm_domains.o
> -obj-$(CONFIG_CPU_IDLE)		+=3D cpuidle.o
> =20
>  obj-$(CONFIG_ARCH_EXYNOS)	+=3D pmu.o
> =20
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cp=
uidle.c
> deleted file mode 100644
> index d6e5115..0000000
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ /dev/null
> @@ -1,95 +0,0 @@
> -/* linux/arch/arm/mach-exynos4/cpuidle.c
> - *
> - * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> - *		http://www.samsung.com
> - *
> - * This program is free software; you can redistribute it and/or mod=
ify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/cpuidle.h>
> -#include <linux/cpu_pm.h>
> -#include <linux/io.h>
> -#include <linux/export.h>
> -#include <linux/time.h>
> -
> -#include <asm/proc-fns.h>
> -#include <asm/cpuidle.h>
> -#include <mach/regs-clock.h>
> -
> -#include "common.h"
> -
> -static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device)=
;
> -
> -static struct cpuidle_driver exynos4_idle_driver =3D {
> -	.name			=3D "exynos4_idle",
> -	.owner			=3D THIS_MODULE,
> -	.states =3D {
> -		[0] =3D ARM_CPUIDLE_WFI_STATE,
> -	},
> -	.state_count =3D 1,
> -	.safe_state_index =3D 0,
> -};
> -
> -static void __init exynos5_core_down_clk(void)
> -{
> -	unsigned int tmp;
> -
> -	/*
> -	 * Enable arm clock down (in idle) and set arm divider
> -	 * ratios in WFI/WFE state.
> -	 */
> -	tmp =3D PWR_CTRL1_CORE2_DOWN_RATIO | \
> -	      PWR_CTRL1_CORE1_DOWN_RATIO | \
> -	      PWR_CTRL1_DIV2_DOWN_EN	 | \
> -	      PWR_CTRL1_DIV1_DOWN_EN	 | \
> -	      PWR_CTRL1_USE_CORE1_WFE	 | \
> -	      PWR_CTRL1_USE_CORE0_WFE	 | \
> -	      PWR_CTRL1_USE_CORE1_WFI	 | \
> -	      PWR_CTRL1_USE_CORE0_WFI;
> -	__raw_writel(tmp, EXYNOS5_PWR_CTRL1);
> -
> -	/*
> -	 * Enable arm clock up (on exiting idle). Set arm divider
> -	 * ratios when not in idle along with the standby duration
> -	 * ratios.
> -	 */
> -	tmp =3D PWR_CTRL2_DIV2_UP_EN	 | \
> -	      PWR_CTRL2_DIV1_UP_EN	 | \
> -	      PWR_CTRL2_DUR_STANDBY2_VAL | \
> -	      PWR_CTRL2_DUR_STANDBY1_VAL | \
> -	      PWR_CTRL2_CORE2_UP_RATIO	 | \
> -	      PWR_CTRL2_CORE1_UP_RATIO;
> -	__raw_writel(tmp, EXYNOS5_PWR_CTRL2);
> -}
> -
> -int __init exynos4_init_cpuidle(void)
> -{
> -	int cpu_id, ret;
> -	struct cpuidle_device *device;
> -
> -	if (soc_is_exynos5250())
> -		exynos5_core_down_clk();
> -
> -	ret =3D cpuidle_register_driver(&exynos4_idle_driver);
> -	if (ret) {
> -		printk(KERN_ERR "CPUidle failed to register driver\n");
> -		return ret;
> -	}
> -
> -	for_each_online_cpu(cpu_id) {
> -		device =3D &per_cpu(exynos4_cpuidle_device, cpu_id);
> -		device->cpu =3D cpu_id;
> -
> -		ret =3D cpuidle_register_device(device);
> -		if (ret) {
> -			printk(KERN_ERR "CPUidle register device failed\n");
> -			return ret;
> -		}
> -	}
> -
> -	return 0;
> -}
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 0d8bd55..37c6178 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -6,4 +6,7 @@ obj-y +=3D cpuidle.o driver.o governor.o sysfs.o gove=
rnors/
>  obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) +=3D coupled.o
> =20
>  obj-$(CONFIG_CPU_IDLE_CALXEDA) +=3D cpuidle-calxeda.o
> +ifeq ($(CONFIG_ARCH_EXYNOS),y)
> +	obj-y +=3D cpuidle-exynos.o
> +endif
>  obj-$(CONFIG_ARCH_KIRKWOOD) +=3D cpuidle-kirkwood.o
> diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuid=
le-exynos.c
> new file mode 100644
> index 0000000..1c592d2
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-exynos.c
> @@ -0,0 +1,92 @@
> +/*
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/io.h>
> +#include <linux/export.h>
> +#include <linux/time.h>
> +
> +#include <asm/proc-fns.h>
> +#include <asm/cpuidle.h>
> +#include <mach/regs-clock.h>
> +
> +static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device)=
;
> +
> +static struct cpuidle_driver exynos4_idle_driver =3D {
> +	.name			=3D "exynos4_idle",
> +	.owner			=3D THIS_MODULE,
> +	.states =3D {
> +		[0] =3D ARM_CPUIDLE_WFI_STATE,
> +	},
> +	.state_count =3D 1,
> +	.safe_state_index =3D 0,
> +};
> +
> +static void __init exynos5_core_down_clk(void)
> +{
> +	unsigned int tmp;
> +
> +	/*
> +	 * Enable arm clock down (in idle) and set arm divider
> +	 * ratios in WFI/WFE state.
> +	 */
> +	tmp =3D PWR_CTRL1_CORE2_DOWN_RATIO | \
> +	      PWR_CTRL1_CORE1_DOWN_RATIO | \
> +	      PWR_CTRL1_DIV2_DOWN_EN	 | \
> +	      PWR_CTRL1_DIV1_DOWN_EN	 | \
> +	      PWR_CTRL1_USE_CORE1_WFE	 | \
> +	      PWR_CTRL1_USE_CORE0_WFE	 | \
> +	      PWR_CTRL1_USE_CORE1_WFI	 | \
> +	      PWR_CTRL1_USE_CORE0_WFI;
> +	__raw_writel(tmp, EXYNOS5_PWR_CTRL1);
> +
> +	/*
> +	 * Enable arm clock up (on exiting idle). Set arm divider
> +	 * ratios when not in idle along with the standby duration
> +	 * ratios.
> +	 */
> +	tmp =3D PWR_CTRL2_DIV2_UP_EN	 | \
> +	      PWR_CTRL2_DIV1_UP_EN	 | \
> +	      PWR_CTRL2_DUR_STANDBY2_VAL | \
> +	      PWR_CTRL2_DUR_STANDBY1_VAL | \
> +	      PWR_CTRL2_CORE2_UP_RATIO	 | \
> +	      PWR_CTRL2_CORE1_UP_RATIO;
> +	__raw_writel(tmp, EXYNOS5_PWR_CTRL2);
> +}
> +
> +int __init exynos4_init_cpuidle(void)
> +{
> +	int cpu_id, ret;
> +	struct cpuidle_device *device;
> +
> +	if (soc_is_exynos5250())
> +		exynos5_core_down_clk();
> +
> +	ret =3D cpuidle_register_driver(&exynos4_idle_driver);
> +	if (ret) {
> +		printk(KERN_ERR "CPUidle failed to register driver\n");
> +		return ret;
> +	}
> +
> +	for_each_online_cpu(cpu_id) {
> +		device =3D &per_cpu(exynos4_cpuidle_device, cpu_id);
> +		device->cpu =3D cpu_id;
> +
> +		ret =3D cpuidle_register_device(device);
> +		if (ret) {
> +			printk(KERN_ERR "CPUidle register device failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
