From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable
 of handling multiple SoCs
Date: Mon, 21 Jul 2014 12:59:33 +0200
Message-ID: <53CCF295.6030907@linaro.org>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com> <1404913221-17343-13-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:59542 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754350AbaGUK7w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 06:59:52 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so4032072wiw.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2014 03:59:50 -0700 (PDT)
In-Reply-To: <1404913221-17343-13-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On 07/09/2014 03:40 PM, Thomas Petazzoni wrote:
> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> In order to prepare the add of new SoCs supports for this cpuidle
> driver, this patch extends the platform_data understood by the
> cpuidle-mvebu-v7 driver to contain a "type" identifying which specifi=
c
> SoC the cpuidle driver is being probed for. It will be used by the
> cpuidle driver to know the list of states for the current SoC.

It makes more sense to use/implement a 'soc_is_xxx' macro or=20
'of_machine_is_compatible', like the other cpuidle drivers, no ?

Is there a good reason to implement a new way to check the board ?

It isn't possible to do:

if (of_machine_is_compatible("marvell,armada-370-xp-pmsu"))
	cpuidle_register(&armadaxp_cpuidle_driver, NULL);

?

That will prevent the creation of the new single-declaration header fil=
e.
=09


> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>   arch/arm/mach-mvebu/pmsu.c         | 20 +++++++++++++-------
>   drivers/cpuidle/cpuidle-mvebu-v7.c | 32 ++++++++++++++++++++-------=
-----
>   include/linux/mvebu-v7-cpuidle.h   | 26 ++++++++++++++++++++++++++
>   3 files changed, 59 insertions(+), 19 deletions(-)
>   create mode 100644 include/linux/mvebu-v7-cpuidle.h
>
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index 802edc8..0a24073 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -19,10 +19,12 @@
>   #define pr_fmt(fmt) "mvebu-pmsu: " fmt
>
>   #include <linux/cpu_pm.h>
> +#include <linux/cpuidle.h>
>   #include <linux/init.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
>   #include <linux/mbus.h>
> +#include <linux/mvebu-v7-cpuidle.h>
>   #include <linux/of_address.h>
>   #include <linux/platform_device.h>
>   #include <linux/resource.h>
> @@ -75,10 +77,6 @@ extern void armada_370_xp_cpu_resume(void);
>
>   static void *mvebu_cpu_resume;
>
> -static struct platform_device mvebu_v7_cpuidle_device =3D {
> -	.name =3D "cpuidle-mvebu-v7",
> -};
> -
>   static struct of_device_id of_pmsu_table[] =3D {
>   	{ .compatible =3D "marvell,armada-370-pmsu", },
>   	{ .compatible =3D "marvell,armada-370-xp-pmsu", },
> @@ -325,17 +323,25 @@ static struct notifier_block mvebu_v7_cpu_pm_no=
tifier =3D {
>   	.notifier_call =3D mvebu_v7_cpu_pm_notify,
>   };
>
> -static int __init armada_xp_cpuidle_init(void)
> +static struct mvebu_v7_cpuidle armada_xp_cpuidle =3D {
> +	.type =3D CPUIDLE_ARMADA_XP,
> +	.cpu_suspend =3D armada_370_xp_cpu_suspend,
> +};
> +
> +static struct platform_device mvebu_v7_cpuidle_device =3D {
> +	.name =3D "cpuidle-mvebu-v7",
> +};
> +
> +static __init int armada_xp_cpuidle_init(void)
>   {
>   	struct device_node *np;
> -
>   	np =3D of_find_compatible_node(NULL, NULL, "marvell,coherency-fabr=
ic");
>   	if (!np)
>   		return -ENODEV;
>   	of_node_put(np);
>
>   	mvebu_cpu_resume =3D armada_370_xp_cpu_resume;
> -	mvebu_v7_cpuidle_device.dev.platform_data =3D armada_370_xp_cpu_sus=
pend;
> +	mvebu_v7_cpuidle_device.dev.platform_data =3D &armada_xp_cpuidle;
>
>   	return 0;
>   }
> diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpu=
idle-mvebu-v7.c
> index 302596e..82c545bb 100644
> --- a/drivers/cpuidle/cpuidle-mvebu-v7.c
> +++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
> @@ -16,15 +16,15 @@
>   #include <linux/cpu_pm.h>
>   #include <linux/cpuidle.h>
>   #include <linux/module.h>
> +#include <linux/mvebu-v7-cpuidle.h>
>   #include <linux/of.h>
>   #include <linux/suspend.h>
>   #include <linux/platform_device.h>
>   #include <asm/cpuidle.h>
>
> -#define MVEBU_V7_MAX_STATES	3
>   #define MVEBU_V7_FLAG_DEEP_IDLE	0x10000
>
> -static int (*mvebu_v7_cpu_suspend)(int);
> +static struct mvebu_v7_cpuidle *pcpuidle;
>
>   static int mvebu_v7_enter_idle(struct cpuidle_device *dev,
>   				struct cpuidle_driver *drv,
> @@ -32,12 +32,13 @@ static int mvebu_v7_enter_idle(struct cpuidle_dev=
ice *dev,
>   {
>   	int ret;
>   	bool deepidle =3D false;
> +
>   	cpu_pm_enter();
>
>   	if (drv->states[index].flags & MVEBU_V7_FLAG_DEEP_IDLE)
>   		deepidle =3D true;
>
> -	ret =3D mvebu_v7_cpu_suspend(deepidle);
> +	ret =3D pcpuidle->cpu_suspend(deepidle);
>   	if (ret)
>   		return ret;
>
> @@ -46,8 +47,8 @@ static int mvebu_v7_enter_idle(struct cpuidle_devic=
e *dev,
>   	return index;
>   }
>
> -static struct cpuidle_driver mvebu_v7_idle_driver =3D {
> -	.name			=3D "mvebu_v7_idle",
> +static struct cpuidle_driver armadaxp_cpuidle_driver =3D {
> +	.name			=3D "armada_xp_idle",
>   	.states[0]		=3D ARM_CPUIDLE_WFI_STATE,
>   	.states[1]		=3D {
>   		.enter			=3D mvebu_v7_enter_idle,
> @@ -55,7 +56,7 @@ static struct cpuidle_driver mvebu_v7_idle_driver =3D=
 {
>   		.power_usage		=3D 50,
>   		.target_residency	=3D 100,
>   		.flags			=3D CPUIDLE_FLAG_TIME_VALID,
> -		.name			=3D "MV CPU IDLE",
> +		.name			=3D "Idle",
>   		.desc			=3D "CPU power down",
>   	},
>   	.states[2]		=3D {
> @@ -63,19 +64,26 @@ static struct cpuidle_driver mvebu_v7_idle_driver=
 =3D {
>   		.exit_latency		=3D 100,
>   		.power_usage		=3D 5,
>   		.target_residency	=3D 1000,
> -		.flags			=3D CPUIDLE_FLAG_TIME_VALID |
> -						MVEBU_V7_FLAG_DEEP_IDLE,
> -		.name			=3D "MV CPU DEEP IDLE",
> +		.flags			=3D (CPUIDLE_FLAG_TIME_VALID |
> +					   MVEBU_V7_FLAG_DEEP_IDLE),
> +		.name			=3D "Deep idle",
>   		.desc			=3D "CPU and L2 Fabric power down",
>   	},
> -	.state_count =3D MVEBU_V7_MAX_STATES,
> +	.state_count =3D 3,
>   };
>
>   static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
>   {
> +	struct cpuidle_driver *drv;
> +
> +	pcpuidle =3D pdev->dev.platform_data;
> +
> +	if (pcpuidle->type =3D=3D CPUIDLE_ARMADA_XP)
> +		drv =3D &armadaxp_cpuidle_driver;
> +	else
> +		return -EINVAL;
>
> -	mvebu_v7_cpu_suspend =3D (void *)(pdev->dev.platform_data);
> -	return cpuidle_register(&mvebu_v7_idle_driver, NULL);
> +	return cpuidle_register(drv, NULL);
>   }
>
>   static struct platform_driver mvebu_v7_cpuidle_plat_driver =3D {
> diff --git a/include/linux/mvebu-v7-cpuidle.h b/include/linux/mvebu-v=
7-cpuidle.h
> new file mode 100644
> index 0000000..00fde86
> --- /dev/null
> +++ b/include/linux/mvebu-v7-cpuidle.h
> @@ -0,0 +1,26 @@
> +/*
> + * Marvell EBU cpuidle defintion
> + *
> + * Copyright (C) 2014 Marvell
> + *
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + */
> +
> +#ifndef __LINUX_MVEBU_V7_CPUIDLE_H__
> +#define __LINUX_MVEBU_V7_CPUIDLE_H__
> +
> +enum mvebu_v7_cpuidle_types {
> +	CPUIDLE_ARMADA_XP,
> +};
> +
> +struct mvebu_v7_cpuidle {
> +	int type;
> +	int (*cpu_suspend)(unsigned long deepidle);
> +};
> +
> +#endif
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

