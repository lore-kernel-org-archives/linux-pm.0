From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 3/3] cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver
Date: Tue, 6 Aug 2013 17:21:00 +0100
Message-ID: <20130806162059.GA28176@e102568-lin.cambridge.arm.com>
References: <1374750866-750-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1374750866-750-4-git-send-email-lorenzo.pieralisi@arm.com>
 <87txj2g74i.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33791 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863Ab3HFQVH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2013 12:21:07 -0400
In-Reply-To: <87txj2g74i.fsf@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Amit Kucheria <amit.kucheria@linaro.org>, Olof Johansson <olof@lixom.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jon Medhurst <tixy@linaro.org>

Hi Kevin,

thanks for the review.

On Tue, Aug 06, 2013 at 04:40:29PM +0100, Kevin Hilman wrote:
> Hi Lorenzo,
> 
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> 
> > The big.LITTLE architecture is composed of two clusters of cpus. One cluster
> > contains less powerful but more energy efficient processors and the other
> > cluster groups the powerful but energy-intensive cpus.
> >
> > The TC2 testchip implements two clusters of CPUs (A7 and A15 clusters in
> > a big.LITTLE configuration) connected through a CCI interconnect that manages
> > coherency of their respective L2 caches and intercluster distributed
> > virtual memory messages (DVM).
> >
> > TC2 testchip integrates a power controller that manages cores resets, wake-up
> > IRQs and cluster low-power states. Power states are managed at cluster
> > level, which means that voltage is removed from a cluster iff all cores
> > in a cluster are in a wfi state. Single cores can enter a reset state
> > which is identical to wfi in terms of power consumption but simplifies the
> > way cluster states are entered.
> >
> > This patch provides a multiple driver CPU idle implementation for TC2
> > which paves the way for a generic big.LITTLE idle driver for all
> > upcoming big.LITTLE based systems on chip.
> >
> > The driver relies on the MCPM infrastructure to coordinate and manage
> > core power states; in particular MCPM allows to suspend specific cores
> > and hides the CPUs coordination required to shut-down clusters of CPUs.
> >
> > Power down sequences for the respective clusters are implemented in the
> > MCPM TC2 backend, with all code needed to clean caches and exit coherency.
> >
> > The multiple driver CPU idle infrastructure allows to define different
> > C-states for big and little cores, determined at boot by checking the
> > part id of the possible CPUs and initializing the respective logical
> > masks in the big and little drivers.
> >
> > Current big.little systems are composed of A7 and A15 clusters, as
> > implemented in TC2, but in the future that may change and the driver
> > will have evolve to retrieve what is a 'big' cpu and what is a 'little'
> > cpu in order to build the correct topology.
> >
> > Cc: Kevin Hilman <khilman@linaro.org>
> > Cc: Amit Kucheria <amit.kucheria@linaro.org>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Some minor comments below, as well as some readability nits.
> 
> > +#include <linux/cpuidle.h>
> > +#include <linux/cpu_pm.h>
> > +#include <linux/slab.h>
> > +#include <linux/of.h>
> > +
> > +#include <asm/cpu.h>
> 
> from checkpatch: WARNING: Use #include <linux/cpu.h> instead of <asm/cpu.h>

It does not work, I am aware of the warning but there is not much I can do
since the former does not include the latter. Actually, thanks for
raising the point since this is a question I would like answered.

> > +#include <asm/cputype.h>
> > +#include <asm/cpuidle.h>
> 
> You already have <linux/cpuidle.h>, this shouldn't be necessary.

Ditto. It is, since it defines the default idle state for ARM :-(

> > +#include <asm/mcpm.h>
> > +#include <asm/smp_plat.h>
> > +#include <asm/suspend.h>
> 
> from checkpatch: WARNING: Use #include <linux/suspend.h> instead of <asm/suspend.h>

Ditto, I can't use <linux/[..]> here.

> [...]
> 
> > +static struct cpuidle_driver bl_idle_little_driver = {
> > +	.name = "little_idle",
> > +	.owner = THIS_MODULE,
> > +	.states[0] = ARM_CPUIDLE_WFI_STATE,
> > +	.states[1] = {
> > +		.enter			= bl_enter_powerdown,
> > +		.exit_latency		= 1000,
> > +		.target_residency	= 3500,
> 
> It would be good to have some comments about where these numbers come
> from.  The changelog suggests this will be generic for all b.L
> platforms, but I suspect these values to have various SoC specific
> components to them.  Eventually, we'll probably need some way specify
> these values, maybe from DT?

I tried to explain this on the cover letter, and there is still the
age-old issue related to the current menu governor and its usage of
per-CPU next events (these residencies are "cluster" values, even though
the menu governor makes decisions on per CPU basis).

I will comment on that and I have a series of patches to explain the
issues I am facing with the current CPU idle framework and to provide
some optimizations for TC2.

Certainly those values are coming from benchmarks and vary _widely_
depending on use cases, but I will explain where they come from.

> Same comment for the 'big' driver definition.

Ok.

> 
> [...]
> 
> > +/*
> > + * notrace prevents trace shims from getting inserted where they
> > + * should not. Global jumps and ldrex/strex must not be inserted
> > + * in power down sequences where caches and MMU may be turned off.
> > + */
> > +static int notrace bl_powerdown_finisher(unsigned long arg)
> > +{
> > +	/* MCPM works with HW CPU identifiers */
> > +	unsigned int mpidr = read_cpuid_mpidr();
> > +	unsigned int cluster = (mpidr >> 8) & 0xf;
> > +	unsigned int cpu = mpidr & 0xf;
> > +
> > +	mcpm_set_entry_vector(cpu, cluster, cpu_resume);
> 
> add blank line

Done.

> > +	/*
> > +	 * Residency value passed to mcpm_cpu_suspend back-end
> > +	 * has to be given clear semantics. Set to 0 as a
> > +	 * temporary value.
> > +	 */
> > +	mcpm_cpu_suspend(0);
> 
> add blank line

Done.

> > +	/* return value != 0 means failure */
> > +	return 1;
> > +}
> > +
> > +/**
> > + * bl_enter_powerdown - Programs CPU to enter the specified state
> > + * @dev: cpuidle device
> > + * @drv: The target state to be programmed
> > + * @idx: state index
> > + *
> > + * Called from the CPUidle framework to program the device to the
> > + * specified target state selected by the governor.
> > + */
> > +static int bl_enter_powerdown(struct cpuidle_device *dev,
> > +				struct cpuidle_driver *drv, int idx)
> > +{
> > +	struct timespec ts_preidle, ts_postidle, ts_idle;
> > +	int ret;
> > +
> > +	/* Used to keep track of the total time in idle */
> > +	getnstimeofday(&ts_preidle);
> > +
> > +	cpu_pm_enter();
> > +
> > +	ret = cpu_suspend(0, bl_powerdown_finisher);
> 
> add blank line

Done.

> > +	/* signals the MCPM core that CPU is out of low power state */
> > +	mcpm_cpu_powered_up();
> > +
> > +	cpu_pm_exit();
> > +
> > +	getnstimeofday(&ts_postidle);
> > +	ts_idle = timespec_sub(ts_postidle, ts_preidle);
> > +
> > +	dev->last_residency = ts_idle.tv_nsec / NSEC_PER_USEC +
> > +					ts_idle.tv_sec * USEC_PER_SEC;
> > +	local_irq_enable();
> 
> All of the residency caluclations and IRQ disable stuff is handled by
> the CPUidle core now, so should be removed from here.

Done, already on LAKML, v2 of this series.

> > +	return idx;
> > +}
> > +
> > +static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int cpu_id)
> > +{
> > +	struct cpuinfo_arm *cpu_info;
> > +	struct cpumask *cpumask;
> > +	unsigned long cpuid;
> > +	int cpu;
> > +
> > +	cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
> > +	if (!cpumask)
> > +		return -ENOMEM;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		cpu_info = &per_cpu(cpu_data, cpu);
> > +		cpuid = is_smp() ? cpu_info->cpuid : read_cpuid_id();
> > +
> > +		/* read cpu id part number */
> > +		if ((cpuid & 0xFFF0) == cpu_id)
> > +			cpumask_set_cpu(cpu, cpumask);
> > +	}
> > +
> > +	drv->cpumask = cpumask;
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init bl_idle_init(void)
> > +{
> > +	int ret;
> 
> add blank line

Done.

Thanks !
Lorenzo

