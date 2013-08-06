From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC PATCH 3/3] cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver
Date: Tue, 06 Aug 2013 08:40:29 -0700
Message-ID: <87txj2g74i.fsf@linaro.org>
References: <1374750866-750-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1374750866-750-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:63111 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847Ab3HFPkd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2013 11:40:33 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so589786pbb.20
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2013 08:40:33 -0700 (PDT)
In-Reply-To: <1374750866-750-4-git-send-email-lorenzo.pieralisi@arm.com>
	(Lorenzo Pieralisi's message of "Thu, 25 Jul 2013 12:14:26 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Amit Kucheria <amit.kucheria@linaro.org>, Olof Johansson <olof@lixom.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jon Medhurst <tixy@linaro.org>

Hi Lorenzo,

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> The big.LITTLE architecture is composed of two clusters of cpus. One cluster
> contains less powerful but more energy efficient processors and the other
> cluster groups the powerful but energy-intensive cpus.
>
> The TC2 testchip implements two clusters of CPUs (A7 and A15 clusters in
> a big.LITTLE configuration) connected through a CCI interconnect that manages
> coherency of their respective L2 caches and intercluster distributed
> virtual memory messages (DVM).
>
> TC2 testchip integrates a power controller that manages cores resets, wake-up
> IRQs and cluster low-power states. Power states are managed at cluster
> level, which means that voltage is removed from a cluster iff all cores
> in a cluster are in a wfi state. Single cores can enter a reset state
> which is identical to wfi in terms of power consumption but simplifies the
> way cluster states are entered.
>
> This patch provides a multiple driver CPU idle implementation for TC2
> which paves the way for a generic big.LITTLE idle driver for all
> upcoming big.LITTLE based systems on chip.
>
> The driver relies on the MCPM infrastructure to coordinate and manage
> core power states; in particular MCPM allows to suspend specific cores
> and hides the CPUs coordination required to shut-down clusters of CPUs.
>
> Power down sequences for the respective clusters are implemented in the
> MCPM TC2 backend, with all code needed to clean caches and exit coherency.
>
> The multiple driver CPU idle infrastructure allows to define different
> C-states for big and little cores, determined at boot by checking the
> part id of the possible CPUs and initializing the respective logical
> masks in the big and little drivers.
>
> Current big.little systems are composed of A7 and A15 clusters, as
> implemented in TC2, but in the future that may change and the driver
> will have evolve to retrieve what is a 'big' cpu and what is a 'little'
> cpu in order to build the correct topology.
>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Some minor comments below, as well as some readability nits.

> +#include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +
> +#include <asm/cpu.h>

from checkpatch: WARNING: Use #include <linux/cpu.h> instead of <asm/cpu.h>

> +#include <asm/cputype.h>
> +#include <asm/cpuidle.h>

You already have <linux/cpuidle.h>, this shouldn't be necessary.

> +#include <asm/mcpm.h>
> +#include <asm/smp_plat.h>
> +#include <asm/suspend.h>

from checkpatch: WARNING: Use #include <linux/suspend.h> instead of <asm/suspend.h>

[...]

> +static struct cpuidle_driver bl_idle_little_driver = {
> +	.name = "little_idle",
> +	.owner = THIS_MODULE,
> +	.states[0] = ARM_CPUIDLE_WFI_STATE,
> +	.states[1] = {
> +		.enter			= bl_enter_powerdown,
> +		.exit_latency		= 1000,
> +		.target_residency	= 3500,

It would be good to have some comments about where these numbers come
from.  The changelog suggests this will be generic for all b.L
platforms, but I suspect these values to have various SoC specific
components to them.  Eventually, we'll probably need some way specify
these values, maybe from DT?

Same comment for the 'big' driver definition.

[...]

> +/*
> + * notrace prevents trace shims from getting inserted where they
> + * should not. Global jumps and ldrex/strex must not be inserted
> + * in power down sequences where caches and MMU may be turned off.
> + */
> +static int notrace bl_powerdown_finisher(unsigned long arg)
> +{
> +	/* MCPM works with HW CPU identifiers */
> +	unsigned int mpidr = read_cpuid_mpidr();
> +	unsigned int cluster = (mpidr >> 8) & 0xf;
> +	unsigned int cpu = mpidr & 0xf;
> +
> +	mcpm_set_entry_vector(cpu, cluster, cpu_resume);

add blank line

> +	/*
> +	 * Residency value passed to mcpm_cpu_suspend back-end
> +	 * has to be given clear semantics. Set to 0 as a
> +	 * temporary value.
> +	 */
> +	mcpm_cpu_suspend(0);

add blank line

> +	/* return value != 0 means failure */
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
> +	ret = cpu_suspend(0, bl_powerdown_finisher);

add blank line

> +	/* signals the MCPM core that CPU is out of low power state */
> +	mcpm_cpu_powered_up();
> +
> +	cpu_pm_exit();
> +
> +	getnstimeofday(&ts_postidle);
> +	ts_idle = timespec_sub(ts_postidle, ts_preidle);
> +
> +	dev->last_residency = ts_idle.tv_nsec / NSEC_PER_USEC +
> +					ts_idle.tv_sec * USEC_PER_SEC;
> +	local_irq_enable();

All of the residency caluclations and IRQ disable stuff is handled by
the CPUidle core now, so should be removed from here.

> +	return idx;
> +}
> +
> +static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int cpu_id)
> +{
> +	struct cpuinfo_arm *cpu_info;
> +	struct cpumask *cpumask;
> +	unsigned long cpuid;
> +	int cpu;
> +
> +	cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
> +	if (!cpumask)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_info = &per_cpu(cpu_data, cpu);
> +		cpuid = is_smp() ? cpu_info->cpuid : read_cpuid_id();
> +
> +		/* read cpu id part number */
> +		if ((cpuid & 0xFFF0) == cpu_id)
> +			cpumask_set_cpu(cpu, cpumask);
> +	}
> +
> +	drv->cpumask = cpumask;
> +
> +	return 0;
> +}
> +
> +static int __init bl_idle_init(void)
> +{
> +	int ret;

add blank line

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
> +	ret = bl_idle_driver_init(&bl_idle_little_driver,
> +				  ARM_CPU_PART_CORTEX_A7);
> +	if (ret)
> +		return ret;
> +
> +	ret = bl_idle_driver_init(&bl_idle_big_driver, ARM_CPU_PART_CORTEX_A15);
> +	if (ret)
> +		goto out_uninit_little;
> +
> +	ret = cpuidle_register(&bl_idle_little_driver, NULL);
> +	if (ret)
> +		goto out_uninit_big;
> +
> +	ret = cpuidle_register(&bl_idle_big_driver, NULL);
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

Kevin
