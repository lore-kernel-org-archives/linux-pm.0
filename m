From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH] Exynos4: cpuidle: support dual CPUs with AFTR state
Date: Thu, 24 Apr 2014 19:42:47 +0200
Message-ID: <53594D17.6020107@samsung.com>
References: <1396604925-18383-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:58663 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830AbaDXRm4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Apr 2014 13:42:56 -0400
In-reply-to: <1396604925-18383-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, kgene.kim@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, ccross@google.com

Hi Daniel,

Please see my comments inline.

Btw. Please fix your e-mail composer to properly wrap your messages 
around 7xth column, as otherwise they're hard to read.

On 04.04.2014 11:48, Daniel Lezcano wrote:
> The following driver is for exynos4210. I did not yet finished the other boards, so
> I created a specific driver for 4210 which could be merged later.
>
> The driver is based on Colin Cross's driver found at:
>
> https://android.googlesource.com/kernel/exynos/+/e686b1ec67423c40b4fdf811f9a4dfa3b393a010%5E%5E!/
>
> This one was based on a 3.4 kernel and an old API.
>
> It has been refreshed, simplified and based on the recent code cleanup I sent
> today.
>
> The AFTR could be entered when all the cpus (except cpu0) are down. In order to
> reach this situation, the couple idle states are used.
>
> There is a sync barrier at the entry and the exit of the low power function. So
> all cpus will enter and exit the function at the same time.
>
> At this point, CPU0 knows the other cpu will power down itself. CPU0 waits for
> the CPU1 to be powered down and then initiate the AFTR power down sequence.
>
> No interrupts are handled by CPU1, this is why we switch to the timer broadcast
> even if the local timer is not impacted by the idle state.
>
> When CPU0 wakes up, it powers up CPU1 and waits for it to boot. Then they both
> exit the idle function.
>
> This driver allows the exynos4210 to have the same power consumption at idle
> time than the one when we have to unplug CPU1 in order to let CPU0 to reach
> the AFTR state.
>
> This patch is a RFC because, we have to find a way to remove the macros
> definitions and cpu powerdown function without pulling the arch dependent
> headers.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   arch/arm/mach-exynos/common.c        |   11 +-
>   drivers/cpuidle/Kconfig.arm          |    8 ++
>   drivers/cpuidle/Makefile             |    1 +
>   drivers/cpuidle/cpuidle-exynos4210.c |  226 ++++++++++++++++++++++++++++++++++
>   4 files changed, 245 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/cpuidle/cpuidle-exynos4210.c
>
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index d5fa21e..1765a98 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -299,9 +299,18 @@ static struct platform_device exynos_cpuidle = {
>   	.id                = -1,
>   };
>
> +static struct platform_device exynos4210_cpuidle = {
> +	.name              = "exynos4210-cpuidle",
> +	.dev.platform_data = exynos_sys_powerdown_aftr,
> +	.id                = -1,
> +};
> +
>   void __init exynos_cpuidle_init(void)
>   {
> -	platform_device_register(&exynos_cpuidle);
> +	if (soc_is_exynos4210())
> +		platform_device_register(&exynos4210_cpuidle);
> +	else
> +		platform_device_register(&exynos_cpuidle);
>   }
>
>   void __init exynos_cpufreq_init(void)
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 92f0c12..2772130 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -51,3 +51,11 @@ config ARM_EXYNOS_CPUIDLE
>   	depends on ARCH_EXYNOS
>   	help
>   	  Select this to enable cpuidle for Exynos processors
> +
> +config ARM_EXYNOS4210_CPUIDLE
> +	bool "Cpu Idle Driver for the Exynos 4210 processor"
> +	default y
> +	depends on ARCH_EXYNOS
> +	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
> +	help
> +	  Select this to enable cpuidle for the Exynos 4210 processors
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 0d1540a..e0ec9bc 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
>   obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
>   obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
>   obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
> +obj-$(CONFIG_ARM_EXYNOS4210_CPUIDLE)    += cpuidle-exynos4210.o
>
>   ###############################################################################
>   # POWERPC drivers
> diff --git a/drivers/cpuidle/cpuidle-exynos4210.c b/drivers/cpuidle/cpuidle-exynos4210.c
> new file mode 100644
> index 0000000..56f6d51
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-exynos4210.c
> @@ -0,0 +1,226 @@
> +/*
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Copyright (c) 2014 Linaro : Daniel Lezcano <daniel.lezcano@linaro.org>
> + *		http://www.linaro.org
> + *
> + * Based on the work of Colin Cross <ccross@android.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/proc-fns.h>
> +#include <asm/suspend.h>
> +#include <asm/cpuidle.h>
> +
> +#include <plat/pm.h>
> +#include <plat/cpu.h>
> +#include <plat/map-base.h>
> +#include <plat/map-s5p.h>

This won't work with multiplatform.

> +
> +static atomic_t exynos_idle_barrier;
> +static atomic_t cpu1_wakeup = ATOMIC_INIT(0);
> +
> +#define BOOT_VECTOR S5P_VA_SYSRAM
> +#define S5P_VA_PMU                  S3C_ADDR(0x02180000)
> +#define S5P_PMUREG(x)              (S5P_VA_PMU + (x))
> +#define S5P_ARM_CORE1_CONFIGURATION S5P_PMUREG(0x2080)
> +#define S5P_ARM_CORE1_STATUS        S5P_PMUREG(0x2084)
> +
> +static void (*exynos_aftr)(void);

Could we get rid of those global variables? I know that they won't break 
anything, but they don't look good. A driver data struct would look much 
better.

> +
> +static int cpu_suspend_finish(unsigned long flags)

Name of this function could be more meaningful. Something like 
exynos_cpu_enter_lpm() could be better. Same goes for the argument. 
Maybe it could be simply called enter_aftr?

> +{
> +	if (flags)
> +		exynos_aftr();
> +
> +	cpu_do_idle();
> +
> +	return -1;
> +}
> +
> +static int exynos_cpu0_enter_aftr(void)
> +{
> +	int ret = -1;

Hmm, wouldn't a real error code be better here?

> +
> +	/*
> +	 * If the other cpu is powered on, we have to power it off, because
> +	 * the AFTR state won't work otherwise
> +	 */
> +	if (cpu_online(1)) {
> +
> +		/*
> +		 * We reach a sync point with the coupled idle state, we know
> +		 * the other cpu will power down itself or will abort the
> +		 * sequence, let's wait for one of these to happen
> +		 */
> +		while (__raw_readl(S5P_ARM_CORE1_STATUS) & 3) {

nit: A macro could be used for 3.

> +
> +			/*
> +			 * The other cpu may skip idle and boot back
> +			 * up again
> +			 */
> +			if (atomic_read(&cpu1_wakeup))
> +				goto abort;
> +
> +			/*
> +			 * The other cpu may bounce through idle and
> +			 * boot back up again, getting stuck in the
> +			 * boot rom code
> +			 */
> +			if (__raw_readl(BOOT_VECTOR) == 0)

Is this a reliable behavior? I mean, is this part of some specification 
or rather a feature specific to a particular Android bootloader this was 
used with in original kernel tree?

> +				goto abort;
> +
> +			cpu_relax();
> +		}
> +	}
> +
> +	cpu_pm_enter();
> +
> +	ret = cpu_suspend(1, cpu_suspend_finish);
> +
> +	cpu_pm_exit();
> +
> +abort:
> +	if (cpu_online(1)) {
> +		/*
> +		 * Set the boot vector to something non-zero
> +		 */
> +		__raw_writel(virt_to_phys(s3c_cpu_resume),
> +			     BOOT_VECTOR);

Resume address is quite a specific "something non-zero". :)

> +		dsb();

Checkpatch would probably complain about missing comment on why dsb() is 
needed here (or I'm confusing this with other barriers).

> +
> +		/*
> +		 * Turn on cpu1 and wait for it to be on
> +		 */
> +		__raw_writel(0x3, S5P_ARM_CORE1_CONFIGURATION);
> +		while ((__raw_readl(S5P_ARM_CORE1_STATUS) & 3) != 3)
> +			cpu_relax();

nit: Here again 3 could be replaced with a macro.

> +
> +		/*
> +		 * Wait for cpu1 to get stuck in the boot rom
> +		 */
> +		while ((__raw_readl(BOOT_VECTOR) != 0) &&

Same comment about the assumption about BOOT_VECTOR changing to 0 as above.

> +		       !atomic_read(&cpu1_wakeup))
> +			cpu_relax();
> +
> +		if (!atomic_read(&cpu1_wakeup)) {
> +			/*
> +			 * Poke cpu1 out of the boot rom
> +			 */
> +			__raw_writel(virt_to_phys(s3c_cpu_resume),
> +				     BOOT_VECTOR);
> +			dsb_sev();

Hmm, platsmp code seems to be using an IPI to do this. Again, I wonder 
if this isn't a behavior implemented only in some specific Android 
bootloader.

> +		}
> +
> +		/*
> +		 * Wait for cpu1 to finish booting
> +		 */
> +		while (!atomic_read(&cpu1_wakeup))
> +			cpu_relax();
> +	}
> +
> +	return ret;
> +}
> +
> +static int exynos_powerdown_cpu1(void)
> +{
> +	int ret = -1;

Error code?

> +
> +	/*
> +	 * Idle sequence for cpu1
> +	 */
> +	if (cpu_pm_enter())
> +		goto cpu1_aborted;
> +
> +	/*
> +	 * Turn off cpu 1
> +	 */
> +	__raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
> +
> +	ret = cpu_suspend(0, cpu_suspend_finish);
> +
> +	cpu_pm_exit();
> +
> +cpu1_aborted:
> +	dsb();
> +	/*
> +	 * Notify cpu 0 that cpu 1 is awake
> +	 */
> +	atomic_set(&cpu1_wakeup, 1);
> +
> +	return ret;
> +}
> +
> +static int exynos_enter_aftr(struct cpuidle_device *dev,
> +			     struct cpuidle_driver *drv, int index)
> +{
> +	int ret;
> +
> +	__raw_writel(virt_to_phys(s3c_cpu_resume), BOOT_VECTOR);

Why this is being written here, instead of some of the low level 
functions above?

Otherwise, I quite like the whole idea. I need to play a bit with CPU 
hotplug and PMU to verify that things couldn't really be simplified a 
bit, but in general this looks reasonably.

Best regards,
Tomasz
