From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: add freescale e500 family porcessors idle support
Date: Tue, 30 Jul 2013 11:51:29 +0200
Message-ID: <51F78CA1.40605@linaro.org>
References: <1375167603-16722-1-git-send-email-dongsheng.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:53506 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755762Ab3G3Jv3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2013 05:51:29 -0400
Received: by mail-we0-f179.google.com with SMTP id t57so4961226wes.10
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2013 02:51:28 -0700 (PDT)
In-Reply-To: <1375167603-16722-1-git-send-email-dongsheng.wang@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Cc: scottwood@freescale.com, rjw@sisk.pl, benh@kernel.crashing.org, leoli@freescale.com, chenhui.zhao@freescale.com, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 07/30/2013 09:00 AM, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> Add cpuidle support for e500 family, using cpuidle framework to
> manage various low power modes. The new implementation will remain
> compatible with original idle method.
>=20
> Initially, this supports PW10, and subsequent patches will support
> PW20/DOZE/NAP.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> This patch keep using cpuidle_register_device(), because we need to s=
upport cpu
> hotplug. I will fix "device" issue in this driver, after
> Deepthi Dharwar <deepthi@linux.vnet.ibm.com> add a hotplug handler in=
to cpuidle
> freamwork.
>=20
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/includ=
e/asm/machdep.h
> index 8b48090..cbdbe25 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -271,6 +271,16 @@ extern void power7_idle(void);
>  extern void ppc6xx_idle(void);
>  extern void book3e_idle(void);
> =20
> +/* Wait for Interrupt */
> +static inline void fsl_cpuidle_wait(void)
> +{
> +#ifdef CONFIG_PPC64
> +	book3e_idle();
> +#else
> +	e500_idle();
> +#endif
> +}
> +
>  /*
>   * ppc_md contains a copy of the machine description structure for t=
he
>   * current platform. machine_id contains the initial address where t=
he
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index b3fb81d..7ed114b 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -35,6 +35,11 @@ depends on ARM
>  source "drivers/cpuidle/Kconfig.arm"
>  endmenu
> =20
> +menu "PowerPC CPU Idle Drivers"
> +depends on PPC32 || PPC64
> +source "drivers/cpuidle/Kconfig.powerpc"
> +endmenu
> +
>  endif
> =20
>  config ARCH_NEEDS_CPU_IDLE_COUPLED
> diff --git a/drivers/cpuidle/Kconfig.powerpc b/drivers/cpuidle/Kconfi=
g.powerpc
> new file mode 100644
> index 0000000..9f3f5ef
> --- /dev/null
> +++ b/drivers/cpuidle/Kconfig.powerpc
> @@ -0,0 +1,9 @@
> +#
> +# PowerPC CPU Idle drivers
> +#
> +
> +config PPC_E500_CPUIDLE
> +	bool "CPU Idle Driver for E500 family processors"
> +	depends on FSL_SOC_BOOKE
> +	help
> +	  Select this to enable cpuidle on e500 family processors.
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 0b9d200..0dde3db 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -11,3 +11,7 @@ obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+=3D cpuidle-cal=
xeda.o
>  obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+=3D cpuidle-kirkwood.o
>  obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+=3D cpuidle-zynq.o
>  obj-$(CONFIG_ARM_U8500_CPUIDLE)         +=3D cpuidle-ux500.o
> +
> +####################################################################=
##############
> +# PowerPC platform drivers
> +obj-$(CONFIG_PPC_E500_CPUIDLE)		+=3D cpuidle-e500.o
> diff --git a/drivers/cpuidle/cpuidle-e500.c b/drivers/cpuidle/cpuidle=
-e500.c
> new file mode 100644
> index 0000000..1919cea
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-e500.c
> @@ -0,0 +1,222 @@
> +/*
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * CPU Idle driver for Freescale PowerPC e500 family processors.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Author: Wang Dongsheng <dongsheng.wang@freescale.com>
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/cpuidle.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +
> +#include <asm/machdep.h>
> +
> +static struct cpuidle_driver e500_idle_driver =3D {
> +	.name =3D "e500_idle",
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static struct cpuidle_device __percpu *e500_cpuidle_devices;
> +
> +static void e500_cpuidle(void)
> +{
> +	/*
> +	 * This would call on the cpuidle framework, and the back-end
> +	 * driver to go to idle states.
> +	 */
> +	if (cpuidle_idle_call()) {
> +		/*
> +		 * On error, execute default handler
> +		 * to go into low thread priority and possibly
> +		 * low power mode.
> +		 */
> +		HMT_low();
> +		HMT_very_low();
> +	}
> +}

Nope, this is not the place to add such function.

> +static int pw10_enter(struct cpuidle_device *dev,
> +			struct cpuidle_driver *drv, int index)
> +{
> +	fsl_cpuidle_wait();
> +	return index;
> +}
> +
> +static struct cpuidle_state fsl_pw_idle_states[] =3D {
> +	{
> +		.name =3D "pw10",
> +		.desc =3D "pw10",
> +		.flags =3D CPUIDLE_FLAG_TIME_VALID,
> +		.exit_latency =3D 0,
> +		.target_residency =3D 0,
> +		.enter =3D &pw10_enter
> +	},
> +};
> +
> +static int cpu_hotplug_notify(struct notifier_block *n,
> +			unsigned long action, void *hcpu)
> +{
> +	unsigned long hotcpu =3D (unsigned long)hcpu;
> +	struct cpuidle_device *dev =3D
> +			per_cpu_ptr(e500_cpuidle_devices, hotcpu);
> +
> +	if (dev && cpuidle_get_driver()) {
> +		switch (action) {
> +		case CPU_ONLINE:
> +		case CPU_ONLINE_FROZEN:
> +			cpuidle_pause_and_lock();
> +			cpuidle_enable_device(dev);
> +			cpuidle_resume_and_unlock();
> +			break;
> +
> +		case CPU_DEAD:
> +		case CPU_DEAD_FROZEN:
> +			cpuidle_pause_and_lock();
> +			cpuidle_disable_device(dev);
> +			cpuidle_resume_and_unlock();
> +			break;
> +
> +		default:
> +			return NOTIFY_DONE;
> +		}
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block cpu_hotplug_notifier =3D {
> +	.notifier_call =3D cpu_hotplug_notify,
> +};

This should go to the cpuidle framework.

> +
> +/*
> + * e500_idle_devices_init(void)
> + * allocate, initialize and register cpuidle device
> + */
> +static int e500_idle_devices_init(void)
> +{
> +	int i;
> +	struct cpuidle_driver *drv =3D &e500_idle_driver;
> +	struct cpuidle_device *dev;
> +
> +	e500_cpuidle_devices =3D alloc_percpu(struct cpuidle_device);
> +	if (!e500_cpuidle_devices)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(i) {
> +		dev =3D per_cpu_ptr(e500_cpuidle_devices, i);
> +		dev->state_count =3D drv->state_count;
> +		dev->cpu =3D i;
> +
> +		if (cpuidle_register_device(dev)) {
> +			pr_err("cpuidle_register_device %d failed!\n", i);
> +			return -EIO;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * e500_idle_devices_uninit(void)
> + * unregister cpuidle devices and de-allocate memory
> + */
> +static void e500_idle_devices_uninit(void)
> +{
> +	int i;
> +	struct cpuidle_device *dev;
> +
> +	if (!e500_cpuidle_devices)
> +		return;
> +
> +	for_each_possible_cpu(i) {
> +		dev =3D per_cpu_ptr(e500_cpuidle_devices, i);
> +		cpuidle_unregister_device(dev);
> +	}
> +
> +	free_percpu(e500_cpuidle_devices);
> +}
> +
> +static void e500_cpuidle_driver_init(unsigned int max_idle_state,
> +		struct cpuidle_state *cpuidle_state_table)
> +{
> +	int idle_state;
> +	struct cpuidle_driver *drv =3D &e500_idle_driver;
> +
> +	drv->state_count =3D 0;
> +
> +	for (idle_state =3D 0; idle_state < max_idle_state; ++idle_state) {
> +		if (!cpuidle_state_table[idle_state].enter)
> +			break;
> +
> +		drv->states[drv->state_count] =3D cpuidle_state_table[idle_state];
> +		drv->state_count++;
> +	}
> +}
> +
> +static int cpu_is_feature(unsigned long feature)
> +{
> +	return (cur_cpu_spec->cpu_features =3D=3D feature);
> +}
> +
> +static int __init e500_idle_init(void)
> +{
> +	struct cpuidle_state *cpuidle_state_table =3D NULL;
> +	struct cpuidle_driver *drv =3D &e500_idle_driver;
> +	int err;
> +	unsigned int max_idle_state =3D 0;
> +
> +	if (cpuidle_disable !=3D IDLE_NO_OVERRIDE)
> +		return -ENODEV;
> +
> +	if (cpu_is_feature(CPU_FTRS_E500MC) || cpu_is_feature(CPU_FTRS_E550=
0) ||
> +			cpu_is_feature(CPU_FTRS_E6500)) {
> +		cpuidle_state_table =3D fsl_pw_idle_states;
> +		max_idle_state =3D ARRAY_SIZE(fsl_pw_idle_states);
> +	}
> +
> +	if (!cpuidle_state_table || !max_idle_state)
> +		return -EPERM;

Please use different drivers for each and then register the right one
instead of state count convolutions.

Then use cpuidle_register(&mydriver, NULL) and get rid of the duplicate
initialization routine.


> +	e500_cpuidle_driver_init(max_idle_state, cpuidle_state_table);
> +
> +	if (!drv->state_count)
> +		return -EPERM;
> +
> +	err =3D cpuidle_register_driver(drv);
> +	if (err) {
> +		pr_err("Register e500 family cpuidle driver failed.\n");
> +
> +		return err;
> +	}
> +
> +	err =3D e500_idle_devices_init();
> +	if (err)
> +		goto out;
> +
> +	err =3D register_cpu_notifier(&cpu_hotplug_notifier);
> +	if (err)
> +		goto out;
> +
> +	ppc_md.power_save =3D e500_cpuidle;

This is not the place.

> +
> +	pr_info("e500_idle_driver registered.\n");
> +
> +	return 0;
> +
> +out:
> +	e500_idle_devices_uninit();
> +	cpuidle_unregister_driver(drv);
> +
> +	pr_err("Register e500 family cpuidle driver failed.\n");
> +
> +	return err;
> +}
> +device_initcall(e500_idle_init);
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

