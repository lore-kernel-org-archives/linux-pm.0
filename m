From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 3/3] cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver
Date: Mon, 29 Jul 2013 16:00:33 +0200
Message-ID: <51F67581.5080207@linaro.org>
References: <1374750866-750-1-git-send-email-lorenzo.pieralisi@arm.com> <1374750866-750-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:63612 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab3G2OAf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2013 10:00:35 -0400
Received: by mail-bk0-f45.google.com with SMTP id je2so555bkc.4
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2013 07:00:33 -0700 (PDT)
In-Reply-To: <1374750866-750-4-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Olof Johansson <olof@lixom.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jon Medhurst <tixy@linaro.org>

On 07/25/2013 01:14 PM, Lorenzo Pieralisi wrote:
> The big.LITTLE architecture is composed of two clusters of cpus. One =
cluster
> contains less powerful but more energy efficient processors and the o=
ther
> cluster groups the powerful but energy-intensive cpus.
>=20
> The TC2 testchip implements two clusters of CPUs (A7 and A15 clusters=
 in
> a big.LITTLE configuration) connected through a CCI interconnect that=
 manages
> coherency of their respective L2 caches and intercluster distributed
> virtual memory messages (DVM).
>=20
> TC2 testchip integrates a power controller that manages cores resets,=
 wake-up
> IRQs and cluster low-power states. Power states are managed at cluste=
r
> level, which means that voltage is removed from a cluster iff all cor=
es
> in a cluster are in a wfi state. Single cores can enter a reset state
> which is identical to wfi in terms of power consumption but simplifie=
s the
> way cluster states are entered.
>=20
> This patch provides a multiple driver CPU idle implementation for TC2
> which paves the way for a generic big.LITTLE idle driver for all
> upcoming big.LITTLE based systems on chip.
>=20
> The driver relies on the MCPM infrastructure to coordinate and manage
> core power states; in particular MCPM allows to suspend specific core=
s
> and hides the CPUs coordination required to shut-down clusters of CPU=
s.
>=20
> Power down sequences for the respective clusters are implemented in t=
he
> MCPM TC2 backend, with all code needed to clean caches and exit coher=
ency.
>=20
> The multiple driver CPU idle infrastructure allows to define differen=
t
> C-states for big and little cores, determined at boot by checking the
> part id of the possible CPUs and initializing the respective logical
> masks in the big and little drivers.
>=20
> Current big.little systems are composed of A7 and A15 clusters, as
> implemented in TC2, but in the future that may change and the driver
> will have evolve to retrieve what is a 'big' cpu and what is a 'littl=
e'
> cpu in order to build the correct topology.
>=20
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  MAINTAINERS                          |   9 ++
>  drivers/cpuidle/Kconfig              |  10 ++
>  drivers/cpuidle/Makefile             |   1 +
>  drivers/cpuidle/cpuidle-big_little.c | 187 +++++++++++++++++++++++++=
++++++++++
>  4 files changed, 207 insertions(+)
>  create mode 100644 drivers/cpuidle/cpuidle-big_little.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf61e04..01f1b3d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2263,6 +2263,15 @@ F:	drivers/cpufreq/arm_big_little.h
>  F:	drivers/cpufreq/arm_big_little.c
>  F:	drivers/cpufreq/arm_big_little_dt.c
> =20
> +CPUIDLE DRIVER - ARM BIG LITTLE
> +M:      Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +M:      Daniel Lezcano <daniel.lezcano@linaro.org>
> +L:      linux-pm@vger.kernel.org
> +L:      linux-arm-kernel@lists.infradead.org
> +T:      git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git
> +S:      Maintained
> +F:      drivers/cpuidle/cpuidle-big_little.c
> +
>  CPUIDLE DRIVERS
>  M:	Rafael J. Wysocki <rjw@sisk.pl>
>  M:	Daniel Lezcano <daniel.lezcano@linaro.org>
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 0e2cd5c..0f86587 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -42,6 +42,16 @@ config CPU_IDLE_ZYNQ
>  	help
>  	  Select this to enable cpuidle on Xilinx Zynq processors.
> =20
> +config CPU_IDLE_BIG_LITTLE
> +	bool "Support for ARM big.LITTLE processors"
> +	depends on ARCH_VEXPRESS_TC2_PM
> +	select ARM_CPU_SUSPEND
> +	select CPU_IDLE_MULTIPLE_DRIVERS
> +	help
> +	  Select this option to enable CPU idle driver for big.LITTLE based
> +	  ARM systems. Driver manages CPUs coordination through MCPM and
> +	  define different C-states for little and big cores through the
> +	  multiple CPU idle drivers infrastructure.
>  endif
> =20
>  config ARCH_NEEDS_CPU_IDLE_COUPLED
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 8767a7b..3b6445c 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) +=3D couple=
d.o
>  obj-$(CONFIG_CPU_IDLE_CALXEDA) +=3D cpuidle-calxeda.o
>  obj-$(CONFIG_ARCH_KIRKWOOD) +=3D cpuidle-kirkwood.o
>  obj-$(CONFIG_CPU_IDLE_ZYNQ) +=3D cpuidle-zynq.o
> +obj-$(CONFIG_CPU_IDLE_BIG_LITTLE) +=3D cpuidle-big_little.o
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/c=
puidle-big_little.c
> new file mode 100644
> index 0000000..98cb375
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -0,0 +1,187 @@
> +/*
> + * Copyright (c) 2013 ARM/Linaro
> + *
> + * Authors: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *          Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + *          Nicolas Pitre <nicolas.pitre@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Maintainer: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + * Maintainer: Daniel Lezcano <daniel.lezcano@linaro.org>
> + */
> +#include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +
> +#include <asm/cpu.h>
> +#include <asm/cputype.h>
> +#include <asm/cpuidle.h>
> +#include <asm/mcpm.h>
> +#include <asm/smp_plat.h>
> +#include <asm/suspend.h>
> +
> +static int bl_enter_powerdown(struct cpuidle_device *dev,
> +			      struct cpuidle_driver *drv, int idx);
> +
> +static struct cpuidle_driver bl_idle_little_driver =3D {
> +	.name =3D "little_idle",
> +	.owner =3D THIS_MODULE,
> +	.states[0] =3D ARM_CPUIDLE_WFI_STATE,
> +	.states[1] =3D {
> +		.enter			=3D bl_enter_powerdown,
> +		.exit_latency		=3D 1000,
> +		.target_residency	=3D 3500,
> +		.flags			=3D CPUIDLE_FLAG_TIME_VALID |
> +					  CPUIDLE_FLAG_TIMER_STOP,
> +		.name			=3D "C1",
> +		.desc			=3D "ARM little-cluster power down",
> +	},
> +	.state_count =3D 2,
> +};
> +
> +static struct cpuidle_driver bl_idle_big_driver =3D {
> +	.name =3D "big_idle",
> +	.owner =3D THIS_MODULE,
> +	.states[0] =3D ARM_CPUIDLE_WFI_STATE,
> +	.states[1] =3D {
> +		.enter			=3D bl_enter_powerdown,
> +		.exit_latency		=3D 1000,
> +		.target_residency	=3D 3000,
> +		.flags			=3D CPUIDLE_FLAG_TIME_VALID |
> +					  CPUIDLE_FLAG_TIMER_STOP,
> +		.name			=3D "C1",
> +		.desc			=3D "ARM big-cluster power down",
> +	},
> +	.state_count =3D 2,
> +};
> +
> +/*
> + * notrace prevents trace shims from getting inserted where they
> + * should not. Global jumps and ldrex/strex must not be inserted
> + * in power down sequences where caches and MMU may be turned off.
> + */
> +static int notrace bl_powerdown_finisher(unsigned long arg)
> +{
> +	/* MCPM works with HW CPU identifiers */
> +	unsigned int mpidr =3D read_cpuid_mpidr();
> +	unsigned int cluster =3D (mpidr >> 8) & 0xf;
> +	unsigned int cpu =3D mpidr & 0xf;
> +
> +	mcpm_set_entry_vector(cpu, cluster, cpu_resume);
> +	/*
> +	 * Residency value passed to mcpm_cpu_suspend back-end
> +	 * has to be given clear semantics. Set to 0 as a
> +	 * temporary value.
> +	 */
> +	mcpm_cpu_suspend(0);
> +	/* return value !=3D 0 means failure */
> +	return 1;
> +}
> +
> +/**
> + * bl_enter_powerdown - Programs CPU to enter the specified state
> + * @dev: cpuidle device
> + * @drv: The target state to be programmed
> + * @idx: state index
> + *
> + * Called from the CPUidle framework to program the device to the
> + * specified target state selected by the governor.
> + */
> +static int bl_enter_powerdown(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int idx)
> +{
> +	struct timespec ts_preidle, ts_postidle, ts_idle;
> +	int ret;
> +
> +	/* Used to keep track of the total time in idle */
> +	getnstimeofday(&ts_preidle);
> +
> +	cpu_pm_enter();
> +
> +	ret =3D cpu_suspend(0, bl_powerdown_finisher);
> +	/* signals the MCPM core that CPU is out of low power state */
> +	mcpm_cpu_powered_up();
> +
> +	cpu_pm_exit();
> +
> +	getnstimeofday(&ts_postidle);
> +	ts_idle =3D timespec_sub(ts_postidle, ts_preidle);
> +
> +	dev->last_residency =3D ts_idle.tv_nsec / NSEC_PER_USEC +
> +					ts_idle.tv_sec * USEC_PER_SEC;
> +	local_irq_enable();

time computation and local irq enablement are handled by the cpuidle
framework.

> +	return idx;
> +}
> +
> +static int __init bl_idle_driver_init(struct cpuidle_driver *drv, in=
t cpu_id)
> +{
> +	struct cpuinfo_arm *cpu_info;
> +	struct cpumask *cpumask;
> +	unsigned long cpuid;
> +	int cpu;
> +
> +	cpumask =3D kzalloc(cpumask_size(), GFP_KERNEL);
> +	if (!cpumask)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_info =3D &per_cpu(cpu_data, cpu);
> +		cpuid =3D is_smp() ? cpu_info->cpuid : read_cpuid_id();
> +
> +		/* read cpu id part number */
> +		if ((cpuid & 0xFFF0) =3D=3D cpu_id)
> +			cpumask_set_cpu(cpu, cpumask);
> +	}
> +
> +	drv->cpumask =3D cpumask;
> +
> +	return 0;
> +}
> +
> +static int __init bl_idle_init(void)
> +{
> +	int ret;
> +	/*
> +	 * Initialize the driver just for a compliant set of machines
> +	 */
> +	if (!of_machine_is_compatible("arm,vexpress,v2p-ca15_a7"))
> +		return -ENODEV;
> +	/*
> +	 * For now the differentiation between little and big cores
> +	 * is based on the part number. A7 cores are considered little
> +	 * cores, A15 are considered big cores. This distinction may
> +	 * evolve in the future with a more generic matching approach.
> +	 */
> +	ret =3D bl_idle_driver_init(&bl_idle_little_driver,
> +				  ARM_CPU_PART_CORTEX_A7);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D bl_idle_driver_init(&bl_idle_big_driver, ARM_CPU_PART_CORTE=
X_A15);
> +	if (ret)
> +		goto out_uninit_little;
> +
> +	ret =3D cpuidle_register(&bl_idle_little_driver, NULL);
> +	if (ret)
> +		goto out_uninit_big;
> +
> +	ret =3D cpuidle_register(&bl_idle_big_driver, NULL);
> +	if (ret)
> +		goto out_unregister_little;
> +
> +	return 0;
> +
> +out_unregister_little:
> +	cpuidle_unregister(&bl_idle_little_driver);
> +out_uninit_big:
> +	kfree(bl_idle_big_driver.cpumask);
> +out_uninit_little:
> +	kfree(bl_idle_little_driver.cpumask);
> +
> +	return ret;
> +}
> +device_initcall(bl_idle_init);
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

