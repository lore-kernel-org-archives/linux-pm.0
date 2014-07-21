From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCHv2 11/17] cpuidle: mvebu: rename the driver from armada-370-xp
 to mvebu-v7
Date: Mon, 21 Jul 2014 11:59:14 +0200
Message-ID: <53CCE472.8020100@linaro.org>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com> <1404913221-17343-12-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:63335 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025AbaGUJ7Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 05:59:16 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so6208144wgh.8
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2014 02:59:15 -0700 (PDT)
In-Reply-To: <1404913221-17343-12-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On 07/09/2014 03:40 PM, Thomas Petazzoni wrote:
> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> This driver will be able to manage the cpuidle for more SoCs than jus=
t
> Armada 370 and XP. It will also support Armada 38x and potentially
> other SoC of the Marvell Armada EBU family. To take this into account=
,
> this patch renames the driver and its symbols.
>
> Note that in order to be bisectable, this commit needs to change both
> the cpuidle driver itself, and the place where the corresponding
> platform_device is registered.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm/mach-mvebu/pmsu.c                         |  2 +-
>   drivers/cpuidle/Kconfig.arm                        | 12 +++----
>   drivers/cpuidle/Makefile                           |  2 +-
>   ...{cpuidle-armada-370-xp.c =3D> cpuidle-mvebu-v7.c} | 40 +++++++++=
++-----------
>   4 files changed, 28 insertions(+), 28 deletions(-)
>   rename drivers/cpuidle/{cpuidle-armada-370-xp.c =3D> cpuidle-mvebu-=
v7.c} (58%)
>
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index 15e67bf..802edc8 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -76,7 +76,7 @@ extern void armada_370_xp_cpu_resume(void);
>   static void *mvebu_cpu_resume;
>
>   static struct platform_device mvebu_v7_cpuidle_device =3D {
> -	.name =3D "cpuidle-armada-370-xp",
> +	.name =3D "cpuidle-mvebu-v7",
>   };
>
>   static struct of_device_id of_pmsu_table[] =3D {
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> index b6d69e8..a563427 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -1,12 +1,6 @@
>   #
>   # ARM CPU Idle drivers
>   #
> -config ARM_ARMADA_370_XP_CPUIDLE
> -	bool "CPU Idle Driver for Armada 370/XP family processors"
> -	depends on ARCH_MVEBU
> -	help
> -	  Select this to enable cpuidle on Armada 370/XP processors.
> -
>   config ARM_BIG_LITTLE_CPUIDLE
>   	bool "Support for ARM big.LITTLE processors"
>   	depends on ARCH_VEXPRESS_TC2_PM
> @@ -61,3 +55,9 @@ config ARM_EXYNOS_CPUIDLE
>   	depends on ARCH_EXYNOS
>   	help
>   	  Select this to enable cpuidle for Exynos processors
> +
> +config ARM_MVEBU_V7_CPUIDLE
> +	bool "CPU Idle Driver for mvebu v7 family processors"
> +	depends on ARCH_MVEBU
> +	help
> +	  Select this to enable cpuidle on Armada 370, 38x and XP processor=
s.
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index d8bb1ff..11edb31 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -7,7 +7,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) +=3D couple=
d.o
>
>   ###################################################################=
###############
>   # ARM SoC drivers
> -obj-$(CONFIG_ARM_ARMADA_370_XP_CPUIDLE) +=3D cpuidle-armada-370-xp.o
> +obj-$(CONFIG_ARM_MVEBU_V7_CPUIDLE) +=3D cpuidle-mvebu-v7.o
>   obj-$(CONFIG_ARM_BIG_LITTLE_CPUIDLE)	+=3D cpuidle-big_little.o
>   obj-$(CONFIG_ARM_CLPS711X_CPUIDLE)	+=3D cpuidle-clps711x.o
>   obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+=3D cpuidle-calxeda.o
> diff --git a/drivers/cpuidle/cpuidle-armada-370-xp.c b/drivers/cpuidl=
e/cpuidle-mvebu-v7.c
> similarity index 58%
> rename from drivers/cpuidle/cpuidle-armada-370-xp.c
> rename to drivers/cpuidle/cpuidle-mvebu-v7.c
> index 28587d0..302596e 100644
> --- a/drivers/cpuidle/cpuidle-armada-370-xp.c
> +++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
> @@ -21,12 +21,12 @@
>   #include <linux/platform_device.h>
>   #include <asm/cpuidle.h>
>
> -#define ARMADA_370_XP_MAX_STATES	3
> -#define ARMADA_370_XP_FLAG_DEEP_IDLE	0x10000
> +#define MVEBU_V7_MAX_STATES	3
> +#define MVEBU_V7_FLAG_DEEP_IDLE	0x10000
>
> -static int (*armada_370_xp_cpu_suspend)(int);
> +static int (*mvebu_v7_cpu_suspend)(int);
>
> -static int armada_370_xp_enter_idle(struct cpuidle_device *dev,
> +static int mvebu_v7_enter_idle(struct cpuidle_device *dev,
>   				struct cpuidle_driver *drv,
>   				int index)
>   {
> @@ -34,10 +34,10 @@ static int armada_370_xp_enter_idle(struct cpuidl=
e_device *dev,
>   	bool deepidle =3D false;
>   	cpu_pm_enter();
>
> -	if (drv->states[index].flags & ARMADA_370_XP_FLAG_DEEP_IDLE)
> +	if (drv->states[index].flags & MVEBU_V7_FLAG_DEEP_IDLE)
>   		deepidle =3D true;
>
> -	ret =3D armada_370_xp_cpu_suspend(deepidle);
> +	ret =3D mvebu_v7_cpu_suspend(deepidle);
>   	if (ret)
>   		return ret;
>
> @@ -46,11 +46,11 @@ static int armada_370_xp_enter_idle(struct cpuidl=
e_device *dev,
>   	return index;
>   }
>
> -static struct cpuidle_driver armada_370_xp_idle_driver =3D {
> -	.name			=3D "armada_370_xp_idle",
> +static struct cpuidle_driver mvebu_v7_idle_driver =3D {
> +	.name			=3D "mvebu_v7_idle",
>   	.states[0]		=3D ARM_CPUIDLE_WFI_STATE,
>   	.states[1]		=3D {
> -		.enter			=3D armada_370_xp_enter_idle,
> +		.enter			=3D mvebu_v7_enter_idle,
>   		.exit_latency		=3D 10,
>   		.power_usage		=3D 50,
>   		.target_residency	=3D 100,
> @@ -59,35 +59,35 @@ static struct cpuidle_driver armada_370_xp_idle_d=
river =3D {
>   		.desc			=3D "CPU power down",
>   	},
>   	.states[2]		=3D {
> -		.enter			=3D armada_370_xp_enter_idle,
> +		.enter			=3D mvebu_v7_enter_idle,
>   		.exit_latency		=3D 100,
>   		.power_usage		=3D 5,
>   		.target_residency	=3D 1000,
>   		.flags			=3D CPUIDLE_FLAG_TIME_VALID |
> -						ARMADA_370_XP_FLAG_DEEP_IDLE,
> +						MVEBU_V7_FLAG_DEEP_IDLE,
>   		.name			=3D "MV CPU DEEP IDLE",
>   		.desc			=3D "CPU and L2 Fabric power down",
>   	},
> -	.state_count =3D ARMADA_370_XP_MAX_STATES,
> +	.state_count =3D MVEBU_V7_MAX_STATES,
>   };
>
> -static int armada_370_xp_cpuidle_probe(struct platform_device *pdev)
> +static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
>   {
>
> -	armada_370_xp_cpu_suspend =3D (void *)(pdev->dev.platform_data);
> -	return cpuidle_register(&armada_370_xp_idle_driver, NULL);
> +	mvebu_v7_cpu_suspend =3D (void *)(pdev->dev.platform_data);
> +	return cpuidle_register(&mvebu_v7_idle_driver, NULL);
>   }
>
> -static struct platform_driver armada_370_xp_cpuidle_plat_driver =3D =
{
> +static struct platform_driver mvebu_v7_cpuidle_plat_driver =3D {
>   	.driver =3D {
> -		.name =3D "cpuidle-armada-370-xp",
> +		.name =3D "cpuidle-mvebu-v7",
>   		.owner =3D THIS_MODULE,
>   	},
> -	.probe =3D armada_370_xp_cpuidle_probe,
> +	.probe =3D mvebu_v7_cpuidle_probe,
>   };
>
> -module_platform_driver(armada_370_xp_cpuidle_plat_driver);
> +module_platform_driver(mvebu_v7_cpuidle_plat_driver);
>
>   MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>=
");
> -MODULE_DESCRIPTION("Armada 370/XP cpu idle driver");
> +MODULE_DESCRIPTION("Marvel EBU v7 cpuidle driver");
>   MODULE_LICENSE("GPL");
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

